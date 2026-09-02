Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A849E5E6;
	Wed,  2 Sep 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356433; cv=fail; b=GvSFbCaq4FiwSDdM9sAoGrqKd7RSXq1e/ah3gSg2Soqi/r1ctEHpHBwdHDpv0TqNyzHh0dxSSk5+QRU49HbWL2GycoXO7F7rM982M8AfOlqz5fAdddFK96X99O2+h7xrS+5cAsyqeFHYP+OHJmuIYw0fZq4gLArz3nimqQfWpiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356433; c=relaxed/simple;
	bh=oxTB66Npz5xUrmAgbGdYBswzbkGwwkWyPyuRNuFinlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzp0+ogRIpU2LZ4lgSQwi/XncRFWY4Vu8GFiI4Dt7irFMUIkkUeJXNUuePnHyscM+7OxSZPywZbnm5rraXAAO+2r1kHa3Rk2ERC1l+d3VtSpcdAZms0QIYUa+xJgumuz3kw/GPP/BJWeAywJWLZ7PLQjcNGGzaTvTwhbtsJ+j3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C/wfp6JL; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C/wfp6JL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MThtfkn/7EJo8AZgesrEtitNStijGrUvD9oLC8LvkIk2mhRLQdImapLknu4rVujNtE1dCuSIrVHa4a4WTf6BzO5jxtnIFAIQ/NqFPlifvWGfXhAMzcbC8qnP6rXphSwOoPc071AZ+tj+z8fDSUg9SoEAVqYVbg3ArU7oa0VPEb2ZlepqLqaC/wDaob5Skyc0Fm7rdHDhsA8oRg5O61U3/pHhgUFXRzG/ZZtex1iZy/OoUx3Rm19de8GGRFGoW9mE891Fn+jjif2z3lN7AJ/5cl9R9pSMJfCcEf4p9xHr/1uRDY213fwFv+6rnIMGYDmqpf+wU1ca1xHnD9qiq0FtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiGAr8qiD2Q1jNINc6JFYtvTgstf4cyFUZ7M9dardA4=;
 b=Y2MbakYklzoztl93TDh7qXAuvRcKclkxtSsCtlwtQKkbOx2/Y+/7hp/lyspjwC9ljg7YVHzPkk6IXU5/NrOGZa6FE4KRQpEDsNYsdaI9YowWJodD060jcX5n+2EO/wxOJyV5dRDe8evtMNm/jhstikEUbFVvneTekDAZSm0e88S7sT8Mr4ftOtkzQCsWzGb3yHeXhxG32e3D3HyL7KPw/Wk66chJfkSO/xero4kCYXKJ/T1LTffpSpx+Ntzb+QksxazjgPSJCq5YTbYTHjPsCdiNKmE1GbzeuEQYGDBLyIj5bIqVvlnqsL30QSVjI9G5inDchDYjMEK1ZisNnLFuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiGAr8qiD2Q1jNINc6JFYtvTgstf4cyFUZ7M9dardA4=;
 b=C/wfp6JL62diyxPR+xHq2YuaG/d24WKeW5k8mH5jdizSgykpZGg/ooYEZO4jLs4t/0Pa3JJmCcqIqkf9xEtv3WWwC4bkl11UhUDIidyJi79rKPaC7xbIQe3MLMQ2FdajtLNmvf+FBXE3Hu6kPRYC1ARAZP8eVIIxswHOImAQQAQ=
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:40:25 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9e) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:40:25 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:40:24 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>, "Lukas
 Wunner" <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v20 4/9] cxl/pci: Thread port and dport through RAS handling helpers
Date: Wed, 2 Sep 2026 08:39:28 -0500
Message-ID: <20260902133933.2992457-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902133933.2992457-1-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 1483544a-2daa-49ed-52fe-08df08f7be85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|7416014|376014|10067099003|22082099003|11063799006|56012099006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	tkIDUNz8d89j+zAHH9HpUV++P3gxTh5GuRM3IIWUPFPr//evyaJKSyylIgdZw1i6u37GXB1iJKFBMAAePEDo8D7Idu0UqMIyPtE+pHmZ5FQYuMQDlRVyN5m0m4as/vnbBSxjgMa6QepAbUO9CfRCUcv4K/LFfuKoyAZQXdVwSeWpIBfeRU+gnw4YtVJODgAfMfjRnrH9fhdqmTbmnyaWFTNXtwDCf0hW4uaszEYlxbJL3OibZuDcaoMprImjPs5UvjLxVUnmpfTHxjgAHOAJjvRPb9fhlTlwpm79qRxboNEc0E2bAug/zy3C0WYRPh5DcvAmSErpF0JJhYkDPCdnG30PWXlr6uv/qcrDa/WamT0Ngn7ZkApAXuEvuCTqzAH9sTm/XC5wQWOgZZDjsZzbTgKtGb9zGsH27tou1kEdGrU0U5Iz+wj+NOevPo/Kahm/ffJTaUl9KFtc1ZhrkeRRElVGse21QmIfjEgY7Mwh4YbrpMnKqzcIV4X3AC3ojPPrcyGmdno7WQrAmWpv/M01M8DZ2Vksh2y5lxNuSBtzsRLFyoHda6g09ffzYMpcgSp8X947q2pUveAcUaVUpogsMWF8fSJWibGlYOP1jYmS/PTR/IGzhQfRD2VKU6zpA8XSADxxdx0kZduhSxTEFfg4qjta+fxsq3CZNBPfxWCro906XKn80qyW7mziLDjYo1WK0Rh3za/4M9nMi1f/9uqK/8jLeiA2PFvfpWKbo5PyaUhe2L4DMEyqt5NJZyTJSc3V
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dfzoN4tl2A0pZZC7iNBrr2pMdpCxv/plV02reVPRFjH6axvpkKRz0z2nYqetZQUuFWG2SsdOBLseSovJgpCoFB1lk0HZkYMISINs4BqUeBnW+D8PKJX75ltewaUhyBb0Dr7Ev4kJ58hgDGd/OzyGJRR5w5SOo3i4DF+9Cv17LInL6LANZwppKMVygdSoE6MBEFcLgF2ehXqyDGpw86GZSyLaRU1HbeB8q4xbi8AMgC47DYa0hEdIp5lSLpAJVGvwlRiVO+VEixA4+DrX3dlpeuoSDnYMaeH4XprRRVBkrT0ny+YDo5kzV3cI6fnS181OxuenUxx7jOeHVVgEjNJcLQhVWGja+o4yv8pVoTfvnqaFcxVgQIGV6TUFjPznG+aW9r6wi4Oqs2xOeAZZT3qHVBCwx0HK1XmMzf1X33SK6uNSVLxv366amKD7Jj+1Bklk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:40:25.5532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1483544a-2daa-49ed-52fe-08df08f7be85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

From: Dan Williams <djbw@kernel.org>

The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
a struct cxl_port * and optionally a struct cxl_dport * for the device
being handled. Passing a generic struct device * requires is_cxl_memdev()
to distinguish Endpoints from Ports at trace emission time. Threading
Port and Downstream Port directly enables is_cxl_endpoint() and explicit
dport/port branching for cleaner trace dispatch.

Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
emission logic is split into three branches: Endpoint events are
identified via is_cxl_endpoint() and emit with the memdev, dport events
emit with dport->dport_dev, and Upstream Port events fall back to
port->uport_dev. This branching is transitional: the follow-on patch
("cxl: Add port and dport identifiers to CXL AER trace events") unifies
the trace events on port/dport and removes it.

Update cxl_handle_rdport_errors() and cxl_handle_proto_error() to pass
Port and Downstream Port to the refactored functions.

RCH Downstream Port correctable trace events now report the dport device
(dport->dport_dev) as a consequence of threading Port and Downstream
Port through the RAS helpers. The following trace event rework ("cxl: Add
port and dport identifiers to CXL AER trace events") adds explicit memdev,
Port, Downstream Port, and host fields that provide full context for all
device types.

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

---

Changes in v19 -> v20:
- None

Changes in v18 -> v19:
- Added review-by for DaveJ
- Update commit message that three-way trace branching is transitional
  and removed by the following trace-event unification patch

Changes in v17 -> v18:
- New patch.
---
 drivers/cxl/core/core.h    | 12 ++++++++----
 drivers/cxl/core/ras.c     | 29 +++++++++++++++--------------
 drivers/cxl/core/ras_rch.c |  2 +-
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 645824167f788..4f6b4702deb38 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -187,10 +187,12 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 #ifdef CONFIG_CXL_RAS
 void cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
+		    void __iomem *ras_base);
 void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 		     struct cxl_dport *dport);
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
+			void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct pci_dev *pdev);
@@ -199,13 +201,15 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
 static inline void cxl_ras_init(void) { }
 static inline void cxl_ras_exit(void) { }
-static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
+				  void __iomem *ras_base)
 {
 	return false;
 }
 static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport) { }
-static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
+static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
+				      void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 02c791f149270..e99dcd028b738 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -227,20 +227,19 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
 
 void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
 {
-	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
 	void __iomem *ras_base = to_ras_base(port, dport);
 
 	if (!ras_base)
 		panic("CXL: UCE with unmapped RAS registers");
 
-	if (cxl_handle_ras(dev, ras_base))
+	if (cxl_handle_ras(port, dport, ras_base))
 		panic("CXL cachemem error");
 
 	dev_dbg(&pdev->dev,
 		"CXL UCE signaled but no CXL RAS status bits set\n");
 }
 
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -252,10 +251,12 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		if (is_cxl_memdev(dev))
-			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		if (is_cxl_endpoint(port))
+			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
+		else if (dport)
+			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
 		else
-			trace_cxl_port_aer_correctable_error(dev, status);
+			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
 	}
 }
 
@@ -280,7 +281,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	void __iomem *addr;
@@ -307,10 +308,12 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	if (is_cxl_memdev(dev))
-		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	if (is_cxl_endpoint(port))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
+	else if (dport)
+		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
 	else
-		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
 
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
@@ -344,7 +347,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * cache coherency is already lost; continuing risks silent
 		 * data corruption.
 		 */
-		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
+		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
 	}
 
 	/*
@@ -375,10 +378,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
 {
-	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
-
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
 	else
 		cxl_do_recovery(pdev, port, dport);
 }
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 285eed5b828b9..bc6cf50fcc926 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -123,7 +123,7 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 	 */
 	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
 		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
-		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
 	}
 
 	if (uncor_status) {
-- 
2.34.1

