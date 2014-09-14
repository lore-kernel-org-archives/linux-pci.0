Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:62106 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbaINPFH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Sep 2014 11:05:07 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so1019636qcz.23
        for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2014 08:05:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-84571-41252@https.bugzilla.kernel.org/>
References: <bug-84571-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 14 Sep 2014 09:04:45 -0600
Message-ID: <CAErSpo5_RfiZXtunWHrsFw-6Zw_7aQLDOVxGm_1LtE6Q3WnJnA@mail.gmail.com>
Subject: Re: [Bug 84571] New: PCMCIA cards not recognized in IBM 31 without pci=assign-busses
To: Thomas Richter <thor@math.tu-berlin.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, Andreas, switching to email for discussion]

On Sun, Sep 14, 2014 at 5:29 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=84571
>
>             Bug ID: 84571
>            Summary: PCMCIA cards not recognized in IBM 31 without
>                     pci=assign-busses
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.17.0-rc4
>           Hardware: i386
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
> Recent kernels do not recognize PCMCIA cards inserted into the card slot of the
> (admittedly old) IBM R31 laptop. The kernel argument pci=assign-busses is
> needed to make such cards visible (e.g. wifi cards). The PCMCIA hardware is not
> very spectacular, it is the typical yenta cardbus bridge. lspci -vv and dmesg
> will follow tomorrow.

You mention "recent kernels," so this sounds like a regression.  If
so, can you mark the bugzilla as a regression and mention the most
recent kernel you know of where it worked without "pci=assign-busses"?
 If you have that old working kernel handy, a dmesg log from it would
also be useful.

Possibly the same problem as https://bugzilla.kernel.org/show_bug.cgi?id=83441

Bjorn
