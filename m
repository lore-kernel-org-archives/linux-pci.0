Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219C9C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 05:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F8620663
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 05:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bUi5kQnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F8620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeKZQpF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:45:05 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14545 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeKZQpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Nov 2018 11:45:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfb89e20000>; Sun, 25 Nov 2018 21:51:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 25 Nov 2018 21:52:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 25 Nov 2018 21:52:02 -0800
Received: from [10.2.161.165] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 26 Nov
 2018 05:52:00 +0000
Subject: Re: [PATCH V2] PCI: dwc: Don't hard-code DBI/ATU offset
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181120175750.26141-1-swarren@wwwdotorg.org>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <acc9aca4-2f1a-70cf-72f4-9f631951a75c@nvidia.com>
Date:   Mon, 26 Nov 2018 11:21:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120175750.26141-1-swarren@wwwdotorg.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543211490; bh=c/CHXebkz2wydLib/YEEADhYSKqj043v3Fm+yZFY+Qs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=bUi5kQnQjHh6VPnUZ+C5IfyCsvX/sRhZNSlJRYzmvFB+8yJ04FLNyN32zMtAr/Mx4
         m1zsK9yEC//WAI3N7iZVJYn3lO77upFpkUDJPETYQBa3VHjhqT4zxAOE/MHkS4PYbQ
         M4AaxMW6G+iywM8ZIdkpu1kfkoUEMl/X1Fo7o9neK8x2TMkGYC6UecDYMCaJ6XpxZc
         JZ39EdqLSSvfejJuDIMTrNrqluWICgvUhS742iROBgadMSpML0ICKFB55m8qONiP7q
         OEJzC8pMpY2JnQMbb5yv6vTMdYjyXBDMDBRVoOnKvlq5nJ2JAy4nigf1LSwO5sB+QC
         ihsRhjIHsft+w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/20/2018 11:27 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> The DWC PCIe core contains various separate register spaces: DBI, DBI2,=

> ATU, DMA, etc. The relationship between the addresses of these register=

> spaces is entirely determined by the implementation of the IP block, no=
t
> by the IP block design itself. Hence, the DWC driver must not make
> assumptions that one register space can be accessed at a fixed offset f=
rom
> any other register space. To avoid such assumptions, introduce an
> explicit/separate register pointer for the ATU register space. In
> particular, the current assumption is not valid for NVIDIA's T194 SoC.
>
> The ATU register space is only used on systems that require unrolled AT=
U
> access. This property is detected at run-time for host controllers, and=

> when this is detected, this patch provides a default value for atu_base=

> that matches the previous assumption re: register layout. An alternativ=
e
> would be to update all drivers for HW that requires unrolled access to
> explicitly set atu_base. However, it's hard to tell which drivers would=

> require atu_base to be set. The unrolled property is not detected for
> endpoint systems, and so any endpoint driver that requires unrolled acc=
ess
> must explicitly set the iatu_unroll_enabled flag (none do at present), =
and
> so a check is added to require the driver to also set atu_base while at=

> it.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> v2:
> * Modified patch subject
> * Added missing outer brackets to PCIE_GET_ATU_INB_UNR_REG_OFFSET macro=

> ---
>   .../pci/controller/dwc/pcie-designware-ep.c   |  4 ++++
>   .../pci/controller/dwc/pcie-designware-host.c |  3 +++
>   drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++----
>   drivers/pci/controller/dwc/pcie-designware.h  | 20 +++++++++++++++---=
-
>   4 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> index 1e7b02221eac..880210366e71 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -504,6 +504,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
>   		return -EINVAL;
>   	}
> +	if (pci->iatu_unroll_enabled && !pci->atu_base) {
> +		dev_err(dev, "atu_base is not populated\n");
> +		return -EINVAL;
> +	}
>  =20
>   	ret =3D of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windo=
ws);
>   	if (ret < 0) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..2ebb7f4768cf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -699,6 +699,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>   		dev_dbg(pci->dev, "iATU unroll: %s\n",
>   			pci->iatu_unroll_enabled ? "enabled" : "disabled");

I see that dw_pcie_setup_rc() API has code where=20
pci->iatu_unroll_enabled gets set based on reading a viewport register.

IMO, we need a check like following to avoid pci->iatu_unroll_enabled=20
getting modified (if already set)

if (!pci->iatu_unroll_enabled)
=20=C2=A0=C2=A0 =C2=A0pci->iatu_unroll_enabled =3D dw_pcie_iatu_unroll_en=
abled(pci);

>  =20
> +		if (pci->iatu_unroll_enabled && !pci->atu_base)
> +			pci->atu_base =3D pci->dbi_base + (0x3 << 20);
> +
>   		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
>   					  PCIE_ATU_TYPE_MEM, pp->mem_base,
>   					  pp->mem_bus_addr, pp->mem_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> index 2153956a0b20..93ef8c31fb39 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -93,7 +93,7 @@ static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pc=
i, u32 index, u32 reg)
>   {
>   	u32 offset =3D PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>  =20
> -	return dw_pcie_readl_dbi(pci, offset + reg);
> +	return dw_pcie_readl_atu(pci, offset + reg);
>   }
>  =20
>   static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, =
u32 reg,
> @@ -101,7 +101,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie=
=20*pci, u32 index, u32 reg,
>   {
>   	u32 offset =3D PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>  =20
> -	dw_pcie_writel_dbi(pci, offset + reg, val);
> +	dw_pcie_writel_atu(pci, offset + reg, val);
>   }
>  =20
>   static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int=
=20index,
> @@ -187,7 +187,7 @@ static u32 dw_pcie_readl_ib_unroll(struct dw_pcie *=
pci, u32 index, u32 reg)
>   {
>   	u32 offset =3D PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
>  =20
> -	return dw_pcie_readl_dbi(pci, offset + reg);
> +	return dw_pcie_readl_atu(pci, offset + reg);
>   }
>  =20
>   static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, =
u32 reg,
> @@ -195,7 +195,7 @@ static void dw_pcie_writel_ib_unroll(struct dw_pcie=
=20*pci, u32 index, u32 reg,
>   {
>   	u32 offset =3D PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
>  =20
> -	dw_pcie_writel_dbi(pci, offset + reg, val);
> +	dw_pcie_writel_atu(pci, offset + reg, val);
>   }
>  =20
>   static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int i=
ndex,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> index 0989d880ac46..e895f37b1dee 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -93,11 +93,11 @@
>   #define PCIE_ATU_UNR_UPPER_TARGET	0x18
>  =20
>   /* Register address builder */
> -#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	\
> -			((0x3 << 20) | ((region) << 9))
> +#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region) \
> +		((region) << 9)
>  =20
> -#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)				\
> -			((0x3 << 20) | ((region) << 9) | (0x1 << 8))
> +#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
> +		(((region) << 9) | (0x1 << 8))
>  =20
>   #define MAX_MSI_IRQS			256
>   #define MAX_MSI_IRQS_PER_CTRL		32
> @@ -219,6 +219,8 @@ struct dw_pcie {
>   	struct device		*dev;
>   	void __iomem		*dbi_base;
>   	void __iomem		*dbi_base2;
> +	/* Used when iatu_unroll_enabled is true */
> +	void __iomem		*atu_base;
>   	u32			num_viewport;
>   	u8			iatu_unroll_enabled;
>   	struct pcie_port	pp;
> @@ -289,6 +291,16 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pci=
e *pci, u32 reg)
>   	return __dw_pcie_read_dbi(pci, pci->dbi_base2, reg, 0x4);
>   }
>  =20
> +static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u3=
2 val)
> +{
> +	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
> +}
> +
> +static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
> +{
> +	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
> +}
> +
>   static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
>   {
>   	u32 reg;
-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
