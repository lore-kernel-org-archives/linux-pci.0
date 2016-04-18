Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33486 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbcDRIbt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 04:31:49 -0400
Date: Mon, 18 Apr 2016 10:30:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] pci: spread interrupt vectors in
 pci_alloc_irq_vectors
In-Reply-To: <1460770552-31260-8-git-send-email-hch@lst.de>
Message-ID: <alpine.DEB.2.11.1604181026290.3941@nanos>
References: <1460770552-31260-1-git-send-email-hch@lst.de> <1460770552-31260-8-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 15 Apr 2016, Christoph Hellwig wrote:
> Set the affinity_mask before allocating vectors.  And for now we also
> need a little hack after allocation, hopefully someone smarter than me
> can move this into the core code.
> 
>  
> +	/* XXX: this should really move into the core IRQ allocation code.. */
> +	if (vecs > 1) {
> +		for (i = 0; i < vecs; i++)
> +			irq_program_affinity(irqs[i]);

No. We don't want to do that at allocation time. The problem here is that we
set the IRQF_NOBALANCING flag for the allocated interrupts and therefor the
affinity is not set from request_irq(). We'll fix it there.

Thanks,

	tglx

