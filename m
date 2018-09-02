Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49821 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeIBNtM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Sep 2018 09:49:12 -0400
Date: Sun, 2 Sep 2018 11:34:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 11/16] PCI/portdrv: Restore pci state on slot reset
Message-ID: <20180902093402.rgeb5ioig7h5hoxf@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-12-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-12-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:26:34PM -0600, Keith Busch wrote:
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -174,7 +174,9 @@ static int slot_reset_iter(struct device *device, void *data)
>  
>  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
>  {
> +	pci_restore_state(dev);
>  	device_for_each_child(&dev->dev, dev, slot_reset_iter);
> +	pci_save_state(dev);
>  	return PCI_ERS_RESULT_RECOVERED;
>  }

Shouldn't this be the other way round, i.e. save, reset, restore?

Also, the function pcie_portdrv_slot_reset() was introduced in the prior
patch, so it seems this is a fix for that other patch and the two should
be squashed together.

Thanks,

Lukas
