Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020107.outbound.protection.outlook.com [52.101.152.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251035677B;
	Sun,  2 Aug 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670269; cv=fail; b=p3qZ/qYFflqHL9i6cp9/KmQOrNlpvuS10uihfCRWoAPU3aGQLqw33kwKTZjAqZQd0MJ6vmQNbyljJ7NG7hAC3VOhnsBbe1nacQUXA3U4MerGcAgPaUBDtcQnTlfFpcjkURLENcvtLtMXqnSE2G1eRJBvQlXY8M8hRK43Ag/GfvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670269; c=relaxed/simple;
	bh=ImpYMDOq/6V6bTVslcG+LRc53TlIRBpJhOP2rzm9Zjg=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qmmyUl/jDGEz3kRa7v/apaV6iMVpACznQrTD8+if1bTrWNeUdiz+AkeJRGhRKgdlZKHnDew1C4+wYfvzu2sSUYQ9cdiHWHa9nKek1Er7eav0j14u8PaG+clU5HT2ZAn4HVBMpx/xQlxWD717d+u0gJOFTCb7B4m2mBj7TfFulLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.152.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0cXaaNYHc8uK5kkFCBpjZWJzL/5ppJucIS+HNnPyZs1uTOs8XuZr47FYjLKVkbokrL5Zvo5OFEey3OsnUYTmHjyuNmS72kGt0eVisBDyNyp9WkZIaxexi0naXFXqq066o9io1CqBWhrT4bR7s7XDwyVa7eu/HIpDddsJNGC6NQBiJECO6eBqhoJVQcMfnoP23Sa0DSsNp+13eeMaQvFQXBF+RSF+ueq/TilUD53+sRSSWw0kYumU89/TUa2QMyAO1FhnqcRndG74VOCgChW2Hrmxez9FP4cdPpKPSRqLU7651AUAveK7sHTMtii0z1YiEQDku+8jAXmeTGMvLz3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC74zshp6DxYIErR44fbGhxWe4muMtd04nqdHSFAx+s=;
 b=q4kGOJ/uUvtng+eJBXJ2l9kSdfyEQrG7Hzj4ADUtiNCrL2yE2EaiAPR+iVL9HJGuF1tOqO0BKHC3F7ZMcELiVbZ0axE6kF6MJ12mOD5cGp8sUqPwq9RC0tYag+9dSxMrIYdJiUm+NOhjeT5LyXalroR3wcfoFAPC+kn1U9QipmxJkD39iXCYpRPj69cGy5qpWhJeToTZ2Yc+F+2FiGdnXTUB1N8vjvCmoiKXKx/F5MxsqK7hlrD3vjcen8jXjlTGpxthVCfRzhWFpok/MvTyywUOjHZMN+IgsWL0ep5rN5bNSeIg7qeZmmAuH5FWY01+uoYVSd+ey/wrJAr2azfE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by SY4P282MB3986.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 11:31:03 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 11:31:02 +0000
Date: Sun, 2 Aug 2026 11:30:44 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rudi@heitbaum.com
Subject: [PATCH 0/3] PCI: imx6: select the PCIe REF_CLK source on i.MX8MQ
Message-ID: <cover.1785669457.git.rudi@heitbaum.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWP282CA0088.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1e1::17) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|SY4P282MB3986:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dce776-5a09-4525-6faa-08def0898866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|3023799007|10067099003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6sqvL9VYZ0wCyDpuNA5t/z4b6L7s4krJQSE8ChandYg/BBggQjIeYxL6XBv6ks0+B+UmyGQ7xD4iQCXXZI64GYz29rWp/LuZjf5s1QVeMl8xzAIiNThlDZd6TWFa0C/lifYDChkBxgSSu5hk/0yXuGsAEzg6ffriiITBxsPHPIond9J72gusPSw+e/1gPkoBgew2gbuDRezjFCWe2XLo0DdMAq68G07daZch21CsUSJ4ogNYy53Sd4dmm6RCaeNV5Sp2ChttQjLqf3MXR8V4Pz+ftMqVVWuXR1dg0rkQDuwhEznHSGkQUXP9EcqLpYiZ0FalWRplUGlfmG8pA+DLoU2eYOIsrK4uMPYNU3VZjqltAoIhbbEGWSZ7Yaa4k3BKJ1279ed/pU3laX2aBAmCqXGMuQE253FdEeLxpbPbciTxFvn7652XS0UZLTclCOJv41pbxK+K4I3O4TSM/aksW3bajfTSuB8St2CjPHEhKQv0WcsotdK0HO8OZQseBb/Ee7xkDF3PFoOw+/Dvw8f7kVTznTBrE8CLmzce3vz0lypY4cw6mpN2IAjKXNfb9mLm4fh0pIAeXFAD0yemPky+/zHOVrdoewnA0Q3Yyi/uceZ94k77tqbC7sI60ScoD4y6fMFSOrXOafEkOlYPhV0yE8k1Mdr7z9U+G85LZu0UufI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UsPCkVpvCXJzZ2DQzT6QWMPrv2S+Io9m4uHfpxS3iA51cMhNJWZlATASzHEQ?=
 =?us-ascii?Q?Ifgs/IFbKDoQIwHbbm4uez2rWMGw9Zj1ePoNTmIDV0LBN8mS8YUcfFAth25P?=
 =?us-ascii?Q?NxrN7jwSm5CQEvQMJ5pdsP0m6Eiqe46DPtWR+/or1HnjqcdIRwMr/sQEkwrh?=
 =?us-ascii?Q?zHne/PCnQj2unclx67KOJqqA8FOzWw5qEJ6Ua38aV1ku8oCQOjdgfs+kVrTx?=
 =?us-ascii?Q?qX95rJt1jeDtOF16oVrnDzpeKS4js2pCbWtStc2Hm02m9njdO23nzNgA/NGp?=
 =?us-ascii?Q?ug1wxa/ZL/nyGyaK3fy8jKfsfwEd/ke0H7BqTM1n/D1f28vXnC1TDwhd7glJ?=
 =?us-ascii?Q?YOWiidZXbLmmW2Q7gI0yaxcRdc7SzOT+6rjafLMPmh6UrVKqRVk0baYMuSg3?=
 =?us-ascii?Q?s2ezMAGwRWlhSudG78hR3nlOoYAHxpF3Fbe6hFkz9rnkEwPDUw7A66Es/gky?=
 =?us-ascii?Q?WDiYLv/0h9wK/qxfUkVyx2d4rHLtXRSSGdHVweogOn5DEWQGWrDL5s/LCvpU?=
 =?us-ascii?Q?CzGjWK9GNqVXxgOsSNUD/i/rfDRizsegYEvz4IGxo9SPav6Tdwi010fRl+te?=
 =?us-ascii?Q?cexj+Ldnl6JHtmOEaB31C+qtXdRR0rh6ytrWzWTgMwqtzM54gdamn5P5i/8u?=
 =?us-ascii?Q?5brhHnBQ2MWxm/4PAEnFRUdPl3lpqwiU1z/X4vxpevii7W9VpxHFmDmZtUOW?=
 =?us-ascii?Q?0KXh4/+bmIMquCO1fFDboH96fN8NBzEUYW2hG/RsxluxGOF1Giv4dglO3BxH?=
 =?us-ascii?Q?46+IqXRTQTQfIyXiYoW9k0mb0LkywwchBoSBv6LvROh4THRyfnRHRcUmwX2k?=
 =?us-ascii?Q?a14w+zJ0pO6HWczoRd9+Yje2stmmL9QHvEpwmq1/0lRdUdRpH0f8zUqkNzh/?=
 =?us-ascii?Q?ttEvuYcJNluo/pVoH/3EmDxIS3f7EWRhicfZNSJmV2afAcORZUBklReRpJDP?=
 =?us-ascii?Q?FPvDcZ3nDJR2/Ayrrf6ruO2x5hgeCH2sxHjrl4ucAt6dxHD3LygrdpPyqZEC?=
 =?us-ascii?Q?ox3q7hNio/ys7PnfF3jEmz6733N0RCtnZpQGNUSv93VyKCvgt6cf8NmBlSZh?=
 =?us-ascii?Q?CFQC5JB6D56gjIFTmJu4hSa4gQZ+BffU+5TBIHP4sWNqYM4QDi27RBqHzoeO?=
 =?us-ascii?Q?6nCiurXC4XRtD56jwcZVCIStAG9vhuow6Hrv7tYlADSq9Xn1/WFU34kSReZO?=
 =?us-ascii?Q?CW4LTHG9ztCFwTSeLQskCpkAG2wM+AgrfTpQFhJw5WkBO1+XJwKv1MHt8H34?=
 =?us-ascii?Q?uJUBeed6QoRa4FyH2MA1MpUZSS46hfB/fgyRJwQEdZGn7xDJs5sngVqeGED+?=
 =?us-ascii?Q?gd0DWmjMEq5EV0j1Forwywla8sKM95AVJCVCpoIYtOYJFG2/HLPh+gaAxKke?=
 =?us-ascii?Q?HNTPmHdSv6iHLKS2923ybLe5gU3m0/Vr+cRNxHNWZ2rt0U3uSJUEZiuvj2C8?=
 =?us-ascii?Q?+BqMubWzPacJms8vvCx27PSOJRwJ5TkYQU8KmxDjz2StdZrkYhMXdU/Ii39e?=
 =?us-ascii?Q?e+eKOe39auvDcsB9iM9db2mq5MKB3I9pqzUsFK30FnOTPzHRztp8IGD3HGvz?=
 =?us-ascii?Q?KOoIhl+KR0gm0W0WxGns95gbCcF1yUXnop8gtES3TqT22/VeBZff/PdzNFUC?=
 =?us-ascii?Q?OwyiUAeszwX2kU9WQWGkt9PkHUs5XcW4SXLPoNdm9GDYrGN/LYpoC9+SG/qM?=
 =?us-ascii?Q?jar5dzLTYRWU3tx09yJJGIhRSQgk8HIduNi/6okQrfSflec1?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dce776-5a09-4525-6faa-08def0898866
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 11:31:02.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWOg6miJDQB0/8arEq5LG5pxmTxqyWCZExdNYjzfI8QwkjNqfCM6Opnwq8+QlgrY9aflJJ2J7A6qDzyvueKuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3986

i.MX8MQ can take PCIe REF_CLK either from an off-chip oscillator or from
the internal PLL, but imx8mq_pcie_init_phy() has always selected the
oscillator unconditionally:

	/* TODO: This code assumes external oscillator is being used */

Boards that wire an oscillator to the pad describe it as the "pcie_bus"
clock, but nothing in the driver looks that clock up by name, so it does
not select anything - the unconditional IMX8MQ_GPR_PCIE_REF_USE_PAD is
what actually makes those boards work.

Commit d8574ce57d76 ("PCI: imx6: Add external reference clock input mode
support") added a generic enable_ext_refclk flag, set when an "extref"
clock is supplied, and wired it up for i.MX95. This series extends the
same mechanism to i.MX8MQ, which resolves the TODO above.

Patch 1 allows an optional fifth "extref" clock for fsl,imx8mq-pcie.
Patch 2 makes the driver honour enable_ext_refclk on i.MX8MQ.
Patch 3 names the oscillator on the in-tree i.MX8MQ boards that have one.

Patch 2 must not land before patch 3. On its own it would stop setting
REF_USE_PAD on any board that has not declared an "extref" clock, which
is all of them today. The reverse order is safe: patch 3 only adds a
clock that the driver ignores until patch 2 is applied.

Patch 3 touches arch/arm64/boot/dts/freescale and would normally go via
the i.MX tree rather than the PCI tree. Given the ordering constraint
above, either all three through one tree, or 1 and 3 first with 2
following, would work - whichever the maintainers prefer.

Patch 3 is deliberately additive: each board keeps the "pcie_bus" entry
it already has and gains a fifth clock naming the same oscillator, so
the set of clocks being enabled is unchanged.

Tested on a Google Coral Dev Board (imx8mq-phanbell, not yet enabled in
mainline), where pcie1 takes the off-chip oscillator and pcie0 the
internal PLL. With the extref clock declared, clock-names reads

	pcie pcie_bus pcie_phy pcie_aux extref

pcie1 links at Gen2 and the endpoint enumerates.

The five boards touched by patch 3 are untested - I have no access to
them. The change is intended to preserve their current behaviour
exactly, and review from anyone who has the hardware would be welcome.

Rudi Heitbaum (3):
  dt-bindings: pci: fsl,imx6q-pcie: Add extref clock for i.MX8MQ
  PCI: imx6: Select the PCIe REF_CLK source on i.MX8MQ
  arm64: dts: imx8mq: Declare the PCIe extref clock

 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml          | 8 ++++++--
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts             | 8 ++++++--
 .../boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts     | 8 ++++++--
 arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts     | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts  | 8 ++++++--
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi      | 8 ++++++--
 drivers/pci/controller/dwc/pci-imx6.c                    | 9 +++++++--
 7 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.53.1

