Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:57332 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab2L0JWb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Dec 2012 04:22:31 -0500
Received: by mail-bk0-f45.google.com with SMTP id jk13so4134590bkc.18
        for <linux-pci@vger.kernel.org>; Thu, 27 Dec 2012 01:22:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo53_NBCRdQdTSaiGda=sXMn-WEJ2EbO31UA5Q2n0qT56g@mail.gmail.com>
References: <CAHsH0E_WaqDhZ44a8S=E-h8vY=uJXrbBZogwNYB-4e4DoMjJ=Q@mail.gmail.com>
	<50DB1EA0.1060501@gmail.com>
	<CAErSpo53_NBCRdQdTSaiGda=sXMn-WEJ2EbO31UA5Q2n0qT56g@mail.gmail.com>
Date: Thu, 27 Dec 2012 17:22:29 +0800
Message-ID: <CAHsH0E_Oqhdja-pFL0O0sW9S-jqOk6JrVGgc6HBeEmSqB+m54g@mail.gmail.com>
Subject: Re: Question: why my 82599 nic doesn't show Virutal function or SR-IOV
From: lei yang <yanglei.fage@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 27, 2012 at 3:00 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I don't see an SR-IOV capability in your lspci output.  Are you sure
> your 82599 device supports SR-IOV?
>
> The SR-IOV capability is a PCIe extended capability, which means it
> would appear in the 0x100-0xfff extended config space.  If your
> platform doesn't support extended config space, you wouldn't see it.
> For example, you might not have MMCONFIG enabled.
>

Thanks it works for me, this need to rebuild kernel with
CONFIG_PCI_MMCONFIG=y, If I don't want
to rebuild kernel, can we use pass "pci=mmconfig" as kernel parameter
to instead

Lei


> On Wed, Dec 26, 2012 at 8:58 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> Hi Lei,
>>         Have you passed the module parameter to enable SR-IOV functions
>> when loading the ixgbe module?
>>
>> max_vfs:Maximum number of virtual functions to allocate per physical function (uint)
>>
>> On 12/26/2012 10:26 PM, lei yang wrote:
>>> I don't know if I'm wrong to ask this question here,if I'm wrong,
>>> please route me to other list.
>>>
>>>
>>> Lei
>>>
>>> root@intel_5500_server:~# lspci --version
>>> lspci version 3.1.9
>>> root@intel_5500_server:~# lspci -vv -s "03:00.0"
>>> 03:00.0 Ethernet controller: Intel Corporation 82599EB 10-Gigabit
>>> SFI/SFP+ Network Connection (rev 01)
>>>       Subsystem: Intel Corporation Ethernet Server Adapter X520-1
>>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>       Latency: 0, Cache Line Size: 64 bytes
>>>       Interrupt: pin A routed to IRQ 26
>>>       Region 0: Memory at b1900000 (64-bit, prefetchable) [size=512K]
>>>       Region 2: I/O ports at 2000 [size=32]
>>>       Region 4: Memory at b1980000 (64-bit, prefetchable) [size=16K]
>>>       Capabilities: [40] Power Management version 3
>>>               Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
>>>               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>>>       Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>>>               Address: 0000000000000000  Data: 0000
>>>               Masking: 00000000  Pending: 00000000
>>>       Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
>>>               Vector table: BAR=4 offset=00000000
>>>               PBA: BAR=4 offset=00002000
>>>       Capabilities: [a0] Express (v2) Endpoint, MSI 00
>>>               DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>>>                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>>>               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>>                       RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>>>                       MaxPayload 256 bytes, MaxReadReq 512 bytes
>>>               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>>>               LnkCap: Port #2, Speed 5GT/s, Width x8, ASPM L0s, Latency L0 <1us, L1 <8us
>>>                       ClockPM- Surprise- LLActRep- BwNot-
>>>               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>>                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>               LnkSta: Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive-
>>> BWMgmt- ABWMgmt-
>>>               DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
>>>               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>>>               LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
>>> Selectable De-emphasis: -6dB
>>>                        Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
>>> ComplianceSOS-
>>>                        Compliance De-emphasis: -6dB
>>>               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
>>> EqualizationPhase1-
>>>                        EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>>>       Kernel driver in use: ixgbe
>>>       Kernel modules: ixgbe
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
