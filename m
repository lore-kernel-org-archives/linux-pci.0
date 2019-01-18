Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD9C43387
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 15:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FF120883
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547824037;
	bh=5CXKIinzlw8kc1nTpMzk1oSN9I9YRoe736HXqDJadn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q+AjDX5qejRtCKGljF3jc5ybxoIx+x/R+dxULtoRQMZqAnwm0CbJBB3v/KAIZEJVe
	 twGYC0GHQQv3OudPUdrCKl5YSuvlumqypZWjpwp1T8YSeYVuqUEiKj8m7PLZhSYBtP
	 aNyke6sQx3E7VYnCT1OFK5kaCYLPRrVKzZ+hWh+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfARPHR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfARPHR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jan 2019 10:07:17 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FC12086D;
        Fri, 18 Jan 2019 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547824035;
        bh=5CXKIinzlw8kc1nTpMzk1oSN9I9YRoe736HXqDJadn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jr5qy2efYBQdj/youdsXvj2znl+cV1PF4wSJnaScc1ZhMpQFyQeeg1HXk9xI5xRu/
         endeuEIDa+siSxs+1TKW/pL7V1Mis4e+aTMR+iFMb5rme8xQThVQtagJGHU2uwTuJk
         +8TUXw90d+0n8in2WWzQRlS/UjAgIEVjyBUme4eg=
Date:   Fri, 18 Jan 2019 09:07:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: iproc: Add feature to set order mode
Message-ID: <20190118150713.GB25249@google.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
 <1547785403-32268-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547785403-32268-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 09:53:21AM +0530, Srinath Mannam wrote:
> Order mode in RX header of incoming pcie packets can be override to
> strict or loose order based on requirement.
> Sysfs entry is provided to set dynamic and default order modes of upstream
> traffic.

s/pcie/PCIe/

If this is two paragraphs, insert a blank line between.  If it's one
paragraph, reflow it so it reads like one paragraph.

Are you talking about the Relaxed Ordering bit in the TLP Attributes
field?  If so, please use the exact language used in the spec and
include a reference, e.g., to PCIe r4.0, sec 2.2.6.4, 2.4, etc.

I'm hesitant about a new sysfs file for this.  That automatically
creates a user-space dependency on this iProc feature.  Who would use
this file?

> To improve performance in few endpoints we required to modify the
> ordering attributes. Using this feature we can override order modes of RX
> packets at IPROC RC.
> 
> Ex:
> In PCIe based NVMe SSD endpoints data read/writes from disk is using
> Queue pairs (submit/completion). After completion of block read/write,
> EP writes completion command to completion queue to notify RC.
> So that all data transfers before completion command write are not
> required to strict order except completion command. It means previous all
> packets before completion command write to RC should be written to memory
> and acknowledged.

IIUC, if Enable Relaxed Ordering in the endpoint's Device Control
register is set, the device is permitted to set the Relaxed Ordering
bit in TLPs it initiates.  So I would think that if we set Enable
Relaxed Ordering correctly, the NVMe endpoint should be able to
use Relaxed Ordering for the data transfers and strict ordering (the
default) for the completion command.  What am I missing?

This sysfs file apparently affects the Root Port/Root Complex
behavior, not the Endpoint's behavior.  Does that mean iProc ignores
the Relaxed Ordering bit by default, and you're providing a knob that
makes it pay attention to it?  If that's the case, why wouldn't you
enable iProc support for Relaxed Ordering always, by default?

> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 128 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/controller/pcie-iproc.h |  16 +++++
>  2 files changed, 144 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index c20fd6b..13ce80f 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -57,6 +57,9 @@
>  #define PCIE_DL_ACTIVE_SHIFT		2
>  #define PCIE_DL_ACTIVE			BIT(PCIE_DL_ACTIVE_SHIFT)
>  
> +#define MPS_MRRS_CFG_MPS_SHIFT		0
> +#define MPS_MRRS_CFG_MRRS_SHIFT		16
> +
>  #define APB_ERR_EN_SHIFT		0
>  #define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
>  
> @@ -91,6 +94,14 @@
>  
>  #define IPROC_PCIE_REG_INVALID		0xffff
>  
> +#define RO_FIELD(window)		BIT((window) << 1)
> +#define RO_VALUE(window)		BIT(((window) << 1) + 1)
> +/* All Windows are allowed */
> +#define RO_ALL_WINDOW			0x33333333
> +/* Wait on All Windows */
> +#define RO_FIELD_ALL_WINDOW		0x11111111
> +#define DYNAMIC_ORDER_MODE		0x5
> +
>  /**
>   * iProc PCIe outbound mapping controller specific parameters
>   *
> @@ -295,6 +306,15 @@ enum iproc_pcie_reg {
>  	/* enable APB error for unsupported requests */
>  	IPROC_PCIE_APB_ERR_EN,
>  
> +	/* Ordering Mode configuration registers */
> +	IPROC_PCIE_ORDERING_CFG,
> +	IPROC_PCIE_MPS_MRRS_CFG,
> +	IPROC_PCIE_IMAP0_RO_CONTROL,
> +	IPROC_PCIE_IMAP1_RO_CONTROL,
> +	IPROC_PCIE_IMAP2_RO_CONTROL,
> +	IPROC_PCIE_IMAP3_RO_CONTROL,
> +	IPROC_PCIE_IMAP4_RO_CONTROL,
> +
>  	/* total number of core registers */
>  	IPROC_PCIE_MAX_NUM_REG,
>  };
> @@ -352,6 +372,13 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>  	[IPROC_PCIE_IMAP4]		= 0xe70,
>  	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
>  	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
> +	[IPROC_PCIE_ORDERING_CFG]	= 0x2000,
> +	[IPROC_PCIE_MPS_MRRS_CFG]	= 0x2008,
> +	[IPROC_PCIE_IMAP0_RO_CONTROL]	= 0x201c,
> +	[IPROC_PCIE_IMAP1_RO_CONTROL]	= 0x2020,
> +	[IPROC_PCIE_IMAP2_RO_CONTROL]	= 0x2024,
> +	[IPROC_PCIE_IMAP3_RO_CONTROL]	= 0x2028,
> +	[IPROC_PCIE_IMAP4_RO_CONTROL]	= 0x202c,
>  };
>  
>  /* iProc PCIe PAXC v1 registers */
> @@ -1401,6 +1428,97 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
>  	return 0;
>  }
>  
> +static
> +ssize_t order_mode_show(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buff)

Please format the same as the rest of the file, i.e.,

  static ssize_t order_mode_show(struct device *dev, ...

> +{
> +	struct pci_host_bridge *host = to_pci_host_bridge(dev);
> +	struct iproc_pcie *pcie = pci_host_bridge_priv(host);
> +
> +	return sprintf(buff, "Current PAXB order configuration %d\n",
> +		       pcie->order_cfg);
> +}
> +
> +static void pcie_iproc_set_dynamic_order(struct iproc_pcie *pcie)
> +{
> +	u32 val = 0, mps;
> +
> +	/* Set all IMAPs to relaxed order in dynamic order mode */
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_ORDERING_CFG,
> +			     DYNAMIC_ORDER_MODE);
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP0_RO_CONTROL,
> +			     RO_ALL_WINDOW);
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP1_RO_CONTROL,
> +			     RO_ALL_WINDOW);
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP2_RO_CONTROL,
> +			     RO_ALL_WINDOW);
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP3_RO_CONTROL,
> +			     RO_ALL_WINDOW);
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP4_RO_CONTROL,
> +			     RO_ALL_WINDOW);
> +
> +	/* PAXB MPS/MRRS settings configuration */
> +	iproc_pci_raw_config_read32(pcie, 0, IPROC_PCI_EXP_CAP + PCI_EXP_DEVCTL,
> +				    2, &mps);
> +	mps = (mps & PCI_EXP_DEVCTL_PAYLOAD) >> 5;
> +	/* set MRRS to match system MPS */
> +	val |= (mps << MPS_MRRS_CFG_MRRS_SHIFT);
> +	/* set MPS to 4096 bytes */
> +	val |= (0x5 << MPS_MRRS_CFG_MPS_SHIFT);
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_MPS_MRRS_CFG, val);
> +}
> +
> +static
> +ssize_t order_mode_store(struct device *dev,
> +			 struct device_attribute *attr,
> +			 const char *buf,
> +			 size_t count)

Fix formatting as above.

> +{
> +	struct pci_host_bridge *host = to_pci_host_bridge(dev);
> +	struct iproc_pcie *pcie = pci_host_bridge_priv(host);
> +	unsigned long  val, regval;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val > PAXB_ORDER_DEV_MEM_ONLY) {
> +		dev_err(dev, "Invalid Value passed %lu\n", val);
> +		dev_err(dev, "0: Everything in strict order\n");
> +		dev_err(dev, "1: Only IMAP2 in strict order\n");
> +		dev_err(dev, "2: Only device memory in strict order (MSI/MSIX)\n");
> +		return -EINVAL;
> +	}
> +
> +	if (val == pcie->order_cfg)
> +		return count;
> +
> +	switch (val) {
> +	case PAXB_ORDER_IMAP2_ONLY:
> +		pcie_iproc_set_dynamic_order(pcie);
> +		regval = RO_ALL_WINDOW;
> +		regval &= ~(RO_VALUE(0));
> +		/* Set IMAP2 to strict order */
> +		iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP2_RO_CONTROL, regval);
> +		dev_info(dev, "RO_IMAP2 set to %#lx\n", regval);
> +		break;
> +	case PAXB_ORDER_DEV_MEM_ONLY:
> +		pcie_iproc_set_dynamic_order(pcie);
> +		/* Set IMAP0 to strict order */
> +		iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP0_RO_CONTROL,
> +				     RO_FIELD_ALL_WINDOW);
> +		dev_info(dev, "RO_IMAP0 set to %#x\n", RO_FIELD_ALL_WINDOW);
> +		break;
> +	default:
> +		iproc_pcie_write_reg(pcie, IPROC_PCIE_ORDERING_CFG, 0);
> +		break;
> +	}
> +	pcie->order_cfg = val;
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(order_mode);
> +
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  {
>  	struct device *dev;
> @@ -1484,6 +1602,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  
>  	pci_bus_add_devices(host->bus);
>  
> +	if (pcie->type == IPROC_PCIE_PAXB_V2) {
> +		ret = device_create_file(&host->dev, &dev_attr_order_mode);
> +		if (ret < 0)
> +			goto err_power_off_phy;
> +	}
>  	return 0;
>  
>  err_power_off_phy:
> @@ -1496,6 +1619,11 @@ EXPORT_SYMBOL(iproc_pcie_setup);
>  
>  int iproc_pcie_remove(struct iproc_pcie *pcie)
>  {
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +
> +	if (pcie->type == IPROC_PCIE_PAXB_V2)
> +		device_remove_file(&host->dev, &dev_attr_order_mode);
> +
>  	pci_stop_root_bus(pcie->root_bus);
>  	pci_remove_root_bus(pcie->root_bus);
>  
> diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
> index 4f03ea5..6e100cd 100644
> --- a/drivers/pci/controller/pcie-iproc.h
> +++ b/drivers/pci/controller/pcie-iproc.h
> @@ -24,6 +24,18 @@ enum iproc_pcie_type {
>  };
>  
>  /**
> + * PAXB Dynamic ordering modes
> + * PAXB_ORDER_EVERYTHING: Everything in strict order
> + * PAXB_ORDER_IMAP2_ONLY: Only IMAP2 memory window strict order
> + * PAXB_ORDER_DEV_MEM_ONLY: Only device memory (MSI/MSIX) is strict order
> + */
> +enum paxb_order_cfg {
> +	PAXB_ORDER_EVERYTHING,
> +	PAXB_ORDER_IMAP2_ONLY,
> +	PAXB_ORDER_DEV_MEM_ONLY,
> +};
> +
> +/**
>   * iProc PCIe outbound mapping
>   * @axi_offset: offset from the AXI address to the internal address used by
>   * the iProc PCIe core
> @@ -74,6 +86,8 @@ struct iproc_msi;
>   * @ib: inbound mapping related parameters
>   * @ib_map: outbound mapping region related parameters
>   *
> + * @order_cfg: indicates current value of the order mode.
> + *
>   * @need_msi_steer: indicates additional configuration of the iProc PCIe
>   * controller is required to steer MSI writes to external interrupt controller
>   * @msi: MSI data
> @@ -102,6 +116,8 @@ struct iproc_pcie {
>  	struct iproc_pcie_ib ib;
>  	const struct iproc_pcie_ib_map *ib_map;
>  
> +	enum paxb_order_cfg order_cfg;
> +
>  	bool need_msi_steer;
>  	struct iproc_msi *msi;
>  };
> -- 
> 2.7.4
> 
