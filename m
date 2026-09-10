Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95C3C3C07;
	Thu, 10 Sep 2026 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024125; cv=fail; b=SC/iJu3Z97rpSWEbjxT+ahj2mhbd+R3ag1Td9wnoNrtEVYCpeXv1+T/D6XvkK1/adslsa/2Nc96HPv4UemPqVeLI9b3Uip+imTUuXIKK8TbBaH6TP5cX4XFpgqxKnj411qVhiz+FgVyaJPCRjFuBJe70J1aMPTLiOLMd6q2XhLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024125; c=relaxed/simple;
	bh=K1QuJjwz/jjiIhK4PFcptWV+sxJRzvvzeDWuvWskyRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OfQFO19w4lC8IcadCdVGul7GRpvcnCsgj77LBPME4WKEiz8gdWUoxcqAIXNlraN857S0LXq7u8Hhg1ysbb2mz+zeCes1q/buJI2jw2DkFMRqVSeC5iDHSJiyWvmkroexE9rsTv76FCpGYZEstlobL+UfD7+KmYhegW5NX0PcMbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ubaNLwHg; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubaNLwHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XePk/HslruMUcnAmuNxzsadtV5+j/QrmhzlPC9uu5EcPOXslGYQXIUKHUc9LQx0kW3z75lTzv6QHehsghd41sEWyry+WspncZwPkxEnjxvpT6I84MBhSm6axCqd9ZlBvOGXwW9J9LsE+2EMWlCtFTKNtEZzi1DaWOjn/OGCHP+5ymtW+Fn7L/nxYjUC/X8PYWWNs6hjqKYQto3o+7JpuNZDEb5RSJuwuDGk6eCHlbmTePAtMMfHgkvKquJZcBL2u5Q1vlqm027eDs6wqKejllU/pxDVqFH+N+4l4WNH6ajetW02JameexAhT5T4SIsySS2E+zY3dr3qW1z1MxeACtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaTBEgCxByWCPnXZouFoeNU4h7sutsuZt/t+h05oYVE=;
 b=zSkGk+c33LnTaISkMjkpkrGq9Lce3U74Wwj06kBnzuaH5J4eCB/bNJ8pAS8m8E+rxfR2sqvxL/DaOr5Ox41/kIAsVMR369Cgq/JL0oPM0bylCJX4dWjszHAvNKKVNljX5Mazn0LMkVB5A7kPh/nXUw/okOREBDN+qL4EwAzTXa2BAoFbjbu+uNH5jnVXIEl1Qq9EMXrEulPvopmL2tk2M+ghaZ31IsihW5q0sMAUeZRXg2mD39lUM1+g4ttVHEdboJ2Q7UyNIciDGzs8JAqFHc3y0ycTFra1PqHMcU76v1lSXCxABDR8pYQlqWlkFL+WJlqdLJH601uP3lET+XH1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaTBEgCxByWCPnXZouFoeNU4h7sutsuZt/t+h05oYVE=;
 b=ubaNLwHgVfHWwvioMQkHUcvl+hoWjbzmp5J/cpij5uoNXS3YihbsI+NOI7GSgFaY0blVAEIXwswMb1akiUHzi4zXUl0vozr+xwHM9h6RWG2Hqme0AzPq+Jy7kIorJeBafSXhV61GWmnyH4F44pNO9J1ygbW36/tX0vFBPqwbD4LHRjUh3Q53VJcIsdnSzGiKbbuDQXhl/4Y95i06L0XbC5tLsMGoOh/9l11K+PoomTkupEpMQVgOXmyvOL5g1vy3AlcusTaf71tbbkHcthGDiqma2DmiHlAVsxaWhGFmOeINtv/jkrdJmFpR9GyKaS2R5hJap4qY5oIBFXnWm4z9Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:20 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:20 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v12 02/12] cxl: Make HDM commit helpers available to reset code
Date: Thu, 10 Sep 2026 07:07:58 +0000
Message-ID: <20260910070808.1444264-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: a81ed343-2d94-471d-f77b-08df0f0a4b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	xMuh342q1zBBOnPOazwK5haa/Fs/+b3MxNvbkUpYvRYs4fA/4B4js2bMHho/BqNwtoOzpvhdwJMCIXqL5uiZ5X1eadS/+WR02yZNnoZ0zJVqoCCljHLtpNtPWw7+vsJO1MhPMg0mWQbfEooqdtaJtSpRboY1jP3fbAMLXhPZKtAHmN+XqCfP06IptwyQkhqEUwyfZiF1Tnavej9Ds130LLgWWELXU224fv/kTDUwUEk/kEQN477DpQGSoPc0ct7MMKzzefEH3TpRtfa1M525W86xlnDalH0oXqudq91cU7EdhZoZAc0JJWKMJanXJ7ipOPqksCTiDJCLpM/A916Q9ILXvis2e0MfdfUcqSfZHBvwZL5QeFCdSg6BUVRhkzbsjlW/IAnp5huLmyNPJol6B3qHrczYyjW8oY+L2CRITOYaXX9AYs8luzuMWpkqRcOynPFRrcjNWdWwFQQ4hkogf0eW8qebuoVpUX1acOThuavEuU6ArI2GYf9zA3odetlL1saGH5JywHoj6zIwQZISbhqk5pGd2x+jSr2UXW5rHaNa6MBGossX3RuRlpw5iSPT9C9ceToKKuiKqYokSKthd+CUvTW9LRl6ouF6IlpGTZBBml6Ds2VlO3cnGR53EIM6s5nYFpJQacIXgmq5zA5w9K769i9dKAAwogANYuQsta7DKOr4/lUuDPpqzH9jYLaEF8RUSVia9cRiaAc4dggSag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcJjzE+YyD0LuhnRNjnVUeQjN6QU94ZdmJY2RmFYgayKSmtRdlOLYWqDNJ1H?=
 =?us-ascii?Q?A2YlRrHAKv62wXmdT5te4BPgXtmzRbEdKQkKEkG6kFSlZpqmO5kp358QWixE?=
 =?us-ascii?Q?Zml4jkzL6Rqle88i33wcx+9QYjN8HHfpF9sG8nTRmY+RtLyQbcgEdXCpU+qC?=
 =?us-ascii?Q?iBck1fTTpLgT5k2CM754Xq3/JZq04ufzZe0ExadLVu4z0OwtHuxYB5m8EkOK?=
 =?us-ascii?Q?ny+CgLj7ArrtVJYhYZjsePvmhKMrB+8elQnrfBtOnfnlCL0oKIHBkY2XNV8o?=
 =?us-ascii?Q?9JKGCm8s0L7l6xlLAEL7zlXkK+KOQyJHj9GMSY393cKtsUh42QDrBf0TgjCs?=
 =?us-ascii?Q?sx3LmeTX9+s5QM40v/0sHX8OYp1xH5zChZdWPFpWTzFq6M2R8ZVSduPfvs03?=
 =?us-ascii?Q?7/540y/bdb9+xURehL/nGHj593GhHYbOcx+TQI6ilqoJUVE3rrmGrHTOLyMx?=
 =?us-ascii?Q?moGEeH0HmO3/OOMAHWvXETfYcoWbGnNfnGfdrjNZQ/n2jkYJQyE+s8MgvlFe?=
 =?us-ascii?Q?q4dJ/3dKnSAHlN6LX32TEvR99uc1Ruv/oCYNdXPcfaF6c4CPQrIOurdKrWn3?=
 =?us-ascii?Q?WrpxgGJweMJPIHHDIJIX8MnlFosMUqsUn0wE/CNt92PUsnpcjur/HUmZCnJ1?=
 =?us-ascii?Q?s0QRSuwfQSIjLKYBhHnIJpYqZ1IFSyE4SjR2dcCOiolIL5F3L4fxOBeirxAc?=
 =?us-ascii?Q?YyRlSpS84BHGMz4+4BGWjBGKEkru4sY3XDiyWDSr1l9X+2xsPyspAhnsa1fw?=
 =?us-ascii?Q?dEArBvLd7zEr9ilxmifIn72ioM0LCh3CVjo/JqBF0CrGqglb0OHcnCbAsYZv?=
 =?us-ascii?Q?9589wWzs4w/RcUPyUaiVVeRDJ70DCczjl/oE16rHSPXbUXY9rYs19gNLnSvz?=
 =?us-ascii?Q?Z6/kvCdqSiU/YenC16TRwER+n0NtrQuYoNEL7oKezr3+hF8y8hyb5odqN4dr?=
 =?us-ascii?Q?LvtfGfFZVQF6CJZjC8cYAGQ2Uzck/TCwfer2JvGozWIbBa6yBgHQHOkbfKaz?=
 =?us-ascii?Q?9rfMZ7V6fZ38OIKLo6uz6UmwJLQ7WM0ZMqPqL8VM3Yo3W8Q45/TH4TDsGU3Q?=
 =?us-ascii?Q?Kv96gw2i5kYQPuJQwLQ4PjsG1qrSZiWSXPbn9sAcDeN5kQGL4+UK49pIoFqv?=
 =?us-ascii?Q?vQgEZbBexvGlbU4sshPTpvjLeWl5P/vnCMekrSzJSN8odQaKyNSljDUALTbb?=
 =?us-ascii?Q?6CLNydrWBikQvJGGoHMCO3XvjVyTj+T+kvXjgd2Ch5faOt3zRLAXTBDgBEWu?=
 =?us-ascii?Q?+5S+KHzy5xiZCO8cc6UhvYLi53Gk+fGtjed0g7syZcCehWBTEWaIW4iQRXJr?=
 =?us-ascii?Q?79j6jY/XvKGndLxEqr1L8KIBDkNzXqFzXSAnJJmFPJVd0eFbIn0N/yZqZ1VL?=
 =?us-ascii?Q?z/203xte5aVfxzb4hRGopy1IUZF7Ytqnbi/BX7CkYEuL7CaFNA5INQ3f7hrO?=
 =?us-ascii?Q?WfYoKdXBiE4gECcmNFWqAIreQVWPHYjTzE1A4E9bTOQCxCX178QPOpnNPZnl?=
 =?us-ascii?Q?f4X4eCIHlIDiGfZZaQgR1fIbN3Y8W4EnsMBND4eiWKEgGPnJRXyG4QJjWwd3?=
 =?us-ascii?Q?Qus8kA9Iv/dDqYLoBoR/cD9KKTQpnASfwyP4ir5MPTO6vyi+e1RUNBXatmi4?=
 =?us-ascii?Q?EIgPLBaINkipXkig0uMx0GzQf47NxLPFWpKG+LD+haehwOAfJguVfyJ0mlV8?=
 =?us-ascii?Q?HhHwc6HEtC44PGd3c792rFdLA0R0bNQ0c+Wg2M84PrJuCM7uSBLAOLL639sw?=
 =?us-ascii?Q?s0ZosZ5W7Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81ed343-2d94-471d-f77b-08df0f0a4b7b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:20.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQgIhYq/8h4zVfm/0azlO2KpqGC/QF6NZ242PJJPBmPg9dlGjJ7dzAw0C00hRv8Jhw3VfRAybGY1SPu/4cj8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Build the generic HDM resource helpers under CONFIG_CXL_RESET so PCI
reset paths can use them when cxl_core is modular. Export the lock and
commit entry points consumed by cxl_core, and leave resource.o out of the
mock cxl_core module once it is built into the kernel.

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

