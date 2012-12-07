Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:56004 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab2LGAeP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2012 19:34:15 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so6622636vcd.19
        for <linux-pci@vger.kernel.org>; Thu, 06 Dec 2012 16:34:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bug-50671-41252@https.bugzilla.kernel.org/>
References: <bug-50671-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 6 Dec 2012 17:33:54 -0700
Message-ID: <CAErSpo4gfmt97canuW4x48+-v2kfXiED0rukQvCNOdrQUuJ73g@mail.gmail.com>
Subject: Re: [Bug 50671] New: bnx2: No interrupt was generated using MSI,
 switching to INTx mode
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-pci@vger.kernel.org, Michael Chan <mchan@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> https://bugzilla.kernel.org/show_bug.cgi?id=50671

> When booting 3.6.5 on a Proliant DL360 G3, I get this in dmesg:
>
>   bnx2: Broadcom NetXtreme II Gigabit Ethernet Driver bnx2 v2.2.3 (June 27,
> 2012)
>   bnx2 0000:01:01.0: eth0: HP NC370F Multifunction Gigabit Server Adapter (A2)
> PCI-X 64-bit 100MHz found at mem f4000000, IRQ 28
>   bnx2 0000:01:01.0: irq 80 for MSI/MSI-X
>   bnx2 0000:01:01.0: eth2: No interrupt was generated using MSI, switching to
> INTx mode. Please report this failure to the PCI maintainer and include system
> chipset information.

The DL360 G3 is pretty ancient.  The HP NC370F quickspecs
(http://h18004.www1.hp.com/products/quickspecs/12196_na/12196_na.html)
say it is supported on the DL360 G4, G4p, and  G5, but not the G3.  I
have no idea why.

I assume the NC370F has never been able to use MSI on this box with any kernel?

We have quirks that disable MSI globally on some machines; maybe we
need to do that on this system as well.

Can you attach a complete dmesg log and output of "lspci -vv"?
