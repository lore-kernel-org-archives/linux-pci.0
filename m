Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB044C32789
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECF12087E
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 15:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECF12087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeKUBoF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:44:05 -0500
Received: from foss.arm.com ([217.140.101.70]:50700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeKUBoF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 20:44:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3E84EBD;
        Tue, 20 Nov 2018 07:14:28 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292D73F5A0;
        Tue, 20 Nov 2018 07:14:27 -0800 (PST)
Date:   Tue, 20 Nov 2018 15:14:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de, tpiepho@impinj.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: dwc: allow to limit registers set length
Message-ID: <20181120151419.GA26247@e107981-ln.cambridge.arm.com>
References: <20181120132705.6917-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120132705.6917-1-stefan@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 02:27:03PM +0100, Stefan Agner wrote:
> Add length to the struct dw_pcie and check that the accessors
> dw_pcie_(rd|wr)_own_conf() do not read/write beyond that point.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 5 insertions(+)

Hi Stefan,

may I kindly ask you please to rebase this series against my pci/dwc
branch ? I will apply it with Lucas tags then.

Please CC me on the patches.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..b422538ee0bb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -29,6 +29,8 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>  		return pp->ops->rd_own_conf(pp, where, size, val);
>  
>  	pci = to_dw_pcie_from_pp(pp);
> +	if (pci->dbi_length && where + size > pci->dbi_length)
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  	return dw_pcie_read(pci->dbi_base + where, size, val);
>  }
>  
> @@ -41,6 +43,8 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>  		return pp->ops->wr_own_conf(pp, where, size, val);
>  
>  	pci = to_dw_pcie_from_pp(pp);
> +	if (pci->dbi_length && where + size > pci->dbi_length)
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  	return dw_pcie_write(pci->dbi_base + where, size, val);
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9f1a5e399b70..5be5f369abf2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -215,6 +215,7 @@ struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
>  	void __iomem		*dbi_base2;
> +	int			dbi_length;
>  	u32			num_viewport;
>  	u8			iatu_unroll_enabled;
>  	struct pcie_port	pp;
> -- 
> 2.19.1
> 
