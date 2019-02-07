Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3ACC282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A612175B
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549572782;
	bh=akTfZxeIHbgXqtmrpQWMvU2724HDWRVadTdBm5rkfQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OnbZF3Uew4cU4o6q+KeDTZZpfRQRojJjVQh1Ii208N1wocxRLP0hAEcZqIP4ghYTy
	 YznzuaM5VsNXGTeUvk6iONooEpdSxX/AARwE/1ZiYauHNdlPNcCHMt/uLKm6565kYO
	 sFdfPBUHKPHGe3hsz8KHPwRlxUOkw9GyQcAOAZPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBGUxB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfBGUxB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 15:53:01 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15EC22146E;
        Thu,  7 Feb 2019 20:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549572779;
        bh=akTfZxeIHbgXqtmrpQWMvU2724HDWRVadTdBm5rkfQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuspQwkrj74vyGFZgYB1LxuoQhS7he5/ZtKo5qtO2kNedYWJKZmQfJbj/s063mNre
         igWwzh/QVnM5oeLSdqyTpLTtsno+Bi7Mc8CiYDWXMxhAzXHVVoaH9L5RqIg6QVr/Fs
         R+5/mlP5zEfobsghJ5VQbaOSMO9Y4/HpWcEvtcgM=
Date:   Thu, 7 Feb 2019 14:52:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] PCI: keystone: Modify legacy_irq_handler to check
 the IRQ_STATUS of INTA/B/C/D
Message-ID: <20190207205257.GM7268@google.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207110924.30716-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the subject, "legacy_irq_handler" looks like it's supposed to be a
function name, but it's not.  Maybe something like:

  PCI: keystone: Check INTA/B/C/D IRQ_STATUS in ks_pcie_legacy_irq_handler()

On Thu, Feb 07, 2019 at 04:39:17PM +0530, Kishon Vijay Abraham I wrote:
> The legacy interrupt handler directly checks the IRQ_STATUS register
> corresponding to a interrupt line inorder to invoke generic_handle_irq.

s/The legacy interrupt handler/ks_pcie_handle_legacy_irq()/ ?
s/to a/to an/
s/inorder/in order/
s/generic_handle_irq/generic_handle_irq()/

> While this is okay for K2G platform which has separate interrupt line for
> each of the 4 legacy interrupts, AM654 which uses the same PCIe wrapper
> has a single interrupt line for all the legacy interrupts. So for AM654
> the interrupt handler won't be able to directly check the IRQ_STATUS
> register corresponding to the interrupt line.

s/platform which/platform, which/
s/separate interrupt line/separate interrupt lines/
s/AM654 which/AM654, which/
s/PCIe wrapper/PCIe wrapper,/
s/interrupt line for all/interrupt line shared by all/


> Also the legacy interrupt handler uses 'virq' obtained from
> irq_of_parse_and_map to find the correct interrupt line which raised the
> interrupt. There is no guarantee that virq assigned for contiguous hardware
> irq will be contiguous and the interrupt handler might end up checking
> the wrong IRQ_STATUS register.

s/irq_of_parse_and_map/irq_of_parse_and_map()
s/irq will/IRQ will/

> In order to overcome the above issues, read the IRQ_STATUS register of
> all the 4 legacy interrupts to determine which interrupt was raised.
> 
> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5286a480f76b..4cf9849d5a1d 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -214,16 +214,11 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>  {
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 pending;
>  	int virq;
>  
> -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
> -
> -	if (BIT(0) & pending) {
> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> -		generic_handle_irq(virq);
> -	}
> +	virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> +	dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> +	generic_handle_irq(virq);
>  
>  	/* EOI the INTx interrupt */
>  	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
> @@ -607,8 +602,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int irq_no;
> +	u32 reg;
>  
>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
>  
> @@ -618,7 +614,13 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	 * ack operation.
>  	 */
>  	chained_irq_enter(chip, desc);
> -	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> +	for (irq_no = 0; irq_no < PCI_NUM_INTX; irq_no++) {
> +		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(irq_no));
> +		if (!(reg & INTx_EN))
> +			continue;
> +		ks_pcie_handle_legacy_irq(ks_pcie, irq_no);

It's too bad that reading IRQ_STATUS and writing IRQ_EOI are now in
separate functions.  It's nice to have them together for code auditing
purposes.

Could maybe accumulate a mask of which INTx bits are set and call
ks_pcie_handle_legacy_irq() only once with that mask?  Of course, then
you'd need another loop in ks_pcie_handle_legacy_irq().

> +	}
> +
>  	chained_irq_exit(chip, desc);
>  }
>  
> -- 
> 2.17.1
> 
