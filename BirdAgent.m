classdef birdAgent < Agent
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        position
        velocity
        avoid_factor
        avoid_range
        match_factor
        del_t = 0.1
        low_speed = 1
        high_speed = 10
        bounds
        turnfactor
    end

    methods
        function obj = birdAgent(unique_id, avoid_factor, avoid_range,...
                match_factor, bounds, turnfactor)
            % Initialize birdAgent
            obj = obj@Agent(unique_id)
            obj.avoid_factor = avoid_factor;
            obj.avoid_range = avoid_range;
            obj.match_factor = match_factor;
            obj.bounds = bounds;
            obj.turnfactor = turnfactor;
            obj.position = rand(1, 2);
            obj.velocity = rand(1, 2);
        end

        function obj = step(obj, bird_pos, bird_vel)
            % bird Time Step
            closeness = [0, 0];
            new_vel = [0, 0];
            dist_to_birds = vecnorm(bird_pos - bird_pos(obj.unique_id, :), 2, 2);

            % Separation
            for i = 1:length(bird_pos)
                if dist_to_birds(i) <= obj.avoid_range && i ~= obj.unique_id
                    closeness = closeness + obj.position - bird_pos(i, :);
                end
            end
            new_vel = new_vel + closeness*obj.avoid_factor;
            obj.velocity = obj.velocity + new_vel;

            % Alignment
            
            % Cohesion
            
           

            % Turn bird if out of bounds
            if obj.position(1) < obj.bounds(1)
                obj.velocity(1) = obj.velocity(1) + obj.turnfactor;
            elseif obj.position(1) > obj.bounds(2)
                obj.velocity(1) = obj.velocity(1) - obj.turnfactor;
            end

            if obj.position(2) < obj.bounds(1)
                obj.velocity(2) = obj.velocity(2) + obj.turnfactor;
            elseif obj.position(2) > obj.bounds(2)
                obj.velocity(2) = obj.velocity(2) - obj.turnfactor;
            end

            % Constrain bird speed
            vel_mag = vecnorm(obj.velocity);
            if vel_mag < obj.low_speed
                obj.velocity = obj.velocity / vel_mag * obj.low_speed;
            elseif vel_mag > obj.high_speed
                obj.velocity = obj.velocity / vel_mag * obj.high_speed;
            end
            % Update Position
            obj.position = obj.position + obj.del_t * obj.velocity;
        end
    end
end