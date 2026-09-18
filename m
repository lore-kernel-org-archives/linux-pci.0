Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6744E9C36;
	Fri, 18 Sep 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743424; cv=fail; b=of0SojhMaakmUfvk2xRjCZGi6x6dRx59LSsDtV1lkct6L/gfzLKgzNEQ1IP/WVaVh0yyqq/4a5mvEQJQU6ydj1pm9v4GHtxS1ZQKh9NM3Yx1ATmlKUTy2q9RathTXR13NhtqbcEiEMFQrQ7J46W48e8O3LMLaPmvLOUl4g30GME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743424; c=relaxed/simple;
	bh=xzwxyVBDYCyd2ZeTE/kzD69P+IQrzK1xSrBLdtsXzzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6Xfd+AF55rWUHLpz4KZvmD+VIPOQaA6A9Lk8LuJ6FQFTArm1euqK4SLsuwkSaDeFZp+bXkeUKG5+5rCS3OGnCjyRjCu2K6eJOVTG/5cAYaEC4eDTGO3WfEg4kEVo4IZs6qT7ojUJHzJo7VmVu+EwjcdItwsT4Zxjd7qqdUX7sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IdKtrL3Q; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IdKtrL3Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2hXgVc0EVPAcZUspTtRCrbNzOqw7dETkpUmxxoUXosoZAfdiVzlmS/vY+QRO3mYHMA8MtjVV0lshWp/JVlm+gEUiWB5RVxbi10tQ09w9k7OHiDiKDrNQSv+Q6qG1HZ8k81YSWhZ7hqGU2dDvnZu+ovmcR7ZdPwhKzGRhWWs96qlKET8FUeZJu6tejcWkK3X1y2vJORuuuU+64Af8JTRDU9sl8bHc8zIZdq7OCNdtB5xfmgg4NiIvHhYzm9anTn1pV/HyiiCSZ46VVVXJKts3vpcBLqjPXB1Q8uQiUg6fpFkFhvT/mxFkCsKRvxyXcMEVQOEBopy40kkwpYOy9RnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR5qT8cz3Ne1J4GwHHSAHQYdvCfbRy4PXCG8JfmyJ+A=;
 b=iAfnQPJVB/NapqaNvBrvtZSTe5Gnyhdcx06VOJCnU7NDAiQntUbbTzL1KbxTQCKgCd0EV+pNP7WqFPnwE9m9McouGralNebs/6XrH9W0esV93MMp8+yE68e3pbRFGR4azpf0bsQi7bMwTLS5B/5clT2aWKV5qEDHY50FfxjklpzMHsmg2TJI4houQ3hH6hQtyLwmQ7V//FUFq7UbzCPP0MMQwwx4Ku382K4YXemnKe1ZfpyoQPAHTlaz0kWKSCesfsMOiq92CXGxECiTCh/VF4Z2SpUGu6BGEMa1pkvCRybh81VAdURe+y0PvSls8cnZgpQs5Oe0+0oXW0/U2Ona3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR5qT8cz3Ne1J4GwHHSAHQYdvCfbRy4PXCG8JfmyJ+A=;
 b=IdKtrL3QwYKy8WYXahr0pAN1O0BlHpx7YL3LPuRNZzjiQICdf6VnP20OZll+nuu7BQcLXEMcgLXyPvVRD1SCXy75uZsCAubtnA7EoMAdoze5ukDgMj1eQfVHFRbWbRApGlLI0EupIlwuI0fuukHuDEVMEF3WeGo1leBuLExs+i4=
Received: from CH2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:610:51::31)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Fri, 18 Sep 2026 14:56:55 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::56) by CH2PR15CA0021.outlook.office365.com
 (2603:10b6:610:51::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 14:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:54 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:52 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 09/10] PCI/FLIT: Ratelimit flit error logging
Date: Fri, 18 Sep 2026 09:56:17 -0500
Message-ID: <20260918145619.3016889-10-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918145619.3016889-1-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dcd143-f9b2-4ab2-f30d-08df15951491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	7bJSQ8DfNdFG7/vVxC4t2jd9WVtluTbzqeNVPLi0OqvYxsg3yVlWqfKUSczL2V4JgxrKhqhA+VGYBoP9TW6m4bmrKiuPZ0PrWE4vhH8hstHakle1sHTfxFL2f3RF1Ekl5542mNskEuEvHrsTz7LbP1luiusf05lmj1VcY5Uhg4tCjp1s/xMxgQY+NDJrJjab4uPsgDhZKdeZ0uKbhw5rpoYxkosHLUyuyBthDJIrtFaZTmwSIZ63wgC7IhHocqEtakPmQlXctUyfKLllXLIYk20lsFgMT43sKD2lU/sUg0LcWT0DV2io/FbjghphnVbTMKLSQUVJLGzoWSEyObQ5Sm5hjIGul998tguJnWMfJN11uas44M87+8MkdjHh+8mLB9iLblz1gWpl0gkZMsROeN1KlmTYreh3Zo5OkWTvH2QRPgxZCdoOdmU2ubkAtnF6RBwyAdUlPQYhIPM8alWItt76Rb02+bA9sRHRXwm6qmhuR1SHssn6kjfiGfB/fVgVqCl2zQYOTbBqJPoJJ12tHH5DEdtTIxK+ElBk/YqfGK3s29QGZP9dInhxTXPbuyoH8v8nP9bRBK619mo18V8mGXgOi9q3XCz0hI7t0yhbZzlM5xA8zgx40KWdPBDRj62A4F2Qkk9pxTBDUu+JWTTvAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F5wWkQJIF18KR3vG4FBr0FAwcGDrVpq/P+EYC8HUmiDpBZ3gBNKl+1rkLbcSuPClkq3oUcqQHBVIhMZ8moiwpIMzBxbYIFQi1GBH7wy6Z8RBci5oSQmLur0AhtH2iw4sUrNwS7LFwNxNW9gqfAs6j3uAL2+8g5Q7qLaZ3W2gHopFimLMlh+MnvvKlbiuOqWaDSkUpIObtwXm9C0q3v459Ha5rcKfvzdevvN1F7ojJOXwV7beLqNvJ+g2gyIRH1CuI8Tk3N/VM8+7O5ypJaEvgxHoWwXnxdDEZoOr9eTeDrwSZBobhvP3/rwt6vCd3HCnMtt0jGlShfa7eslCc1Me67Iv+rfc4En57f8P2W6bWpPWXj8d529YB1JV1AEXV4DlABCI8n0AAPGxGJE9VvxB4JNyV4Puts9dWNhVgMGAvOgU3HoV2nfdSgslpHWr4GWp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:54.8751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dcd143-f9b2-4ab2-f30d-08df15951491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

A high rate of flit errors can flood the kernel log. Ratelimit it.

Keep the limit per port, so a storm on one port cannot suppress logging
on another, and take the decision per logged error rather than per
interrupt, so the configured burst counts console lines. AER does both
for the same reasons.

The trace event is left unthrottled, so tooling records every erroneous
flit even while the console log is limited.

Expose the interval and burst through a per-device "flit" sysfs group,
gated on CAP_SYS_ADMIN, so the limit can be tuned or disabled at
runtime. Document the attributes and list the new file in the PCI
SUBSYSTEM entry.

Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 .../ABI/testing/sysfs-bus-pci-devices-flit    | 35 ++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/pci/pci-sysfs.c                       |  3 ++
 drivers/pci/pci.h                             |  1 +
 drivers/pci/pcie/flit.c                       | 42 ++++++++++++++++++-
 5 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-flit

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-flit b/Documentation/ABI/testing/sysfs-bus-pci-devices-flit
new file mode 100644
index 000000000000..43d7c7aacf81
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-flit
@@ -0,0 +1,35 @@
+PCIe Flit error log ratelimits
+------------------------------
+
+These attributes show up under the Root Ports, Switch Ports and Root Complex
+Event Collectors that implement the PCI Express Flit Logging Extended
+Capability, where the OS was granted control of it. They represent configurable
+ratelimits of the flit error logs written to the kernel log.
+
+The ratelimit applies only to the kernel log. The flit_event trace event is
+emitted for every flit error the driver drains from the Flit Error Log,
+regardless of these settings. The log is a FIFO of implementation specific
+depth, so errors the hardware could not log are not reported either way.
+
+Writing these attributes requires CAP_SYS_ADMIN.
+
+What:		/sys/bus/pci/devices/<dev>/flit/ratelimit_interval_ms
+Date:		September 2026
+KernelVersion:	7.4.0
+Contact:	linux-pci@vger.kernel.org
+Description:	Writing 0, or any negative value, disables flit error log
+		ratelimiting. Writing a positive value sets the ratelimit
+		interval in ms. Reading gets the current ratelimit interval
+		in ms, rounded up to a whole jiffy. Default is
+		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
+
+What:		/sys/bus/pci/devices/<dev>/flit/ratelimit_burst
+Date:		September 2026
+KernelVersion:	7.4.0
+Contact:	linux-pci@vger.kernel.org
+Description:	Ratelimit burst for flit error logs. Writing a value changes
+		the number of logs (burst) allowed per interval before
+		ratelimiting. Reading gets the current ratelimit burst.
+		Writing 0, or any negative value, suppresses all logs
+		unless the interval attribute is also 0. Default is
+		DEFAULT_RATELIMIT_BURST (10).
diff --git a/MAINTAINERS b/MAINTAINERS
index 3df47851869e..2faa74c190f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21111,6 +21111,7 @@ B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	Documentation/ABI/testing/sysfs-bus-pci-devices-aer
+F:	Documentation/ABI/testing/sysfs-bus-pci-devices-flit
 F:	Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a111e62e39b3..e53e81ef5d91 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -2016,6 +2016,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
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
index 53a90f75cd76..733f0db70413 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1005,6 +1005,7 @@ void pci_flit_init(struct pci_dev *pdev);
 void pci_flit_exit(struct pci_dev *pdev);
 void pci_save_flit_state(struct pci_dev *pdev);
 void pci_restore_flit_state(struct pci_dev *pdev);
+extern const struct attribute_group flit_attr_group;
 #else
 static inline void pci_flit_init(struct pci_dev *pdev) { }
 static inline void pci_flit_exit(struct pci_dev *pdev) { }
diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
index 9eb804035997..252bbb54e617 100644
--- a/drivers/pci/pcie/flit.c
+++ b/drivers/pci/pcie/flit.c
@@ -16,8 +16,10 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sysfs.h>
 #include <ras/ras_event.h>
 #include "portdrv.h"
 #include "../pci.h"
@@ -76,6 +78,7 @@ static bool flit_is_native(struct pci_dev *pdev)
 
 struct flit_info {
 	spinlock_t lock;	/* serializes Counter Control read-modify-write */
+	struct ratelimit_state ratelimit;
 	bool cntr_enabled;	/* Counter Enable as the driver intends it */
 };
 
@@ -96,6 +99,10 @@ void pci_flit_init(struct pci_dev *pdev)
 
 	spin_lock_init(&pdev->flit_info->lock);
 
+	ratelimit_state_init(&pdev->flit_info->ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL,
+			     DEFAULT_RATELIMIT_BURST);
+
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_FLIT, sizeof(u16));
 
 	pci_dbg(pdev, "Flit Logging Extended Capability present.\n");
@@ -170,6 +177,38 @@ static void flit_cntr_ctrl_update(struct pci_dev *pdev, u16 clear, u16 set)
 	spin_unlock_irqrestore(&pdev->flit_info->lock, flags);
 }
 
+/*
+ * pci_dev_attr_groups[] in pci-sysfs.c is the only consumer of the group
+ * below, and the ratelimit accessors it is built from live there too.
+ */
+#ifdef CONFIG_SYSFS
+
+PCI_RATELIMIT_INTERVAL_ATTR(ratelimit_interval_ms, flit_info->ratelimit);
+PCI_RATELIMIT_BURST_ATTR(ratelimit_burst, flit_info->ratelimit);
+
+static struct attribute *flit_attrs[] = {
+	&dev_attr_ratelimit_interval_ms.attr,
+	&dev_attr_ratelimit_burst.attr,
+	NULL
+};
+
+static bool flit_group_visible(struct kobject *kobj)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return !!pdev->flit_info;
+}
+
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(flit);
+
+const struct attribute_group flit_attr_group = {
+	.name		= "flit",
+	.attrs		= flit_attrs,
+	.is_visible	= SYSFS_GROUP_VISIBLE(flit),
+};
+
+#endif /* CONFIG_SYSFS */
+
 static void flit_cntr_enable(struct pci_dev *pdev)
 {
 	u16 flit = pdev->flit_cap;
@@ -205,7 +244,8 @@ static void flit_report(struct pci_dev *pdev, u32 err_log1, u32 err_log2)
 	if (!(err_log1 & FLIT_ERR_LOG1_ERROR) && !err_log2)
 		return;
 
-	pci_warn(pdev, "ErrLog1: 0x%08x ErrLog2: 0x%08x\n", err_log1, err_log2);
+	if (__ratelimit(&pdev->flit_info->ratelimit))
+		pci_warn(pdev, "ErrLog1: 0x%08x ErrLog2: 0x%08x\n", err_log1, err_log2);
 
 	trace_flit_event(pci_name(pdev), err_log1, err_log2);
 }
-- 
2.43.0

