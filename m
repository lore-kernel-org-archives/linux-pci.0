Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996DC3E0257;
	Fri, 15 May 2026 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828986; cv=fail; b=dasJp8fO49c8feI/AI688vtccW7Yj7t7VETygGvFiUHn5/1Lxh2z4dHdx6EVFdy6SGyFVbWNYYEb7/u1H4MC9T08sNiyMR4u+XYPT5SkBkVL67nYDuEcbbcOqa1Hj9UUQDRDdGx+ti+//3yhWa4sU0xnhBeW45PlE6VXtcGLpJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828986; c=relaxed/simple;
	bh=39yERHy2piAZMWQqp4n5G78w9FNQfZXZFEubiB+bKvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gw1G7c5Se/cUAgdpbnj1i1KTac0/N1bWf8mx5A9/8W4EhgPeqogchHstOV0IM4up5cxW2M6c12sNbTHwrsYbHG6lAQkhk3NgcL+V5f7N4UFjdBywoy+dqqJ4aTUWgjF4MGh9CBq342ILupLaeQ1LFaw0AyBXOtmQEpphPU3q63I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s9QeFk4B; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s9QeFk4B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1Gq/wSsMX7T07S8lSf283fL5j0sa9zm5eBCV0Y7MIKJxBUMzCl2Won8UfVakf5oOJXIp/kG6+9+QaDBu/AuKB4VOXW1uBVpli3AztKYCkbMyVpPqmHQ3l64KrcyeHGzZW9wOmp40HmSUROtKgVeaKnxQzmsq5qNj1UzAhaR6URo6GfRVQEXj1TMUosFiE02B5rzDBJ5bd5dBHDPut+X93sxr2U0r5qYn+UD2oNRcHrQ9KqyTVrkS4mHjRkWcvWUaiGmOenducqGISqnH3Y/DmWTc094SdObnojuf2wnUrBwek4IVaZZxgG5pldkqYGT4zGY9pFyIXim66FCUQQMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcYIAl8I/1iR5yjAzZBsJzy2RNe0cvxv915aFRG7yJw=;
 b=D3kQ+aKZzFMyAy4uJK3YlmOa+qL4s/QeUGkeKAHMteo3mApXB0s+EWnxo3lWoQVQw7ZKGAwVP8UJl0NG01ZdKsBtvO/T22ceoEWHYcQ7zOWg7chpOk0qi9Dw77xVtq4weRpqvwBiY2MuTHnoWtBaMxP01CSgndogvUUvdYFySMD2qLa9p6yXSfKIGD5xolG3AgBjxnumcBfSNkBjdVjpPs70xULl/RPkyQuHVjfiYa/pcxn/W0QJaAJBd1RTjyHcoA0fDr+md1LhHLzNL9GpCdrE5hSHZCGiAVv9rqL6V1/Ef+kAIrT0CkB9Uam54u08MaAAazF+k50T07smC0lLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcYIAl8I/1iR5yjAzZBsJzy2RNe0cvxv915aFRG7yJw=;
 b=s9QeFk4BKgYdfhOD4SVDJ5HdIgLj6e0xnE0jnkq/cU+28U1a4XP6+DdvO+wj1gjsxC+tgk6lotmO9ajuegvCFxnY1g2T/p6p87F5w8zO9r4aXUu38KoM5vvyIRyIM+asmWI/ECDoSQMXLGcyQ7v+LuS4RTay2ubxJn2GsNqNRtyRAyyF2EstsoP3F4rEG0+tMuS6NKIq5ajNaI2/NOm66ShpVYYy6fNpZHsl8L8ed3zVj8BWaj7ACE0d0AVu6R98bE6fv717ut+/gUMWyF/SDF4ti58VYBszjLbAooekKLBCrPpiWUW0jWALWb9C1CtmEhVY92vZw9rWSDZwX7DaWw==
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Fri, 15 May
 2026 07:09:40 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::a6) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.20 via Frontend Transport; Fri,
 15 May 2026 07:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 07:09:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 00:08:31 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 15 May 2026 00:08:24 -0700
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
Subject: [PATCH v3 2/2] arm64: tegra: fix aspm-l1-entry-delay-ns L1 latency cells
Date: Fri, 15 May 2026 12:37:53 +0530
Message-ID: <20260515070753.3852840-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515070753.3852840-1-mmaddireddy@nvidia.com>
References: <20260515070753.3852840-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 293468a8-de00-476c-0fb3-08deb250ee45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|921020|22082099003|56012099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mQZ84L8n6qzX9dQeSxXJf68bEgTsBeiRDprSL8zzeR9oeJ6oYdZ6kxI9yZIi0nuqf2YUwBf4zwRzOyQqmKDuuflKU/zTgWyp6usqDBp3O5QrMTjrbAdh5mk4So6nx9PPGyOZAKC3jzPmyY/pWh+monhq0UStGrXBLjhVqosdM4KeOu+ff+I430domplBAxew/HWDrqAvwYxbK2NRQJNt5fpyohgZrNBybe/cHWiUq5XgYs2u0tFsH7dVGxHXQ9vqXDc1LGFMuU43QkC4vQ4MZ8ZYurfeUa5W3Mm8qPPb8jZWjaric3+gaZHQY7rj8eMoEdCBj+hMH3tr6lEnpr6zbii4N2gNxnzcGRHXB1CVY239Zj7F4GUgtt9F+TeqpXLXR+mHxKYTNc/5TGIlxJjeTc+O7AbADWU0VSxzJarYq9N+64dFzMTk0v6bchylwWXlEI7JK3K9fF9Ofvlz0sUQfPBX+RNfSOmyhgCLgFmbb1ZQfId9RNAf6vM3tsqkLEO3cEA9EhwRqQxDPFzzKC/oag7reFqwIUi7Og17yNs2YryJNt1/zRW381eTsW1DAGvrnaI/itKZrMxebg+aHjVt6yUUod6MIXiNKEK+5Tizzsa7esHNI8uPNmwcY7dbqzI8v1MJw1UDub3PZ0Df95+gAQi9RGrmTUzYlE4TnLf8mnBwi+oljTgZn5F5Q3Ntadbeja0LnZq/xlKu3Z9V+cbSVi43yUAl88GZSqSMNkIBcj03c7xTFd5DjsV64DQNqOgKV7iasBcdVbKEGMzLCK4QEg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(921020)(22082099003)(56012099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uTlaA/8293qCHfmH31lgZkNlb+G7wIluLbLqUloIojCKbQqUxhmy4PYedAnDCe3f54ycbrHCwlJRmnbIk3DCBHEtRXGKBEzSP2TFrV5G+pc5NyqJ/QLPKZbpS9+R+vnB/Bw+WK4bxaYuGX9xzdZw6nCaZJOJ9ilylF/vvuh5nR+wwSsmK3pfQtqSVq0NiwX93N+0CHaWpw3j3zMatELz4ggZHZq9AQDAY6kcnLpxPafMHGpyg0zaIWuIeS8Lqe/TEJ5W764vXkWDur69LzQyOdDFdOUIMHUqsfKkScWf5+LpTvK1TvZHNGbYCNdwWXtgdu8v/ujlWBgPzjs6mdT6g63gtsmGF9Xsg4DRjBK2tUf/+FYL/mYl0OQ28p2kW5qxIsgL9/hryvsrrEVD4dYXxjcj1VT0PS1g4Xx+zp9l8tEtQS1b5/GK/crUa5szZYxU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 07:09:39.6250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 293468a8-de00-476c-0fb3-08deb250ee45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

The Tegra194 PCIe driver converts aspm-l1-entry-delay-ns to whole ms
with ceiling division, then derives the Synopsys DesignWare PORT_AFR L1
entrance latency encoding as min(order_base_2(us), 7).

The nanosecond values from the Fixes tag below round up to 4, 8, and 16 us,
selecting PORT_AFR L1 entrance latency codes 2, 3, and 4 respectively.
Raise the programmed latency so the PORT_AFR codes are 3 / 4 / 5
(8 / 16 / 32 us buckets) instead of 2 / 3 / 4 (4 / 8 / 16 us).

- tegra194.dtsi: 4000 -> 8000 ns (all listed controllers)
- tegra234.dtsi: 8000 -> 16000 ns (Root Port), 16000 -> 32000 ns (Endpoint)

Fixes: d60ed99f1c9e ("arm64: tegra: Add aspm-l1-entry-delay-ns to PCIe nodes")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 18 ++++++-------
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 32 ++++++++++++------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 1d659454a6f9..7bbf0e892724 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2382,7 +2382,7 @@ pcie@14100000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2435,7 +2435,7 @@ pcie@14120000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2488,7 +2488,7 @@ pcie@14140000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2541,7 +2541,7 @@ pcie@14160000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2587,7 +2587,7 @@ pcie-ep@14160000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_PCIE4R &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_PCIE4W &emc>;
@@ -2634,7 +2634,7 @@ pcie@14180000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2680,7 +2680,7 @@ pcie-ep@14180000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_PCIE0R &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_PCIE0W &emc>;
@@ -2730,7 +2730,7 @@ pcie@141a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2779,7 +2779,7 @@ pcie-ep@141a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <4000>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_PCIE5R &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_PCIE5W &emc>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 75bb9a0ad027..8e0c51e496e2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -4532,7 +4532,7 @@ pcie@140a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4587,7 +4587,7 @@ pcie@140c0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4642,7 +4642,7 @@ pcie@140e0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4689,7 +4689,7 @@ pcie-ep@140e0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <16000>;
+			aspm-l1-entry-delay-ns = <32000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE10AR &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_PCIE10AW &emc>;
@@ -4738,7 +4738,7 @@ pcie@14100000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4793,7 +4793,7 @@ pcie@14120000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4848,7 +4848,7 @@ pcie@14140000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4903,7 +4903,7 @@ pcie@14160000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4945,7 +4945,7 @@ pcie-ep@14160000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <16000>;
+			aspm-l1-entry-delay-ns = <32000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE4R &emc>,
 				      <&mc TEGRA234_MEMORY_CLIENT_PCIE4W &emc>;
@@ -4992,7 +4992,7 @@ pcie@14180000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -5047,7 +5047,7 @@ pcie@141a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -5094,7 +5094,7 @@ pcie-ep@141a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <16000>;
+			aspm-l1-entry-delay-ns = <32000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE5R &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_PCIE5W &emc>;
@@ -5143,7 +5143,7 @@ pcie@141c0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -5190,7 +5190,7 @@ pcie-ep@141c0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <16000>;
+			aspm-l1-entry-delay-ns = <32000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE6AR &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_PCIE6AW &emc>;
@@ -5239,7 +5239,7 @@ pcie@141e0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <8000>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -5286,7 +5286,7 @@ pcie-ep@141e0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
-			aspm-l1-entry-delay-ns = <16000>;
+			aspm-l1-entry-delay-ns = <32000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE7AR &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_PCIE7AW &emc>;
-- 
2.34.1

