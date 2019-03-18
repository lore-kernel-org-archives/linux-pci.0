Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D141C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A692063F
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WY3dJWeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCRKDr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:03:47 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:38544 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCRKDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 06:03:47 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 82F0A24E2E0F;
        Mon, 18 Mar 2019 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552903426; bh=OwQOkRbBOR8voSThbnyUFP4XiZJPg6aSlJeILTKQx0Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=WY3dJWeAUCYZzjVe1LKSp/xFe/xhvhRlrznTX/AnOWyDwT0lHtY0UGg1pBxtEQfFB
         2r7A8fOedKQH+d1NGF4XF9+yISiWNhOy4NLbjWMMxEM7lAXP3MnTNlJxsg/De63wkZ
         FYKDEZ+TqvFWxVsFKJ8ioqO0r1xCi0QdVLRVYrmsohQyhiC0rmb9/eqvhDnXAgm43x
         IFQn2hZ96iKEz5MdJlxPc8HQez0IbsJD0ZlBitSdOXpRYX4jZ0bqDC/MfDZG7v6yDA
         WCt0JU9ZCtl3kKGmzUZEtwCcH+rcLexI0hV29qMGHlhLjC6/OQDrsu0koVxRLyNC3G
         uug5dNekouFgA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 88002A0062;
        Mon, 18 Mar 2019 10:03:44 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 03:03:44 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 11:03:42 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 11:03:41 +0100
Subject: Re: [PATCH v3 2/5] PCI: dwc: Free the page for MSI IRQ in
 dw_pcie_free_msi()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190318174415.74fd25a5@xhacker.debian>
 <20190318174711.4b7e556a@xhacker.debian>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <97016e8d-9975-84a0-5ab3-dc4009227927@synopsys.com>
Date:   Mon, 18 Mar 2019 10:03:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190318174711.4b7e556a@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 18/03/2019 09:54, Jisheng Zhang wrote:
> To avoid memory leak, we need to free the page for MSI in
> dw_pcie_free_msi().
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++++----
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 1040939f45b4..a71b874ae3c0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -305,20 +305,24 @@ void dw_pcie_free_msi(struct pcie_port *pp)
>  
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
> +
> +	if (pp->msi_page)
> +		__free_page(pp->msi_page);
>  }
>  
>  void dw_pcie_msi_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct device *dev = pci->dev;
> -	struct page *page;
>  	u64 msi_target;
>  
> -	page = alloc_page(GFP_KERNEL);
> -	pp->msi_data = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
> +	pp->msi_page = alloc_page(GFP_KERNEL);
> +	pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
> +				    DMA_FROM_DEVICE);
>  	if (dma_mapping_error(dev, pp->msi_data)) {
>  		dev_err(dev, "Failed to map MSI data\n");
> -		__free_page(page);
> +		__free_page(pp->msi_page);
> +		pp->msi_page = NULL;
>  		return;
>  	}
>  	msi_target = (u64)pp->msi_data;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 377f4c0b52da..6fb0a1879932 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -179,6 +179,7 @@ struct pcie_port {
>  	struct irq_domain	*irq_domain;
>  	struct irq_domain	*msi_domain;
>  	dma_addr_t		msi_data;
> +	struct page		*msi_page;
>  	u32			num_vectors;
>  	u32			irq_mask[MAX_MSI_CTRLS];
>  	raw_spinlock_t		lock;
> 

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
