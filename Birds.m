
% Initialize Model
bird_model = Model();

% Initialize Scheduler
bird_model.scheduler = BaseScheduler();

% Initialize Turnable Parameters
avoid_factor = 2;
avoid_range = 0.5;
match_factor = 0.1;
bounds = [-9, 9];
turnfactor = 2;


% Add Agents
num_birds = 40;
for i = 1:num_birds
    bird_model = bird_model.add(birdAgent(i, avoid_factor, avoid_range,...
        match_factor, bounds, turnfactor));
end


% Plotting
bird_model = bird_model.get_agent_data();
figure()
set(gcf, "position", [100, 100, 1000, 800]);
p = plot(bird_model.agent_position(:, 1), bird_model.agent_position(:, 2), "b*");
xlim([-10, 10])
ylim([-10, 10])
p.XDataSource = "bird_x";
p.YDataSource = "bird_y";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
I = imread('environment.jpg');
h = image(xlim,-ylim,I);
uistack(h,'bottom')

% Start Agent Steps
while true
    bird_model = bird_model.step(bird_model.agent_position, bird_model.agent_velocity);
    bird_model = bird_model.get_agent_data();
    bird_pos = bird_model.agent_position;
    bird_x = bird_pos(:, 1);
    bird_y = bird_pos(:, 2);
    refreshdata
    drawnow
    pause(1/24)
end
