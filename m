Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1837F320;
	Wed,  2 Sep 2026 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334099; cv=fail; b=V6JKM6FDhkBal4/p6VoNDVLGnJRBVqY8SsmjrXSvbPWJJ6c5eegMURLfvUNP7LAz0dj5LcrKYlkScW6PoHwe8PxXb1xJkQWf4+vJFb7HPCv7QYWSYHIuiicTEHHcRg9WZBrqDmyfkwmtQMNgx5wPCZtyKWvBh9+K0YS8fYb1+bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334099; c=relaxed/simple;
	bh=OzuesIEWiyCJLFGVjNrscTigp83CXBs3yN5gDuybkHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JEEuL6DPZZLuj64Gc/iFaHhR+19cIxSrP/ZSSf9QC+3p8OfW030Dp/Rz8ijO35st3KjYoAcI/qXp6iAa7imI7ZyHEBgULNwksS/wuKzREAXzFEqOFyUDrD2ojr8qhDt2lqMcKtNGkmWzgm5GpX/x2gaaYsL+2U76+8UYLWZbvKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O2eII2r2; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O2eII2r2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl3N72QtH0zc6NAdYXMh8/UsbWyKeQBW3BlhYEGLhrUdGkZtfX2OGx/MgNdtMZJo7n+0XOdO/SGaRSDjGuTvT0xOEZZptzBOeYzrLuI1LiqaIPvL9Db9u7riCNTtl5wKqMXMDF8h3fM+C80dPgIcdSb/V1CZWthSxObBmxB8iGhKWU1DvJA9BtEnPX2e/G9HrsZ+GbZ/xDwiWWJ9gxlJRDXVrCkACwSENw7kUAIfiX9s/BsNz6EW4GB2e8id4bYImRlElDIhIZzjGB95yvLaEnhZwUOzbdtgPufsVmWkxWvhhvOHqM2ElOqCK4I9hMfHF6aYPl4jHCYTLsPWuR2roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8RmpwJbZALHzONy3SbVVd7Qrsc7xsF3ATSOG2rK774=;
 b=KoA43l83UmHUIXoei+63M3y76AqZLfTVDs4LmOfXWDZiMxNOCMkd2Zjw03df8EId+Jfxt/9RU5MRrobTb1RMz7v4by4ypCSvrJ3yzgOTUNu3aIJsxUdGvqz/4cSImkncdDuf4DqivVzPgBk3jouTJ3VVR9eSNAmNEm34mfmDmZHeDCcjlFSIzJlk7cLoA2sdjB2kcjZrFIx8mL13FUFBbve5vOTPvPQ/0dhIahT1RXei8ZRw7s/i2gFA2OdTtHWxx6+BUoK8czxEeaBAzzqc8qDJ2Mqi9Q71Gc7NtZlJr7CCI81Uzqqt12gQDTiidcDodNCetJVifxJDFMI4wO3N4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8RmpwJbZALHzONy3SbVVd7Qrsc7xsF3ATSOG2rK774=;
 b=O2eII2r2Io138N7/dQtNtIrntd0E9mEwQ1/SmpT8kCCGAhRJz1/YBt8QUHlpOH6BRq65V35yDBdtX5FXGwfHpC1TqTfg5UlBCDDhr2DGdwpfm415hBqUEcfduRuBoaJ4WctAu0DGmq+tGRebg9g588AO4snHntcHWdosZco+Zn14h5exkKAEY+gf0aZodzpADzRueynSwix7n7rsiXcaaFMy7Yimt6gMBwLSnyEy9iRtgzfRKBnbfDhz+ERb03yeG3bgkwwV+VhHEJ+GN8r0HVGbwOOsO/x6TEu8a5mOrUuZS7jn9mAsHYFlo5xZqiPvTFI9jTn6AIzMtjPO3zw4BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:14 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:14 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v11 02/12] cxl: Make HDM commit helpers available to reset code
Date: Wed,  2 Sep 2026 07:27:54 +0000
Message-ID: <20260902072804.665639-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:303:16d::13) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc97605-e0e7-4fc0-b770-08df08c3c016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dcKm8tkZESVlh8prG1wc3AosBmmLvep/SuM80ydQYpwfmT1q0lzTXuMInOmNTkx3B0h61WlicUuZkvDf8AC9W0VO9/4hhVIC/TBH0+LWAuCadLa5jEkWkbbbI/wah+zZkpQZ9bSGhkqaFCdzFT/CKnrW86sXePJxwnspSsRWw6fIEFyUFy8Eckz/DmhBbk580E/BDT9PQvCVlWaV5NDOETJ0P21vhLs9WnTnoA2/DbsAmTf53YWMVzU3ep0iQ255KWEaXvctHW+qT4i1wVZAudbAYecabVozbtiAIWG18A7EIkkLYPW+nFaWQMdpVPRGPO+AoddgOhZyBlI8sXE5OZGMSWm0ZcM3iriJjntpi870p/g81Agf50UXFQ3b24KgSWSmg85qzPgBIdeiJn/I0+lgugqA8Yph468PF8yZQ8KwoUPvAFiw70WzTMyGDXKTv9iL78JWwitWudZyuISTY6Of0KA91icYPDW1kULAgvryhaFW4AH3v4qwY8hhisbGBpxgvbQzI5wNdeqX2WJsNmAzgxrKDmNWVvF+ldwENJiPJyOncxWa/un9xfUyaVEf00zzamRH0yqdDWq5EigClewmutGoX1iZk8eUYpJxtjpRo5g+dQzhtXunT6gUIpcEBPu/MQi7Gh1zy6eAVjeLm8M1GlZPdTSgU3F5+bm3LBl42zblVKQokn+U2yPDF7g72TIgt7uhsdOz6yhesxAdEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T705J/8E913dzWAxxAopPPy9CcttjWixFw6CA50kDdW+csnmN2DIExmstzPg?=
 =?us-ascii?Q?8/7xdTrgEcU2AFRB5pUZ3VSP26GbA0A1X8p2z5NEGnrXCJI7buK8MUalw+OR?=
 =?us-ascii?Q?PBFd4nMQrc4cKGauZ/PXYDhVpqqooo2PToAlylgTOc+0j/EmyFDf7xyR9Fhn?=
 =?us-ascii?Q?38CMBd/wsNsg4SDmQ+v0XpQixpjxOmJw2ByPDCiivvRCR6lkYJHh05TUgmO1?=
 =?us-ascii?Q?pb7lONxNQWrgqfTDIACDjPrU1W97nJKztzvQuVvZtRz0GXBTKHpqUlk739yP?=
 =?us-ascii?Q?9mh/IyjLjpn/Vb6fgh8fEGeVZUpYvpg5RZ4Ue0e7B5Rj7mEgS55rWqqs8VEs?=
 =?us-ascii?Q?dJm+sKAtgGg1VQ0hYiP9GwGJ8t6ijTFrZty1re/GNgSrC+eViLIL2z/BnBOA?=
 =?us-ascii?Q?4PfVsDBIqa85XiXedWoGxm1emYgMV27uzANDd0Xb7YxCt4vAkpqJouYvOo2f?=
 =?us-ascii?Q?+EQrKe6ehZx6gb6R5pD38skgK71dh/WhjWdB25y87mbIEbcTNIS6p7vYtJAM?=
 =?us-ascii?Q?Bi9brk2WqqpTPNBUtOYUEKilq9Z05bfeI7AU1/TZiAiDIKBQNHSbGHMGN/2b?=
 =?us-ascii?Q?/PMswBWtCp93P+NA5xSCReYPe6E6YPhWSnwkI/tOFUlZp+6wzw4cwRNTXf3O?=
 =?us-ascii?Q?K+rjqEJvayb/+GlQECsm3GpZOxaSLtj14I4z/AmMBuQ/zMyl+5MV+csF+VAf?=
 =?us-ascii?Q?OuqkHLfJLOpyOcvyP1nrQBMfuu4GBvKt8N3j3aACJkHvM4JYCuZkKZovxn0W?=
 =?us-ascii?Q?0xtqjbMe2FmFWJTSekTbJaE3xofmV9z9eQeZIRazahVtNGm1CA5nrNK74RI1?=
 =?us-ascii?Q?4qlF6zyJ0lFnZ47rHzo2/4ZJAz1nEVPMjrqwqOfzUw/7q5a7nAtaUcTHrvDX?=
 =?us-ascii?Q?J/XzU5uBdxNsfyPGuvToJ/eGZkzgonLoMBC8sgEmMPc56e+ZcyURMEo7C0kV?=
 =?us-ascii?Q?8fQA3bwHDU8RtcPYBe8s2VlSA4HKenooxwmV+ZyGAlxkZRQ+JeUZYEtjAb2M?=
 =?us-ascii?Q?LEo9aYmq8dFfZYS5Kd/9BFMsohJYGo1eS9Qw/zOXn+NcCzQppceJq8HuwId0?=
 =?us-ascii?Q?EY+cY5M30y7a2aFRieZoj1Efv5HEJr2M1bet95GJobXjz6yQlyEOjM7r0ZdL?=
 =?us-ascii?Q?9MpmMbMzCwwe0E9J05CuFN+8JAnTp4Af9Eh/MGdbKWkXgxiplge0ZNFWFV/S?=
 =?us-ascii?Q?Z9nn1ENtGwevrt0b+vfDW7K+jG166FUgdHQ8fhgCJJtZJqlJOfpQjNqJcNNK?=
 =?us-ascii?Q?enZo6GD66NRa9BvO6Ktl+mDeVEalwYmWvBcO0KKzPdJKo/n/CCJmlNjGQTvT?=
 =?us-ascii?Q?0+H78NDVOf/OTh2RgCyJc0XWRVKlfpsk9LXeDQ9lCY8+74RZv4Mvj6hUiief?=
 =?us-ascii?Q?9mT91Qh5NUMWn/SqZF6WWzokWhoB8G5fWzdMPCHLEiH0bdoV8Jg+ZbPacfLY?=
 =?us-ascii?Q?adlwbh8SHbZNfqWcz+ur77C1xG+ndjat0G51Sz8YQ7jKGFmBRzkpziePpaM8?=
 =?us-ascii?Q?uWCjPqIqFoaOq4q+ka1cp4pdRbWmsVvKbtl05SmEz0pra0IeaFGqBfbGAE8+?=
 =?us-ascii?Q?/AG+yizDZMa4lU1oXDgfZa9kIHIdapLm1e5yGLu1yZRXOWEeQsGGgKjDcSBE?=
 =?us-ascii?Q?sZaxS4y0YkHQZ6OskIVj1d+pBhJYtXdGj3QCAVXIISGFT4XTxQu40JkJTzx+?=
 =?us-ascii?Q?NO6fAnJqo+/sjewXpHOO6CYPW5WxWymp9bSRoyocLAf4OvtRTQ10OTlw+zxD?=
 =?us-ascii?Q?D3Y1QK7gTw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc97605-e0e7-4fc0-b770-08df08c3c016
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:14.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlDE2kz8IzPRqUsyqeKmzynvaauSEsji/XEnqqiXzic8nqo4Ypb1AM/QlfAEFq+foyCrNnNPYrnsSUGkTjOY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

Build the generic HDM resource helpers under CONFIG_CXL_RESET so PCI
reset paths can use them when cxl_core is modular. Export the lock and
commit entry points consumed by cxl_core, and leave resource.o out of
the mock cxl_core module once it is built into the kernel.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/Kconfig         | 4 ++++
 drivers/cxl/core/Makefile   | 2 +-
 drivers/cxl/core/resource.c | 3 +++
 tools/testing/cxl/Kbuild    | 1 -
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..9e6fb2290fed 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select CXL_RESET
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	select FWCTL if CXL_FEATURES
 	help
@@ -243,4 +244,7 @@ config CXL_ATL
 	depends on CXL_REGION
 	depends on ACPI_PRMT && AMD_NB
 
+config CXL_RESET
+	bool
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 57995777af0d..30470799e059 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_RESET) += resource.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
-cxl_core-y += resource.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 64e63114cfbf..8d3f43640199 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -13,6 +13,7 @@ struct cxl_rwsem cxl_rwsem = {
 	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
 	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
 };
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
 
 static void cxld_set_interleave(struct cxl_decoder_settings *settings, u32 *ctrl)
 {
@@ -105,8 +106,10 @@ int cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
 	lockdep_assert_held(&cxl_rwsem.dpa);
 	return setup_hw_decoder(hdm, settings);
 }
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");
 
 int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
 {
 	return cxld_await_commit(hdm, settings->id);
 }
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6c09932587ce..2be1df80fcc9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -60,7 +60,6 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
-cxl_core-y += $(CXL_CORE_SRC)/resource.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
-- 
2.43.0
