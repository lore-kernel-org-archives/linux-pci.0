Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:44695 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbaKRRhr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 12:37:47 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so4437546pdj.21
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2014 09:37:46 -0800 (PST)
From: Kevin Hilman <khilman@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH] PCI: fixup __pci_read_base() after refactoring
References: <20141118105542.457d7863@free-electrons.com>
	<1416310271-4423-1-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Tue, 18 Nov 2014 09:37:44 -0800
In-Reply-To: <1416310271-4423-1-git-send-email-thomas.petazzoni@free-electrons.com>
	(Thomas Petazzoni's message of "Tue, 18 Nov 2014 12:31:11 +0100")
Message-ID: <7hwq6sxvdj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> In commit 7ea945f0bb49 ("PCI: Shrink decoding-disabled window while
> sizing BARs"), Myron Stowe refactored the code of __pci_read_base() in
> order to reduce the amount of time spent with decoding disabled.
>
> However, contrary to what was said in the commit log, the commit does
> introduce some functional change: the pci_size() function that used to
> be called *before* the BAR size check is done is now called *after*
> the BAR size check is done.
>
> This causes some failures on certain platforms (namely ARM Marvell EBU
> platforms, equipped for example with a PCIe SATA card, or a PCIe USB3
> XHCI controller):
>
> pci 0000:03:00.0: reg 0x10: can't handle BAR larger than 4GB (size 0xfffffffffff00000)
>
> This problem didn't exist before this commit, due to pci_size() being
> called before doing the PCI BAR size check. Therefore, this commit
> fixes the problem by restoring the initial order of the operation, by
> calling pci_size() before doing the PCI BAR size check.
>

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Fixes: 7ea945f0bb49 ("PCI: Shrink decoding-disabled window while sizing BARs")

I also boot tested this on armada-370-mirabox (multi_v7_defconfig and
mvebu_v7_defconfig) where I originally noticed the problem, and it's
booting fine again.

Tested-by: Kevin Hilman <khilman@linaro.org>

and, you forgot something:  ;)

Reported-by: Kevin Hilman <khilman@linaro.org>

Kevin
