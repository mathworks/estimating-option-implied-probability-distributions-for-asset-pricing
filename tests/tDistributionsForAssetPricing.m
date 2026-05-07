classdef tDistributionsForAssetPricing < matlab.unittest.TestCase
    %TDISTRIBUTIONSFORASSETPRICING Check the main example script.

    methods ( Test )

        function tScriptIsWarningFree( testCase )

            try
                DistributionsForAssetPricing
                testCase.verifyTrue( true )
            catch e
                testCase.verifyTrue( false, ...
                    "The main example script did not run " + ...
                    "without errors." )
            end % try/catch

        end % tScriptIsWarningFree

    end % methods ( Test )

end % classdef