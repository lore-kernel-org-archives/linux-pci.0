Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965017AbeEJQeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 12:34:00 -0400
Date: Thu, 10 May 2018 11:33:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ariel Elior <ariel.elior@cavium.com>
Cc: linux-pci@vger.kernel.org, everest-linux-l2@cavium.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH v6 5/5] PCI: Remove unused pcie_get_minimum_link()
Message-ID: <20180510163357.GB190385@bhelgaas-glaptop.roam.corp.google.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152537764322.62474.552711932384023140.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152537764322.62474.552711932384023140.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 03:00:43PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> In some cases pcie_get_minimum_link() returned misleading information
> because it found the slowest link and the narrowest link without
> considering the total bandwidth of the link.
> 
> For example, consider a path with these two links:
> 
>   - 16.0 GT/s  x1 link  (16.0 * 10^9 * 128 / 130) *  1 / 8 = 1969 MB/s
>   -  2.5 GT/s x16 link  ( 2.5 * 10^9 *   8 /  10) * 16 / 8 = 4000 MB/s
> 
> The available bandwidth of the path is limited by the 16 GT/s link to about
> 1969 MB/s, but pcie_get_minimum_link() returned 2.5 GT/s x1, which
> corresponds to only 250 MB/s.
> 
> Callers should use pcie_print_link_status() instead, or
> pcie_bandwidth_available() if they need more detailed information.
> 
> Remove pcie_get_minimum_link() since there are no callers left.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Hi Jeff,

I got your note that you applied this to dev-queue.  I assume that
means you also applied the preceding patches that removed all the
users.  I got a note about ixgbe, but not the others, so I'm just
double-checking.

> ---
>  drivers/pci/pci.c   |   43 -------------------------------------------
>  include/linux/pci.h |    2 --
>  2 files changed, 45 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e597655a5643..4bafa817c40a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5069,49 +5069,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>  }
>  EXPORT_SYMBOL(pcie_set_mps);
>  
> -/**
> - * pcie_get_minimum_link - determine minimum link settings of a PCI device
> - * @dev: PCI device to query
> - * @speed: storage for minimum speed
> - * @width: storage for minimum width
> - *
> - * This function will walk up the PCI device chain and determine the minimum
> - * link width and speed of the device.
> - */
> -int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
> -			  enum pcie_link_width *width)
> -{
> -	int ret;
> -
> -	*speed = PCI_SPEED_UNKNOWN;
> -	*width = PCIE_LNK_WIDTH_UNKNOWN;
> -
> -	while (dev) {
> -		u16 lnksta;
> -		enum pci_bus_speed next_speed;
> -		enum pcie_link_width next_width;
> -
> -		ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> -		if (ret)
> -			return ret;
> -
> -		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
> -		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
> -			PCI_EXP_LNKSTA_NLW_SHIFT;
> -
> -		if (next_speed < *speed)
> -			*speed = next_speed;
> -
> -		if (next_width < *width)
> -			*width = next_width;
> -
> -		dev = dev->bus->self;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(pcie_get_minimum_link);
> -
>  /**
>   * pcie_bandwidth_available - determine minimum link settings of a PCIe
>   *			      device and its bandwidth limitation
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 73178a2fcee0..230615620a4a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1079,8 +1079,6 @@ int pcie_get_readrq(struct pci_dev *dev);
>  int pcie_set_readrq(struct pci_dev *dev, int rq);
>  int pcie_get_mps(struct pci_dev *dev);
>  int pcie_set_mps(struct pci_dev *dev, int mps);
> -int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
> -			  enum pcie_link_width *width);
>  u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width);
> 
