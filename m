Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:59954 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754223AbaKRPmK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 18 Nov 2014 10:42:10 -0500
MIME-Version: 1.0
Message-ID: <trinity-7d71b540-5b76-4374-9a00-011d5e8262c3-1416325326852@3capp-webde-bs37>
From: "Roland Kletzing" <devzero@web.de>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Aw: Re: [Bug 88451] New: PCI devices missing - including USB
 controller. Boot fail
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Nov 2014 16:42:06 +0100
In-Reply-To: <CAErSpo5LgFPz9uUyg6+QchHbNP4G5R6xiYDqfYZp5wyBK-RagA@mail.gmail.com>
References: <bug-88451-41252@https.bugzilla.kernel.org/>,
 <CAErSpo5LgFPz9uUyg6+QchHbNP4G5R6xiYDqfYZp5wyBK-RagA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn, 

> Gesendet: Dienstag, 18. November 2014 um 15:22 Uhr
> Von: "Bjorn Helgaas" <bhelgaas@google.com>
> An: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
> Cc: "Roland Kletzing" <devzero@web.de>
> Betreff: Re: [Bug 88451] New: PCI devices missing - including USB controller. Boot fail
>
> [+cc linux-pci]
> 
> Hi Roland,
> 
> Thanks for the report!

Thanks for quick response & help !

> On Tue, Nov 18, 2014 at 5:08 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=88451
> >
> >             Bug ID: 88451
> >            Summary: PCI devices missing - including USB controller. Boot
> >                     fail
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 3.17 3.18rc4
> >           Hardware: i386
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: devzero@web.de
> >         Regression: No
> >
> > Created attachment 157971
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=157971&action=edit
> > dmesg from working kernel
> >
> > While stock debian kernel 3.2.0-4-486 and kernel 3.2.63 showed no problems,
> > 3.17+ fails.
> >
> > Apparently, all PCI devices except 0000:00:00.0 and 0000:00:12.2 are suddenly
> > missing, including USB controller - and thus boot from USB fails.
> >
> > I have taken a look at git and there seems to be a lot of PCI code rework
> > between 3.2.63 and 3.17+, which may be an explanation
> 
> Yeah, there have definitely been a lot of changes since 3.2.63 :)  I
> can't think of an obvious suspect, though.

No wonder. 

It is not an pci issue , as i just found out some minutes ago. Having some time
today for doing stupid trial&error testing, as i`m having a bad cold :-P
So i was wrong assigning this to linux-pci.

The answer is simple:

Apparently, the pci code portion has been separated from ohci_hcd, so it seems ohci_hcd is not
responsible anymore for an usb controller sitting on the pci bus, but there`s a separate module 
now: ohci_pci

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/host/ohci-hcd.c?id=2621d0119e574f12496c4ab731265d5777cb6a18

I found this by chance as i statically compiled usb into the kernel and suddenly it worked again, 
as i set CONFIG_USB_OHCI_PCI=y

In dmesg i then could see that ohci_pci now was jumping in - and that was the problem:

I was simply missing that module in my initrd, as it was not needed before :-P

> > So, i`m curious what`s the problem and how to fix it. Too many pci bootparams
> > to try all of them :(
> 
> Wow, very impressive screenshot console log of the failing kernel!
> Thanks for all the work to put that together

Oh, that was piece of cake. just 5mins of grabbing screenshots from a video and stitching 
them together. The harder part was to find boot_delay and lpj kernel params and make them 
work (to slow down output, as my lcd+cam were not fast enough for a clean picture), as with 
that applied, the kernel needs a long time to give a sign of life at all - which made me 
think it didn`t work on the first try...

> I notice that you're using "acpi=off" on both kernels.  Is that to
> work around some problem?  Do you know whether it's still needed in
> v3.17?

Yes, iirc, i have used that for long because booting had issues without that.

Now it "works" - at least it does not hang anymore with acpi on:

[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI BIOS Error (bug): A valid RSDP was not found (20140724/tbxfroot-211)
[    0.344469] ACPI: Interpreter disabled.

This hardware does not have an ordinary bios, so i suspect it also has no acpi at all.
Will need to find a way for proper power-off, though....

> Can you boot with "ignore_loglevel"?  Some of the PCI probing output
> is at KERN_DEBUG, which makes it into dmesg, but not normally to the
> console.  The useful part is the stuff that looks like this:
> 
>   [    0.111587] pci 0000:00:00.0: [1078:0001] type 0 class 0x000600
>   [    0.111927] pci 0000:00:0f.0: [100b:0020] type 0 class 0x000200
>   [    0.112886] pci 0000:00:12.0: [1078:0100] type 0 class 0x000601
>   [    0.113494] pci 0000:00:12.1: [1078:0101] type 0 class 0x000680

Ah, that`s the reason why i did not see it and what made me suspect that there
is something wrong with pci. I was not aware that dmesg on console and dmesg
on disk can differ. Good hint!

> so my suspicion is that the PCI core actually does enumerate all the
> devices, but for some reason ohci_hcd isn't claiming 00:13.0.

As told above.

I`m putting this (including dmesg from 3.17) to bugzilla and closing it.

Thanks again - and sorry for the noise.

regards
Roland
