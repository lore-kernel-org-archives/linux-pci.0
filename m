Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41CCC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 11:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA9C21104
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 11:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA9C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeK0Wdu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:33:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34112 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeK0Wdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 17:33:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BCE335FA;
        Tue, 27 Nov 2018 03:36:13 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE7A3F575;
        Tue, 27 Nov 2018 03:36:11 -0800 (PST)
Date:   Tue, 27 Nov 2018 11:36:02 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     jingoohan1@gmail.com, bhelgaas@google.com, joao.pinto@synopsys.com,
        linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Fix MSI-X EP framework address calculation
 bug
Message-ID: <20181127113554.GA19805@e107981-ln.cambridge.arm.com>
References: <7d7ec9c537b5aa6cac918b0201572efb14dc89c3.1542992421.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7ec9c537b5aa6cac918b0201572efb14dc89c3.1542992421.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 23, 2018 at 06:00:21PM +0100, Gustavo Pimentel wrote:
> Fixes an error caused by 3-bit right rotation on offset address
> calculation of MSI-X table in dw_pcie_ep_raise_msix_irq().
> 
> During the development time, by default the offset address of MSI-X
> table was set to zero, so that even with a 3-bit right rotation the
> computed result would still be zero and valid, therefore not being
> noticed this bug.
> 
> Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to pci/controller-fixes for the upcoming rc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1e7b022..de8635a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -440,7 +440,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	tbl_offset = dw_pcie_readl_dbi(pci, reg);
>  	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
> -	tbl_offset >>= 3;
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
>  	bar_addr_upper = 0;
> -- 
> 2.7.4
> 
