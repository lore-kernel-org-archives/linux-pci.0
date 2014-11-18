Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:59177 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbaKROXC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 09:23:02 -0500
Received: by mail-qg0-f54.google.com with SMTP id q107so849399qgd.27
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2014 06:23:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bug-88451-41252@https.bugzilla.kernel.org/>
References: <bug-88451-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Nov 2014 07:22:40 -0700
Message-ID: <CAErSpo5LgFPz9uUyg6+QchHbNP4G5R6xiYDqfYZp5wyBK-RagA@mail.gmail.com>
Subject: Re: [Bug 88451] New: PCI devices missing - including USB controller.
 Boot fail
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Roland Kletzing <devzero@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

Hi Roland,

Thanks for the report!

On Tue, Nov 18, 2014 at 5:08 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=88451
>
>             Bug ID: 88451
>            Summary: PCI devices missing - including USB controller. Boot
>                     fail
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.17 3.18rc4
>           Hardware: i386
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: devzero@web.de
>         Regression: No
>
> Created attachment 157971
>   --> https://bugzilla.kernel.org/attachment.cgi?id=157971&action=edit
> dmesg from working kernel
>
> While stock debian kernel 3.2.0-4-486 and kernel 3.2.63 showed no problems,
> 3.17+ fails.
>
> Apparently, all PCI devices except 0000:00:00.0 and 0000:00:12.2 are suddenly
> missing, including USB controller - and thus boot from USB fails.
>
> I have taken a look at git and there seems to be a lot of PCI code rework
> between 3.2.63 and 3.17+, which may be an explanation

Yeah, there have definitely been a lot of changes since 3.2.63 :)  I
can't think of an obvious suspect, though.

> So, i`m curious what`s the problem and how to fix it. Too many pci bootparams
> to try all of them :(

Wow, very impressive screenshot console log of the failing kernel!
Thanks for all the work to put that together.

I notice that you're using "acpi=off" on both kernels.  Is that to
work around some problem?  Do you know whether it's still needed in
v3.17?

Can you boot with "ignore_loglevel"?  Some of the PCI probing output
is at KERN_DEBUG, which makes it into dmesg, but not normally to the
console.  The useful part is the stuff that looks like this:

  [    0.111587] pci 0000:00:00.0: [1078:0001] type 0 class 0x000600
  [    0.111927] pci 0000:00:0f.0: [100b:0020] type 0 class 0x000200
  [    0.112886] pci 0000:00:12.0: [1078:0100] type 0 class 0x000601
  [    0.113494] pci 0000:00:12.1: [1078:0101] type 0 class 0x000680
  ...

I can tell from other driver printks that in v3.17, we did find these devices:

  [ 4.12] 00:12.2
  [ 4.44] 00:12.4
  [ 5.73] 00:0f.0
  [16.54] 00:12.3

so my suspicion is that the PCI core actually does enumerate all the
devices, but for some reason ohci_hcd isn't claiming 00:13.0.

Bjorn

> This is an older geode gx1 board (still have multiple around). for their age,
> they are quite power efficient (<6W) and i have some ideas to turn them into
> something useful.
>
> lspci
> 00:00.0 Host bridge: Cyrix Corporation PCI Master
> 00:0f.0 Ethernet controller: National Semiconductor Corporation DP83815
> (MacPhyter) Ethernet Controller
> 00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua] (rev 30)
> 00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
> 00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua]
> 00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
> 00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua]
> 00:13.0 USB controller: Compaq Computer Corporation ZFMicro Chipset USB (rev
> 06)
