classdef Agent
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        unique_id
    end

    methods
        function obj = Agent(unique_id)
            % Initializes an agent
            obj.unique_id = unique_id;
        end
    end
end