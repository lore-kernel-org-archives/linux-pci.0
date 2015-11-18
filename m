Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36625 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187AbbKRP7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2015 10:59:40 -0500
Received: by obdgf3 with SMTP id gf3so36963254obd.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2015 07:59:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151118105907.GC4437@intel.com>
References: <CALCETrXM5w0iCKDNBZYEpk17ViCMdP_B-cO4X01EQR9H8hesTw@mail.gmail.com>
 <20151118105907.GC4437@intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Nov 2015 07:59:20 -0800
Message-ID: <CALCETrUPfgPrKY4ZQcvLr8=i_dYb=FTndfVXzbCjxEMfbi0YiQ@mail.gmail.com>
Subject: Re: [Intel-gfx] i915 Skylake: "Invalid ROM contents"
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	DRI <dri-devel@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[adding linux-pci]

On Wed, Nov 18, 2015 at 2:59 AM, Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
> On Tue, Nov 17, 2015 at 11:43:25AM -0800, Andy Lutomirski wrote:
>> Typing:
>>
>> # cat /sys/devices/pci0000:00/0000:00:02.0/rom
>>
>> Provokes:
>>
>> i915 0000:00:02.0: Invalid ROM contents
>
> Hmm. So there's no PCI option ROM there. I wonder what is there. I
> get the same on my Braswell BTW. I tried to look through the UEFI
> spec a bit, and it seems to say that even for non-legacy option ROMs
> the 0x55aa signature should be there.
>
> But this being the GPU means we may be using the shadow ROM stuff,
> which IIRC assumes that the shadow is at 0xc000. I'm not sure that
> holds anymore with UEFI, and maybe we should be using some UEFI
> trick instead to find out where it actually lives?
>
> BTW what does 'lspci -vv -s 00:02.0' say on your machine?
>

00:02.0 VGA compatible controller: Intel Corporation Sky Lake
Integrated Graphics (rev 07) (prog-if 00 [VGA controller])
    DeviceName:  Onboard IGD
    Subsystem: Dell Device 0704
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 128
    Region 0: Memory at db000000 (64-bit, non-prefetchable) [size=16M]
    Region 2: Memory at 90000000 (64-bit, prefetchable) [size=256M]
    Region 4: I/O ports at f000 [size=64]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [40] Vendor Specific Information: Len=0c <?>
    Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
    Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee00018  Data: 0000
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] #1b
    Capabilities: [200 v1] Address Translation Service (ATS)
        ATSCap:    Invalidate Queue Depth: 00
        ATSCtl:    Enable-, Smallest Translation Unit: 00
    Capabilities: [300 v1] #13
    Kernel driver in use: i915
    Kernel modules: i915

--Andy

>>
>> This is on a Dell XPS 13 9350 (Skylake).  This is 4.3.0 plus some
>> wireless-next bits.
>>
>> --Andy
>>
>> --
>> Andy Lutomirski
>> AMA Capital Management, LLC
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/intel-gfx
>
> --
> Ville Syrjälä
> Intel OTC



-- 
Andy Lutomirski
AMA Capital Management, LLC
