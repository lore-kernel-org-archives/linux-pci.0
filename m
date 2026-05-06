Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015D7080D;
	Wed,  6 May 2026 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034995; cv=none; b=gQrJUXUmJ55oHO3ubRwU09JcBXMicP+74RtahCZcj9E7EC1VDtjgdHx+ZQwqHDmeZyXSjouy0lm6gJbCYH3e98WyXyTBp9ZUXG3la6mEOeFNFS63XrMvidHLvQ1dVv93ccqzLV8fkfM49jiTVWp3hHHiKAlNGaxU0w1zNRWpyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034995; c=relaxed/simple;
	bh=JNW9yjxTwYLk3ZAiuaQzkdjZTR6wNkFJG5hnOuV0meY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEl7lywdMufcZlMrgy8R0ff7hXXhuImDQPxmazJx5P6VWOIUhLb9LWl078qSI/OB5xCm3oMsCO0aE5WOkZgNxgsAvzDZ+Co6JRRL0hrlL7g6KrxkT6z91rxKFOPhGHHKN1qQTIdYJLdrB+iKDN4cD5dKQxFqdkDxFoTqbm0aQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdoXtTeY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdoXtTeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45509C2BCB9;
	Wed,  6 May 2026 02:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778034994;
	bh=JNW9yjxTwYLk3ZAiuaQzkdjZTR6wNkFJG5hnOuV0meY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KdoXtTeY9+YvMzCJd4vIVWletUNOsZfLqdPYvybwpuB5IkLnOsGcRI2D7MsD/5K1I
	 u4zGVMquEfentnxZc/2Y+vUOlPvBHf7/5lwPp2c5XRGjgxuIC0O32QCy8uLRY9Al7z
	 BC6/Bm2oVvoIdzIMH8ViuCKBiuuNVfPvj1KJYqtEP47OGFAc/4ZVUby3RYdobN8gQP
	 3XpiKIboaocM5hpi9vv031HFi0RsDYCcfHgHxmKBrZ03ZILba2jGiGVjIY3wN98Hoa
	 gmIqmKB+rbTHszrOxGFcYqWuNSt59yESZBBkwlPMgW54uXAYIStjlssNyrn1CBAiwQ
	 +CYl+9JLhAXQw==
Date: Wed, 6 May 2026 10:36:30 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: pawell@cadence.com
Cc: Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdnsp: Add support for device-only configuration
Message-ID: <afqpLr/BMMuN0pTg@nchen-desktop>
References: <20260505-device_only_branch_v2-v2-1-98cc19fbd02a@cadence.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505-device_only_branch_v2-v2-1-98cc19fbd02a@cadence.com>

On 26-05-05 12:02:56, Pawel Laszczak via B4 Relay wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> This patch introduces support for operating the Cadence USBSSP (cdnsp)
> controller in a peripheral-only mode, bypassing the Dual-Role Device (DRD)
> logic.

I still debate peripheral-only not equals to no-drd, see below.

> 
> The change in BAR indexing (from BAR 2 to BAR 1) is a direct
> consequence of switching from 64-bit to 32-bit addressing in the
> Peripheral-only configuration.
> 
> Tested on PCI platform with Device-only configuration. Platform-side
> changes are included to support the PCI glue layer's property injection.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci_ids.h
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
> This is a resubmission of the previous patch, now based on the restored
> commit e4d7362dc9cd ("usb: cdns3: Add USBSSP platform driver support").
> 
> Since the "usb: cdns3: Add USBSSP platform driver support" patch  was
> reverted and then re-added, this version (v2) ensures compatibility
> with the latest tree state.
> ---
> v2:
>   - Changed otg_irq to be optionali.
>   - Added cdns->no_drd check in cdns_power_is_lost.
>   - Added cdns->no_drd check in cdns_get_id.
> ---
>  drivers/usb/cdns3/cdns3-plat.c | 23 ++++++++++++-----------
>  drivers/usb/cdns3/cdnsp-pci.c  | 33 ++++++++++++++++++++++++---------
>  drivers/usb/cdns3/core.c       |  3 ++-
>  drivers/usb/cdns3/core.h       |  3 +++
>  drivers/usb/cdns3/drd.c        | 22 ++++++++++++++++++++--
>  include/linux/pci_ids.h        |  1 +
>  6 files changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> index 3fe3109a3688..1af19360410e 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -113,21 +113,22 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>  
>  	cdns->dev_regs	= regs;
>  
> -	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
> -	if (cdns->otg_irq < 0)
> -		return dev_err_probe(dev, cdns->otg_irq,
> -				     "Failed to get otg IRQ\n");
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
> -	if (!res) {
> -		dev_err(dev, "couldn't get otg resource\n");
> -		return -ENXIO;
> +	cdns->otg_irq = platform_get_irq_byname_optional(pdev, "otg");
> +
> +	if (cdns->otg_irq < 0) {
> +		dev_dbg(dev, "Device-only mode: DRD support disabled\n");

Why "Device-only", just no DRD support?

> +		cdns->no_drd = 1;
> +	} else {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
> +		if (!res) {
> +			dev_err(dev, "couldn't get otg resource\n");
> +			return -ENXIO;
> +		}
> +		cdns->otg_res = *res;
>  	}
>  
>  	cdns->phyrst_a_enable = device_property_read_bool(dev, "cdns,phyrst-a-enable");
>  
> -	cdns->otg_res = *res;
> -
>  	cdns->wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
>  	if (cdns->wakeup_irq == -EPROBE_DEFER)
>  		return cdns->wakeup_irq;
> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
> index 432007cfe695..28e16b094525 100644
> --- a/drivers/usb/cdns3/cdnsp-pci.c
> +++ b/drivers/usb/cdns3/cdnsp-pci.c
> @@ -29,10 +29,15 @@ struct cdnsp_wrap {
>  #define RES_HOST_ID		3
>  #define RES_DEV_ID		4
>  #define RES_DRD_ID		5
> -
> +/* DRD PCI configuration - 64-bit addressing */
> +/* First PCI function */
>  #define PCI_BAR_HOST		0
> -#define PCI_BAR_OTG		0
>  #define PCI_BAR_DEV		2
> +/* Second PCI function */
> +#define PCI_BAR_OTG		0
> +/* Device only PCI configuration - 32-bit addressing */
> +/* First PCI function */
> +#define PCI_BAR_ONLY_DEV	1
>  
>  #define PCI_DEV_FN_HOST_DEVICE	0
>  #define PCI_DEV_FN_OTG		1
> @@ -65,6 +70,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
>  	struct cdnsp_wrap *wrap;
>  	struct resource *res;
>  	struct pci_dev *func;
> +	bool no_drd = false;
>  	int ret = 0;
>  
>  	/*
> @@ -75,11 +81,14 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
>  		    pdev->devfn != PCI_DEV_FN_OTG))
>  		return -EINVAL;
>  
> +	if (pdev->device == PCI_DEVICE_ID_CDNS_UDC_USBSSP)
> +		no_drd = true;
> +
>  	func = cdnsp_get_second_fun(pdev);
> -	if (!func)
> +	if (!func && !no_drd)
>  		return -EINVAL;
>  
> -	if (func->class == PCI_CLASS_SERIAL_USB_XHCI ||
> +	if ((func && func->class == PCI_CLASS_SERIAL_USB_XHCI) ||
>  	    pdev->class == PCI_CLASS_SERIAL_USB_XHCI) {
>  		ret = -EINVAL;
>  		goto put_pci;
> @@ -93,7 +102,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
>  
>  	pci_set_master(pdev);
>  
> -	if (pci_is_enabled(func)) {
> +	if (func && pci_is_enabled(func)) {
>  		wrap = pci_get_drvdata(func);
>  	} else {
>  		wrap = kzalloc_obj(*wrap);
> @@ -106,10 +115,12 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
>  	res = wrap->dev_res;
>  
>  	if (pdev->devfn == PCI_DEV_FN_HOST_DEVICE) {
> +		int bar_dev = no_drd ? PCI_BAR_ONLY_DEV : PCI_BAR_DEV;
> +
>  		/* Function 0: host(BAR_0) + device(BAR_2). */
>  		dev_dbg(&pdev->dev, "Initialize Device resources\n");
> -		res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
> -		res[RES_DEV_ID].end = pci_resource_end(pdev, PCI_BAR_DEV);
> +		res[RES_DEV_ID].start = pci_resource_start(pdev, bar_dev);
> +		res[RES_DEV_ID].end = pci_resource_end(pdev, bar_dev);
>  		res[RES_DEV_ID].name = "dev";
>  		res[RES_DEV_ID].flags = IORESOURCE_MEM;
>  		dev_dbg(&pdev->dev, "USBSSP-DEV physical base addr: %pa\n",
> @@ -145,7 +156,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
>  		wrap->dev_res[RES_IRQ_OTG_ID].flags = IORESOURCE_IRQ;
>  	}
>  
> -	if (pci_is_enabled(func)) {
> +	if (no_drd || pci_is_enabled(func)) {
>  		/* set up platform device info */
>  		pdata.override_apb_timeout = CHICKEN_APB_TIMEOUT_VALUE;
>  		memset(&plat_info, 0, sizeof(plat_info));
> @@ -185,13 +196,17 @@ static void cdnsp_pci_remove(struct pci_dev *pdev)
>  	if (wrap->devfn == pdev->devfn)
>  		platform_device_unregister(wrap->plat_dev);
>  
> -	if (!pci_is_enabled(func))
> +	if (!func || !pci_is_enabled(func))
>  		kfree(wrap);
>  
>  	pci_dev_put(func);
>  }
>  
>  static const struct pci_device_id cdnsp_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC_USBSSP),
> +	  .class = PCI_CLASS_SERIAL_USB_DEVICE },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC_USBSSP),
> +	  .class = PCI_CLASS_SERIAL_USB_CDNS },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSSP),
>  	  .class = PCI_CLASS_SERIAL_USB_DEVICE },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSSP),
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 6a8d1fefbc0d..504bdf13ea80 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -70,7 +70,8 @@ static void cdns_role_stop(struct cdns *cdns)
>  static void cdns_exit_roles(struct cdns *cdns)
>  {
>  	cdns_role_stop(cdns);
> -	cdns_drd_exit(cdns);
> +	if (!cdns->no_drd)
> +		cdns_drd_exit(cdns);
>  }
>  
>  /**
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index bca973b999a4..ef3f50169246 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -84,6 +84,8 @@ struct cdns3_platform_data {
>   *                        value in CHICKEN_BITS_3 will be preserved.
>   * @gadget_init: pointer to gadget initialization function
>   * @host_init: pointer to host initialization function
> + * @no_drd: DRD register block is inaccessible - driver handles only
> + *          device mode.
>   */
>  struct cdns {
>  	struct device			*dev;
> @@ -124,6 +126,7 @@ struct cdns {
>  	u32                             override_apb_timeout;
>  	int (*gadget_init)(struct cdns *cdns);
>  	int (*host_init)(struct cdns *cdns);
> +	bool				no_drd;
>  };
>  
>  int cdns_hw_role_switch(struct cdns *cdns);
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 84fb38a5723a..8e8414c2e994 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -87,6 +87,9 @@ int cdns_get_id(struct cdns *cdns)
>  {
>  	int id;
>  
> +	if (cdns->no_drd)
> +		return 0;
> +
>  	id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
>  	dev_dbg(cdns->dev, "OTG ID: %d", id);
>  
> @@ -107,7 +110,7 @@ void cdns_clear_vbus(struct cdns *cdns)
>  {
>  	u32 reg;
>  
> -	if (cdns->version != CDNSP_CONTROLLER_V2)
> +	if (cdns->version != CDNSP_CONTROLLER_V2 || cdns->no_drd)
>  		return;
>  
>  	reg = readl(&cdns->otg_cdnsp_regs->override);
> @@ -120,7 +123,7 @@ void cdns_set_vbus(struct cdns *cdns)
>  {
>  	u32 reg;
>  
> -	if (cdns->version != CDNSP_CONTROLLER_V2)
> +	if (cdns->version != CDNSP_CONTROLLER_V2 || cdns->no_drd)
>  		return;
>  
>  	reg = readl(&cdns->otg_cdnsp_regs->override);
> @@ -234,6 +237,9 @@ int cdns_drd_gadget_on(struct cdns *cdns)
>  	u32 ready_bit;
>  	int ret, val;
>  
> +	if (cdns->no_drd)
> +		return 0;
> +
>  	/* switch OTG core */
>  	writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
>  
> @@ -265,6 +271,9 @@ void cdns_drd_gadget_off(struct cdns *cdns)
>  {
>  	u32 val;
>  
> +	if (cdns->no_drd)
> +		return;
> +
>  	/*
>  	 * Driver should wait at least 10us after disabling Device
>  	 * before turning-off Device (DEV_BUS_DROP).
> @@ -392,6 +401,12 @@ int cdns_drd_init(struct cdns *cdns)
>  	u32 state, reg;
>  	int ret;
>  
> +	if (cdns->no_drd) {
> +		cdns->version  = CDNSP_CONTROLLER_V2;
> +		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
> +		return 0;
> +	}
> +

I still concern this, CIX SoC has host-only configuration, and it
needs to use cdns3 driver for low power purpose, eg set D3 mode
for controller.

>  	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
> @@ -500,6 +515,9 @@ int cdns_drd_exit(struct cdns *cdns)
>  /* Indicate the cdns3 core was power lost before */
>  bool cdns_power_is_lost(struct cdns *cdns)
>  {
> +	if (cdns->no_drd)
> +		return false;
> +

You may not just return false, would you please find one host and one device
register to compare, we need this feature.

Peter

>  	if (cdns->version == CDNS3_CONTROLLER_V0) {
>  		if (!(readl(&cdns->otg_v0_regs->simulate) & BIT(0)))
>  			return true;
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24cb42f66e4b..a6b9b6f6d8cc 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2424,6 +2424,7 @@
>  #define PCI_DEVICE_ID_CDNS_USBSS	0x0100
>  #define PCI_DEVICE_ID_CDNS_USB		0x0120
>  #define PCI_DEVICE_ID_CDNS_USBSSP	0x0200
> +#define PCI_DEVICE_ID_CDNS_UDC_USBSSP	0x0400
>  
>  #define PCI_VENDOR_ID_ARECA		0x17d3
>  #define PCI_DEVICE_ID_ARECA_1110	0x1110
> 
> ---
> base-commit: 9d0d467c3572e93c5faa2e5906a8bbcd70b24efd
> change-id: 20260505-device_only_branch_v2-53692f329752
> 
> Best regards,
> --  
> Pawel Laszczak <pawell@cadence.com>
> 
> 

-- 

Best regards,
Peter
