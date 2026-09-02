Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96414481FC5;
	Wed,  2 Sep 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356478; cv=fail; b=XwffBENLMCVJY38Gxn/olNfzoeglqddXXFL+Oa6czNf+CAPglt0UEn6qcwbYUvfkR9uXf+6IV+Xb9LPWGdyd4TvX4+KiQh4uNLo7Gu0K5EIBpCSC4fZEU4lve9QyoTq5N0TG7HG0ekWUbQa8jVvuYYSy9vHhFN3ZMCAyEdERUyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356478; c=relaxed/simple;
	bh=GDdxPFdrKkOjQOWFZxlnUnOcpZEXoYNL/EvbbyVvpAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S58tk9bBcLtwxCsFHhM2+thBVnvoCC6isVCFP5O89BY7PysRSsQh9csRlkQXZ1+6Rp36i6HzKKjeG/sZ1goHidArkybLK6/pKShcfQHpG0yGbCbhhUgN15BLEQTQve8+XyOsuezDXPNHX0qleXaQzD1dbysbRqhjSSwvJzRUDaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ohQj/MH; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ohQj/MH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEwDu+RpZOIQSM4lCv+VH9HHE5qCAfCG65E94nDuOBupBU+tWqfYpYHxVfiXCMmfKyKZdtaWKUoDi4D1AJtVKyFg5quaVA4s9i3RM+4jlUiuC6BN1EFeGj/IZm02isL0eSZ8u4GT1P224FMBuCtrwfchy+0CABQGmIqTObVXnUPRhkegIzp8hgmzm3MyAcvwSc+l1ogtH+2oi0eD3bo7ZpqMvcEr7FeytCT0Bb9M9gfZjNqkbiJpMgL2MyjKeDvDETsfsNYtU5AtDRKpjmuJHxPPZnJNg6cO6UUwTcTNigmA31s3eh7KhQ84a+KFFUvpW92z+2zKaMtbjYFA5e174Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmUNXkaRLD/y+ZQvI/3gp2m8wRiQMQdKq3NJSRmUDO8=;
 b=AWzYkxrl/o9TPvI4LJ7d+cm2eZYV0N4bU1D9afCBIoIFM64FgGGUcuf0O2sg+OenaEpdsb20X/kVXerciSoBFda5aseMasAnAL7WxWvqK4JO3T0jMlzlHL/qB408dsPn6QM0/PXzBkDf28rpDnCvpHeNxClP+NJ3yEnwADkAz2E0cacWZ6G61hCBmvOF2XQiF5G8yXnMSD4f0cs/T1ahKUUvsBhcd/n+KGyPl31v64DGrMHaotZU60UBTONZQgfoiV0Z3YMNlDVYq0eEGwzYUA/uvwgaGrDS7jEFFVNWKlYnxuqfQPW404i1uzDKjCiGzdvQ/Ya3t+km3BB4XDZ9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmUNXkaRLD/y+ZQvI/3gp2m8wRiQMQdKq3NJSRmUDO8=;
 b=2ohQj/MHVli4BPaz2wRtIuGHXYRWjlSWYrdEnOqtns/P0hXuDA7qgblgQIdYK+tUll6y/Gc0Zwn754ynAoEcP0isw8jY/BYd9YJYeDYYRnAXdA1EoSfHjo1MIDXWEpiGCereVcZ68DdAAiyEndsxRPYTgM15pDTqWXCllZQZgLU=
Received: from SJ0PR03CA0070.namprd03.prod.outlook.com (2603:10b6:a03:331::15)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 13:41:05 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::97) by SJ0PR03CA0070.outlook.office365.com
 (2603:10b6:a03:331::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 13:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:41:04 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:41:03 -0500
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
Subject: [PATCH v20 7/9] cxl: Add port and dport identifiers to CXL AER trace events
Date: Wed, 2 Sep 2026 08:39:31 -0500
Message-ID: <20260902133933.2992457-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: d3909a1b-dcd2-4d43-9e0c-08df08f7d5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|7416014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	T4CkLUjVSeDeBKDNt2QQQHqKisKMV4OVXzdXmKSr2RbtvWOiyrpPxe0bZgAHv+k8Utnrp1gyc+qzy2pPScMHESjewGcTI4hcZ3EUjrXOPRo4ETNNP+ZAkPtaoduVi5617hbYcaMYHPlC2b2GGRqJ2pYhP2E22nNPnvfqVhrhQKG3DgE4iyTuXdOjYriRBLT/wiXW8GEyjqNv/Ac6EmGhQ+Vl/T7RpEqKTV0ljbBGZuAMrbrJ+C86QSg1BcT9gnccJss8YyqdFGu2s3LcyHsrjSvaeI06MzZZp7gLMFpmpanaKBXgoPUKxjovZfIXV/lLCi71zCWFADFKcgjEvcb81q7RxaHsK6v0mEOW+AJJ0WtUma7WduFzRAK5pQ7lon1vZpizQdKZ38RVj7gtiyUMHRafCXxBL6o1qT82RLigfPJ8wSF8typvqxigKHONVKreN6Gdvk1iEVJkPam73ASdVIXYS8v1CbNIIoZrDA+3cidoPsg8C0D4CZTSl89M6qxeAyHkCXqkQ+AfBd9EtrsYi7PsX8Zkt+Ht79Du/gNBheNQYdAC4TCaeyUEEoPNe6MbTrCv/pRhJB11ISj7arp3YxmE1F+92g5K6/ckFHk+RdQWb5NnS4J5gQvHQuYcPW3DWYKVqlHp8LRwTr4p5Idzv5hYOIpO/D6y5d8w7ijrvuzkTxYGuGJq/LSsJTsoUsaUcHbuQ43JdfjzlrdW2Irc2GGRU9wf8uceYpEW281aPqcLGb6Flq64H5cjyR5WX9Fk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iobgrCqMa49WZX3jU2LHpL2Slz+PSziXFclVNivgR8fWpe1SO0g0P9bLqFt/HuTIFeBjh+RBxROk8r7OinrxNC8tQyw//nre0AHXZxil8vC7f2q5uDEtrLs08lzYwAiO63gCzQ/vbKXyPU7fYxXiuRE1NcsnOItFu8Kd1FZ0uPSYppv47C1m0QN8n9rWgCkfRmht6ETl0RatwM34Kwz22G/s8DXNhMt/zQnecfQFVzSY7G46sUdBsTadxPYPiPZ+TxiL7QscCxcc2/t21b4TaH7y+sVdmS7A1KrIgjX059y0JSznNC0d9JO1SDqOuXfVpPzeTRTDdrfcTKFJfvpftiG9deSYtrfjaD8xCg2lnAIy5pw4w3RUgK77eaww+dKAOFpky/GXIu9tPqYStGpU0t/AMGoFKyVKtrT7EbwTiwUGMCd4aAvL9sz1B1WLiadq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:41:04.9188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3909a1b-dcd2-4d43-9e0c-08df08f7d5fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

From: Dan Williams <djbw@kernel.org>

Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_* trace events
instead of a plain struct device * derived at the caller. The trace event
helpers then derive the right strings for Endpoints, Switch Ports, Root
Ports, and RCH Downstream Ports consistently across the CPER and native AER
paths.

The unified cxl_aer_* events keep "memdev" as the legacy field (Endpoint
events populate it with the memdev name; non-Endpoint events emit
memdev="") and add new "port" and "dport" string fields populated for all
CXL device classes. Updated userspace can key off "port" and "dport"
without a parallel set of events.

Remove the separate cxl_port_aer_uncorrectable_error and
cxl_port_aer_correctable_error trace events. All CXL AER events now use the
unified cxl_aer_* events with port and dport fields.

Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and the
unified trace helpers, replacing the per-port-type branching and
bus_find_device() memdev lookup.

The TP_printk format string places "port=%s dport=%s" between "memdev=%s"
and "host=%s", changing the text-mode field order from the pre-patch output.
This does not affect consumers such as rasdaemon that use libtraceevent to
parse fields by name rather than by fixed text position.

For non-Endpoint events (Switch Port, Root Port, RCH Dport), "memdev" is
empty and "port"/"dport" carry the topology information.

CPER: trace firmware-supplied protocol errors even when the host device is
unbound; the record is self-contained in ras_cap and reads no MMIO. Keep
the host lock only to serialize the dport lookup against teardown.

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

RCH Downstream Port (RCD attached under a host bridge, no switch):
cxl_aer_correctable_error: memdev= port=root0 dport=pci0000:0c \
   host=pci0000:0c serial=0: status: 'Memory Data ECC Error'

cxl_aer_uncorrectable_error: memdev= port=root0 dport=pci0000:0c \
   host=pci0000:0c serial=0: status: 'Cache Address Parity Error' \
   first_error: 'Cache Address Parity Error'

For RCH topologies, both correctable and uncorrectable protocol errors
were previously traced against the memdev via the cxl_aer_* events with
memdev populated. They now emit memdev="" with the RCH Downstream Port
carried in the "dport" field (dport->dport_dev, the host bridge) and the
host bridge in "host". Consumers that keyed RCH errors off "memdev" must
key off "dport" instead.

Endpoint:
cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
   host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
   first_error: 'Cache Address Parity Error'

cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
   serial=0: status: 'Memory Data ECC Error'

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>

---

Changes in v19->v20:
- Remove host->driver gate. Not required for dev_name() call

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
 drivers/cxl/core/ras.c     | 137 +++++++++++++------------------------
 drivers/cxl/core/ras_rch.c |   3 +-
 drivers/cxl/core/trace.c   |  35 ++++++++++
 drivers/cxl/core/trace.h   |  91 +++++++-----------------
 drivers/cxl/cxlmem.h       |   7 ++
 6 files changed, 122 insertions(+), 159 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 4f6b4702deb38..5509521a2034d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -188,11 +188,11 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
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
@@ -202,14 +202,14 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
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
index bf479fac08565..fac37b6fd882f 100644
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
-{
-	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
-	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
-	u32 fe;
-
-	if (hweight32(status) > 1)
-		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
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
@@ -108,44 +76,42 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
 
 void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
+	struct cxl_dport *dport;
+	struct device *host;
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
+	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
+		data->prot_err.agent_addr.segment, data->prot_err.agent_addr.bus, devfn);
+	if (!pdev) {
+		pr_err_ratelimited("Failed to find CPER device in CXL topology\n");
 		return;
+	}
 
-	port_type = pci_pcie_type(pdev);
-	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
-	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    port_type == PCI_EXP_TYPE_UPSTREAM) {
-		if (data->severity == AER_CORRECTABLE)
-			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
-		else
-			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
-
+	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, NULL);
+	if (!port) {
+		dev_err_ratelimited(&pdev->dev,
+				    "Failed to find parent port device in CXL topology\n");
 		return;
 	}
 
-	guard(device)(&pdev->dev);
-	if (!pdev->dev.driver)
-		return;
+	host = is_cxl_root(port) ? port->uport_dev : &port->dev;
 
-	struct device *mem_dev __free(put_device) = bus_find_device(
-		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
-	if (!mem_dev)
-		return;
+	/*
+	 * Lock host to serialize the dport lookup/trace against dport teardown.
+	 * Don't gate on host->driver as the CPER record is FW provided and needs
+	 * no device MMIO.
+	 */
+	guard(device)(host);
+
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
 
@@ -232,14 +198,15 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
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
@@ -251,12 +218,7 @@ void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __i
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
 
@@ -281,7 +243,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
+		    void __iomem *ras_base, u64 serial)
 {
 	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	void __iomem *addr;
@@ -308,12 +271,7 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
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
 
@@ -354,7 +312,8 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 		 * block cannot attribute the error to CXL and must not panic.
 		 * The switch cases below then handle AER recovery.
 		 */
-		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
+		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
+				    pdev->dsn);
 	}
 
 	/*
@@ -386,7 +345,7 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
 {
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport), pdev->dsn);
 	else
 		cxl_do_recovery(pdev, port, dport);
 }
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index bc6cf50fcc926..3684d1d829e1e 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -123,7 +123,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 	 */
 	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
 		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
-		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport),
+				   pdev->dsn);
 	}
 
 	if (uncor_status) {
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
index c379d60047fc8..9f7fad8d77a54 100644
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
-	TP_printk("memdev=%s host=%s serial=%llu: status: '%s' first_error: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%llu: status: '%s' first_error: '%s'",
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
-	TP_printk("memdev=%s host=%s serial=%llu: status: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%llu: status: '%s'",
+		  __get_str(memdev), __get_str(port), __get_str(dport),
+		  __get_str(host), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06f..c6368ddae4a21 100644
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

