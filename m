Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:50099 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeIAVcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Sep 2018 17:32:54 -0400
Date: Sat, 1 Sep 2018 19:20:11 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 04/16] PCI/ERR: Use slot reset if available
Message-ID: <20180901172011.haapzq6o7ivuiq4g@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-5-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:26:27PM -0600, Keith Busch wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> +int pci_bus_error_reset(struct pci_dev *bridge)
> +{
> +	struct pci_bus *bus = bridge->subordinate;
> +
> +	if (!bus)
> +		return -ENOTTY;
> +
> +	if (!list_empty(&bus->slots)) {
> +		struct pci_slot *slot;
> +
> +		list_for_each_entry(slot, &bus->slots, list)
> +			if (pci_probe_reset_slot(slot))
> +				goto bus_reset;
> +		list_for_each_entry(slot, &bus->slots, list)
> +			if (pci_slot_reset(slot, 0))
> +				goto bus_reset;
> +		return 0;
> +	}

I don't see any locking to protect the slots list access.  It seems
pci_slot_mutex is meant to serve this purpose, but it's scoped to slot.c.
Which begs the question if this function should live there as well?

Thanks,

Lukas
