Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753408AbdGSNg5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jul 2017 09:36:57 -0400
Subject: Re: [PATCH] pci: shpchp: set the bridge busmaster if MSI are enabled
To: Aleksandr Bezzubikov <zuban32s@gmail.com>,
        linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Michael Tsirkin <mst@redhat.com>
References: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <b0c85887-38f1-337e-4cc4-d671a200ff7d@redhat.com>
Date: Wed, 19 Jul 2017 16:36:50 +0300
MIME-Version: 1.0
In-Reply-To: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18/07/2017 17:12, Aleksandr Bezzubikov wrote:
> An MSI-based SHPC built in PCI bridges can configure hotplugged devices
> only if they notify the bridge with MSI.
> But they can't trigger interrupt without the bridge being busmaster,
> that's why it should be enabled.

Hi Aleksandr,

Hot-plugging an empty bridge does require making it bus-master,
otherwise we end up with an unusable pci brigde.

> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   drivers/pci/hotplug/shpchp_hpc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
> index de0ea47..e5824c7 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -1062,6 +1062,8 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
>   		if (rc) {
>   			ctrl_info(ctrl, "Can't get msi for the hotplug controller\n");
>   			ctrl_info(ctrl, "Use INTx for the hotplug controller\n");
> +		} else {
> +			pci_set_master(pdev);
>   		}
>   
>   		rc = request_irq(ctrl->pci_dev->irq, shpc_isr, IRQF_SHARED,
> 


I am not really familiar with the shpc code,
but the change looks OK to me.

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
