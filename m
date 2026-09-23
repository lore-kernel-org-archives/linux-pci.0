Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021092.outbound.protection.outlook.com [52.101.125.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEC524B1C;
	Wed, 23 Sep 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175368; cv=fail; b=RZkaxqXh32zsthMx/msK+XGeSuAKN3If0q9zI/k7POM7v861mGeYXaNwI6JdJ3dynj3ZIPgUFzEF4UwayIQZqxvNoYVjEV+Y55UZJWa8tkhMclVVBYdhTy+Zuoc+JXT/iiOHRW7AZA0o/7Su4tghpbsAypyG3EDH79+jxP5c9ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175368; c=relaxed/simple;
	bh=gxzrpFxIWTkqT8W1dSv0yWS9dxO6msaVTgpKjvTPyPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eS28CocbFNclYmsAt0gZ0IuUoWxD7qnyBnmhQt8CrNBQFDbm1b1kAH4+IWAcFXtJP2J3t2Qf0QaaYKsB9NsQV1VGFEkfLq65gVxXI5pAg4FgHGM0GtiZZ59saMLLZXqIFn7J0T8Kxnsis91ck4wvY6fRG7Vrg+ZuG69PqXlkE7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Qa/7umtH; arc=fail smtp.client-ip=52.101.125.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Qa/7umtH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZDBnhJ9w5iifaNbecz4q08Xryvi/S/SXq7ah0HUvOfi4QmQ7WoV2/iGbPw972iGuJO/BBKbZmhifhvuiJEUCt2c7NWEw7mMUNn12eaDuu7bIrulYRzs9pYZH/L3bEKxi9PhJUu81KiWPrnVUjxv/9Swao0cZG8VzL8y/VgiBI+ioPKP5/4qljQVg4dKqLQH+lk/rLSDQBCKauC4KuPrarj4lTu3VcUIguOJam018rIzIwTThmtYWS4h/MPmEVi+s05cKPwJvrpRijvpbNX9ILZLHL3F0K6H8UXnO/Vnd/PFjYD3jLsz4/wDhVTTX8pjIivjg1kLwAcB8NLRY1cHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t22dXBZqt2z4JT9fbc1/BdiYrNv+duR9pIagmXPOuBg=;
 b=o3MQARFjSYwgjZvIT0H90XDOSWZBJ1P53NT7OMgOYi/sJDLcQM2RJ+J7726InSCO4HUZFIpJmvJrSfr9gI5ixSs7uUwacVNk4PDkZdMUWiF6jMthE/TCYue+Oken+kEtATDprPRJ+MMMhsY8PF8oXTXgnqvts1yXbXydxrUuLPkOV1UtWtluaYrRX4PR2Ohv0i6rMgj+5eVeZrm1SIzuHlNWYb8h4QodDW9Mrsi0u8TH6084BU6bfZ9qOvWFw3JRkpRt6VPrbtuYZYvH3EAkXlS1W9vm5f1vrbU94fmU+brjS8O+pIk3RfP0nxd9LL880YeGthkBj/SeyufAWLZcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t22dXBZqt2z4JT9fbc1/BdiYrNv+duR9pIagmXPOuBg=;
 b=Qa/7umtHmA5JZlpEWti8do/Kou2ELrd5PYE+31LwEL67DODjtgrkd6NJNO/67kZNtUB1324akWFq+P/IT2hl8bcVkOpbXnjExTP6HsPx+988Ieok8FpnYNkNY3AkkjZfVtxgxw4b0rR9UD1qAOG92bS3r4Gak0DPmDd9KNLRMF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 14:56:02 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:56:02 +0000
Date: Wed, 23 Sep 2026 23:56:01 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] PCI: rcar-gen4: Drop the APP-based link_up check
Message-ID: <4peziifkgyfpglfl4jtyvcxqht2yo4r4bswmkweicpxdf45ejc@jxbqgurozlft>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-3-den@valinux.co.jp>
 <c2807afc-3e69-4744-8588-20f60839a603@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2807afc-3e69-4744-8588-20f60839a603@mailbox.org>
X-ClientProxiedBy: TY4P286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f63c675-c61a-4986-7ef2-08df1982c93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10070799003|7416014|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N5MdaBfw0qQ+HG+g1/hagf1GLtnJmwE+ij4/cU6ZgcuMK3Cd5xnv/RV/3BDNC0E2fq1r4k6QFfp4J9wWvBOAlifqgQPLpSETjZZd7YcjZy8x++LCzmYGs6DhWeQid4NmkbKzjJStZhBI+c4+do9ocXIp8KWcEz2RQLpAfusSHhaUP+P5AQQjOGyapVvbhZyU9Ixe+eVU/gByDT2LaPtTXW/SXQHjaJaZInh+6bfYDTC+Rcw146lkqQkmBopOZInWyHQ8gOLjWHA5xltnNVqpPf+7DdQTBmpIz5vni/usBDVBF/kxEmDHR1WkJXLMFD7I4FQTcTxi7DE+2LX8CriHQ/ydXpCWf8E9DwOTXUYXoj7Y7Sy3lSsB3cjf6nrCKJHRi4a1gSkeu3JK6dlviPQlGew05zop+ST0eIBLLRgOvYgTCaP6WhzCpJlQ9jWTEC7pKyrBdFJQISNt7/ZQpNuYt+rDNS1ekY9uGBCxgy197KMw8OlvbVjDw5KstB+lU9BHUBZYRrTm0Nmk3eABtYWymDOLSSSy3B/B8M9W/sViB6/hRtM8/18Z89gxDwekM9CRLkf5X5AlGrWjRbvnu7329/IXyn7+8U48zKv+vzHFEABle5I92pwxZr4Mj4Vd7G7gFFt6z66texGHVn0qqDqLZmU50kCjnHPJmtsGu5+CU7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(7416014)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ieCJRV5Q0DKxb1UD5lkbK1un6SnnL9zpmq+UzXlnnuWta2U7JekISCL1ZNTI?=
 =?us-ascii?Q?wQnunmSllMzajQqYpesaXJouHXWXYs5CKcMYU2mRlZyw4rXOBT84jMAPhAO6?=
 =?us-ascii?Q?rqN4a+r0CDvvKTkahNabJyJ/VSMgHFuzS8U/yw7WKosWHspz3MiUMX3cyLoI?=
 =?us-ascii?Q?EfbvLgXa3qIXEFwjPBZ4La7QsDI8rHFtcu3m0p3Ks7NkE6cWrNN648CnhW/W?=
 =?us-ascii?Q?JPGiCUDCCK/z80XrUSElyD0lq7O2aHNDH0zECQCgMAFmmDRc1FjdmgxdNnRK?=
 =?us-ascii?Q?HDcuCqkFxOUjwHJeLzwXhJz1DuATtqwlSrR+SqJ8IkeNY+Og8CVYAnZ8AfAu?=
 =?us-ascii?Q?I4sxmuZNojGXR/tGoyMfJYKvNtoIrl77XKIlBHlK419zcYFDt3aqSskGmPSK?=
 =?us-ascii?Q?/+6IwAJ6qCye/DO5wKIHzYP+S4O9OxxBDI26ieEWr7QnydecbwtLQ3RZl3i4?=
 =?us-ascii?Q?OuAp1lhIxDR7JkJAThY1veg4vKE+Lt6EDwR380Ew9RmGZ5xU61DZfG0wnr5O?=
 =?us-ascii?Q?DVXABtcXira4E6K+gsZpSaW+LB2YuGA/RNL76owHOXyBZUpywMJJ9E9rFAwU?=
 =?us-ascii?Q?sHF/72JuWabVhBQ5CaB/2BgGLDBIDQRIcKvunkBEf8telei//xdSUx/38TFy?=
 =?us-ascii?Q?ZXBVDbz9klKCUNyQAb8vQpiif/LVP1GQ7lUKXEW+Z7vpZ4iJAMB9JNLojCHy?=
 =?us-ascii?Q?xA9B+zu+aohNETFLOtiWoS7ClauJGoxurqKO5bgJn4T3QfrMjICsXdqsYOvO?=
 =?us-ascii?Q?jLbkwN25UkYXzTEEO/5jkQA2U0/2vmBeVZl7Pwl41DJIT+OBcoZR//Je0UZ8?=
 =?us-ascii?Q?s7JUc4kFWYYKEFW9GOUaOsfnyHN2b6b1/6y4zCBUEbEJmerGjIxzCAXXz0KQ?=
 =?us-ascii?Q?P/Kc3o1Ax7WmK9aWX3i56C4o+tt9yO4jv0eWUn3J8f5/WsM2NGWqGjVKghs/?=
 =?us-ascii?Q?hlKg9LIr+qFIeVNjsGzdnaXsZdk3hDSD8uPJX5RDJm8HtddJDQXzCa5hxS3E?=
 =?us-ascii?Q?bYczc3zF85c9TXE2thC5KxokvwU7fmlBKPIIJjF7To1C7tIu4niexyij/srl?=
 =?us-ascii?Q?dIcjmQUF/CXXj8PKY797XHnEWpL79spghqnhJwutl2MafQqd5kva0sPAjT9V?=
 =?us-ascii?Q?Cro8XYpwwrFxeZC9sWMCd8Pf8ZZQyXd5bB2/Jdd1lcNXnEt0EPJgADjzcv5h?=
 =?us-ascii?Q?b4w1trqNJSJ76HYJVTPzK6bTjBQ5BHGQMzUAjP842k4PsVZJDYXYGuedGi7U?=
 =?us-ascii?Q?9fHpopxdasWHUmDHLCDikQn9uYzrcMpAbaYyXfgLZzNSdEE8x2MKi83Lr/Nn?=
 =?us-ascii?Q?/KfWipowj5FSPCIXT7d3n7rFTEJRiVdZw+iXPBtyZ+62Rfzf3ZGko+KFpiW8?=
 =?us-ascii?Q?eqQ0PcwNaGv9p6aj7P8eb7vRUcrpexWno8JLAbItcJ3qGLGfkSCfIpWY8fEb?=
 =?us-ascii?Q?A7M7Vjv3dR+a9xz/zq7BnRYaxIMqrnDEUj3FXOnnno70yawutMUMmfwh6Kzj?=
 =?us-ascii?Q?uXqfz4e+5xLEKwJH6n5S86EYk61HCIf3F34mBTnZM1G/RrJXjW4XTqpW9W0G?=
 =?us-ascii?Q?PYhUkb2hvcKrTUPwJWfJDwvPBo9S+pXdafoGCBNb/Lv1OLcjJxx75l4XfYT5?=
 =?us-ascii?Q?cG97RN9C7TZJTaF2+yQR2q/tty5kCrM3YPB+UeyytRgy7hviF9EZVutWeofJ?=
 =?us-ascii?Q?fB0/D7DbmnWyIB6YrcbtGHfvwryTxlJaKK2iE5F4YIBsFdurEGnO9ToNThEv?=
 =?us-ascii?Q?pADMa0crDmF+1Da74fIvFkH54z3SswirlrHNb0YBi9JmAl+R2/wz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f63c675-c61a-4986-7ef2-08df1982c93a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:56:02.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PO826IH0jRXmTC9x9K521xCxNUvDwwUZUc5BGIStUNeEPxoDWY5XDW4ov9eNpAsyUEwrbBi+q0qIzGvm6J+FrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4353

On Tue, Sep 22, 2026 at 10:56:02PM +0200, Marek Vasut wrote:
> Hello Den-san,
> 
> I apologize for my late reply.
> 
> On 9/18/26 5:20 AM, Koichiro Den wrote:
> > rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
> > RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
> > link state. On an R-Car S4, after taking down the endpoint, a link-down
> > interrupt saw PCIEINTSTS0 = 0x20a000c5 with both bits still set. Even
> > after resetting the controller with the LTSSM back in Polling, they read
> > 0xa000c5, still set.
> > 
> > As a result, dw_pcie_link_up() keeps reporting the link as up after it
> > has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
> > which is supposed to stop config accesses to downstream devices while
> > the link is down, so such accesses go out on the dead link and stall the
> > host. It also makes the callback useless for the link-down recovery
> > added later, which has to wait for the link to actually come back after
> > resetting the controller.
> > 
> > Drop the callback and let the DesignWare core use its PORT_DEBUG1 check
> > instead, which correctly detects the downed link.
> > 
> > Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >   drivers/pci/controller/dwc/pcie-rcar-gen4.c | 14 --------------
> >   1 file changed, 14 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > index 5a076aa3f490..fe1f1940e809 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -44,8 +44,6 @@
> >   /* PCIe Interrupt Status 0 Enable */
> >   #define PCIEINTSTS0EN		0x0310
> >   #define MSI_CTRL_INT		BIT(26)
> > -#define SMLH_LINK_UP		BIT(7)
> > -#define RDLH_LINK_UP		BIT(6)
> >   /* PCIe DMA Interrupt Status Enable */
> >   #define PCIEDMAINTSTSEN		0x0314
> > @@ -102,17 +100,6 @@ struct rcar_gen4_pcie {
> >   #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
> >   /* Common */
> > -static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> > -{
> > -	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > -	u32 val, mask;
> > -
> > -	val = readl(rcar->base + PCIEINTSTS0);
> > -	mask = RDLH_LINK_UP | SMLH_LINK_UP;
> > -
> > -	return (val & mask) == mask;
> > -}
> > -
> >   /*
> >    * Manually initiate the speed change. Return 0 if change succeeded; otherwise
> >    * -ETIMEDOUT.
> > @@ -298,7 +285,6 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> >   static const struct dw_pcie_ops dw_pcie_ops = {
> >   	.start_link = rcar_gen4_pcie_start_link,
> >   	.stop_link = rcar_gen4_pcie_stop_link,
> > -	.link_up = rcar_gen4_pcie_link_up,
> >   };
> >   static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
> 
> Can we include some form of the draft patch below, so the S4 Reference
> Manual rev.1.40 , page 1564 , Figure 104.5 Initial Setting of PCIEC ,
> bottommost diamond in the figure (smlh_link_up and rdlh_link_up = 1 test),
> would still be fulfilled, and the initialization code in the driver would
> not diverge from the initialization sequence listed in the reference manual
> ? What do you think ?

If always relying on the PORT_DEBUG1 check instead of the SMLH/RDLH check does
not introduce any regressions, I'd personally prefer to keep patch 2 as-is
because it keeps the code simpler. We could just add a comment noting that this
link-up check diverges from Figure 104.5.

That said, I agree that in general we should follow the R-Car reference manual
where possible, and your draft makes sense for that purpose. If we go that way,
I have one question: would we need a polling loop with a timeout
(PCIE_LINK_WAIT_MAX_RETRIES * PCIE_LINK_WAIT_SLEEP_MS) in
rcar_gen4_pcie_start_link(), similar to dw_pcie_wait_for_link()?

P.S. I'll rebase v2 onto the latest pci/controller/dwc-rcar-gen4.

Thanks for the review.

Best regards,
Koichiro

> 
> The PCIEINTSTS0CLR should clear the link state bits before the link gets
> started, so the initialization code should be able to sample those bits
> after the link came up and confirm they were set during the link up.
> 
> The PCIEINTSTS0CLR usage however won't solve the case where the DWC PCIe
> core code has to sample PCIe link state at arbitrary time, this is what this
> patch does solve correctly.
> 
> "
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index e5833f36625d2..9f29055f0bed7 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -203,17 +203,28 @@ static int rcar_gen5_pcie_speed_control(struct
> rcar_gen4_pcie *rcar)
>   * Enable LTSSM of this controller and manually initiate the speed change.
>   * Always return 0.
>   */
> +#define PCIEINTSTS0CLR		0x0340
>  static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
>  {
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	u32 val, mask;
>  	int ret;
> 
> +	/* Clear RDLH/SMLH link state */
> +	writel(RDLH_LINK_UP | SMLH_LINK_UP, rcar->base + PCIEINTSTS0CLR);
> +
>  	if (rcar->drvdata->ltssm_control) {
>  		ret = rcar->drvdata->ltssm_control(rcar, true);
>  		if (ret)
>  			return ret;
>  	}
> 
> +	ret = rcar->drvdata->speed_control(rcar);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(rcar->base + PCIEINTSTS0);
> +	mask = RDLH_LINK_UP | SMLH_LINK_UP;
> +	return ((val & mask) == mask)
>  }
> 
> @@ -223,6 +234,9 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
> 
>  	if (rcar->drvdata->ltssm_control)
>  		rcar->drvdata->ltssm_control(rcar, false);
> +
> +	/* Clear RDLH/SMLH link state */
> +	writel(RDLH_LINK_UP | SMLH_LINK_UP, rcar->base + PCIEINTSTS0CLR);
>  }
> 
>  static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> "
> 
> -- 
> Best regards,
> Marek Vasut
