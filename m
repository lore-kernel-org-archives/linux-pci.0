Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811236920E;
	Mon, 23 Feb 2026 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872240; cv=fail; b=tZqSMcxNQfsozN8aTH9gIyNNQLDGjwBrtrg6WNkBBzeC07jLKhfmHRBc9hwJy6gHKMkwJ4vwUziGG1RW6gLgMq6JyJ03g4GUU1DMRR0pLEiKsmnr5cDZF1ls1IF90TF/dKD8G78Jyt06Zdde/SJf2QzwkdztDl4Yvtu9W+aeiEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872240; c=relaxed/simple;
	bh=ek8xVoViTUkjuS+Xh8QVIW33W/omd2bedFhlO0GfEkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i88JCObw7fo1z7x1Ma/JZe8I4FFrf0qzq9sDfNB1w6c/V+bTscP34w1Bh7pkJw+vd9SbemoGtK7PZD3Gy0MM2XOVnpGmMWx0d+PUMiNX91iS96Zy6VPFwCuWGRnchuiEvOQHmTWcztPT+WPqF6qOnYAP+NJAT1E2jcCBfxFK5iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Crp2t46R; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Crp2t46R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPjdmNvxe+5EjWpdf4+3rCQFxL0QTGUwtFxWOHLGysdMtKhBj5PQGydrw1Vt0yvGFvwLNoIpV/t+Cb/dex0UezxOuYrByEb0ScSpDTzppOohaupWAtwjxOfFzAiOpBCaX6PnUDBhk+c3rAEnWkWiNgrqr2b8an5ilM8VzjjPs8E0veV4laXPwmjgzNOqeAEwWt505Ki7je5ul7whXuhCNUHiH7biHlCUmvEA8WmxwxbfHXcriwXpdD31DklFa5IcO1GtFtuYJ33z2ROKU82NaWg/srkVX4HPbo6sp0awD2oNMNcGMyQdJSBno7IK2cYvGGCCkkzTJLX7YYTNOhB7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeXEXpvhnRlxASsBfRtK6oF8SaqbrjICr5FJpMh1lUk=;
 b=f5KhmwPqDa96bF+SCHgh0DqX3XQBaQ9rmW76HjSXDWCy0bRoeMM4oFHxB8zYiYbL2LqJ8GmazSmUzCIkhz5InCh7yfLEUIQKcr7gCTdHcbc/BIcsEOardXUBxqwpj483tg/tvBw4Q+vXMJD1YHlJzv7rtYmrty+yiUIPZZuZzA1BYPHPRYYxBcJxHOwXLWotOogTciaM8y1B0JO0BQXui3p5tgzgj9xPBa5A0Fjyf0mEaKPCwY3oaZ4mn+rNSJwJreacWV7ecGi1INM2XHtO06N7zrmPodo94aEUqE0iRVcMA46G/wHsnDjpCKjXOGt7uynDzIWpapzllWuLA7g3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeXEXpvhnRlxASsBfRtK6oF8SaqbrjICr5FJpMh1lUk=;
 b=Crp2t46RUVIwjAvgojRi1sTTF/Wabm1O/LteebERW0c0xfgOREaxf3lBNeOxf16f1apWB/FBeOBjZ28kAGCg1P0zXsteJaHYOt3+7OR2fMV7L+END5xDYbI8UpZMAyC3JXgT0JYt605pP9OVYm1g0zZsLPPrWxrSmLIp+z1qQAZQO3Dhtjhxw2bw8lcpNy4jgdSzuF3Jb3x2RfrhYhjXHTI/FMvwBEjDgL31e/paZyLpbSDPFPsgk6HbIM0AFnuwTAA6Y6Cez0eL+O9w2tqZTEET465iaz/TkbUGZNym2EbxFq0+G+SaN8rWWtthPXvsX8j+Aw9pt6EKRFKWWRBhLA==
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:55 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:333:cafe::23) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:43:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:43:31 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:43:24 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v6 11/13] PCI: tegra194: Use HW version number
Date: Tue, 24 Feb 2026 00:11:49 +0530
Message-ID: <20260223184151.3083221-12-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a7c838-23c3-4443-f324-08de730b7f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6az0jqP7L7yr4eiz5Xahs+3UfD/tWfOxsZga73ioSiGWB6lMClFoEkIcZefk?=
 =?us-ascii?Q?Eg4j4HhClrwovXkhz259c/pxFhhFuYd31j2MzWlZfqsfK6Z8kl4ruW0X5l0O?=
 =?us-ascii?Q?IvzMKPy0iYrKyse7mgftYQg3GK1FPcT7mEl4FpEGuC3yY02B0SgTg80mA92Q?=
 =?us-ascii?Q?X3lZjR17qmKTw05pozEKSSjr3PqXirUtIiBFpDog8lnmsG7p/uadtRIDteWO?=
 =?us-ascii?Q?HWuDHwj1WP16EpRRn9FeIXJljcm2byi5mG6XZhF0YWhS7zqYRwMGLf8QoV1e?=
 =?us-ascii?Q?vnLM2va38w/zhggmGcQg3gCpqMU/882C6kCKm1+OVoDOOcr/zHSEM4YTqoXX?=
 =?us-ascii?Q?ISkqTyv8nWXLouzpL04Kjdis2yRjsONQMDX7K+/yX3/r6RlWwiei7T3zfNhw?=
 =?us-ascii?Q?6Ql+0kleWj124UpsCpJpEyLLiDqzUuGkdYx5NmhordOI97BKxJsrPdn3bFps?=
 =?us-ascii?Q?jfIA5I5C0HWrSBmj31FCNJTQ3Ux9VCwUeIU/y0++Wy5IgzhlDl9b7eXVHH/u?=
 =?us-ascii?Q?Cbs9RENZgAfaUPJQyLp0WsEuDswvo1ZlcIbqneNbEG1IpRmxyV3QVD5MkTQP?=
 =?us-ascii?Q?5lVBqOAB4czOnpsMIqw52rb95iKtPyFucjXW/clp+/PgOtWV+WAmzSKj4Kyt?=
 =?us-ascii?Q?Jix2bZImkS1gqExKwx+8Ux/9KJWqoacQ1or/lHuEofyDTS14lU13E7CXN4FF?=
 =?us-ascii?Q?wHA7sG4d687tvMaGEr7cP+mGtuk3pBO/zOPyD3Z8oD1l8di7SJdGtnbgYgPy?=
 =?us-ascii?Q?9p+NsUK1I8+5h6JfjRi6JOuhMidUlKwVbOogtzjRnz8K9uZV0YXlOGXYyWYk?=
 =?us-ascii?Q?MsIvJ+itTFHHjNtFjFMc1ybFEsth9fIBNCsEzpG7Jh35dMFH8VI+CgciXbqS?=
 =?us-ascii?Q?jbjLoDhexWm4nReuHwVwF9LqTL9HR/CYjrMKw0dcxYNRHuJxTXccAsOAnlmH?=
 =?us-ascii?Q?3CxSr3mFDqjjhF2iNGaGLrFg0u54Ciu5R/TEvdLR5/ImiCF3DYbHuBeaEbJH?=
 =?us-ascii?Q?KIOtCxpbdr6s8YfvV4wFOCCDq3xEpwtTGWLBgRO1nuZE67lEgqZ9cRuoPDai?=
 =?us-ascii?Q?SxLo4/MwY/loGxflYaE0SsjjSkE8Ojrkrduqqp5RitwgKHABX4KNpfnThTAa?=
 =?us-ascii?Q?sOinQfP08JqPzmpTrgh9LM2DxrvhNm1qOuzBre1KV/8PojDoapJC9z/Wx/8D?=
 =?us-ascii?Q?YKrp1z0z6/Ynm+IbL0VCOtqcjRu1pymTHa0sD5Hre6dAnH0kHAyVpa3nPRkZ?=
 =?us-ascii?Q?4N9uFzYDgGnOQjbE3NBc1GpKKfN4otMZX8B8Vx4g+VsNj8eJI+U57zh4WwDi?=
 =?us-ascii?Q?J8B2T51yCgYTnaTTorEwiS1t/vEYimhR1FWu/dZpK3VnUDnTOOO5eKEdD6Nh?=
 =?us-ascii?Q?fpHxB/4ZTAnV5ZLWM+sL8tDE+xU33WuKDdzhhznGNi7L17W9UwKtZIh+NUyZ?=
 =?us-ascii?Q?A01fU6LZf4FaIRFxEEI1X/Hy/4f9cbzPYu6Myt+fNiTMbio8tm1Qudvajdbf?=
 =?us-ascii?Q?ZyI74oB+IhFcB7ysEJcKbmbeKNwLKAkjN2i6hxG3EGT+AdHYJA9r68SAgqA7?=
 =?us-ascii?Q?U6GQ7TiB20OjQUui1IrG7aOe0C8Hlsx65H7y4d2P2fElVaYCl2BT6jbj/P1X?=
 =?us-ascii?Q?XCUmqqEgx38P3hN4fV4lipGad+ai/10Bs2VoPbJELqZJNzra602qMB3mcic1?=
 =?us-ascii?Q?dzP4hVAfGl+uWxOCxPFYdIaU4GM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dAPJuV9STxupno+wgNYUT7LuYK9x2Z8yuWFBVC6wdIf3RzE9ByxLIILQAiSEO5OfTYHQ/ZeSYbYk8KDjP4FtUplNtFl38/QLwpdTguzAdqgaDgCmEzI941+p3WcPyUUlTcziR6gJUitbuiW4UxSR8nlH3UuVpiiAas3Jjp8BJwI+B5V1cJCVSZtg1joVvg/H83pqKXLfxcCVDJwhsVYiHEHNu5CrWwOXH/PWR91GOTpd1L30N25Ph8H8OlMLycplLdEg/UhSRXOyPCBV20YszNRw9+mVPlQW2P1QSIhy1tW3kZQvkCKSqSItoRoJBuqShVpNNhFXv84esGBUjusr7vILRzoQ3HrwSy1d88oXDEalXshrmj0GOcA54qbxvtwMsckyxt9iAcsBcpPonEeGN7Ayay5YIhfmne5iQM7W3v/PyVS0oXLKkwCcAiBWkAIl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:55.2989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a7c838-23c3-4443-f324-08de730b7f82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145

Tegra194 PCIe driver uses custom version number to detect Tegra194 and
Tegra234 IPs. With version detect logic added, version check results
in mismatch warnings.

Use HW version numbers in Tegra194 driver to avoid this kernel warnings.

Fixed version check to enable ecrc for Tegra194.
Existing 490A check is left intact in case any HW relying on existing check.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 345365ea97c7..0dac5d2f5a83 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (dw_pcie_ver_is(pci, 490A))
+	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f4cf1602cc99..5bceadbd2c9f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -34,8 +34,10 @@
 #define DW_PCIE_VER_470A		0x3437302a
 #define DW_PCIE_VER_480A		0x3438302a
 #define DW_PCIE_VER_490A		0x3439302a
+#define DW_PCIE_VER_500A		0x3530302a
 #define DW_PCIE_VER_520A		0x3532302a
 #define DW_PCIE_VER_540A		0x3534302a
+#define DW_PCIE_VER_562A		0x3536322a
 
 #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
 	((_pci)->version _op DW_PCIE_VER_ ## _ver)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index d225165a3aa2..f107f2eb98fd 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -35,8 +35,8 @@
 #include <soc/tegra/bpmp-abi.h>
 #include "../../pci.h"
 
-#define TEGRA194_DWC_IP_VER			0x490A
-#define TEGRA234_DWC_IP_VER			0x562A
+#define TEGRA194_DWC_IP_VER			DW_PCIE_VER_500A
+#define TEGRA234_DWC_IP_VER			DW_PCIE_VER_562A
 
 #define APPL_PINMUX				0x0
 #define APPL_PINMUX_PEX_RST			BIT(0)
-- 
2.34.1

