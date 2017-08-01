Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbdHAP5p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Aug 2017 11:57:45 -0400
Date: Tue, 1 Aug 2017 18:57:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, marcel@redhat.com,
        stable@vger.kernel.org
Subject: Re: pci: shpchp: set the bridge busmaster if MSI are enabled
Message-ID: <20170801185648-mutt-send-email-mst@kernel.org>
References: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 18, 2017 at 05:12:25PM +0300, Aleksandr Bezzubikov wrote:
> An MSI-based SHPC built in PCI bridges can configure hotplugged devices
> only if they notify the bridge with MSI.
> But they can't trigger interrupt without the bridge being busmaster,
> that's why it should be enabled.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>


Given there's pci_enable_msi above, not enabling bus master
seems like a very strange thing to do.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

This also looks like a good candidate for stable.

> ---
>  drivers/pci/hotplug/shpchp_hpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
> index de0ea47..e5824c7 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -1062,6 +1062,8 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
>  		if (rc) {
>  			ctrl_info(ctrl, "Can't get msi for the hotplug controller\n");
>  			ctrl_info(ctrl, "Use INTx for the hotplug controller\n");
> +		} else {
> +			pci_set_master(pdev);
>  		}
>  
>  		rc = request_irq(ctrl->pci_dev->irq, shpc_isr, IRQF_SHARED,
