Return-Path: <m-karicheri2@ti.com>
Return-Path: <m-karicheri2@ti.com>
Subject: Re: PCIe issue with NIC card that has 64bit BARs
To: Alex Williamson <alex.williamson@redhat.com>
References: <5730E5DA.4020906@ti.com> <20160509203436.GC18166@localhost>
 <5730FADF.7000009@ti.com> <20160509152351.17389748@t450s.home>
 <57310353.5020802@ti.com> <20160509171246.3c33478b@t450s.home>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <5733A849.7020508@ti.com>
Date: Wed, 11 May 2016 17:46:49 -0400
MIME-Version: 1.0
In-Reply-To: <20160509171246.3c33478b@t450s.home>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Bjorn, Alex,

On 05/09/2016 07:12 PM, Alex Williamson wrote:
> On Mon, 9 May 2016 17:38:27 -0400
> Murali Karicheri <m-karicheri2@ti.com> wrote:
> 
>> On 05/09/2016 05:23 PM, Alex Williamson wrote:
>>> On Mon, 9 May 2016 17:02:23 -0400
>>> Murali Karicheri <m-karicheri2@ti.com> wrote:
>>>   
>>>> Hi Bjorn,
>>>>
>>>> Thanks for your quick response!
>>>> See below for some follow up question.
>>>>
>>>> On 05/09/2016 04:34 PM, Bjorn Helgaas wrote:  
>>>>> Hi Murali,
>>>>>
>>>>> On Mon, May 09, 2016 at 03:32:42PM -0400, Murali Karicheri wrote:    
>>>>>> Bjorn,
>>>>>>
>>>>>> I am running into an issue with using a rtk8168 GiB NIC card with Keystone PCIe.
>>>>>> It works for 32bit BARs such as the Marvel SATA controller on K2E. On another
>>>>>> recent SoC (K2G) that re-uses the same driver and hardware, I have issues
>>>>>> bringing up PCIe.
>>>>>>
>>>>>> The rtk8168 NIC gets detected, but all read values are zeros. Based on the boot
>>>>>> log, it appears to be getting assigned 64bit BARs. See the log on K2E with Marvell
>>>>>> controller and that on K2G with rtk8168. Is there way we can get it assigned
>>>>>> 32Bit BAR and get it functional? Keystone is a 32bit ARM A15 SoC.
>>>>>>
>>>>>> Here are the logs.
>>>>>>
>>>>>> K2E log with Marvel controller (Good working case).
>>>>>> ===================================================
>>>>>> [    0.236353] pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
>>>>>> [    0.236364] pci 0000:00:00.0: BAR 9: assigned [mem 0x60100000-0x601fffff pref]
>>>>>> [    0.236373] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
>>>>>> [    0.236385] pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
>>>>>> [    0.236394] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
>>>>>> [    0.236406] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x100f]
>>>>>> [    0.236418] pci 0000:01:00.0: BAR 0: assigned [io  0x1010-0x1017]
>>>>>> [    0.236429] pci 0000:01:00.0: BAR 2: assigned [io  0x1018-0x101f]
>>>>>> [    0.236441] pci 0000:01:00.0: BAR 1: assigned [io  0x1020-0x1023]
>>>>>> [    0.236452] pci 0000:01:00.0: BAR 3: assigned [io  0x1024-0x1027]
>>>>>> [    0.236464] pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>> [    0.236472] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
>>>>>> [    0.236481] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
>>>>>> [    0.236490] pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
>>>>>>
>>>>>> K2G log with Tealtek NIC card
>>>>>> =============================
>>>>>> [    2.311572] keystone-pcie 21801000.pcie: PCI host bridge to bus 0000:00
>>>>>> [    2.318188] pci_bus 0000:00: root bus resource [bus 00-ff]
>>>>>> [    2.323844] pci_bus 0000:00: root bus resource [io  0x0000-0x3fff]
>>>>>> [    2.330023] pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]    
>>>>>
>>>>> There's no "(bus address ...)" annotation here, which means these
>>>>> windows map CPU addresses to identical bus addresses.  The
>>>>> "[mem 0x50000000-0x5fffffff]" window is a 32-bit window.
>>>>>     
>>>>>> [    2.337567] PCI: bus0: Fast back to back transfers disabled
>>>>>> [    2.361159] PCI: bus1: Fast back to back transfers disabled
>>>>>> [    2.366889] pci 0000:00:00.0: BAR 8: assigned [mem 0x50000000-0x500fffff]
>>>>>> [    2.373841] pci 0000:00:00.0: BAR 9: assigned [mem 0x50100000-0x501fffff pref]
>>>>>> [    2.381061] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
>>>>>> [    2.387225] pci 0000:01:00.0: BAR 6: assigned [mem 0x50100000-0x5011ffff pref]
>>>>>> [    2.394505] pci 0000:01:00.0: BAR 4: assigned [mem 0x50120000-0x5012ffff 64bit pref]
>>>>>> [    2.402288] pci 0000:01:00.0: BAR 2: assigned [mem 0x50000000-0x50000fff 64bit]    
>>>>>
>>>>> I assume these BARs (2 and 4) are the ones in question.  They are
>>>>> 64-bit BARs, but the addresses currently assigned to them fit in 32
>>>>> bits, so the space is already all below 4GB.
>>>>>
>>>>> The BAR type (32-bit or 64-bit) is built into the device; Linux
>>>>> doesn't have any influence on that.  The type is encoded in the
>>>>> low-order four bits of the BAR, which are read-only.
>>>>>     
>>>>>> [    2.409610] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
>>>>>> [    2.415729] pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>> [    2.420693] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
>>>>>> [    2.426806] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x500fffff]
>>>>>> [    2.433610] pci 0000:00:00.0:   bridge window [mem 0x50100000-0x501fffff pref]
>>>>>> [    2.441365] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
>>>>>> [    2.448323] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>>>>>> [    2.455567] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>>>>>> [    2.461332] r8169 0000:01:00.0: enabling device (0140 -> 0143)
>>>>>> [    2.468789] r8169 0000:01:00.0 eth0: RTL8169 at 0xf0d6a000, 00:00:00:00:00:00, XID 00000000 IRQ 286    
>>>>>
>>>>> Looks like this is printed by rtl_init_one().  I see that we read
>>>>> zeroes from MAC0 and TxConfig, but I don't see any PCI problem here.    
>>>> So if device specific configuration registers for this device are mapped
>>>> to the window to have 64bit access, they are to be accessed with proper
>>>> address to get the lower 32 bits of the data, right? So is there a chance
>>>> it is making access to upper 4 bytes and hence reading all zeros?
>>>>    
>>>>> Could it be that some EEPROM on the card hasn't been programmed yet?
>>>>> Does the card work if you put it in a different machine?
>>>>>     
>>>> Probably. I will ask this to the owner of r8169 driver. He seems to think
>>>> the access is not right.  I need to find a PC that has PCIe slot to do this
>>>> test. Meanwhile do you know of any 1GiB NIC card that has 32bit BARs and
>>>> driver in Linux?   
>>>
>>> I happen to have an Intel 82571EB (PRO/1000 PT Dual Port Server
>>> Adapter) that only has 32bit BARs:
>>>
>>> 02:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit Ethernet Controller [8086:105e] (rev 06)
>>> 	Region 0: Memory at fe7e0000 (32-bit, non-prefetchable) [size=128K]
>>> 	Region 1: Memory at fe7c0000 (32-bit, non-prefetchable) [size=128K]
>>> 	Region 2: I/O ports at e800 [size=32]
>>> 02:00.1 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit Ethernet Controller [8086:105e] (rev 06)
>>> 	Region 0: Memory at fe7a0000 (32-bit, non-prefetchable) [size=128K]
>>> 	Region 1: Memory at fe780000 (32-bit, non-prefetchable) [size=128K]
>>> 	Region 2: I/O ports at e400 [size=32]  
>> Alex,
>>
>> Thanks for the response. I see following mini pci card which match with your
>> description.
>>
>> http://www.amazon.com/Intel-1000-Dual-Server-Adapter/dp/B000BMZHX2/ref=sr_1_1?ie=UTF8&qid=1462829688&sr=8-1&keywords=intel+expi9402pt
>>
>> Is this same thing? I assume e1000e/82571.c is the driver for this.
>> Could you please confirm so that I can procure the same?
> 
> I would venture to say yes, but I offer no guarantees ;)
> 
> Ark seems to indicate all 1000 PT dual port cards use that chip:
> http://ark.intel.com/products/50494/Intel-PRO1000-PT-Dual-Port-Server-Adapter
> 
I got hold of a Intel pro server adapter card and tried it with Keystone PCIe RC
and I am getting the following error:- This one has a 32bit bar, but similar
issue as with r8169 and tg3. The PCI access over the window seems to return zeros.
Per suggestion, tried dumping the memory window and got all zeros. See below
for additional debug info.

root@k2g-evm:/# insmod e1000e.ko debug=16
[  604.596552] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[  604.602505] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[  604.608774] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[  606.462763] e1000e 0000:01:00.0: The NVM Checksum Is Not Valid
[  606.477439] e1000e: probe of 0000:01:00.0 failed with error -5

root@k2g-evm:/# lspci -vvv
00:00.0 PCI bridge: Texas Instruments Device b00b (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 287
        Region 0: Memory at <ignored> (32-bit, non-prefetchable)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 50000000-500fffff
        Prefetchable memory behind bridge: 50100000-501fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 0000000021800054  Data: 0000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 256 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s, Exit Latency L0s <2us, L1 <64us
                        ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: pcieport
lspci: Unable to load libkmod resources: error -12

01:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
        Subsystem: Intel Corporation PRO/1000 PT Server Adapter
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 319
        Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at 50020000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 1000 [disabled] [size=32]
        [virtual] Expansion ROM at 50100000 [disabled] [size=128K]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000021800054  Data: 0001
        Capabilities: [e0] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [140 v1] Device Serial Number 00-15-17-ff-ff-90-0f-b2

Tried dumping the window 50000000 and 50020000 and See all zeros. Similar observation with
Broadcom tg3 and 

root@k2g-evm:/# ./rdwrmem -m -s 0x50000000 -b 4 -l 0x100
50000000:00000000 00000000 00000000 00000000
50000010:00000000 00000000 00000000 00000000
50000020:00000000 00000000 00000000 00000000
50000030:00000000 00000000 00000000 00000000
50000040:00000000 00000000 00000000 00000000
50000050:00000000 00000000 00000000 00000000
50000060:00000000 00000000 00000000 00000000
50000070:00000000 00000000 00000000 00000000
50000080:00000000 00000000 00000000 00000000
50000090:00000000 00000000 00000000 00000000
500000A0:00000000 00000000 00000000 00000000
500000B0:00000000 00000000 00000000 00000000
500000C0:00000000 00000000 00000000 00000000
500000D0:00000000 00000000 00000000 00000000
500000E0:00000000 00000000 00000000 00000000
500000F0:00000000 00000000 00000000 00000000

root@k2g-evm:/# ./rdwrmem -m -s 0x50020000 -b 4 -l 0x100                                                                                    
50020000:00000000 00000000 00000000 00000000
50020010:00000000 00000000 00000000 00000000
50020020:00000000 00000000 00000000 00000000
50020030:00000000 00000000 00000000 00000000
50020040:00000000 00000000 00000000 00000000
50020050:00000000 00000000 00000000 00000000
50020060:00000000 00000000 00000000 00000000
50020070:00000000 00000000 00000000 00000000
50020080:00000000 00000000 00000000 00000000
50020090:00000000 00000000 00000000 00000000
500200A0:00000000 00000000 00000000 00000000
500200B0:00000000 00000000 00000000 00000000
500200C0:00000000 00000000 00000000 00000000
500200D0:00000000 00000000 00000000 00000000
500200E0:00000000 00000000 00000000 00000000
500200F0:00000000 00000000 00000000 00000000

Corresponding PCI boot log

[    2.310465] PCI host bridge /soc/pcie@21800000 ranges:
[    2.316146]   No bus range found for /soc/pcie@21800000, using [bus 00-ff]
[    2.323302]    IO 0x23250000..0x23253fff -> 0x00000000
[    2.328455]   MEM 0x50000000..0x5fffffff -> 0x50000000
[    2.335406] keystone-pcie 21801000.pcie: PCI host bridge to bus 0000:00
[    2.342206] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.347691] pci_bus 0000:00: root bus resource [io  0x0000-0x3fff]
[    2.353937] pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
[    2.361483] PCI: bus0: Fast back to back transfers disabled
[    2.368357] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    2.378560] PCI: bus1: Fast back to back transfers disabled
[    2.384366] pci 0000:00:00.0: BAR 8: assigned [mem 0x50000000-0x500fffff]
[    2.391314] pci 0000:00:00.0: BAR 9: assigned [mem 0x50100000-0x501fffff pref]
[    2.398534] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    2.404699] pci 0000:01:00.0: BAR 0: assigned [mem 0x50000000-0x5001ffff]
[    2.411555] pci 0000:01:00.0: BAR 1: assigned [mem 0x50020000-0x5003ffff]
[    2.418348] pci 0000:01:00.0: BAR 6: assigned [mem 0x50100000-0x5011ffff pref]
[    2.425591] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    2.431712] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.436675] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    2.442788] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x500fffff]
[    2.449572] pci 0000:00:00.0:   bridge window [mem 0x50100000-0x501fffff pref]
[    2.457313] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
[    2.464412] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt


Any idea where to start to debug this issue? Suggestion?

Thanks
-- 
Murali Karicheri
Linux Kernel, Keystone
