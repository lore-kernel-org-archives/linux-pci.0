Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18981 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab3EOFjO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 May 2013 01:39:14 -0400
Date: Tue, 14 May 2013 22:39:11 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Xenia Ragiadakou <burzalodowa@gmail.com>
Cc: linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
	linux-pci@vger.kernel.org
Subject: Re: [OPW kernel] dma_set_coherent_mask
Message-ID: <20130515053911.GD17398@xanatos>
References: <5192F5C8.3090100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5192F5C8.3090100@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 15, 2013 at 05:41:12AM +0300, Xenia Ragiadakou wrote:
> Hi Sarah, (again)
> 
> Also I noticed that  dma_set_coherent_mask() is not called somewhere,
> which according to DMA-API-HOWTO.txt, means the even if the DMA mask
> is set to 64 bits by dma_set_mask, dma_alloc_coherent and
> dma_pool_alloc wont return 64 bit addresses (32 MSbits wont be
> addressed).

Another good question for Alan, and the USB and PCI list.

(Alan, Ksenia is one of the applicants for the FOSS Outreach Program for
Women that I've been coordinating: http://kernelnewbies.org/OPWIntro)

We do allocate memory using DMA pools, and we do want 64-bit context
addresses if the xHCI host controller can handle it.

The xHCI driver calls dma_set_mask, but not dma_set_coherent_mask():

                temp = xhci_readl(xhci, &xhci->cap_regs->hcc_params);
                if (HCC_64BIT_ADDR(temp)) {
                        xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
                        dma_set_mask(hcd->self.controller, DMA_BIT_MASK(64));
                } else {
                        dma_set_mask(hcd->self.controller, DMA_BIT_MASK(32));
                }

Alan, should it be calling dma_set_coherent_mask()?  I think I may have
noticed the context addresses were never 64-bit addresses, but I didn't
think to look whether the host supported 64-bit addresses.  I just
assumed it could only handle 32-bit addresses.

> I hope I'm not doing a huge mistake in my reasonance, and you loose
> your time with these emails.

Nope, I want you to ask questions, so don't worry about that.

Sarah Sharp
