Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44418 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbdFTT7q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jun 2017 15:59:46 -0400
Date: Tue, 20 Jun 2017 16:07:59 -0400
From: Keith Busch <keith.busch@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 15/55] PCI: vmd: Create named irq domain
Message-ID: <20170620200758.GC24415@localhost.localdomain>
References: <20170619233700.547167146@linutronix.de>
 <20170619235444.379861978@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619235444.379861978@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 20, 2017 at 01:37:15AM +0200, Thomas Gleixner wrote:
>  static int vmd_enable_domain(struct vmd_dev *vmd)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> +	struct fwnode_handle *fn;
>  	struct resource *res;
>  	u32 upper_bits;
>  	unsigned long flags;
> @@ -617,8 +618,13 @@ static int vmd_enable_domain(struct vmd_
>  
>  	sd->node = pcibus_to_node(vmd->dev->bus);
>  
> -	vmd->irq_domain = pci_msi_create_irq_domain(NULL, &vmd_msi_domain_info,
> +	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
> +	if (!fn)
> +		return -ENODEV;
> +
> +	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
>  						    x86_vector_domain);
> +	kfree(fn);

If I'm following all this correctly, it looks like we need to use
irq_domain_free_fwnode with irq_domain_alloc_named_id_fwnode instead of
freeing 'fn' directly, otherwise we leak 'fwid->name'.
