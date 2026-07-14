Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA1377AA7;
	Tue, 14 Jul 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054425; cv=fail; b=ApsomQMiWj06sGg1zh3Sw1GdK/dU+FteNGsU5b5vcYLIOr8HUKP58wrZRxoVLkX0bz+QG/t+TOdhDNLUoyY2cmEB+I7Lwgeh5YVdkswt/+mK73sGOCkMb1JQNjQG6I/uLzcXB9ABrT8tQS5PpXp7JTEnzhuYRiu/iZ6KuA7T9tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054425; c=relaxed/simple;
	bh=or03WoCLuvVmncGe+e2Mdf3lgu30w2GsmtUCstWl8R4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVjP9+W0OajhbF+XGOD3UeZKnF96Sp2DLbn5h1FwCkqgO5skE+57Mx6qsrXoJLxo1nTZuqEdmuLt7h8uBeSRoEnr563RykVg6QTpxhPhXodfKUaNIonneU4ZO5+DCZJrq5hE5xY9XWnls4j0ZnOgqp+KtgaV07L90jJSEbgDR/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WSPs6vTk; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WSPs6vTk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APrUKFNDMuLxl7WSPxi/TXebmylkzFtHclttNVaEt9Grj2wTZosl6uzGR/JV3gZ8k57FCWZh+kdUSffG/hNUtiiLNhv5OET+RLQhsrdQ40IUbTX+0npyu+9XOxjuN+9pppi+XYk1xb9In02x/cf8ai/+3rfkJDK2rpDkEzq94xdwqXKh3fV1A2gyQ51mZ/1YD0vgT5fZsQeQH6afOpnYNicWfHLvSiK7E9dX4d/T1NnrGs1gQ2zPg4jIus5GnSV9fZ7TMdZezhmi/BrMc+yNu+ypx8zhSekvp7iklOpX3AcqaWWtT44cLE1N25NyFaYumsZNmQLAMDk95nms31HqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKTckLxuKCtVYq+JdqxChQOzoZEggQiE7BL9GjVBysw=;
 b=fa1VRAnnBFLI60s+z7r3xby/LJQeaGZYDlLWLTvPhQG/02fwWl7U9NdM3h1sSu07E1bpJCpDIAmEjper3dMGeqDpG6lky3FrWpO6ZKn/1CZ6kLTTyQJQply1SM1FHO3RYTjZC8y6oD6hcQkakFu+C4m0vp3YiKy0cQVkWWZIBSU1S3Au+tRZ+wwPdpPAS6wX3GIgufLVeT6RUdzTKJOJHPQIaa9R09xs6pClFcKqTNi5CdHXFLESo17q9961+oUOp3FYW4c06Vh0k2gPe6lCgkuvDl0t9F3qvMw+yQ09n/dlRMYfX4HiLjzgJP08sqEZ37Pp1zjdI6YVisBOxtcX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKTckLxuKCtVYq+JdqxChQOzoZEggQiE7BL9GjVBysw=;
 b=WSPs6vTkcKeaa0DLwniur/s/Houta56ABuZ5PcTBhmK+DGaymUr+n9fY4C8gF5pblGxAmW5Zxmbu1HHQdnIMJL6qT0HZpjBJtLQeJo1E8C99aVGZe8eBx9Pfb6UmZzcH0X8bxBF/0Z8Xm7fg8fcmjdt+PsBxop1Dr4H/xiDf2Fs=
Received: from LV3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::18)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 14 Jul
 2026 18:40:07 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::2d) by LV3P220CA0009.outlook.office365.com
 (2603:10b6:408:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:40:07 +0000
Received: from yaz-khff4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 13:40:06 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 5/5] PCI/FLIT: Ratelimit flit error logging
Date: Tue, 14 Jul 2026 14:39:50 -0400
Message-ID: <20260714183950.1620016-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714183950.1620016-1-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 76384859-dac8-402f-7505-08dee1d75410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|56012099006|3023799007|11063799006|18002099003|5023799004|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uyNQNTawd46jVCKPrMKvNsAnbeXAfQ9GAuZXHNK54lBNL1VOmSutC88pMVFFXyg6iOX26KrHtcfLM2MWAC5W03V5DYSEFJcvSy/8G9pt+1hO0kEUeDvI6n/WLA4RwpUop0BcA26Fbp4+x2nY+WI9IzEmeXOWcgbxvUFnYg/oqbJ/hlbxLHp+RiRbV2oDuadxRJwVi3pd2xSa7J1ikRWWvFRKIo9cl2vQZb7TGaemAgor93rFuj9NfxyyXo09o2yBgE4CcxCVCpFYKSDLLQsEe1BY01oGko6bLb1p8jrPb/KABUJDB0BidWT0JxynpcoNU7hNxg/d6l7FdSL2ouAe3Z3BAfpy4bP2hYMR+36Z+sY3VBeKxu1Xv1MY55Jp8uhKMJ18peCUyGESsfG51TCvgEFnAI4a++WeFFaSEp2qJaykHgMJ1ZAJtp3ra3PanRBxDzea9o4A/FjSOSwQ8Y0if0JwIgg+ot2TU96B0bQRyW5YzvH7P+Ugpju6u0Z2WPE7K8le027dK5/LN9WIfhJITAbVKY+1hJvjIb8gBZw9L0w4MFxkkb+W4c5azNXfp3x7UQ5XJG8ygoeLwsnEfsjZ/RJLlzDyXTZAhIpFk5RWpVEBj1gBvkLdGagIcgIp79kRTrbwY1TgPzwa16yaq3H6CPbMtHEQSnHSNCkXrwKHQctcZggAsnRHY8o0oK3ldOiYuO9wjpyvtxzTrmEqE4gVnA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(3023799007)(11063799006)(18002099003)(5023799004)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nYLlGjhqRIAKaZ3rvC883JSBnKVrMhV+WAT+m7oAVusn1M0EABpy+dXKmaJOk5Rtnbs2QKqsOwtMX4zu0PmkTV9tX3GDzzxPAQx3Vl3ZdO1vJFWluR0RQec9B5D8VRts8sKvQj1uhUG6I0yQlkS3FgGmhcS4meb9/0wWd7TD/JgB+eNX8IcY66V0L+kX2w2AsbNtUbz8YjhgtptMwI62MbuXWAKAIysQPuanoXzlclKam6nw1bELOXYFJVr6AlJIrsQpgK8HuQbCzOcpSUKnhMab1kRxSR9f6fr4GXZlpwLqWIsCZTl5cC0BLmIxve6UnUvjfyGH6+So+Aoseejq0HEvNKh7as+kIGjwDILP5Nc1OfatqqoM611NcrSDk6A/NcO9QDLMck0KuItIUWYf8g/ddDN/q00xyBhyZ+1S/n+vtGAE2PlwM6jiYu/iURcV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:40:07.7340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76384859-dac8-402f-7505-08dee1d75410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

A high rate of flit errors can flood the kernel log with error counter
and error log messages. Model the throttling on the AER capability: give
each device its own ratelimit_state, initialized in pci_flit_init() with
the default interval and burst, rather than a single static per-call-site
limiter shared across all ports.

Take one ratelimit decision per interrupt and use it to gate the console
output, so a storm on one port cannot suppress logging on another. Leave
the flit_error trace event unthrottled so RAS tooling still records every
erroneous flit while the log is limited.

Expose the interval and burst through per-device sysfs attributes
(flit_ratelimit_interval_ms, flit_ratelimit_burst), gated on CAP_SYS_ADMIN,
so the limit can be tuned or disabled at runtime.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/pci/pci-sysfs.c |   3 +
 drivers/pci/pci.h       |   1 +
 drivers/pci/pcie/flit.c | 119 ++++++++++++++++++++++++++++++++++++++--
 include/linux/pci.h     |   2 +
 4 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index e985a3854f8d..e85953c249f2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1932,6 +1932,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 	&aer_stats_attr_group,
 	&aer_attr_group,
 #endif
+#ifdef CONFIG_PCIE_FLIT
+	&flit_attr_group,
+#endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
 #endif
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 31d04366b980..28ff4243d125 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -896,6 +896,7 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 
 #ifdef CONFIG_PCIE_FLIT
 void pci_flit_init(struct pci_dev *pdev);
+extern const struct attribute_group flit_attr_group;
 #else
 static inline void pci_flit_init(struct pci_dev *pdev) { }
 #endif
diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
index 83cf53f39291..7cb5aff7c552 100644
--- a/drivers/pci/pcie/flit.c
+++ b/drivers/pci/pcie/flit.c
@@ -12,9 +12,12 @@
 #define pr_fmt(fmt) "Flit: " fmt
 #define dev_fmt pr_fmt
 
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/ratelimit.h>
+#include <linux/sysfs.h>
 #include <ras/ras_event.h>
 #include "portdrv.h"
 #include "../pci.h"
@@ -30,10 +33,106 @@ void pci_flit_init(struct pci_dev *pdev)
 		return;
 
 	pdev->flit_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_FLIT);
-	if (pdev->flit_cap)
-		pci_dbg(pdev, "Flit Mode Error Logging Capability present.\n");
+	if (!pdev->flit_cap)
+		return;
+
+	ratelimit_state_init(&pdev->flit_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
+			     DEFAULT_RATELIMIT_BURST);
+
+	pci_dbg(pdev, "Flit Mode Error Logging Capability present.\n");
+}
+
+/*
+ * Ratelimit interval
+ * <=0: disabled with ratelimit.interval = 0
+ * >0: enabled with ratelimit.interval in ms
+ */
+static ssize_t flit_ratelimit_interval_ms_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%d\n",
+			  jiffies_to_msecs(pdev->flit_ratelimit.interval));
+}
+
+static ssize_t flit_ratelimit_interval_ms_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int interval;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoint(buf, 0, &interval) < 0)
+		return -EINVAL;
+
+	if (interval <= 0)
+		interval = 0;
+	else
+		interval = msecs_to_jiffies(interval);
+
+	pdev->flit_ratelimit.interval = interval;
+
+	return count;
+}
+static DEVICE_ATTR_RW(flit_ratelimit_interval_ms);
+
+static ssize_t flit_ratelimit_burst_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%d\n", pdev->flit_ratelimit.burst);
+}
+
+static ssize_t flit_ratelimit_burst_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int burst;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoint(buf, 0, &burst) < 0)
+		return -EINVAL;
+
+	pdev->flit_ratelimit.burst = burst;
+
+	return count;
+}
+static DEVICE_ATTR_RW(flit_ratelimit_burst);
+
+static struct attribute *flit_attrs[] = {
+	&dev_attr_flit_ratelimit_interval_ms.attr,
+	&dev_attr_flit_ratelimit_burst.attr,
+	NULL
+};
+
+static umode_t flit_attrs_are_visible(struct kobject *kobj,
+				      struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pdev->flit_cap)
+		return 0;
+
+	return a->mode;
 }
 
+const struct attribute_group flit_attr_group = {
+	.name = "flit",
+	.attrs = flit_attrs,
+	.is_visible = flit_attrs_are_visible,
+};
+
 static void flit_cntr_enable(struct pci_dev *pdev)
 {
 	u16 flit = pdev->flit_cap;
@@ -70,12 +169,22 @@ static irqreturn_t flit_isr(int irq, void *context)
 	u16 flit = pdev->flit_cap;
 	u16 cntr_ctrl, cntr_sta;
 	u32 err_log1, err_log2;
+	bool print;
 
 	/* Read and log Counter and Error Log Registers. */
 	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &cntr_ctrl);
 	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &cntr_sta);
 
-	pci_info(pdev, HW_ERR "Counter Control: 0x%04x Counter Status: 0x%04x\n", cntr_ctrl, cntr_sta);
+	/*
+	 * Take a single ratelimit decision per interrupt and use it to gate
+	 * the console output.  The trace event is always emitted so RAS
+	 * tooling records every erroneous flit even while the log is throttled.
+	 */
+	print = __ratelimit(&pdev->flit_ratelimit);
+
+	if (print)
+		pci_info(pdev, HW_ERR "Counter Control: 0x%04x Counter Status: 0x%04x\n",
+			 cntr_ctrl, cntr_sta);
 
 	do {
 		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, &err_log1);
@@ -84,7 +193,9 @@ static irqreturn_t flit_isr(int irq, void *context)
 			break;
 
 		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG2, &err_log2);
-		pci_info(pdev, HW_ERR "  Error Log1: 0x%08x Error Log2: 0x%08x\n", err_log1, err_log2);
+		if (print)
+			pci_info(pdev, HW_ERR "  Error Log1: 0x%08x Error Log2: 0x%08x\n",
+				 err_log1, err_log2);
 		trace_flit_event(pci_name(pdev), cntr_ctrl, cntr_sta, err_log1, err_log2);
 
 		pci_write_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, err_log1);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4e4d1d9eb7fe..01df7c84a658 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -40,6 +40,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
+#include <linux/ratelimit_types.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -595,6 +596,7 @@ struct pci_dev {
 
 #ifdef CONFIG_PCIE_FLIT
 	u16		flit_cap;	/* Flit Logging Capabilities */
+	struct ratelimit_state flit_ratelimit;	/* Flit error log ratelimit */
 #endif
 };
 
-- 
2.53.0

