Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:49084 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746AbaJ3TQa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 15:16:30 -0400
Date: Thu, 30 Oct 2014 20:09:22 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
Message-ID: <20141030200922.15126d7a@dualc.maya.org>
In-Reply-To: <1414688299.27420.292.camel@ul30vt.home>
References: <20140923210318.498dacbd@dualc.maya.org>									 <20141011003219.560cca97@dualc.maya.org>									 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>									 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>									 <1413925580.4202.189.camel@ul30vt.home>								 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org>							 <1414010215.4202.275.camel@ul30vt.home> <54492606.5090308@maya.org>						 <1414082022.27420.39.camel@ul30vt.home> <54493BFA.8010609@maya.org>					 <1414093023.27420.40.camel@ul30vt.home> <544B3D14.70907@maya.org>				 <1414533068.27420.226.camel@ul30vt.home> <54511A16.30602@maya.org>			 <1414604677.27420.263.camel@ul30vt.home> <54512A91.2010606@maya.org>		 <1414606581.27420.266.camel@ul30vt.home>		 <20141029204344.61d5fc73@dualc.maya.org>	 <1414615824.27420.281.camel@ul30vt.home> <545268E8.3080107@maya.org> <1414688299.27420.292.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson wrote:
> On Thu, 2014-10-30 at 17:35 +0100, Andreas Hartmann wrote:
>> Alex Williamson wrote:
>>> On Wed, 2014-10-29 at 20:43 +0100, Andreas Hartmann wrote:
>> [...]
>>>> Therefore, I never should need pci_save_vc_state and
>>>> pci_restore_vc_state. Thus, it should be ok to add "return" at the
>>>> beginning of each of these function, true? Then it should work.
>>>>
>>>> I tested it. It worked.
>>>>
>>>> But if I'm removing only one of these returns either in
>>>> pci_save_vc_state or pci_restore_vc_state, the machine hangs again.
>>>>
>>>> Therefore, there must be something odd going on in the for loops. Isn't
>>>> it possible to add some useful debug code to these loops to see what's
>>>> really going on? But the output *must* go to the actual console,
>>>> otherwise I can't see it!
>>>>
>>>>
>>>> int pci_save_vc_state(struct pci_dev *dev)
>>>> {
>>>>         return 0; // must be set
>>>>         int i;
>>>>
>>>>         for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
>> 		   // continue; -> works
>>>>                 int pos, ret;
>>>>                 struct pci_cap_saved_state *save_state;
>> 		   // continue does not work!
>>
>> --> Most probably the
>>
>>             struct pci_cap_saved_state *save_state;
>>
>>     makes the system hang!
> 
> We've done nothing more than declare variables there, there's no actual
> code.  What happens if you increase the delay after bus reset, edit
> drivers/pci/pci.c, find the call to ssleep(1) and change the 1 to a 2,
> doubling the delay after reset.

Same behaviour.

>  It seems like VC save/restore is just a
> scapegoat for the platform already being broken by the bus reset.  Also,
> if you have any other card to test in this slot, it would be useful
> comparison data to know if we're dealing with an endpoint issue or a bus
> issue.

I organized an Intel pcie card:

03:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
        Subsystem: Intel Corporation Gigabit CT Desktop Adapter
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fdbc0000 (32-bit, non-prefetchable) [disabled] [size=128K]
        Region 1: Memory at fdb00000 (32-bit, non-prefetchable) [disabled] [size=512K]
        Region 2: I/O ports at cf00 [disabled] [size=32]
        Region 3: Memory at fdbfc000 (32-bit, non-prefetchable) [disabled] [size=16K]
        [virtual] Expansion ROM at fdb80000 [disabled] [size=256K]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <128ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [a0] MSI-X: Enable- Count=5 Masked-
                Vector table: BAR=3 offset=00000000
                PBA: BAR=3 offset=00002000
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [140 v1] Device Serial Number 00-1b-21-ff-ff-cf-8f-57
        Kernel driver in use: vfio-pci


and tested with the same kernel, which hangs w/ atheros card. It just
worked. Not just once, but each of the tests I did. I retested w/
atheros -> hang. Tested again with intel-card -> works. Back to
atheros -> hang.

Seems to be really a problem w/ the atheros card, which is triggered by
new vc save/restore.

Well, but what to do now? I know how to "fix" it. But this means I have
to compile my kernels again on my own if it is >= 3.14.


Thanks,
kind regards,
Andreas
