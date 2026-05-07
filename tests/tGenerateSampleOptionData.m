classdef tGenerateSampleOptionData < matlab.unittest.TestCase
    %TGENERATESAMPLEOPTIONDATA Tests for generateSampleOptionData.

    methods ( Test )

        function tOutputHasExpectedAttributes( testCase )

            % Class.
            optionData = generateSampleOptionData();
            testCase.verifyClass( optionData, "table", ...
                "The function did not return a table of option data." )

            % Size.
            testCase.verifySize( optionData, [48, 6], ...
                "The function did not return a table of the " + ...
                "expected size (48-by-6)." )

            % Variable names.
            varNames = optionData.Properties.VariableNames;
            testCase.verifyEqual( sort( string( varNames ) ), ...
                sort( ["K", "C", "P", "T", "rf", "S"] ), ...
                "The output table did not contain the " + ...
                "expected variable names." )

            % Variable types.
            types = varfun( @class, optionData, "OutputFormat", "cell" );
            testCase.verifyTrue( all( types == "double" ), ...
                "The variables in the output table were not all " + ...
                "of type double." )

            % Strike prices.
            testCase.verifyGreaterThan( optionData.K, 0, ...
                "All strike prices were not positive." )

            % Call prices.
            testCase.verifyGreaterThan( optionData.C, 0, ...
                "All call option prices were not positive." )

            % Put prices.
            testCase.verifyGreaterThan( optionData.P, 0, ...
                "All put option prices were not positive." )

            % Expiry times.
            testCase.verifyGreaterThan( optionData.T, 0, ...
                "All times to expiry were not positive." )

            % Risk-free interest rate.
            testCase.verifyGreaterThanOrEqual( optionData.rf, 0, ...
                "All risk-free interest rates were not nonnegative." )
            testCase.verifyLessThanOrEqual( optionData.rf, 1, ...
                "All risk-free interest rates were not at most 1." )

            % Underlying asset prices.
            testCase.verifyGreaterThan( optionData.S, 0, ...
                "All underlying asset prices were not positive." )

        end % tOutputHasExpectedAttributes

    end % methods ( Test )

end % classdef