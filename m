Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30F345EC4;
	Mon,  3 Aug 2026 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795518; cv=fail; b=VwkfpJLRslT2allpWKd0PYfT1v6JqEaWO/GO6yvTwFZ9/DQ1PRlIEZ1ByedgOmRmjANqIC70IetgayF03ZZDTWBbM+BlSCbj4dNc2E+o2pGP2zYHOkbqQtWgjhf6bknDMiBcOI/0oRLAHksUHzFUCI0pKJ4qNxGzmIk2Yk8BSNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795518; c=relaxed/simple;
	bh=YangYTUsbKCKLiVy0ZEi/vmMGnqlWaj3K6dcdQHdX4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bq6+mxrqJheNGGCIVJZ0VIFQ3SswRtBIg278e1Mek2SFYh7+a8cbZGgae/vIbkEhO5J9ClsyMBcbpsSeVTQ/Bp4XeQJBbxUR17lqovJtstiYbdQPntN40FeC6CGa+eI+wcREp+63FEx1D7Dn5jAy3oDqwMI2QpTDry5wqSfq7cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SOEL+vzY; arc=fail smtp.client-ip=52.101.53.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SOEL+vzY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFDztFNSo2F+776ch1wZb/xEjk9Cw8pFkfHxdxlJuA0MdvscPo0UsZmpxv1NbAQNbBrLr2Wc+TpZmf06huUuzvQ7kMihUjKtiv4oxqtTATzrMUV3sQn9392Ux4Tfn1MV4wfbpdLpkoUq9uhHW8hl7Pe2H2Mw57CQojFaAee0H1QtPaK5m1fK2gBLtSzAvix8QleVieXvaXqffZF4KI82DkSWFnO8G0DL/otPghs6Di7iLQ1GcEIhe1vPKj7djC+KR7VroniHXeoFPAn3AtjumlPHOV/IYuYCorkczXJuCNdBV8EY2EQnlHAOnpxoahWMDOjn8IhIeetIL+9h89j8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O6zKQrvEitkuZdwVZc9iZXkjlU8/y17cEgX7BXqfz8=;
 b=ORE5ezbl8VoeKioboeiKMMO265HBt82cWNPydS+or2PbuDmC1UD1DkjB1tvIi8iatc+TzKzj4JR7vWp6YMOBqYau8t4xjLbpprWjzzNoj9Bef9xrE7YUWCvwkg0oWj6VsJUHO4skYyb2SjvOeXTexcclT/Lbu8YLI/wMorB59sk0jguuMoSvpjQGsh1z86ZIZ8YX3SEb8hhnrpcj8eJBZYcD9vzI5Nu9IPhAxEoRvXSwhBnASfCr6Ao+UKGiVj4094AJAyC5w+oCkDCf0ez2xo7zE4SeN5Hf7u9SGijScw99uUYVbyrA+SCJ+PeIq+3/qBYSq5z9qAtqJt1oQ7yfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O6zKQrvEitkuZdwVZc9iZXkjlU8/y17cEgX7BXqfz8=;
 b=SOEL+vzYeI7DzDK/IoAtOqJqk9fpFhLnVbP8KtZMM5GGKHTpYnTmJ9K1EHwcoduN6/duH7WQTEox+E5Typ4evuMG88Yted6rf3JhbgF/rwn06MuyiQyVCmnT9oXg0CGWBSiZfkS1bL53tupFtlKHsZAfJJjsZq5mH9p4fDW/wkQ=
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Mon, 3 Aug 2026 22:18:28 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::69) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 22:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:18:27 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:18:26 -0500
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
Subject: [PATCH v19 01/14] cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read
Date: Mon, 3 Aug 2026 17:17:57 -0500
Message-ID: <20260803221810.3685703-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 74843111-3eff-466a-83ac-08def1ad24b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nP/dPD0f0Mt+hyJLkp6uNmLX/qDbS8D8Vgo+iD94oAqTRBmTAQkFIQY7LE3fT24CFBoZA0Bg4Azb1TmTaZVO5P82s52rNMvH8a6EK3Nq/gNriyb9XmP/Q1OW2epPXYwAEgMWfe8l3ScBD/uzY33V/szRI7MRTAahLryKXWw1rsq70uBz6fB4LErmPxgrPLGr4xcoTJSUKgRZJA96YfxjwACFRoYOX1P5U6/6WInnVqLAYCSQsf+ty3dZ0UQ9ReG2n0NZC8lLaSn949WhOCp8f5sLhTw4+G+zvbU8YxQFdze64u7poieOhGJ1xGzJyrj7bjRnTZbPsS6w2YxtUFce2KOyOX2mqNXLPPTlsDN0DWu79S0P8Fa/MZTJiLT1zSeCG/JIcco1oMTexvyoa9rsuAPSG/Ckj4DuAuvTXbUeaNCPugdPO93aa5bR7WrJQAMHZV69SaDSH+uVjj2xN3CzRvx1l2AfteujU44U9dZ3SQBK9y6GLLug7AfB1a3bgePQEHEtZQPYUYef+DV9Fj+Qgzo8v6hxQvatOhe5aEZ1JPv3ampTHg12PbUkhC8AQTL+vKbRxjJ7OWtosy0vnfGVl8hWwAAg5KtZ51CErkmzkH0rx00guUVcC3L59hnVgK0EMzSTDazlckCP9fP46X/ReDsVFMv82V3tWDusTeD/4LSWsxnEzjToN9/BxAxK84wRO/TILknvN/PxVp1Pd4l/VQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pAhV3yqlodjbiLq7vHeX3a1xpw5CaSmrtXPxSZ7a7gH5CA7/EeiRROIgoGC6yXsxmYG31bBWTkUpbLJFDNyt2aZr62hBp5z39mytFMN35B7IGKOL05Lk4D5Z9AtuFoLjm6i2mAMZMUXqD09SFhFJSoq21WOniIxg8vxOmgrG5jNyimDWUBNSJaC5s3QBVESstkWU0TLehp5/uENEw5v1WE5mxxy7QtS++AQpwKDZhn7/bCcqZE3HMzlkWXvH02sDNx20U/B/opKy0y0TV9HYKIxnHRFC/ZK2zYLhi9TU6BXiwDP+JySy725N6ip3t93OC6MDqa1yik4KqgPY7mDmatCG+R6lSXBx0G1irT+8S11V6mWR677qINTJeZ5uixl5DQBx0TlcrfmHX+xWnoARojePj9Sn312zeaHWYGHg7eMvT1GpnVrqx38E3Pooeo/d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:18:27.9846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74843111-3eff-466a-83ac-08def1ad24b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

cxl_rch_get_aer_info() copies the RCH Downstream Port AER capability from
the RCRB MMIO block using a readl() loop bounded by sizeof(struct
aer_capability_regs). This struct is a software layout and its embedded
struct pcie_tlp_log is larger than the on-wire AER capability. As a
result the loop reads past the mapped AER register block.

The over-read also populates the software-only tail fields including
header_log.header_len. An out-of-range header_len passed to
pcie_print_tlp_log() can then loop past the header log buffer and cause
a second out-of-bounds read.

The read was correct when introduced, but struct pcie_tlp_log has since
grown (Header Log and TLP Prefix Log sizes, header_len and flit fields),
so sizeof(struct aer_capability_regs) no longer matches the physical AER
capability.

Bound the read to the physical AER registers, header through the 16 byte
Header Log. Zero the destination first so the software-only fields are
deterministic.

Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
Reported-by: Sashiko <sashiko@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v18 -> v19:
- New patch, split from "cxl/ras: Fix cxl_rch_get_aer_severity() wrong
  severity register". Addresses out-of-bounds RCRB MMIO read that
  Sashiko flagged against the combined v18 patch.
---
 drivers/cxl/core/ras_rch.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 0a8b3b9b63884..8a3965edaa12c 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -58,13 +58,28 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 static bool cxl_rch_get_aer_info(void __iomem *aer_base,
 				 struct aer_capability_regs *aer_regs)
 {
-	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	/*
+	 * Bound the copy to the physically-defined AER registers (header
+	 * through the 16-byte Header Log). struct aer_capability_regs is a
+	 * software layout whose embedded struct pcie_tlp_log is larger than
+	 * the on-wire AER capability; copying sizeof(*aer_regs) would
+	 * over-read the RCRB-mapped MMIO block.
+	 */
+	int read_cnt = (PCI_ERR_HEADER_LOG + 16) / sizeof(u32);
 	u32 *aer_regs_buf = (u32 *)aer_regs;
 	int n;
 
 	if (!aer_base)
 		return false;
 
+	/*
+	 * Zero the destination so the software-only tail fields
+	 * (e.g. header_log.header_len) are deterministic rather than
+	 * left as uninitialized stack, which could drive a bogus loop
+	 * length in pcie_print_tlp_log().
+	 */
+	memset(aer_regs, 0, sizeof(*aer_regs));
+
 	/* Use readl() to guarantee 32-bit accesses */
 	for (n = 0; n < read_cnt; n++)
 		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
-- 
2.34.1

