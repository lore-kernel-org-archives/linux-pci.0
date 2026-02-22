Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7F35B65D;
	Sun, 22 Feb 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771788960; cv=fail; b=e3GGt8FtqpAid+XC2NsjION83FiSVRqwDelmuKYOgX++DFeArb4ouM2Sjl4BwrMftGamKIPqX9SKz/uP/aNO6hc6ydg87knzH+HgqhQmwTFhzcwV7HY2Xo8X3MdsVqfr08Tdm66zz4SiS++8+kJhJ0tbQEqTMLjqotd2FO8tY+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771788960; c=relaxed/simple;
	bh=Ceh04XzkT/9KtM0cCw+EYX+CFObGQtmf1i2CHFASzXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6N0pNKyrqwm1rmbyEbwa9MnGvNzI+DDJoYe1WtyJd1oW5bjWIEjIvyw5/I6dToq829UPQmOy3Ij4FUI6upUrt51GPsEvUJ94bdppHoM/kMGHVCccX53uZWs2jFlx4mqeOOIY0YckrMN3Y2JGyOF58moL8E7OKhbJl4FiBpQMWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFxf6RV8; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFxf6RV8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwHqxMTt88szRc/Htm1ivtRwIYhE0XvWLNZumlo7XwDdi5yRed61VkzzEKXGmiJqVfF81Sxt8LWVXpe9W+eIWjbMNefzBvxeGYSStBoj9qYP1Zs2cxOYwep0XHtesin4fHEMq76B1FH7fPIqLQ9OPcLi0kegvqEGN7rDkp3WqzW5H6hxm9J4LzvzOR9M86b6cbb3DZYBFBER7LrL0hv7OkeqV7wAZXd/HaabWaQMUuksbhLWTRbTpBUUSOjL5pIGTMvbFt0cSUaiOSUiky/gn2f5pYks60fn0GmfXifv6dBHGm7NXYxD5t29W9SVn8ZXP2K3l/7ZR1pj3p8BhCVUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wCN3rP7AlgdtAsPA1pXFU3kvcZhzjlLR9VwFfEAYNU=;
 b=tLMkS9rkImZ3oAnls8uUO3CsLtSK3kupmwqTctyTS0D4WM8Z3Y3kdKoSNUGs2rVeZvn7Xp9v0FwJCbIU+UWFa5AKKigFVMR+NZR5D/MiE0HJ4f8ni9ViPe22N1EiEsoPRYimVSl8ohxf+ILcl+cfgyKWX2DkWEIthAJUhIlgaMDlY11uM52XCb8QjHZTrBHFp7gHeu69sNNETeDV1lxkjJmm1/QoFd3X8psI+ArHrIW5HdEB86Qwpb/xMDYEwwgg1KEn889zl8ih0qhDbpe+tKQUrWD/B+1SjNnqUiHIsKA/7K+e2dZn8p/CeMMxzkRqauM0RI4aZAAPehUopt4m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wCN3rP7AlgdtAsPA1pXFU3kvcZhzjlLR9VwFfEAYNU=;
 b=hFxf6RV8NjzJbMjFexfwEJktsUFNkC+gGObsUUUTgzYWQFxnV9/cQ3mp81/HDlWSaY/akVNPxOfmgwt6gXE6fAHrYYycXFJ99+JuimxAOkpTtchsfmbQCiBwSRHJ3KIXAyWadjtign7BlcW5lwMdskCtZ/a94s4RDwBTgore6n74y/eXWKhVpjgfePqA1v62saMZGCWxCrBOYiAXtTzXjmQpgIt4Imu0HkbIr9bGDByJQftUKlJlHIJPH3oDITb29JC4XjGieR/SLWLaypWT2TCCmXqEas+IJCVkuZPv8TOmSzhWYqIGfbjkFdQZlPU58pneOL9nDc+9eBsKyssgBA==
Received: from BYAPR07CA0053.namprd07.prod.outlook.com (2603:10b6:a03:60::30)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Sun, 22 Feb
 2026 19:35:55 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::d1) by BYAPR07CA0053.outlook.office365.com
 (2603:10b6:a03:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Sun,
 22 Feb 2026 19:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 19:35:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 11:35:51 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 22 Feb 2026 11:35:45 -0800
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
Subject: [PATCH 4/4] misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table entries
Date: Mon, 23 Feb 2026 01:04:56 +0530
Message-ID: <20260222193456.2460963-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbdd384-48ee-43fa-4072-08de724998cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9LyKBJbVhN1lT8UeRm8qW/PBVIeZrYz9DSd3uVy5gdMv1m8yjCG045dCNBsI?=
 =?us-ascii?Q?rFqhfswMdEEO1NJcKkU6pJbFzssASyzbl9hoLfIvJYaNSbhmWnF6PivnNRQi?=
 =?us-ascii?Q?8aC9dh+hB0SmP+VwuCaFPWiRnnF4LLAmxonAy3W7zinCGCUwZRx+NulF/dZa?=
 =?us-ascii?Q?ePi64ju7tJy0KDQP+kxnDVJcEBtzHl2PXYmPjlzeomKcFy9pyoxH82QV0lTa?=
 =?us-ascii?Q?vBXFczf22XKoc50lIT4vaJJyh/6FGMynbjdsPhYs2J/2O5FxAY3jZ5OafuNc?=
 =?us-ascii?Q?IHv0ZApwbrjtU+qLHBSl4f6dHB/WXURIN3LUcafR8H3uas/YOuIw+ISF5GhW?=
 =?us-ascii?Q?EfFns2mG66VLBnvsFU6kli305vYKf5vn6F6eJAEHbv4XUKMMORYFbPY7MB7X?=
 =?us-ascii?Q?lyUzrlMRc79KhEFEsh6W2llLKHGvS/OjvpYrwu/gCajiaGDf+55sPztCHNmN?=
 =?us-ascii?Q?wvDz/U9ftk3/uiQVx8Pep88dKZ/diieSElX2jB74JVpjQZGF4OnRxGecibh8?=
 =?us-ascii?Q?WYLjvei/1ilIn+37cRcKiDe/eNMrHA5MYduFsH9dCAAKn7USN+RSz48szDM3?=
 =?us-ascii?Q?WQc4KRrS0XRk3CesrY9IWzuJiTjr3jq7zE56tEkxETJM0NwQhwD7DCZfjprm?=
 =?us-ascii?Q?Ui7RDf3TpAIeGLCw5W6X9b9J4+adGgLnRdLLxvOSIbsE+Fjxjof2SG5u47lS?=
 =?us-ascii?Q?DdyKRk6oi84rKxN4KeJQtd3AkTwvZ2IY5QfOZRcoE0pwxxSSM2w9w+WIZtr4?=
 =?us-ascii?Q?hORWjHdYujSBTEH7LekLeKPLv82US1f7dy2zb2lLqf/kRWw+WrMWaJTGOEST?=
 =?us-ascii?Q?gUYgCuNJdp8QJ9H0QzQp8xt9XwN7SC+Cmcjs09qVYpe7FG/YpISxeCE7SH3M?=
 =?us-ascii?Q?tIHOXO2nS2E9AOQpKINXR1kBR0XarFD72izdeO93Zd6+CCMXzwuFpusF4+V2?=
 =?us-ascii?Q?ZA5aJQsDaB/RS9XGls+5MF6Tr/pxselm+b1NyTqJeX+yzSfI42LzEun2Zbxm?=
 =?us-ascii?Q?+TguZuQWWdbplPu2+WV7Y1Iqgr6qAJBxIypnV087Akn0bNH7hzdS1pftgCYx?=
 =?us-ascii?Q?4YOMK4XKJGyzIGbkUAtExW8TY/EVm4ZRMcBsI42FGMeGh9etApqWnqB3FOyl?=
 =?us-ascii?Q?UIjlMCGENcrTOSTQueJz67dYHd0h7RQAQi7spdOZpvzLC+PgOyvr3XDOtFch?=
 =?us-ascii?Q?+ZWnBfikA36xSv2nHKu4oSTJ/MmOJPSMqmhtPAJgYd8iU3/LvI0Fplmg29y4?=
 =?us-ascii?Q?D85YZukm08mn6G+adUE41ykvZ+ONTPljDTnSg+Di0mwh1wcH4hyZOhHPfKRo?=
 =?us-ascii?Q?PM0Q/pKUMrqs5eNaaJIzvhqd6OPNiBjMRcQKpPy0a6BGqrk9YBsrEHFAfMlU?=
 =?us-ascii?Q?9GdKyZoHhUEaXgPK54JWLF4bySMkN87NRucamT8arS8MsSzn7loL+ayY+3dJ?=
 =?us-ascii?Q?IqSanVMDwUHp5YvXRXuDUl4jhNcFb61kRaxZK2uqcRszNER/gWgTnFdJmvps?=
 =?us-ascii?Q?Tr4OcVV24hIV43FIW+UA3ZG73mHg6w1MguPCY1H6V9XSsnvy20/6ml1VPHf8?=
 =?us-ascii?Q?OvzLAjXXBUaWNGmx2iau1Xzi30LksDBP7Kvmidc5isBgMckHFR8ltMPAPJGf?=
 =?us-ascii?Q?dkwBhzgAfepsP+uXP8P9Xsj1gpL+yWiWaQaVysZxGGn+njreuyWbvMdGMcPA?=
 =?us-ascii?Q?4Wk5RNDNnV4iwWDHebpfoJE/w7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5qPbmR1zz+lRhml0fr2Nx6ZhIq0i4hYSBXu6mn4hmDbWsafoXUBbUFZpUYecXBq2ZlW9O1KwtxzLj/ECRpmJB5bXPlkEMZdVHnAawmxlmmIdq55VjibrNcC4q/5P1AQ4IpHTF4ie2ndt6KsXwZQyiAIqWJGzrszUZgllGE8jEsGebI56utRfyAcy15nwRl2vMTL6RDW2wHC0LyA8+9abdg8rl2XXXLUYcl4NHBSsKG4KsEVoUBG9VGmOgWRJI4HHvjKSCeVH5HcdR+KXb4QYM7q2b7KgcjMuED9bswqIWYbII+CHTs9F1uID/xheCt/qdSER0ZrOhpmdq0NCTuw3tpXEbkPQsuryZm1x9mjM99db0SRJF+1StkJS7R6ZPZV2EYybOcW/nGLbN0R1wevW5Pspw14+pzpeSe89GDEwqKPjqGzpvMeQsjZtLL/+ozhY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 19:35:55.3880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbdd384-48ee-43fa-4072-08de724998cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F

Add PCI device IDs and test data for Tegra194 (0x1ad4) and Tegra234
(0x229b) endpoints so pci_endpoint_test can bind and run on these
controllers (64K BAR alignment).

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/misc/pci_endpoint_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index f166b6fea698..43545dbad26f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -106,6 +106,9 @@
 
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
+#define PCI_DEVICE_ID_NVIDIA_TEGRA194_EP	0x1ad4
+#define PCI_DEVICE_ID_NVIDIA_TEGRA234_EP	0x229b
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -1202,6 +1205,10 @@ static const struct pci_endpoint_test_data rk3588_data = {
 	.alignment = SZ_64K,
 };
 
+static const struct pci_endpoint_test_data tegra_ep_data = {
+	.alignment = SZ_64K,
+};
+
 /*
  * If the controller's Vendor/Device ID are programmable, you may be able to
  * use one of the existing entries for testing instead of adding a new one.
@@ -1246,6 +1253,12 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
 	  .driver_data = (kernel_ulong_t)&rk3588_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA194_EP),
+	  .driver_data = (kernel_ulong_t)&tegra_ep_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TEGRA234_EP),
+	  .driver_data = (kernel_ulong_t)&tegra_ep_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.34.1

