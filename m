Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36049 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbcAJTNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jan 2016 14:13:04 -0500
Received: by mail-ob0-f176.google.com with SMTP id ba1so392455946obb.3
        for <linux-pci@vger.kernel.org>; Sun, 10 Jan 2016 11:13:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALCETrV+RwNPzxyL8UVNsrAGu-6cCzD_Cc9PFJT2NCTJPLZZiw@mail.gmail.com>
References: <CALCETrXM5w0iCKDNBZYEpk17ViCMdP_B-cO4X01EQR9H8hesTw@mail.gmail.com>
 <20151118105907.GC4437@intel.com> <CALCETrUPfgPrKY4ZQcvLr8=i_dYb=FTndfVXzbCjxEMfbi0YiQ@mail.gmail.com>
 <CAPj87rNj4mGtRe33k64zYMAdSKc=OwrseY0oxMGtPtzn=XGnXA@mail.gmail.com> <CALCETrV+RwNPzxyL8UVNsrAGu-6cCzD_Cc9PFJT2NCTJPLZZiw@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 10 Jan 2016 11:12:42 -0800
Message-ID: <CALCETrXD6WUPJ-d8vUD0UnjGDDK6MnQfNtd7tyZNbNZkFBxYNw@mail.gmail.com>
Subject: Re: [Intel-gfx] i915 Skylake: "Invalid ROM contents"
To: Daniel Stone <daniel@fooishbar.org>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	DRI <dri-devel@lists.freedesktop.org>,
	=?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 10, 2016 at 10:41 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Nov 18, 2015 at 8:12 AM, Daniel Stone <daniel@fooishbar.org> wrote:
>> Hi,
>>
>> On 18 November 2015 at 15:59, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Wed, Nov 18, 2015 at 2:59 AM, Ville Syrjälä
>>> <ville.syrjala@linux.intel.com> wrote:
>>>> On Tue, Nov 17, 2015 at 11:43:25AM -0800, Andy Lutomirski wrote:
>>>>> Typing:
>>>>>
>>>>> # cat /sys/devices/pci0000:00/0000:00:02.0/rom
>>>>>
>>>>> Provokes:
>>>>>
>>>>> i915 0000:00:02.0: Invalid ROM contents
>>>>
>>>> Hmm. So there's no PCI option ROM there. I wonder what is there. I
>>>> get the same on my Braswell BTW. I tried to look through the UEFI
>>>> spec a bit, and it seems to say that even for non-legacy option ROMs
>>>> the 0x55aa signature should be there.
>>>>
>>>> But this being the GPU means we may be using the shadow ROM stuff,
>>>> which IIRC assumes that the shadow is at 0xc000. I'm not sure that
>>>> holds anymore with UEFI, and maybe we should be using some UEFI
>>>> trick instead to find out where it actually lives?
>>>>
>>>> BTW what does 'lspci -vv -s 00:02.0' say on your machine?
>>>>
>>>
>>> 00:02.0 VGA compatible controller: Intel Corporation Sky Lake
>>> Integrated Graphics (rev 07) (prog-if 00 [VGA controller])
>>>     DeviceName:  Onboard IGD
>>>     Subsystem: Dell Device 0704
>>>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>     Latency: 0
>>>     Interrupt: pin A routed to IRQ 128
>>>     Region 0: Memory at db000000 (64-bit, non-prefetchable) [size=16M]
>>>     Region 2: Memory at 90000000 (64-bit, prefetchable) [size=256M]
>>>     Region 4: I/O ports at f000 [size=64]
>>>     Expansion ROM at <unassigned> [disabled]
>>
>> UEFI has an option to enable option ROMs, which is disabled by
>> default; I wonder if having it disabled prevents all access to the
>> ROM.
>>
>> Mind you, it doesn't seem to be fatal; I've not had any issues with
>> the same machine that I can pin down to lack of ROM.
>>
>
> FWIW, my logs also get spammed with:
>
> [  127.101881] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
> has bogus alignment
>
> I suspect that the PCI core is just failing to recognize that the ROM
> is disabled.
>

A bit more info:

I think I only get this error when suspending for the second time
after boot.  No clue why.

I instrumented the code a bit.  At the time of that error, res->flags
== 0x2.  It's probably not a coincidence that:

#define IORESOURCE_ROM_SHADOW        (1<<1)    /* ROM is copy at C000:0 */

Should pci_fixup_video check that the resource exists in the first
place before setting flags on it?

--Andy
