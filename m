Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752806AbdAKShc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 13:37:32 -0500
Date: Wed, 11 Jan 2017 12:37:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vaibhav Shankar <vaibhav.shankar@intel.com>
Cc: bhelgaas@google.com, mayurkumar.patel@intel.com,
        keith.busch@intel.com, lukas@wunner.de, yinghai@kernel.org,
        yhlu.kernel@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Optimize PCIe root resume time
Message-ID: <20170111183726.GE14532@bhelgaas-glaptop.roam.corp.google.com>
References: <20161211011908.GA10954@linux-siqj.site>
 <1481589145-22109-1-git-send-email-vaibhav.shankar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481589145-22109-1-git-send-email-vaibhav.shankar@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Vaibhav,

On Mon, Dec 12, 2016 at 04:32:25PM -0800, Vaibhav Shankar wrote:
> On Apollolake platforms, PCIe rootport takes a long time to resume
> from S3. With 100ms delay before read pci conf, rootport takes
> ~200ms during resume.
> 
> commit 2f5d8e4ff947 ("PCI: pciehp: replace unconditional sleep with
> config space access check") is the one that added the 100ms delay
> before reading pci conf.
> 
> This patch includes a condition check for 100ms dealy before reading
> PCIe conf. This delay in included only when PCIe
> max_bus_speed > 5.0 GT/s. Root port takes ~16ms during resume.

This patch reduces the delay by 100ms for devices that don't support
5.0 GT/s.  Please include references to the specs about the necessary
delays and explain why we don't need this 100ms delay.

Presumably there's something in the spec about needing extra delay
when supporting 5.0 GT/s.

This is generic code, so we can't make changes based on specific
devices like Apollolake.  We have to make the code follow the spec so
it works for everybody.

> With 100ms delay:
> [  155.102713] calling  0000:00:14.0+ @ 70, parent: pci0000:00, cb: pci_pm_resume_noirq
> [  155.119337] call 0000:00:14.0+ returned 0 after 16231 usecs
> [  155.119467] calling  0000:01:00.0+ @ 5845, parent: 0000:00:14.0, cb: pci_pm_resume_noirq
> [  155.321670] call 0000:00:14.0+ returned 0 after 185327 usecs
> [  155.321743] calling  0000:01:00.0+ @ 5849, parent: 0000:00:14.0, cb: pci_pm_resume
> 
> With Condition check:
> [   36.624709] calling 0000:00:14.0+ @ 4434, parent: pci0000:00, cb: pci_pm_resume_noirq
> [   36.641367] call 0000:00:14.0+ returned 0 after 16263 usecs
> [   36.652458] calling 0000:00:14.0+ @ 4443, parent: pci0000:00, cb: pci_pm_resume
> [   36.652673] call 0000:00:14.0+ returned 0 after 208 usecs
> [   36.652863] calling  0000:01:00.0+ @ 4442, parent: 0000:00:14.0, cb: pci_pm_resume
> 
> Signed-off-by: Vaibhav Shankar <vaibhav.shankar@intel.com>
> ---
> changes in v2:
>         - Modify patch description.
>         - Add condition check for 100ms delay before read pci conf as
>           suggested by Yinghai.
> 
>  drivers/pci/hotplug/pciehp_hpc.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index b57fc6d..2b10e5f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -311,8 +311,15 @@ int pciehp_check_link_status(struct controller *ctrl)
>  	else
>  		msleep(1000);
>  
> -	/* wait 100ms before read pci conf, and try in 1s */
> -	msleep(100);
> +	/*
> +	 * If the port supports Link speeds greater than 5.0 GT/s, we
> +	 * must wait for 100 ms after Link training completes before
> +	 * sending configuration request.
> +	 */
> +	if (ctrl->pcie->port->subordinate->max_bus_speed > PCIE_SPEED_5_0GT)
> +		msleep(100);
> +
> +	/* try in 1s */
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
