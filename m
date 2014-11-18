Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:49860 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbaKRPs6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 10:48:58 -0500
Received: by mail-qg0-f51.google.com with SMTP id l89so2668614qgf.38
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2014 07:48:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <trinity-7d71b540-5b76-4374-9a00-011d5e8262c3-1416325326852@3capp-webde-bs37>
References: <bug-88451-41252@https.bugzilla.kernel.org/> <CAErSpo5LgFPz9uUyg6+QchHbNP4G5R6xiYDqfYZp5wyBK-RagA@mail.gmail.com>
 <trinity-7d71b540-5b76-4374-9a00-011d5e8262c3-1416325326852@3capp-webde-bs37>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Nov 2014 08:48:37 -0700
Message-ID: <CAErSpo4OajjHFNUp-ytAmnEbwq+4trDqmx-egy=prQVrLSmJwg@mail.gmail.com>
Subject: Re: Re: [Bug 88451] New: PCI devices missing - including USB
 controller. Boot fail
To: Roland Kletzing <devzero@web.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 18, 2014 at 8:42 AM, Roland Kletzing <devzero@web.de> wrote:
...
> The answer is simple:
>
> Apparently, the pci code portion has been separated from ohci_hcd, so it seems ohci_hcd is not
> responsible anymore for an usb controller sitting on the pci bus, but there`s a separate module
> now: ohci_pci
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/host/ohci-hcd.c?id=2621d0119e574f12496c4ab731265d5777cb6a18

...

> I`m putting this (including dmesg from 3.17) to bugzilla and closing it.

Great, thanks for tracking this down!

Bjorn
