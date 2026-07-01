Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A9B3A543A;
	Wed,  1 Jul 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903042; cv=fail; b=jOLiUy1mzDW4D46HSM+mG94ynIyJpe+bMv+EHnU4YlYUJACv4/nhzvYPSnQYktvw/cXDgdyLnpO97Y6Kj9vvV1fdCF+ixAeMPbHIaxxm5U+cH4Je44JBw1eyTeLK26S9PUXEuU0cjOR4wLeCDe2+uLD9aTcziD79b/Jl5cmZLd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903042; c=relaxed/simple;
	bh=z2HD9Dog4vXzbMBTervRNz367lcG3SRlbNWZqtynn9E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sgZs0l704gPg4lnaayuhrjVdXeNPpSE5Icheg5bAbHbMfHPDr3QNh6nPXCZ+DwbkIoull4CEcGNqqyWzF8EyQ8yP07srdJQUXLuEUrEWQNfQYk/WxC2BinWm+12ZWAPNze9CVeC6xDeXtkkwcVahpi0KEs1D8VWrBkjcKDfNef0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Oe0JE0/F; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Oe0JE0/F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwx6fkEBk+90+MamfwRav7nDME/fpY1briI7Qpn0YFDfeXMWEC3Xc7QDltcw8qpIN7TVa7W/GyQDrLzorCczA1Y70iOBBqtxR7I1Nu47N8h6Jl1+9hNf2akG2q44tBvfMewjiAu9GOHCqYiMyo7BFfr5vBzRiZ9VgwCDJ9HTPO6/uVzNlOXIQz/50B78S2pGVyhzs8bJcZ1rnmRC6gylhCf5EkyeVeh9MtchUaoejj5Dzpc8+rMtQpO8rhDePl2VwKIc6trfzqID+18R5VG2y6oUoL7QAbbP05q+dSQsn1BlqLO+8hwMF62mnIE9nQ0mTcMgIjoObWI2vr3BU/ZLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS4AKL4j9/K5N4GJ+A+l+DBC/aCVZeLPKC+wOqUJdLA=;
 b=s8l/qJx/Y6Pk4maHNOa2UW4ausXb+YO3ELVJEYKeacSRBZgBPvZtYnBVRlYNej6ZBpMzmQcuOYbQ3WvRHWcGFEaN7zhmOkZhAetH6j34ChySSb73Itz/S3oBzy8i/tzxORu4alAbZODJYneUjwA/kQgM/+gDTv7JrcfswqzjdwzmBYyfmFtuhlWvGecuRHHAMKw/Wn3iKhYKwm42CB0o6pxB3b26nhi916M7yqeXXlLEs7m4pRO/WGkpD+UkBeWd/5oTuSN9gV5bpE0lfULhhW9k5lHfvBRLq2KOSWtkr0bkpABEgNXltxPjLb5ZdnrbfnrbXmNllaqf0uEzRavwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS4AKL4j9/K5N4GJ+A+l+DBC/aCVZeLPKC+wOqUJdLA=;
 b=Oe0JE0/Fh8nbcOiQr1CmsbKXOTSZdCsVrl+8CVJPt3IFx4TcD0DmP/jQeeKZ3F7TjHKk+wr5iqn/F5cZnUZmrnKi9vTl4Y7x2ozA5hWlVtBnXNCDPPDku/hc8BZMxfUuKAM7eiEP0Dl01/ds8IpKqSol3LGWd2KmQVnP4pKKj96b3N6BQzn9h6x9wMolgV5UW95DUyoxCvrpx2miCKuP70rNOa/mDReMm8yc+EfSg2IKTduTO5MIY/vFkz7mcagGwlEmIq3Q83S8G1BeXeWHTqZkKFjpGV6Vh5JrO6B4NUU+IwzFEOnntmsj719/pwUNrmlzIWz0RSiIT4i5V9TVBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by GV1PR04MB10252.eurprd04.prod.outlook.com (2603:10a6:150:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:50:31 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:50:30 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V5 0/7]PCI: imx6: Integrate pwrctrl API and update device trees
Date: Wed,  1 Jul 2026 18:52:27 +0800
Message-ID: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|GV1PR04MB10252:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fd2669-8cc1-4cb0-aea2-08ded75e917b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|921020|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Hq968s07hlwg9qRusRLV4LoDhKEPz8Pcg9odLqksPmTvCavF4PBP9D2vzL5OVLP3699VGIE+dhfeZRRu8GbZ1Lnd3VFyBIAoc+CkUawY1IaFVHD/5k94rYv+4mt8zSBXQGWS/3rYtLXiZphf2aVBACUhc6n3nDEUugF3qJtvP1kkZIY9eJpwcS5JgzZ1OtYtpwvuh0DFdFnDW8FBsVHiMxe0WI6RS1KjxZ3a5+eof6mEIFEGYoHXMJ1+pVl039PO0kPnFFXvUUqiAe/n2ELKrSJ7G0DG6VdBEbdJEdlVGewCl3+StUoOFWbL3SNuohNegAYFpUEIhjtRlgYTPW9Ja/8w+3MEe24h8VGNI/lTkLIHFI8LH0qgxuKqK3VcADF2BXWgrHvnT3nLZrR6xopf8xsJDo8yr96M/cyBJ2w2y0oBTb1WZu4OS9Kg3AVMAasTz/8s0bFWQR1OrpZAg7N0mLOEI2RRZKoYLfCJ5CDm8iMLneq3j93kuAJBu+ct+v6aq6mJVhEDyOhvetj640Fh3fO6ScEYW6kGA0/w6n5EsJPO/3s1F8b3QmpvKiUWnRPMtZl903JF+rs6eduxqUBw8hCuIDrJNbAJBzP24+tafAy03NT+3vewdsHoeNz670yEsa/K0l1a+M3N2hI4TmwL6Gs1EwAeGefn0qv6QUVp90gmdoVm8Xw+y2t98TJbuxI8jkCjk7dnzG3JfRdg5saT4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kiDQ/iYBvbBBwBsNnWt2jJ4UiCUDrYnljQ3zNP7IH4aR3V1W4ewNzk+ffWUh?=
 =?us-ascii?Q?FYiF+jCClQEglnYgq+CuYe0utk6p2vZPfRbWAcnHdxXMsJMkRgHpF5FPphyb?=
 =?us-ascii?Q?hvA6oZkDzBUa0iIW9wCcF2a+nRDLYcTJ3G0oAogQUq848A+hxwIOak1/dZWe?=
 =?us-ascii?Q?e2ap12ca0rm5ObU4HsDB7NSGSLllXux1B/+xrSZ+fleTstgqAZ5eNWc7Q1X/?=
 =?us-ascii?Q?kH6VAw3FC9A0nHzVJ8S6CpK8KedBWApA+VYkB1Lu/3RvWsu1m5n6kCU83ZfT?=
 =?us-ascii?Q?MpMCOKMd4cp6079fqGiges7Dq8HMqGoeQ7RIH06jd2sNRo8LIpuoafQYucNP?=
 =?us-ascii?Q?fp/MTrwWgWGMC0VdtcvcaSmB71iEGV4ssBsZVadjCRQWRX470IKMzu1w5R4X?=
 =?us-ascii?Q?6zrmvd7P6yvGhAgG/SgXnXd5OK9MI0FF4nKl4sJ8PPk9n4nh00GksvI0yxW7?=
 =?us-ascii?Q?5BwD5Hv6hwAoCG3XpBy7kGg6acVWwP0MP7NCZUxOAuJ0dq9+UPB/3HRyajC9?=
 =?us-ascii?Q?8o1Ejx9tl7jBpKux5IS3tbM4avVn98u4rECgZTfq6N0BPE5IE1Zk7XadHAuR?=
 =?us-ascii?Q?tqYNU/uNSj6H/j9iXdF1hGeby7mUu/4FiBszs6hWIpvmXtgY8L97jLWe6wZT?=
 =?us-ascii?Q?VWZ2/2o2qL69ph/Nx8vtxtSsk7jGWxpf0r73F64DUFvw+iI6EukYfZ4zdoZq?=
 =?us-ascii?Q?w08rMokCNSyiE+z7qs83tqwqC+mrJnoOo5Wfu6ZdZa52OJz3CxhEoNd0JLhB?=
 =?us-ascii?Q?CAlzypn5zwj5zURPK7KaEv9npbFybn7sIy7+74qN7DRmZZ/UdL4trwLiLdI2?=
 =?us-ascii?Q?8QUNAT0prE/6QNonAxc0lJYdcKIPdV3Usq+V/aM8dKuQVQCUGpfC/LFbWU/U?=
 =?us-ascii?Q?3S9V074F8bK0Gt6qOT9Swxzb/CX0/zpz7KJg51IoaZN3JkFa6aOgmSVVUoUh?=
 =?us-ascii?Q?UZxpIwzgbqiUSaZyOlCe/0FAXbiXA87yEbCyPuifDZVARq0i/xOQHdNLMFkh?=
 =?us-ascii?Q?LiGPTfd/GS8drw9B+cnwnIx2SuKestBKaIqzcTGo+N38wwoo179JXJfuXebg?=
 =?us-ascii?Q?PHHx0WoYFbvPfXFeXpz4p713YhnxJSRmFhDJEWrBWB6PMNHZqxvTauupyLvC?=
 =?us-ascii?Q?4N0tOV4VgBoUw6MbYdNvo1uoNBV78hBP5yXggsEa1Q7x9MFFl0ampPAX1kqY?=
 =?us-ascii?Q?JbYs/WKdGjDQCS77sZJzwlrWigfiSxWueGZteh38vTUvEAMrFnvxTsRp1rpj?=
 =?us-ascii?Q?QLdLj+X0aFu8nrbqzj8LgsP5bbOlwNK/xANBIe522ciwdXDuUIeOVk4DJTXc?=
 =?us-ascii?Q?LdTjOacqfc/lAK6WcG/W+bKNQvXLem9d1imbUp9d2EkzvrxHO2P7arFGdKMP?=
 =?us-ascii?Q?PA7mZEkYrnfmX/ZPZ4k5zw+fowlfDhF49WIWp6RwbUemT8pS3geUtEUFS1TL?=
 =?us-ascii?Q?XdvH/xbrdVbwYDulBAFsHTfe5N9823G+GQHA9L6ASQX8Qtw0ihkCZAcnwqHu?=
 =?us-ascii?Q?gobvNXYNIXseIoInyTtyDJi7gaM6KFlf2bw6HGDNtU3953dDaJJwr6KTJvkA?=
 =?us-ascii?Q?hqFHiogPhDursoP1Zcys4K2gX3lqQL5rkjuhlj2DOncCuk5t/n26TvzOPoDx?=
 =?us-ascii?Q?NGwIOICd8IF8ITDyUuRWSvcAuhTr3mvq/LcS2AeukuUGT8nl0csL9wqqqAA4?=
 =?us-ascii?Q?iSbwL/18VhUuynCNOarPJGyZgvgFQJpGMx+HCM9nxRfmiNs13N8hu1REbv5i?=
 =?us-ascii?Q?zoN08oAiyO3/kf0LOZIHCdrPzvrAH3oYDhR6TZUuvPEOGZiV0QpN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fd2669-8cc1-4cb0-aea2-08ded75e917b
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:50:30.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3/ZAYMHnu9wOzZOCXyxHR4osW9lLeWbfRHE6udYMjWxpo7TIqQlRGGqNYKUtqpaJMSGLTO73Qdyzj3YzOZFXhmZozbfePkWaSRz5Qqdm2TtsVRc5i41GBpPG027pPdo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10252

From: Sherry Sun <sherry.sun@nxp.com>

This series integrates the PCI pwrctrl framework into the pci-imx6
driver and updates i.MX EVK board device trees to support it.

Patches 2-8 update device trees for i.MX EVK boards which maintained
by NXP to move power supply properties from the PCIe controller node
to the Root Port child node, which is required for pwrctrl framework.
Affected boards:
- i.MX6Q/DL SABRESD
- i.MX6SX SDB
- i.MX8MM EVK
- i.MX8MP EVK
- i.MX8MQ EVK
- i.MX8DXL/QM/QXP EVK
- i.MX95 15x15/19x19 EVK

The driver maintains legacy regulator handling for device trees that
haven't been updated yet. Both old and new device tree structures are
supported.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

---
Changes in V5:
1. Legacy power supply property is retained for backward compatibility
   in patch 1-6.

Changes in V4:
1. Fix the CHECK_DTBS warnings. 
2. Drop pci-imx6 pwrctrl support patch as it got applied.

Changes in V3:
1. Rebased on top of latest 7.1.0-rc4

Changes in V2:
1. After commit 2d8c5098b847 ("PCI/pwrctrl: Do not power off on pwrctrl
   device removal"), the pwrctrl drivers no longer power off devices
   during removal. Update pci-imx6 driver's shutdown callback in patch#1
   to explicitly call pci_pwrctrl_power_off_devices() before 
   pci_pwrctrl_destroy_devices() to ensure devices are properly powered
   off.
---

Sherry Sun (7):
  arm: dts: imx6qdl-sabresd: Add power supply property to Root Port node
  arm: dts: imx6sx-sdb: Add power supply property to Root Port node
  arm64: dts: imx8mm-evk: Add power supply property to Root Port node
  arm64: dts: imx8mp-evk: Add power supply properties to Root Port node
  arm64: dts: imx8mq-evk: Add power supply properties to Root Port node
  arm64: dts: imx8dxl/qm/qxp: Add power supply properties to Root Port
    node
  arm64: dts: imx95: Move power supply properties to Root Port node

 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi    | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi         | 2 ++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts     | 3 +++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi     | 2 ++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts      | 3 +++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts      | 3 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 3 +++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts     | 3 +++
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 8 ++++----
 10 files changed, 27 insertions(+), 6 deletions(-)


base-commit: be5c93fa674f0fc3c8f359c2143abce6bbb422e6
-- 
2.50.1

