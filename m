Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:43299 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaIMVef (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 13 Sep 2014 17:34:35 -0400
Received: by mail-qc0-f182.google.com with SMTP id c9so525448qcz.13
        for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2014 14:34:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-84471-41252@https.bugzilla.kernel.org/>
References: <bug-84471-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 13 Sep 2014 15:34:14 -0600
Message-ID: <CAErSpo52yO3R5sMePz7JeMzL-j5-+9ezfUAi1L92_v-LFRnPGg@mail.gmail.com>
Subject: Re: [Bug 84471] New: pci=assign-busses breaks power-off of T4215 laptop
To: thor@math.tu-berlin.de
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, Andreas, switching to email for discussion]

On Sat, Sep 13, 2014 at 10:08 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=84471
>
>             Bug ID: 84471
>            Summary: pci=assign-busses breaks power-off of T4215 laptop
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.17.0-rc4
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: thor@math.tu-berlin.de
>         Regression: No
>
> If the kernel argument "pci=assign-busses" is specified as a kernel boot
> parameter, power-off does no longer work with the T4215 laptop. The machine
> goes through the power-down cycle, but then sits idle with a blank screen after
> reporting "powering down". Without the kernel parameter, power-off works
> correctly.

Thank you very much for the report!

It sounds like this is a regression, i.e., power-off used to work
correctly with "pci=assign-busses", but it doesn't any more.  If
that's the case, what's the most recent kernel you know of where it
worked correctly?

Can you attach complete dmesg and "lspci -vv" output (as root) both
with and without "pci=assign-busses" to the bugzilla?  If you have an
older kernel where power-off works correctly with "pci=assign-busses",
please attach the same information for that kernel, too.

Why do you use "pci=assign-busses" in the first place?  This is likely
a different issue, but if "pci=assign-busses" fixes something, I
consider that a bug in itself, because Linux should be smart enough to
do the right thing even without "pci=assign-busses".  So if something
on your machine requires "pci=assign-busses" in order to work, please
open a second bugzilla for that.

It's possible this is the same problem reported at
https://bugzilla.kernel.org/show_bug.cgi?id=83441.  We think that is
related to fc1b253141b3 ("PCI: Don't scan random busses in
pci_scan_bridge()"), which appeared in v3.15.  I attached a test patch
to that bugzilla to revert that commit.  If you think it looks like
the same problem, you might try testing that patch.

Thanks again,
Bjorn
