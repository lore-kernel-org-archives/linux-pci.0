Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D705233134;
	Tue,  5 May 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002273; cv=fail; b=JwPPPtBfXcFn3/l9nIgYawtU0BViHFmtfXz6NoxMjVz/0PNQg7SFkh2QXciFfUKGya3t1i7fRokj5tYT590IjQk7f+n5k1UNXkL3Do/S6tHPoEn0JoFhaaMB8ppst9XqJOT2hkW2ZuJ8DJDoG5ThCdbQ7jckYGCqlv2LwCK/D0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002273; c=relaxed/simple;
	bh=Ss78Dy5HsIuhx2YN5aMK8ny117Fj9ZrcWH5izgtRiFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RX2CRMMJ7L6RrQj1mCKb9VW3pEu+o8hVi8tnJ3swbUaRiE1+60d0tlAli9BYJB81cYEoaVZ+mJuU3w3TkWyloybhTY7sJlbdc//1apb8jTALDy2NZvQz+gGw3moNLHQthDS6wgC7MW31jyfJc3/1b/egbVxq0yqU1aTBFGmGnCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2dn3qjz6; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2dn3qjz6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCNf0p/Uz6IGmBPOwrjc7JMZIPR0x7grB/NGZlYrgOpVzwQdVLgDLC1rDs+uWwBJCZCRrajcDY1H0NZbzWHQCWMe94gCKMYVbFG+WrfKzAM28DUh26B1vdKKQuBeBqcdXn1nAXG9zhTZqgIGo5QA8jpCry/UHj6blooJfS4G77Wk5VPhEKzR3Kp34pRAiteAab6DTyxwcIU5bh1q2lRlRkNn4Fso+4xIAcKivWApGXZWXmU+gh9Efqj+Pf2SDC34ltsitk5jc/mnZXHswklQMoxFuWsUiksxwrTJOHSGLCKh90PHF8PJNG8Q1DKr5oo3Pimg+cya5xVyzkvNOpI/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leMS1edZgJP0a5F15QZwQR0/NY9pJq2oOnOQPGm7qxI=;
 b=bYJ37HvjkXbwfG/Y2lbsmDJYSGQJdlwqi7xlH3GeTLUu6XfmGSZQo4eZ4LF+/6NQxbFM3obEjM5P6DQdEHEYraoktTmEpahCElkI846ZcwObcZmKz0NVyEz1/JbFOG0l/MB+5/nBko2T2yyqvr5Rw7z3uRWQ97lbQl3OuB1ADjf2vkXE4U3HcOnMYwmurmUJoIDoSg0F19hcNQv6ASqLrC9n86qpkhq25u8g+ZJj+610CBsPCSYYZelBlWbID0bVU5fu3xtbo9mGmStw8iFrWRVsgF7RgjiBJfIaotjjJJ2DjUD17s9p9iWXKinNbg4sejjVGcUgwxBiSMW3wmfZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leMS1edZgJP0a5F15QZwQR0/NY9pJq2oOnOQPGm7qxI=;
 b=2dn3qjz6oUl7/OLtxBTXL8GYSaM8hnV+0MgO5gt8fOBpz6ItwsnfNFcy/g5SFJHjmU/Uda7HXeoSEqe8I59+dB6o+qlcgPoLgPLPNvO2uZcSXEdfeeDjvlNCCFuKL+Qfe2USFLaEZ2puLoa2qO85Ab99dpBItLyWkULvgijTqq4=
Received: from DM6PR02CA0155.namprd02.prod.outlook.com (2603:10b6:5:332::22)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 17:31:06 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::6e) by DM6PR02CA0155.outlook.office365.com
 (2603:10b6:5:332::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 17:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:31:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:31:04 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace events
Date: Tue, 5 May 2026 12:30:20 -0500
Message-ID: <20260505173029.2718246-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505173029.2718246-1-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: cec53833-f5ae-4d30-02a9-08deaacc16f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bCqNK6LC6KJr2pYyPrwsCu+0INH3mboA0k6enqVwS2igFM3yp9616gGPJj/xUN2CsLb+LxoLwY7k24ugPnx4BwkNqwdytIDXBA59dVeUyoMZGZetFncxyZcHjJ5ing0AUadIuao8xQgk3BVVZCazNIJtxHXHDfhe2K/4j7Ioy/HzFrnqS1C/OhzrrRXvO+vGJepFUScSOKRFaD3RsZmGpADIaPK7vFcgr77y/YxtARXCF292E7E7bOPa/0I/iJZj39mcc4hDq9H9T/XqY9MiEv1yVWDcJkaYkukSMUZhz9EHxip48OUfkzhxAvU2cOjmZiqt6gxbeDLFLgFr+eUkQRsBN/kuu6E4ZXiMAvXDl83TgViSE323AyKwBgYz+nMfB3ORQ981UVO/E9lUdhBnGJ7iZbQX7UePo8ZeoxXN9I+2neC9fBx/Ie6F0cCi5O6yxeXLjq4h/eV05ScTRZn1IEHwBaEjIUDN+v1XGwBf+mNiSsFKz19OPnUXoKnwAKIwPgNFzIiK1v92qkwdYugWOyMWLo2Qok+Qw4RZkrHNgijVrQUNIumi7aJDAcmSbiqYLaYo45BIQdk72gl+WyyhPer88ZoyQO4Rll6YiyIiY9fkYaGFk8CPYwuJSBFytl3kr2L8Xu+2UBXw+518z4Gp12V12j2TiYbtvZsBpfUDkggib53beyQ3tTMuQASVG70u7j5Tco4HWyvhfCVatESqSq8VWJzi1pTBSeqHb5O8Hb6+fSVHlLRqUOh8tZFL1abcLzeWQ8yZWJYO4XiQPifToU6Sp9AxMUVsQ4XFp+vxFsA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bq1A+/lhOolrjuL1v2uzzAJp3F+vh9xvxVGBC3A2SDnhXf6gLwVb4hPB3mhYsWw6DrefBShoD1pLVIu6cRjJFBpvmnkyjO+53ex2qYtiCr9Njq4LvBZHyAORiZjJGd/Zfwqh1+m0MX8omCSFxt78wezc0Q5bTut6LyoLvxGPCAiYPzr5Y8L1tyFzWvZE8UvYTDTMkRInJSnPGKGLdWVDtIGJq8+mKSeeNMh32Q5TqKPZfEPtEF8YeVMmgaRHrTbcbcRyX564qaPtKEgYmMMmLdS27oqN1ZKslPXRhOK8WFuz4WmTSyGcMtbC09n5Jad7TOEGlc+aH9Lssy0jpt9i0ogS/qY+9UTNaCIKstN/qfOAaV18HXQO2j2M0IX41AkQhgp+N51Dho6Cl5AaMVVJYedflG/ew4r9YVn1Ee8InLbG1mAVvHMcZxw1JOgCm5cK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:31:06.7391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec53833-f5ae-4d30-02a9-08deaacc16f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

From: Dan Williams <djbw@kernel.org>

CXL protocol error logging uses two parallel sets of trace events. The
cxl_port_aer_correctable_error() and cxl_port_aer_uncorrectable_error()
events are used by CPER for CXL Port devices. The cxl_aer_correctable_error()
and cxl_aer_uncorrectable_error() events are used for CXL Endpoints. Update
the trace routines to use the latter for all CXL devices on both the CPER
and native AER paths.

Generalize cxl_aer_correctable_error()/cxl_aer_uncorrectable_error to
take a struct device * and a u64 serial argument supplied by the caller.
cxl_handle_ras() and cxl_handle_cor_ras() gain the new u64 serial parameter,
sourced from pci_get_dsn().

The CPER path keeps its existing Port-vs-Endpoint dispatch and passes the
new arguments to the unified trace events. The CPER path will be folded
together in a following patch.

Remove the now-unused cxl_port_aer_correctable_error() and
cxl_port_aer_uncorrectable_error().

**WARNING: ABI BREAK**
Rename the trace event field "memdev" to "device" so all CXL device types
(Ports and Endpoints) can be reported under a common field name. Note this
is an ABI break for userspace tools that key off the old "memdev" field.
Specifically, rasdaemon's ras-cxl-handler.c looks up "memdev" and bails on
NULL, so an unmodified rasdaemon will drop every CXL CE/UCE event once this
kernel ships. A rasdaemon update is needed in a separate series.

The need for the field rename was discussed in v16 review [1].

Also, for CXL Upstream Switch Port (USP) and Endpoint (EP) fatal UCE,
the cxl_aer_uncorrectable_error trace event is not emitted. The AER core
only retrieves PCI_ERR_UNCOR_STATUS for Root Ports, RCECs, and Downstream
Ports, or for non-fatal severities. PCI config reads to the source device
are expected to fail otherwise, so the AER core never reads the status
word, is_cxl_error() does not classify the event as CXL, and the AER path
handles it instead. In this case the AER handler consumes the event and
logs it as an AER error without calling the CXL RAS handlers or trace
logging.

Before this patch, Endpoint and Port devices emitted different events:

  # Endpoint (cxl_aer_*):
  cxl_aer_correctable_error: memdev=mem0 host=0000:0c:00.0 serial=0: status: 'CRC Threshold Hit'
  cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0c:00.0 serial=0: status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'

  # Port (cxl_port_aer_*, no serial field):
  cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='CRC Threshold Hit'
  cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'

After this patch, all CXL devices emit the unified cxl_aer_* events
with the same field layout:

  cxl_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c serial=0 status: 'CRC Threshold Hit'
  cxl_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c serial=0 status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'

[1] https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch/

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>

---

Changes in v16->v17:
- Replace cxlds->serial with pci_get_dsn()
- Change 'memdev' to 'device' (Dan)
- Updated Commit message

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
 drivers/cxl/core/core.h    | 11 ++++--
 drivers/cxl/core/ras.c     | 39 +++++++++++--------
 drivers/cxl/core/ras_rch.c |  6 ++-
 drivers/cxl/core/trace.h   | 76 ++++++++------------------------------
 4 files changed, 49 insertions(+), 83 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 82ca3a476708..132ac9c1ebf4 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -183,8 +183,9 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
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
@@ -195,11 +196,13 @@ static inline int cxl_ras_init(void)
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
index 006c6ffc2f56..d7081caaf5d3 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+	trace_cxl_aer_correctable_error(&pdev->dev, status, pci_get_dsn(pdev));
 }
 
 static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
@@ -28,20 +28,24 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
-					       ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
+					  ras_cap.header_log,
+					  pci_get_dsn(pdev));
 }
 
-static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
+static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
+					 struct cxl_memdev *cxlmd,
 					 struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_aer_correctable_error(cxlmd, status);
+	trace_cxl_aer_correctable_error(&cxlmd->dev, status,
+					pci_get_dsn(pdev));
 }
 
 static void
-cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
+cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
+			       struct cxl_memdev *cxlmd,
 			       struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
@@ -53,8 +57,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
-					  ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
+					  ras_cap.header_log,
+					  pci_get_dsn(pdev));
 }
 
 static int match_memdev_by_parent(struct device *dev, const void *uport)
@@ -101,9 +106,9 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 
 	cxlmd = to_cxl_memdev(mem_dev);
 	if (data->severity == AER_CORRECTABLE)
-		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
+		cxl_cper_trace_corr_prot_err(pdev, cxlmd, data->ras_cap);
 	else
-		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
+		cxl_cper_trace_uncorr_prot_err(pdev, cxlmd, data->ras_cap);
 }
 EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
 
@@ -183,7 +188,7 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -195,7 +200,7 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		trace_cxl_aer_correctable_error(dev, status, serial);
 	}
 }
 
@@ -220,7 +225,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -247,7 +252,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -270,7 +275,8 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
+				   cxlmd->endpoint->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -299,7 +305,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
+				    cxlmd->endpoint->regs.ras);
 	}
 
 	switch (state) {
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 0a8b3b9b6388..61835fbafc0f 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -115,7 +115,9 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
+				   dport->regs.ras);
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
+			       dport->regs.ras);
 }
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a972e4ef1936..6f3957b3c3af 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,49 +48,22 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
-TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
+TRACE_EVENT(cxl_aer_uncorrectable_error,
+	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl,
+		 u64 serial),
+	TP_ARGS(dev, status, fe, hl, serial),
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
 		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-		__entry->first_error = fe;
-		/*
-		 * Embed the 512B headerlog data for user app retrieval and
-		 * parsing, but no need to print this in the trace buffer.
-		 */
-		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
-	),
-	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
-		  __get_str(device), __get_str(host),
-		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
-	)
-);
-
-TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
-	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
-		__assign_str(memdev);
+		__assign_str(device);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("device=%s host=%s serial=%lld status: '%s' first_error: '%s'",
+		  __get_str(device), __get_str(host), __entry->serial,
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
 	)
@@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
-TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
+TRACE_EVENT(cxl_aer_correctable_error,
+	TP_PROTO(const struct device *dev, u32 status, u64 serial),
+	TP_ARGS(dev, status, serial),
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
 		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-	),
-	TP_printk("device=%s host=%s status='%s'",
-		  __get_str(device), __get_str(host),
-		  show_ce_errs(__entry->status)
-	)
-);
-
-TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
-	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(memdev);
+		__assign_str(device);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("device=%s host=%s serial=%lld status: '%s'",
+		  __get_str(device), __get_str(host), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
-- 
2.34.1

