Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44110 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbcCLABO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 19:01:14 -0500
Date: Fri, 11 Mar 2016 18:01:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/6] PCI: No need to set d3cold_allowed to PCIe ports
Message-ID: <20160312000111.GJ4725@localhost>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
 <1456750566-116248-2-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456750566-116248-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 02:56:01PM +0200, Mika Westerberg wrote:
> PCIe ports are already skipped by the PCI core so they are never moved to
> D3 (or D3cold) anyway. No need to set the field.

A pointer to where the PCI core skips these ports would be helpful.
pci_pm_runtime_suspend() is the only place I see that tests d3cold_allowed,
and I don't see that it checks anything about PCIe ports.

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index be35da2e105e..6c6bb03392ea 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -134,11 +134,6 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		return status;
>  
>  	pci_save_state(dev);
> -	/*
> -	 * D3cold may not work properly on some PCIe port, so disable
> -	 * it by default.
> -	 */
> -	dev->d3cold_allowed = false;
>  	return 0;
>  }
>  
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
