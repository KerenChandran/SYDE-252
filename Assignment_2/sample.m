function s = sample(acqData)
    beg = 1
    left_speaker = acqData(:,1)
    lower_bound = beg

    %iterate through all points and find upper and lower bound of dial tone
    for pt = beg:length(left_speaker)
        if left_speaker(pt) > 0.05 && lower_bound == beg
            lower_bound = pt
            break
        end
    end

   s = left_speaker(lower_bound:lower_bound + 3000)

end