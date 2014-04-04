Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36556 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbaDDXcy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 19:32:54 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so3968907pdj.4
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 16:32:54 -0700 (PDT)
Date: Fri, 4 Apr 2014 17:32:51 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] PCI: Refactor pci_is_bridge()
Message-ID: <20140404233251.GB15806@google.com>
References: <1394789926-11912-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394789926-11912-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 14, 2014 at 05:38:46PM +0800, Yijing Wang wrote:
> Refactor pci_is_bridge(), check pci device
> hdr_type instead, and move it in include/linux/pci.h
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  include/linux/pci.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 33aa2ca..22370c4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1649,6 +1649,12 @@ static inline bool pci_is_pcie(struct pci_dev *dev)
>  	return pci_pcie_cap(dev);
>  }
>  
> +static inline bool pci_is_bridge(struct pci_dev *dev)
> +{
> +	return dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
> +		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
> +}

There's no point in adding this unless somebody uses it (but I assume
you probably meant to use it in acpi_pci_find_companion() as I mentioned).

>  /**
>   * pcie_caps_reg - get the PCIe Capabilities Register
>   * @dev: PCI device
> -- 
> 1.7.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
