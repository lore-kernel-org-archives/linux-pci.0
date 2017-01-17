Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Jan 2017 08:49:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v2] PCI/MSI: pci-xgene-msi: Fix CPU hotplug registration
 handling
Message-ID: <20170117144939.GC22776@bhelgaas-glaptop.roam.corp.google.com>
References: <1484662916-9549-1-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484662916-9549-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2017 at 02:21:56PM +0000, Marc Zyngier wrote:
> The conversion to the new hotplug state machine introduced a regression
> where a successful hotplug registration would be treated as an error,
> effectively disabling the MSI driver forever.
> 
> Fix it by doing the proper check on the return value.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Fixes: 9c248f8896e6 ("PCI/xgene-msi: Convert to hotplug state machine")
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Tested-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied to for-linus for v4.10, thanks!

> ---
> * From v1: added Sebastian's Ack and Duc's Tested-by, cc'ing linux-pci
> 
>  drivers/pci/host/pci-xgene-msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
> index 1f38d08..f1b633b 100644
> --- a/drivers/pci/host/pci-xgene-msi.c
> +++ b/drivers/pci/host/pci-xgene-msi.c
> @@ -517,7 +517,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  
>  	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "pci/xgene:online",
>  			       xgene_msi_hwirq_alloc, NULL);
> -	if (rc)
> +	if (rc < 0)
>  		goto err_cpuhp;
>  	pci_xgene_online = rc;
>  	rc = cpuhp_setup_state(CPUHP_PCI_XGENE_DEAD, "pci/xgene:dead", NULL,
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
