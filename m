Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755091AbeF3A5U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 20:57:20 -0400
Date: Fri, 29 Jun 2018 19:57:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
Message-ID: <20180630005718.GJ40928@bhelgaas-glaptop.roam.corp.google.com>
References: <20180614122146.62118-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180614122146.62118-1-christian.koenig@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 14, 2018 at 02:21:45PM +0200, Christian König wrote:
> Resize BARs after resume to the expected size again.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199959
> CC: stable@vger.kernel.org      # v4.15+

I applied both of these to pci/resource for v4.19, thanks!  It'd be nice to
have them in v4.18, but since it's not a regression and the problem has
been there since v4.15, I'm not sure I could justify it.

> ---
>  drivers/pci/pci.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bd6f156dc3cf..d4685090378b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1159,6 +1159,33 @@ static void pci_restore_config_space(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void pci_restore_rebar_state(struct pci_dev *pdev)
> +{
> +	unsigned int pos, nbars, i;
> +	u32 ctrl;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
> +		    PCI_REBAR_CTRL_NBAR_SHIFT;
> +
> +	for (i = 0; i < nbars; i++, pos += 8) {
> +		struct resource *res;
> +		int bar_idx, size;
> +
> +		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
> +		res = pdev->resource + bar_idx;
> +		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
> +		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
> +		ctrl |= size << 8;
> +		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> +	}
> +}
> +
>  /**
>   * pci_restore_state - Restore the saved state of a PCI device
>   * @dev: - PCI device that we're dealing with
> @@ -1174,6 +1201,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_pri_state(dev);
>  	pci_restore_ats_state(dev);
>  	pci_restore_vc_state(dev);
> +	pci_restore_rebar_state(dev);
>  
>  	pci_cleanup_aer_error_status_regs(dev);
>  
> -- 
> 2.14.1
> 
