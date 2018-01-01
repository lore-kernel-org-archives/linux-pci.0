Return-Path: <SRS0=6OAf=D4=molgen.mpg.de=pmenzel@kernel.org>
Return-Path: <SRS0=6OAf=D4=molgen.mpg.de=pmenzel@kernel.org>
Subject: Re: `pci_apply_final_quirks()` taking half a second
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1712311607450.15484-100000@netrider.rowland.org>
From: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Message-ID: <92dff466-d0a5-b30c-4d47-48584fac579e@molgen.mpg.de>
Date: Mon, 1 Jan 2018 11:21:19 +0100
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1712311607450.15484-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Dear Alan,


First, please note, that your mailer (MUA) doesn’t set the references 
header, which breaks threading for people not having their own answers 
in the inbox.

Am 31.12.2017 um 22:16 schrieb Alan Stern:
> On Sun, 31 Dec 2017, Paul Menzel wrote:
> 
>> Am 29.12.2017 um 17:14 schrieb Alan Stern:
>>> On Thu, 28 Dec 2017, Bjorn Helgaas wrote:
>>>
>>>> On Tue, Dec 26, 2017 at 04:55:20PM +0100, Paul Menzel wrote:
>>>>> Am 08.04.2017 um 17:41 schrieb Bjorn Helgaas:
>>>>>> On Fri, Apr 07, 2017 at 11:07:15PM +0200, Paul Menzel wrote:
>>>>>
>>>>>>> Measuring where time is spent during boot with `systemd-bootchart`
>>>>>>> on an Asus A780FullHD, it turns out that half a second is spent in
>>>>>>> `pci_apply_final_quirks()`.
>>>>>>
>>>>>> I agree, that seems like a crazy amount of time.
>>>>>>
>>>>>> Can you figure out how to turn on pr_debug() (via the dynamic debug
>>>>>> mess or whatever) and boot with "initcall_debug"?  That should tell us
>>>>>> how long each quirk took.
>>>>>
>>>>> I am sorry for taking so long to reply. I finally added `dyndbg=file
>>>>> quirks.c +p` to the command line of Linux 4.13.13. This is on
>>>>> another AMD system (Asus F285M Pro).
> 
>>>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 88643 usecs for
>>>>> 0000:00:12.0
> 
>>>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 85770 usecs for
>>>>> 0000:00:13.0
> 
>>>>> So it’s `pci fixup quirk_usb_early_handoff` taking around 85 ms, and
>>>>> that twice.
>>>>
>>>> Wow.  That's pretty painful, but of course I don't know how to fix it.
>>>>   From looking at quirk_usb_early_handoff(), it may depend on BIOS
>>>> details.  Maybe the USB folks will have some ideas.
>>>
>>> Can we see the output from lspci?  It would help to know what the 12.0
>>> and 13.0 devices are.
>>
>> Sorry, that was trimmed from the original message. Here is the output
>> from the ASRock A780FullD.
>>
>>> ```
>>> $ more /proc/version
>>> Linux version 4.9.0-0.bpo.2-amd64 (debian-kernel@lists.debian.org)
>>> (gcc version 4.9.2 (Debian 4.9.2-10) ) #1 SMP Debian 4.9.13-1~bpo8+1 (2017-02-27)
>>> $ lspci -nn
> 
>>> 00:12.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
>>> 00:12.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller [1002:4398]
>>> 00:12.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
>>> 00:13.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
>>> 00:13.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller [1002:4398]
>>> 00:13.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
> 
>> So far, this can be reproduce on all AMD systems I have (ASRock
>> A780FullHD, ASRock E350M1, Asus F2A85-M Pro).
> 
> So they are OHCI controllers.  You could add some debugging statements
> to quirk_usb_handoff_ohci() to try and locate the part that's taking so
> long.

As you suggested debugging statements, I guess the Linux kernel doesn’t 
offer other ways to instrument functions without modifying the source code.

Is it possible to only rebuild the module somehow or is the early 
handoff stuff not a module?

> It's also worth mentioning that the same source file contains lots of
> special-case code for AMD and ASmedia hardware.  I don't know whether
> any of it is involved in the long time delays you are seeing, however.

Thank you for already looking into this. I haven’t had to time to read 
the commit messages, which might shed some light into the reasoning.


Kind regards,

Paul
