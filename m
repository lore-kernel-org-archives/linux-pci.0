Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC85335BA;
	Wed, 23 Sep 2026 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179942; cv=fail; b=flOZgD20nnV1RTxvW3wM8rkjQhZ4SoTPpKjnekmt8rPUvJTMBS3w6PK/Q+wNEMcY21zIlFl0XuBf40N76Exn6SAIBAegvuT+7z4qHI9N/hOJ7bhTwfO/KNhup+m3Ii5HHjuwttvnE5DfXCnFVyPpifDOai7hLw+1lNRJvkpAi6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179942; c=relaxed/simple;
	bh=wkwF+hXRfxBWZJilR3uZML0Q8qjnA9p+3kZQWEq6IZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=br3dECHQ4JRJWIiOACyXxqnWA931F56l92l716vm3ihEihwuWc/ZryhNt2FDbmIy2ezE9zaksZwhUp7tSK5E+1/84/cnc7ZVhaW5VSG6PhtDt8enaFG/7oGG0K7XM8+TkNQei6dcktDc1iR8jBkEqvoiW3L9XwrYPmjpqqv4TBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qHO3qMKc; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qHO3qMKc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9u992rDHuwPV0e7K+R4wYBx+PoG+v1/9mHHQURho+dhwb4HwmK6T8cROkf69exhzYeM5lotekeKpLFIG1gOQ5wvKUYnlw4Obxqi7C+6XUDLWO1VQoLCpsgVquKlv0rBUYDLo5oCJfPk1QKNKKpfwIT82aSjTifOCkNmyNrrWUBHjHo4gfBctkgLzPGXa3sY33CSZ25ICU0wnQWijMOHR0l3YeVhC6K/kofxa7O7YSj1eevpTi9yvtMCXbNnx1Xt/EWnGLJaUzAN6jrEkMckO96jD2Te629QrgOaKTnq8tyw2smN6ji6fkRfTYX5hGNPComHsNj/zCVB1obqDfgG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKQUofVo/lq3zKkMWa0drPyKXMNxJ2cQTwtZKinZqcI=;
 b=mFDTzcr4wjhlBRmC6uYbcjrNMHOLGUIhbTrhBNIXAnS/w8YjkUw7exM6c9uU9QFDTuJBMnCayLlj7b1SgNrKzTHjLn7Saf/2BncO5VzhBl/6jRf7oUuIsaxJ8nmisgRHOQRyYUhQt59pCx5ZTaKSQu4RVjM2VSD8s2rsHjaTRZYhR/EozFo37Ma++ZrbLLuTR/yfF/fqWSX4JF9Shu2VjHMr0wtAmmXsaqXJzg3qmr6o6RtImPPfikaUifqOHEP6DJ8tN9780P7+egEgC5dvQo3+C5gRawABC98mzHyzadGMkDtsGMGyAjpVauaXDqouPiG1UXn+mNaPC2E7vD/WFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKQUofVo/lq3zKkMWa0drPyKXMNxJ2cQTwtZKinZqcI=;
 b=qHO3qMKcBIyS5+1MvYIPp+yxK2FCyB6Ltdi+6ELA6psmE03kR5wok++2risufekkJieXEqBUWNludbARmz6LDd8lFijdTI1ujnVWguE6PXUOPQilnGppq3F+tqgb5PGLPZO63IWTju4lPP3Ht2zS6esmekhIaGIq+FmMeJGerIo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS7P286MB6859.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42c::16)
 by OSCP286MB4488.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:329::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:12:14 +0000
Received: from OS7P286MB6859.JPNP286.PROD.OUTLOOK.COM
 ([fe80::68ab:417:9dec:6c25]) by OS7P286MB6859.JPNP286.PROD.OUTLOOK.COM
 ([fe80::68ab:417:9dec:6c25%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:12:14 +0000
Date: Thu, 24 Sep 2026 01:12:13 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] PCI: rcar-gen4: Add Root Port reset support
Message-ID: <rdeabz72swub66aykpwmzqotzcr7pncdqnla6tduki2ex5y3yu@vxb6h7w2uueo>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-7-den@valinux.co.jp>
 <4e7d7c8b-3daa-4ab3-9de1-51468975c28d@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7d7c8b-3daa-4ab3-9de1-51468975c28d@mailbox.org>
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To OS7P286MB6859.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:42c::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7P286MB6859:EE_|OSCP286MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 332c7777-16bc-40ae-0509-08df198d6e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|7416014|1800799024|366016|376014|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dx0MvGLV6XPuepKjS2olgXFslZ+zGOhOEXnt7hbFit0LjmurMHx1Ej3KFRUqnFYWUYL/3i3iKhFhmKgIrPEqz9jLF2EMKoZK3MjGgwkt7pwn0lHIMLxXdC3+O7iWtiaCNtjOr8tH6DJUCnr0WbHEqKScrEW1FxsRG2D7FiNTQLrUDwapCWoUUdvmVsepUwc71m94d79bwSKPodJKo7GENLtSiS6TOJ/S04BNv3ZIQOQoFbZOld2zA210sKKuquO6KBVSccHeMHMoEPP6AvLyDmDpfIe+2mkWgyc0pKiyH6npToo3CxUMV1tS15bPnCwTY3J5JMvf2pjIvQt1cpHkYfK2cMhQIi5CGnmAg1CSj3imn1YVqlDQDfQyVt+M9wkoaT6e/ISM+ZqPCNcRUcK2sEAhrE/wHRR1g33O94gK99EzNGbgBCz+MIHVvqpMgCaNoLG+TJ9OrNZdmxtxnfzW1JNbThPVnmN++hdZJvMUzKhQayZgQwT9nPE1EkRSCx9VpSN3s8WRlHuBBzjhZ0orQs3wsqpEQCtxeAoHA2vXLrTaQDVqfDpkQqXo1jBkrtjAiE/IX7dZ3I2XoY8+Z5RNSfzlljLtQnlrdJbIYN3wsjKoqR5AY4dWCpEzAYx/itLELB0BzhOFVi4e9g3QEFdBNvRU1CUBobfuuuKrB2lR+Qs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7P286MB6859.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(7416014)(1800799024)(366016)(376014)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3UBGp4dnC4Q2VUId2Zcd1QMQQmW6hd3HqIpByDxLSdhvHmlksoNW9g2MUoe1?=
 =?us-ascii?Q?I3MQTF32AcEEyZEkpYRCt/NWJzZBURkF576vVcoCr67K/9JeiIhs6fS5gFMh?=
 =?us-ascii?Q?kfgMZfdpk0wMFLC7uCdjYVxOYStnlwbXUAonz3q58rWHQkGsnH/RfLDvIBg5?=
 =?us-ascii?Q?MS/1isNvgUIb+QSfQl06qq6U3NK+6gbJSydZB97EwcqODmuZP1lCgNpOW8hj?=
 =?us-ascii?Q?pM2Eb/yMoinyvC0zn1LP6aGuUTsK9Ta1JE54DvywT8MghJ8MdrSfuMlrbh5T?=
 =?us-ascii?Q?2bog/TzeTmRHZ2T91I8c1Hw14+2/c7vqAgEcfnv15Q+5oOkixGEghnvKq1Qt?=
 =?us-ascii?Q?w0Ul1K53pJe9e3SiBmG0aej+e08LFdAz/+9/aFn0BXDgIELzslytQrUgFRNp?=
 =?us-ascii?Q?EeXYXZ+42bibqPBi6I8X2pQY67IzZCgPwVyEXG6oCpbwP9EW8sFgzYZbJLUy?=
 =?us-ascii?Q?ZR1RZ6yk2Ihvp/zgagdQOt3SDJPiMM1ROod8zW+FSK5n8K/XWYZrrHhMPYVk?=
 =?us-ascii?Q?UaRpjfPUrKqoi1LNVr+dNh4zXM3gp0WBmB9aUbY2hWuDfTKKWjqX9C9CusY3?=
 =?us-ascii?Q?aNdo6tSSFdZ0VZnkHVyZbCQ95nQAMzobh1UKiTfEaR1WtECibQDo+B892WhQ?=
 =?us-ascii?Q?MpjDsqR2h2UoPT8gn/PgiOU5T882zh4kI/kN19WVhgAWogLP5hgv8QPe/vH2?=
 =?us-ascii?Q?0Cw+niJ443PbOqw+4KxxWg6xcuwQtiijJhjKblAJ2bcDTg/7gxlFe0J0Ckfg?=
 =?us-ascii?Q?C2xRUc6imZCpEfPJZbP+i4keHlno6W/WJ7QVSYYv/SzWvxuLvNgAdI35ngn7?=
 =?us-ascii?Q?VH1zWXMDCtnSuTqXPtY9lc50qAqvYZ22kQBCNffB7vmdqmL8/UYxgjJy2HLl?=
 =?us-ascii?Q?np/coh6g7eHdhfPgy3sa1R4ItJi2X+gYHmxblNuvk7OS7e+oXMAxUu0cYtYd?=
 =?us-ascii?Q?bHqWrNnkmOmsk3mCs+Ih0BzaX2pPN4CK1xeIVIllOoaGWNHQPAWJx5qXgpOy?=
 =?us-ascii?Q?SKM6D6X4x9H/H29ONMQvbFlexOQpEGffyg7QJE5kBwvy3yujTWEqcLDHTERT?=
 =?us-ascii?Q?zdJA3c6XLgfPd5/6KffMOVXDKmImi6pl1WtrRbIURQoqbwau4SD3LBBkfolL?=
 =?us-ascii?Q?Q0z2FLskwEs8H9kHpr8EtZh0ZOwAjGY1isvtNMuNrVg+S6xrEKepMjBI8I9S?=
 =?us-ascii?Q?uTE4IMPdbMBFrc2nidvRH2ubL/cYyj2cGCJ6t2aYtlhkMLIqGSYc2RGPmA0k?=
 =?us-ascii?Q?Y5xAVVsWlPXjbDEqk/2+0BgOu2m7N3A16JOHB4uue6zb62OfcOt8PHrNqaty?=
 =?us-ascii?Q?6ZeUxfGEGSinsisVrqX2lue8fgg86hWbIJNK7U1mJK0ft8p7YKh+lLKBZjae?=
 =?us-ascii?Q?Pb5a7Fbq6+PfemOJEvYOWdZAGFkKL7khI0INvcJT/cVLxDIzJrbPl/dS8YYs?=
 =?us-ascii?Q?XU36xJu5lIPJQtjrz47bf8TVZ3ISZ+8Lt1xHSz9+MyaNjEoURXMT4TusfahZ?=
 =?us-ascii?Q?8l2RfIMO23TFyWhcNrO6TdRt+EJsH2Eh5lpXiVw2NhZXajgH5ReVbgKmi3r+?=
 =?us-ascii?Q?Bmx6Kj1qSTSIJ7Yvyb6RkcX0qHEVxd/bXXOWXWrhTggYR+sgF/3y9a+GbjD+?=
 =?us-ascii?Q?2+gd5qBD6GbITjEKgd5OofwPn1Xhv4g5L5dgj/gAkRgnrQOrK5hc9hImPQZE?=
 =?us-ascii?Q?0iiRo3htvILSOfHM1Aa2DSgBrdxLL3xpmcPVm8U5GBSQAn2GcNe41oXuCUZU?=
 =?us-ascii?Q?sERDkOfrisC5B1cpZ2FOkDOdTYOZXwUWRplgPafXmzK+moi8O1L7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 332c7777-16bc-40ae-0509-08df198d6e83
X-MS-Exchange-CrossTenant-AuthSource: OS7P286MB6859.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:12:14.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZARb666cIRA8wzrbzmbxbkHLek4jxtcVINcP9FGSPKp5cNe3KzughMGP7doaJL3TDxAGCVC/0PmLG3vt6cI5LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4488

On Tue, Sep 22, 2026 at 11:22:01PM +0200, Marek Vasut wrote:
> On 9/18/26 5:20 AM, Koichiro Den wrote:
> 
> [...]
> 
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> 
> [...]
> 
> > @@ -90,12 +91,22 @@ struct rcar_gen4_pcie_drvdata {
> >   	enum dw_pcie_device_mode mode;
> >   };
> > +enum rcar_gen4_pcie_state {
> > +	/* The controller is being reset and reinitialized */
> > +	RCAR_PCIE_RESETTING,
> > +};
> > +
> >   struct rcar_gen4_pcie {
> >   	struct dw_pcie dw;
> >   	void __iomem *base;
> >   	void __iomem *phy_base;
> >   	struct platform_device *pdev;
> >   	const struct rcar_gen4_pcie_drvdata *drvdata;
> > +	unsigned long state;
> 
> Can we simply use boolean flags here in struct rcar_gen4_pcie, instead of
> the enum rcar_gen4_pcie_state ?

Sure! let me rework this for v2.

> 
> > +	/* Protects APP interrupt enable registers and their software state. */
> > +	raw_spinlock_t app_lock;
> > +	/* Serializes Root Port hardware reinitialization. */
> > +	struct mutex reset_lock;
> >   };
> >   #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
> > @@ -344,6 +355,33 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
> >   	return 0;
> >   }
> > +/* Whether the APP interrupt sources may currently be enabled. */
> > +static bool rcar_gen4_pcie_irqs_blocked(struct rcar_gen4_pcie *rcar)
> > +{
> > +	return !!rcar->state;
> > +}
> > +
> > +static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
> > +{
> > +	bool armed = !rcar_gen4_pcie_irqs_blocked(rcar);
> > +	u32 val;
> > +
> > +	lockdep_assert_held(&rcar->app_lock);
> > +
> > +	val = readl(rcar->base + PCIEINTSTS0EN);
> > +	val &= ~MSI_CTRL_INT;
> > +	if (armed && pci_msi_enabled())
> > +		val |= MSI_CTRL_INT;
> 
> Should this function cache the state of pci_msi_enabled() in struct
> rcar_gen4_pcie , so that in case rcar_gen4_pcie_irqs_blocked() reports MSIs
> as blocked at this point ...
> 
> > +	writel(val, rcar->base + PCIEINTSTS0EN);
> > +}
> > +
> > +static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
> > +{
> > +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> > +
> > +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
> 
> ... this function can enable MSIs once it is called and MSIs are no longer
> blocked ?

Even leaving aside rcar_gen4_pcie_resume_irqs(), which this patch introduces,
rcar_gen4_pcie_app_irq_sync() re-evaluates the blocked state and
pci_msi_enabled() on each call, so I would expect it to enable MSIs once
unblocked, provided pci_msi_enabled() is true.

Am I missing a case where a cached value would be needed?

For example, even if there were a race with quirk_disable_all_msi(), I'm not
sure caching the value would help.

Best regards,
Koichiro

> 
> > +}
> > +
> >   static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
> >   {
> >   	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> 
> [...]
> 
> -- 
> Best regards,
> Marek Vasut
