Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:54029 "EHLO
	resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753733AbbCCCIK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 21:08:10 -0500
Message-ID: <54F51787.2060405@comcast.net>
Date: Mon, 02 Mar 2015 18:08:07 -0800
From: Alnie <memobook80@comcast.net>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: PCI Issues with ExpressCard/54 Audio Device
References: <1703881568.13072732.1424911985807.JavaMail.zimbra@comcast.net> <1602089933.13084034.1424913145538.JavaMail.zimbra@comcast.net> <CAErSpo6E5EMDUA8tHRZYF6rgfRqtHEZtG4EyVcMSRL02T3Ttyg@mail.gmail.com> <54EED7D2.7000205@comcast.net> <20150226174635.GA25765@google.com> <54EF74CF.7050909@comcast.net> <20150226231843.GC25765@google.com> <54EFB400.4000904@comcast.net> <20150227003448.GH25765@google.com> <54F00F7D.6040604@comcast.net> <54F4F636.8090907@comcast.net> <CAErSpo61UL8Pj3dA9qGKmzW2fczrAMRij0T0BRa76nD8WxhVeA@mail.gmail.com>
In-Reply-To: <CAErSpo61UL8Pj3dA9qGKmzW2fczrAMRij0T0BRa76nD8WxhVeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/02/2015 05:51 PM, Bjorn Helgaas wrote:
> On Mon, Mar 2, 2015 at 5:45 PM, Alnie <memobook80@comcast.net> wrote:
>> On 02/26/2015 10:32 PM, Alnie wrote:
>>>
>>> On 02/26/2015 04:34 PM, Bjorn Helgaas wrote:
>>>
>>>>
>>>> So it looks like the Unsupported Request error is unrelated to the
>>>> problem
>>>> you're seeing.  Probably left over from something the BIOS did when it
>>>> enumerated devices.
>>>>
>>>> You could look at "lspci -vv" again after clearing the errors and loading
>>>> the driver.  But I think it will be the same as it was after you manually
>>>> cleared the errors.
>>>
>>>
>>> (after clearing errors) http://pastebin.com/UxdgDyp1
>>>
>>>>
>>>> Oh, one more idea: *before* clearing the errors, can you collect
>>>> "lspci -xxxxs05:00.0" output?  That will give us more AER log registers,
>>>> and it's possible there's a clue there.  It's conceivable that we have
>>>> an MPS issue that causes the Unsupported Request error.
>>>
>>>
>>> (before clearing errors w/ card in @ boot) http://pastebin.com/wTeNjHHT
>>> (before clearing errors w/ card out @ boot) http://pastebin.com/4Q82KNNc
>>>
>>>
>>>>
>>>> Just to be exhaustive, can you also stash the "lspci -vvv" output for the
>>>> entire system somewhere (again, before clearing the error).
>>>>
>>> http://pastebin.com/K4iPhGcq
>>>
>>> not sure if this is relevant but for debugging sake here is the output
>>> of the card when left out during boot (no UnsupReq error)...
>>>
>>> 05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI
>>> to PCIe Bridge (prog-if 00 [Normal decode])
>>>       Physical Slot: 3
>>>       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>       Bus: primary=05, secondary=06, subordinate=06, sec-latency=0
>>>       I/O behind bridge: 00002000-00002fff
>>>       Memory behind bridge: f8000000-f80fffff
>>>       Prefetchable memory behind bridge: 00000000f4000000-00000000f40fffff
>>>       Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>> <TAbort- <MAbort+ <SERR- <PERR-
>>>       BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>>           PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>>       Capabilities: [50] Power Management version 3
>>>           Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
>>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>>           Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>           Bridge: PM- B3+
>>>       Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
>>>           Address: 0000000000000000  Data: 0000
>>>       Capabilities: [80] Subsystem: Creative Labs Device 0040
>>>       Capabilities: [90] Express (v1) PCI-Express to PCI/PCI-X Bridge,
>>> MSI 00
>>>           DevCap:    MaxPayload 512 bytes, PhantFunc 0
>>>               ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
>>>           DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
>>> Unsupported-
>>>               RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
>>>               MaxPayload 128 bytes, MaxReadReq 512 bytes
>>>           DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr-
>>> TransPend-
>>>           LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
>>> Latency L0s <512ns, L1 <16us
>>>               ClockPM- Surprise- LLActRep- BwNot-
>>>           LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>>               ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>           LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
>>> DLActive- BWMgmt- ABWMgmt-
>>>       Capabilities: [100 v1] Advanced Error Reporting
>>>           UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>           UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>>           UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
>>> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>>           CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>>           CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>>           AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
>>> ChkEn-
>>>
>>>
>>>>>> The device is at [mem 0xf4300000-0xf4303fff], so anything in that
>>>>>> region
>>>>>> should respond.  Why don't you try this, which should dump the whole
>>>>>> region:
>>>>>>
>>>>>>     ./mem -N -m -s 0xf4300000 -l 0x4000
>>>>>>
>>>>>
>>>>> http://pastebin.com/eHEsZNmU
>>>>
>>>>
>>>> The data there looks fine, at least from a PCI perspective:
>>>>
>>>>     F4300000:00 33 00 01 3C 00 1D 00 01 00 00 00 00 00 00 00
>>>>     F4300010:00 00 00 00 00 00 00 00 3C 00 1D 00 00 00 00 00
>>>>     F4300020:00 00 00 C0 00 00 00 00 00 00 00 00 00 00 00 00
>>>>     F4300030:0F FA 24 A8 00 00 00 00 00 00 00 00 00 00 00 00
>>>>     ...
>>>>
>>>> That means the device itself seems happy and is responding to read
>>>> requests.
>>>>
>>>> The only thing left I can think of to do is to instrument the driver and
>>>> see where it gets data that it doesn't expect.  So I'm going to punt this
>>>> back to you, Takashi :)  Don't hesitate to send it back to me if you find
>>>> something that looks like a PCI problem, but I don't see one yet.
>>>>
>>>> Bjorn
>>
>> Today I booted up into Win 7 and the card wasn't recognized. This is the
>> first time I've noticed this. After re-inserting it, everything was fine,
>> but I thought to take note. Maybe some of the issues coming up are unique to
>> my hardware. Any new ideas? Is there hope for this? Should this conversation
>> be moved elsewhere?
>
> After you re-inserted the card, does it work after cold-booting Win 7?
>   If so, maybe it's an intermittent problem with the slot connector.
>
> If you have to remove and re-insert the card *every* time you boot Win
> 7, maybe there's a problem on the card, e.g., it doesn't come out of
> reset fast enough.
>
> I looked again at the Unsupported Request error that was logged, and I
> really don't think it's related.  The header from the offending
> transaction was logged, and it looked like a Config Read request.
> It's normal for these reads to fail during enumeration.  From the PCIe
> spec (r3.0, sec 2.3.2):
>
>      Some system configuration software depends on reading a data value
>      of all 1’s when a Configuration Read Request is terminated as an
>      Unsupported Request, particularly when probing to determine the
>      existence of a device in the system. A Root Complex intended for
>      use with software that depends on a read-data value of all 1’s must
>      synthesize this value when UR Completion Status is returned for
>      a Configuration Read Request.
>
> It is a bit strange that this error is only logged when the card is
> present.  I suspect the error is always logged during enumeration, but
> the BIOS may smart enough to clear it from the built-in bridges, but
> not smart enough to clear it on the bridge that's on the ExpressCard.
>
> In any event, I still don't see a PCI issue here.  I intended to open
> a bugzilla and attach the information you've collected in case
> somebody else can make sense out of it.  But I haven't had time yet.
>
> Bjorn
>

Yes, it seems like just a intermittent problem with the slot connector 
Most of the time it works fine. Thank you very much for being so 
informative and taking the time to look into this :)

-Alnie
