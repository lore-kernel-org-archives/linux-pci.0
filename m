Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965245AbeF1NmX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jun 2018 09:42:23 -0400
Date: Thu, 28 Jun 2018 08:42:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/5] pci: export pcie_get_speed_cap and pcie_get_width_cap
Message-ID: <20180628134221.GC90450@bhelgaas-glaptop.roam.corp.google.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
 <20180625210606.2736-2-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180625210606.2736-2-alexander.deucher@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 04:06:02PM -0500, Alex Deucher wrote:
> So drivers can use them.  This can be used to replace
> duplicate code in the drm subsystem.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks a lot for doing this!

If you haven't applied these yet, please

  s/pci: export/PCI: Export/

in the subject.

> ---
>  drivers/pci/pci.c   | 2 ++
>  include/linux/pci.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 97acba712e4e..22adaf35b136 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5222,6 +5222,7 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
>  
>  	return PCI_SPEED_UNKNOWN;
>  }
> +EXPORT_SYMBOL(pcie_get_speed_cap);
>  
>  /**
>   * pcie_get_width_cap - query for the PCI device's link width capability
> @@ -5240,6 +5241,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>  
>  	return PCIE_LNK_WIDTH_UNKNOWN;
>  }
> +EXPORT_SYMBOL(pcie_get_width_cap);
>  
>  /**
>   * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 340029b2fb38..6e0c0803b241 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -261,6 +261,9 @@ enum pci_bus_speed {
>  	PCI_SPEED_UNKNOWN		= 0xff,
>  };
>  
> +enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
> +enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> +
>  struct pci_cap_saved_data {
>  	u16		cap_nr;
>  	bool		cap_extended;
> -- 
> 2.13.6
> 
