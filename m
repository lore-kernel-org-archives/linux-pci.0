Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34111 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbHQWbm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2015 18:31:42 -0400
Received: by paccq16 with SMTP id cq16so73652768pac.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2015 15:31:41 -0700 (PDT)
Date: Mon, 17 Aug 2015 17:31:36 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 3/3] PCIE: Remove symbol export for pcie_set_mps()
Message-ID: <20150817223136.GL26431@google.com>
References: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
 <1438208335-19457-4-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438208335-19457-4-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 04:18:55PM -0600, Keith Busch wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> The setting of PCIe MPS should be left to the PCI subsystem and not
> the driver. An ill configured MPS by the driver could cause the device
> to not function or unstablize the entire system. Removing the exported
> symbol.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/pci.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0008c95..92349ee 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4121,7 +4121,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>  	return pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>  						  PCI_EXP_DEVCTL_PAYLOAD, v);
>  }
> -EXPORT_SYMBOL(pcie_set_mps);

I think the pcie_set_mps() declaration could be moved from
include/linux/pci.h to drivers/pci/pci.h, couldn't it?
