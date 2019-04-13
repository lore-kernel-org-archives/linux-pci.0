Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19EDC282CE
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B3720848
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555164465;
	bh=Jzll/Ep+ESB04XVkUgP/Ai2lVI2yqMTtW4oROxJvqsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wl1KCVXWkKTFMdth202Trzmblr8Wkrvq6LAr0K6kgwaTyRJoqNa7T2wg7fVoPqNYH
	 Pd6GAQkM2Z3vyMfAKaimdngpmkIMW0YoHmNie9hpun/5twc8qVt1vtqJKA0EJyicTa
	 JfewbVVb1Q6sc6Y0HXc0NPzqSV7x+GMd5+S89fY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfDMOHj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfDMOHj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Apr 2019 10:07:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38DC420848;
        Sat, 13 Apr 2019 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555164457;
        bh=Jzll/Ep+ESB04XVkUgP/Ai2lVI2yqMTtW4oROxJvqsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDuyDxl8LSmVIfQrMKEApcNHdOEFRD0hj1aGZXzaMUEGDdKuyfTpMWaGmaHmdA3De
         5nP6vY1E8s/tCcIgdpLB0ivQA4kCdQK4+wjsyE3XnvIv32COFiyXIOnEaQBuZ0D5iq
         pcyUfXuG0w0ZSb0Rmf5pdn1e/2lGqrXMDQ6rX6rY=
Date:   Sat, 13 Apr 2019 09:07:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH v3 02/26] PCI: keystone: Cleanup error_irq configuration
Message-ID: <20190413140735.GD126710@google.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325093947.32633-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 03:09:23PM +0530, Kishon Vijay Abraham I wrote:
> pci-keystone driver uses irq_of_parse_and_map to get irq number of
> error_irq. Use platform_get_irq instead and move platform_get_irq()
> and request_irq() of error_irq from ks_pcie_add_pcie_port to ks_pcie_probe
> since error_irq is common to both RC mode and EP mode.

Part of my confusion here is that there's no hint about why
you need to use platform_get_irq() instead of irq_of_parse_and_map().

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 43 +++++++++--------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 07f55b355d75..e50f8773e768 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -98,8 +98,6 @@ struct keystone_pcie {
>  	struct irq_domain	*legacy_irq_domain;
>  	struct device_node	*np;
>  
> -	int error_irq;
> -
>  	/* Application register space */
>  	void __iomem		*va_app_base;	/* DT 1st resource */
>  	struct resource		app;
> @@ -743,12 +741,6 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>  	return ret;
>  }
>  
> -static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
> -{
> -	if (ks_pcie->error_irq > 0)
> -		ks_pcie_enable_error_irq(ks_pcie);
> -}
> -
>  /*
>   * When a PCI device does not exist during config cycles, keystone host gets a
>   * bus error instead of returning 0xffffffff. This handler always returns 0
> @@ -810,7 +802,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
>  
>  	ks_pcie_stop_link(pci);
>  	ks_pcie_setup_rc_app_regs(ks_pcie);
> -	ks_pcie_setup_interrupts(ks_pcie);
>  	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
>  			pci->dbi_base + PCI_IO_BASE);
>  
> @@ -854,23 +845,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	/*
> -	 * Index 0 is the platform interrupt for error interrupt
> -	 * from RC.  This is optional.
> -	 */
> -	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
> -	if (ks_pcie->error_irq <= 0)
> -		dev_info(dev, "no error IRQ defined\n");
> -	else {
> -		ret = request_irq(ks_pcie->error_irq, ks_pcie_err_irq_handler,
> -				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to request error IRQ %d\n",
> -				ks_pcie->error_irq);
> -			return ret;
> -		}
> -	}
> -
>  	pp->ops = &ks_pcie_host_ops;
>  	ret = ks_pcie_dw_host_init(ks_pcie);
>  	if (ret) {
> @@ -946,6 +920,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	u32 num_lanes;
>  	char name[10];
>  	int ret;
> +	int irq;
>  	int i;
>  
>  	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
> @@ -965,6 +940,20 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "missing IRQ resource: %d\n", irq);
> +		return irq;
> +	}
> +
> +	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
> +			  "ks-pcie-error-irq", ks_pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request error IRQ %d\n",
> +			irq);
> +		return ret;
> +	}
> +
>  	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
>  	if (ret)
>  		num_lanes = 1;
> @@ -1020,6 +1009,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_get_sync;
>  
> +	ks_pcie_enable_error_irq(ks_pcie);
> +
>  	return 0;
>  
>  err_get_sync:
> -- 
> 2.17.1
> 
