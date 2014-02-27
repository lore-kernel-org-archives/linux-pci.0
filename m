Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:56929 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbaB0P6x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 10:58:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-kernel@lists.linaro.org
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] pci: Add support for creating a generic host_bridge from device tree
Date: Thu, 27 Feb 2014 16:58:41 +0100
Message-ID: <5722634.VerP6OyMlP@wuerfel>
In-Reply-To: <20140227141322.GL1692@e106497-lin.cambridge.arm.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com> <18746655.qWHLpMg2Yy@wuerfel> <20140227141322.GL1692@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 27 February 2014 14:13:22 Liviu Dudau wrote:
> 
> It is useful for host bridge drivers as this is the only place where we store
> the physical CPU address for the IO range. This is then needed when setting up the
> translation registers. Also used when calling the pci_ioremap_io function that I'm
> introducing in the AArch64 patches.

I don't understand what translation windows you are talking about. Is this
about how the PCI spaces are mapped into the CPU address space? If so, I
would strongly recommend to have this handled by the boot loader before
calling into the kernel. For ARM32, we have a lot of embedded systems
that require the PCI host driver to set up those windows, but actually
it would be much better to just have the firmware tell us what the setup
is and that use that.

> Whole patch is still under legal review, but the fragment for setting up the ATR looks
> like this:
> 
>         list_for_each_entry(window, &bridge->windows, list) {
>                 res = window->res;
>                 offset = window->offset;
>                 wsize = ilog2(resource_size(res)) - 1;
> 
>                 if (resource_type(res) == IORESOURCE_MEM)
>                         update_atr_entry(pp->base + ATR_REG_whatever,
>                                 res->start,                             /* CPU address */
>                                 res->start - offset,                    /* PCI address */
>                                 0, wsize);
>                 else if (resource_type(res) == IORESOURCE_IO) {
>                         io_offset = pci_ioremap_io(res, bridge->io_base + offset);
>                         update_atr_entry(pp->base + ATR_REG_whatever,
>                                 bridge->io_base + res->start + offset,  /* CPU address */
>                                 res->start,                             /* PCI address */
>                                 0x20000, wsize);
>                 }
>         }

Hmm, I again don't see how 'bridge->io_base + res->start + offset' is
the correct address here. What is it you are trying to pass into
update_atr_entry()?

	Arnd
