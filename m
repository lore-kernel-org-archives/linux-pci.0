Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:53641 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3IFW7F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 18:59:05 -0400
Received: by mail-yh0-f44.google.com with SMTP id f64so398906yha.31
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 15:59:03 -0700 (PDT)
Date: Fri, 6 Sep 2013 16:59:00 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] PCI: remove obsolete "is_pcie" from pci_dev structure
Message-ID: <20130906225900.GB12956@google.com>
References: <1378173729-20700-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378173729-20700-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 03, 2013 at 10:02:09AM +0800, Yijing Wang wrote:
> No one uses "is_pcie" now, remove this obsolete member.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to my pci/misc branch for v3.13.  Thanks!

> ---
>  drivers/pci/probe.c |    1 -
>  include/linux/pci.h |    2 --
>  2 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index eeb50bd..70f6e75 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -983,7 +983,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
>  	if (!pos)
>  		return;
> -	pdev->is_pcie = 1;
>  	pdev->pcie_cap = pos;
>  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>  	pdev->pcie_flags_reg = reg16;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 186540d..be06125 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -317,8 +317,6 @@ struct pci_dev {
>  	unsigned int	msix_enabled:1;
>  	unsigned int	ari_enabled:1;	/* ARI forwarding */
>  	unsigned int	is_managed:1;
> -	unsigned int	is_pcie:1;	/* Obsolete. Will be removed.
> -					   Use pci_is_pcie() instead */
>  	unsigned int    needs_freset:1; /* Dev requires fundamental reset */
>  	unsigned int	state_saved:1;
>  	unsigned int	is_physfn:1;
> -- 
> 1.7.1
> 
> 
