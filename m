Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D963BF68D;
	Mon, 12 Oct 2026 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831455; cv=fail; b=SlOacJdYUE+xU3EHD4DxhOAXmGSDULJmLtifRjSc4Mbc763HsF5OPKOYycuiFNTeFcNgG2e/mQvDnn5mQKAJmxPHjrnPOxhVUWG5pl/PaHHAlhxJzTDuFjHx5Fs13pXFeOITxs2RpKspdZb21lP8i9zkGhd1mZjZogBxLIsdDag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831455; c=relaxed/simple;
	bh=8aoBkvC24CFew4jkVYtaxQ7pkDPT0SkCRtFBARGQ/Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LzshR9WGKL8YpHgSuToJlAqcuVo/1V0FLQZ5qfi59UAhVhUmqbZxIRk2GDLG18F/Dao/Yyyh9VfAzh0EcPCe2sgI0O5dffVT4hsBNDWkd+tL+3IKrHumu9AXcn3jGFDdRCX1TKvoy7FH4+tKeWY7h8zftYjD0mpUofUDX5Ixk1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dF61N3eR; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dF61N3eR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIaTUUMzonHDVLr0Oz4B9SCJGx54mYUIoIzmH3EC0gcCfid65d3EZxtxPcNQOQlHn5s9f6PuZhcddnz4K3GwmbxPfLEUOgfKpC0wCWNJgZTfgPXMk/1U53EL2wCoy2QoD7DhlEGZP8Q3MLe/0hmHZNLl+WdLQnxk3vKInuUJwCJTkLGqGE9TyT53s9lSRCB1BHmERs415zbOwguNuRHjrgzV4gg8uOnMpV//RZPSwLLgY5iXpIzXJ8irW0G5COt0bPL1foSzey2MB7HwODfBWd46jQoyIXpxda0PhEXC+KvGJNGJ+vm9APGKkAGQQYBtvrj9ysK7I6bBsZuIOjgnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoNllUW7CTk+++4zMr3EcYbkhL9HNDNyLR8lS4lh4Qc=;
 b=vuQaIK10U4EFvaKbkab8v2bMMiksYD4t9AUnVDbIDa4QV4nHd5+2s10jdNL9s+dsQauRTIFUrYfEIlr63YHK9Ee5LY/IRGgsVejFZ/88pazizB9ZOP1acU5ro8Mbhc0R9J9F7uYeDYdfc90APwZNkP4AuqMeT0vSh6TJ6yJRsaF5S/0Z/PjJZZiR6h1f8c7GOVhkbtjgbwCWzqphqnhjgG6K7eUzTI6vJ/wj7gok2RZqXyuRj8byS2nPJRymaVhM9RZfFwFt2GOGVbkxHXdHMzKTMzy85+8lQ6YX1DNoJhjaBSjnIv390MDds/VE9bo1MXn2URGNyZuKm+uuEDx++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoNllUW7CTk+++4zMr3EcYbkhL9HNDNyLR8lS4lh4Qc=;
 b=dF61N3eRvq1SHMJ8g/sPbCjMXH4vBs2EjvLKoQHD3CTxZJ4ErRv7KCdqDbNOxrVsmm/OlL6CXW6DXfOWTMXoEayJqqztUs78Tb4tFf90TJLcchRilSfpN4Lgk120CCDS5YTdbAca3deXgrxDx6enzlxMgG2AbvJ23BDEBoV0UZIcC48sObVGVRQFLDjy9oEDsI2KIaclwxFqgVowkif0b54+M+jTt7Q6zxROECx/gxvgDBvlLmDl56mphBeV8ewqTXDNjXzsJPB5IpNqIiIa7Jme6u7FErHw+2ld25z1/nJoSStIcsUy4mDGL6KFvuem64EiQUTy3WJ4PuF03SEP4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB12127.eurprd04.prod.outlook.com (2603:10a6:150:313::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 18:57:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 18:57:28 +0000
Date: Mon, 12 Oct 2026 13:57:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: jan.petrous@oss.nxp.com
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
Message-ID: <as0tiQwquNkdlF2i@SMW015318>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-1-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919-s32g_serdes-v3-1-9d68868c1e89@oss.nxp.com>
X-ClientProxiedBy: PH8PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB12127:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c7c23b-725e-42e8-63a9-08df2892a98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|7416014|376014|366016|10067099003|3023799007|261009223027099003|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jn0rNHYiU0xmm3bTmxaOLhMAciomECXzcP4F1816TZbVzQXbZNYb3cyKldhUW3M/jDQqlIaFm11coQ7YqKU7KngamkYMMuMwRT8jzTmtij+JoFdJMgHhB+OVAu4oWvw2Hi/TieX3xym+3if/zd2LSECNhbbEml8fShQFtWMRLpOKMZOcpm7zenAmjo9Ur71iwHXYr57CblCT2wqinXgJA6ArRAi8bpELDTVGhZWuZQmCDJlaGARQfbQzkELTfhVdFnBHdfvQSAlxqhilmmZ+SXzbgxCmPNINX6fEAjMKgvoiyaUFQAM2dtT4GL6nM/h0ZaW9WE0JRRYVsc0vBaVS3sNQgMILX4mgeatv5EVqc4xE0skNbPjIuPpOE8a/DpbcWLKQZtfaIj2pSxEiok2BcEiXpMIP1ZCQL8LPNSmsY6/qTpFjyQvynC69uXV3jV5x/TLDjfkk1dMjSTFIanZ76ynoFXBfeWVHXxc7d6ouV5EfTtLucBXqc4h+s3jtvZwPjPjgEZUreOeMjtLRpYhbt2Nyl6YruQ69qqRqOj24o05cYY8MDn5EoX966paiLiVowYUl9QAU/HIaKSMlVbd8Ulge8xF5YLCp8GuFko0pzHXonQsappzaWwLZ/XzYE1QM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(7416014)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YKJi4WFoUp5gOr3oyCpSnPzlaQuY8lkDLZkOVJhokxwFj8mwO/9OzbUnvKD9?=
 =?us-ascii?Q?RYahCkTVkqh2tlDIya1PE7Lha3rH3fPmvmHzb9rD6Pmk7Bwnybrcwn6WPzZK?=
 =?us-ascii?Q?iY6tZh8bWrUr9ZZs2hHsVYrs/U2yddiVjzWWgGMx+83el1SkeJE17RGaFzou?=
 =?us-ascii?Q?fcHkb5Jq5wMm7iaReZDiHWfhIiytr34MAiW4zkUntYOjShf76Mx6TJ2D+9bi?=
 =?us-ascii?Q?7ha60OVX82zPgsxsHFKcFt782GoguGTwp1jhQHCBcTD6HR1PiuNWQhzsIHZ3?=
 =?us-ascii?Q?QKGAqDJ1Cumus9e3fg5nM9vJgRlNxIqGTzG/8UVMS297oAIoIKlHKhP4pLKa?=
 =?us-ascii?Q?+8Rn1v3BYa8E7dV84TmjMTSZpLt3HkHzh/obwafAuGP0FbpVMyfalGqiC7Rc?=
 =?us-ascii?Q?CasDBjGfE1IrC4nmwpxYkE6gI/NmEv9vtvAPe3EqroUHtbV3YAk5nDQwJOQp?=
 =?us-ascii?Q?i1XqoC8+uU9Z9CS+asJlaGoYqsxP0j16g4KDQaVM0nPd4czE8cNJaAkJAnV5?=
 =?us-ascii?Q?0Nl6a1J34C83g7s4r4NGP0e71TmuLBlFTYrpUbtz03TLYh35QdBoke4otyHC?=
 =?us-ascii?Q?0xRobQMATw4fAyCcD9+71gUuWV0ZyuiOb96SyXakt8QqWks1WVchYvccUZWl?=
 =?us-ascii?Q?VNhKdx8yTfbbWMTeODrHrbRKmyzDsSAc5CARD+Z72J71tUlYuKni/Q/DU0rH?=
 =?us-ascii?Q?5+18RQIKFYsTQK3rJAsZmrwqhbxTqZ4HFJ6fCg6LDqAyKTU6HjuwjA2r2Brr?=
 =?us-ascii?Q?0lX3ZpGOYBTdTrNqzZPb+Vt2LXw5RnavCubZFLsXQzknAST5KnCCzi19s7su?=
 =?us-ascii?Q?dN68qelelKrr0RNdh9i/a/2IQ9w2S3rbgIvaSq/tSQlaKmSJpGdOrMF0t9/b?=
 =?us-ascii?Q?J5ro10q+qk0jjtD5LrZLFvis1VBZUQJi711shNdTQ2WmnHeglcpByBxWDuj7?=
 =?us-ascii?Q?hRlIVMJaQWk6mvDcdtg6/4ixMpCXZTjjv0oKvhR3oS21AU1GPlZ1bgkp60IR?=
 =?us-ascii?Q?zNISyoo0rt728KTvWlytqVt8KyDzn/EReCl1FerieC8pF22X0HrN7UyGXa3q?=
 =?us-ascii?Q?qLqajkArAiXWjiO/dxPd24Oe/g/+xjzUO+qMS2ltoW2WaRUe4POpiqME/Xhy?=
 =?us-ascii?Q?Xkb1Ryk8UVpkLtDk3h4mgTfEETh4O8TvQy9WrmGISGWc4WxxgrjcJWyCbJ9E?=
 =?us-ascii?Q?0fxNKFTkD5lpa8XQVD5plgjSR1aZC0pJHkrz4Y5J08WQKisKJbitrEW9cqvx?=
 =?us-ascii?Q?pZhQr7c2swPl8B6BnXGu2cHHAv5Z83OPVQZhp/GDDLj8fZedLKbF7FF2EyKK?=
 =?us-ascii?Q?Yhs/eJx0cU1MvJ4YI31fx0JzBM1N8LvkyTlKkPh/g8z0rE8QRQDC6bi3j8oJ?=
 =?us-ascii?Q?RVxVeQlCYecVHrKvXQ7OpLhHFtmxM5eZ4IqqEOXNvSFmOBZvlIoeY9AI/Ecs?=
 =?us-ascii?Q?MQgEm9rFXuXdAXkaDIx1zDCOfDp/a1qIOp4tsN3kGynzFGhOruH3Or0j0Pqt?=
 =?us-ascii?Q?n1GxTP8Tf0C6xv36ssrIGpkSfD2r8VAAHyGE+nxxblJoYG5k2Ubxoclojw34?=
 =?us-ascii?Q?/ytce/OKrflR/hIL5Lcar6+XYxjoTiAVHfyJMrVj9utT1dUY1S5hKu94EHXN?=
 =?us-ascii?Q?Vad000YflBPjAo9lcT3OBU1JrRAEZGIWfRNDYAC42TN0TuEsq63ElFP6DUi6?=
 =?us-ascii?Q?gfQBL50TjEwnEvinVNeSIMxDcXQualntn5Cvrmnv0r0IaNV0wAwWrS6NKhHk?=
 =?us-ascii?Q?FeuJLYh6MPC7J+HMbLBbfMAmuSe+FuJZuI9bRjIIDwro6uBVZlpc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c7c23b-725e-42e8-63a9-08df2892a98e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 18:57:28.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTvgtFMGjFveliSMjFEKPBLLuQmbNSvnj6FwJ8DvRPuNQE8FSdd2n1pDvRBU4I0Kne1R2aB7vk7LbdjbGdUxkhKri6ZroMJ5Kl1zG0fkscRscAWM/VCAFE7VBbdoA8gx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12127

On Sat, Sep 19, 2026 at 08:54:29AM +0200, Jan Petrous via B4 Relay wrote:
> [You don't often get email from devnull+jan.petrous.oss.nxp.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>
> The S32G SerDes subsystem multiplexes two lanes between a PCIe PHY and
> two DesignWare XPCS instances. Describe it with one node per SerDes and
> one child node per lane.
>
> Compared to the previous revision, the vendor nxp,sys-mode property is
> removed: the SS_RW_REG_0[SUBSYS_MODE] value is fully derivable from the
> child-node lane mux and the XPCS instance routing (nxp,xpcs-instance).
> Each working mode described here has a unique lane mux, so the mode is
> a pure function of the child nodes. The reference-clock rate is
> validated against the derived mode; it is not used to select it.
>
> The 3.125 Gbit/s working modes are deliberately not described yet.
> Distinguishing them from the 1.25 Gbit/s dual-XPCS mode requires a
> per-lane 2500BASE-X capability that this binding does not express, and
> the reference clock does not distinguish them either - both accept 100
> or 125 MHz. They are added by the 2500BASE-X follow-up.
>
> Only the PCIe lane child gets '#phy-cells'. An XPCS lane is not a
> generic PHY provider; the Ethernet controller references it through the
> standard pcs-handle property instead.

Is it possible Ether controller use standard phy interface? of use standard
pcs-handle to phy convertion

pcs-handle = <&pcs>

pcs: pcs = {
	compatible = "pcs-to-phy";
	phys = <&phy ...>;
}

>
> S32G2 and S32G3 use distinct compatibles without fallback because the
> full reference-manual mode tables differ per SoC and per SerDes
> instance.
>
> Co-developed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  .../devicetree/bindings/phy/nxp,s32g-serdes.yaml   | 258 +++++++++++++++++++++
>  1 file changed, 258 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> new file mode 100644
> index 000000000000..6343d01bfde4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> @@ -0,0 +1,258 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/nxp,s32g-serdes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xxx/S32G3xxx SerDes PHY subsystem
> +
> +maintainers:
> +  - Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> +  - Jan Petrous <jan.petrous@oss.nxp.com>
> +
> +description: |
> +  The SerDes subsystem multiplexes two SerDes lanes between one PCIe
> +  controller PHY and two Synopsys DesignWare XPCS (Ethernet PCS) instances,
> +  behind a shared 2-lane combo PHY. The active routing is selected by the
> +  SS_RW_REG_0[SUBSYS_MODE] field.
> +
> +  Reference-manual working modes described by this binding:
> +
> +  Mode  Lane0   Lane1   PHY refclk (MHz)  Description
> +  ------------------------------------------------------------
> +  0     PCIe    PCIe    100               PCIe x2
> +  1     PCIe    XPCS0   100               PCIe x1 + SGMII
> +  2     PCIe    XPCS1   100               PCIe x1 + SGMII
> +  3     XPCS0   XPCS1   100 or 125        dual SGMII, 1.25 Gbit/s
> +
> +  Which Ethernet MAC an XPCS instance feeds is fixed by the SoC integration
> +  and differs per SoC and per SerDes instance - on S32G3 SerDes_0, XPCS0
> +  feeds GMAC0 and XPCS1 feeds PFE_MAC2, while on SerDes_1 the same two
> +  instances feed PFE_MAC0 and PFE_MAC1. That mapping is a property of the
> +  SoC, not of this binding, and is resolved by the driver.

Roughly look like use argument is little bit better

<&phys PHY_MODE instance(0/1)>;

Frank
