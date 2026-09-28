Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020098.outbound.protection.outlook.com [52.101.229.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F033A9C4;
	Mon, 28 Sep 2026 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567457; cv=fail; b=Keldj1DtPYg695A3W/3VCzDr4sfcYP2efIku9vyWHXItWtG46fI2NWgJZ0tidDSDPyYV2i5703pYq7mKgHCk4zpKZZ6LiUtasX6MHRPPqmykcvGC3BvxsNMNVUvJgqVwqA2Yy9Dp0WGeo/RZA4teuGd+RUnqbiwEbAnLwD75n5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567457; c=relaxed/simple;
	bh=uTYt9Lv7Oh/GgzqXu3Hap6J/m2pPNAK5ZdLROAqXEIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4lgx1GAkvIJzsM95Z8D0lIwY8+4LqLtGoNlwBXDeGKx+52KdTSEtnUP2KSSh3nEQqq6wXPBEO27DH3eqok0OHLixddqBgR9Gbmn8wBtmr6ChBZLP5aGejAIGabRdjuTO90qOog6dnsscclkNOSDl77OSfk14kGs5kjsS5ByCfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=I8ta24se; arc=fail smtp.client-ip=52.101.229.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="I8ta24se"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJt3Sp+XO/AV/QESeqzELyHp2WEupIgMlKev5Hkwlqad56rZAf8dDz2AFmtrM/BNnhPfu2Xa/WN3Oq3KpK/qY0Z4+I51v2k26j+iGSlrbDVSNx09uYqAPsEjsa1soHJy7KQ4HVe6uqOqj+o1xY6BCVLai8SdG9D7EQ9hQN4kT3S10NeBxYJBtQZEnNvbJt7V3rxtTDxrUf0kQ2tFwCE3o9iryjgLck40doruJ7G7NTCWWQz747keyH5tANfvG/s1ddQylIFR+xJSs7FQ4sBVJfeOqR4Ec/8MCs46alrsKdW3G868jOy5rKnFInzUMR0IGHEQY98O79OeQBiKXuyUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdEdz+k9fbv0rlaIlU7B6/CXfATpYT63BoQJp95MNz0=;
 b=QdQ7H1SsdFJfd5MGA37zs4g3ThPnm43IwNQMYaFFXDdfpvTHNcDRLlKip2j7f7HMNrz9oUBOPFcGV/CextBEBVgW1WMyzvHDB4DjopPrCJlNcM+gCFr2XB95BkDCexPLa3tF7ZhIx3RY/PAOxDfvCGQON/eQU6Zyrxuxq6GRNJphaUpcmGQBtP725UoJuqbhd4Wa64fHgyCjKPCQmgdJcLVmADFSxqN3SnUgF7NAHvStZVVdGgXY3txQi/DS0TYoCfVjQtw3aehZhNjoXsITnrgWyX7hQwBvr+9NsLOKMSWAu1V1FRBGgPQSja55mGsR+QA3G3qrUAq6K0wAgip6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdEdz+k9fbv0rlaIlU7B6/CXfATpYT63BoQJp95MNz0=;
 b=I8ta24sexQfxfyfxb/AUon7gQfA4Kf8DBjsMt4ZJvjYUBoIJB1V9wrZhd645dyrJOiD5Zrtsw+HXfC1U9NcHYg56e4wL8/0zEfI2N44F1BxX4i2sl6SLrlJtWMZPvH66jiHb5VcFU9dpcljsjeUZihD6klqjepMdXftHKK09eQ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB2750.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:50:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:50:51 +0000
Date: Mon, 28 Sep 2026 12:50:50 +0900
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
Message-ID: <lic2nmokugkeu3r6zgjux5a4p2o3545vs2kaijfth3f7rqipz2@ppokxnd7t3ai>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-7-den@valinux.co.jp>
 <4e7d7c8b-3daa-4ab3-9de1-51468975c28d@mailbox.org>
 <rdeabz72swub66aykpwmzqotzcr7pncdqnla6tduki2ex5y3yu@vxb6h7w2uueo>
 <502bbcc9-956b-497f-822d-c7f70340d1d0@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502bbcc9-956b-497f-822d-c7f70340d1d0@mailbox.org>
X-ClientProxiedBy: TY6P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB2750:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7e403b-6099-4140-5680-08df1d13b064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QDdPgUdZY5geEPMlWrAYsWNGtA03DbyQYYxpt++huLhsjKiynp0I593gjL4B2q58k8PQwIhtn63HZsOCOw72XPhrrt5MNQh2Os//LoG6LO6j/U50OLXWK00bWjB69dVxeWQOQsHC/wkEflyTCriB4uguiDTcCpHvWRMXY5HVBrfINSrGUROPHOUTFtX+AIkOC/RVHANIkvlbAT9R4YNEqGYrcJTscw9zOVTh6F5C8dYsuDNQ666FfDEPzIzG1lIS2FnzZMQteoBtdAEtG8Zn5SN+s8ANhXiEkD1oc2HNZFbHkWO9FgihV34NxmA0p3kKxNAxmJqehnxImumnHr3LplqnzjpUe73s+faFmpHKFanfq+En5UOifXEnuO1XiSL3wkkIRO/lWRlVlz1l6dm662dQdI+9D5SGmrcMLKaEi4mDymEYPw3N4GKXni/HFQygpwfjVtQneQ2jOZjvHVRRViqzsNgHd4zq7t9thyFl3ePAF5alcrrQwABL+SFSyWWoizzM1yWyb5aq2C94DNuO4MVv/LovMolUsZ0cU2XTbEgDkxHk4xF4If2X5FmWOlhgLUP03CBni3p7NV6znr6WsPpz1rrn9r93QZk69Kqm7p+ydyvtuAHxDAY6r1hnE4hrDfXu5cl3zjUT+7LYBYmpt+rSnyUhm85j6a437+PUTOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HeYQO96qbRvLgk92+jimzqll8o+WuUedh0lwCrjWFpyN70v4Izt1Hi5kZslg?=
 =?us-ascii?Q?hsv9J+Acb0nJBaGwIybkZOFv8s3f5u9E1JKt5Eam0ZbCP3Wk/+M8k8LNvXGW?=
 =?us-ascii?Q?fzcA7uh5FGOqAW7in8qUzFKY0/u8V09sdlSinPf4ulS/X2VgU3pDQX4GsnKZ?=
 =?us-ascii?Q?khDf6XW0qCRCnjflnlNMnPcW43XnoCMXHY9tkrGOCcPh/jZ+PG+1A7SVkKcC?=
 =?us-ascii?Q?6zA5jZezKL8jsy4x4ovnFn3B1rBH+tpPmnqk24Bh01lyldDvufP2q070qL8v?=
 =?us-ascii?Q?CQZCA2HQQShyTfeh2A19S6bL363XcwQel9krvxtEfwLEPzIj30uBAaG552KM?=
 =?us-ascii?Q?5VrBzm6579H0zBRufTjuP4hR0abbC0SoLZWjje7zT6da9f5UTsSqpPMt3kU2?=
 =?us-ascii?Q?GZnwM10zOgixjcOZt0a8XSbpTt/0NjXm0wuZ1gHLRtldnoJTwvnsvQGlXQ78?=
 =?us-ascii?Q?qVzaRf77HV9Bmix3If9bvBleWCW/dsdYXMDuedxGZsbt6JIQ8JtD3qp01jRt?=
 =?us-ascii?Q?sCenu18zcIPEst+qSK/KcB1Ap3Ieq6zJR8ayHnwtJ4pNwYIwBu0onT+zAHEk?=
 =?us-ascii?Q?kCXb3XedmpkSFDBJ/dhCZZPUVn6HGdCYndGybaiuGDJ9fSpOpTwxOpBunA1v?=
 =?us-ascii?Q?OTVaM5v/tDFgIlHV58AQrmIrFBmjuSL3IHlajMtLhVybgYHhbxuS6IfENOth?=
 =?us-ascii?Q?DmtGba4OJLuznZyMZ5U4UgAR+Rf3Y3WoW09+oV0ZHkM2HN9EtfyjyOzSZQZO?=
 =?us-ascii?Q?yH4QCKUwCYvgzSC3FXgQSokj0WJWkIIrULa9oaQkjVrwCvFfLUnxSznJmqd0?=
 =?us-ascii?Q?ZWclbOih82MLnnVU1l6P7jaYnLMQI4L+5VW8hc6Cio7y/m205LPW2SFOjR1l?=
 =?us-ascii?Q?GAqqT7M8IrH78W+hNSSdkHVVFkwTcQlookAN4izpZuFI0OhMtFHKRhnD2aoI?=
 =?us-ascii?Q?85a+0QVka5QvKIuCm1uL5z73lagbQoiHW3JsVqxUUrtXMCnAJoLbcjk/oMWm?=
 =?us-ascii?Q?xLGsnR1Q/PgwTC0+7Ds3tVFXCGc74WeTZEGAjRt7j5+jIotfG+qs95si9VmW?=
 =?us-ascii?Q?YUFxa2r541yMOk5t5Tp7e0c2NLpFY/CNaDSeEZ0HJmS0XHmT5lpZSVHVdRQW?=
 =?us-ascii?Q?qp7mAO1pjl2BpcQIp+rIJJANb6YKzvAUD9b8NsOLNTn15n4x4TzdHjjiGHC7?=
 =?us-ascii?Q?bzus7jpNrHZ7EIqYXhbyDtltT7Ynbssh70CHVe37sGc5lMjfMud3AUB7s3Ke?=
 =?us-ascii?Q?se/lbzzAIEKqcD+abxbQzM+U4RHSkpyfs2cabDStCHoxUZJilfZkme/u9n5Y?=
 =?us-ascii?Q?QPii/JKMYrD8rgtvY2Fw1/ilOKt8vOkq3zlzqBz8+N5cU5SULQCl2yQ1Mjul?=
 =?us-ascii?Q?w+nTWcIEsqVgUYJ8T0UiRenkMnDNvn6fNsDmh5iPQRfm407bKKrnmutU5eGM?=
 =?us-ascii?Q?mmHHrxj90cBUJkhlVzb50SjLFcHqeiGWWTyBwH4skWifwny2KCWKP7CqWTdi?=
 =?us-ascii?Q?coXAOKbrjYFqSUjeoQkSwH8+ebDENLcbKKEoT52FmnbWDzjObb4V3TXUW3mn?=
 =?us-ascii?Q?rX5Y7moj9fn2LlIf/T/e6v8EILgLQ2IlmHasK+ejpUh4DdK5l73qZPp7n6Nn?=
 =?us-ascii?Q?sM74AgFSHnWyk7L3A7XDBZ5/OeQhS7ap4Mh/G/0Xj1JlTx4JcbcAa+8UN0Yn?=
 =?us-ascii?Q?jJKPPXLelZ+3Nm6FiohyWEHzN0+FbxMel51l125wPqakmOwMFJqVwekI2CT1?=
 =?us-ascii?Q?J3xwqlJ1g8x25+E5/2Ia++8pOAR7U7RMbM76SYiWgkVny0VOObV6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7e403b-6099-4140-5680-08df1d13b064
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:50:51.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zm4/859iNzc9jxhLVtGuoEeLw1bIXc1bMb1OdrDzkIfyl2WAPypgp3kw8v6dWyOyDgBYTDr7sajgfgN1NzjeOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2750

On Mon, Sep 28, 2026 at 12:25:00AM +0200, Marek Vasut wrote:
> On 9/23/26 6:12 PM, Koichiro Den wrote:
> 
> Hello Den-san,
> 
> > > > @@ -90,12 +91,22 @@ struct rcar_gen4_pcie_drvdata {
> > > >    	enum dw_pcie_device_mode mode;
> > > >    };
> > > > +enum rcar_gen4_pcie_state {
> > > > +	/* The controller is being reset and reinitialized */
> > > > +	RCAR_PCIE_RESETTING,
> > > > +};
> > > > +
> > > >    struct rcar_gen4_pcie {
> > > >    	struct dw_pcie dw;
> > > >    	void __iomem *base;
> > > >    	void __iomem *phy_base;
> > > >    	struct platform_device *pdev;
> > > >    	const struct rcar_gen4_pcie_drvdata *drvdata;
> > > > +	unsigned long state;
> > > 
> > > Can we simply use boolean flags here in struct rcar_gen4_pcie, instead of
> > > the enum rcar_gen4_pcie_state ?
> > 
> > Sure! let me rework this for v2.
> 
> Thank you.
> 
> > > > +	/* Protects APP interrupt enable registers and their software state. */
> > > > +	raw_spinlock_t app_lock;
> > > > +	/* Serializes Root Port hardware reinitialization. */
> > > > +	struct mutex reset_lock;
> > > >    };
> > > >    #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
> > > > @@ -344,6 +355,33 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
> > > >    	return 0;
> > > >    }
> > > > +/* Whether the APP interrupt sources may currently be enabled. */
> > > > +static bool rcar_gen4_pcie_irqs_blocked(struct rcar_gen4_pcie *rcar)
> > > > +{
> > > > +	return !!rcar->state;
> > > > +}
> > > > +
> > > > +static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
> > > > +{
> > > > +	bool armed = !rcar_gen4_pcie_irqs_blocked(rcar);
> > > > +	u32 val;
> > > > +
> > > > +	lockdep_assert_held(&rcar->app_lock);
> > > > +
> > > > +	val = readl(rcar->base + PCIEINTSTS0EN);
> > > > +	val &= ~MSI_CTRL_INT;
> > > > +	if (armed && pci_msi_enabled())
> > > > +		val |= MSI_CTRL_INT;
> > > 
> > > Should this function cache the state of pci_msi_enabled() in struct
> > > rcar_gen4_pcie , so that in case rcar_gen4_pcie_irqs_blocked() reports MSIs
> > > as blocked at this point ...
> > > 
> > > > +	writel(val, rcar->base + PCIEINTSTS0EN);
> > > > +}
> > > > +
> > > > +static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
> > > > +{
> > > > +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> > > > +
> > > > +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
> > > 
> > > ... this function can enable MSIs once it is called and MSIs are no longer
> > > blocked ?
> > 
> > Even leaving aside rcar_gen4_pcie_resume_irqs(), which this patch introduces,
> > rcar_gen4_pcie_app_irq_sync() re-evaluates the blocked state and
> > pci_msi_enabled() on each call, so I would expect it to enable MSIs once
> > unblocked, provided pci_msi_enabled() is true.
> > 
> > Am I missing a case where a cached value would be needed?
> > 
> > For example, even if there were a race with quirk_disable_all_msi(), I'm not
> > sure caching the value would help.
> 
> I think there might be a possible issue, please consider this:
> 
> - The code enters rcar_gen4_pcie_reset_root_port() with MSI disabled
>   (register PCIEINTSTS0EN bit MSI_CTRL_INT is unset)
> - rcar_gen4_pcie_quiesce_irqs() is called, updates rcar->state
> - rcar_gen4_pcie_resume_irqs() is called on exit from
>   rcar_gen4_pcie_reset_root_port(), updates rcar->state again,
>   and calls rcar_gen4_pcie_app_irq_sync_locked()
> - At this point, I think MSI might be enabled instead of disabled ?
>   (register PCIEINTSTS0EN bit MSI_CTRL_INT is SET)
> 
> Is that correct ?

I understand, but I'm still unsure when MSI_CTRL_INT should remain clear after
a successful reset, with pci_msi_enabled() still true. And if there is such a
case, wouldn't we need to preserve the intended enable state of MSI_CTRL_INT,
rather than cache pci_msi_enabled()?

Best regards,
Koichiro

> 
> Please correct me if I am wrong.
> 
> -- 
> Best regards,
> Marek Vasut
