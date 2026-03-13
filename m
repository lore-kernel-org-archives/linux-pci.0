Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942D17A300;
	Fri, 13 Mar 2026 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378970; cv=fail; b=Fd+WKJxHKKLdukMQUy/sanZUWEt+95hOQPhoyXOBxEjdwcNHomitRM5xaXogTlRsCR5d6GQvxTZexIL9ugbExcJm9OKfODYspKjY+DjbhONjL/UWjw1UA+zNPAFxKAcHvyhLbeTbRdqKdNQN+0o5nk7Z+Imhb3gwgnOLtZseotM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378970; c=relaxed/simple;
	bh=TFNahk9qOfjjj4j1f4eKWGa8uREn7AG1wC1plzoVT4U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y6CJtXRAtMBPao3t2QEHxW69a+pXsAIuFe9tdb4FG/dswRmMubVTQrtTk6X5zWnxR/AKqCPSo0yVyeg1MAutZPYO/JLESJY9NkLMm9NvizBoxw3YcVX8fBPwLa1/GxZeBVNOtdC+5i2R00Fty9EKu/2jB3Xmtk7ZG2XdOBUBNDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iBc/oV4k; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iBc/oV4k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ8VhrS/yL4JVVoVe3O5V8mj0FfbedUQo0CSWk85A9zFYvCGCvqQqD1ixMv2yIRcvRvEyCi1AGNv3jAvnSG5oxSjFF9Exy3JtE8cHF/ZyZ/4ymAGBYPt2PQKv4MFLKuyAQk/rLdcwj1XX8zsz7e+uqdwm6zvGUt9DEHGP/F/zqiseEicn2nUzgnuaKPdhlw1SXVgghF4GUkyjc4dypDPRZuNSElekU97P6RtmOSp6QIwtCVVgyDrYQhpDk8EQyQrVZxxTh8ZQb+OaUWJxhlCYFOuMcrmKCIKn+zmj6HdURM/whAF4DM6uuXbxzpbGCAfIWUiID6AxfTEQKw9iuZqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHAKmIB0mU1m8A5dKIu4BJpA4+rbEsMRiUcWZHtLP7I=;
 b=Djvog72OAQ8l5ln3vqLjI3z6Kbk9nkSPbUCBtrYtVXie5cMXmi2LXonC6opeXfrU158s4hCxnmhyVR/JkfUpZOqZ3mvVtWXbED2m1lGUC/MSuqSGKmmvAPDmEhXDC5K/rzLKe0GMQz2rlwUJsa8etwEXlJJc4vWIuMlkFZsm2tunTlNRL6zO+OsKiNCx9xNXdLz+3Pp43LoyJSkB1erGPrkbozSk4V4/HMKZhm7mwodAlL9qlyU3qsLHIqbqgX+byOAk3quyQg9XnLTdMJBXe2lHugWaa2hWqyHiHDAChlZB2BWrWT8I2IdftziJ+nBQrwP7TazLwCIV4089d0w0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHAKmIB0mU1m8A5dKIu4BJpA4+rbEsMRiUcWZHtLP7I=;
 b=iBc/oV4kRXbrzPsOWme8dsI/ktE818XfROZ+HTWKr3VMRysVRiHiODo+dUgCJs/0KVocx0oiJVd/SYOV8RsxO+1Bnw4gFQNejvMJmuPtB0RFHucNTZ/t8ucXdoPTNZdqaGh0WKVajh1rK+p2rVysuIjL1maVrerR9pQrnorokxa8xWWEmsEBPeuMkehx1tdTO3Ixu+OPeqMRTaX9+KqbPEviPp6H48IhnXGRwXlQmSAKBt9qgbo5/YPqQb0rk6Eut+RMBmM9gJwB1grvjn8v+4U7TMkivCb5B/X0ipna7pbwrCW159k7Nx8OWUgKt22d2bahh2utJfQhjXA2j3OzBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 05:15:58 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 05:15:54 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] Add i.MX943 PCIe supports
Date: Fri, 13 Mar 2026 13:17:13 +0800
Message-Id: <20260313051718.1931375-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0161.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad557c4-4cb5-4fb4-120f-08de80bf9aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|366016|1800799024|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	pl7OCU00m167pqXngqpFl7RtQHKUUfxyhnqqha6YnO1uKfsjM028mgkTxHKV0c8ZkYPmi+bvBBwqiH2xxjHjCB1s0+Dj6B1HWM4acvIDyzue26vmEaJXYLK5lznbNh8/2fdWmr5f9vQ3NSEsYt3lnfFRwN8bcsKL2fbJk1vlsky8l697ZhYFEIvpVLAQGVIfLlBrrzeVqplG0rEG3vUjeHVOHuwwzZOnh7chuW+sHnqV9JmJnxii/xpdMMwDihXOLPI4gSyLkQ2c2d8CGLW/Z4NP4pOp/8mvQmoAOxuBoHuwd3t8jehv2Cqk1KIXTm6REhLrHLLt8BTLwWSrY0u8f9XvDCKgmUA0WMcQsOOe6jmZzuk/Juvvm99w2ZsVz5JLLT7illifE5HSUYMz4jhfzc0iA0KxbUcHZNS09cAX/Im3giXuL1KKC4Ik3WwDiU+I1HL6lXn6Q5qZEmNGFvOe3i32GKri9vnlkUKpKrCPJd5f5OVlDFBhc2mAsdy3shXbSOZpvMethTedImpkl5/CCxzzUErRuceWyc0pp5JSoci9dwEL9m1wnGV8mAy/vTXHpO4p3eYARng2Wi+aBJucUii2cKgE555pmmGdRMva6hhEwovPjjoD8iMLWCnuoyTGdL7EEOX2CCU5TpNCrYgSRwZxlIfzA4dgpABe63PRfuWlIn3lzcvI0y4zOboKxbCQMAuSCvALLZqG62qBL6G0HHgfIP7UYL1COPLXJgq8EMdt65hPac1ShYOsEa9SNpZgJY1hjyjT3YX4Xj9FJJdkxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3WrBSOgdFphzP2NoZeI9Y/rRtYG31q+CguV1vbatk6lEDr2oQbGIIGD2DMVt?=
 =?us-ascii?Q?4sSSCMkaZf2yzj88+/eGnYCOrTs6lq8mOfAcGQ/s0heIXKWieLfdPUpM7AoP?=
 =?us-ascii?Q?A3YAVA/JMEhOyW8jHkb+D5nLa7gHlT+uu705tzHiT8Ijc+9O6N3q/2Ga1M4P?=
 =?us-ascii?Q?9txItaLKcOty5mBkUwIc5X1mQ2TcR2ajgM7fmN15dVj6PBm9MK/nCm7MRBcG?=
 =?us-ascii?Q?vNGMZdHOp1n2xR2cVXpUOQcXh6FuzyyO7zRi+vrULS5xhKm+GelJwAd3Tdop?=
 =?us-ascii?Q?2pUpYpAr8NCb5/UriBUYUimIJ++YF+koNZXohTzu4JKpFAmc6JbQYN6UvOFK?=
 =?us-ascii?Q?l89uccRAjO64sBPhbaJC6OVQTUBPaYJYqRqwZ7RINrpwcjqvHtu2zARkJ26g?=
 =?us-ascii?Q?cDwM+WwoIEbwD31eeu9r9Adf8jHTM5uTGL/EcXv5vlVd2gyAliw3/JZhDxOX?=
 =?us-ascii?Q?80dL6XaQZoJ6A8qItNTGxJATSHUdwvHc83zI5TFziFktZmvwcJvWzDflcwa2?=
 =?us-ascii?Q?CMiknWfPTzOgTCAKOQTArxhEfkZLB/r0jsAPO24DNckxZ0ZPGslp4QYs8tJ/?=
 =?us-ascii?Q?sn8zR2zR9TkcKblPC6JREtwBuJ9nwom5IPEQOVMepyyWhG4Gw7ScOvCwekRM?=
 =?us-ascii?Q?8MOp6I0z1FhxBh3NTVzPfCIDSgv/QJBRYCVpXcN0VahOs2SsMRJxOe2XRMi+?=
 =?us-ascii?Q?5DVmbPrYIfDYCNOinYbHgbATINYbVxy87rq3pTcaS8JrAAcQgHTGIG5gmy7f?=
 =?us-ascii?Q?QbuPwYtVa4iAsPcDHt3igC5G1zaoDtDVJJPiWxZlpQ4rYT+Vi2i4XWBgd4xw?=
 =?us-ascii?Q?ahvYfNAIGcPuEXAvmSJkcAc+DtUVbcqLTrIXi8cdoRrA1DHUNigEdHGJyrar?=
 =?us-ascii?Q?DJ0bd3gGyPo6tvDE+nLoeH9JcThVS1VfQaoQszeayLfzisdtWEB67yuq4Cpo?=
 =?us-ascii?Q?ZU74TLEFzG4f14JuEFGAS2ySR34NdzwUcfmjZk+JQOgoW9nOPmmRaIOS96nj?=
 =?us-ascii?Q?QYvmIzBD+K12Nb8mMrJHMSNRDi1gwlufV7i8Z0FcCGaS5ZczbpnaBL70xRy0?=
 =?us-ascii?Q?8RP8fDD1PlLYZgULHAufLGAcDb3XQEYwmcgfaYeP2uyDJEm9RF1u5bnHJx6K?=
 =?us-ascii?Q?VWw56wAK6zla05xh7BtWdbjacJ5grafAT1ONlS5e7ITirqopb+Rh2OXhWfK0?=
 =?us-ascii?Q?Xy/xGMf+b1fyGEymlh7AybHOTNXmlFu0/3BSetbi+zx9kJLdTgp3ZbbcN15/?=
 =?us-ascii?Q?jZZSg35773d0VHU/S+kloEqoWkLNjgCemdnwv866B6hQi7uhVJmw7AZ+BnBp?=
 =?us-ascii?Q?NUN+vq4J4+uRa64kKgfX3N5+J7rnLdLf2PcFKydoiFP7Z/Crxfkeg+NphWpt?=
 =?us-ascii?Q?YzQgBvSGeQZSXfRYYcQQ/KEKbDew08u/DzBh6WbQaTYzmzKOIrcSFrEnwmXv?=
 =?us-ascii?Q?PDfKJpmVxovvPA1W6gIUY/ZUIdex5LDpIKmkuOWjy6CBXkt99x2I7ZvqmeSp?=
 =?us-ascii?Q?KZl8kJdEkBRDO8agyLOsAZkzHXu9asLRd0g3Qrp0gk1v1cMy0zNq8kSBY9Jj?=
 =?us-ascii?Q?YfVoRjCNICTa363JpeBla9eNf/iGWCnLKNReHmCjjrTuCG/aCcqyvLRxPdkS?=
 =?us-ascii?Q?zyg+GSY9vcfOVG2tO3I6kJ9aLFAM3oueEg6HVayBh0QrpsMyT/y563Gdh5V9?=
 =?us-ascii?Q?uCVGQEj5yBVFxl9hphXn6UW2oZZ6vfuZ4pSx+PEcwnZj5qBYHpij1+1aBCas?=
 =?us-ascii?Q?5G1LyZORzQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad557c4-4cb5-4fb4-120f-08de80bf9aa0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:15:54.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wozz7dw2fmcKRrOCfDrt+L3Cj7um06JckFG169rcJ0G+HtkIZyrpodTifOywcclyONcV5TTtKw2Xx4Cr+3MvbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

This patch-set adds i.MX943 PCIe supports on EVK board. Please pay
attention to that it relies on the patch-set[1], and the PCIe1 port on
the EVK board relies on the [2].

Both of them are included in the v7.0 kernel.
[1] https://lore.kernel.org/imx/176649331066.523506.9443864112044699350.b4-ty@kernel.org/
[2] https://lore.kernel.org/imx/inzg46tc2fwsajxq4vzdyuiq7krzy6xtcg2mjaieninz7zsmgm@mtdjr4tuegpq/

Changes in v6:
- Let i.MX94 and i.MX943 EP mode compatible strings fallback to i.MX95 EP
mode complatible string too.
- Add missing space after "=" in pcie0_ep node.

Changes in v5:
- Add Reviewed-by tag in first patch.
- Add i.MX94/i.MX943 compatible strings.
- Add "dma" irq for i.MX94/i.MX943 PCIe.
- Add 'fsl,max-link-speed = <3>;' back. Because that Link speed is decided
by pcie_link_speed[pci->max_link_speed]; Found it when one Gen3 NVME SSD is
used in the tests.

Changes in v4:
- Add missing space after comma or '='.
- Remove 'fsl,max-link-speed = <3>;' in dts, since it's not required anymore.

Changes in v3:
- Fix build warning in the dtbs_check.

Changes in v2:
- Refine the nodes sequence refer to Frank's comments.
- Rely on [3], and remove the duplacated codes mentioned by Sherry.
[3] https://patchwork.kernel.org/project/imx/patch/20260204022306.2372889-1-sherry.sun@nxp.com/

[PATCH v5 1/5] dt-bindings: PCI: pci-imx6: Change maxItems of clocks
[PATCH v5 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943
[PATCH v5 3/5] arm64: dts: imx94: add pcie0 and pcie0-ep supports
[PATCH v5 4/5] arm64: dts: imx943: add pcie1 and pcie1-ep supports
[PATCH v5 5/5] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1]

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  4 ++--
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     | 24 +++++++++++++++++------
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 31 +++++++++++++++++++-----------
arch/arm64/boot/dts/freescale/Makefile                           |  4 ++++
arch/arm64/boot/dts/freescale/imx94.dtsi                         | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943-evk.dts                     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943.dtsi                        | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
7 files changed, 289 insertions(+), 19 deletions(-)

