Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F33DD523;
	Mon, 10 Aug 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365813; cv=fail; b=WqYI7ngAWyON5G5DPHAYSF8oO15mgEQ2eiyuIFgXwJMEIGIVy1odKKLJCtjeLofODCTJ76DY/ivv/qTGM/OvjLk5UD1qzotHdWNNpYvr2WeeWuOFjI5b7S6V/L6IGYUxGiSaouWSVMy99LY+EOEUhzxnxSNpAGhfB6h8mvnDjU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365813; c=relaxed/simple;
	bh=0FT9BRHxWL3Qcg3Lyzc4b057mI9f1sim0gSjll0InAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MOta5CinYeP4538QnMlgX3OB8gwIH+jBsgOYy/BV3N75Rb0a5LJal/BMaF+tab++YLL+Oc7FN7qm0umj+2/PVkwuvcs3GpT+DAX+07EOq44H4Z8Pt7/TyhMrUMK/SX7zatN/yufP8MKs7fHGaehdx7kg4Bm0UIl9misSi2I+GBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JSbq+1eE; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JSbq+1eE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJukTzSk8e1aJNARLAZHDJ8Tlcg/AezCgSrgEqScma0FtzfcI50dRl53ipZ+9aAz2S3xCIpSIo1CskX2Z6LbCoDQ4VjMoU7C/jW8Fm1RAgYR1lX0ctfTEEMouOxoAqKzl6fEUjZT9NrIgyQP0r2sq5nm3HGoas07afMtyzY5CIrDDo1gjyqcNqBjaVdjfBEjdWk/zT5x5sjYnL8YOwTo6Ei61fyBmBwcBpJaXW1z2Xvfrly7PlDggupkhcqbR8D9R5qGb2/IhYbeyQXlPIqaIxz0c2ErEXCBmcGI7g19L5o67K8f/TU8yij+u/7Mo+BYCIBlV5BsS0FX61NGxxBSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBAib2mGDj2jtO1fk+LLEJx/InP4rMTZBO5PlJbT1BE=;
 b=nFvPQPox1Xi2IMhKxF+yc2JQqLOjgTDD4csQaiHgifObYyD/ENuL+zMU4uYKPNvEA82xRWaM9NbTIQl7FbFfpg+JUHp0dfHtuwqaA3Mv/j8uIFfZBfyC5ujtxVyEowYrUJs3eUqjsIQPTeCWkjzm6DJQjqw6iWg3PMSUqDo4C/eVBStA1AULvMUmTZNYgKzJHfZGBrRm665skqSuRiGOQm9EpTJodHX+fajt/P7MQopqKhg6UXTHaQINV6h9oK78DhSBD9sAKuKxIz++8B5HDanSAlENXG716lUl2RHI3VW6njqoBQlvUnAEYmT/ImoAvAF0hL28GDgMTO8Ow7465A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBAib2mGDj2jtO1fk+LLEJx/InP4rMTZBO5PlJbT1BE=;
 b=JSbq+1eE/DeCzMxhT35OuV93oLPx4rKNGxPKbs4v2tOtXAH8UffCoi/04ee1/68ol062aWkf3Dt/sECZWrkVZ9txpTSiCWVtH9W7fMC1bPIpXuXZ2Yvmf3b8aAHw3l6SgYFx3DruiJZvWSfTvCXFlxNb8qr1UQ8jsCcmhauCrKENHrh17A2+dOZuTg0/JRMDieaEi7LRbRlKlK54d4JsCFTPnTTFmzMGDSze9qrizU8cdztqgo15qMi1FWoPvlxVm/n7Ij5eWFgw3xbm2YsiLokrnxtIE3OGHyr+Ax5KYpyPUIYSf2GUbhjt1vAAAmHZD8Tykf1Is4925eQ+JQxRDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:43:29 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:43:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Yixun Lan <dlan@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: [PATCH v9 2/3] PCI: Add missing headers transitively included by <linux/phy/phy.h>
Date: Mon, 10 Aug 2026 15:43:14 +0300
Message-Id: <20260810124315.433448-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810124315.433448-1-vladimir.oltean@nxp.com>
References: <20260810124315.433448-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f8ed69-225e-45fd-c625-08def6dcfa75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|19092799006|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CeNq/W8ySISWdAC/sR7WyOpgljSE2K2sX1ooyyPeV5W9lXHTdnMvShLpEoU/4CsG6bZkTklewRnHs/lgTNkLk9ngYuXU9lFlypOxWPtIGJcFAjF/QSNy2RzHpJe/cp4AcW6fNU95oAhyzEn+u9oGXyjORguFOdd0pvnwSJlCCeoq8eu7eMDskvAag4TElPl5QX0KFl+wClCHf2RfuM02JN5s20/882X+kcFouo+1dzqWGIO9FAPF2R2joRsE4fsN3caefB46uZDOygrk6NWS+YqSK73q+XKBKVM3xwZswDgh0xm5pPvy8U5T3CUkOJVlOANjo7v7VdBT0eExpRc6KGaZo4RAhWhgolfJooT9CJ9glBYV3hCuuJFlsVgFGAzDuhImRFAJTY9HyJUkBDltDtdTz01Y+soBtbZQQMlUM528IGV0qphvMOQB92PZJFH1J3WAFcuOW9hnu6mFopxmxPJ7XdEvQ+Uho7yI6cg8ozE1ncgGQmI6Q0z/Cajgv1GCQ8ALtnh0dZTwAxWSV2mmoRQ166ioTP99C+bes6CQeUB3sghliXELqvapiYNqiPVlnBNUpki5Qa4wH7KXaxkdAGn8eBAqtHN9amDCFo5Cki2BgoQjux6rN3+P5xnRPDirb2CfeXJ+X62itG2IWm+Sk8+x9etBQ9NBa5mvc5hZ28s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(19092799006)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlZEWGJFWUUwU2xlVFdnR3ZzY25XMTJJT3ppRnFSaVB1eW5UQ2tXTlVyMG1Q?=
 =?utf-8?B?dkdpR1N0QTFJdFozTHRRNzNXQVZYWDR0RmZnMjdjWDRmeklvamJqWkJScWVI?=
 =?utf-8?B?b1RkdzdvbzNKVU9McTFHVDhtdC9sNGFUdEM2c0lMT2krR3RiUFBvUExzY0Jl?=
 =?utf-8?B?d0xsSDJXVU9WOW5IUTNpT0lVWTlVWVR6ZURuaFkybmFZL1cxRHo5VWVGZGY4?=
 =?utf-8?B?aHJ6c1FvUXphL2ZYV0wrSVdKQUtaUHo1NGFWZEVzUmdCMlFwZkpHeldCRnA1?=
 =?utf-8?B?VjE4bTRMMEdXTk5ZalFHWWRpTnNCdUlGWmZXOHErblRVQjlIbXRzNlY0elRn?=
 =?utf-8?B?bzhPa2cyOVc3dHUwMmdMbnFKVWNuN0ZkdlV4SjRMcGVOc29UNVhadGM0OExs?=
 =?utf-8?B?NTArSUFScTg0VTVnNHBEVmplcDdnYUpkaElqTzVnY1FNSFZKTkREVExPRndN?=
 =?utf-8?B?cW9FTmdsc1owdU9RWk1VU3ZlSXVsQzhURUhRNG9meXJ6MWRFbU9WSUlIVXZT?=
 =?utf-8?B?dUQ3Zk9aMDdjN0x5dHIraVRCNXRiT3J5R09GOXVneDhuT2RMN1NWK2tpbnBZ?=
 =?utf-8?B?dlVPMXF5dnpjYlRQR084OEZIeDZYRmxBVHpyOVFLS09XT21BTWIrMDRkb1lK?=
 =?utf-8?B?d3JQclRkM0ZJeTJzQ1B5WXBTVWVDWFQ4M1ZQbG1abDJJUkxhMnl1UklVMStY?=
 =?utf-8?B?akZWRXU2RW0xSU1ZbjI2ZTd2Y3lrZEQxd2FrRGxRT3dxNFpqOW9VcEdEcXp6?=
 =?utf-8?B?dnVGMDFlRFdzRWF4N05wVUJSOXpGQStsSlpua2lhYm5kUXlCMUx5YzZqVWxs?=
 =?utf-8?B?Z3VFQUorMUlhbWlvQ2tvR0tkL3hNS1dWMmtKVktwdlJ4V2VkdU1CVkNGa2Rz?=
 =?utf-8?B?Y0VpQllHSzgxcngyZjBhQ25WLzR3NkhHcVZyUUZYT2ZSbmMzSDc3dEh6dlFp?=
 =?utf-8?B?NDRMM2hrNVZ0WEtPYWJ0V1ZwRVc0VndqZ3U4djVwNXZkQ3pqWXVxT3hheTZa?=
 =?utf-8?B?OTZpbVN5Y2VFN3JqTXBGNU9QNFVyZmRpMWNrR204UzJ5T0VValM1SzIvTlRp?=
 =?utf-8?B?L05IOVdwVGFHdHlFbnhaL0VLRHJEdWlyNUp3R3QwaTJYMDU3NTFRRjBTNjRk?=
 =?utf-8?B?R1dWa2Q3YXE3ZUJaYlYzWjI2aXczYW9EKzl1alRSaXQ3ZFlpVVdleE0zbGVB?=
 =?utf-8?B?UXg5cXlmN2VWQUFkcW5nMENnMjVvTUdCM1pFUEdBN0IwSWoxV3BDTFRvakpT?=
 =?utf-8?B?OWZ1VlV2a3hQb2dvcHllUFl5R3pYUldRY2dTWVdjcFRTbldRUVFEMzk1ZEVG?=
 =?utf-8?B?VXdiQjgybEZyNlRwbHNtcmdaS3ZzclpDS1o1dEd5Q01ZZE4zR3kwcythV3ov?=
 =?utf-8?B?b1BCNzQ3b1J6TlViK3FCNnU3QndKNHh1WWw1RnJyVnNhNW1OanA4UWszNkU5?=
 =?utf-8?B?cEQ3TFpkdXZ3cWtqOGRNeXFPZjZ2ZXY1cVFYcjBYVXl1bDZKSVhvMU9HMSti?=
 =?utf-8?B?eTlFMFZjdmdqeHdQaXduVGIraHVXWHN2aWE4U2xrY25pL0NKY2Z5VlhEMjhm?=
 =?utf-8?B?cDUrazJjSGMwK014Y0dJTU1oaTdVcnlLak5FcG0yam9qY3ByTHJJcGFhbUVv?=
 =?utf-8?B?bklLdngwUDVHWHE5eVRqOS9ydDY5UGUwdkkwbXloSG1KMTBQTjhybC9TeUVk?=
 =?utf-8?B?NHUvQ1VwU3hrYjJ4SUNNZ0ZuUjF3akc1ckRyTXIxWDJDQnNiT3ZMZFdsNEZo?=
 =?utf-8?B?ejBlazQvOS9aWEdJK0dkb2JKdnMrK2huMklMMmFSNHFpekdNM1pZYlA3cXM5?=
 =?utf-8?B?Y0FvUHZUY0o0YWh2WnJqaU1UanlJYWd4dXl5UHpiVmtvcUN6aU5mK0ovOWtz?=
 =?utf-8?B?clprbzltUzU3VDJIR2xwTjFZdDhCSjNPSDNxZVVMTEFJRFl6N2kvRjgwa0VR?=
 =?utf-8?B?Qk5WK2tGbzZZMXNBeHdrbWY2WVRhMjlLcWtxZzB4UW44Zkw3ZnQzT3FXcUdC?=
 =?utf-8?B?dDVMOHduTEhCbDFVaTVHcU1Fa2t3YlNwRXN5S0wyWi9zMmhMN0dXWHA1OXpW?=
 =?utf-8?B?TmJpYUMxRzB1Wi9PaGsvSlp2NkQyZE9vVWlBZDM2M1pCTW1BcHY2YjNMTU0v?=
 =?utf-8?B?L1BXZ0xpRTFQOEhCYnFsRjhOd1Z3MWp5Y2JFdmVaRGNJZW1ERC9GQ1pMZndZ?=
 =?utf-8?B?ZWxMRWRxUnRZTWxGc0RrUE1McTBEbW93ZWwvT0dCbFNSVjhGeFFIVVRjWUNa?=
 =?utf-8?B?M3hRa1J4UUtpejY2L1pKeHRsZjhSdGFzMXY1NDJkeUxMSHNSd3h4R0xuWDU4?=
 =?utf-8?B?cldFcEJ1c1N2NzY1QXVSZ3Y1a2tMTUVsR0VmdlZ0M0JGdUpEY1djdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f8ed69-225e-45fd-c625-08def6dcfa75
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:43:28.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TINhJ6gMTBbkr9KHfz2R+iXe8JmgAI3uHWd3fw7QjlKdPAFfi7qeOksiK2Lc6V3XqSfzobVfHedqOggH6DEJ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861

The tegra as well as a few dwc PCI controller drivers uses PM runtime
operations without including the required <linux/pm_runtime.h> header.

Similarly, pcie-rockchip-host, pcie-starfive as well as a few dwc PCI
controllers use the regulator consumer API without including
<linux/regulator/consumer.h>.

pcie-spacemit-k1.c uses of_get_next_available_child() and of_node_put()
without including <linux/of.h>.

It seems these function prototypes were indirectly provided by
<linux/phy/phy.h>, mostly by mistake (none of the functions it exports
need it).

Before the PHY header can drop the unnecessary includes, make sure the
PCI controller drivers include what they use.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>

v8->v9: fix conflict in drivers/pci/controller/dwc/pcie-spacemit-k1.c
        with commit 995832b2cebe ("Replace <linux/mod_devicetable.h> by
        more specific <linux/device-id/*.h> (c files)")
v5->v8: none
v4->v5: fix pcie-spacemit-k1 driver, previously missed due to limited
        build coverage
v2->v4: none
v1->v2: collect tag, adjust commit title
---
 drivers/pci/controller/dwc/pci-keystone.c     | 1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 drivers/pci/controller/dwc/pcie-histb.c       | 1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 3 +++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 1 +
 drivers/pci/controller/pci-tegra.c            | 1 +
 drivers/pci/controller/pcie-rockchip-host.c   | 1 +
 drivers/pci/controller/plda/pcie-starfive.c   | 1 +
 9 files changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index f1b27aed488d..e9b012a5ea9a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f9efe2d44957..5d41e6096504 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -21,6 +21,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/workqueue.h>
 #include <trace/events/pci_controller.h>
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index a52071589377..432a54c5bfce 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/reset.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 56184e6ca6e6..8364696a1b98 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/module.h>
diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 0564c46e2f48..92a71ea90ac3 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -12,9 +12,12 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 63a0f56cad8e..8ab23d1d7bd6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/resource.h>
 #include <linux/types.h>
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 59b56446c507..96bd522fa67b 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index d203c4876d30..be8ff99b243f 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include "../pci.h"
 #include "pcie-rockchip.h"
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 02d5aa6dc14b..b693eabdf85b 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include "../../pci.h"
 
-- 
2.34.1

