Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:35499 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeGCOeg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 10:34:36 -0400
Date: Tue, 3 Jul 2018 16:34:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180703143434.GA4086@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
> @@ -308,8 +310,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>  		pci_dev_put(pdev);
>  	}
>  
> +	hpsvc = pcie_port_find_service(udev, PCIE_PORT_SERVICE_HP);
> +	hpdev = pcie_port_find_device(udev, PCIE_PORT_SERVICE_HP);
> +
> +	if (hpdev && hpsvc)
> +		hpsvc->mask_irq(to_pcie_device(hpdev));
> +
>  	result = reset_link(udev, service);
>  
> +	if (hpdev && hpsvc)
> +		hpsvc->unmask_irq(to_pcie_device(hpdev));
> +

We've already got the ->reset_slot callback in struct hotplug_slot_ops,
I'm wondering if we really need additional ones for this use case.

If you just do...

	if (!pci_probe_reset_slot(dev->slot))
		pci_reset_slot(dev->slot)
	else {
		/* regular code path */
	}

would that not be equivalent?

(It's worth noting though that pciehp is the only hotplug driver
implementing the ->reset_slot callback.  If hotplug is handled by
a different driver or by the platform firmware, devices may still
be removed and re-enumerated twice.)

Thanks,

Lukas
