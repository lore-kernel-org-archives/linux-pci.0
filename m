Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:44671 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIFQRU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2018 12:17:20 -0400
Date: Thu, 6 Sep 2018 13:42:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 03/20] PCI: Add required waits on link active
Message-ID: <20180906114215.jkz547ykg756pq4o@wunner.de>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905203546.21921-4-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 02:35:29PM -0600, Keith Busch wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4485,21 +4485,33 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
>  	bool ret;
>  	u16 lnk_status;
>  
> +	/*
> +	 * PCIe 4.0r1 6.6.1, a component must enter LTSSM Detect within 20ms,
> +	 * after which we should expect an link active if the reset was
> +	 * successful. If so, software must wait a minimum 100ms before sending
> +	 * configuration requests to devices downstream this port.
> +	 *
> +	 * If the link fails to activate, either the device was physically
> +	 * removed or the link is permanently failed.
> +	 */
> +	if (active)
> +		msleep(20);

This function is also called by pciehp when bringing up the slot,
yet I assume the above delay only applies to a Fundamental Reset,
not hotplug?


> +	if (active && ret)
> +		msleep(100);

This delay is already observed by pciehp_check_link_status()
after calling pcie_wait_link_active().

Thanks,

Lukas
