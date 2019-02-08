Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0DEC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 11:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DC121924
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 11:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfBHLLE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:11:04 -0500
Received: from foss.arm.com ([217.140.101.70]:48604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfBHLLE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 06:11:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE55DA78;
        Fri,  8 Feb 2019 03:11:03 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF3213F719;
        Fri,  8 Feb 2019 03:11:01 -0800 (PST)
Date:   Fri, 8 Feb 2019 11:10:58 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: allow to limit registers set length
Message-ID: <20190208111058.GC13009@e107981-ln.cambridge.arm.com>
References: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 06, 2019 at 10:57:31AM +0100, Stefan Agner wrote:
> Add length to the struct dw_pcie and check that the accessors
> dw_pcie_(rd|wr)_conf() do not read/write beyond that point.
> 
> Suggested-by: Trent Piepho <tpiepho@impinj.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v4:
> - Move length check to dw_pcie_rd_conf
> Changes in v5:
> - Rebased ontop of pci/dwc
> 
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
>  2 files changed, 15 insertions(+), 2 deletions(-)

Applied to pci/dwc for v5.1, thanks.

Lorenzo

PS: Remember adding a version number to the patches next time please,
thanks.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 45ff5e4f8af6..bad54204fb52 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -612,14 +612,20 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  			   int size, u32 *val)
>  {
>  	struct pcie_port *pp = bus->sysdata;
> +	struct dw_pcie *pci;
>  
>  	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
>  		*val = 0xffffffff;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> -	if (bus->number == pp->root_bus_nr)
> +	if (bus->number == pp->root_bus_nr) {
> +		pci = to_dw_pcie_from_pp(pp);
> +		if (pci->dbi_length && where + size > pci->dbi_length)
> +			return PCIBIOS_BAD_REGISTER_NUMBER;
> +
>  		return dw_pcie_rd_own_conf(pp, where, size, val);
> +	}
>  
>  	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
>  }
> @@ -628,12 +634,18 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  			   int where, int size, u32 val)
>  {
>  	struct pcie_port *pp = bus->sysdata;
> +	struct dw_pcie *pci;
>  
>  	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> -	if (bus->number == pp->root_bus_nr)
> +	if (bus->number == pp->root_bus_nr) {
> +		pci = to_dw_pcie_from_pp(pp);
> +		if (pci->dbi_length && where + size > pci->dbi_length)
> +			return PCIBIOS_BAD_REGISTER_NUMBER;
> +
>  		return dw_pcie_wr_own_conf(pp, where, size, val);
> +	}
>  
>  	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 279000255ad1..d1d95119a422 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -226,6 +226,7 @@ struct dw_pcie_ops {
>  struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
> +	int			dbi_length;
>  	void __iomem		*dbi_base2;
>  	/* Used when iatu_unroll_enabled is true */
>  	void __iomem		*atu_base;
> -- 
> 2.20.1
> 
