function r = getReward(startState, action, endState, pd)
        
        [u0, s0, m0] = indexToTuple(startState, pd);
        [u1, s1, m1] = indexToTuple(endState, pd);
        
        Ux0 = pd.UxTable(pd.s == s0, pd.actions == m0);
        Ux1 = pd.UxTable(pd.s == s1, pd.actions == m1);
        
        ax = (Ux1 - Ux0)/(s1 - s0);
        
        if ax == 0
            r = (s1 - s0)/Ux1;
        else
            r = log(ax*(s1 - s0) + Ux0)/ax - log(Ux0)/ax;
        end
        
        if m0 ~= m1  %penalize switching slightly
            r = r + .05;
        end
        
        if u1 == 1
            r = r*1.03; %penalty for sliding
        end
        
        if isnan(r)
            error('whoops')
        end
        
      
        
        %if u0 ~= 1 && u1 ~= 1  %not in sliding region, small penalty for switching
        %    if m0 ~= m1  %penalize switching slightly
        %        r = r + .05;
        %    end
        %else  %in sliding region, big penalty for switching
        %    if m0 ~= m1
        %        r = r + 1;
        %    end
        %end
        
        
        %maximize reward, so make everything negative. 
        r = -r;

end