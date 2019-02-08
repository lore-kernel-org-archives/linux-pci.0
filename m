Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51E7C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EABF20663
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfBHMZ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:25:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50274 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBHMZ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 07:25:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA91A80D;
        Fri,  8 Feb 2019 04:25:57 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA4363F719;
        Fri,  8 Feb 2019 04:25:56 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:25:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <joao.pinto@synopsys.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Print debug error message when MSI-X entry
 control mask bit is set
Message-ID: <20190208122553.GF13009@e107981-ln.cambridge.arm.com>
References: <a5f26b59ae720edf4f3b90e4ee2d052e2920dca9.1544203477.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f26b59ae720edf4f3b90e4ee2d052e2920dca9.1544203477.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 07, 2018 at 06:24:37PM +0100, Gustavo Pimentel wrote:
> Add debug error message when MSI-X entry control mask bit is set, to help
> debug the reason why a MSI-X interrupt is not being triggered.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Joao Pinto <joao.pinto@synopsys.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to pci/dwc for v5.1, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1e7b022..a969322 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -466,8 +466,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	iounmap(msix_tbl);
>  
> -	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
> +	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
> +		dev_dbg(pci->dev, "MSI-X entry ctrl set\n");
>  		return -EPERM;
> +	}
>  
>  	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->page_size);
> -- 
> 2.7.4
> 
