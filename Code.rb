STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

# nb_floors: number of floors
# width: width of the area
# nb_rounds: maximum number of rounds
# exit_floor: floor on which the exit is found
# exit_pos: position of the exit on its floor
# nb_total_clones: number of generated clones
# nb_additional_elevators: ignore (always zero)
# nb_elevators: number of elevators


i=0
j=0




nb_floors, width, nb_rounds, exit_floor, exit_pos, nb_total_clones, nb_additional_elevators, nb_elevators = gets.split(" ").collect {|x| x.to_i}
a = Array.new(nb_floors){Array.new(width,0)}
nb_elevators.times do
    # elevator_floor: floor on which this elevator is found
    # elevator_pos: position of the elevator on its floor
    elevator_floor, elevator_pos = gets.split(" ").collect {|x| x.to_i}

    a[(nb_floors-elevator_floor-1)][(elevator_pos)]=2
    
end

i = 0 
STDERR.puts "nb_floors = " , nb_floors
STDERR.puts "width = " , width

STDERR.puts "nb_rounds = " , nb_rounds


STDERR.puts "exit_floor = " , exit_floor
STDERR.puts "exit_pos = ", exit_pos
STDERR.puts "yyyyyyyyyyy = ", nb_floors-exit_floor-1
a[(nb_floors-exit_floor-1)][(exit_pos)]=3
STDERR.puts a.map { |x| x.join(' ') }
# game loop
omar = 0 #to delay when start in elevator
omar_floor = 0 
blocked = 0 

init1=0


loop do
    
    # clone_floor: floor of the leading clone
    # clone_pos: position of the leading clone on its floor
    # direction: direction of the leading clone: LEFT or RIGHT
    clone_floor, clone_pos = 0,0
    a[(nb_floors-clone_floor-1)][(clone_pos)]=0
    clone_floor, clone_pos, direction = gets.split(" ")
    clone_floor = clone_floor.to_i
    clone_pos = clone_pos.to_i
    
    
    
    #Choose Track




    STDERR.puts "START CHECKING VALUES "
    i=0
    j=nb_floors
    y = Array.new(width,-1) {Array.new(3,-1)} 
    
    f_j = clone_floor
    f_i = clone_pos
    counter = 0 
    if init1 == 0 
        init1=1
        STDERR.puts "Printing Y Matrix "
        STDERR.puts y.map { |x| x.join(' ') }
        while j > 0
            while i < width

                STDERR.print "*** Searching for Value = " , j , " , " , i , " = " , a[(j-1)][(i)] ,"\n"
                if a[(j-1)][(i)]>1
                    STDERR.print "*** Found one = " , a[(j-1)][(i)] , " at " , j , " , " , i , "\n"
                    y[counter][(0)] = j-1
                    y[counter][(1)] = i
                    y[counter][(2)] = (i-f_i).abs
                    counter +=1
                end
                i+=1
                
            end
            STDERR.puts y.map { |x| x.join(' ') }
            j-=1
            i=0
            counter = 0 
            STDERR.print "*** NEW Values = " , j , " , " , i , "\n"
            y = Array.new(width,-1) {Array.new(3,-1)} 


        end
    end







    STDERR.puts "Check STEP"
    if omar_floor != clone_floor 
        omar_floor = clone_floor
    end
    if omar != 0
        STDERR.puts "OMAR FUNCTION "
        puts "WAIT"
        omar -=1
        next
    end

    STDERR.puts clone_floor
    STDERR.puts clone_pos
    STDERR.puts "Check STEP"

    if clone_floor == -1 
        puts "WAIT"
        next
    end
    STDERR.puts "99999 STEP"
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."
    i = 0 
    target = -1
    dir = 0 
    dir1 = 0 
    STDERR.puts "FINAL STEP"
    STDERR.puts "*** Floor we are checking is " , (nb_floors-clone_floor-1)
    while i < width

        STDERR.puts "*** Value Before Comparasion" , a[(nb_floors-clone_floor-1)][(i)]
        if a[(nb_floors-clone_floor-1)][(i)]>1
            target = i 
            STDERR.puts "*** Target Worked " , a[(nb_floors-clone_floor-1)][(i)] , i
            break
        end
        i+=1
    end

    if target == -1 
        puts "ELEVATOR"
        STDERR.puts "*** Elevator Worked " , a[(nb_floors-clone_floor-1)][(i)] , i

        a[(nb_floors-clone_floor-1)][(clone_pos)]=2
        STDERR.puts "!@#$!%$!#@$@%$@#$%#$!@##$! ", a[(nb_floors-clone_floor-1)][(clone_pos)]

        #omar=1
        STDERR.puts a.map { |x| x.join(' ') }
        next
    end
    #a[(nb_floors-clone_floor-1)][(clone_pos)]=1
    STDERR.puts "Clone Floor " , clone_floor , "Clone pos " , clone_pos 
    if clone_pos - target > 0 
        dir = 1 #Should go Left
        STDERR.puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ SHOULD GO LEFT"
        STDERR.puts "Clone " , clone_pos , "Target " , target
    elsif clone_pos - target < 0 
        dir = -1 #Should go right 
        STDERR.puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ SHOULD GO RIGHT"
        STDERR.puts "Clone " , clone_pos , "Target " , target
    else 
        dir = 0 #wait
        if omar_floor == clone_floor 
             while i < width

            STDERR.puts "*** Value Before Comparasion" , a[(nb_floors-clone_floor-1)][(i)]
            if a[(nb_floors-clone_floor-1)][(i)]>1
                target = i 
                STDERR.puts "*** Target Worked " , a[(nb_floors-clone_floor-1)][(i)] , i
                break
            end
            i+=1
        end

            #omar = 1
            omar_floor = clone_floor +1
            STDERR.puts "##############################"
            STDERR.puts "Omar Floor = " , omar_floor , "CLone Floor = " , clone_floor

        end
        STDERR.puts "SHOULD WAIT"
        STDERR.puts "Clone " , clone_pos , "Target " , target
    end
    STDERR.puts "Direction " , direction
    if direction == "LEFT" 
        STDERR.puts "################################################# LEFT"

        dir1 = 1
    elsif direction == "RIGHT"
        STDERR.puts "################################################# RIGHT"
        dir1 = -1
    else
        dir1 = 0
        STDERR.puts "################################################# ELEVATOR"
    end
    STDERR.puts "FINAL STEP"
    
    if dir == 0 
        puts "WAIT"
        STDERR.puts "Omar Floor = " , omar_floor , "CLone Floor = " , clone_floor

        if omar_floor != clone_floor
        STDERR.puts "///////////////////"
        STDERR.puts "///////////////////"
        STDERR.puts "///////////////////"
        STDERR.puts "///////////////////"
            blocked = 0
        end
    elsif dir == dir1
        puts "WAIT"
        
    else
        STDERR.puts "!!!!!!!!!!!!!!!!!!!!!!!! BLOCK FUNCTION STARTED \n \n \n"
        if blocked == 0 
            STDERR.puts "CCC"
            STDERR.puts "Omar Floor = " , omar_floor , "CLone Floor = " , clone_floor
            if omar_floor == clone_floor 
                i=0
                check = 0
                while i < width

                    STDERR.puts "*** Value Before Comparasion" , a[(nb_floors-clone_floor-1)][(i)]
                    if a[(nb_floors-clone_floor-1)][(i)]== 5
                        check = 1
                        STDERR.puts "&&&&&&&&&& CHECK Done " , a[(nb_floors-clone_floor-1)][(i)] , i
                        
                    end
                    i+=1
                end


                if check == 0 

                    puts "BLOCK"
                    blocked = 1
                    #omar = 1
                    
                    a[(nb_floors-clone_floor-1)][(clone_pos)]=5
                    STDERR.puts "(((((((((((()))))))))))))))"
                    STDERR.puts "(((((((((((()))))))))))))))"
                    STDERR.puts "(((((((((((()))))))))))))))"
                    STDERR.puts "(((((((((((()))))))))))))))"
                    STDERR.puts "(((((((((((()))))))))))))))"
                    STDERR.puts "(((((((((((()))))))))))))))"
                else 
                    STDERR.puts "BBB"
                    puts "WAIT"
                end
                
            end
        else
            STDERR.puts "AAA"
            puts "WAIT"
            
        end        
    end 





    #puts "WAIT" # action: WAIT or BLOCK
end
