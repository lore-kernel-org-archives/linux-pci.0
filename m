Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F78192B90;
	Tue, 24 Mar 2026 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315821; cv=fail; b=HY6W6JFx4Hzbfnxb8dGexhpWtTvsPmhgi2pXG25jr7uQZT+/t51ddueRP9TboJnUhu2JS5DlC3w/DQeEACQ4Rq7Ui6FFyoXZa9D+iyuxilEmE2xktP6dFHLhkXAyIP4Tv8QVGQQkZP2+eH07BQxnhhjkvC6C5gn3hpufB3ZnpqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315821; c=relaxed/simple;
	bh=uW0U7sWv4q6D+t7dQEhGQ2iAta3BZxmXjZuKXSqECjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvh87xYl5e6HqJnpXqPkW6PgQz+tWZQRBn83R7r216OLkhFNaX075MwFNgh/X5k5pS1lJsyadIsk8c15nYTx1Wa36/jzNq6IqBQeX7Z8P+pXSNKk1s7ymK7NuIDrADQtS0tWx351ERXvWcv9Ij+jno+7WWq3uWV19KoxNfUE26c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aA4VTyPs; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aA4VTyPs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPGrW2KPHTKk+PcZspDD+rBFbyHIkJxupU0J5Xcu5XBL2QUGSuv+77B/R/M8b62bB6Xy8Dce1YQwz3GodmQ2hRXVQjHGf45nzcMrGnPJHyH21kzK9qS/DD6rqMOiXty48jmQeFEipIXmDaGTgC+BAUBrtShvKPE/3uP7+5BCYbM5z4ppsFWuk4wJ3XgseEELIBjB6rb8HsfGyaM87Q49uPmoIiq6oYUlN1yFthFkV14oou/PoCf2ZM7FPZzQ+Fw6IKOLvC+dmTFAbcGf7desSzIxlvCOZJpTbvVp+oOEukPjAA71hHTGSMplYxiy7Mj2eCwYe+hssZhfCiWRaa54DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRL37xd9wtmmL9LmO6hkhJ+rDg1HbnpPEFTOE5j6uAw=;
 b=PWeSsSZCT1a9QFophjdPEGoKm7z0cKZDExU/ztl3qItO3XyQ0W09TvtutAd6Mfo7yq3OUMc9vAsDGz0wxn+9wePw0K2FYRU1uY6czQjF9JNHJarW6e7/u8EMYxouixamZi6a685OhUUiRGYzG1ix1fz9yDuMbJlQ/QbLI0ry8XfcYd3HNzPDUFqfIkf+0MPdq+5FcxrfJ2SsbZuLKJCpe5YCmPfZeCSBwX6N+9kcS/GctcpMRiVT7BEy6kxbBKlaqV9vBn6PZXYUE5MMhbxpQWQ4EOETvMoF1vuub3/FSG4CjHgh/3vXx+/714akncXGl+utk819XRbowHdtspsP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRL37xd9wtmmL9LmO6hkhJ+rDg1HbnpPEFTOE5j6uAw=;
 b=aA4VTyPs0/XrVH+cu8Z3v2MmeZ5ilxKcFIeL4PEuKib16u3gBS56tZmuG8oIdY7oQpikxNfT8uyodYVioSJeckBcwqeA2eHg7C6Yl/7dcsYTnW+iPVh7g/EYPb0vJ3Nb1aC4kAl/Zf0661oY1FnFAfH9A8A76K/p68oHH7KOaJNU9B5TaaJHWc91l+T0UZDckBaYYFEx6eGGvVJxccEYJPwC3MIy/fe08AkLl7IdaJeeCPfjfO4vHHeAEvZ+MixFN5BtMCNOFmitGqrpB/10MGZh8z6QJii9pgvk6SQp+KkodhcaJNLa6kLrLBltLYyfK9dedCtEa8D0dwWBY+Il7A==
Received: from MN2PR16CA0059.namprd16.prod.outlook.com (2603:10b6:208:234::28)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:30:15 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::f2) by MN2PR16CA0059.outlook.office365.com
 (2603:10b6:208:234::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:30:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:30:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 18:30:03 -0700
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 23 Mar 2026 18:30:02 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <will@kernel.org>, <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
	<ilkka@os.amperecomputing.com>, <jonathan.cameron@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
	<sdonthineni@nvidia.com>, <skelley@nvidia.com>, <mochs@nvidia.com>,
	<nirmoyd@nvidia.com>, <bhelgaas@google.com>, <wangyushan12@huawei.com>,
	<shiju.jose@huawei.com>, <linux-pci@vger.kernel.org>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v3 1/8] perf/arm_cspmu: nvidia: Rename doc to Tegra241
Date: Tue, 24 Mar 2026 01:29:45 +0000
Message-ID: <20260324012952.1923296-2-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324012952.1923296-1-bwicaksono@nvidia.com>
References: <20260324012952.1923296-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: e74d8de0-9e9c-4536-53f3-08de8944e6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wPxXc56bA6/bLFU8G+FT/BpwnmQM8aI5tJpUiRToZeWbcYp5M+luLEQ7oG++SlYJT8Cr+/r7hKWxt1kYxvfYYT3IVAscGaXPkO+p4MRKRtcTgKIrQ2QeCeugC5acJu/5cquTM0dwOzGWqE9ruxyhB9I+ostJoJJkQI1q0YJZxRHQXCXJsarzIm/tX+PNmQrHFJev3VhcdFRffhAD/gJcSpwC+1N6339JxGiM6aQay7wCB4q32ZsnBZH7dFqFY+cCuVNPTgiTfACscLa1/wrwoSS6eQ9GeAYKfHecJSvCRzoXmLisrgx4A8byhkD3E7w78i4ka7eRHjmnnrnrrYthOvjJkUiktvmY7Pz4cyxrcyJEf0UyeUuboIqGnnDWABwB1ltLikRmRqrX9hHxHRV9Zaa9HV+OAV/C9Zo7qy58dK3B2mibv6+X9Za1JaYPRwz/EU2hWwNkSDfd2VvPBEiEOggDl6EAGoei5jRSzvBudM0sHCdZB+ncYesR9/LpPPbzrLp2ROI8Ge0LSP/m793hAmIQEgE9FBYdvr03hzl5uu1PP60ywE6OvQZc0+UbYJVqzhajHDmBanJMKP3U224XnFb8C0yY11IGUixkuV/CA5lSLNVMQcix+Md7f5Izt+dR/BL+CciHv9JpceXwm8lk9ArmrfH23UGMj4suVhHifIvc5XgdS6MaJztPvLPZ6Kv57a/+StIXL/s0YqXtXsDmyqqj2lKYL0gMB4eKQd2Vd9wRL8UK+aH4JEEm8wxMczkSqviBoHSW4eLVuUX6KMniCg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uqStbu8oS9IXF2uYSSsbEZb7CeBrymuw8u9n3dp/79K+zLdSinFLeNe0oiU1HiYj8ZCDeB/5911sPtqYaKbCUOGG9XdazMPAbgu4Gtf0rUPiBOLo1NiMCn664qYlqzDVOb97c+b2QFfoBpi5eGUdmAwN719iSck8WpieVJP3ZNHVvfocb2a9v3vnuFGBrnN3taPDziBeaQWPShtUBvCfoyyyoNEnB6YaBbicKaUCDMGSOYL0PmqrQL0Miga1djAEBsTV51wfEfG8KkU4Ca9yY7fj6EcMAh+Jm+86GbN280zca6ndsm7dHKToNqBt8NfNm7FD0ZxQOnZLSDXjwiACCtkWD42PGTSzOwv5cOUviMuL3XoUpAU+53jmosUjqtueexeW3ZUtmkP6mr2ckr0BFzgCIqY2YI0kQWIArGiI4nnCxTn7Iidxgo7uuN8N8tq7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:30:15.2169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74d8de0-9e9c-4536-53f3-08de8944e6ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316

The documentation in nvidia-pmu.rst contains PMUs specific
to NVIDIA Tegra241 SoC. Rename the file for this specific
SoC to have better distinction with other NVIDIA SoC.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 Documentation/admin-guide/perf/index.rst                  | 2 +-
 .../perf/{nvidia-pmu.rst => nvidia-tegra241-pmu.rst}      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/admin-guide/perf/{nvidia-pmu.rst => nvidia-tegra241-pmu.rst} (98%)

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 47d9a3df6329..c407bb44b08e 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -24,7 +24,7 @@ Performance monitor support
    thunderx2-pmu
    alibaba_pmu
    dwc_pcie_pmu
-   nvidia-pmu
+   nvidia-tegra241-pmu
    meson-ddr-pmu
    cxl
    ampere_cspmu
diff --git a/Documentation/admin-guide/perf/nvidia-pmu.rst b/Documentation/admin-guide/perf/nvidia-tegra241-pmu.rst
similarity index 98%
rename from Documentation/admin-guide/perf/nvidia-pmu.rst
rename to Documentation/admin-guide/perf/nvidia-tegra241-pmu.rst
index f538ef67e0e8..fad5bc4cee6c 100644
--- a/Documentation/admin-guide/perf/nvidia-pmu.rst
+++ b/Documentation/admin-guide/perf/nvidia-tegra241-pmu.rst
@@ -1,8 +1,8 @@
-=========================================================
-NVIDIA Tegra SoC Uncore Performance Monitoring Unit (PMU)
-=========================================================
+============================================================
+NVIDIA Tegra241 SoC Uncore Performance Monitoring Unit (PMU)
+============================================================
 
-The NVIDIA Tegra SoC includes various system PMUs to measure key performance
+The NVIDIA Tegra241 SoC includes various system PMUs to measure key performance
 metrics like memory bandwidth, latency, and utilization:
 
 * Scalable Coherency Fabric (SCF)
-- 
2.43.0

