Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbdHBWfu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 18:35:50 -0400
Date: Wed, 2 Aug 2017 17:35:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, marcel@redhat.com
Subject: Re: [PATCH] pci: shpchp: set the bridge busmaster if MSI are enabled
Message-ID: <20170802223547.GP20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 18, 2017 at 05:12:25PM +0300, Aleksandr Bezzubikov wrote:
> An MSI-based SHPC built in PCI bridges can configure hotplugged devices
> only if they notify the bridge with MSI.

I think you're referring to the events listed in SHPC r1.0, sec 4.7.3,
table 4-24, right?  Attention Button Press, Isolated Power Fault, Card
Presence Change, MRS Sensor Change, etc?

So IIUC, this is really about the bridge itself generating MSIs about
slot-related events, not the hot-added devices generating MSIs.

I agree this patch makes sense, I'm just trying to clarify the
changelog.

> But they can't trigger interrupt without the bridge being busmaster,
> that's why it should be enabled.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
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
> -- 
> 2.7.4
> 
