Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5374C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68688218A4
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="d5A789s/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfABKZ7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:25:59 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:34742 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfABKZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 05:25:59 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AD8D024E11FC;
        Wed,  2 Jan 2019 02:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546424759; bh=DbM8GDdJKlSpbVLoK63r8vFdbrHDFjR72e6F/u//36o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=d5A789s/OICdbG2ySZfcMWj4A67ALlf5DkGWsm5OM8eevW06KEkYtfUKFXsBNKix7
         sJIUSyfQErBIjyvj9mVQat+0115YDUjWS9RpQz2eTGVjil+67oJhVwp79+W+wnnY4f
         muMEkVHew7CeKxsRw5u+4eq442RoHLbRcCR25Uus0dk8D3bnFJsm1haHN7B3zBr9K/
         hGtvnPUPzMjLSRgo7wu41XnTiAsSq6B6PomhSrO83217jel1q2h4nguXfQEmJTvpcx
         lIl4OCCa5//yyf5IpF4krUWrna/yOGmaLebaQH/OUhNfQT6Ptko4eRDLaGDnWrG0+n
         YjgI7vlRY6ijw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3ADB352F3;
        Wed,  2 Jan 2019 02:25:58 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 02:25:58 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 11:25:56 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 11:25:56 +0100
Subject: Re: [PATCH 08/21] PCI: designware: Share code for
 dw_pcie_rd/wr_other_conf()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-9-andrew.smirnov@gmail.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <3d995998-ccec-339d-3676-6abd013dad09@synopsys.com>
Date:   Wed, 2 Jan 2019 10:21:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-9-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 21/12/2018 07:27, Andrey Smirnov wrote:
> Default implementation of pcie_rd_other_conf() and
> dw_pcie_wd_other_conf() share more than 80% of their code. Move shared
> code into a dedicated subroutine and convert pcie_rd_other_conf() and
> dw_pcie_wd_other_conf() to use it. No functional change intended.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++------------
>  1 file changed, 23 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 721d60a5d9e4..8f957cd6901b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -512,8 +512,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	return ret;
>  }
>  
> -static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> -				 u32 devfn, int where, int size, u32 *val)
> +static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> +				     u32 devfn, int where, int size, u32 *val,
> +				     bool write)
>  {
>  	int ret, type;
>  	u32 busdev, cfg_size;
> @@ -521,9 +522,6 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  	void __iomem *va_cfg_base;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
> -	if (pp->ops->rd_other_conf)
> -		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
> -
>  	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>  		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
>  
> @@ -542,7 +540,11 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
>  				  type, cpu_addr,
>  				  busdev, cfg_size);
> -	ret = dw_pcie_read(va_cfg_base + where, size, val);
> +	if (write)
> +		ret = dw_pcie_write(va_cfg_base + where, size, *val);
> +	else
> +		ret = dw_pcie_read(va_cfg_base + where, size, val);
> +
>  	if (pci->num_viewport <= 2)
>  		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
>  					  PCIE_ATU_TYPE_IO, pp->io_base,
> @@ -551,43 +553,26 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  	return ret;
>  }
>  
> +static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> +				 u32 devfn, int where, int size, u32 *val)
> +{
> +	if (pp->ops->rd_other_conf)
> +		return pp->ops->rd_other_conf(pp, bus, devfn, where,
> +					      size, val);
> +
> +	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, val,
> +					 false);
> +}
> +
>  static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  				 u32 devfn, int where, int size, u32 val)
>  {
> -	int ret, type;
> -	u32 busdev, cfg_size;
> -	u64 cpu_addr;
> -	void __iomem *va_cfg_base;
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -
>  	if (pp->ops->wr_other_conf)
> -		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
> -
> -	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> -		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> +		return pp->ops->wr_other_conf(pp, bus, devfn, where,
> +					      size, val);
>  
> -	if (bus->parent->number == pp->root_bus_nr) {
> -		type = PCIE_ATU_TYPE_CFG0;
> -		cpu_addr = pp->cfg0_base;
> -		cfg_size = pp->cfg0_size;
> -		va_cfg_base = pp->va_cfg0_base;
> -	} else {
> -		type = PCIE_ATU_TYPE_CFG1;
> -		cpu_addr = pp->cfg1_base;
> -		cfg_size = pp->cfg1_size;
> -		va_cfg_base = pp->va_cfg1_base;
> -	}
> -
> -	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> -				  type, cpu_addr,
> -				  busdev, cfg_size);
> -	ret = dw_pcie_write(va_cfg_base + where, size, val);
> -	if (pci->num_viewport <= 2)
> -		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> -					  PCIE_ATU_TYPE_IO, pp->io_base,
> -					  pp->io_bus_addr, pp->io_size);
> -
> -	return ret;
> +	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, &val,
> +					 true);
>  }
>  
>  static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
> 

Nice!

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo
