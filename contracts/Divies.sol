pragma solidity ^0.4.24;
/** title -Divies- v0.7.1
 * ┌┬┐┌─┐┌─┐┌┬┐   ╦╦ ╦╔═╗╔╦╗  ┌─┐┬─┐┌─┐┌─┐┌─┐┌┐┌┌┬┐┌─┐
 *  │ ├┤ ├─┤│││   ║║ ║╚═╗ ║   ├─┘├┬┘├┤ └─┐├┤ │││ │ └─┐
 *  ┴ └─┘┴ ┴┴ ┴  ╚╝╚═╝╚═╝ ╩   ┴  ┴└─└─┘└─┘└─┘┘└┘ ┴ └─┘
 *                                  _____                      _____
 *                                 (, /     /)       /) /)    (, /      /)          /)
 *          ┌─┐                      /   _ (/_      // //       /  _   // _   __  _(/
 *          ├─┤                  ___/___(/_/(__(_/_(/_(/_   ___/__/_)_(/_(_(_/ (_(_(_
 *          ┴ ┴                /   /          .-/ _____   (__ /                               
 *                            (__ /          (_/ (, /                                      /)™ 
 *                                                 /  __  __ __ __  _   __ __  _  _/_ _  _(/
 * ┌─┐┬─┐┌─┐┌┬┐┬ ┬┌─┐┌┬┐                          /__/ (_(__(_)/ (_/_)_(_)/ (_(_(_(__(/_(_(_
 * ├─┘├┬┘│ │ │││ ││   │                      (__ /              .-/  © Jekyll Island Inc. 2018
 * ┴  ┴└─└─┘─┴┘└─┘└─┘ ┴                                        (_/
 *          ______      .-./`)  ,---.  ,---. .-./`)      .-''-.      .-'''-.   .---.  
 *=========|    _ `''.  \ .-.') |   /  |   | \ .-.')   .'_ _   \    / _     \  \   /=========*
 *         | _ | ) _  \ / `-' \ |  |   |  .' / `-' \  / ( ` )   '  (`' )/`--'  |   |  
 *         |( ''_'  ) |  `-'`"` |  | _ |  |   `-'`"` . (_ o _)  | (_ o _).      \ /   
 *         | . (_) `. |  .---.  |  _( )_  |   .---.  |  (_,_)___|  (_,_). '.     v    
 *         |(_    ._) '  |   |  \ (_ o._) /   |   |  '  \   .---. .---.  \  :   _ _   
 *         |  (_.\.' /   |   |   \ (_,_) /    |   |   \  `-'    / \    `-'  |  (_I_)  
 *=========|       .'    |   |    \     /     |   |    \       /   \       /  (_(=)_)========* 
 *         '-----'`      '---'     `---`      '---'     `'-..-'     `-...-'    (_I_)  
 * ╔═╗┌─┐┌┐┌┌┬┐┬─┐┌─┐┌─┐┌┬┐  ╔═╗┌─┐┌┬┐┌─┐ ┌──────────┐
 * ║  │ ││││ │ ├┬┘├─┤│   │   ║  │ │ ││├┤  │ Inventor │
 * ╚═╝└─┘┘└┘ ┴ ┴└─┴ ┴└─┘ ┴   ╚═╝└─┘─┴┘└─┘ └──────────┘
 *         ┌──────────────────────────────────────────────────────────────────────┐
 *         │ Divies!, is a contract that adds an external dividend system to P3D. │
 *         │ All eth sent to this contract, can be distributed to P3D holders.    │
 *         │ Uses msg.sender as masternode for initial buy order.                 │
 *         └──────────────────────────────────────────────────────────────────────┘
 *                                ┌────────────────────┐
 *                                │ Setup Instructions │
 *                                └────────────────────┘
 * (Step 1) import this contracts interface into your contract
 * 
 *    import "./DiviesInterface.sol";
 * 
 * (Step 2) set up the interface and point it to this contract
 * 
 *    DiviesInterface private Divies = DiviesInterface(0xc7029Ed9EBa97A096e72607f4340c34049C7AF48);
 *                                ┌────────────────────┐
 *                                │ Usage Instructions │
 *                                └────────────────────┘
 * call as follows anywhere in your code:
 *   
 *    Divies.deposit.value(amount)();
 *          ex:  Divies.deposit.value(232000000000000000000)();
 */

import "./interface/DiviesInterface.sol";
import "./library/SafeMath.sol";
import "./library/UintCompressor.sol";
import "./interface/HourglassInterface.sol";

contract Divies {
    using SafeMath for uint256;
    using UintCompressor for uint256;

    HourglassInterface constant P3Dcontract_ = HourglassInterface(0xB3775fB83F7D12A36E0475aBdD1FCA35c091efBe);
    
    uint256 public pusherTracker_ = 100;
    mapping (address => Pusher) public pushers_;
    struct Pusher
    {
        uint256 tracker;
        uint256 time;
    }
    uint256 public rateLimiter_;
    
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // MODIFIERS
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    modifier isHuman() {
        address _addr = msg.sender;
        uint256 _codeLength;
        
        assembly {_codeLength := extcodesize(_addr)}
        require(_codeLength == 0, "sorry humans only");
        _;
    }
    
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // BALANCE
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    function balances()
        public
        view
        returns(uint256)
    {
        return (address(this).balance);
    }
    
    
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // DEPOSIT
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    function deposit()
        external
        payable
    {
        
    }
    
    // used so the distribute function can call hourglass's withdraw
    function() external payable {}
    
    
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // EVENTS
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    event onDistribute(
        address pusher,
        uint256 startingBalance,
        uint256 masternodePayout,
        uint256 finalBalance,
        uint256 compressedData
    );
    /* compression key
    [0-14] - timestamp
    [15-29] - caller pusher tracker 
    [30-44] - global pusher tracker 
    [45-46] - percent
    [47] - greedy
    */  
    
    
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // DISTRIBUTE
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    function distribute(uint256 _percent)
        public
        isHuman()
    {
        // make sure _percent is within boundaries
        require(_percent > 0 && _percent < 100, "please pick a percent between 1 and 99");
        
        // data setup
        address _pusher = msg.sender;
        uint256 _bal = address(this).balance;
        uint256 _mnPayout;
        uint256 _compressedData;
        
        // limit pushers greed (use "if" instead of require for level 42 top kek)
        if (
            pushers_[_pusher].tracker <= pusherTracker_.sub(100) && // pusher is greedy: wait your turn
            pushers_[_pusher].time.add(1 hours) < now               // pusher is greedy: its not even been 1 hour
        )
        {
            // update pushers wait que 
            pushers_[_pusher].tracker = pusherTracker_;
            pusherTracker_++;
            
            // setup mn payout for event
            if (P3Dcontract_.balanceOf(_pusher) >= P3Dcontract_.stakingRequirement())
                _mnPayout = (_bal / 10) / 3;
            
            // setup _stop.  this will be used to tell the loop to stop
            uint256 _stop = (_bal.mul(100 - _percent)) / 100;
            
            // buy & sell    
            P3Dcontract_.buy.value(_bal)(_pusher);
            P3Dcontract_.sell(P3Dcontract_.balanceOf(address(this)));
            
            // setup tracker.  this will be used to tell the loop to stop
            uint256 _tracker = P3Dcontract_.dividendsOf(address(this));
    
            // reinvest/sell loop
            while (_tracker >= _stop) 
            {
                // lets burn some tokens to distribute dividends to p3d holders
                P3Dcontract_.reinvest();
                P3Dcontract_.sell(P3Dcontract_.balanceOf(address(this)));
                
                // update our tracker with estimates (yea. not perfect, but cheaper on gas)
                _tracker = (_tracker.mul(81)) / 100;
            }
            
            // withdraw
            P3Dcontract_.withdraw();
        } else {
            _compressedData = _compressedData.insert(1, 47, 47);
        }
        
        // update pushers timestamp  (do outside of "if" for super saiyan level top kek)
        pushers_[_pusher].time = now;
    
        // prep event compression data 
        _compressedData = _compressedData.insert(now, 0, 14);
        _compressedData = _compressedData.insert(pushers_[_pusher].tracker, 15, 29);
        _compressedData = _compressedData.insert(pusherTracker_, 30, 44);
        _compressedData = _compressedData.insert(_percent, 45, 46);
            
        // fire event
        emit onDistribute(_pusher, _bal, _mnPayout, address(this).balance, _compressedData);
    }
}
