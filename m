Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37280 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbEZX54 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 19:57:56 -0400
Received: by igbsb11 with SMTP id sb11so1765092igb.0
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 16:57:55 -0700 (PDT)
Date: Tue, 26 May 2015 18:57:51 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, mjg59@coreos.com, rwhite@pobox.com,
	alex.williamson@redhat.com
Subject: Re: [PATCH v4 1/3] PCI: Add pdev->has_secondary_link to mark pcie
 link
Message-ID: <20150526235751.GO32152@google.com>
References: <1432191904-16451-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432191904-16451-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 21, 2015 at 03:05:02PM +0800, Yijing Wang wrote:
> We assumed root port and downstream port always have
> pcie link, downstream port always has a upstream port.
> It's not always correct, In ATCA platform, system has
> unusual pcie topology like:
> 
> (root port)   (downstream port)   (upstream port)
> +-1c.0-[02-0a]----00.0-[03-0a]--+-00.0-[04]--
> |                               +-01.0-[05]-- (downstream port)
> |                               +-02.0-[06]--
> |                               +-03.0-[07]--
> |                               +-08.0-[08]--
> |                               +-09.0-[09]--
> |                               \-0a.0-[0a]--
> 
> In this pcie tree, downstream port 02:00.0 has no
> pcie link, and upstream port 03:00.0 has a pcie link.
> 
> This patch introduced a new assumption suggested by Bjorn.
> 1. Root port is always on the upstream end of a link.
> 2. The pcie hierarchy should alternate between links
> and internal switch logic, there should be no adjacent
> links or internal buses in pcie tree.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to pci/aspm for v4.2, thanks!

> ---
>  drivers/pci/probe.c |   16 ++++++++++++++++
>  include/linux/pci.h |    1 +
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a9c5e63..192c6b9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -973,6 +973,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  {
>  	int pos;
>  	u16 reg16;
> +	struct pci_dev *parent;
>  
>  	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
>  	if (!pos)
> @@ -982,6 +983,21 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	pdev->pcie_flags_reg = reg16;
>  	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
>  	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> +
> +	/*
> +	 * We assume root port is always on the upstream end of
> +	 * a link, and the pcie hierarchy should alternate
> +	 * between links and internal switch logic.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> +		pdev->has_secondary_link = 1;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM
> +			|| pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
> +		parent = pci_upstream_bridge(pdev);
> +		if (!parent->has_secondary_link)
> +			pdev->has_secondary_link = 1;
> +	}
>  }
>  
>  void set_pcie_hotplug_bridge(struct pci_dev *pdev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 50b7c7d..141fcc1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -355,6 +355,7 @@ struct pci_dev {
>  	unsigned int	broken_intx_masking:1;
>  	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
>  	unsigned int	irq_managed:1;
> +	unsigned int	has_secondary_link:1;
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  
> -- 
> 1.7.1
> 
