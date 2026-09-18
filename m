Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D004FC352;
	Fri, 18 Sep 2026 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743422; cv=fail; b=FMcTq1CUzbhTKepvV7nyGZPR9drMnm3vaGmms93gF25vjAqRWM1szKBO7IRskc3t7qtuEl+xcxgNbdTfrXZmozdFXIRHj3FNBCUkefKiyM8cYaxP32wMDiFHQDuhx81Std2uluiSe1ppqOfTjN80fFq+Qb3anzMXnGYLKHXh+oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743422; c=relaxed/simple;
	bh=7MRMSn+YDW9Pnvrb7Usc6jhAKmzrYYTAxMLralsFcHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEzSHc2qFfEzhHg/odBM9FVSpdr5yOgMJg/FOHSOmV2KjzPjJTv8u0lP3mWRTCyYc0D4GR8hiPc0yp2z0jEr1C+jJk9Pk26kEccfK8vAPWa1T9bxa5Di3C8sjMSUkDpNKo6/LZM2XVW/CmfC78EGvIbIygH01yc3dIsr7bqdw6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZTkGeFX7; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZTkGeFX7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiaUrCzHh10FK35WPq81eS21x1YLaMeSzDuSnrR5sj+3XqXn0YtbHd3cAtrGP+vRiYg8XAXggKDZKiM6Vz1C0CwXvWotetM1QiBQVXpOXcT5v1wqVWyfSOa5aSvEb6m4yWTLpi/7TD6RdPDMs1fFsHGxkxU5IQgLufhWcwCcnGqY/XcqaoPRcx31ADt8/py5GmBARM7K1eqkqXnZxuXlTSeQ8vT/OcikWziTYx7MyJMylVU/CrpEh5cp1Bd9G+Y+09Jyv6C9Dz74UCeO9hbs0giQr+Gjc8cnJ1OZ2kZcIQ7M9yMk3KhrBJQaVvvD+qZz+yUl6sRTgwjv6Szjc2qfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP1jPW8iXN9pCm9A9aJjRacn1gXM4bSqRMNPAOib3Ac=;
 b=O2qqtBqx/Awlc3RGMOQCqkBSZ5zRE8g6GmCPsHNaqq9prNRBrD1Bfhktw43pL5ojGuZpAOa+T1gnnxjDKOmGHJwTbraPRn7qJVbFKDCE7TucI52kziE5Jmwuv4G+b80qUPL/YZyePlS3EkMD2XPADvbEYzwjZXb4O6J8/wxTEkng/3gwtm2tFL7gwC3r1+JbTyeThdWaLEkrwNo4zbDsqYoHr1l1ixDEYXvCANrMw6Qrs4mZI5S5co3IffK+imwfUK1oDzSh8i42FtKrcRdmIBPaF9UB3kPN0sMZtDgnBcAK9aavwm9p6goatggZdFX9SDrYEfrNzFGd2dXVEBmFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP1jPW8iXN9pCm9A9aJjRacn1gXM4bSqRMNPAOib3Ac=;
 b=ZTkGeFX79jZhRC8vgnGnzFGQ6nVuqFd0x91KgYOHqKCbjSPiUUj/QYxzfI4mokYzSJ9qBlcJ7iOT8vH4k4Joux9JnposBCsMtSWAjnffuSyq4f/k6hj4M5TadtepVSo5ryj13JAdqPyxX4NmJLWRws7wi7fl+wL6bLRT6+nTmZ4=
Received: from CH2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:610:51::35)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:56:52 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::8a) by CH2PR15CA0025.outlook.office365.com
 (2603:10b6:610:51::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 14:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:52 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:50 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 05/10] PCI: Share the AER ratelimit sysfs accessors
Date: Fri, 18 Sep 2026 09:56:13 -0500
Message-ID: <20260918145619.3016889-6-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|LV8PR12MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: df998540-0340-4508-d433-08df15951332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|56012099006|11063799006|10067099003|6133799003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WQ+3bVN70ESdLL2KkL1QTvBjekuC/UwlhOeuJ8Zc1rEUa3HtU1Ch8oGLS8uSegzMOgQY427b3O7Src9Tc3t3V9Ogo3N+IWAqL3RD8Y2L7bu6SiD/kGS3LDr9M24LBle/DIm3Zbdo3aikb+wjBDO89noIQP67eg12345xCDixm4PJhWlBDRENjrc8oKw3qah4JlekCdGBcMX7FRz9cNTKEa6AJmHCBjmvEmwWZjbTMxetrcAdiapM3IQK2MLoKi1XGJo0WJBoDoEcJGPO4LaUrLRdcQvAe+heO5qkS57rnJYbtn/dvgSEq+ANhh/J3FzEUOOvDpiZ1RDdIeoWTgTg2fSq5IzLKJoqz3rCwRjzh3LNWyZoiiM8A60n9LyptVZenSmBq127e/GKrrnl1fWGnV8yYIYmL6DeCbYmBp3NuJiBST1IPsITiT/YzK5ns/VG2KpLAnPbMQ0d+r2+C7nwiz+StMo+/3Dq+7J6HprdpXw5YSDMqtGYWIrL0pMRzasjOWE8UNeNbBuhm3Rxz7ZyUme+k1yutHfRQrDk3uhR4EEs2uayg7jR7bE9qQ5R4ySjxHGTFYFtl8/GkmK8XawfTWq4ojZtuiYn161FKlUSQtwXuLITi6nPvYstiCKjYNB8C1F03AYdnWgdN9dkfm70RQcoG02+FXkqy2xumrv2Rb1XbMe2vNBy5JMdu3ZBAm79GOS+TaxJGlbUA8VUDnXarA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xIxXaN6zsx1+cUWXbSjMA5vzhlYzQSgnR8DQNS0xNxiTfF2thR7BpoH5CEPBCSYZud6oqbsgVscjx6gpLieUhcbpGv6FYIVdmBufYWACy2nRPlMYmmdoT/LpL7eT+iZLiqdzsWm4TWqXG0M9oXhZmfe8SZJjnIpKFkGxz0tHIxnhWqF2T+DILb/RtI81PabpdZnZ74ksePgjoRysr6KAx6wBtxcundAZ5sf1X8gSoWPwNaPelVs95ftWYw2LArJT/Emaov+owRZS8jf+HqT0FStYQ/WGXSUBNfN43ZgnL50zXFZmg3m7TrGcFCxwkbJ5Sr2yH8bg7K0S767spJeCtHZTB2l04ABv77WKoiMXdiXtPht024IDubOOamsYRmkdzl8vsD/rhwjw3xdGZ32GAO1nmGhJUPNNB+TR39+plioCNx2fONUnpmk3LtHJQxCH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:52.5739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df998540-0340-4508-d433-08df15951332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713

The show and store paths for a ratelimit_state exposed through sysfs are
the same whichever capability owns the state. Only the expression that
reaches the ratelimit_state differs.

Move the bodies into pci-sysfs.c as four helpers taking a
ratelimit_state, and add PCI_RATELIMIT_INTERVAL_ATTR() and
PCI_RATELIMIT_BURST_ATTR() to generate the attribute pair around them.
Convert AER to use them.

The Makefile builds pci-sysfs.c only under CONFIG_SYSFS, so build the
AER attributes under it too. They were dead code without it, since
pci_dev_attr_groups[] is their only consumer, but they were still
emitted and now reference the shared helpers.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/pci/pci-sysfs.c | 68 ++++++++++++++++++++++++++++++
 drivers/pci/pci.h       | 49 ++++++++++++++++++++++
 drivers/pci/pcie/aer.c  | 93 +++++++----------------------------------
 3 files changed, 131 insertions(+), 79 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 1f21856aac8a..a111e62e39b3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -29,6 +29,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/ratelimit.h>
 #include <linux/aperture.h>
 #include <linux/unaligned.h>
 #include "pci.h"
@@ -1892,6 +1893,73 @@ static const struct attribute_group pci_dev_group = {
 	.attrs = pci_dev_attrs,
 };
 
+/*
+ * Accessors shared by the capabilities that expose a struct ratelimit_state
+ * through sysfs. Use them via PCI_RATELIMIT_INTERVAL_ATTR() and
+ * PCI_RATELIMIT_BURST_ATTR() rather than calling them directly.
+ */
+ssize_t pci_ratelimit_interval_show(struct ratelimit_state *rs, char *buf)
+{
+	unsigned long iv = rs->interval;
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(iv));
+}
+
+/*
+ * Ratelimit interval, in milliseconds
+ * <=0: disabled with ratelimit.interval = 0
+ * >0: enabled, ratelimit.interval held in jiffies
+ */
+ssize_t pci_ratelimit_interval_store(struct ratelimit_state *rs,
+				     const char *buf, size_t count)
+{
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
+	rs->interval = interval;
+
+	return count;
+}
+
+ssize_t pci_ratelimit_burst_show(struct ratelimit_state *rs, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", rs->burst);
+}
+
+/*
+ * Ratelimit burst
+ * <=0: everything suppressed, unless the interval is also 0
+ * >0: messages allowed per interval
+ */
+ssize_t pci_ratelimit_burst_store(struct ratelimit_state *rs,
+				  const char *buf, size_t count)
+{
+	int burst;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoint(buf, 0, &burst) < 0)
+		return -EINVAL;
+
+	if (burst < 0)
+		burst = 0;
+
+	rs->burst = burst;
+
+	return count;
+}
+
 const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f5fdb5dffdb7..f43c5330fca3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -9,6 +9,7 @@
 #include <trace/events/pci.h>
 
 struct pcie_tlp_log;
+struct ratelimit_state;
 
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
@@ -74,6 +75,54 @@ struct pcie_tlp_log;
 #define PCIE_LINK_WAIT_MAX_RETRIES	10
 #define PCIE_LINK_WAIT_SLEEP_MS		90
 
+ssize_t pci_ratelimit_interval_show(struct ratelimit_state *rs, char *buf);
+ssize_t pci_ratelimit_interval_store(struct ratelimit_state *rs,
+				     const char *buf, size_t count);
+ssize_t pci_ratelimit_burst_show(struct ratelimit_state *rs, char *buf);
+ssize_t pci_ratelimit_burst_store(struct ratelimit_state *rs,
+				  const char *buf, size_t count);
+
+/*
+ * Define the "<name>" sysfs attribute for the interval or the burst of a
+ * struct ratelimit_state. @member names it within struct pci_dev, so it
+ * reads as e.g. aer_info->correctable_ratelimit.
+ */
+#define PCI_RATELIMIT_INTERVAL_ATTR(name, member)			\
+	static ssize_t name##_show(struct device *dev,			\
+				   struct device_attribute *attr,	\
+				   char *buf)				\
+	{								\
+		return pci_ratelimit_interval_show(			\
+				&to_pci_dev(dev)->member, buf);		\
+	}								\
+									\
+	static ssize_t name##_store(struct device *dev,			\
+				    struct device_attribute *attr,	\
+				    const char *buf, size_t count)	\
+	{								\
+		return pci_ratelimit_interval_store(			\
+				&to_pci_dev(dev)->member, buf, count);	\
+	}								\
+	static DEVICE_ATTR_RW(name)
+
+#define PCI_RATELIMIT_BURST_ATTR(name, member)				\
+	static ssize_t name##_show(struct device *dev,			\
+				   struct device_attribute *attr,	\
+				   char *buf)				\
+	{								\
+		return pci_ratelimit_burst_show(			\
+				&to_pci_dev(dev)->member, buf);		\
+	}								\
+									\
+	static ssize_t name##_store(struct device *dev,			\
+				    struct device_attribute *attr,	\
+				    const char *buf, size_t count)	\
+	{								\
+		return pci_ratelimit_burst_store(			\
+				&to_pci_dev(dev)->member, buf, count);	\
+	}								\
+	static DEVICE_ATTR_RW(name)
+
 /* Format of TLP; PCIe r7.0, sec 2.2.1 */
 #define PCIE_TLP_FMT_3DW_NO_DATA	0x00 /* 3DW header, no data */
 #define PCIE_TLP_FMT_4DW_NO_DATA	0x01 /* 4DW header, no data */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 91d73bd2ca7c..f42b57cac28a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -599,6 +599,12 @@ static const char *aer_agent_string[] = {
 	"",
 };
 
+/*
+ * pci_dev_attr_groups[] in pci-sysfs.c is the only consumer of the groups
+ * below, and the ratelimit accessors they are built from live there too.
+ */
+#ifdef CONFIG_SYSFS
+
 #define aer_stats_dev_attr(name, stats_array, strings_array,		\
 			   total_string, total_field)			\
 	static ssize_t							\
@@ -687,87 +693,14 @@ const struct attribute_group aer_stats_attr_group = {
 	.is_visible = aer_stats_attrs_are_visible,
 };
 
-/*
- * Ratelimit interval, in milliseconds
- * <=0: disabled with ratelimit.interval = 0
- * >0: enabled, ratelimit.interval held in jiffies
- */
-#define aer_ratelimit_interval_attr(name, ratelimit)			\
-	static ssize_t							\
-	name##_show(struct device *dev, struct device_attribute *attr,	\
-					 char *buf)			\
-	{								\
-		struct pci_dev *pdev = to_pci_dev(dev);			\
-		unsigned long iv = pdev->aer_info->ratelimit.interval;	\
-									\
-		return sysfs_emit(buf, "%u\n", jiffies_to_msecs(iv));	\
-	}								\
-									\
-	static ssize_t							\
-	name##_store(struct device *dev, struct device_attribute *attr, \
-		     const char *buf, size_t count) 			\
-	{								\
-		struct pci_dev *pdev = to_pci_dev(dev);			\
-		int interval;						\
-									\
-		if (!capable(CAP_SYS_ADMIN))				\
-			return -EPERM;					\
-									\
-		if (kstrtoint(buf, 0, &interval) < 0)			\
-			return -EINVAL;					\
-									\
-		if (interval <= 0)					\
-			interval = 0;					\
-		else							\
-			interval = msecs_to_jiffies(interval); 		\
-									\
-		pdev->aer_info->ratelimit.interval = interval;		\
-									\
-		return count;						\
-	}								\
-	static DEVICE_ATTR_RW(name);
-
-#define aer_ratelimit_burst_attr(name, ratelimit)			\
-	static ssize_t							\
-	name##_show(struct device *dev, struct device_attribute *attr,	\
-		    char *buf)						\
-	{								\
-		struct pci_dev *pdev = to_pci_dev(dev);			\
-									\
-		return sysfs_emit(buf, "%d\n",				\
-				  pdev->aer_info->ratelimit.burst);	\
-	}								\
-									\
-	static ssize_t							\
-	name##_store(struct device *dev, struct device_attribute *attr,	\
-		     const char *buf, size_t count)			\
-	{								\
-		struct pci_dev *pdev = to_pci_dev(dev);			\
-		int burst;						\
-									\
-		if (!capable(CAP_SYS_ADMIN))				\
-			return -EPERM;					\
-									\
-		if (kstrtoint(buf, 0, &burst) < 0)			\
-			return -EINVAL;					\
-									\
-		if (burst < 0)						\
-			burst = 0;					\
-									\
-		pdev->aer_info->ratelimit.burst = burst;		\
-									\
-		return count;						\
-	}								\
-	static DEVICE_ATTR_RW(name);
-
 #define aer_ratelimit_attrs(name)					\
-	aer_ratelimit_interval_attr(name##_ratelimit_interval_ms,	\
-				    name##_ratelimit)			\
-	aer_ratelimit_burst_attr(name##_ratelimit_burst,		\
-				 name##_ratelimit)
+	PCI_RATELIMIT_INTERVAL_ATTR(name##_ratelimit_interval_ms,	\
+				    aer_info->name##_ratelimit);	\
+	PCI_RATELIMIT_BURST_ATTR(name##_ratelimit_burst,		\
+				 aer_info->name##_ratelimit)
 
-aer_ratelimit_attrs(correctable)
-aer_ratelimit_attrs(nonfatal)
+aer_ratelimit_attrs(correctable);
+aer_ratelimit_attrs(nonfatal);
 
 static struct attribute *aer_attrs[] = {
 	&dev_attr_correctable_ratelimit_interval_ms.attr,
@@ -792,6 +725,8 @@ const struct attribute_group aer_attr_group = {
 	.is_visible = SYSFS_GROUP_VISIBLE(aer),
 };
 
+#endif /* CONFIG_SYSFS */
+
 static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 				   struct aer_err_info *info)
 {
-- 
2.43.0

