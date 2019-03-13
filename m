Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D61C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D862184C
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O0lHcxNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfCMKMM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:12:12 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35238 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfCMKMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 06:12:12 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id A7A7610C17F0;
        Wed, 13 Mar 2019 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552471931; bh=w+t73vudo7xgHCpFBFeCraD8IXrfeVuVwDvom4gnmZA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=O0lHcxNKkdlNC4Il5u23LQJJ3d0M8VvL1HcqdeWTA/Lk1MT1wA9wuAX93R21eJsV3
         uxFt04PrmJ0O3ht4oPLuXlg1TZQ7jP5RXbiveMK2WYYkFIzFtBMSYvMuxl4lVd0606
         1Jufd4i/zzuJmMRXQCqpDw9z6MO2vKjNDTv7cFMIQ+cO3k3Cmu/NTAcxNpzBRy3yGu
         zAMNFX768HOWH8pFdw1lvcuH72fDW8ECQxaJjFSWDC72+WKPa6FqkZ8eicalOkkYEo
         NSQF2bb3h4V4Cxldg3WocA64+2YtIceQi+lpJw/i0Tq+KoRf4GNVbniN77KO+iVDxX
         VgL0Jz1JL1VGQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7B772A005D;
        Wed, 13 Mar 2019 10:12:11 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 03:12:11 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:12:08 +0100
Received: from [10.107.19.55] (10.107.19.55) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:12:08 +0100
Subject: Re: [PATCH v2 2/5] PCI: dwc: Free the page for MSI IRQ in
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
References: <20190301125510.4e2ee985@xhacker.debian>
 <20190301125707.73563471@xhacker.debian>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <9acbe004-d345-b7cf-d838-3bf68c6fd246@synopsys.com>
Date:   Wed, 13 Mar 2019 10:12:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190301125707.73563471@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.55]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 01/03/2019 05:04, Jisheng Zhang wrote:
> To avoid memory leak, we need to free the page for MSI in
> dw_pcie_free_msi().
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a94d3530b694..abe3ff5f0867 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -305,6 +305,8 @@ void dw_pcie_free_msi(struct pcie_port *pp)
>  
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
> +
> +	__free_page(pp->msi_page);

Perhaps you could test is msi_page is null or not before the free.

>  }
>  
>  void dw_pcie_msi_init(struct pcie_port *pp)
> @@ -322,6 +324,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>  		return;
>  	}
>  	msi_target = (u64)pp->msi_data;
> +	pp->msi_page = page;

And maybe use the pp->msi_page variable from the beginning of the function, that
way is one less variable.

Regards,
Gustavo

>  
>  	/* Program the msi_data */
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f6fb65a40f10..3be7ca9f1fc3 100644
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

