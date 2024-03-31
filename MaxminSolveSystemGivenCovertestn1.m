function [x, y,w1,w2] = MaxminSolveSystemGivenCovertestn1(c, d_)
    [n, ~] = size(c);

    
    Aeq = [];
    beq = [];
    A = [];
    b = [];
    ind=1;
    
    
    for i = 1:n
        for j = 1:n

                A = [A; zeros(4, n+n+n*n+n*n)];
                A(end-3, i) = 1;
                A(end-3, 2*n + ind) =100000;

                A(end-2, n+j) = 1;
                A(end-2, n+n+n*n + ind) =100000;

                A(end-1,i)=-1;
                A(end,n+j)=-1;


                b = [b; c(i, j)+100000;c(i, j)+100000;-d_(i,j);-d_(i,j)];

                Aeq=[Aeq;zeros(1, n+n+n*n+n*n)];
                Aeq(end,2*n+ind)=1;
                Aeq(end,n+n+n*n+ind)=1;
                beq=[beq;1];
                ind=ind+1;
   
            
        end
    end






    f = zeros(1, n+n+n*n+n*n);

    intcon = 1:n+n+n*n+n*n;

    lb=zeros(n+n+n*n+n*n,1);
    lb(2*n+1:end)=0;

    ub=zeros(n+n+n*n+n*n,1)+inf;
    ub(2*n+1:end)=1;

    
    options = optimoptions('intlinprog', 'Display', 'off');
    z = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,options);

    %options = optimoptions('linprog','Algorithm','dual-simplex');
    %z=linprog(f,A,b,Aeq,beq,lb,ub,options);
    %z=linprog(f,A,b,Aeq,beq);

    % Check if a solution exists
    if isempty(z)
        x = [];
        y = [];
        w1=[];
        w2=[];
        return;
    end

    x = z(1:n);
    y = z(n+1:2*n);
    w1=z(2*n+1:n+n+n*n);
    w2=z(n+n+n*n+1:n+n+n*n+n*n);

end
