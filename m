Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:16410
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753901AbeDAUjF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Apr 2018 16:39:05 -0400
Subject: Re: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute max
 supported link bandwidth
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com>
Date: Sun, 1 Apr 2018 23:38:53 +0300
MIME-Version: 1.0
In-Reply-To: <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/31/2018 12:05 AM, Bjorn Helgaas wrote:
> From: Tal Gilboa <talgi@mellanox.com>
> 
> Add pcie_bandwidth_capable() to compute the max link bandwidth supported by
> a device, based on the max link speed and width, adjusted by the encoding
> overhead.
> 
> The maximum bandwidth of the link is computed as:
> 
>    max_link_speed * max_link_width * (1 - encoding_overhead)
> 
> The encoding overhead is about 20% for 2.5 and 5.0 GT/s links using 8b/10b
> encoding, and about 1.5% for 8 GT/s or higher speed links using 128b/130b
> encoding.
> 
> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
> [bhelgaas: adjust for pcie_get_speed_cap() and pcie_get_width_cap()
> signatures, don't export outside drivers/pci]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> ---
>   drivers/pci/pci.c |   21 +++++++++++++++++++++
>   drivers/pci/pci.h |    9 +++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 43075be79388..9ce89e254197 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5208,6 +5208,27 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>   	return PCIE_LNK_WIDTH_UNKNOWN;
>   }
>   
> +/**
> + * pcie_bandwidth_capable - calculates a PCI device's link bandwidth capability
> + * @dev: PCI device
> + * @speed: storage for link speed
> + * @width: storage for link width
> + *
> + * Calculate a PCI device's link bandwidth by querying for its link speed
> + * and width, multiplying them, and applying encoding overhead.
> + */
> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> +			   enum pcie_link_width *width)
> +{
> +	*speed = pcie_get_speed_cap(dev);
> +	*width = pcie_get_width_cap(dev);
> +
> +	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
> +		return 0;
> +
> +	return *width * PCIE_SPEED2MBS_ENC(*speed);
> +}
> +
>   /**
>    * pci_select_bars - Make BAR mask from the type of resource
>    * @dev: the PCI device for which BAR mask is made
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 66738f1050c0..2a50172b9803 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -261,8 +261,17 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>   	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>   	 "Unknown speed")
>   
> +/* PCIe speed to Mb/s with encoding overhead: 20% for gen2, ~1.5% for gen3 */
> +#define PCIE_SPEED2MBS_ENC(speed) \

Missing gen4.

> +	((speed) == PCIE_SPEED_8_0GT ? 7877 : \
> +	 (speed) == PCIE_SPEED_5_0GT ? 4000 : \
> +	 (speed) == PCIE_SPEED_2_5GT ? 2000 : \
> +	 0)
> +
>   enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>   enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> +			   enum pcie_link_width *width);
>   
>   /* Single Root I/O Virtualization */
>   struct pci_sriov {
> 
