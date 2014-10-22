Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:43650 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbaJVPkA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Oct 2014 11:40:00 -0400
Date: Wed, 22 Oct 2014 17:34:05 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
Message-ID: <20141022173405.2e5474a1@dualc.maya.org>
In-Reply-To: <1413925580.4202.189.camel@ul30vt.home>
References: <20140923210318.498dacbd@dualc.maya.org>		 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>		 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>		 <5437F1F5.3010706@maya.org>		 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>		 <543804BC.3080307@maya.org>		 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>		 <20141011003219.560cca97@dualc.maya.org>		 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>	 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org> <1413925580.4202.189.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson schrieb:
> Hi Andreas,
> 
> On Fri, 2014-10-17 at 03:04 +0200, Andreas Hartmann wrote:
>> Hello Alex,
>>
>> Alex Williamson wrote:
>>> Hi Andreas,
>> [...]
>>> Sorry for the breakage.  Is it possible to run lspci on the device in a
>>> loop from the host and capture whether we're failing to restore some of
>>> the VC bits to their previous state? 
>>
>>> Does the problem also occur if you
>>> unbind from host driver,
>>
>> The machine is booted w/ blacklisted ath9k. Then, the device is bound to
>> vfio:
>>
>> echo "168c 0030" > /sys/bus/pci/drivers/vfio-pci/new_id
>> echo 0000:03:00.0 > /sys/bus/pci/devices/0000:03:00.0/driver/unbind
>> echo 0000:03:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
>>
>> afterwards the VM is started -> hang.
>>
>> W/o starting th VM, I can bind it to vfio and unbind it from vfio w/o
>> any problem.
>>
>>> echo 1 > reset in pci-sysfs,
>>
>> echo 1 > /sys/bus/pci/devices/0000:03:00.0 works w/o any problem while
>> bound to vfio. Even after unbinding from vfio and rebinding to vfio
>> again ... .
>>
>>> and re-bind to the
>>
>> Do you mean loading ath9k in host system after unbinding from vfio? If
>> yes: Works w/o any problem. It's even possible to reset it or do a
>> ifconfig wlan0 up, ifconfig wlan0 down, rmmod ath9k, bind it to vfio
>> again and reset it, ....
>>
>> Looks like the hang only is triggered by qemu-system_x86_64 on startup
>> the VM.
>>
>>> host?  I'll also try to reproduce on my 990fx system, but I won't be
>>> able to do that until next week due to travel.  Thanks,
> 
> Could you send me the lspci -vvvxxxx for the device and parent root
> port?  Thanks,


Done with kernel 3.12.28 in host while the device was used in VM:

# lspci -vt
-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (external gfx0 port B)
           +-00.2  Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory Management Unit (IOMMU)
           +-02.0-[01]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Turks PRO [Radeon HD 6570/7570]
           |            \-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Turks/Whistler HDMI Audio [Radeon HD 6000 Series]
           +-04.0-[02]----00.0  Etron Technology, Inc. EJ168 USB 3.0 Host Controller
           +-05.0-[03]----00.0  Qualcomm Atheros AR93xx Wireless Network Adapter
           +-09.0-[04]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
           +-0a.0-[05]----00.0  Etron Technology, Inc. EJ168 USB 3.0 Host Controller
           +-11.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode]
           +-12.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
           +-12.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
           +-13.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
           +-13.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
           +-14.0  Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller
           +-14.2  Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA)
           +-14.3  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller
           +-14.4-[06]--+-06.0  Intel Corporation 82557/8/9/0/1 Ethernet Pro 100
           |            \-0e.0  VIA Technologies, Inc. VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller
           +-14.5  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
           +-15.0-[07]--
           +-16.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
           +-16.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
           +-18.0  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
           +-18.1  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
           +-18.2  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
           +-18.3  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
           +-18.4  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
           \-18.5  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5


# lspci -s 03:00 -vvvxxxx
03:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network Adapter (rev 01)
        Subsystem: Qualcomm Atheros Device 3112
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fdbc0000 (64-bit, non-prefetchable) [size=128K]
        [virtual] Expansion ROM at fda00000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <2us, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [300 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Kernel driver in use: vfio-pci
        Kernel modules: ath9k
00: 8c 16 30 00 07 01 10 00 01 00 80 02 10 00 00 00
10: 04 00 bc fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8c 16 12 31
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
40: 01 50 c3 5b 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 84 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 02 00 00 87 2c 01 10 20 09 00 11 5c 03 00
80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
100: 01 00 01 14 00 00 00 00 00 00 00 00 30 20 06 00
110: 00 30 00 00 00 20 00 00 00 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
140: 02 00 01 30 00 00 00 00 00 00 00 00 00 00 00 00
150: 00 00 00 00 ff 00 00 80 00 00 00 00 00 00 00 00
160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
300: 03 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
700: 76 00 63 01 ff ff ff ff 04 00 00 07 01 3f 3f 17
710: 20 01 01 00 00 00 00 00 aa 83 00 00 80 02 00 00
720: 00 00 00 00 03 00 00 00 51 5c ae 03 10 01 00 08
730: 40 00 01 00 ff 0f 01 00 ff ff 0f 00 00 00 00 00
740: 0f 00 00 00 00 00 00 00 08 40 20 00 03 40 20 00
750: 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7a0: 00 00 00 00 00 00 00 00 2c 00 08 00 00 00 00 00
7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
800: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
810: ff ff ff ff 00 00 00 00 00 03 00 00 00 00 00 00
820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


I'm not sure what you mean with "parent root port". Could it be this:

# lspci -s 00:00 -vvvxxxx
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (external gfx0 port B) (rev 02)
        Subsystem: Gigabyte Technology Co., Ltd Device 5000
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Region 3: Memory at <ignored> (64-bit, non-prefetchable) [size=512M]
        Capabilities: [f0] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [c4] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=0 UnitCnt=20 MastHost- DefDir- DUL-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 3.00
                Link Frequency 0: [e]
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD-
                Link Frequency 1: 200MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [40] HyperTransport: Retry Mode
        Capabilities: [54] HyperTransport: UnitID Clumping
        Capabilities: [9c] HyperTransport: #1a
        Capabilities: [70] MSI: Enable- Count=1/4 Maskable- 64bit-
                Address: 00000000  Data: 0000
00: 02 10 14 5a 02 00 10 20 02 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 e0
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 00 50
30: 00 00 00 00 f0 00 00 00 00 00 00 00 ff 00 00 00
40: 08 54 00 c0 c1 00 00 00 00 00 00 00 42 20 05 00
50: 58 14 00 50 08 9c 00 90 08 10 00 00 08 10 00 00
60: 00 00 00 00 86 01 00 00 00 00 00 40 64 56 00 78
70: 05 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 10 00 00 03 20 02 30 00 31 20 00 00
90: 00 00 00 d0 00 00 00 00 10 09 00 00 08 70 3c d0
a0: 66 00 00 00 00 00 00 05 00 00 00 00 79 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 80 08 40 80 02 20 00 11 11 d0 00 00 00
d0: 60 0e f5 7f 13 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 05 00 ff ff ff ff 00 00 00 00 00 00 00 00
f0: 08 c4 03 a8 00 80 80 00 01 00 00 00 08 00 c0 fe

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory Management Unit (IOMMU)
        Subsystem: Gigabyte Technology Co., Ltd Device 5000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 40
        Capabilities: [40] Secure device <?>
        Capabilities: [54] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000feeff00c  Data: 4171
        Capabilities: [64] HyperTransport: MSI Mapping Enable+ Fixed+
00: 02 10 23 5a 00 04 10 00 00 00 06 08 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 00 50
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 0f 54 0b 01 01 00 c3 fe 00 00 00 00 00 00 00 00
50: 00 34 20 00 05 64 81 00 0c f0 ef fe 00 00 00 00
60: 71 41 00 00 08 00 03 a8 58 14 00 50 01 01 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 82 00 00 00 00 00 00 00 11 00 05 00 00 00 00 00


Hope this helps!

Thanks,
Andreas
