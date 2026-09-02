Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE9480335;
	Wed,  2 Sep 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356451; cv=fail; b=h0z7upCIkuk4d0TuckvgNGgEsBXam9JD/HynjjoFeiDsajpirH/bBzqAPuZszNWYdj2dNMu3CLKW2sklGzV2DvtE99gU+3P2lAplI80ShUc7C6a7MzgSpYb8RChpL8UhwqmQz25hqBuOOCJ/SYMD4ft459EIol51zd/WsS0PUL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356451; c=relaxed/simple;
	bh=0E3fUgo4UILLzzBl1wzkw3wIBUlgvbSrgQTo0NdRkFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m68LnD4O19bZQN58EGwCZhDI0UGJVpvmsSLZ3f6Q4+j90GqbRgnMt+hU92CzU7KOWHTRyoe9uOndBYmxNJ+7wYkRKKHpFzh3kMRO/O5PcaRkhaLxOlU5J0T1OaBryheWsS0uvix8NIcOj/q6P/LzU6a9+p/uGTy4gc/CPpVnH0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A9HAC2+M; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A9HAC2+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3jnntm4K1h1DFX3tvyNt0afXnJ5bMjusFyn2TJPA8zZTy4KOpF07AGFPGYGJRi9/3nRp5O0qbZMGfeuIG1Vg6fXuzH18lZx6Z9fpf1y5EMqSP9Kddz8NdB0+nb6FOUH0HBrCw5FEfLkM11LqmhgASIuajrSW3OgPZSM37wzgbau0MqcmLOkSE35b7EXSp59WL/B/CnjtUO5UBg6HqyCSyQ4WS2d9qjly4XKZK/p42hT1RLZpEqP3AAUEj7ZjQY9vBdRGo+W6cx1z5hjc0YH0RUMc0Cql6lr667SSQ+T3IKLXMjDODhboF50JhKDYYV6HBOqgqX8rZOnPXFjR+XLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeqOLmrD0A/xnMlkQaocsmiaj/1160e/IVDxcDaExaA=;
 b=Rp6MX6OmW6jB49JAsUmtu5tPhRPYVJ3lWdXuNXNrb5LUTA3ML9c4coVn40pEDKpXzBzQcDQ3FSrQzNdZCVtJZ+D4f02FzFEiBcXK6egB9cRyX5fNcn11mGDoygkntGNppHV6APP5Zz2CQcPNo6FcVpXs3W/fAlYB1F6NW46Y0r1FtnCoHzHCrIDimfOzqgGxtdtGNt7XZfUJhDxJpwvjbO+mvtYfrmBZVSl5PDIRse0cAhMVXZM3Kii9jG/CZTjBW7CnigkagEGBOUH97GptXNffXOqwO+SZzhAuGitJxFRmad43D+QkNBoOUBdHCF1oYbR7BQxwEg23zoplpbNAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeqOLmrD0A/xnMlkQaocsmiaj/1160e/IVDxcDaExaA=;
 b=A9HAC2+Mn4DTB256jAOSMfCPgGxrizbXsPZUrsC+MsW1nCkIm+v4zArRrhxnHivTHpzQW4sesS+Ls4kWmmrUwbjmPK8oxiyfLZ0NFXfH8JxFn+FR4ZBOCSoh8f8MTKzQeDpHQ39wjYE1EoFCCQI5iz0u9z+m2y/uwv+A7Ai740o=
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 2 Sep
 2026 13:40:43 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:40:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:40:40 -0500
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
Subject: [PATCH v20 5/9] cxl: Update CXL Endpoint AER handler
Date: Wed, 2 Sep 2026 08:39:29 -0500
Message-ID: <20260902133933.2992457-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 98168189-e5cf-4181-db95-08df08f7c846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|23010399003|921020|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FLtbMEatAcCFCHxZd9kFoXlMUrq+kYcV2gTNCLwQZzM32sc5w5PaYuNZ4Yzr5nINOlYQ6JgZ//3YkkK3KbUhZCjQM2NqPbGa4HZgZpjSPmyZ4ZLgPnY25yvvUspvKMmzmZFCtgLN0reTMaKKKoRPBlZ4RmbRqeqeEjfdVz6jPFHzbbU83DC4ouzrI6FQ5MHilgTwKk+bs9LVtDKVGAnKZ3tFESp3Fis3Oxxe+q/sYjBMCI32dGqAZzXecHo/9dUkB4dEqSrklZimoPj6g8r8Y+kwEHgdWpXGXoltQZMdUTW894O/4fUiGXBjEIc6fplUN8Og3QUn3ZwlNKnN/FRMhlx1tXcm4Nneks23eOssfFJeaEpEkIIK6e6dwndXE2ut38L6uYoLSyT/lMP5cQMRz1avo/4FqnuuePCbC+9/gjA9AtWixydRSKcpG9bwsJeokp3E8wUUzELbbzKy53NNJHHyhGtmQbAX62N9BHmzkP6p/LmHLyVZ+9J5dfhmm/4yzTlSeaNKiRV7/BgKWUtSFbrIbcoHPv7+oj3k/d+OmeOpyCMlQbrp4NBltcyT16RkBoGhE+Pmp+J+nnmpQxlV+48VAOoa5b5EmCdeIxo0Ex2kQPYgByzkroNkTKTw9ztkd2ef7ntzZFxDr4JMUAwrOWblS93SRauMn/Hw9NN4T4xTwJGszwocdScAGONSRuxR8Jby+U1sbzUCMqReo82cOWdrAMze0hG4joxF7FbBW8qUeoKzkflPxnjzw4d5Rc9P
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(23010399003)(921020)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QjC6tyxNVNYoP4XardnhngV/8EwVeEj43b0pWDvrGYIwukYEBataGW8TI451/NRVFF/G1ST2ulY4JsZTDNEb4F79EVemk91Bi0CSVCnHi/ImVPiT381gvYz08EuydCi1pkZhnWtH/3n73/knbPjBqppEwUevyKGLo9FI0ysmWXDvApfR+/gk99dUYg7kU3x8CJGd8pEiWYjTP1+FUwuGWXcXFmqspnqa5bBlH7ANHSBBYw8zvh85f6TXe5Y9sqV4cpRbMlSG6GXvadsB3ZktSN1oy++UUsnwSRhAzn+44XOZ/VXwyaFz7JwMcHHFAluHhjtmhZ7O7EMmPeR7G0ptAuyyOhZqFZUueTzxovOMRF+GVJqfpRSkTs7sutMjynyclPaCzWmnjdivypCdYFA958J8pzoFjlnU8eDNLG5zw/qJgFKKU/BxZy01I5UeFwMf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:40:41.8671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98168189-e5cf-4181-db95-08df08f7c846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198

Rename cxl_error_detected() to cxl_pci_error_detected() and rename the
struct pci_error_handlers instance from cxl_error_handlers to
cxl_pci_error_handlers for consistency with the cxl_pci_ prefix used by
the renamed handler and the rest of the PCI-facing entry points.

Document the unconditional CXL RAS read policy: on a dead link, readl()
returns 0xFFFFFFFF which is interpreted as UCE bits set and triggers a
panic. If RAS registers are not mapped the read is skipped and the
frozen/perm_failure switch cases defer to AER recovery for devices
without active CXL.mem traffic.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

---

Changes in v19->v20:
- Expand the comment block in cxl_pci_error_detected().
- Clarify commit message's first paragraph. cxl_error_handlers is a variable
- Clarify AER handling in cxl_pci_error_detected() block comment

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
- Rename pci_error_handlers struct instance to cxl_pci_error_handlers for
  cxl_pci_ naming consistency.
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
 drivers/cxl/core/ras.c | 25 ++++++++++++++++---------
 drivers/cxl/cxlpci.h   |  8 ++++----
 drivers/cxl/pci.c      |  6 +++---
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index e99dcd028b738..bf479fac08565 100644
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
@@ -341,11 +341,18 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		}
 
 		/*
-		 * The CXL RAS read is unconditional regardless of channel
-		 * state. Any uncorrectable error bit set in the CXL RAS
-		 * status register triggers a panic below because CXL.mem
-		 * cache coherency is already lost; continuing risks silent
-		 * data corruption.
+		 * The CXL RAS uncorrectable status is the only signal here
+		 * that the error is a CXL internal (protocol) error. A set
+		 * UCE bit confirms it and triggers the panic below. On a dead
+		 * link readl() returns 0xFFFFFFFF, which sets all UCE bits and
+		 * triggers the panic intentionally.
+		 *
+		 * If RAS is not mapped the read is skipped. Unlike
+		 * cxl_do_recovery(), which is reached only after
+		 * is_aer_internal_error() has already confirmed a CXL internal
+		 * UCE, this path has no such confirmation, so an unmapped RAS
+		 * block cannot attribute the error to CXL and must not panic.
+		 * The switch cases below then handle AER recovery.
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
index 606fadd2476f3..7421132899fc4 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -79,13 +79,13 @@ struct cxl_dev_state;
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
index fe11be7fd9aab..1e7be77ded634 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -998,8 +998,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers cxl_pci_error_handlers = {
+	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.reset_done	= cxl_reset_done,
@@ -1009,7 +1009,7 @@ static struct pci_driver cxl_pci_driver = {
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

