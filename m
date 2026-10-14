Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB14EF14D;
	Wed, 14 Oct 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987283; cv=fail; b=fMFB7pjgPRrA8FaAIHCNfwhElJPdpM1jhNEO8uDPQh894oSaMpb8ZU24UGuBIRXdp5/5vsGJ3uR4Sspry3sKMcN6nBAqjqUcvS8YxrRY2uoFVB0M9B97hOyVC1XkRNlWzQhKFqtodpanyyjOP6RvegrEfI4FFzGxabKBtyH/Z0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987283; c=relaxed/simple;
	bh=PN/79TtKG1Twx/if6loW28TPYH3F06rhG3sa7PcQiGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HK9jsbNIchweXOo0vKvx4dSX9jq8spLRSowbW07PiYNsA7LIjHjAtrq7yldKrvQyZzAArAc9KvBulNq4f+fdPyHxUnfYAPEnsNGJnDaWJxfRp6DHDJtrPctOpW4zdtfICdtWJeF95JQEON/jPOw85U9/hVlCsW76ea2BUyzGJRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I2nuYJJv; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I2nuYJJv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLqBHUx2iXyUx0YPWorspLmuqp72cNpoiVctqwPnb/baq+b8JFJmiu/UDyh66GWBbd+SkCQzwTkShHoageKaL5oUoC2lrahVG/ymRXJAdRjJSE+mZg41BoXBmA+UkHWlp25pH5vR4I3PK3W5l1SBGjCHSy5Xq8D01KgTif7Q0NTG/GnOw6MOaIucLtb3iaAxNKrl0EFC+lYbVSCBI+x4Bb3zCuzTHfqb4n9gTKxN9cL9IR7oL/uPt54P+nu2Vofz27H+X8VC1GvCPYaDMDx9/0UDq0Dx0i972gOqQz2vPTGlX8+wfKQ289em3ZZgmCFmikK2+gTe75iQPOK0BuIlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y98FdFXP6lNVVSuw4Al/ZqHmCmhFcPmxUMackPfNcdg=;
 b=rz1sxN1YScoJ6mg8zc3LhW9dYVu8DW6UVuTxIFsJQf1qyGPyPGieqNRex3iqSwp6/F6oQ8dPr43CXguGGymRmEDjUUT5lKokPmi+JLPQzGKZAp08DtghWVbBBwgE1QF8CVny48Ios/i0PYhQb/yVDiN1UVElLsG+R9FvBkSxvyM8UzVjKLXr7UDukrZ1adzWZ5RueZmlCeC7CcwfH1eXLl1FuqzXpIlgw9zZXWW6p5B0SbrGwsIMlxndZPUsn6TBm5vizar4FjifOfgp8XLEhrh0xJyZ2ELgUYXTJK4R5ODJUaTh5Zu3iQL7AWI2h27xEGsGOGx+2e517cXpczsYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y98FdFXP6lNVVSuw4Al/ZqHmCmhFcPmxUMackPfNcdg=;
 b=I2nuYJJvOlctjIeY2K098zVxLJD3Y47lq1ElZY3skq57E3RuHS2Ll263lQyfxS7+skMWYLF3jcbyrG7p95Fe52Ob5D5M2HAXfeXONgFBXPztdE3JvL/lKfjD4gThvzMtaWahZmqUNLM1ai3KRJyZT91y/6n1lA3vv/RYGU7QL92GTmxcdEtMUHQsiW0m6mjg+bfwVmr8tpnOs+SfdLMnquIFg8B+ESPbIsbcfaWSk/FVI8DW1Tq6GXrlM+If+cWHE4hwNhvH/78obPrY0/gaEiu4Wnc1PTHrTtmne/O3B+evdmY/UQYOL68tYEPvSUQfSXN05+6lKPQQZMxWuS0tbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by BR0PR04MB672694.eurprd04.prod.outlook.com (2603:10a6:2c8:49::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:14:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 14:14:32 +0000
Date: Wed, 14 Oct 2026 09:14:15 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bogdan Hamciuc <bogdan.hamciuc@nxp.com>,
	Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	imx@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC v3 01/12] dt-bindings: phy: Add NXP S32G SerDes
 subsystem
Message-ID: <as-ON6s8sNjQC9NP@SMW015318>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-1-9d68868c1e89@oss.nxp.com>
 <as0tiQwquNkdlF2i@SMW015318>
 <as5C7o1joORcdesQ@lsv051416.swis.nl-cdc01.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5C7o1joORcdesQ@lsv051416.swis.nl-cdc01.nxp.com>
X-ClientProxiedBy: CY5PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:930:69::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|BR0PR04MB672694:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e211a71-4092-4569-dc7c-08df29fd777b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|19092799006|366016|376014|261009223027099003|10067099003|3023799007|4143699003|11063799006|5023799004|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iqMi9E1CI8+ZHT4bf1CGCFjhTyhtGc7XZ1Nau/DLYqSUFE3to6qHDos+vLxmA4t/N+oVTc1h0dX7+wqrggRRvN0Ygp9pQFNgzZR65pDZ+EHGtnH6Ey6yZLXe4FPGs6aFDLK8rCNMdHq0vL9tddzs215wT0J2cjcNX9H8c+r0eaU+EnSpUxr7aWkQq9r02fJB5lE1UKvV2mAe7sHfemHyfaOTwJutYWM+mZxnx7xi9pZw0qcwe9RsW1vsQ5Gcn4nko/rdo5JwJZaGJMTsys5dKlv+kt1m1LwhxkmNr14cFxqt62YTI4X2PuuQ7Qwu5LcIkmit81zOiDjtzBbAQOr0Zqn7P8w0ddYa60dbNl0bRClDt0Ban3Mu/bpokGssZz+Y/IA299o/s4FLlvfo+zlfgv/P+52Sr7kDGTTtFj+9ufeK2TTKq5iEw13cnO4VqfMTVj5/aCCW0CZqxpOhDtqg1Z1gXEM2hOfTcB5WEHUwtDQveIuXypokEqNlDVjTtml4rQt82/zKxNPK4N4YqeIaeHRJTdsPhWJq3QzBvInNCuIqcWuLdrbZiZVMv+5+XhCA8ESpMD6ts7cAy3fzcRLzlF6hlTq+pUS9FHUpSh3D7CyMtJ5b9dwDAUNGEVc6/Lto
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(19092799006)(366016)(376014)(261009223027099003)(10067099003)(3023799007)(4143699003)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZb3KyE7u/U2W2UkG+hqSgnTIuPqUukPgDfjVESg+bn/zCqEDjfdJPXi/1Uw?=
 =?us-ascii?Q?ABiZ3+7qQXMKoJ8bQ8EBZV9ox7isY8PlkHkcKaTiKqOoeA3zIiMATcWRnuxw?=
 =?us-ascii?Q?smBWUtS97w/rAFPwdsa/Qqeu+2jES1epyMsdNW9j1K2/d5Fpr+Q7YxZIhWaT?=
 =?us-ascii?Q?uroObGNeKhIxtnfQB0nYJ590sxFlAa5SWKon/bJJ4x6YhB/vj0ogBpObz/z2?=
 =?us-ascii?Q?vd5F7oDXD3nczv6KjaenuVkQCuPJuWIHZ+GZwkjzlTVn+ubAR2hJKPwMXJod?=
 =?us-ascii?Q?TgJK4FyoC92tX1GoimpIFA1AADvxBOZ03X2aztgkJheB7eOK4CimI0wR355c?=
 =?us-ascii?Q?1RBvLq9Bgcs1JkL1liIXuOueKglrkv1EwKzWFKjTirfPt/J8GZnXFYxOLefu?=
 =?us-ascii?Q?Kx+gNAU4RiziFqUiB/pEiKhCmBd/hJJzc3DRi8WNkUiNr1+Ys9t2KbjN5Uxg?=
 =?us-ascii?Q?nmuzlxoyxBRq0/HqGjt1lplLmcdewz57nBbz7NUeSiQ20sh/dCiUyBMxu2rp?=
 =?us-ascii?Q?5Wni5dLXLq+RI3D1LnoAiUg+HM08rN9qivte5LbMNHr2HiJqj1OdO9tDdI3Q?=
 =?us-ascii?Q?i+JVudZuyE9HNULxhNuJ3QrgRnTLb236s1FSqutY4OCUHYNDS6Ip7AGspsyJ?=
 =?us-ascii?Q?dOYI1V1UIKXZtEL4S729QLH2Z1dCKEsunBevUlDgKeMLfxbp6x0P+NJooJML?=
 =?us-ascii?Q?uLvBPdZ+KIYJuMvu4qGUWQlnjLmujahl4JxNQjbtcwgDvnp5GNNVREkPHJ67?=
 =?us-ascii?Q?9/s0x5nEfZ7YG3JemVXGqyuCdZ2qQJS7nXokdW2qA5JdxiPsDYVsJhac6i8b?=
 =?us-ascii?Q?vQuqUZfvnNrZtaYnG6MI14pSvX5MBWeaH0hoosrzqzHXcvSND0pkoudNqNhI?=
 =?us-ascii?Q?1M+nYDaBSksQMISFEKhsNgXdC8U40qJoYmCgzs7e68df4RN84dAewKxqQDc/?=
 =?us-ascii?Q?XwfylmJbom+73OVTOh60v/ddw9biqeczS4riePbwyX4DSJH84e/y6y2cLhFi?=
 =?us-ascii?Q?UVq0TneAbx9Vb09mY4jtJUlvi2o3TQzTh56sFGfXYcB5A2m5kFFfZph132UQ?=
 =?us-ascii?Q?ZA2V8pyxUXSmsx9NO0xSkSHW1OfqyO4/OnjtQ/u9FNPof0iXDjczZVT7bw7l?=
 =?us-ascii?Q?beoxpKZLbMnpm+TpABPhOlnsgRbYatCNujIUcXBNqm5GfzuqjVDL/2qYaNec?=
 =?us-ascii?Q?nFQtNJ91EzvVadwanwA3mBQcQOoyXKdymnN8egzruwTOI+Y796LxuNi4Eh8l?=
 =?us-ascii?Q?ohKRlLxgazVoD8j7gF1Fnb48ELCUkAipnPkCmsr1qKCeR6d6SePIrXna3cgs?=
 =?us-ascii?Q?rJPE6gTcnb+j4vOWFqoVOpQPpc8TTuy3Wp1N3JtT36izvKk04mcOsIKCaxlx?=
 =?us-ascii?Q?CVQ6NIwhX4OVmocsvSYAgEGRyw0u7OPhMv9tXDjmHPfIM1vCLpUNSwIN+Q07?=
 =?us-ascii?Q?dEiLDEyDrwHD06lbLB5a5l5Vs8B6trhQgdX+oG+GbM9KhGwnVoyYGtAYGgdb?=
 =?us-ascii?Q?rbp0CtDKkNc5azwkf1tvyVnd83fkAtw7/yf4NeEPdTf6bksnyL1SUiCTth+b?=
 =?us-ascii?Q?winbqyNMlR4b1QwTlOGbJ3Sev8y7oO0eGbyXKbnNzO9zq29tKlQvbkBkOlaD?=
 =?us-ascii?Q?UX3ZQY6MnzkWJClcgrw+Nh4zL6aDqBn4MzZHxWbP7Jsh9zxON88Y68lur2D8?=
 =?us-ascii?Q?32fdr003fPJRi1bAnR1KO34+HNZz01th8hgNoi6TPG3m4v+cViy4Am4xyjrZ?=
 =?us-ascii?Q?C8LyZ8bm+0sozq690SUzeNBsfobjyidkp+vXTjKmPJaJWro9abVY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e211a71-4092-4569-dc7c-08df29fd777b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:14:32.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M9bjZCrrVK6Oix02h3lHDishrjZt1IeTyhBLKLynv+l5/rcuM6ULuFvCpWDPHRdNJ0+qqxZmKFK4jm6aG521yZWrfKGP9Upo4WGsS35foYgrYo3dlXKxKBoVRHzb5ju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB672694

On Tue, Oct 13, 2026 at 04:40:46PM +0200, Jan Petrous wrote:
> On Mon, Oct 12, 2026 at 01:57:13PM -0500, Frank Li wrote:
> > On Sat, Sep 19, 2026 at 08:54:29AM +0200, Jan Petrous via B4 Relay wrote:
> > > [You don't often get email from devnull+jan.petrous.oss.nxp.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > >
> > > The S32G SerDes subsystem multiplexes two lanes between a PCIe PHY and
> > > two DesignWare XPCS instances. Describe it with one node per SerDes and
> > > one child node per lane.
> > >
> > > Compared to the previous revision, the vendor nxp,sys-mode property is
> > > removed: the SS_RW_REG_0[SUBSYS_MODE] value is fully derivable from the
> > > child-node lane mux and the XPCS instance routing (nxp,xpcs-instance).
> > > Each working mode described here has a unique lane mux, so the mode is
> > > a pure function of the child nodes. The reference-clock rate is
> > > validated against the derived mode; it is not used to select it.
> > >
> > > The 3.125 Gbit/s working modes are deliberately not described yet.
> > > Distinguishing them from the 1.25 Gbit/s dual-XPCS mode requires a
> > > per-lane 2500BASE-X capability that this binding does not express, and
> > > the reference clock does not distinguish them either - both accept 100
> > > or 125 MHz. They are added by the 2500BASE-X follow-up.
> > >
> > > Only the PCIe lane child gets '#phy-cells'. An XPCS lane is not a
> > > generic PHY provider; the Ethernet controller references it through the
> > > standard pcs-handle property instead.
> >
> > Is it possible Ether controller use standard phy interface? of use standard
> > pcs-handle to phy convertion
> >
> > pcs-handle = <&pcs>
> >
> > pcs: pcs = {
> > 	compatible = "pcs-to-phy";
> > 	phys = <&phy ...>;
> > }
> >
>
> The MAC needs a phylink_pcs, not a PHY: the XPCS does the C37 autoneg
> and link state. pcs-handle is the standard property for that, and in
> v4 the XPCS is driven by pcs-xpcs. The lane mux is fixed before the
> SerDes reset is released, so the MAC has nothing to set on a generic
> PHY, and a "pcs-to-phy" node would describe a block the SoC does not
> have.
>
> > >
> > > S32G2 and S32G3 use distinct compatibles without fallback because the
> > > full reference-manual mode tables differ per SoC and per SerDes
> > > instance.
> > >
> > > Co-developed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > > ---
> > >  .../devicetree/bindings/phy/nxp,s32g-serdes.yaml   | 258 +++++++++++++++++++++
> > >  1 file changed, 258 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> > > new file mode 100644
> > > index 000000000000..6343d01bfde4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> > > @@ -0,0 +1,258 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/nxp,s32g-serdes.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP S32G2xxx/S32G3xxx SerDes PHY subsystem
> > > +
> > > +maintainers:
> > > +  - Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > > +  - Jan Petrous <jan.petrous@oss.nxp.com>
> > > +
> > > +description: |
> > > +  The SerDes subsystem multiplexes two SerDes lanes between one PCIe
> > > +  controller PHY and two Synopsys DesignWare XPCS (Ethernet PCS) instances,
> > > +  behind a shared 2-lane combo PHY. The active routing is selected by the
> > > +  SS_RW_REG_0[SUBSYS_MODE] field.
> > > +
> > > +  Reference-manual working modes described by this binding:
> > > +
> > > +  Mode  Lane0   Lane1   PHY refclk (MHz)  Description
> > > +  ------------------------------------------------------------
> > > +  0     PCIe    PCIe    100               PCIe x2
> > > +  1     PCIe    XPCS0   100               PCIe x1 + SGMII
> > > +  2     PCIe    XPCS1   100               PCIe x1 + SGMII
> > > +  3     XPCS0   XPCS1   100 or 125        dual SGMII, 1.25 Gbit/s
> > > +
> > > +  Which Ethernet MAC an XPCS instance feeds is fixed by the SoC integration
> > > +  and differs per SoC and per SerDes instance - on S32G3 SerDes_0, XPCS0
> > > +  feeds GMAC0 and XPCS1 feeds PFE_MAC2, while on SerDes_1 the same two
> > > +  instances feed PFE_MAC0 and PFE_MAC1. That mapping is a property of the
> > > +  SoC, not of this binding, and is resolved by the driver.
> >
> > Roughly look like use argument is little bit better
> >
> > <&phys PHY_MODE instance(0/1)>;
> >
>
> Rob suggested that in v2 [1]. Child nodes stayed because:
>
> - SUBSYS_MODE is written before the reset is released, so the SerDes
>   driver needs the whole lane mux at its own probe. With cells it would
>   have to walk the tree for its consumers, including disabled ones, and
>   an unconnected lane has no consumer to carry a cell.
>
> - The MAC uses pcs-handle, which has no argument cells, so the XPCS
>   instance has nowhere else to go.
>
> - A type cell duplicates phy_set_mode_ext(PHY_MODE_PCIE) from the PCIe
>   driver.
>
> - In mode 0 there is one x2 PHY, not two lane PHYs.
>
> I will put this in the v4 commit message. If you or Rob still prefer
> cells, let me know.

I think Rob suggestion is better.  ethernet controller should support
standard phy interface, more devices will share phy between PCI and
ethernet.

Frank

>
> [1] https://lore.kernel.org/all/CAL_Jsq+SswpTjQShfkdhVwL_k8gJ_5+NrecPCUiFR52UB5zNMA@mail.gmail.com/
>
> BR.
> /Jan
>
