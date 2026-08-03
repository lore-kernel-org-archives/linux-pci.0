Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED9347BA7;
	Mon,  3 Aug 2026 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795605; cv=fail; b=cb74ut/9bKZhPr81JiXGRYP6UwNcBQS3oXLEBj4uL19pEUTUca/OVVlZGDd4BHKd0D0NuEQPOB5G6t0xcWck2w+uyXRkU4OGiVqioNpMm3zXzYCFvk26knVgiI+xcWO9/f+5o1YyaH0Lbw8HVfzkS3NzaoycrJbCV23upzXbg2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795605; c=relaxed/simple;
	bh=KgbrCxgkLDoHaoM9AeDZl1vTD300Pd8NFKLQMbMcZ4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRhn6wBjxuuZ07mAQ9R/NzpHZYddachB/v5UbLXIOhkgWmrPotyc6vw05zYXp3Bi3ZQRUb3KbqE9SR1/RK7/LNYFXFsaFOTC7dPFsYZgIAn1jJ7ypydeAEgOqJ+hJmYVUOGNrUr7AAAbTYlm8M5e4nQvLZYIh75INQRivMF4Bz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gerBfFsv; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gerBfFsv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNTAKa3e0cREjr1XAzfTfg/UlAc3AuN7k8JOTDDxOBnOJtDZp+XaHWpgrPHm9+qG3N0djqT5l80PF3QhpamYomWWrO+uff7awsbV7a/hIHoed2OTvwTZBDnf5/S3RqYxFvqM6+x6nqYY0Q8nZ3H9oM1iV6ucjYhJATaSBCTAMkiZRYpBctE1qWelmFozZTaF+RxHfjwlcW5nZKfFQzCB9cvdxbu605deL8m7imxwHBvsFL3sTTdHR5oFJ/zSYB77n29IoBkC+Cs4uiPBRX8AfYbXc7vWEsC/MbEo4CmZIFR74/3gZj5ogXsIhFUKpF6Xae9NCh2xZ9VRoXGPU7BU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL45Zw7LZ+Lj8QsvjqsPN5zouafqhrMpIBu/zd9HP+E=;
 b=kOnn9DiHbsK9BwGmG3C7Ftiy7kN5zbWiv1jgByNKdiaFC/xnTLff6uSNuoSFZNLao4jy1/z8ICQzCUY3LlazEvkPPeuAuFgawZKkxqvr98z2fRGidSsIkLhCinkWDtEv8SPO+KGFu+ZOot3FdZPqrF40oj4hLLZSM47nbqdNMj0RpLelNcIEUmsNRwjAdgAhwj59yJ66VtGF2RgChAreMcZeLxl6rM2kADep7UjhaFhAxFdbl1P+oCBtD2/QN9G8ra2M7tfP1JaPoQELCm+I0nWioLJ9cbT08Re54jH9OH2aUYkDDVDL5Cf0I5N0Z58ey45Rrk6tG+eLY3zxpqxihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL45Zw7LZ+Lj8QsvjqsPN5zouafqhrMpIBu/zd9HP+E=;
 b=gerBfFsvsnFlTYb1q0C1KUKLO5P0P945sFklbi8ie+/WzKDZACTKg+YQrDLdoAnF9cl7ERfyJ1z5R4YYcWoRc29wDlKcdcYvGbqvmq9x90hIdvG9sfZo4ZYoIYDoYCZQuU0oBkDf0j9XWHxsXWJudxvLIjf1bjNtC5PQ+76F8BI=
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:19:57 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::1) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 22:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:19:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:19:56 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 09/14] cxl/pci: Thread port and dport through RAS handling helpers
Date: Mon, 3 Aug 2026 17:18:05 -0500
Message-ID: <20260803221810.3685703-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803221810.3685703-1-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 886b62a4-27c2-41af-1343-08def1ad5a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Wn7ddWIYh9Nk731J8cgABFOkjMnsuo35Tqp7iaDpJlXGceWYxLjZQExIDjt7tZ18LorczcHi240W18XhjqWSlIE1/vtF+lRcsoklGL4CxChiRBKoAHyLgmGNNWjtSllMS2Qc/9fOoKv2xxwhsgIcV6k/LtQZBCa9dGp+3w0GK0aKH6VU9k8lmloLthNifnRrYuW/SesCxxm7TFuqxF2CdBaC0Q656Z/WmEspXQHharWHrzgMtmQxMgOqBW4P1cFhKdCkMOeO4PupqQtmgAqQY3Rm/VycGkQ3uJ6JLPFAts0KftNrkCm8X0EiR3pcGejLXy0yrz0BZNhQA2nrFo3rdvItt3VXIpMgsFOE7BjshRx7IBoRAURy8ggQmv6brZPBXmFNb21O+GdIDUKdLtEBIs1uh0Kgck9hdNKV4BEl94PaO8rbsTbs0JcIFvaYIeNKCDnA78y09itAgklmgw+8XAq+rk096xsOwBtHViqbHd9mDGB3fEyuRa11XBX8Wqwf4ycVNWquYt17m5U12ZZSKIMFoxj2ad0+K0zJ9zmCTHg31H1ir8dWVUjNpei40ux2Z7ugbn2terHplGxuaktGNEiBJIp1a9sE1pk6dYR+HWou6nPfOl+7Dd92cW3qXR2RV21hQETkPVST0J6Xr32x0Uzj4CrWJhwW9LBIEMgoJePfZmcvtbrfrHOjLjc9gpq5R4xHpOU5T9Cz2t1oicKdJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tZ0elJ2Z3iDDQZxN/ks4tpf49vZfEQtXoHw/ZhbFicG4lqbGwS5g9uf1QzV2AvvL7T5VvkkDyay7wN50VspdyFAW0uBqk5I9k1AuLltGevpusxh5OKFssAeVhVR7MjMYiedBwhMSYxPOJiM5TjWZk3MC7kf3IuhxJGOGhGXk/vaUCTzyNEId3omExWE5q+OP5GI1A9BKceFDr4Ad/OdX1tBri+by4q5Ck32H+PTqRIGpzBAyNYRIFkMjuZff+J1LcvXOtJXJoxNHwMEQHIPPvnUe8/CxRwYObEKxTvwzq5dtVQV5QI+u8UaF105A05yTprUqWKfCfo8R/2EyI6/PRgQ7JlMWKPSPIPo3vPn5lBEWZvEO0Fw+Yikid6FMSdd/KUnFkoz3lvXpYq8IvBv4MmWLg6EYzRm/DPYQR7+ML4eCKSOyZwNck5BIywrrBrir
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:19:57.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 886b62a4-27c2-41af-1343-08def1ad5a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540

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

---

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
index 272634ff2615b..5ca1275fd8f35 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -185,10 +185,12 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
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
@@ -197,13 +199,15 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
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
index 83df544e5a656..ff4fb016ed4a1 100644
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
index 6f95542e2e6a7..a5c62c71060d9 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -113,7 +113,7 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 	 */
 	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
 		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
-		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
 	}
 
 	if (aer_regs.uncor_status & ~aer_regs.uncor_mask) {
-- 
2.34.1

