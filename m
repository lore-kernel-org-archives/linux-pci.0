Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33123 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbHJPec (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 11:34:32 -0400
Received: by wijp15 with SMTP id p15so140517775wij.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 08:34:31 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Aug 2015 10:34:11 -0500
Message-ID: <CAErSpo7D51x=D4fuPuk0PyzrxqvnVTq684fKBR3J-CGeqUWTLQ@mail.gmail.com>
Subject: [REGRESSION, bisected] [Bug 102311] New: ASMEDA asm1062 not working
To: Matthew Garrett <mjg59@coreos.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	andre@lianse.eu
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 5, 2015 at 1:36 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=102311
>
>             Bug ID: 102311
>            Summary: ASMEDA asm1062 not working
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 4.1
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: andre@lianse.eu
>         Regression: No
>
> Created attachment 184311
>   --> https://bugzilla.kernel.org/attachment.cgi?id=184311&action=edit
> git_bisect_4.0_4.1.log
>
> I'm running Arch Linux on a ASRock Z87 Extreme 6. After switching from 4.0
> kernel to 4.1. All drives attached to the ASMedia Chipset stopped working.
>
> To inspect this further I switched over to vanilla kernel and did a git bisect
> to mirror it down to the following commit:
> [387d37577fdd05e9472c20885464c2a53b3c945f] PCI: Don't clear ASPM bits when the
> FADT declares it's unsupported
>
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
