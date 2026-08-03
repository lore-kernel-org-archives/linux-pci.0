Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301F2749DC;
	Mon,  3 Aug 2026 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795547; cv=fail; b=kM8+72xO/y+u0nimlkoOHnLLR8xletB9NAJPtHGeaYECG7Mvr43VKg0Rc+ONAxWioEmuPMgLNFQYDR/RLsnrRyiFvmXSpfW7gobbo1FJLo3keKdbWYtAtUGxoodKpwzHM8+KbaDNPCuHSBHjJ8KPVtpl0/Fm7NTw17Ux22noOJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795547; c=relaxed/simple;
	bh=/gn8fcg66NSD2i0E/MV1Lsn29blnNjnPsN0TyIv9+bA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgxKYdlvjzItYJ9PSiUCiFDK/1in3SnsWoTt+LBM+9WgI8JGnFoJ5RNEHpmVtwrDez9tAwVALeltV719YHz0CBy0FXY8AzlIHUIyudq7OihxC6BX65DuH47M6b1qzwtuRKnhDFcgSKTiq3+pGeewgO8mkcCpYOV3FdQYSyRqW7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BiV6Jwsj; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BiV6Jwsj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvtrEc4ySjYA+OIfWfGdYY0nU+6NhZvD3buoo6CZ3GMesraPKOAtmk7v1zNq7lGjIjd8sHvBNYad5CT8OYOc/PlExsvk10BLTPFMn1/BZQTTOK/ydqerqsJE2SH8xtD8R5Nb9aJ0OliFfh2hCtm2XFW1ZxZcDWfTXdNf4ViEC+Cy9hTA7jOcuK3DVMYoPbe1wHxphznWS+tlViwADzz8X3N8FEuZaOOeywei0tYtIBbuXac10Ok+CIZVUj+Auqz+pHeUVuj/RYX+IbAI9e22U72nCwBZ/OxSqNgYwcLM7VZf3bYVgUVunC4UW9atmCkbP6VL3b+GuEv5VCkW4+X32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boZ125BRtRoAb9h7ORE6ptnzrsO8uxYBwHXb+sKf7Oc=;
 b=dnnY7Odw0/ZdgRcWV7qFJ4YsO/D6p4OMV/kkJ1btLw197tWz3I+c662WysuAOKx9KC5222YoZbrAfKNwxHPFijFuglbmCB4ikFmpkLV32cbfAZLxPN0rXPWDcET24i/xFBY56z22EWfeuVXGtpPvrLYV1nKS0QGw1OfHMe9ju/R9t2GiP/dRhzwOC2wk4jZrpLRT8EDbSvlm2jSJvMuTZjUALoTSQYk7DniIffCgthVtxHnhHlGHgc9gxX25uVpCiGM5rdb2KlwprFH8Csn2UBdHOltBVrjhN8Ds7ysY/DO+PCUcThEO6hNubh4AxfMXpBvG3luH/VO1NdDcMSkNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boZ125BRtRoAb9h7ORE6ptnzrsO8uxYBwHXb+sKf7Oc=;
 b=BiV6JwsjIaFsMpNbP+BN2UwEqxG96c9Jb+6gsXGpd5YSRevj85zJl3cve7XVqluBM7R4AUx6FslkDNddnLfg6/9xMDTQDvwfOeOU2da2METAVqcsEcD8TEqUfmLbKYT3BLEj4tWZHHnnNTOiC77BxvB07kVhbHQVSCmdE/rQ/Ek=
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 22:18:51 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::87) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 22:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:18:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:18:49 -0500
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
Subject: [PATCH v19 03/14] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
Date: Mon, 3 Aug 2026 17:17:59 -0500
Message-ID: <20260803221810.3685703-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: c20bcda7-f5a4-433a-1297-08def1ad320e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|18002099003|22082099003|11063799006|3023799007|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fAp0Yl9aC6Hf/G7C/pmjrRZfqH0fe2YKLMRUIGQAQ33Hcpf0Zri+msn8ml7QiRjv4kPbxYzKNOLVIt7tRzP9jJw3MeP7Me0V8EFqmXErwpJikNXNK5lBKbuJI4H5RoB1YJxhbPGA5PvEBbBdd7/0fn6BpVUEGvRsgMlpjPDw0tLoiEnFhBLh0V8GKu9dwnE+3aEw61n+0f2Ca+fecowzyDSf9xT6zg8sTvzd2y0zM+MYpIft969T0psqfNsMS4PcgEm3h4h5k5MTE7BsyxetZ2dEZJOjG0zrfoE+27uHpAIRM5LegRL2P5pNENuA8WilaPxUlPsTcH83qivI2Ji9dQoIUhY9RLI0xsrf7Xj4C5X8pbZX3+Cts/05VBJR0ozKvDAiui39kPsfSh0Bg6EJDegyyewxFDBk8pFXrUY9lJR07liQ4fp74XAJE8dA4k1BFQh1mUY6gK3b7XuTk4Gw7gT3l6DMCPKrx9kZxreX/VHvqC0m6spxwhRpjSZCTbuJy23uxVfxEW5fpgIFxVyHQvmQH2EeEhI6jaI0yJBrc9q+FCdMyit+0yM/1Wu9z02qDBXWHCcp/pK7bMi8/8LDx05wZr530FCKToU9GQzXR1PZAbdwpzV1U1Qdz7LOz8ylLOPCg4NzzmgLU9ydvmmLk0qi2dmjbMd7MBE83uQJQ8919Z/glwiirzyEtBNl1iyvfB1xWDif6dFEUCN66zjxKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(11063799006)(3023799007)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BxJYGgMDGQRWqzNBt1bC3bUguduEhm6M5ykWL9hJUtKFrLQRd51J5kwOVAx9CbIH0zsOmMbPGEuh51ZhZKMyfBePDtt6dCFl5orw3TOo0EIEfnRSRaNU1FlEIbH+p+AxCImY3j6p+dpa6tkbN0uNwEF13fpshgkQmff5e/2AldRqs48AYp7boCsRwDhZTTh6xEK/F1uhihB+i0CmU41biGlyjLwJsLzM2CPf7ou6fnn4ngvXdVQX77hYq/7xwqPLImHYqYsTKXKS6EIf1W8FMOUXGyNVDAIMl5dee3MoepVchMYyI8OnSURUSxDQtd+aql0Ux8Bcxd7u3cd9tMdp6SYgSeV7qkPDYNDVUKUacl7MXLZ4dFayTmjlxILzgEC5k6I46caoT1++46OmnOvgufUoVXPNs5v2eTnQ5/8YTf5IN9+BbJgGukPJrNkSnAG2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:18:50.3823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c20bcda7-f5a4-433a-1297-08def1ad320e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

The CXL CPER work registration and unregistration helpers acquire
cxl_cper_work_lock and cxl_cper_prot_err_work_lock with a spinlock
guard(), which leaves local interrupts enabled. The corresponding post
paths (cxl_cper_post_event(), cxl_cper_post_prot_err()) execute in hard
IRQ context (they are called from the GHES error notification path) and
acquire the same locks with an irqsave guard().

If a CPU is holding one of these locks via a spinlock guard() when a GHES
interrupt arrives on the same CPU, the IRQ handler spins on the held lock
waiting for it to release, while the lock holder is preempted by the IRQ.
The result is a deadlock.

Convert both locks from spinlock_t to raw_spinlock_t and use guard() at
all call sites. On PREEMPT_RT kernels spinlock_t is backed by rt_mutex and
sleeping from hard IRQ context is not permitted; raw_spinlock_t is safe in
both contexts.

Add WARN_ONCE to both register functions to surface double-registration
bugs at runtime.

Restructure both unregister functions to clear the global work pointer
under the lock before calling cancel_work_sync(), closing the window
where a CPER interrupt could schedule work on a pointer about to be
freed. Add kfifo_reset() after cancel_work_sync() so stale entries
are not replayed on next module load.

Both kfifos are single-consumer: only one work_struct is registered at
a time, enforced by the WARN_ONCE guard in the register functions.
kfifo_reset() is safe outside the lock because cancel_work_sync() has
already quiesced the consumer, and no new consumer can register until
the current module exit completes and a fresh module init runs.

Remove the redundant cancel_work_sync() call from cxl_ras_exit() and
cxl_pci_driver_exit(). The CPER unregister functions now quiesce
the work internally.

Reported-by: Sashiko <sashiko@linuxfoundation.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---

Changes in v18 -> v19:
- Remove the redundant cancel_work_sync() from cxl_ras_exit() and
  cxl_pci_driver_exit().
- Add review-by for DaveJ and Jonathan

Changes in v17 -> v18:
- New patch.
---
 drivers/acpi/apei/ghes.c | 50 ++++++++++++++++++++++++++--------------
 drivers/cxl/core/ras.c   |  1 -
 drivers/cxl/pci.c        |  1 -
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6b..ca7a138c1ff2e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -749,7 +749,7 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
 		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
 
 /* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
-static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
+static DEFINE_RAW_SPINLOCK(cxl_cper_prot_err_work_lock);
 struct work_struct *cxl_cper_prot_err_work;
 
 static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
@@ -761,7 +761,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	if (cxl_cper_sec_prot_err_valid(prot_err))
 		return;
 
-	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
+	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
 	if (!cxl_cper_prot_err_work)
 		return;
@@ -780,10 +780,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 
 int cxl_cper_register_prot_err_work(struct work_struct *work)
 {
-	if (cxl_cper_prot_err_work)
-		return -EINVAL;
+	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	if (WARN_ONCE(cxl_cper_prot_err_work,
+		      "CPER-CXL kfifo consumer already registered\n"))
+		return -EINVAL;
 	cxl_cper_prot_err_work = work;
 	return 0;
 }
@@ -791,11 +792,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
 
 int cxl_cper_unregister_prot_err_work(struct work_struct *work)
 {
-	if (cxl_cper_prot_err_work != work)
-		return -EINVAL;
+	scoped_guard(raw_spinlock_irqsave, &cxl_cper_prot_err_work_lock) {
+		if (WARN_ONCE(cxl_cper_prot_err_work != work,
+			      "CPER-CXL kfifo consumer mismatch on unregister\n"))
+			return -EINVAL;
+		cxl_cper_prot_err_work = NULL;
+	}
+
+	cancel_work_sync(work);
+
+	/* Discard stale entries so they are not replayed on next module load */
+	kfifo_reset(&cxl_cper_prot_err_fifo);
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
-	cxl_cper_prot_err_work = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
@@ -811,7 +819,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
 
 /* Synchronize schedule_work() with cxl_cper_work changes */
-static DEFINE_SPINLOCK(cxl_cper_work_lock);
+static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
 static void cxl_cper_post_event(enum cxl_event_type event_type,
@@ -831,7 +839,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 		return;
 	}
 
-	guard(spinlock_irqsave)(&cxl_cper_work_lock);
+	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
 
 	if (!cxl_cper_work)
 		return;
@@ -849,10 +857,11 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
 int cxl_cper_register_work(struct work_struct *work)
 {
-	if (cxl_cper_work)
+	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
+	if (WARN_ONCE(cxl_cper_work,
+		      "CXL CPER kfifo consumer already registered\n"))
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_work_lock);
 	cxl_cper_work = work;
 	return 0;
 }
@@ -860,11 +869,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
 
 int cxl_cper_unregister_work(struct work_struct *work)
 {
-	if (cxl_cper_work != work)
-		return -EINVAL;
+	scoped_guard(raw_spinlock_irqsave, &cxl_cper_work_lock) {
+		if (WARN_ONCE(cxl_cper_work != work,
+			      "CXL CPER kfifo consumer mismatch on unregister\n"))
+			return -EINVAL;
+		cxl_cper_work = NULL;
+	}
+
+	cancel_work_sync(work);
+
+	/* Discard stale entries so they are not replayed on next module load */
+	kfifo_reset(&cxl_cper_fifo);
 
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 99fb00949c2fa..bc74d4848132e 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -137,7 +137,6 @@ int cxl_ras_init(void)
 void cxl_ras_exit(void)
 {
 	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
 static void cxl_dport_map_ras(struct cxl_dport *dport)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c2..7c6faee7f85ed 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1083,7 +1083,6 @@ static int __init cxl_pci_driver_init(void)
 static void __exit cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
-	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
 
-- 
2.34.1

