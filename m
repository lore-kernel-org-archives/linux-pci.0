Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43857 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754388AbeCGR6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 12:58:23 -0500
Received: by mail-qt0-f193.google.com with SMTP id d26so3659879qtk.10
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2018 09:58:22 -0800 (PST)
Subject: Re: [PATCH 2/9] PCI: iproc: remove dependency on ARM specific struct
 pci_sys_data
To: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
References: <20180307154243.3205-1-robh@kernel.org>
 <20180307154243.3205-3-robh@kernel.org>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <e46bd6df-ca7c-91df-39e0-bb4de5ea161f@broadcom.com>
Date: Wed, 7 Mar 2018 09:58:13 -0800
MIME-Version: 1.0
In-Reply-To: <20180307154243.3205-3-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks fine.


On 18-03-07 07:42 AM, Rob Herring wrote:
> The iproc driver is using ARM's struct pci_sys_data simply to store a
> private data pointer. This is completely unnecessary, so store the
> private data directly in bus->sysdata as is done on arm64.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/pci/host/pcie-iproc-bcma.c |  3 +--
>   drivers/pci/host/pcie-iproc.c      | 19 ++-----------------
>   drivers/pci/host/pcie-iproc.h      |  4 ----
>   3 files changed, 3 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
> index 603c83429cb3..aa55b064f64d 100644
> --- a/drivers/pci/host/pcie-iproc-bcma.c
> +++ b/drivers/pci/host/pcie-iproc-bcma.c
> @@ -25,8 +25,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);
>   
>   static int iproc_pcie_bcma_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>   {
> -	struct pci_sys_data *sys = dev->sysdata;
> -	struct iproc_pcie *pcie = sys->private_data;
> +	struct iproc_pcie *pcie = dev->sysdata;
>   	struct bcma_device *bdev = container_of(pcie->dev, struct bcma_device, dev);
>   
>   	return bcma_core_irq(bdev, 5);
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index cbb095481cdc..3c76c5fa4f32 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -377,14 +377,7 @@ static const u16 iproc_pcie_reg_paxc_v2[] = {
>   
>   static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
>   {
> -	struct iproc_pcie *pcie;
> -#ifdef CONFIG_ARM
> -	struct pci_sys_data *sys = bus->sysdata;
> -
> -	pcie = sys->private_data;
> -#else
> -	pcie = bus->sysdata;
> -#endif
> +	struct iproc_pcie *pcie = bus->sysdata;
>   	return pcie;
>   }
>   
> @@ -1331,7 +1324,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>   {
>   	struct device *dev;
>   	int ret;
> -	void *sysdata;
>   	struct pci_bus *child;
>   	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>   
> @@ -1376,13 +1368,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>   			goto err_power_off_phy;
>   	}
>   
> -#ifdef CONFIG_ARM
> -	pcie->sysdata.private_data = pcie;
> -	sysdata = &pcie->sysdata;
> -#else
> -	sysdata = pcie;
> -#endif
> -
>   	ret = iproc_pcie_check_link(pcie);
>   	if (ret) {
>   		dev_err(dev, "no PCIe EP device detected\n");
> @@ -1399,7 +1384,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>   	host->busnr = 0;
>   	host->dev.parent = dev;
>   	host->ops = &iproc_pcie_ops;
> -	host->sysdata = sysdata;
> +	host->sysdata = pcie;
>   	host->map_irq = pcie->map_irq;
>   	host->swizzle_irq = pci_common_swizzle;
>   
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index d55f56a186cd..814b600b383a 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -54,7 +54,6 @@ struct iproc_msi;
>    * @reg_offsets: register offsets
>    * @base: PCIe host controller I/O register base
>    * @base_addr: PCIe host controller register base physical address
> - * @sysdata: Per PCI controller data (ARM-specific)
>    * @root_bus: pointer to root bus
>    * @phy: optional PHY device that controls the Serdes
>    * @map_irq: function callback to map interrupts
> @@ -80,9 +79,6 @@ struct iproc_pcie {
>   	u16 *reg_offsets;
>   	void __iomem *base;
>   	phys_addr_t base_addr;
> -#ifdef CONFIG_ARM
> -	struct pci_sys_data sysdata;
> -#endif
>   	struct resource mem;
>   	struct pci_bus *root_bus;
>   	struct phy *phy;
