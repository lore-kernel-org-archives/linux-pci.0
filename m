Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03C202C48;
	Tue,  3 Feb 2026 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087204; cv=fail; b=boYoAnSvW0jvF3SAufglvPfnzaxVa1rhBV7j77NLR2yLdhankQu7vW9edXJFe6E899Wq9PRysqfk1Sna9/QgWdv3nGfACe8hOpV2HtxOwbyun9Y/yVW/p9YULq3TR5cufQqXXuJnjYJanzqbapZAG+fuKwbBKwHaFe64EbeVugg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087204; c=relaxed/simple;
	bh=dnaGMfdmkVPjSrneikeaxYUlgrs1l0oUffs3CazWU9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2IkLTZUQftaCNUgJf9FNvjv43EXrMEjEgdcH05HhDcWbyXNSQnvP9VzZ1joGReLZ707a+NhGm+60eR9DoIgc/WObbmFfqS6WuAYt2A46EnBIKtn8y7pZ34mwWe+7eRI2F1yYxdFX76REfYW3ptZcsBpkzqtnIpdxY3EBLjyDVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Dk8qjxx; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Dk8qjxx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2DbVkntFNmk1RSh38HvF825Apx9FNGzxcMViVJzUA1z/zup+cx/cKxA6AKs0839BnqQ9SC8g0R2uOD6LJeyM7mh713UyQnL4sV4g3XIcFk0gyhWld5ou97sDS/qUvTnGeYpnSjyCzacutQZVHfsGvm4DGytPJvaYj9jWdgzjVxH4dVTo4To8/EdZ+BLd5tYVdwGBe34M5P/bEZNDcWdTYCB0ILkCy41keldX60hwSpMZsGcRzCK2u4La+ysbBwgtvi8GPj9XReTt2yqs+6410D+IsXQNNKVCHU1RYTwxqUo57HmfQCu2J8Ya/OeMS7kCof5ZpZbZyp2T0Mlqi0TRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GReQTtGQOZIMhHjCgHrlA/IVXmuSFdo2CWYE7xGsaw=;
 b=MZTeyu206CtJmg4+hLeX9V53NdGzl1+VoWfEmsb7/qZYZBr2afdlQwS38UdECYkeqmN/FK2yqjMk/s/PcS3IsoLuDA2vPEg3+D+h1TdPfiOFJ+WKlG9rIoXXDKG72ta0SmUJjyggIeiz7IY42pP/aJ6os4KtDKXA2cWEYI8FYKaOdlzecCTkgM3Nnf4cY+XtC8CjJ+xhhGVdnfMDkOnLVfBLJN8PS+GZwmff3PtcDJpPYOs0gUG0DshahPqbVJWiraFHi0NG0OWHYPzwy/9hPXKLnHpshxN8resdJ4AynTOo1MqsrdNBKx1m20cjw0Tbppr3ayixSKqXqHky7DXo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GReQTtGQOZIMhHjCgHrlA/IVXmuSFdo2CWYE7xGsaw=;
 b=1Dk8qjxxHtUTkq+2RNTWP4rBCbqh5M59kOCue1pq0SNbKNQaIaCoJL3hepqCvAJpgvpxznlNboI2zA1xi7i8O1fSIna5HeFpblaaQDFn8DXv5r1gqkCrfxabJmsnsG1WEh+CymQUWh4mO6KLeYIum9QUMKlMOZkhts6XidSxiOI=
Received: from MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25) by
 BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 02:53:18 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::9c) by MN2PR01CA0056.outlook.office365.com
 (2603:10b6:208:23f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 02:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:53:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:53:16 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v15 2/9] cxl: Update CXL Endpoint tracing
Date: Mon, 2 Feb 2026 20:52:37 -0600
Message-ID: <20260203025244.3093805-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203025244.3093805-1-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: c2926d14-cfe0-4012-3e76-08de62cf6230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b31BMaxBFcxWJ/XR75MtV5ciKcI/OWTjU39tLotcgLzL7CK8do+05xy1dl6b?=
 =?us-ascii?Q?bfrhM3z+EwSk2LxJT7XJLpUhI9ryaCO8cicri9qm7wfohSPZe8i3dn2N6FkX?=
 =?us-ascii?Q?lbQU2hZ4h/XUO4QMcowEf+2BryHNPi5BpwImDLvaJYv4FCBKoVvs7Wxt6bO4?=
 =?us-ascii?Q?BG8vmKgqbR4HC/8olZFqj02lxjaU7jZGdreK5HqkRurwDFl+saA7rz7Jtagx?=
 =?us-ascii?Q?L1mCGSQ6G4Dr65QZOqFJD3yxIyQi+xylZ9ltHhwiv5GkRvdmLCNgg7oOKsJd?=
 =?us-ascii?Q?a5N/OQVpSgjg1TLpKmJbiQ412DZ3+it8gi067FWSGjUiEMeUyJOk4TXxj6+g?=
 =?us-ascii?Q?nUZ6uxcdTFxkVF72PXJsGo3MMt2WucPvfSTFgAZAVi9O1UUZmblWWc0zCUqa?=
 =?us-ascii?Q?cVwHMc65XZQz0qFd6YtZ1jLy+s76IYPP560YIeVBCwkbaqzdS+4GmUHf/Gjs?=
 =?us-ascii?Q?ZEeIZEjn7zuiTbt8QHBPwQojAl5ejnczJYXaRYa76/shuX+f9rmegzYxdno/?=
 =?us-ascii?Q?vYhdYpyYzcpu3wRWKr36FT+sWomGJ3DBmqW/Jv/SKOSlNL6QTaXkGGAb+BXd?=
 =?us-ascii?Q?G+i2nJSRTYUuh2ZcGp/J42P6BCxdsCQUzrVtRzOTj7QUOZUwGvPmV3vhVCX0?=
 =?us-ascii?Q?t2NFwwTppPuioJSidV0rKDm6I8imOFjVCF5YcUSeTMS1S5af5kBkj5l8TfkV?=
 =?us-ascii?Q?lhmPZADTLGJyVtikbX1zGyRjofi5Luf+yLmfa9W8lDFM1/Aqzf5guu3axF3L?=
 =?us-ascii?Q?s2QYlnM5+LcbXHneBvLeh34sorbSn4dfJHy1YT8hDDx/ESEt+GiKShlih6Zg?=
 =?us-ascii?Q?NlkCMqCb23B0qnDLyU/MtPH3g7W1OHqisGzeCr79dCks1CcXVOTMv1ONnsGz?=
 =?us-ascii?Q?4zAkxz/8+nhzt428YTwkUh7e9pz5cMBUk+6cq6s7JO4oOU9I405L6CO427+O?=
 =?us-ascii?Q?YGRM7CtTEdjRyU7hSklBiJt3dZqf9O9glWwTAVrmoK30XjwAvjXLmlsE1eY3?=
 =?us-ascii?Q?TdYzKy1Nng9p++2QUjxyj+zO8ge2uIs4C2cOks0PH+G7riQulcoZUH9PtKoX?=
 =?us-ascii?Q?MlqVE4DQNVNNQMXXKAV69LIrHbPDqgFux9hE9Ae+ztQ9y5MjhRszujCuLia2?=
 =?us-ascii?Q?VOrKTW0Y4Hu9Jjnc5of1AVSuVJM4kxVfNAKdJtmIXSx2WmAqaZIBlptvizxb?=
 =?us-ascii?Q?ZymEe7ybLaR8cVjl3KKn4zoWYZZ1BTifD9UKS8R6L4AwG+x+t1lGkXP/Ih8c?=
 =?us-ascii?Q?V1uCX1X23b4H5WTNrdw1f1Mye6gGXxrD94vGiUijMSjoJh1+gYoRRK3hbAK7?=
 =?us-ascii?Q?zonIMZmRYklr/Gj+NfHFR+L3gtwzAy80rjS3f3FFRBYKRJKVHUfXzm4oygJr?=
 =?us-ascii?Q?lVInVg2qOAnvlYK6yYKuIQHVoXeTPV990X3qJ30M14m7OL3jzs0hLF2AHb9n?=
 =?us-ascii?Q?w7xH6jrYNFX2h+GPFdVHJX/66PM88JchXjprFxctJTIGf4ycN3qBUN+T6UH7?=
 =?us-ascii?Q?WSneNmbd2uLuvNHXhmUv7ARN2U1R4TVymQhTNZ9WvEESqsJKsUsFHQfmRu8Y?=
 =?us-ascii?Q?iMK9MN8vOQuC7EXXKSSTfjlAIV3n/9yNrJtT9Lj6yZRIM/CdNxrMbZXVEcBg?=
 =?us-ascii?Q?jJ2GBNhXAXGwiDsZ5kOAch5GVsVZ53GNpV48DL+AUMmVPCJ4lgTmssf32IwS?=
 =?us-ascii?Q?SeKrI1Y5yZIHrwoGv999WG3/hxM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ub4xp3tl+u7k7iTgg+/KM79w3GkjlIHWvbhTueyx8cHg+3GJZNIbAck+1QaXo9FJzxDR5KBOmAxxRFcBQKG4x6KjZuEkyAVQGaicv9HNbatkXMcmouDpgplya20z4SS5jFZnHlVVpu7y1WWlfH3fN7l5iwCPyU2WAiY7UgZKZNhd2Pd8j1BZKpBi/2vccEDSugliGWJZHybLBHWiR9PvFTqvn+d0rzwkVJtoZJYQ+zuIncaIb9ZfHY4ynR+4Y+zWVFhUxjvMM98Bbyasv8sjG6RG/DBgwnvx7iePDE9o1vJeZ8f7HdJgHLXpvFCOzOseuOwnhIl7/cxeknjL7KWM13nNP9jZdbPEjsdjtgnK/S6dn9aO0CHYDGv/8g3WKw67WagPsk//iLlAOQNuM4VbDUksrao+2a3g2B4jMQu6vjf2jPiWRzRtssZ5vm/uFTyA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:53:17.7825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2926d14-cfe0-4012-3e76-08de62cf6230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

CXL protocol error handling will be expanded to soon include CXL Port
support along with existing Endpoint support. 2 updates are needed first:
- Update calling interfaces to use 'struct device*'
- Log endpoint serial number

Add serial number parameter to the trace logging. This is used for EPs
and 0 is provided for CXL port devices without a serial number.

Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
unchanged with respect to member data types and order.

Below is output of correctable and uncorrectable protocol error logging.
CXL Root Port and CXL Endpoint examples are included below.

The tracing support for CXL Port devices and Endpoints is already implemented.
Update cxl_handle_ras() & cxl_handle_cor_ras() to also call the CXL trace
routines.

Root Port:
cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Endpoint:
cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v14->v15:
- Update commit message.
- Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (terry)

Changes in v13->v14:
- Update commit headline (Bjorn)

Changes in v12->v13:
- Added Dave Jiang's review-by

Changes in v11 -> v12:
- Correct parameters to call trace_cxl_aer_correctable_error()
- Add reviewed-by for Jonathan and Shiju

Changes in v10->v11:
- Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
and unchanged TP_printk() logging.
---
 drivers/cxl/core/core.h    | 11 +++++++----
 drivers/cxl/core/ras.c     | 23 ++++++++++++++---------
 drivers/cxl/core/ras_rch.c |  6 ++++--
 drivers/cxl/core/trace.h   | 21 +++++++++++----------
 4 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index be3c7b137115..c6cfaf2720e1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -155,8 +155,9 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
+bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct device *dev, u64 serial,
+			void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
@@ -167,11 +168,13 @@ static inline int cxl_ras_init(void)
 	return 0;
 }
 static inline void cxl_ras_exit(void) { }
-static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static inline bool cxl_handle_ras(struct device *dev, u64 serial,
+				  void __iomem *ras_base)
 {
 	return false;
 }
-static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
+static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
+				      void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index f6a8f4a355f1..74df561ed32e 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -37,7 +37,8 @@ static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_aer_correctable_error(cxlmd, status);
+	trace_cxl_aer_correctable_error(&cxlmd->dev, status,
+					cxlmd->cxlds->serial);
 }
 
 static void
@@ -45,6 +46,7 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 			       struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	u32 fe;
 
 	if (hweight32(status) > 1)
@@ -53,8 +55,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
-					  ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
+					  ras_cap.header_log,
+					  cxlds->serial);
 }
 
 static int match_memdev_by_parent(struct device *dev, const void *uport)
@@ -182,7 +185,7 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -194,7 +197,7 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		trace_cxl_aer_correctable_error(dev, status, serial);
 	}
 }
 
@@ -219,7 +222,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -246,7 +249,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -269,7 +272,8 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
+				   cxlmd->endpoint->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -298,7 +302,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
+				    cxlmd->endpoint->regs.ras);
 	}
 
 	switch (state) {
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 0a8b3b9b6388..5771abfc16de 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -115,7 +115,9 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
+				   dport->regs.ras);
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
+			       dport->regs.ras);
 }
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a972e4ef1936..5f630543b720 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -77,11 +77,12 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
 );
 
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
+	TP_PROTO(const struct device *cxlmd, u32 status, u32 fe, u32 *hl,
+		 u64 serial),
+	TP_ARGS(cxlmd, status, fe, hl, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, dev_name(cxlmd))
+		__string(host, dev_name(cxlmd->parent))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
@@ -90,7 +91,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_fast_assign(
 		__assign_str(memdev);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -144,18 +145,18 @@ TRACE_EVENT(cxl_port_aer_correctable_error,
 );
 
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
+	TP_PROTO(const struct device *cxlmd, u32 status, u64 serial),
+	TP_ARGS(cxlmd, status, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, dev_name(cxlmd))
+		__string(host, dev_name(cxlmd->parent))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 	),
 	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-- 
2.34.1

