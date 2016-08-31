Return-Path: <roland.singer@desertbit.com>
Return-Path: <roland.singer@desertbit.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Peter Wu <peter@lekensteyn.nl>, Ilia Mirkin <imirkin@alum.mit.edu>
References: <20160829235403.GA14177@localhost>
 <1d1bfdc2-f23d-9816-e4e3-ae676105dc39@desertbit.com>
 <20160830130634.GA16426@localhost>
 <CACvgo51b4XLz2PwH1dkcK4_FknfZkSUKsFepYz-AGfPr7ux2kA@mail.gmail.com>
 <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com>
 <CACvgo51gNzECupX6R7jwQndH-1rX6MN1kPquuikzJrPk3CeZVA@mail.gmail.com>
 <43ce7a5b-8331-fec2-f598-afcb13ba3785@desertbit.com>
 <CAKb7UviZ0qKp3PRR+iHr+KiOU9Sadeeb6PyydWN-FUL0RzyCPA@mail.gmail.com>
 <1c761bab-f82b-3f43-c4f0-c7a8eff94f25@desertbit.com>
 <CAKb7Uvjzhog27TUPTn5OOqXviyD_z3UV0qvskZDEO8CAB2-i2w@mail.gmail.com>
 <20160830192112.GA18045@al>
Cc: Emil Velikov <emil.l.velikov@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From: Roland Singer <roland.singer@desertbit.com>
Message-ID: <98b2ae5b-399b-8337-18dc-98ac2480746f@desertbit.com>
Date: Wed, 31 Aug 2016 13:12:30 +0200
MIME-Version: 1.0
In-Reply-To: <20160830192112.GA18045@al>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Am 30.08.2016 um 21:21 schrieb Peter Wu:
> On Tue, Aug 30, 2016 at 02:13:46PM -0400, Ilia Mirkin wrote:
>> On Tue, Aug 30, 2016 at 2:02 PM, Roland Singer
>> <roland.singer@desertbit.com> wrote:
>>> I configured bbswitch to not set any states automatically...
>>> So it's possible to obtain and verify the GPU power state.
>>>
>>> However I removed the bbswitch module and booted with nouveau.
>>>
>>> Kernel 4.7.2: nouveau switches the discrete GPU off.
>>>               I can't trigger the freeze, because bbswitch is missing.
>>>               I'll work with the system and see if it will freeze.
>>>
>>> Kernel 4.8-rc4: nouveau does not care about the power state and
>>>                 the discrete GPU is never switched off. I will notice
>>>                 this, because the second cooling FAN will stop...
>>>                 Same log messages as send before.
>>
>> That's surprising. I believe there's an issue with the new logic when
>> there's an HDMI audio subdevice. However that only appears if there's
>> a cable plugged in, at least in the systems Peter tested. You should
>> be able to see whether it's there or not with 'lspci'.
> 
> I doubt that the audio device is responsible here, that should only show
> up after following very specific steps (runtime suspend/resume (PCI or
> ACPI magic), remove PCI device, rescan bus).
> 
>> You can check for sure by looking in the vgaswitcheroo state. It
>> should say DynOff when it's powered off.
>>
>> Either way, I think using bbswitch + nouveau isn't supported by
>> anyone, so if you want to use it that way, you're on your own. (You
>> may want to load nouveau with runpm=0 so that nouveau doesn't try to
>> manage the GPU suspend stuff.)
> 
> I understood that Roland's intent is to check the power state, not use
> the suspend functionality of bbswitch, if you load bbswitch without
> module options amd do not write to /proc/bbswitch, then it allows you to
> read out the actual status (you could also just use lspci -H1 for that
> though).
> 

lspci -H1 works perfect. Thanks.
Just tried to verify the output with lspci -H1. I unloaded the nouveau
module and modprobe freezed with:

  $ modprobe -r nouveau
    nouveau 0000:01:00.0: pci: failed to adjust lnkctl speed
    nouveau 0000:01:00.0: fb: init failed. -22
    nouveau 0000:01:00.0: init failed with -22
    nouveau: DRM:00000000:00000000: init failed with -22
    nouveau: DRM:00000000:00000000: init failed with -22
