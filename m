Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E93B9601;
	Tue, 24 Mar 2026 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379509; cv=fail; b=A83msvzHCJiZxIsK9iXB+E9PAomwEarkmbhaayv6bscDktQX81MJedlPrQEPPdP2OlFOqaIravZYcE7Tw4YuSnPxtJk6HPNxBztTz2wJHSfLHmP6j9tdwwJAKOmH8wpWYAE60njpAVdatUGm3qn6R+UX4fZjYQcWnDbFGapzwaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379509; c=relaxed/simple;
	bh=GaOaqAXw4IZgkUIGCS2PGJwQTAy0vPcEswZA1EF/qrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4oqzmbFTvRN6l/xr6YorBz8nCn75cvg0Z0L6QPXiouDgcmDR4Tg+er4pdik8/zHSBu5gxBLkoaWSaOyVixN4dFCY4ENfrTtCr3WIovvuXcZLCHJzEzNOmYiwUxEdhKNzh7ng+9qOVJpLyBmm0Osu1/ai1dhWEM4K7VLIqRRDEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D4cGR5Ce; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D4cGR5Ce"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeAecgiqkS24fFXktprWMFBghQf9UATSaw6k9pti8A0jLa1Ymy527TP4r3T1HXA/Suh6ckUAGqtHrpLNl+6UbyoaQUjnu+kS2pDsRvw4PDgC+TXn/OCfkC+xnvUNuualQAEAfMUxsr0pc1HDDwRvGETbkm8Y/EHafoTetu0EANl6qEfEnCmYFPRp3tP/CZbMRx3GdhdWGqD495aVmZJpNAtuNOcrp8e21CZwZ+9AUcvlzPYiDbSZBhF9f83EzBiymBsYX9g+BgiEEhr+Cdb4XIEnIbkhDDJP2PMXoafbyMn6IQh/hPLSAhuNzSG/lYkrHhn8QvtHqb7SKa8SGfub8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpjsvolmyWEs46cOhEsmtpXhxkCNnGE4Li5H2MW965k=;
 b=LAU1ixr0/kC4Ks2DrZEolJTzx5CcDkjf94kIdSy7z37/DkPOImQlOjET1GJiRtYoNH6Iw4+M75Uer8AfqYAroaXwzu2352sn3So+I0u3Xo/vWF5kh6ljr6IrZK2yMYwLpj5Q5sMeOXWK/82XlnCLh7kWmVyBDAE5vCrMGV9hPyJjnLHEeuJDYOjM2zZFiAzDRefelKaxxRyI6ZvNTyiyGlFQD8/M840urdHIPsTHGzfZWgQx2amjhQJDt+EqV6VSzS/MlECxAhKihSu9kGWSITLnLLvrSNArMYiCS40hVpA/y3ib6gRdDv20AEn4k43VENTz2YFesD0e66pz8D91rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpjsvolmyWEs46cOhEsmtpXhxkCNnGE4Li5H2MW965k=;
 b=D4cGR5Cedu2MPtNdSlVliTgivwIKAVUCKPXhoOJKZhSSfV6AlTGHIooVZXRI+Sbf/seMCT/12kb61Wvg+XADWKlPvkpx48Q1H8hJXD3MTzyIJm1EmLPczEoZKPInkhQKd9TwseDvk2Deb/4ke9jqRGXRYdyRSTUl0FjKxsWgeT1UxNRxa2yAxCLi3xxUJjNjW+IFwn/kkotCwbjl3yoW6kRdOrWhxCb6NB1uVHlEzWnG/dqVyMfOv47GaxVqmX4hc2dCDNNURrSoFC0l/Q/SyMXJCEojCCeudGxbe9JbBePv/01HCvA9ONP6N5/kTWEVQhhQk/dNEQJ9R/KW1OsMUw==
Received: from CH2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:52::16)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:11:34 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::31) by CH2PR04CA0006.outlook.office365.com
 (2603:10b6:610:52::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:11:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:11:16 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:11:08 -0700
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
Subject: [PATCH v8 8/9] arm64: tegra: Add aspm-l1-entry-delay-ns to PCIe nodes
Date: Wed, 25 Mar 2026 00:39:59 +0530
Message-ID: <20260324191000.1095768-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c5cf6a-4e89-419a-9219-08de89d92a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aKuoEQRYFzf90a/QV+G6qM5BnK9gFWOm0xgM6mmLXrK3vmijR9lpaiSXFAbVUinJNuIJx+6jwvDVQyNfmA/Tj9CGEMqzrUcuM4qupyRFZQl83TenmvVEMkWTrKSl8GQpY7WDUS/JCwnvvrEeMFsN19GDmS6nsjSTGeTHqT4AVvscQE6A8DOLWVyc2kywLrPlsYVhahQq6QorQ+Qh3TnY53Gp+xuFa3AsfxcGr8BQ3CbObS0yekwgLQ5zq2z6HU1H1GBS5CVngEFpCZSth1FWf9dcgysqHNktDVHXrU2Z1eOcMmhZL7qf5cZu5rjCeNHS1y9PWq2RvjoYCwM/JHymCZqw/W6OJiwIbGMa4Eefe0E2d/qE7XO7yomdPLVzt4lnf3rWeO35t6RMf1XUpJBDxvrShpBODI67CB5YeBtQGlH5ujAYSf7gQnqRIxaBoPUfv6dYG736IC1mjzIsGsP9iGhsWRrdI9HhZixaA56VqsQdqRQGJ6JNZ6lM0MYayiBI90SZ3BdveDS/KOfk6nIy1OruSnAZ/Id0xclMxD0/cFQHbi4Q6Rp6z/OejyfCGoDweNu+I0stIwznM9EKbSrh00eHYLLYXA+EZTAobq4JeQAflEodZKE6nlucqca8z0qwn61u78AxwNDXNJNuurzbHLg8COnAVecxEhgJP8XxLdyYyN4k/jaxcbEV6kWnKE0uZadgDL7uIx6O7v4dx1NVmn/wByFRDoa0yYDeOkt3Z13Gn5gUa4PKxtW8GQJRi0TfEUi9/dq7UWn6hJeyh+pmhIhSqa7HrRRC0rBFnWyOlzngNUZSNHhH+jGFnxZJmazn
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	143gh0O70qk27pG4RTDeZquh7tHBaJ8EV8jrhnvKu8uzhoz4TFTlOB/y+ddoGZeJq9gO3MLFpx/4Eid7E6R9HUlMJFpNJbRFeFKRq5lQTnfq02zJpsy/BeR0Eq/uxqdCmmxJ7Q9dWV3xVyhy55MIz7O4sY1aZAnL+pJHJofAJSb2+ZOiTe23cqaMSw9xKD3RoszdpFVinpObPHrCz3xlUK05ZM4MwbtkmUBGvvS/SInysLhFzN8110/KMyQEYK9ukjhmM5eAcyljHng44r9k5DGAeg86IiC/taC7gzU2MGs8EGnhd1Oy/LnOh+OUR4+dz6rZsDwPkNv5bj6VkITjgURFmTNdTcILFg9u86d1EjKQI5XXT7/XoCZm+QG/xE0eiwmnYOdyKtu4CROINDbJWqOWmbVgLZKQnk6/DGJ1Wm8GmOUeWbQR1YHbx0m1Aqny
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:11:34.2771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c5cf6a-4e89-419a-9219-08de89d92a54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

Add the aspm-l1-entry-delay-ns device tree property to all PCIe Root Port
and PCIe Endpoint nodes in tegra194.dtsi and tegra234.dtsi so that ASPM L1
entrance latency is configured from device tree.

- Tegra194: 4000 ns (4 us) for both Root Port and Endpoint.
- Tegra234: 8000 ns (8 us) for Root Port, 16000 ns (16 us) for Endpoint.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V8: New patch

 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  9 +++++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 849694f751d9..1d659454a6f9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2382,6 +2382,7 @@ pcie@14100000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2434,6 +2435,7 @@ pcie@14120000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2486,6 +2488,7 @@ pcie@14140000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2538,6 +2541,7 @@ pcie@14160000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2583,6 +2587,7 @@ pcie-ep@14160000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_PCIE4R &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_PCIE4W &emc>;
@@ -2629,6 +2634,7 @@ pcie@14180000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2674,6 +2680,7 @@ pcie-ep@14180000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_PCIE0R &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_PCIE0W &emc>;
@@ -2723,6 +2730,7 @@ pcie@141a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -2771,6 +2779,7 @@ pcie-ep@141a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <4000>;
 
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_PCIE5R &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_PCIE5W &emc>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 850c473235e3..850c1a645d71 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -4532,6 +4532,7 @@ pcie@140a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4586,6 +4587,7 @@ pcie@140c0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4640,6 +4642,7 @@ pcie@140e0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4686,6 +4689,7 @@ pcie-ep@140e0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE10AR &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_PCIE10AW &emc>;
@@ -4734,6 +4738,7 @@ pcie@14100000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4788,6 +4793,7 @@ pcie@14120000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4842,6 +4848,7 @@ pcie@14140000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4896,6 +4903,7 @@ pcie@14160000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -4937,6 +4945,7 @@ pcie-ep@14160000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE4R &emc>,
 				      <&mc TEGRA234_MEMORY_CLIENT_PCIE4W &emc>;
@@ -4983,6 +4992,7 @@ pcie@14180000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -5037,6 +5047,7 @@ pcie@141a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -5083,6 +5094,7 @@ pcie-ep@141a0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE5R &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_PCIE5W &emc>;
@@ -5131,6 +5143,7 @@ pcie@141c0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -5177,6 +5190,7 @@ pcie-ep@141c0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE6AR &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_PCIE6AW &emc>;
@@ -5225,6 +5239,7 @@ pcie@141e0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <8000>;
 
 			bus-range = <0x0 0xff>;
 
@@ -5271,6 +5286,7 @@ pcie-ep@141e0000 {
 			nvidia,aspm-cmrt-us = <60>;
 			nvidia,aspm-pwr-on-t-us = <20>;
 			nvidia,aspm-l0s-entrance-latency-us = <3>;
+			aspm-l1-entry-delay-ns = <16000>;
 
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE7AR &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_PCIE7AW &emc>;
-- 
2.34.1

