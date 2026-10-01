Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEB03E3C4F;
	Thu,  1 Oct 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870187; cv=fail; b=iy6qTwjs9uMd+ZYgy4ht7cEeR0319U9IeuE8h/kpVoj62DmHnNj8+kZDmjh9KFz8So4+7oaO0ISDCpo+DN6Jl2oDF22JGQ4Mpd5LrkEvx8b1mhutM3+v2sw+q7W5cIikjoWEMQ/1pt693+S8cA7+WrPEi0u/b/wJRL+GuRL07Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870187; c=relaxed/simple;
	bh=iG/F7Ip5OHyATW9w5dtFcXO5IKJCu6UhswO4zUpzzeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F08P8Jw/rd/NBUGW/k5UXec0XKTfYNowUZPhELWtrBbrCnmpLVKC7Qa5OGGdtZTSmXT6hXY6D2B/rS5zovjghHNOXtZYPiYxEj0niCCn1yjO5jfb0kF9QPGeDe5B8NsSJF3S9iUPUJVyvPKXbnK7+BI/HJZUzpLmiVw4Xy3bPWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xUWZdRVy; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xUWZdRVy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDc/glVyDqN1Ulz6H6JpH+fKMuv6qRrnfK+xZgjri4skLsXXeGG/gx+csuioY91bU4HXxQhwROE29wwFb4KomNoW1fJfKu9ZkYgquRlmPE4H90dTs7YHC0UZJ6Ktjyd+gyylJx6EfAGsvLCSeYjgIiP87t+m8PBmiuBI0rhdHRJ3bCs1ZIWheFneh3+amLogL3ccq64c76cI0HNPRPgY91UrtOzX22xQASF23HcqF6HfNPFO6sOXZd+sWXoyecIGs5kKw8Rq1gmXRxvhYSINojYN9Et0OhOzZaP+f7N02pa875s2H6N15WcDy94ijRatEwGNLDkacZ3Zpm5QjKEwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz/FRzJzHPHtgXYb+SuBCTC1/Ph/RTB3v8VKoq8bAKc=;
 b=ZAzVF3R90TUa3mXqyM8m5wzyK4SexIz5uMCbRuarhUECogDz1wFGqFJZnFFuEAw7YXk43fwfxU5lFkSgHiX5Q/Ki/jdIAXP3K+p9FSuykykCrVZVTZ4WgEupP4wMWD9Fqnncf7blKMXWQA5iLNw4cUmJuKZ1F/E2GttfW43auLij6TcQtJaly4/lteLE9jbNXhZU7uicjZgRs9j9uwTWPYZQP7FX/VBda2t9xUDTxFjp6OOaPe8bjrjckrhVdhsVZGAwbVSQZU+siQ279ywDqxLd/HY6JTgoEFurWsVkwx/hJkLeChTXThrKyRR2BEuDjoghoaUuqJR515AheDWtdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz/FRzJzHPHtgXYb+SuBCTC1/Ph/RTB3v8VKoq8bAKc=;
 b=xUWZdRVyu587k7mFlceKUmY+fLkntHJzvQWbyPMZxUtyDa6hqocqLK21AD0cG4SR9ZC14pHXZKq7r+qnafC+dPt+D76hhZ5ZZqxfGUpLi0AmswPwZmrF7W51Xxyp3/0ZkrPgy8c39tFM/VxEj+H8SZVEQgDJ8LQ6rOVbpt67IRE=
Received: from PH0PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:e::19)
 by LV2PR12MB150617.namprd12.prod.outlook.com (2603:10b6:408:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 15:56:21 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::67) by PH0PR07CA0044.outlook.office365.com
 (2603:10b6:510:e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:56:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:56:20 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:56:18 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <fengchengwen@huawei.com>,
	<wei.huang2@amd.com>
Subject: [PATCH RFC 2/3] PCI: Add per-device debugfs directories
Date: Thu, 1 Oct 2026 10:55:50 -0500
Message-ID: <20261001155551.4182899-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001155551.4182899-1-wei.huang2@amd.com>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|LV2PR12MB150617:EE_
X-MS-Office365-Filtering-Correlation-Id: 099d39b7-2e27-4a06-2e9f-08df1fd48937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|10067099003|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RKeXn2cI+xAMhcJ/0FImpqIUZs0nV6EwLXxMGeY0ag3OjFMVTdukF4+GudnwdKCNgeKpFFicY+u+xE4yRkvwwxMs2fVg9sspgmdjHAkvVdB0z/WDlHTTO6RdHsdDL1Gh3iZk5WatsYTQhjGlb7Xm+shrf3Wz8w9Rr/2jvQ36/n+fRONDPgFW4yK+c9b1ie4xhAve3clY9xAFp9hobtxryScell8ElTzGN85PLeU8uiiK0XbjuoB39nkwQeDx83RU3BnmHe68wUJjhiTt4awkL1sM1OWgbLhP97LQPJuGjP+Y0DtIxdopOYED8zFydbJU8UGOqsfPUUug8TUM2ZGw5zR30oyhOm+Xnifht4XxPkyxw4WTGA5JetOnFYlzZwUny+eBQnmzTNT1+IYTRx8FME+7YBDP3oRD2KCR5o/ZtFwvfHJN+Xj1lCArmY36WNrxI+BSl0+8NUdi0w1dq3vCp6BMqqA/8ap/CCwhgg6XuDCKPLNmsnCOc/yqHhoCk7ecJCL37dOG3x0vetJSxK9zw6FBOWGsapagQKGqUhCp9I8Txupbl4bKcfbI9p4SW9MKX+bewYSeK4TI4dT0ejgg/cs3tf12I5FqZg/B+j8OTcEaKF/V1DP7bvljRs9pSYy8YcWaaED6NmdXZBPhj+1IY3x8QWUhIP/mAt6mpnyjOfgrUmtyQnAGflQVFqfAa0S3XBGuuUHVmU4S0rkNLQdQyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JLp2nX0or223feCmqR3xatbYalNlsSWE6/GUgI8qERyOK5nLxm8OV+Kk2a+Q1UDm8BT+cb6DYa1SNDcQUZIePG+FDMYfficD1trhTBZbxxgTSNpK0Fww0mvAVIbYY+wz7I38CihryvFyne7pxRaDOjEnq9SW7ao7DOI+xc3vgUj2/SlLL7u4qfyFBfHJGadcAR4XvrwVeegqyj6y5oBX7KN6eF+yqIjjHrgy6iNWpTUax4nq9v0sryFDq9o6qijqtnMfQ5tp+GoyHh0irp5HncMi13Tvb7eXW89Xd/kMp3XZYQZuoZZgSM51GhAl6LFYove+3P9zv7zb2CVozirb30jjcJPXQa1k7Hil6P0WX7kH8KCXsDA/NJJDFIR8K5htmYnWAkrSd9DfutxjvI41ByLwSSjUSJwFo4nX5P/Nf2MsGPgbuReFns1M6w55ELw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:56:20.4797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 099d39b7-2e27-4a06-2e9f-08df1fd48937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB150617

PCI features that export debug information have no common place to put it.
The only existing user, PTM, creates a "pcie_ptm_<device>" directory in the
debugfs root, which does not scale as more features follow and leaves each
user to invent its own lifetime rules and leaf names.

Add /sys/kernel/debug/pci/<device>/ directories owned by the PCI core.
pci_dev_debugfs_dir() returns the directory of a device, creating it and
the PCI root directory on first use, so devices without debug content do
not get an empty directory. pci_destroy_dev() removes the directory
recursively, so a feature that pins data in a debugfs file needs no removal
hook of its own: debugfs_remove_recursive() returns only once no operation
on those files is still running.

No functional change for existing users; the next patch is the first
consumer.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/pci/Makefile  |  1 +
 drivers/pci/debugfs.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h     | 12 +++++++++
 drivers/pci/remove.c  |  1 +
 include/linux/pci.h   |  3 +++
 5 files changed, 77 insertions(+)
 create mode 100644 drivers/pci/debugfs.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..dbc841c3e990 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -15,6 +15,7 @@ ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= pci-sysfs.o slot.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
+obj-$(CONFIG_DEBUG_FS)		+= debugfs.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
 endif
 
diff --git a/drivers/pci/debugfs.c b/drivers/pci/debugfs.c
new file mode 100644
index 000000000000..682fb614d7cf
--- /dev/null
+++ b/drivers/pci/debugfs.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Per-device debugfs directories for the PCI core
+ *
+ * PCI features that want to export debug information create their files in
+ * the directory returned by pci_dev_debugfs_dir().  The directory itself is
+ * created on first use and is torn down, together with everything below it,
+ * when the device is destroyed.
+ */
+#include <linux/debugfs.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+
+/* Serializes creation of the root and of the per-device directories */
+static DEFINE_MUTEX(pci_debugfs_lock);
+static struct dentry *pci_debugfs_root;
+
+/**
+ * pci_dev_debugfs_dir - Return the debugfs directory of a PCI device
+ * @dev: PCI device
+ *
+ * Return the /sys/kernel/debug/pci/<device> directory of @dev, creating it
+ * and the PCI root directory if they do not exist yet.  Devices that have no
+ * debugfs content never get a directory.
+ *
+ * Return: the dentry of the directory, or an ERR_PTR() on failure.  The
+ * return value only needs to be checked with IS_ERR() if the caller cares;
+ * it can be passed to debugfs_create_*() as is.
+ */
+struct dentry *pci_dev_debugfs_dir(struct pci_dev *dev)
+{
+	guard(mutex)(&pci_debugfs_lock);
+
+	if (!pci_debugfs_root)
+		pci_debugfs_root = debugfs_create_dir("pci", NULL);
+
+	if (!dev->debugfs)
+		dev->debugfs = debugfs_create_dir(pci_name(dev),
+						  pci_debugfs_root);
+
+	return dev->debugfs;
+}
+
+/**
+ * pci_dev_debugfs_remove - Remove the debugfs directory of a PCI device
+ * @dev: PCI device
+ *
+ * Remove the device's debugfs directory and everything below it.  Returns
+ * once no debugfs operation on those files is running any more, so the
+ * owners of the files can drop the data the files refer to afterwards.
+ */
+void pci_dev_debugfs_remove(struct pci_dev *dev)
+{
+	guard(mutex)(&pci_debugfs_lock);
+
+	debugfs_remove_recursive(dev->debugfs);
+	dev->debugfs = NULL;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..aead99a4ea34 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1059,6 +1059,18 @@ static inline int pci_resource_num_to_vf_bar(int resno)
 }
 #endif /* CONFIG_PCI_IOV */
 
+#ifdef CONFIG_DEBUG_FS
+struct dentry *pci_dev_debugfs_dir(struct pci_dev *dev);
+void pci_dev_debugfs_remove(struct pci_dev *dev);
+#else
+static inline struct dentry *pci_dev_debugfs_dir(struct pci_dev *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void pci_dev_debugfs_remove(struct pci_dev *dev) { }
+#endif
+
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
 void pci_save_tph_state(struct pci_dev *dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e711ac1d4e38..e10139117d57 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -37,6 +37,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	platform_pci_remove_wake(dev);
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
+	pci_dev_debugfs_remove(dev);
 
 	/*
 	 * While device is in D0 drop the device from TSM link operations
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..251d6eeef087 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -580,6 +580,9 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_TSM
 	struct pci_tsm *tsm;		/* TSM operation state */
+#endif
+#ifdef CONFIG_DEBUG_FS
+	struct dentry	*debugfs;	/* debugfs directory, if any */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u16		acs_capabilities; /* ACS Capabilities */
-- 
2.55.0

