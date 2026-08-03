Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AA345EA5;
	Mon,  3 Aug 2026 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795641; cv=fail; b=sKsCwKQT/C1RpzFme1AXn0lyVOCFTlwa0fIbFBKe+7ed7lgzAaJglKKZYYwdXwtUcKGKZFuHgcMxnmzUT/U1V+x2EZ2g+fcWk8x7mig15wRv/m064iyYfBQbtIJG5KzHYfl55l+88FQLqB+lRuGoQ8s0ZomsVNEbYoGRyQaJHoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795641; c=relaxed/simple;
	bh=9KLFh7p/sEq1BU8ZtMLvPyzqft8DSQfM+1NDsyA3M0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXpKCI+fX3BBB6DkwsP/AOeD/qSGmqZgNfAqfB1ZSIzKaP5uY7Brxunpk/vaVz4PRoWTq+igY7+unsnen3h4/w/q6yCiCevG1A/wBEblno9JOru0pLiWATKmhKXejDKLO5MHefQxHEHN27FZfcuYR9ksrRJwQmvvBNQ3cCo/6X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KBubbqnf; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBubbqnf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVizQSm7dd4rHB5B22bzzwAnCrWmzYN/DlxjbmyskvmAB5oQwhNxHIp1XxpjHLU9XsrI5g/6D8laMTZEKt3WUk2adsRCSo16S4y2/2VuosEV4Gp3m7//MGwhCTWD+vj7ZksOh1g6vN/XSueDFOJ4avkYffafHMQKown8rpVcfOCeQKTkG8cDwt7nJ1z5daXVzDjFlJeqn+dvToQxarYPYuX5c1UoYPGYWcpPVOzSWjYnsdzxiJ8lh4H2G/6ydwq8ddfzNQVO0iNY+JiPAbmGfKSVvbnicwObDYHbu7lVi4sWeLK82Xg1L+YwLJymmtUrs1FlTqP68UrgFp+2LxC52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFxMBEzX5jZ5ANDP+TLyVAt8covHoCMmpOv9vW6LUyc=;
 b=VtToZOACx2FPvnnewUBapxtxJtFl2dHKU4DlktEU8Z5otW3GoqxKiWf+4RMa0e5d7rL9cjeZhs89uVjHnGaMV9uKJnvCbw3J1FTz6lfN+1sT/hhlAKBNA4ryNUnTH6mrex1+qSqa95Yixmj7qLsKv0Lar4ZznH5qZjnG2C+zx1X+FlyBb5EOaaXG/v7vqjchlzat7RUdWgM31YkqCuZrcgHbXFsSjoLi/H9jgrQyTsqDkEbakNuOBjqUyEG2jJmwmnVtAYw3q/tVs8Kk5A1RcZF2yRXYwL7BMxCt2m9+lhx8x4o6QpLUYS3GV0Tyq7avOllR1af5O6UXtw+IMEV41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFxMBEzX5jZ5ANDP+TLyVAt8covHoCMmpOv9vW6LUyc=;
 b=KBubbqnfkNuvmtv9zShZRKTxtJK1iVG0JZy5RT/Z8w32BrbghbreiO0ElqMtmf32eW8BRx6U6lK6GVjGpHtic88nMAB+Gc5KtAOjUjc5TXYgv/Knbbwwozp7vdyoZfOE8h2NlJlOiO6oPqrnEb3fK2DhdsYoUuZf2dq2YNTpog8=
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:20:31 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::8d) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 22:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:20:31 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:20:30 -0500
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
Subject: [PATCH v19 12/14] cxl: Add port and dport identifiers to CXL AER trace events
Date: Mon, 3 Aug 2026 17:18:08 -0500
Message-ID: <20260803221810.3685703-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e891324-3411-44d2-6996-08def1ad6e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HK0oDUvyC7oKAbxSYf+8zyixwc8KqUykwTIVLo5/gvUuvZ1XYfq0q1hJnQPCQypBpA1eh8N2sKev4CgPGUq34uPmKTaYGgjM/JIxCAG3XACIAMWyJZ9KlPblLmjc3HGOFjaT2ExkJ/54EnInqQ53Fj7bXB8hnUyvf74+VEJMYUuL9Uez1QEO4e84X6Qki6RMgLcfnb0yew3nuL+bANwr2pYxghlnXWaz2lDHCrtxnqK+5p6xntb8NKLNI1uwx7Cr1rmf/DZjNHtbkYGOot6QfMq2FLVU9U9DdninAfgmPAnnLAS0m+4EcCNlbXfguZb2xVVGS9i5ZsgUHKJpAFxjZX7x+D5HkGTj/Wjwjx3JY1XFHZgCChinpzeWrdBpDYcAH0A08PwuUcc7boiUSEY+uj14G108IGsmEdPB1jGO8YEIFDoNrf3Paa3U+QPcEXZhpHmjoyGdvRFaWwG8ef5ckaYK486V2xwEJrTunrSWtUyV0Z2fsufEenrCR5nh0uFNlKVObVTBNppjFRosQG/VzX9SU3bYCvgbbOnqWmqQUKGXBwhiKrEVid4RzKit8QnIyhwjTYeI5crQLc6bTgtPElLs26TFgCG3OGGINPZDc2C5aLW5baK5N31v4F7BNgYuKaMOoGdjrJ6Q8gmkdiqQ8W57YkaccvfJK+ERG9BCA95dqU3zSr3lYLTycn7xr7XKM6/kbLF6mwMv3354E3onSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	23ahP7f1c5aZv00T00uCKO+nnba1oY3W6O2YcvYLJQzf/yhi4Fs9hJlVbiNhCrOjc3I6wTU/Hjol9XgMaj8uLsttQ8KeYtysrrO8vz5T9X8SeDUSJGK71wC2uRM3iPO4MSOpmQVQtiwzOO47iK+agZyOHXxDC2gHxxyCEA2xnS3w7kwKLqPiBplH/QKGS+ykQOP+udYOjGkJYJpuyUv8DnURkiLe+3NoBPVgM3na4YalBK9Ej0dfMuJav5dkR2v83xNL1LmCEufuYJ/dhD/43gpfp+OVrzg9Fp83+28cyALSPIaBzJtUHVjlYcFjuzNj20AZmImhe3yu9S17QHnNALv5s/CJi3+d9dCXmDh+BUDy5eVFcUHWLNVHaH9aoiNv5tHE/9CGsFku1Szhk8OO+n28pnr3ojBWNxZmoM/bVVw2dHqEtboBttP32JM/8g9n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:20:31.2241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e891324-3411-44d2-6996-08def1ad6e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

From: Dan Williams <djbw@kernel.org>

Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_*
trace events instead of a plain struct device * derived at the
caller. The trace event helpers then derive the right strings for
Endpoints, Switch Ports, Root Ports, and RCH Downstream Ports
consistently across the CPER and native AER paths.

The unified cxl_aer_* events keep "memdev" as the legacy field
(endpoint events populate it with the memdev name; non-endpoint
events emit memdev="") and add new "port" and "dport" string fields
populated for all CXL device classes. Updated userspace can key
off "port" and "dport" without a parallel set of events.

Remove the separate cxl_port_aer_uncorrectable_error and
cxl_port_aer_correctable_error trace events. All CXL AER events now
use the unified cxl_aer_* events with port and dport fields.

Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and
the unified trace helpers, replacing the per-port-type branching and
bus_find_device() memdev lookup.

The TP_printk format string places "port=%s dport=%s" between
"memdev=%s" and "host=%s", changing the text-mode field order from
the pre-patch output. This does not affect consumers such as
rasdaemon that use libtraceevent to parse fields by name rather than
by fixed text position.

For non-Endpoint events (Switch Port, Root Port, RCH Dport),
"memdev" is empty and "port"/"dport" carry the topology information.

Below are examples of the different CXL devices' error trace logs
after this patch:

     ---------------------
     | CXL RP - 0C:00.0  |
     ---------------------
               |
     ---------------------
     | CXL USP - 0D:00.0 |
     ---------------------
               |
     --------------------
     | CXL DSP - 0E:00.0 |
     --------------------
               |
     ---------------------
     | CXL EP - 0F:00.0  |
     ---------------------

Root Port:
cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 \
   host=pci0000:0c serial=0: status: 'Memory Data ECC Error'

cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 \
   host=pci0000:0c serial=0: status: 'Cache Address Parity Error'  \
   first_error: 'Cache Address Parity Error'

Upstream Switch Port:
cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 \
   serial=0: status: 'Memory Data ECC Error'

UCE NA - Upstream Switch Port UCE's are handled in the portdrv driver's
PCI AER callbacks that are not CXL aware.

Downstream Switch Port:
cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 \
   host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'

cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 \
   host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' \
   first_error: 'Cache Address Parity Error'

Endpoint:
cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
   host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
   first_error: 'Cache Address Parity Error'

cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
   serial=0: status: 'Memory Data ECC Error'

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v18->v19:
- Drop redundant device lock in cxl_cper_handle_prot_err(); the port
  reference already keeps the object alive and no RAS iomap is accessed.
- Swap order in series with ("PCI: Cache PCI DSN into pci_dev->dsn during
  probe")
- Add review-by for DaveJ

Changes in v17->v18:
- Consolidate double find_cxl_port_by_dev() in cxl_cper_handle_prot_err()
- Add comment noting dport is NULL for Endpoint and Upstream Port devices
- Add cxl_trace_* helpers
- Add CPER refactor

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
 drivers/cxl/core/core.h    |   8 +--
 drivers/cxl/core/ras.c     | 129 +++++++++++--------------------------
 drivers/cxl/core/ras_rch.c |   3 +-
 drivers/cxl/core/trace.c   |  35 ++++++++++
 drivers/cxl/core/trace.h   |  91 ++++++++------------------
 drivers/cxl/cxlmem.h       |   7 ++
 6 files changed, 113 insertions(+), 160 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5ca1275fd8f35..a55a4e409feda 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -186,11 +186,11 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 void cxl_ras_init(void);
 void cxl_ras_exit(void);
 bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
-		    void __iomem *ras_base);
+		    void __iomem *ras_base, u64 serial);
 void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 		     struct cxl_dport *dport);
 void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
-			void __iomem *ras_base);
+			void __iomem *ras_base, u64 serial);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct pci_dev *pdev);
@@ -200,14 +200,14 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 static inline void cxl_ras_init(void) { }
 static inline void cxl_ras_exit(void) { }
 static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
-				  void __iomem *ras_base)
+				  void __iomem *ras_base, u64 serial)
 {
 	return false;
 }
 static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport) { }
 static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
-				      void __iomem *ras_base) { }
+				      void __iomem *ras_base, u64 serial) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 5183b3c532952..0254b7ec64c30 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -12,69 +12,37 @@
 static_assert(CXL_HEADERLOG_TRACE_SIZE_U32 == 128,
 	      "rasdaemon ABI requires exactly 128 u32s");
 
-static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
-					      struct cxl_ras_capability_regs ras_cap)
-{
-	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
-
-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
-}
-
-static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
-						struct cxl_ras_capability_regs ras_cap)
+static void cxl_cper_trace_uncorr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
+					   u64 serial, struct cxl_ras_capability_regs *ras_cap)
 {
 	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
-	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
 	u32 fe;
 
 	if (hweight32(status) > 1)
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   ras_cap.cap_control));
-	else
-		fe = status;
-
-	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe, hl);
-}
-
-static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
-					 struct cxl_ras_capability_regs ras_cap)
-{
-	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
-
-	trace_cxl_aer_correctable_error(cxlmd, status);
-}
-
-static void
-cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
-			       struct cxl_ras_capability_regs ras_cap)
-{
-	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
-	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
-	u32 fe;
-
-	if (hweight32(status) > 1)
-		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   ras_cap.cap_control));
+				   ras_cap->cap_control));
 	else
 		fe = status;
 
 	/*
-	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
+	 * ras_cap->header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
 	 * dwords. Copy them into the front of a zero-filled
 	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
 	 * event memcpy sees a full 512-byte source and the userspace ABI
 	 * (rasdaemon) is preserved.
 	 */
-	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
+	memcpy(hl, ras_cap->header_log, CXL_HEADERLOG_SIZE);
+	trace_cxl_aer_uncorrectable_error(port, dport, status, fe,
+					  hl, serial);
 }
 
-static int match_memdev_by_parent(struct device *dev, const void *uport)
+static void cxl_cper_trace_corr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
+					 u64 serial, struct cxl_ras_capability_regs *ras_cap)
 {
-	if (is_cxl_memdev(dev) && dev->parent == uport)
-		return 1;
-	return 0;
+	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
+
+	trace_cxl_aer_correctable_error(port, dport, status, serial);
 }
 
 /**
@@ -108,44 +76,32 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
 
 void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
+	struct cxl_dport *dport;
 	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
 				       data->prot_err.agent_addr.function);
-	struct pci_dev *pdev __free(pci_dev_put) =
-		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
-					    data->prot_err.agent_addr.bus,
-					    devfn);
-	struct cxl_memdev *cxlmd;
-	int port_type;
-
-	if (!pdev)
-		return;
-
-	port_type = pci_pcie_type(pdev);
-	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
-	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    port_type == PCI_EXP_TYPE_UPSTREAM) {
-		if (data->severity == AER_CORRECTABLE)
-			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
-		else
-			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
-
+	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
+		data->prot_err.agent_addr.segment, data->prot_err.agent_addr.bus, devfn);
+	if (!pdev) {
+		pr_err_ratelimited("Failed to find CPER device in CXL topology\n");
 		return;
 	}
 
-	guard(device)(&pdev->dev);
-	if (!pdev->dev.driver)
+	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, NULL);
+	if (!port) {
+		dev_err_ratelimited(&pdev->dev,
+				    "Failed to find parent port device in CXL topology\n");
 		return;
+	}
 
-	struct device *mem_dev __free(put_device) = bus_find_device(
-		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
-	if (!mem_dev)
-		return;
+	/* dport is NULL for Endpoint and Upstream Port devices */
+	dport = cxl_find_dport_by_dev(port, &pdev->dev);
 
-	cxlmd = to_cxl_memdev(mem_dev);
 	if (data->severity == AER_CORRECTABLE)
-		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
+		cxl_cper_trace_corr_prot_err(port, dport, pdev->dsn,
+					     &data->ras_cap);
 	else
-		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
+		cxl_cper_trace_uncorr_prot_err(port, dport, pdev->dsn,
+					       &data->ras_cap);
 }
 EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
 
@@ -232,14 +188,15 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
 	if (!ras_base)
 		panic("CXL: UCE with unmapped RAS registers");
 
-	if (cxl_handle_ras(port, dport, ras_base))
+	if (cxl_handle_ras(port, dport, ras_base, pdev->dsn))
 		panic("CXL cachemem error");
 
 	dev_dbg(&pdev->dev,
 		"CXL UCE signaled but no CXL RAS status bits set\n");
 }
 
-void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
+			void __iomem *ras_base, u64 serial)
 {
 	void __iomem *addr;
 	u32 status;
@@ -251,12 +208,7 @@ void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __i
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		if (is_cxl_endpoint(port))
-			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
-		else if (dport)
-			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
-		else
-			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
+		trace_cxl_aer_correctable_error(port, dport, status, serial);
 	}
 }
 
@@ -281,7 +233,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
+		    void __iomem *ras_base, u64 serial)
 {
 	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	void __iomem *addr;
@@ -308,12 +261,7 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
 	}
 
 	header_log_copy(ras_base, hl);
-	if (is_cxl_endpoint(port))
-		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
-	else if (dport)
-		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
-	else
-		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(port, dport, status, fe, hl, serial);
 
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
@@ -354,7 +302,8 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 		 * cases below handle AER recovery for devices without active
 		 * CXL.mem traffic.
 		 */
-		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
+		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
+				    pdev->dsn);
 	}
 
 	/*
@@ -386,7 +335,7 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
 {
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport), pdev->dsn);
 	else
 		cxl_do_recovery(pdev, port, dport);
 }
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index a5c62c71060d9..a371174536a8b 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -113,7 +113,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 	 */
 	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
 		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
-		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport),
+			pdev->dsn);
 	}
 
 	if (aer_regs.uncor_status & ~aer_regs.uncor_mask) {
diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
index 7f2a9dd0d0e3f..df42d119c53dd 100644
--- a/drivers/cxl/core/trace.c
+++ b/drivers/cxl/core/trace.c
@@ -2,7 +2,42 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
 #include <cxl.h>
+#include <cxlmem.h>
 #include "core.h"
 
+const char *cxl_trace_memdev_name(struct cxl_port *port)
+{
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		return dev_name(&cxlmd->dev);
+	}
+
+	return "";
+}
+
+const char *cxl_trace_host_name(struct cxl_port *port)
+{
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		return dev_name(cxlmd->dev.parent);
+	}
+
+	return dev_name(port->uport_dev);
+}
+
+const char *cxl_trace_port_name(struct cxl_port *port)
+{
+	return dev_name(&port->dev);
+}
+
+const char *cxl_trace_dport_name(struct cxl_dport *dport)
+{
+	if (dport)
+		return dev_name(dport->dport_dev);
+	return "";
+}
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index d37876096dd7c..910aceb2ca3ab 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,44 +48,15 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
-TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-		__entry->first_error = fe;
-		/*
-		 * Embed headerlog data for user app retrieval and parsing,
-		 * but no need to print in the trace buffer. Only
-		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
-		 * the remaining entries preserve the 512-byte ABI layout
-		 * rasdaemon depends on and are zero-filled by the caller.
-		 */
-		memcpy(__entry->header_log, hl,
-			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
-	),
-	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
-		  __get_str(device), __get_str(host),
-		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
-	)
-);
-
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
+	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
+		 u32 status, u32 fe, u32 *hl, u64 serial),
+	TP_ARGS(port, dport, status, fe, hl, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, cxl_trace_memdev_name(port))
+		__string(port, cxl_trace_port_name(port))
+		__string(dport, cxl_trace_dport_name(dport))
+		__string(host, cxl_trace_host_name(port))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
@@ -93,8 +64,10 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
+		__assign_str(port);
+		__assign_str(dport);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -107,8 +80,9 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		memcpy(__entry->header_log, hl,
 			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
+		  __get_str(memdev), __get_str(port), __get_str(dport),
+		  __get_str(host), __entry->serial,
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
 	)
@@ -132,42 +106,29 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
-TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
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
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
+	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
+		 u32 status, u64 serial),
+	TP_ARGS(port, dport, status, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, cxl_trace_memdev_name(port))
+		__string(port, cxl_trace_port_name(port))
+		__string(dport, cxl_trace_dport_name(dport))
+		__string(host, cxl_trace_host_name(port))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
+		__assign_str(port);
+		__assign_str(dport);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s'",
+		  __get_str(memdev), __get_str(port), __get_str(dport),
+		  __get_str(host), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ed419d0c59f2f..f1ef8b78db18a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -125,6 +125,13 @@ static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 #endif
 
 struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
+
+/* trace-event helpers */
+const char *cxl_trace_memdev_name(struct cxl_port *port);
+const char *cxl_trace_host_name(struct cxl_port *port);
+const char *cxl_trace_port_name(struct cxl_port *port);
+const char *cxl_trace_dport_name(struct cxl_dport *dport);
+
 struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 					 const struct cxl_memdev_attach *attach);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
-- 
2.34.1

