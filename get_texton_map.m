function texelMap = get_texton_map(im)
    global textonData;
    texMode = '1_1_0_0_1_tex_texton128_malik_0x5_3_universal_intensity_8.mat';
    
    [scale, elongate] = getFilterParameters(texMode);

    % Filterbank parameters
    fbParams.no = 12;
    fbParams.ns = 1;
    fbParams.sc = sqrt(2);


    fb = fbCreate(fbParams.no, scale, fbParams.ns, fbParams.sc, elongate);

    % Filter image
    fim = fbRun(fb, im);

    %% Universal
    if ~isempty(strfind(texMode, 'universal'))

        % Assign universal textons
                                    % Load universal texton dictionary
        textons = textonData.tex;
        nTexels = size(textons, 2);
        texelMap = assignTextons(fim, textons);                                    % Assign textons
    end
    texelMap  = texelMap (1:200,1:200);
end