classdef tDistributionsForAssetPricing < matlab.unittest.TestCase
    %TDISTRIBUTIONSFORASSETPRICING Check the main example script.

    methods ( Test )

        function tScriptIsWarningFree( testCase )
            
            try
                DistributionsForAssetPricing
                success = true;
            catch
                success = false;
            end % try/catch

            testCase.verifyTrue( success, ...
                "The main example script did not run " + ...
                "without errors." )

        end % tScriptIsWarningFree

    end % methods ( Test )

end % classdef