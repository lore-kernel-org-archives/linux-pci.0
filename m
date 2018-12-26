Return-Path: <SRS0=zpRJ=PD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D32EC43387
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1DE2171F
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 15:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SRbPBtkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeLZPTd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Dec 2018 10:19:33 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:52092 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeLZPTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Dec 2018 10:19:33 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 71D3324E25BD;
        Wed, 26 Dec 2018 07:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545837572; bh=7bJtq6WlClTOgEY7fy1zvuHrsJ8CUhuisiP3TTvq/+M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=SRbPBtkC3Z3nS7TICXEHiLd85s6l+TDsSetXFfo1HiwCoUBTr2ezU8xiwch6Wivdu
         62TZOte2PQH4GxI0nNxvrJF8Kum07PsBrylzbcfjZcNwW0Ug3LuBNUnNFhRfbPL3Y1
         D7ahbBTJE12viywm5RbI0TIT7ZjLCelyCLV3D2r+rmL6MoSjWYp/djjJikwm4BU7/h
         PLUgLh5y5E3FHfIerLGv8Ew/b6v1t6XGd5Zxeo0YnjAgqFS4WAQskAhllEglAfhfEK
         JitZMQSwozkpvSem1TM4kOgkCvFn0ATGCXxCMh3RJV0IPCpGrxRiRg8GDICagtAUVE
         Nuv1wHRPCeKlA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id E67D53577;
        Wed, 26 Dec 2018 07:19:31 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 07:19:31 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 16:19:29 +0100
Received: from [10.225.2.19] (10.225.2.19) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 26 Dec
 2018 16:19:29 +0100
Subject: Re: [PATCH 11/21] PCI: designware: Make use of BIT() in constant
 definitions
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
 <20181221072716.29017-12-andrew.smirnov@gmail.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <86e8172d-d1dc-59d6-0b64-b11ce014b6a4@synopsys.com>
Date:   Wed, 26 Dec 2018 15:14:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-12-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.225.2.19]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 21/12/2018 07:27, Andrey Smirnov wrote:
> Avoid using explicit left shifts and convert various definitions to
> use BIT() instead. No functional change intended.
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
>  drivers/pci/controller/dwc/pcie-designware.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index d123ac290b9e..086e87a40316 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -300,7 +300,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  	}
>  
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);

This is unrelated with the patch description purpose.

>  }
>  
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 58735fd01668..348e91b6daa2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -40,11 +40,11 @@
>  #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
>  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
>  #define PCIE_PORT_DEBUG1		0x72C
> -#define PCIE_PORT_DEBUG1_LINK_UP		(0x1 << 4)
> -#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	(0x1 << 29)
> +#define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
> +#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
>  
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> -#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
> +#define PORT_LOGIC_SPEED_CHANGE		BIT(17)
>  #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
>  #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
>  #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
> @@ -58,8 +58,8 @@
>  #define PCIE_MSI_INTR0_STATUS		0x830
>  
>  #define PCIE_ATU_VIEWPORT		0x900
> -#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
> -#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
> +#define PCIE_ATU_REGION_INBOUND		BIT(31)
> +#define PCIE_ATU_REGION_OUTBOUND	0
>  #define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
>  #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
>  #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
> @@ -69,8 +69,8 @@
>  #define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
>  #define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
>  #define PCIE_ATU_CR2			0x908
> -#define PCIE_ATU_ENABLE			(0x1 << 31)
> -#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
> +#define PCIE_ATU_ENABLE			BIT(31)
> +#define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
>  #define PCIE_ATU_LOWER_BASE		0x90C
>  #define PCIE_ATU_UPPER_BASE		0x910
>  #define PCIE_ATU_LIMIT			0x914
> @@ -81,7 +81,7 @@
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
>  #define PCIE_MISC_CONTROL_1_OFF		0x8BC
> -#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
> +#define PCIE_DBI_RO_WR_EN		BIT(0)
>  
>  /*
>   * iATU Unroll-specific register definitions
> @@ -108,7 +108,7 @@
>  		((region) << 9)
>  
>  #define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
> -		(((region) << 9) | (0x1 << 8))
> +		(((region) << 9) | BIT(8))
>  
>  #define MAX_MSI_IRQS			256
>  #define MAX_MSI_IRQS_PER_CTRL		32
> 

Regards,

Gustavo
