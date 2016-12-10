Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752443AbcLJA1t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Dec 2016 19:27:49 -0500
Date: Fri, 9 Dec 2016 18:27:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vaibhav Shankar <vaibhav.shankar@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, venkateswarlu.v.vinjamuri@intel.com,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Optimize PCIe root resume time
Message-ID: <20161210002744.GB8381@bhelgaas-glaptop.roam.corp.google.com>
References: <1481323406-12865-1-git-send-email-vaibhav.shankar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481323406-12865-1-git-send-email-vaibhav.shankar@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai, author of 2f5d8e4ff947]

On Fri, Dec 09, 2016 at 02:43:26PM -0800, Vaibhav Shankar wrote:
> On Apollolake platforms, PCIe rootport takes a long time to resume
> from S3. With 100ms delay before read pci conf, rootport takes
> ~200ms during resume.
> 
> commit 2f5d8e4ff947 ("PCI: pciehp: replace unconditional sleep with
> config space access check") is the one that added the 100ms delay
> before reading pci conf.
> 
> This patch removes the 100ms delay.By removing the delay, the
> PCIe root port takes ~16ms during resume. As per PCIe spec, we
> only require 1000ms delay. This delay is provide by
> pci_bus_check_dev() function.
> 
> With 100ms delay:
> [  155.102713] calling  0000:00:14.0+ @ 70, parent: pci0000:00, cb: pci_pm_resume_noirq
> [  155.119337] call 0000:00:14.0+ returned 0 after 16231 usecs
> [  155.119467] calling  0000:01:00.0+ @ 5845, parent: 0000:00:14.0, cb: pci_pm_resume_noirq
> [  155.321670] call 0000:00:14.0+ returned 0 after 185327 usecs
> [  155.321743] calling  0000:01:00.0+ @ 5849, parent: 0000:00:14.0, cb: pci_pm_resume
> 
> After removing 100ms delay:
> [   36.624709] calling  0000:00:14.0+ @ 4434, parent: pci0000:00, cb: pci_pm_resume_noirq
> [   36.641367] call 0000:00:14.0+ returned 0 after 16263 usecs
> [   36.652458] calling  0000:00:14.0+ @ 4443, parent: pci0000:00, cb: pci_pm_resume
> [   36.652673] call 0000:00:14.0+ returned 0 after 208 usecs
> [   36.652863] calling  0000:01:00.0+ @ 4442, parent: 0000:00:14.0, cb: pci_pm_resume
> 
> Signed-off-by: Vaibhav Shankar <vaibhav.shankar@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 5c24e93..08357e7 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -311,8 +311,6 @@ int pciehp_check_link_status(struct controller *ctrl)
>  	else
>  		msleep(1000);
>  
> -	/* wait 100ms before read pci conf, and try in 1s */
> -	msleep(100);
>  	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
>  					PCI_DEVFN(0, 0));
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
