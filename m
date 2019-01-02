Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49972C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 10:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AD32073F
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 10:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RjFjLG7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfABKRG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:17:06 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:50170 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfABKRG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 05:17:06 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BC3D910C1225;
        Wed,  2 Jan 2019 02:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546424225; bh=wxJi1wjnP2O1RFdQq+JpmzFD++SKjdnAhXh8JrHpfGI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=RjFjLG7R7t3vznz6BFwX+9qOfwI2icWAK0P+9OqRwvi2t/HgNJFxejypzfWV2JwE7
         tlMHrrgJqVPH67ae9SC8ZeOG5aCAQ0XoqBeQvz9Hp+3QvANe8GKxLedG9H/qEQecuv
         OjX+7L8wvFzd6l6t43Epi04BYdDXSE7ghzPa3FYkYZ0II5SM6q2WLwQEsAWA9OofVQ
         iylCWERyEyT2uF5OTbKZBTfgXk1brWBFXf2ySNgxNMz3SApkFVNIY3RrR63d4+sShS
         a/4tY7R7ungxyZtsSKB+375y5u7yWibS8IrZN6xwRYfz1SMl5Lb91L/Tmibdat53Mq
         5dj5UI3OuXXWg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8D4EC34A2;
        Wed,  2 Jan 2019 02:17:05 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 02:17:05 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 11:17:03 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 11:17:03 +0100
Subject: Re: [PATCH 07/10] PCI: dwc: Add support to use non default
 msi_irq_chip
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181219124207.13479-1-kishon@ti.com>
 <20181219124207.13479-8-kishon@ti.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <d84eb74c-4006-b4ce-19b3-9f2e0f33e5a8@synopsys.com>
Date:   Wed, 2 Jan 2019 10:12:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219124207.13479-8-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 19/12/2018 12:42, Kishon Vijay Abraham I wrote:
> Platforms using Designware IP uses dw_pci_msi_bottom_irq_chip for
> configuring the MSI controller logic within the Designware IP. However
> certain platforms like Keystone (K2G) which uses Desingware IP has
> it's own MSI controller logic. For handling such platforms,
> the irqchip ops uses msi_irq_ack, msi_set_irq, msi_clear_irq callback
> functions.

Keystone also uses get_msi_addr and get_msi_data callbacks, do you want to
update the description to add those references as well?

> 
> Add support to use different msi_irq_chip with default as
> dw_pci_msi_bottom_irq_chip. This is in preparation to get rid off
> msi_irq_ack, msi_set_irq, msi_clear_irq and other Keystone specific
> dw_pcie_host_ops.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0fa9e8fdce66..db21bd11f153 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -245,7 +245,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>  
>  	for (i = 0; i < nr_irqs; i++)
>  		irq_domain_set_info(domain, virq + i, bit + i,
> -				    &dw_pci_msi_bottom_irq_chip,
> +				    pp->msi_irq_chip,
>  				    pp, handle_edge_irq,
>  				    NULL, NULL);
>  
> @@ -277,6 +277,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
>  
> +	if (!pp->msi_irq_chip)
> +		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> +
>  	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
>  					       &dw_pcie_msi_domain_ops, pp);
>  	if (!pp->irq_domain) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0989d880ac46..0873ee4084aa 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -168,6 +168,7 @@ struct pcie_port {
>  	struct irq_domain	*irq_domain;
>  	struct irq_domain	*msi_domain;
>  	dma_addr_t		msi_data;
> +	struct irq_chip		*msi_irq_chip;
>  	u32			num_vectors;
>  	u32			irq_status[MAX_MSI_CTRLS];
>  	raw_spinlock_t		lock;
> 

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo
