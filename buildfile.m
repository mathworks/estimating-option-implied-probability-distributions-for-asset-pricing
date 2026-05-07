function plan = buildfile()
%buildfile Build file for the Estimating Option-Implied Probability 
% Distributions for Asset Pricing toolbox.

% Copyright 2015-2026 The MathWorks, Inc.

% Create a plan from the local task functions.
plan = buildplan( localfunctions() );

% Package the toolbox by default.
plan.DefaultTasks = "package";

% Write down the folders of interest.
prj = plan.RootFolder;
tbx = fullfile( prj, "tbx" );
code = fullfile( tbx, tbxname() );
tests = fullfile( prj, "tests" );
doc = fullfile( tbx, tbxname(), "DistributionsForAssetPricing.m" );

% Add the standard clean task.
plan("clean") = matlab.buildtool.tasks.CleanTask();

% Add a custom check task.
plan("check:code") = matlab.buildtool.tasks.CodeIssuesTask( prj, ...
    "IncludeSubfolders", true, ...
    "Configuration", "factory", ...    
    "ErrorThreshold", 0, ...
    "WarningThreshold", 0, ...
    "InfoThreshold", 0 );
plan("check:project") = matlab.buildtool.Task( ...
    "Description", "Run MATLAB project checks", ...
    "Actions", @checkProject, ...
    "Inputs", prj );

% Add a test task.
plan("test") = matlab.buildtool.tasks.TestTask( tests, ...
    "Strict", true, ...
    "Description", "Assert that all project tests pass.", ...
    "SourceFiles", code, ...
    "Dependencies", "check" );

% Add a task to export the Live Script to a Markdown file.
plan("doc").Inputs = doc;
plan("doc").Outputs = ...
    fullfile( tbx, tbxname(), "DistributionsForAssetPricing.md" );
plan("doc").Dependencies = "test";

% Add the toolbox packaging task.
plan("package").Inputs = tbx;
plan("package").Outputs = "releases/*.mltbx";
plan("package").Dependencies = "doc";

end % buildfile

function name = tbxname()
%tbxname Toolbox folder name

name = "optionImpliedPrices";

end % tbxname

function checkProject( ~ )
% Identify and report any project issues.

prj = currentProject();
prj.updateDependencies();
checkResults = table( prj.runChecks() );
passed = checkResults.Passed;
notPassed = ~passed;
if any( notPassed )
    disp( checkResults(notPassed, :) )
    assert( all( passed ), "buildfile:ProjectCheckFailed", ...
        "At least one project check has failed. " + ...
        "Resolve the failure(s) shown above to continue." )    
else
    fprintf( 1, "** All project checks passed.\n\n" )
end % if

end % checkProject

function docTask( context )
% Generate a Markdown version of the main example script.

% Main example script file.
doc = context.Task.Inputs.Path;

% Export to Markdown.
[folder, filename] = fileparts( doc );
exportName = fullfile( folder, filename + ".md" );
export( doc, exportName, ...
    "Format", "markdown", ...
    "IncludeOutputs", true, ...
    "Run", true );

end % docTask

function packageTask( ~ )
% Package toolbox

% Load and tweak metadata
s = jsondecode( fileread( tbxname() + ".json" ) );
v = ver( tbxname() ); % from Contents.m
assert( isscalar( v ), "build:package", ...
    "Found %d instances of %s on the MATLAB path.", numel( v ), tbxname() )
s.ToolboxName = v.Name;
s.ToolboxVersion = v.Version;

if getenv( "GITHUB_ACTIONS" ) == "true"
    % Check version and tag compatibility for release
    ref = string( getenv( "GITHUB_REF" ) );
    gitTagNumber = extractAfter( ref, "refs/tags/v" );
    assert( v.Version == gitTagNumber, ...
        "build:package:VersionTagMismatch", ...
        "%s Toolbox version %s (from Contents.m) does not " + ...
        "match the current Git tag number (%s).", ...
        v.Name, v.Version, gitTagNumber )
    % Define stable name for GitHub
    stableName = replace( v.Name, " ", "_" ) + ".mltbx";
    s.OutputFile = fullfile( "releases", stableName );
else
    % Include version in toolbox file name
    s.OutputFile = fullfile( ...
        "releases", v.Name + " " + v.Version + ".mltbx" );
end % if

% Create options object
f = s.ToolboxFolder; % mandatory
id = s.Identifier; % mandatory
s = rmfield( s, ["Identifier", "ToolboxFolder"] ); % mandatory
pv = [fieldnames( s ), struct2cell( s )]'; % optional
o = matlab.addons.toolbox.ToolboxOptions( f, id, pv{:} );
o.ToolboxVersion = string( o.ToolboxVersion ); % g3079185

% Package
matlab.addons.toolbox.packageToolbox( o )
fprintf( 1, "[+] %s\n", o.OutputFile );

% Add license
lic = fileread( "LICENSE" );
mlAddonSetLicense( char( o.OutputFile ), struct( "type", 'BSD', "text", lic ) );

end % packageTask