Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9663446AF;
	Fri,  6 Mar 2026 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789060; cv=fail; b=U97N4BClkSdO4nuAja85eRwDFrewo041ni1VsOxrwB52Jgv9YDF55pW6DCHTBg1Hja0BOHW3cnPNPuECqBAkrxhfW2v1SHtLSCU2xE4TN2u5TClrA8T1ZYI0VnY9OuFR3umk7/+4Z2+c8n4H0Vr2yaiB6TyM1T8+ivQskm0w/WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789060; c=relaxed/simple;
	bh=kred2tCpyX/GPN5wPTs84TtDtdI5YdqKejzLA7S53zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeLoYSTFT1MSlXmYwdvRa+56HXkYp+3+VDdmZbRq69jgANQjGA39pscm4CzOzbbPLQ79PP8Fmky4r/Mw/zHmW3loFCvuru1gfr+RAao3MFG9XN9kHRTUHD9OGzXZ9L1oFNPIfeYb5wrrnQQ4yd+sTSWaQv8VuBcISinoft6PSPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BC9v6ec9; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BC9v6ec9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfkFr15sfEaxAKEypDQK79suWdzN9/1F4lfqLJFcOAFV6jE/m2ggzyodNaK3sbIt/yk3BeEY3mqX/5cdEPdjkojzK9UcRm+UoflA+Ko4lbRGO4+7if/s7qt+2ER9ga/Nx3WolyZWjwFxievcLEZmxip1LehzJ3ujXPOSCgTPPBErce2NpdueCNjH2B9K3YY7TL98YRS19aQJbUzjZEUPsrXD1znM4vEWVyjh7mrRcDPf4prsG5S/9Av07ioEJ4GnASBaAp0ujIXyiRMQNqci1aFrK24sRcICTSR3xWKyzUx5JuWFaizG4++NbsKpzcJ3emmO9y7nXc33Wjkx2W5PCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFGK5Axy4umzAq31y/MH++kUdSlwC4sL/eJPrOSdbJo=;
 b=Iu1sRAc/WGytIuvDyqxBMqOorUgnb86Fz2KaaUtYkKwftVCiI9m5714F4RaFsnzY674njuMnRYgFrrPmlMo3ONPQkbin8+lxR+KJtBiYYBgI7LWvoXxuEeT+hDPGk6y7JBRQM58hdTbH52O+zQ8V70E1bkMdZMWkub17Lr0F8fhBjj2wKvyU96PtCPMBYBY2uIIFCjmIIzuMnk11B1abF5Lr7s7DxYvog6Ctnj6MF3BZs5mwQNsC3hf/UckzJ2a4ozd9x7zigTZkPn+iQIXhdgGFP0+dIVzwimsnStyKaLiZjmQKPHYS3i9qtUiWzY2eJCj3SFWdskxRLTj883PyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFGK5Axy4umzAq31y/MH++kUdSlwC4sL/eJPrOSdbJo=;
 b=BC9v6ec9yE6HK5f7n1iDLjRppdezeq5qldGndmltlCjwo794pupyMPkQ6dLwpCk+s68K50DSyzY0PZGBbYnhE+U09OK0DdB4TIOUeLaFHTZ/qSNCsf+IQksGsderFlL1hCjRaSJxzufNGq6F4gFaxYZgB1xeUHxf5Jld0x76owfdeP22Mjkz4KDJrPi8kgnQfAKZt+Op6d+sUne0zkgkq4/0AKnR2IutsgN/mIZk4PWyX96426XcgO8TBs7KxuCbEAvXU0+05ov996FpTN3w48m9oASWyrSaueEFCIR2npXv3Xl2tDbq8pFezpvsbEKYzxxJXsfQg/0llBrYFb7Oaw==
Received: from SA1PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:2ce::21)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:24:14 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::92) by SA1PR04CA0016.outlook.office365.com
 (2603:10b6:806:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 09:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:24:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:41 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:40 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 6 Mar 2026 01:23:39 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH v5 1/7] PCI: Add CXL DVSEC reset and capability register definitions
Date: Fri, 6 Mar 2026 09:23:16 +0000
Message-ID: <20260306092322.148765-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092322.148765-1-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: d71329f0-bd9a-48d9-1054-08de7b622202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	glN1ZefX/slKUZi/oUAxBpawJpme2FtCAXrwUoSI0p6ash7wPu7bMRyo/cBim9h4LAQhAzICVRIqlSrKosZUOhZLtKffneNZTH7evSuRH1gjGkRNip4bsqOMmkqlxilQrBMmD14mqJ/+IH1DuyKFhXVpUCCs7gI71tfhovoRnbfIJPgL+0nBbFBvdTfKPEPndALi+iZnLEINCJF38BRKVv3ntwWMnCvDlm4jyRiENPKdDwBZp614hvfQZ5at1iLP1dOxld/e8jwUamr8yuGQeuvPulgwZroHIWuog1OjKhX21ef9HpiU6wrXMpe9OfjExGTfTKNt509iMCeaujCwiCN7C4oE6lRbK0XZYkCuQAXWNwO1LtK6xEbaXFcF4x1r5gSfsT+6GX+cZarAh9rwXnOtBi1WGkZsoWm56sSBzhMjA/Brw0q5LH0XxmoK614pawcKEbOc2F5+VWi6wJEn6sUNC4KGsBkG6cOBRv3fqzQg3OXL8j9KIyAbIRqCze1Kigd/9oEPPHrG0nEZ9JK7KOdFTHtygB1Rlk32n68lSFM0FtLD4S3eH+Mti5pAfXlnUVLY0nCIxWT/dBNh6murSYNMZVOV6/0U3bodMLcixV0R/xfZwVC8OREH8hua0uyVF/Uxe3M7GnDhKuv7XAifb/sWvUxfPp6GJvW+hzVWyFKZo8Amwjm7kbHuJWNG3aqsvJleKxKIz7PhIOTIbTpUZlBa9Fo8doMvuUMF0kI7O9GB+7ZWnaVru7v1RLpIdoh7i595KXeSwHhNbN6TuoDGug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lDqsv8mMcSdKzvJlVpdXU4OBQMit3uGet0qBJ/xrx05w/yF1nT1wLTLxyyx+c9X6WQUxTiRxNbMKlcUAyTi/HUTQUiye7XoTGzKBQZNk+KMEbFPsg30gpOQoGw1ya9cVk8cPg4NeE+GaZg1BVOWCJJq1d5uaBWoJXfmZt6bURq3bH4+RUFt2KIgxQIbtWzwY27zVyvEphOhNyPMejq7qhjVJ1tVeV+HfPbA3zmFCvbbieN6VrmbiW94zGe9nGqjF2ILKb7EZe498g/O//rVPEMM15iSOuA0P/7un3IKtNRJxT73L+7lejmFnYUunCJgN0bs5Yrld1iC8jz4+bySlulVwkLFS+jE7RosUjTHzsS5LqMrLxzxHDZRMDzPtAvjz1+WULc1PNfl6FoBbVoi/vMVxyPSCXMX73yzk+D/HrQpz4GIUYXXNGR/+KSqGlprR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:24:13.0921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71329f0-bd9a-48d9-1054-08de7b622202
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

From: Srirangan Madhavan <smadhavan@nvidia.com>

Add CXL DVSEC register definitions needed for CXL device reset per
CXL r3.2 section 8.1.3.1:
- Capability bits: RST_CAPABLE, CACHE_CAPABLE, CACHE_WBI_CAPABLE,
  RST_TIMEOUT, RST_MEM_CLR_CAPABLE
- Control2 register: DISABLE_CACHING, INIT_CACHE_WBI, INIT_CXL_RST,
  RST_MEM_CLR_EN
- Status2 register: CACHE_INV, RST_DONE, RST_ERR
- Non-CXL Function Map DVSEC register offset

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 include/uapi/linux/pci_regs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 6fdc20d7f5e6..a9dcca54b01c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1349,12 +1349,25 @@
 /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
 #define PCI_DVSEC_CXL_DEVICE				0
 #define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_CTRL_RWL			0x5FED
 #define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING		_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
 #define  PCI_DVSEC_CXL_LOCK				0x14
 #define   PCI_DVSEC_CXL_LOCK_CONFIG			_BITUL(0)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
@@ -1372,6 +1385,7 @@

 /* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
 #define PCI_DVSEC_CXL_FUNCTION_MAP			2
+#define  PCI_DVSEC_CXL_FUNCTION_MAP_REG			0x0C

 /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
 #define PCI_DVSEC_CXL_PORT				3
--
2.43.0

