Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8812749DC;
	Mon,  3 Aug 2026 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795625; cv=fail; b=gfBb69hz2TtQYioPta6+vweOqPZ1P9uwPpchmwoXXmjzH7F9GV5gi74bGa9JeDoaK6H9uvAH/gcax/dI8DG1hRs5kAPhkmIkl7Auwstvh6//JW8IsWwvP4sOM6AJBb3E7jfvNoNTxuQjUhxZq+iVLtc2Nw5Cc0R6gOQjf6eUZF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795625; c=relaxed/simple;
	bh=eBBnQ7kmzo0Gf7zZKJt3ZO75S9e1K4rHrBK3rPL8KCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvTDjG+NdisDZF2a7Z8tkmApKo11+6JJfKEsSPpja9teIdPysqhRpq6ZhCVOHH06Fmb8/Ijeg3I+yeajO1zaE/RyFqq4c1BRLEoKjwiZbSdtSO/Fb2P4Kfo2HXvUeCK7wylIKAzwEmxCB0lN6VfYT+GplotAJ5MHkHOspUuO5/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hlAavdx8; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hlAavdx8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sULMnY/6HGsbe5wv0KL8dWCp1R4qkvfKPuH2qdvqPXaWogWNnmOVnlmbXL4i/GnRBGIBoDQvj8hk+DqZGBOQBe4pa9vRvPN9e09zo9BmYXDKjh/RXHPgZfPM7MjGooG0fAkqIf8DZ7HNV5udkA18mD7ViCugQ8l/AsCSXStDG8yz+MYHEJUfnj7KCMOAhX1deQvcH6HpddFXJsnuqX0J7uAXV/+bHrZ5CrLDKbMFKDQCjF1VR1bITH/8IHek10A5uSIxEhwTVJJjLBwA6EdAiBSUnT8Za2mz9bMzojB8KyW0WnmCzA9f5zGx7eo7O/nvkLqNfrAJQ7BxC325t8uZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgFMzNInLdDhyCIN7y5E/JHIfKIf6ZRqZprikl4nYmg=;
 b=x3cR894wCrLd8MwBET9XiE2UQzkIW7w2AIBtp8nVxZE+txNW2ARnXvtinI3sp58SPHuV/X/KzBaRNFaseZi+5bHo36hySlEdh+lueX0FnhJCCR2OxgEOktcLr9UzVhQ24JN9++wla9zbwvE4N2yqlbMwOCWmOWLEpQw3pVjk/4J1Pa1xzxXCjn45fSIjNFkuah78v9HmtP3v3NGwWRMKyicQUB9GkKDYox7pheZNSSryZKfCa60t6C+ONBQ8dBhSQVEvnUOdRvWpH57DtOeC8zk8GUo7RKkDSoB5vpXpQoMafr85kUIMqWKyM8fBA3VrCcK1s/0+P4SbflNFQfx7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgFMzNInLdDhyCIN7y5E/JHIfKIf6ZRqZprikl4nYmg=;
 b=hlAavdx8a3+MEr1cHOMSCRtqWZBnn1I7Pia+5+ft6lUQPBlIH9UaFSVWggxuYiXV2b/Tk3uNfbRUos3A4Abla70vec9wGfHHzFohN4909JTtiCc12RStqMSCtukFLj/vNx54FItGjia1EGQnPDyOvsDqQfqPDfE9oJY5YUVg0/A=
Received: from MN2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:208:23b::29)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:20:10 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::7) by MN2PR11CA0024.outlook.office365.com
 (2603:10b6:208:23b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 22:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:20:09 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:20:07 -0500
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
Subject: [PATCH v19 10/14] cxl: Update CXL Endpoint AER handler
Date: Mon, 3 Aug 2026 17:18:06 -0500
Message-ID: <20260803221810.3685703-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ba5b8e-2ad3-4155-03f1-08def1ad6143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|23010399003|376014|82310400026|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SUFtxZKpXWN3zFXshWpwajohh3wGZeuBBEvPt85Y0QbZrzEcaIATxZjdmAhoVxiwBr9IKeS9ZVTBkJDl8KTdb1SEVcsIezecONADxPsenJV3V5rirfEzh80ZmEr3ia909xt/z7kKP3ImV2L0ikTfqf4LijgA/sGZ0ZUbvejHOdghM8n2/vMwFot//QP1kztXtBiXbprXa/VKJViWFw/dtJREQQe6iR9Md1U8HS4hE2i7HKK/SHcX7nAEsyb8LbdKzzipuUhGAhokUAxb7XGBGnhS36RqpY49xeUPzpGmRPfQzE1HSNQxYxWz5Qnt/ZpBBrnmU9bCZ8uXSbX5Q0lYLraEc04+txKjyuvxd2nLb3UYe0aIQSBzfcFjcHgfIctPfYa+/l9slO8BCwWtPbaGM/c1ev1pXsQcEWcSZXx4TRBnYexKsxnb/B4vYQG8teoEmDEl2HNgRn0vRdi9mwEm2c6cOV1fwaMNwX4SGUxFiaQqMM79O1WkHaUEqG+ew8FbzqQH/09uC69UTGft5LLQYoI47B/fNfYT2a7fSRbW+wB0BwfIMXdOolMOfU4dPQiIUfiqVvF9nergtL7w2xy5iVVsHF1XJnGjFAWJBqgAFbGiPqaWOejdB4U+aBbeDD39dFXQss7CPGG4M0GrJr3HEmBY2jhuRYVt6ZUjNNW8OktLbKydTKux7Gm2bl78uqHyIMaTWiMzkPpEbcYm4LKMCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fOpwq9zdGhQ+9EpmfRaSm9nPkrIymzf9vx+iE5iDiA5+rdiiJNObChwA5sTQBxcXm9Cz4QqlJge9+aut3VQNsgpVn3Phd5TeR0l9Lyq3txx7S4xoStP5lR6Faid0Bt4sU+x58wJRzBbom4t0iAf+HaKM1p1dYRmZrrTBR+cQjmvJc/G55XOC7wd9k5Y46F8gvTVIiaTm0d22oLYr1+4TVlyGqeH0Yc/o4+wMzS6gKx52osMY/BXSNJmIYyqtz5hCNVMe4YQ73lsEe9EP2dplEtmwoBQdh6i39jNRuJYuEUyp6YEHbyosq6xt5iUbu0D+8fxOzi1iPZCYR6JRqg38eGyrJF4Cm95JUFngtr2YPwjkXHktfH8sIJ6Pm5l3hUwu6xxtOnt86iKXZD3kyD9Y4WoR/rxBbju1e+JmNrYxSaldSuX3fdRHSatpOxvJqFDi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:20:09.6150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ba5b8e-2ad3-4155-03f1-08def1ad6143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060

Rename cxl_error_detected() to cxl_pci_error_detected() and rename
the struct pci_error_handlers instance to cxl_pci_error_handlers to
avoid shadowing the struct type tag.

Document the unconditional CXL RAS read policy: on a dead link,
readl() returns 0xFFFFFFFF which is interpreted as UCE bits set and
triggers a panic. If RAS registers are not mapped the read is
skipped and the frozen/perm_failure switch cases defer to AER
recovery for devices without active CXL.mem traffic.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---

Changes in v18->v19:
- Add review-by for DaveJ and Jonathan
- Remove reindent introduced in v18 at cxl_error_handlers definition.

Changes in v17->v18:
- Fix cxl_pci_error_detected() to use find_cxl_port_by_uport() and port->uport_dev
- Read CXL RAS unconditionally; panic on UCE regardless of channel state
- Document unconditional read policy and 0xFFFFFFFF behavior in comment
- Drop guard removal paragraph from commit message (not in this diff)
- Drop Reviewed-by tags pending re-review after message change

Changes in v16->v17:
- Rename pci_error_handlers struct instance to cxl_pci_error_handlers to
  avoid shadowing the struct type tag.
- Restore scoped_guard(device) and dev->driver check around AER read.
- NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
- Updated commit message. (Terry)
- Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
- Drop cxl_uncor_aer_present(), rely on AER state

Changes in v15->v16:
- Update commit message (DaveJ)
- s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
- cxl_uncor_aer_present(): Leave original result calculation based on
  if a UCE is present and the provided state (Terry)
- Add call to pci_print_aer(). AER fails to log because is upstream
  link (Terry)

Changes in v14->v15:
- Update commit message and title. Added Bjorn's ack.
- Move CE and UCE handling logic here

Changes in v13->v14:
- Add Dave Jiang's review-by
- Update commit message & headline (Bjorn)
- Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
  one line (Jonathan)
- Remove cxl_walk_port() (Dan)
- Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
  sufficient (Dan)
- Remove device_lock_if()
- Combined CE and UCE here (Terry)

Changes in v12->v13:
- Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
  patch (Terry)
- Remove EP case in cxl_get_ras_base(), not used. (Terry)
- Remove check for dport->dport_dev (Dave)
- Remove whitespace (Terry)

Changes in v11->v12:
- Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
  pci_to_cxl_dev()
- Change cxl_error_detected() -> cxl_cor_error_detected()
- Remove NULL variable assignments
- Replace bus_find_device() with find_cxl_port_by_uport() for upstream
  port searches.

Changes in v10->v11:
- None
---
 drivers/cxl/core/ras.c | 21 ++++++++++++++-------
 drivers/cxl/cxlpci.h   |  8 ++++----
 drivers/cxl/pci.c      |  6 +++---
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index ff4fb016ed4a1..5183b3c532952 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -61,7 +61,7 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 
 	/*
 	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
-	 * dwords.  Copy them into the front of a zero-filled
+	 * dwords. Copy them into the front of a zero-filled
 	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
 	 * event memcpy sees a full 512-byte source and the userspace ABI
 	 * (rasdaemon) is preserved.
@@ -320,8 +320,8 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
 	return true;
 }
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t state)
 {
 	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
 	bool ue = false;
@@ -343,9 +343,16 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		/*
 		 * The CXL RAS read is unconditional regardless of channel
 		 * state. Any uncorrectable error bit set in the CXL RAS
-		 * status register triggers a panic below because CXL.mem
-		 * cache coherency is already lost; continuing risks silent
-		 * data corruption.
+		 * status register triggers a panic because CXL.mem cache
+		 * coherency is already lost; continuing risks silent data
+		 * corruption.
+		 *
+		 * On a dead link readl() returns 0xFFFFFFFF which sets all
+		 * UCE bits and also triggers the panic - this is intentional.
+		 * If RAS registers are not mapped the read is skipped, the
+		 * panic is not reached, and the frozen/perm_failure switch
+		 * cases below handle AER recovery for devices without active
+		 * CXL.mem traffic.
 		 */
 		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
 	}
@@ -373,7 +380,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	}
 	return PCI_ERS_RESULT_NEED_RESET;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 06c46adcf0f6c..8aeb80a4e5732 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -89,13 +89,13 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
+static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+						      pci_channel_state_t state)
 {
 	return PCI_ERS_RESULT_NONE;
 }
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5c21db36073fe..46e60c53d3ca4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1000,8 +1000,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers cxl_pci_error_handlers = {
+	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.reset_done	= cxl_reset_done,
@@ -1011,7 +1011,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &cxl_pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1

