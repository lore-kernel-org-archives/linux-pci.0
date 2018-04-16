Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753153AbeDPVus (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Apr 2018 17:50:48 -0400
Date: Mon, 16 Apr 2018 16:50:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
Message-ID: <20180416215044.GE28657@bhelgaas-glaptop.roam.corp.google.com>
References: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Matt,

First of all, sorry about breaking Nautilus, and thanks very much for
tracking it down to this commit.

On Mon, Apr 16, 2018 at 07:33:57AM -0700, Matt Turner wrote:
> Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
> address limits in resource allocation) broke Alpha systems using
> CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
> 32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
> into the upper addresses just below 4GB.
> 
> I can get a working kernel by ifdef'ing out the code in
> drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
> PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
> kernels.
> 
> How can we get Nautilus working again?

Can you collect a complete dmesg log, ideally both before and after
f75b99d5a77d?  I assume the problem is that after f75b99d5a77d? we
erroneously assign space for something above 4GB.  But if we know the
correct host bridge apertures, we shouldn't assign space outside them,
regardless of the PCI bus address size.

Coincidentally, Christoph is replacing CONFIG_PCI_BUS_ADDR_T_64BIT
with CONFIG_ARCH_DMA_ADDR_T_64BIT, but I think that change is a no-op
with respect to the problem you're seeing.

[1] https://lkml.kernel.org/r/20180415145947.1248-10-hch@lst.de
