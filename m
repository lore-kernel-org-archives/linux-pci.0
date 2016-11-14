Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933166AbcKNU7y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 15:59:54 -0500
Date: Mon, 14 Nov 2016 14:59:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: Make pci_std_enable_acs() non-static
Message-ID: <20161114205950.GA9868@bhelgaas-glaptop.roam.corp.google.com>
References: <20161026175156.23495.12980.stgit@gimli.home>
 <20161026180116.23495.77322.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161026180116.23495.77322.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 26, 2016 at 12:01:16PM -0600, Alex Williamson wrote:
> For use by quirks.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/pci.c   |    2 +-
>  include/linux/pci.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aab9d51..b901ee7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2728,7 +2728,7 @@ void pci_request_acs(void)
>   * pci_std_enable_acs - enable ACS on devices using standard ACS capabilites
>   * @dev: the PCI device
>   */
> -static void pci_std_enable_acs(struct pci_dev *dev)
> +void pci_std_enable_acs(struct pci_dev *dev)
>  {
>  	int pos;
>  	u16 cap;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ab8359..c3248d5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1900,6 +1900,7 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> +void pci_std_enable_acs(struct pci_dev *dev);

I think putting this in drivers/pci/pci.h would be sufficient for what
you need, wouldn't it?  Same for pcie_get_link() and pcie_retrain_link().

>  #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
>  #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
> 
