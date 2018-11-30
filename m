Return-Path: <SRS0=gDpg=OJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59237C04EB8
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 10:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC532146D
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 10:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC532146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeK3Vrb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:47:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54106 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbeK3Vrb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Nov 2018 16:47:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CD580D;
        Fri, 30 Nov 2018 02:38:40 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B043F59C;
        Fri, 30 Nov 2018 02:38:39 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:38:34 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     jingoohan1@gmail.com, bhelgaas@google.com, joao.pinto@synopsys.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Print debug error message when MSI-X entry
 control mask bit is set
Message-ID: <20181130103834.GA17598@e107981-ln.cambridge.arm.com>
References: <113052d54c1f3fa01f8ea1aa6e5a49e2620b5c64.1542910855.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113052d54c1f3fa01f8ea1aa6e5a49e2620b5c64.1542910855.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 22, 2018 at 07:20:55PM +0100, Gustavo Pimentel wrote:
> Add debug error message when MSI-X entry control mask bit is set, to help
> depur which reason why a MSI-X interrupt is not being trigger.

s/depur which/debug the

s/trigger/triggered

> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1e7b022..b52b986 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -466,8 +466,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	iounmap(msix_tbl);
>  
> -	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
> +	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
> +		dev_err(pci->dev, "MSI-X entry ctrl set\n");

I would make it dev_dbg() given debugging is the reason you are adding
it, can I make this change ?

Lorenzo

>  		return -EPERM;
> +	}
>  
>  	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->page_size);
> -- 
> 2.7.4
> 
