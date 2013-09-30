Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:45050
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754420Ab3I3Wuv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2013 18:50:51 -0400
Message-ID: <1380581443.24959.531.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with
 Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <B31939@freescale.com>
CC: Minghuan Lian <Minghuan.Lian@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Date: Mon, 30 Sep 2013 17:50:43 -0500
In-Reply-To: <5248144A.6070307@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
		 <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
	 <1380300847.24959.394.camel@snotra.buserror.net>
	 <5248144A.6070307@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2013-09-29 at 19:51 +0800, Lian Minghuan-b31939 wrote:
> >> +/*
> >> + * The fsl_arch_* functions are arch hooks. Those functions are
> >> + * implemented as weak symbols so that they can be overridden by
> >> + * architecture specific code if needed.
> >> + */
> >> +
> >> +/* Return PCI64 DMA offset */
> >> +u64 fsl_arch_pci64_dma_offset(void);
> > Is this always guaranteed to exist?
> [Minghuan] Yes. I define a __weak implementation in pci-fsl.c

I meant is it guaranteed that such a mapping exists?  The API doesn't
give a way to say "no".

Also you should describe what "PCI64 DMA offset" means.

> >> +/* Register PCI/PCIe controller to architecture system */
> >> +int __weak fsl_arch_pci_sys_register(struct fsl_pci *pci);
> >> +
> >> +/* Remove PCI/PCIe controller from architecture system */
> >> +void __weak fsl_arch_pci_sys_remove(struct fsl_pci *pci);
> > Why do these need to be weak?  Won't there be exactly one implementation
> > per supported arch?
> [Minghuan] I added __weak for compiling kernel when selecting pci-fsl 
> module but
> there is no related arch pci implementation.

The module should not be buildable on arches that don't have support.

-Scott



