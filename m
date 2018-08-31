Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIACgI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 22:36:08 -0400
Subject: Re: [PATCH 06/16] PCI/ERR: Remove devices on recovery failure
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-7-keith.busch@intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <c30b9959-46e3-8cc3-684f-804b677c2990@kernel.org>
Date: Fri, 31 Aug 2018 15:26:35 -0700
MIME-Version: 1.0
In-Reply-To: <20180831212639.10196-7-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/31/2018 2:26 PM, Keith Busch wrote:
> +static void pcie_disconnect_device(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->subordinate;
> +	struct pci_dev *child, *tmp;
> +
> +	broadcast_error_message(dev, PCI_ERS_RESULT_DISCONNECT,
> +				"disconnect", report_disconnect);
> +	pci_lock_rescan_remove();
> +	list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
> +		pci_stop_and_remove_bus_device(child);
> +
> +	pci_bridge_secondary_bus_reset(dev);

Series look great so far. Please check the return value of
pci_bridge_secondary_bus_reset().
