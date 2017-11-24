Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753880AbdKXXzk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 18:55:40 -0500
Date: Sat, 25 Nov 2017 00:55:33 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
cc: thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net,
        vidyas@nvidia.com, kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 01/10] genirq: Export irq_set_msi_desc()
In-Reply-To: <1511538800-8275-2-git-send-email-mmaddireddy@nvidia.com>
Message-ID: <alpine.DEB.2.20.1711250050520.2316@nanos>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com> <1511538800-8275-2-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 24 Nov 2017, Manikanta Maddireddy wrote:

Please CC the proper mailing list for irq related changes.

> PCI bus support MSI interrupts, allow PCI host driver to set MSI descriptor
> data for an irq.

This is not really an explanation why this export is needed.

Thanks,

	tglx

> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  kernel/irq/chip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 5a2ef92c2782..bfbd17386bc4 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -136,6 +136,7 @@ int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
>  {
>  	return irq_set_msi_desc_off(irq, 0, entry);
>  }
> +EXPORT_SYMBOL(irq_set_msi_desc);
>  
>  /**
>   *	irq_set_chip_data - set irq chip data for an irq
> -- 
> 2.1.4
> 
> 
