Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949472E414;
	Mon, 13 Jul 2026 02:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909934; cv=fail; b=mccMg3rM1pj7Qhi+QlwUmPqiJDTJW4EOX5ITvwfhb1G6VDqerqcP9oGqoL2QsEb1Gy4mvYlNgQRPZog/J3gUs9hoUp9torvTKP3AK9GqkVJWRbWXE4B8h8G4ngBiCPQaMMuJDvhFv1bnP3a9GN18bcEz82TKb/pX597bbNSwRGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909934; c=relaxed/simple;
	bh=WcMJLVlG4+N8uk+mXST0sETvY+lFbTw2PRX1gh5QXaw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B7DbkenbeVv+1Nxx862OQQAeYraBbf9j01WaYeP1+e1lhFJPItWJ9Da0vkiHyCZUm0fDsWqTHPN4Hsvl2TlbxS+bxHjEoxeq5GlxI3/cfGu0f/7tc5fwpX2zrnJ3q71P2on0RfbjHPjVRGcrbj/A52RPqyHOHgLJ1unTgWtE+pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=h8yjb+yj; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h8yjb+yj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtEG7hueZczZxz1jSrSpVUEW2SAmAOSSzoXZI357wPQBOZckCyNJ6YJxN0cKTc4Buh4VcemFkl8aXvD3P+hRwwwOrZ4ilWNUDiypjNLdYoiWDAgTYoh5rGT+X5xNFwnV4eVU9bOZtse2KIN3gNfEMaocr2SRt+9yExJJqK1E3m94wdrLoI0zXje0UzCObe8eWOT0TtIGejWZoOOO/UaH22n7xNV3vX+ucwK7yWZ5t94NHgJ+xA3LN/SNwEG1QxrjcvZOxUHXpfNVUGwWsRBORIAUIs/bH9IJgrpkpXEvZbEDMqhlmKaVdteON38+ijvukRcZ6oSqunE93fe5og9TpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw7mT3+PAnOqNAPOr2Ac2dDRhK8YOh7BFISecTug3yo=;
 b=tL7ae5fWI/+wkPsqsg4kjPy9XmvqAlSCu0hkuYQLSdjIKmV3ByUe2QmCGOyOr82pMDy2Q7PoMkKLonoDyY1A7qfWhMR8TgOPSjtyo8LHVetpCj7w+I6r2fmXJbKnUbCDCN6iARvb3d/VFv567uQdHdUvXodJtf57jJKUr9bsnPp0DedJ4ReBVgSzg2OpCOxFDELR5EUw8zdWFJJk20JnNqzTf99v8QuvvJ2oYYuhjSKb/PL5KFEmxoHwOz0qBUAK3DJvzse/7BkNImi8n4jI+fb+RohdW64HN5VXoPEohXJV6xYvE8IqLqk1CNsULkofwnffA7XCKOVjeIWHXAEcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw7mT3+PAnOqNAPOr2Ac2dDRhK8YOh7BFISecTug3yo=;
 b=h8yjb+yjWcyOPpIwHUvHgKkn9zuvlJz8t9rkPD7fcKpPJUaPlrDW+oOM4MKnvBYbNpO7c2+eV87dPXXdeaOt6MjV0LSw3L/XRaLmeEypCTJVLJWhXuRZL/JgG+Zxen9AFz3wkdKPJoshN/Yb+WLbFERrAXjehXmjFjnD4CbcbfyE+eEjfbwRb0oT1hmF3MDvSK0DtIV4/6ITVELjVylahpzDHNsQy01EeBwpWFgHjfsNRUNxedcJhh/RMYE06rvDSQtyh4IIewwCf28NEVEFzK+7cAChEmds2HJl5r6i+wCp1kgtFUbak2OnnVaxtZoa1dSgDRoY959f4t1ka+hP9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 02:32:08 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 02:32:07 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V6 0/4] Add PCIe M.2 Key E connector support for NXP i.MX boards
Date: Mon, 13 Jul 2026 10:34:31 +0800
Message-ID: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ac0f36-daf7-4837-f408-08dee086ef21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|6133799003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	g5KWMFc71USu5Aqta14df80G720NpkLsKWi0E8risJi7a84AP3nUJIAokmWS5+rJRh5Jpge/MvBHdFbcw6f5Iv5bEkZHI0qWbjcmXvMSxUIEnt21rJlhkjTp2C3NxvKJyxRxCg6n3L3h8RzpFGQrxIhPftQKYyNdheJJ2IIv84QMZeCJRKOx79KAW7GHgeiWAT+YdQGYzvE/3JRjj0H9fKzmMgZboUhknZa2CoG/bbbhq/ItRTOKwREgqkIWDXZcS9NMfCfECFotzAA2Q+QlnNlTU56/MJwh+/gUCG4k5XmxsZJyj8GB/3uK2i+fAgfcSVV72FuRZNsa52rW9KIW+8aqYvXJXyEfYOdSOErssMd5esuA42DXa0mb1mgkj6gzTD5DgZCyEbX2O7MuTOYLcTYD0h/Q/7zDvh7kw+1VW9lGaPncMSrepCSbL5SXLJf9r6tT66VNny799tTWjkLLLFFLZliOAwRqV7t3Gfn519/MrhojvbRR0pPyb4dR2BOdkhSbD1DhmxT3efl/4Y3RjzPNO7kHhvDkLmUFib/gRa3Ek7SLG28FmOH2DhZK1jYof5XXLZb/RkG2xT6lm1JNW3mgl9YOZrl3EYyOd9cmf63htnAJ/OZm7LDIbHlr2QnoMLg5L1iSfDrjJT0Vm3J8orZhjPgSzqPjIOXgw3iiPfWVlneMW/rf71pUVkbmIXxV+qQmowWuUwTkZoWv1q/2Ww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(6133799003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hG1a7TNiCF335HAqjkl+FAk7cSs0FZmUbgyoSENSJNeMiyOnMTiQe2ySA7Dr?=
 =?us-ascii?Q?iod0sy4Jft7b4NhWpJChKhGzV2bPsSoMndcRPbpsF09RxpAKKJl7PieQgDPj?=
 =?us-ascii?Q?3Mog+32ZDL8XQdmDCZ6qVXn2RplE9ZY9854oeryXxhlVyNLQg93F0004akI9?=
 =?us-ascii?Q?u5Lvv1aljsj3xUbfl3CUS4MCERhkb/S+XxXjsw4UD6d9K+7R4UHenZgt4j2r?=
 =?us-ascii?Q?tfA7LxOXYU8prWU4ViF2vFdwnWr85HQiEqJwKqaoE2RdY65dDIC/l4gFJOMJ?=
 =?us-ascii?Q?BdjF11+vOoijUXyznE5x0FMxlcbp/RQcxfhvJE6t+djMtHNFSEYR6Har6RJ+?=
 =?us-ascii?Q?b700u9XqRxyC/IMFiqRid9tUj/l13p1E7NZsGVt4kgfsgqGuMGHP+qGYTb7d?=
 =?us-ascii?Q?NOYlGa8D8jI5dTNs+pPCUxmYdp9GYT5p6LiYj2ZuRwaElIuQCxSNO04wHwRK?=
 =?us-ascii?Q?zj50ZTlz40pRHUI3nEO2QhBThc/9sVpp3xa0naG83WKbm+9vycsbOC/0RU6p?=
 =?us-ascii?Q?91XB0X1aNZZrZnLRaRppchRCeNSS8UpS+EYlXmavEN3pOkD8WSDJWWxFHmwz?=
 =?us-ascii?Q?DbR1IX2jY6IFrYqkVa79Irk507aYwTiFr1UbIBNsD0d1w7dVHSm6qihrkijW?=
 =?us-ascii?Q?K5oGfeCn4M7r5rTCnmnxWtBRTAcWvxR0ruiKsmM12b/k5uF94LHhYk+1mOii?=
 =?us-ascii?Q?L1gyXBAd7xMB5SBCb2AdAUFGcpQZDlOmUg77jmBebEtV/JOxeXWYp6MBUqvY?=
 =?us-ascii?Q?Lwb28wSQkRQVlolpGWpaaTo2L+o/gMye/YhVDU94AjGyOANw23daNm3F8tts?=
 =?us-ascii?Q?YB891glldw6eZYixfjtSdz1aDtwxBioa/9MYsvV2Dx5sgNmNDy6SLku1n3mk?=
 =?us-ascii?Q?CGgKQF+MRTACGmAMQZs+8ZiCf+/Bfgtq4FXfqRLCPD0HChrKAc02XS/K00bw?=
 =?us-ascii?Q?I7KtNd1Ii3hdmwrJOe/y472dUbz6NNTtxsh/Z7RQNJWZdI5V+Dp/GQDq5DHd?=
 =?us-ascii?Q?1riFhfIT4SpsLBYqTKPIL+USQZh3kvLcwHMol1NIqiirWm5GEyaHQqrGSqFA?=
 =?us-ascii?Q?uAf09+RMCiwTcAt1oskkyuGuDgCwpyXKTv/hXF8LUNyD2DoqoZtymGtZc8Lk?=
 =?us-ascii?Q?X7GVWs0v09YHBYZJV2OXzrEcIa2ukY9fnAb+vffaS05nmJvdfPj7TCKuVgkp?=
 =?us-ascii?Q?Fwre9Qn/xmjLjZvwSxLwsBZ+Zt+5G/jMfJVY5R0oLBi0c+HXvjpoNqmJDaWq?=
 =?us-ascii?Q?p5sVFxOow0E7GIEvwEeXyjmR7gqE6B5iC3QeGdMxFiSC0Gu8XD4dmCkjUE6o?=
 =?us-ascii?Q?YkSS6tP5ibF+pjIzfQxZpByQSII/lCG4bwTsNUhhDpcWajJwIFidtk9+Uhrr?=
 =?us-ascii?Q?0SEGgqK5r88tjLlIC2wGMMCx4uadsBrHymSoAhOVgDk5+OaAPpHTdntAlMSV?=
 =?us-ascii?Q?yRkNiVuX/ncBY48SZ7aNUkCskg3VVamo8+4iOx7qRVvw5kw1bqircL2cM7sd?=
 =?us-ascii?Q?rvrgwVbnhsZhBGgLDQZmmWD8gm1LlWeAUFwanR/fEhyfaibAqAVAl2mLWfNC?=
 =?us-ascii?Q?rZVEnOSwt753RYRJ//Y+OsAvSlizdUvkp4ZZh+vruj1GDojP9k9DaJj99FpZ?=
 =?us-ascii?Q?oyBSn0cVLL+pRzQAAX+XmIweqGURE5Gnf7RJqlQ/siLBiizRSBwqpReiYQCw?=
 =?us-ascii?Q?NFTonxzJfd3VF8lX+Y2KzXIuDDt8a5UKQUZq1VWIQcMuEXe/eDCYFX+HqIDj?=
 =?us-ascii?Q?L366ceDf1Bnc3SOyACR+vL1lj1WLoTq9GrqZE9Qw8/U0qoDTbGB0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ac0f36-daf7-4837-f408-08dee086ef21
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 02:32:07.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+pMTvAxEC5SqUl3pssr4+SqJ2/TNNxW4ZwTbcoNGM/d3zCxBdw6FbuMO2rf8nDs7U2wETbFMcefvyAC68nHwxXNuh90WD1QWN0udKscILoAaiM/JMjBdCAnpnp96X1R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810

From: Sherry Sun <sherry.sun@nxp.com>

This series adds support for NXP Wi-Fi/BT combo chips (88W9098, AW693)
inserted into PCIe M.2 Key E connectors on i.MX95-19x19-EVK boards.

For M.2 cards that rely on PCIe L2 link state and wake-up mechanisms, the
card must remain powered during suspend. Patch #2 uses the existing
dw_pcie_rp::skip_pwrctrl_off flag to skip power-off during suspend and skip
power-on during the init path.

Also the btnxpuart driver is extended to obtain a pwrseq descriptor via the
OF graph on the UART controller device in patch #3.

---
Changes in V6:
1. Fix the power sequencer reference leak issue during BT driver unbound
   and re-bound in patch #3 issue that reported by sashiko.
2. Collected the Reviewed-by tags.

Changes in V5:
1. Improve the patch #1-3 commit message.
2. Remove the skip_pwrctrl_off flag check in imx_pcie_shutdown() in
   patch #2.
3. Add an explicit pwrseq_power_off() call in probe error path and
   nxp_serdev_remove() in patch #3.
4. Remove the imx8mq/imx8qm/imx8qxp/imx8dxl old platforms dts changes to
   avoid pcie functional break in some cases. For example, Uboot without
   M.2 driver support but use the new kernel dts file directly. 

Changes in V4:
1. Add a seperate patch to move pci_pwrctrl_create_devices() to
   imx_pcie_probe() as suggested by Frank.
2. Rebase the dts patches based on [2] patchset.
3. Drop pwrseq-pcie-m2 ID patch as it got applied.

Changes in V3:
1. Move pci_pwrctrl_create_devices() to imx_pcie_probe() in parch #1,
   similar to other regulator_get calls as suggested by Frank.
2. Collected the tags.

Changes in V2:
1. Rebased on top of 7.1.0.
2. Removed the power_off error handling in patch #3 because pwrseq_put()
   would call pwrseq_power_off() to automatically clean.
3. Collected the tags.
---

Sherry Sun (4):
  PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()
  PCI: imx6: Add skip_pwrctrl_off flag support
  Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
  arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector

 .../boot/dts/freescale/imx95-19x19-evk.dts    | 55 ++++++++++++++-----
 drivers/bluetooth/btnxpuart.c                 | 34 ++++++++++--
 drivers/pci/controller/dwc/pci-imx6.c         | 38 +++++++------
 3 files changed, 92 insertions(+), 35 deletions(-)


base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
-- 
2.50.1

