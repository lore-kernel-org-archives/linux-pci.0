Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932462AbeFGNVm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jun 2018 09:21:42 -0400
Date: Thu, 7 Jun 2018 08:21:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH NEXT 1/6] PCI/AER: Take mask into account while clearing
 error bits
Message-ID: <20180607132140.GA15137@bhelgaas-glaptop.roam.corp.google.com>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 07, 2018 at 02:00:29AM -0400, Oza Pawandeep wrote:
> PCIe ERR_NONFATAL and ERR_FATAL are uncorrectable errors, and clearing
> uncorrectable error bits should take error mask into account.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

If/when you repost these, please include a [0/6] cover letter with an
overview of the purpose of the series.

I assume these are for v4.19, so I'll look at them after the merge
window.

If they fix issues introduced during the v4.18 merge window, we may be
able to merge them during the v4.18 -rc cycle.  In this case, I would
need specifics about what exactly the problems are.

> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 377e576..8cbc62b 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -341,8 +341,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>   */
>  static void aer_error_resume(struct pci_dev *dev)
>  {
> -	int pos;
> -	u32 status, mask;
>  	u16 reg16;
>  
>  	/* Clean up Root device status */
> @@ -350,11 +348,7 @@ static void aer_error_resume(struct pci_dev *dev)
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
>  
>  	/* Clean AER Root Error Status */
> -	pos = dev->aer_cap;
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
> -	status &= ~mask; /* Clear corresponding nonfatal bits */
> -	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
> +	pci_cleanup_aer_uncorrect_error_status(dev);
>  }
>  
>  /**
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 946f3f6..309f3f5 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -50,13 +50,17 @@ EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
>  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>  {
>  	int pos;
> -	u32 status;
> +	u32 status, mask;
>  
>  	pos = dev->aer_cap;
>  	if (!pos)
>  		return -EIO;
>  
> +	/* Clean AER Root Error Status */
> +	pos = dev->aer_cap;
>  	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
> +	status &= ~mask; /* Clear corresponding nonfatal bits */
>  	if (status)
>  		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
>  
> -- 
> 2.7.4
> 
