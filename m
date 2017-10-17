Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 14:28:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
cc: Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-pci@vger.kernel.org, devel@linuxdriverproject.org,
        Josh Poulson <jopoulso@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: Re: [patch 2/3] PCI/MSI: Set MSI_FLAG_MUST_REACTIVATE in core code
In-Reply-To: <20171017075600.448649905@linutronix.de>
Message-ID: <alpine.DEB.2.20.1710171416240.1932@nanos>
References: <20171017075456.694047687@linutronix.de> <20171017075600.448649905@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 17 Oct 2017, Thomas Gleixner wrote:

> If interrupt reservation mode is enabled then the PCI/MSI interrupts must
> be reactivated after early activation.
> 
> Make sure that all callers of pci_msi_create_irq_domain() have the
> MSI_FLAG_MUST_REACTIVATE set when reservation mode is enabled.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1441,6 +1441,8 @@ struct irq_domain *pci_msi_create_irq_do
>  		pci_msi_domain_update_chip_ops(info);
>  
>  	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION))

Bah. quilt refresh seems overrated. Correct patch below.

Thanks,

	tglx

8<----------------

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1441,6 +1441,8 @@ struct irq_domain *pci_msi_create_irq_do
 		pci_msi_domain_update_chip_ops(info);
 
 	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (!domain)
