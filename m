Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:61976 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaDCWgN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 18:36:13 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so196250igb.15
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 15:36:13 -0700 (PDT)
Date: Thu, 3 Apr 2014 16:36:09 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: linux-pci@vger.kernel.org, mohit.kumar@st.com, jg1.han@samsung.com
Subject: Re: [PATCH] PCI: designware: Remove unnecessary use of 'conf_lock'
 spinlock
Message-ID: <20140403223609.GC23545@google.com>
References: <1392932494-21630-1-git-send-email-amurray@embedded-bits.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392932494-21630-1-git-send-email-amurray@embedded-bits.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 09:41:34PM +0000, Andrew Murray wrote:
> Serialization of configuration accesses is provided by 'pci_lock' in
> drivers/pci/access.c thus making the driver's 'conf_lock' superfluous.
> 
> Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>

Applied with Jingoo and Richard's acks to my pci/pending branch for v3.16.
After v3.15-rc1, I'll sort it into pci/host-mvebu as usual.  Thanks!

> ---
>  drivers/pci/host/pci-exynos.c      | 1 -
>  drivers/pci/host/pci-imx6.c        | 1 -
>  drivers/pci/host/pcie-designware.c | 6 ------
>  drivers/pci/host/pcie-designware.h | 1 -
>  4 files changed, 9 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 3de6bfb..32c6d56 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -546,7 +546,6 @@ static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
>  	pp->root_bus_nr = -1;
>  	pp->ops = &exynos_pcie_host_ops;
>  
> -	spin_lock_init(&pp->conf_lock);
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to initialize host\n");
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index e8663a8..77588f1 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -480,7 +480,6 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
>  	pp->root_bus_nr = -1;
>  	pp->ops = &imx6_pcie_host_ops;
>  
> -	spin_lock_init(&pp->conf_lock);
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to initialize host\n");
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 17ce88f..b25adb8 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -640,7 +640,6 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  			int size, u32 *val)
>  {
>  	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> -	unsigned long flags;
>  	int ret;
>  
>  	if (!pp) {
> @@ -653,13 +652,11 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> -	spin_lock_irqsave(&pp->conf_lock, flags);
>  	if (bus->number != pp->root_bus_nr)
>  		ret = dw_pcie_rd_other_conf(pp, bus, devfn,
>  						where, size, val);
>  	else
>  		ret = dw_pcie_rd_own_conf(pp, where, size, val);
> -	spin_unlock_irqrestore(&pp->conf_lock, flags);
>  
>  	return ret;
>  }
> @@ -668,7 +665,6 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  			int where, int size, u32 val)
>  {
>  	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> -	unsigned long flags;
>  	int ret;
>  
>  	if (!pp) {
> @@ -679,13 +675,11 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> -	spin_lock_irqsave(&pp->conf_lock, flags);
>  	if (bus->number != pp->root_bus_nr)
>  		ret = dw_pcie_wr_other_conf(pp, bus, devfn,
>  						where, size, val);
>  	else
>  		ret = dw_pcie_wr_own_conf(pp, where, size, val);
> -	spin_unlock_irqrestore(&pp->conf_lock, flags);
>  
>  	return ret;
>  }
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index 3063b35..a10747d 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -41,7 +41,6 @@ struct pcie_port {
>  	void __iomem		*va_cfg1_base;
>  	u64			io_base;
>  	u64			mem_base;
> -	spinlock_t		conf_lock;
>  	struct resource		cfg;
>  	struct resource		io;
>  	struct resource		mem;
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
