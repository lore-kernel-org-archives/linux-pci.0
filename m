Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:57680 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab3DVQWn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 12:22:43 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so1450967obb.14
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 09:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-56931-41252@https.bugzilla.kernel.org/>
References: <bug-56931-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Apr 2013 10:22:22 -0600
Message-ID: <CAErSpo52eg56p87sCy+42xio+n1Rp06Dv=fAXcmxcsAC0GJHAA@mail.gmail.com>
Subject: Re: [Bug 56931] New: "E/xHCI: BIOS handoff failed" breaks poweroff
To: mezin.alexander@gmail.com
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, Rafael, Sarah, Alan]

On Sun, Apr 21, 2013 at 11:41 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=56931
>
>            Summary: "E/xHCI: BIOS handoff failed" breaks poweroff
>     Kernel Version: 3.8.8
>         Regression: No
>
>  --> (https://bugzilla.kernel.org/attachment.cgi?id=99541)
> full dmesg
>
> Usually I see "EHCI: BIOS handoff failed" and "xHCI: BIOS handoff failed" in
> dmesg, and laptop hangs after "Power down" message. However, if I was lucky
> enough and "handoff failed" messages didn't appear, laptop suspends and turns
> off without any problems.

Thanks for the problem report.  If I understand correctly, when you
boot this HP Pavilion dv6, you normally see this in the dmesg:

  pci 0000:00:1a.0: EHCI: BIOS handoff failed (BIOS bug?) 01010001
  pci 0000:00:1d.0: EHCI: BIOS handoff failed (BIOS bug?) 01010001
  pci 0000:19:00.0: xHCI BIOS handoff failed (BIOS bug ?) 00010401

and when you attempt a power-off, it hangs after the "Power down"
message and never actually turns the power off.  But sometimes, you
don't see those "handoff failed" messages, and then a power-off works
as expected?

I'm a little confused by the mention of "suspend."

My guess is that this is actually a USB issue, not a PCI core problem.

> I remember that it didn't happen with old kernels (3.2 maybe). With 3.8 it
> happens almost always.

Sounds like this is actually a regression, but we don't have a solid
idea of what kernel worked.

> On the same laptop, Windows 7 runs fine. However, looks like there is a long
> pause during boot.
>
> --
> Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
> ------- You are receiving this mail because: -------
> You are watching the assignee of the bug.
