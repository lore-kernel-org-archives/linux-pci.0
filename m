Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB03A6EFC;
	Mon,  2 Mar 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483859; cv=fail; b=BjUWV/No9merHz+y7PicT+a0BDOuftLjnvqoZMfsc3lZSDsr362KlmCrYZ/jxwQVx2UbHnJ/CHxZ726VdqK/EytU25/KiQDrm5waO93vEEIV0AmQ/d1yNRmsHYzrtWICrWee+6zpLtSu9ROjRIw4WtjjfFKHN6shTVWK4DtYGAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483859; c=relaxed/simple;
	bh=7981h8VXJRLVSC6/gmkSTAViE5TZp0WBv4BVyu6FYpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdVI7PAVhiX7OYKCu1kVCNH987+IYmL5GtKefNRyftWr5ZYq33L13CUD7eAFA/31QJEIusIJCggUkUmZTqEcavXMK+fNlSNE5v+E7Wcorie+I8HkY1tSrpMxKiZwRSXGU8EfkumKkGSAH2BbHRBZ32mTGNmTKjW33Wnjbq25d/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5F5AZRIk; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5F5AZRIk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEZ0LgFTqwrp+Fe5TnmlTgDcWZQ7E9eRPB3NtMfYydLyFSWN5ASOCSX4sNPiZ2vXWyTO8wDFwal6WPd5JI0Pksh1gPDeSoCLXOA1Cny1OqRe5LTfDOb4A4qNSj2gC5+JgE2iWfhxzXByQW8lnf3aqkV5SFt239FlqYEoQC7+zVjNllVt3fCuykk8sT1aYEnz1YOzQwruCdtYxjtg2QzG9LFyqYes4RAuJqM79NzWSt4xl/MzUZqe6qPvaI3BPvwuS7954nbDSMW0HPNrBG0g6ZbGrWnfYhqgpYa41mV2Szzk9C4W9jd4rqGi0xhsuEdgew7PQAQzKO1hyuwIcSNOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuGerZ6bHPohBUXw7OyAP8TSw+6WiUKlo/6rT9yWVD4=;
 b=Dc4+FoabJkGWpiaQgqdvkQpwS5pQcT9713U9ZLY257vUUZRERAbC/hs4KalWb3TDb4Op1+SZpzCoB/Q8furMskyDWy1PcvJVKNJM88Q89irMjroRxxw6DBc7/1IRxilLwG1HdrL6YDVNecINB1GrWhkazJ/6cyU5CohGODSEIgcdXKsVrNwpMIMuz2ZhYoHGMMbSJxWcrquBu97jWZGIYjGiMAU+TwLVx6d/1k0+cKNe6FmPsKhj7Fhc5P7hpTn3TvjI+pp+zXpp/XXcEq8Cr/Td5jS4Ho+nQkbz8ip9MseSohpcLUeoykegR3lSaW4oyQ2IM/ZxZDwYp0pdo5knLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuGerZ6bHPohBUXw7OyAP8TSw+6WiUKlo/6rT9yWVD4=;
 b=5F5AZRIkAJfjDvg/l1dHzpgyQWKEfQKzdU1+u+0GobGzMf1tYcfvJDjW2Wgm4OS4OpZ0vR0Kcts4TLcnU/vR33n9+hDjQsog/mLYaKIOLvqJn6WrPpkU7T+GLIl7fjLGHRkLsflBBnXLBJw0yhjcJqGoMYvgdQ1gGqMG6cCBORI=
Received: from BN9PR03CA0495.namprd03.prod.outlook.com (2603:10b6:408:130::20)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 2 Mar
 2026 20:37:27 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::4f) by BN9PR03CA0495.outlook.office365.com
 (2603:10b6:408:130::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 20:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:37:27 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:37:26 -0600
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
Subject: [PATCH v16 03/10] cxl: Update CXL Endpoint tracing
Date: Mon, 2 Mar 2026 14:36:41 -0600
Message-ID: <20260302203648.2886956-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302203648.2886956-1-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: aa01de91-9f0b-4ead-798d-08de789b84d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	DUFcReQ9woHcr2oVDDWB1AhJHJZ3g3hTGLGMwzQCrgmGPq/VuuARXR5u3rgt3aGRL0/bNRyNDRjUc9Y/mjG1cf+wbiHzayFSDa65+AT/nmGTclc6h8USGXBRQxIf052DReK1Gv+o/43WikVz8H9OVnfjZpeh994jpQXR84jUB3cPpqZHtW48Tan8VvrbQpjYOmpPpLhmQ5lGtf1GApijDWZHlDEi7UdZISXV4RiMKIRuBeiCHU2KjhqQ5aQ2D+/QQhr7O45IwgferhT5z0IEbrw/1RsxCk0nFGr3RiH4D5R5tDQAmCeiT3mbSR56orWEpe1U/0uombCIdqpnDhwx+rptx+k2U0rOv5auV03cRZyqxvQ+VnxEyHf1Neg/6qqOsjUqI9LIVBPC+ksK1li3s2yvdrFZY0XhvWjIohU40tMljt+jfkNjx1+mYoXNEuUw3/0niuN7zGOpyXVYLmxrVqLX/yoVS7r4szmJUfEvGvp+Xl6hgJ8bhIUmfHKbDWK0TvNaR3DXoab9T/TL6z10KUdETPt2CsSiSo4mkeVCIWMAPqBEqA6Fgs+v/NYI/WcL+XKT+KGJ9AePalqZmscjL0YyFn18GlvWT2rQ/VwD46Wnuds4LQWWW1ANWIPP871VPbd3pbZDMq2XaNHndjvJxbCOqfRN+nMCuEkY5BBXwpyjF8gj+GeTAI2MMkRFHQSP1ZmJXgYCJk5debrdLh1ZjkO45/EcgROm3M031JD2XfmGykGxFCVjdd78YSK8ZPiP1LaiW9DCEG4MbDMrqWBC6fNYyI3IyJPBQdhg4sO8ZhQg/WlvE6KTiOUYIqc+0kKzUg4XnoR/W1OcKPn2Id6PkXmjiWdq2LM2EGmdAGPuHIs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BVk0dRYYaffRu6ac7PC3bPsDNWa/MKkvqGWRigjjiAwf8maT2D6kmlx55TOTrpFqy83guDOIoaSEBVFswniHnqlRmaGXsPiEo/xNQ7TfZbdnMqXdTPUi7UbA9Wf4iGvuTd2KKOjmDgEeflHQVo4pAfkJmBFCTPi0Tqa90hk+KsRhQ74+49SAFwk9izn5DMs1CiXXJI3cG6ooAKR3mTVRaxV0qN2RWUJ3I7q32Lvc9eSkrShfd1DBA2h55R3gN7FHgNBgxSAwR4czu5CAeD+WtzxtgtARiffwH7c+XX/hit++DD72kaiJ/p9j8BxEOYdhNkaT0aTVg1LwyUa2S2K0Tn7SHos5ESSmhFdRyGJrqvUFrRpMUUGmmDca+V0og8NBZOuHj6GRjxR7hShqrizX+q6HIqobllLpUZcyeP2k+PgARuyXS0PvrhCfvi9655jj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:37:27.6446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa01de91-9f0b-4ead-798d-08de789b84d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389

CXL protocol error handling will be expanded to soon include CXL Port
support along with existing Endpoint support. 2 updates are needed first:
- Update calling interfaces to use 'struct device*'
- Log endpoint serial number

Add serial number parameter to the trace logging. This is used for EPs
and 0 is provided for CXL port devices without a serial number. Add the
serial number at the end to preserve compatibility with libtraceevent
parsing of the parameters.

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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v15->v16:
- Add Dan's review-by
- Incorporate Dan's comment into commit message:
"Add the serial number at the end to preserve compatibility with
libtraceevent parsing of the parameters."

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
index 5b0570df0fd9..5051800882c5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -181,8 +181,9 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
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
@@ -193,11 +194,13 @@ static inline int cxl_ras_init(void)
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
index 949d8c8ecdfe..44791f6d7d50 100644
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

