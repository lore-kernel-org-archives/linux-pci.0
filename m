Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB647345CDD;
	Mon,  3 Aug 2026 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795553; cv=fail; b=BKjflVFB75tC0nz/4g+B8p5ystfYZm/IZuR9yyXgZDlj0ch8heeHlriWyX47sAVyAIikXbyTiZdxfOtkhN1EMFf5jmIGcVOjPPir89LHIFooMLDXdCHhsxMIoos/+dCy4Pi2T1Mi8QA4uMXwZagXo/hTA86k5WQNPHU1w0UTYXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795553; c=relaxed/simple;
	bh=F5YQAwsqjtwmxOV+7XaB+Q19rUiVfGNeecPPLxPkR5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMzeDtfPQVGkNUFg7MxFnCAy9d7g7snha5yVVZPDZJzwu8yRDpP9NuVyCUZD9a9JQpCn0z4D1X/Wcs3Ky0EpnpRybnKDdrGtjpFDeConsRzFWCaTrN8C7wMLrlrf4wl80rSHIZn/0VuL4g0my34dR3CCeqq1NN39m8T5z5+0Mq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0PVFKzH7; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0PVFKzH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyBROrXcTQy2kv5e40JjbBrloMKsyTjXJ8Jmb7HqhLixT5MiwSLRQIbuEVCF1JVp0pUgeh4IMsKZ0iYs8geJmoWofaNXRA8EXyBrj4zJ9HmpA81d0H/WB/uHNnbV3cMRfMVj9Ckj+jEhLwo61wIQuOi3yXOuNUHOm9q6eBY27vZNH9t9c+LmxQ63RaWaV9cj0RqJ4UM/GSFZDh00cwagmFHTunnzh+S1EgsotG8bQ0ICh5sV9EjNyFXrX8Gag3+KORL1ZcdFhTz8baVaZ+lBZrhMoZWycIw1RBs/P8deT+Snr/C+6sVlrmO+eGCH6W8cwsElI5PZB/w9APvE7wlDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1OA19mz0W0oB0MGJo7QZjkir3ppM/PJWzMftw+bcIo=;
 b=b36x5m0sFOHKC/in4k3nB0I8rb14mpnKsMJfxjXCqiyjj140Kf1TlnP6VIx6FcQticlgOK98wS/LH7yG1VvcXuqqnBtUFfTDM0IzZ5cQoDeupb+oqvNjqwnTFusKvazsppTo5jC7HIRABPpp87tM8Vj7vGHBcUNXCXycUfB4Sqsql1+rRCwnld1IsJEc4imcGA+Qg/tN2Za3pYpKu0EMuXx/Kf8G2wzoHbSPOPe/EpVPw9PQy3BPmJ6+BouueJA7Pwc6/k1eqqZ6E/vdUtKePy6j4cAGUXj+CmXLB6VllHCLLDFs68dRM4Pvrtf+LfY0q+4REObeY3oW/D68Wvlrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1OA19mz0W0oB0MGJo7QZjkir3ppM/PJWzMftw+bcIo=;
 b=0PVFKzH7OPBdmQXOczRHDlyQKyD7llPjW2KV6hdphdn8d1V0AXuLdWzopZgNoV9TfUjmDXVqDwIQYqKkG/ThaN56YFlVYoHfQ+5y69CGYTkjjFOcg5q4ODyEdvJDIXh51hi5Bs3ibmi4448/Pg/aCpbb+0vXE4LAlrSZT2qDA9g=
Received: from BLAPR03CA0152.namprd03.prod.outlook.com (2603:10b6:208:32f::16)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:19:02 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::23) by BLAPR03CA0152.outlook.office365.com
 (2603:10b6:208:32f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 22:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:19:02 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:19:00 -0500
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
Subject: [PATCH v19 04/14] cxl: Tighten CPER kfifo registration API and symbol visibility
Date: Mon, 3 Aug 2026 17:18:00 -0500
Message-ID: <20260803221810.3685703-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c0a1d9-4543-41ec-9183-08def1ad395a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|1800799024|376014|36860700016|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8yKto+l0JvCxHErtj6Ho9jXfnW9rUP4GRFGQ6puFtGkQs+Rq8zXUwZZ3mJ0Pdav1b2IBpm3WOF94pvddB0SqtjKCc6gQjtYaGMMeaB1xiijbFR1LRL+IvpALe2HtQrkP5kjguJBjWOm2PzoqzMmFkOmDUratfLcxhCdH4zejcGXZ3SJMXROsUxgs8cOHLBgVppmO0tKf90JPtDWDV5ERR7RQq9dVERM3EMNJyKyxr1p8OPzcoW4omgWvgiN/XnuxhNgJkwxob/8NEpIAoomvgaQzkxmVmo03IXiIqUkIWL7tZXJoTAxiA15ySUvjo5oEGcIdpRL2bjaS4tvKYdxL7Ujfc7IcPcKeTzLKmG9qfhggAbPgkxYaNZcXTWgz1bheHNx/XVUu5YSRG+Y8H1+Zc/08lh2JjCULZHbpTbr3iueDeQAt4f2j4UUIYXl/CojXMehsIkEnXayT67KY7cu1Di1S4eadhtIQNOLqdFauXvgX2IEPITW+vKZt24Xl1jQS6ooGLoIhGlPwN/25LXF1VeoxRJtZVJsI5vImoR4IvasJwrGIFL2ciTpWjX2nDCEVPneQ7LEN1yEWFkhuvT1LPePd9VwZCxHbTESUkERNJVKEI5Qtz0IMhvcmOWUfJ4TwGAHr5Mwv9pwETOILv67CZvB3A43FeCfTvI38/pzVkvqArWA+JVTsvBOoiDCWLdy4d3NCZ9h2N4Ad7OvtrFg/2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UtbZKhy8NFocK/OBbwNgqX2g28P02Mr6F5D1JKo1hkSCBy1/NUi5y5wJrusr2yBZmW26HhsjruLfPhdeFtB7EX8aoHsoFxMQHNPW1R2w+aM7q6qlp+J2/CrdwXENy5THoiQmwcTD82aG7ceQPwBsGS93dmAUv1WOefizeBUBdjCxY3zUP9FxOM6m8NkIiHWVGBDyGBXbp+fcwL4umHJ07PiEf2JMzKHHHlEXMYRuCBwCGWh0Iutx4Uh4v9afeo+Z3jgEpiVISzT1lj9Hvvo0q9uhS7h5/x4bfkrKz5LspldDPiJODNP68nlWQJoVc3ECU6hEWRNx+9J9nJnpeGqObZDcdAaSO/axtAoyOvwMEm2nlVlYw85Ec0CmjLoFaWMvZ+Bco3AjGSOfRZv46BymFnW2q/Lhqv9XJYPDzyQJS/WgcGE4aLADLW4wmb+X7p4M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:19:02.6703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c0a1d9-4543-41ec-9183-08def1ad395a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

From: Dan Williams <djbw@kernel.org>

Tighten the CPER protocol error kfifo registration API and symbol
visibility.

Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_NS_GPL() for
the CPER kfifo registration symbols. This names the consuming module
explicitly and gives compile-time enforcement.

Drop the work_struct argument from the unregister path. Change the
WARN_ONCE condition to a NULL check since there is no caller pointer
to compare against anymore.

Return void from the registration helpers whose result callers ignore.
cxl_cper_register_work() keeps its int return as the only one consumed by
a caller. Flag double registration with WARN_ONCE() inside the lock
instead of returning an error.

Change cxl_ras_init() to void because there is one consumer and one
producer so the error return was unnecessary. Remove the now-dead error
check in cxl_core_init().

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v18 -> v19:
- Tidied up definition line-wrapping in event.h
- Refined commit message reason for converting reg/dreg function
return values to NULL.
- Add review-by for DaveJ

Changes in v17 -> v18:
- New patch.
---
 drivers/acpi/apei/ghes.c | 32 +++++++++++++++-----------------
 drivers/cxl/core/core.h  |  7 ++-----
 drivers/cxl/core/port.c  |  6 +-----
 drivers/cxl/core/ras.c   |  6 +++---
 include/cxl/event.h      | 21 ++++++---------------
 5 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ca7a138c1ff2e..187f54e31c33e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -778,41 +778,41 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 #endif
 }
 
-int cxl_cper_register_prot_err_work(struct work_struct *work)
+void cxl_cper_register_prot_err_work(struct work_struct *work)
 {
 	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
 	if (WARN_ONCE(cxl_cper_prot_err_work,
 		      "CPER-CXL kfifo consumer already registered\n"))
-		return -EINVAL;
+		return;
 	cxl_cper_prot_err_work = work;
-	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_register_prot_err_work, "cxl_core");
 
-int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+void cxl_cper_unregister_prot_err_work(void)
 {
+	struct work_struct *old;
+
 	scoped_guard(raw_spinlock_irqsave, &cxl_cper_prot_err_work_lock) {
-		if (WARN_ONCE(cxl_cper_prot_err_work != work,
-			      "CPER-CXL kfifo consumer mismatch on unregister\n"))
-			return -EINVAL;
+		WARN_ONCE(!cxl_cper_prot_err_work,
+			  "CPER-CXL kfifo consumer not registered on unregister\n");
+		old = cxl_cper_prot_err_work;
 		cxl_cper_prot_err_work = NULL;
 	}
 
-	cancel_work_sync(work);
+	if (old)
+		cancel_work_sync(old);
 
 	/* Discard stale entries so they are not replayed on next module load */
 	kfifo_reset(&cxl_cper_prot_err_fifo);
-
-	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_unregister_prot_err_work, "cxl_core");
 
 int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
 {
 	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_prot_err_kfifo_get, "cxl_core");
 
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
@@ -867,12 +867,12 @@ int cxl_cper_register_work(struct work_struct *work)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
 
-int cxl_cper_unregister_work(struct work_struct *work)
+void cxl_cper_unregister_work(struct work_struct *work)
 {
 	scoped_guard(raw_spinlock_irqsave, &cxl_cper_work_lock) {
 		if (WARN_ONCE(cxl_cper_work != work,
 			      "CXL CPER kfifo consumer mismatch on unregister\n"))
-			return -EINVAL;
+			return;
 		cxl_cper_work = NULL;
 	}
 
@@ -880,8 +880,6 @@ int cxl_cper_unregister_work(struct work_struct *work)
 
 	/* Discard stale entries so they are not replayed on next module load */
 	kfifo_reset(&cxl_cper_fifo);
-
-	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae638594..23fe40ddf4c6b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -183,7 +183,7 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 	return &port->dev;
 }
 #ifdef CONFIG_CXL_RAS
-int cxl_ras_init(void);
+void cxl_ras_init(void);
 void cxl_ras_exit(void);
 bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
 void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
@@ -192,10 +192,7 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
-static inline int cxl_ras_init(void)
-{
-	return 0;
-}
+static inline void cxl_ras_init(void) { }
 static inline void cxl_ras_exit(void) { }
 static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f40351..f90f899c31d07 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2531,14 +2531,10 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_region;
 
-	rc = cxl_ras_init();
-	if (rc)
-		goto err_ras;
+	cxl_ras_init();
 
 	return 0;
 
-err_ras:
-	cxl_region_exit();
 err_region:
 	bus_unregister(&cxl_bus_type);
 err_bus:
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index bc74d4848132e..e307361bb39e4 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -129,14 +129,14 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
+void cxl_ras_init(void)
 {
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
 }
 
 void cxl_ras_exit(void)
 {
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cxl_cper_unregister_prot_err_work();
 }
 
 static void cxl_dport_map_ras(struct cxl_dport *dport)
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ff97fea718d2c..b5673384d9306 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -287,10 +287,10 @@ struct cxl_cper_prot_err_work_data {
 
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
-int cxl_cper_unregister_work(struct work_struct *work);
+void cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
-int cxl_cper_register_prot_err_work(struct work_struct *work);
-int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+void cxl_cper_register_prot_err_work(struct work_struct *work);
+void cxl_cper_unregister_prot_err_work(void);
 int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
 #else
 static inline int cxl_cper_register_work(struct work_struct *work)
@@ -298,22 +298,13 @@ static inline int cxl_cper_register_work(struct work_struct *work)
 	return 0;
 }
 
-static inline int cxl_cper_unregister_work(struct work_struct *work)
-{
-	return 0;
-}
+static inline void cxl_cper_unregister_work(struct work_struct *work) { }
 static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
 {
 	return 0;
 }
-static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
-{
-	return 0;
-}
-static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
-{
-	return 0;
-}
+static inline void cxl_cper_register_prot_err_work(struct work_struct *work) { }
+static inline void cxl_cper_unregister_prot_err_work(void) { }
 static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
 {
 	return 0;
-- 
2.34.1

