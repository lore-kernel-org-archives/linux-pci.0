Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A3C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0FE2190A
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V/J6GviV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfBGPNV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:13:21 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:40098 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGPNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2019 10:13:21 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 1BD9F10C197F;
        Thu,  7 Feb 2019 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549552400; bh=Wia0h2SGUqk2JGfhbdqoZIOYNYOvjJn6kw1YXbPfhDI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=V/J6GviVa6c2Rhh7/Duq5WDy4a7sCicY8Z5LbDuO/LWvHbtxyo+yvH8rvFuZXLA9J
         c2S+nyZG2SNBKZozE8UG9/ZW0Wx/U7YMKDK7NkZ1wQJiVKpNVpA3n1kXlq4Zaj4I7m
         nPdyjZjA0ZhBXgejKHzz54rUbGgK7bsojT17yp181tYlv2RlbFDospdciSbGFAUCuL
         qvJb9DJnkwTGMkQPqvW5vudCr82ztB6Sh/s87+lIRfLxPb0iy9LJu7jAwMkdYoThSX
         u9ujWZGopkHjdE07lfeEMOD2HDLdK04Mcd1ZV86BcsnmpZAPF1/7LWs96IRTkgPBLg
         2jehG4o/srK7g==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5C0A3A005A;
        Thu,  7 Feb 2019 15:13:18 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 7 Feb 2019 07:13:18 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 7 Feb 2019 16:13:16 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 7 Feb 2019 16:13:16 +0100
Subject: Re: [PATCH 1/2] Acked-by: Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>
To:     Stefan Agner <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tpiepho@impinj.com" <tpiepho@impinj.com>
CC:     "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <a91e1edd-e6db-e449-29c3-bcf72831f7c2@synopsys.com>
Date:   Thu, 7 Feb 2019 15:08:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/02/2019 09:57, Stefan Agner wrote:
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
> 
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
> 

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
