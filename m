Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323439A07C;
	Mon, 31 Aug 2026 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209764; cv=fail; b=jB5ckMxfN/oskGwD9Cu/veU97+8SCqWctOdQ9GAz710BCyW/wA7TlVESEGnSqKRwI4eFhpKhM3tWufd7vSS++2LMcAlC3allQv4EDLdRRjAZAh5mwdyjbb0bCsRd07RRICv4QiNKygGbZhcZ0NhVq6we1gLonDTYgNzEaM13mL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209764; c=relaxed/simple;
	bh=BEV7lqhsStuNaPnnrkS5VRHgEJtcyDpte9pNB++m4NU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/1D4T30sX3w1kV2Xv1BBdolZhzMJpFqgi1xIvYAREvH2ehskf+/odt6XTbtB440996+cN064zJMXzVQoFUsoC+e/QDNMYTMYpm37truMm9nO5nTliMqPEmDLNwhgXGAxoaV4bFy1obbbbOZIbR7ey9QqscupYGr1mNe7RsNYdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s8t47qQj; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s8t47qQj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duk8p3R7izgCG+IUB+mkHRloKYUCSGgFqflkUUr+gSlBJNUSWbQ0U7HUZR4xux/OB6hg8iBpn31t+sXMECxWx5DD15wdH6aZy/nAvuaC1pq9liRXjb4z/z99Xgn9KDBgoYb9uHRHje35gABXO+ULN4Smp5YZJORz3Viii5nGZQzYIzqXoR1Qau59Y+05C13lT71hNipmhIRQ3TUAU+wQb/voa6/7B0rS5Ot4dEKwbsn6hOk0rbb4QqVUabP6NV62vHxu8k5PPh1LfiOOvE/VmJL9SxtGxM/b6JC+6jVlG32rge2gzc+I7VJDISocck00tfZ7MCz7DlIqZDMAXYK0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD4x08UtncercJhMeL0Wzb+4undSQG4x3yFC/YaghtQ=;
 b=xQfF3ysVZi5XzAmUQVgvkJjFmDKUC+iQde7ek1EyOQ84a2jEtniOzN98eSAgt4/XUFJbws9hgqTQcC6zWcdIMNAkom+ycM6vFPyuDS91PHy8VLHv1HNRAojDWJkELqgIuSGQUUbQSFcooUfF/45jbPVsi0/dM4l2Xz6ze3HKQX920qoc/mNnV6UZ5xl+hN5fAs+6DjGG1rCv4v9ugoVQIejFA88l0KsJvwuqzUoYirEPpnkiHlEQnxjeuDaTMpLOLMDLWVCi8UT1MtYMP3YjA6kCGtc3/07U1IheRyHiGIUY1RclFBYkV2X77sO6aeznfo+6LjzXPowqLIaS7k78gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD4x08UtncercJhMeL0Wzb+4undSQG4x3yFC/YaghtQ=;
 b=s8t47qQjTdyJcZqqV8ZofpDbTOw4dcEgWIqO5RNBHsqNvJj+W8RCmQdc5aJrwXaJ8QQl7vtUOghA6ubTYdFnR+/3jmcDg6Vy76/5KaGzgMUTj/MamsLLrgSewc+xvsaOHyrx5fIUEXwPk9g42TsY4kkwWc8uPldfSvUP1d2JPGI=
Received: from MN0P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::7)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:55:54 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::76) by MN0P221CA0001.outlook.office365.com
 (2603:10b6:208:52a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 20:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 20:55:54 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 15:55:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Eric Naim <dnaim@cachyos.org>
Subject: [PATCH v3 1/3] PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
Date: Mon, 31 Aug 2026 15:55:31 -0500
Message-ID: <20260831205533.2325747-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831205533.2325747-1-mario.limonciello@amd.com>
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c718ffb-e0da-46df-5d6c-08df07a23f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5Y3xQpmaGMHena4T8nAAJHbe305GJzTYOhvB71oAye0Q6aQGCd78OW1GXj6oSVuFDaVJzMyXZNnt596vaWRPOYzZxEjRVdINitBOkcCeQtXaXJeSaUgoVkL7Nic4B+o0g62Eywhw0kC+i8QwFZMWwD9OYwVucnJYg2aJOGTVQtB+cz+1/8W9YbR2TYgIH/qxf7Bfu80eofuDQDR3WPXhYflS9JPxhdfOmjsuXS4CDDe+l8p1UM3hQIb1kYxSdDq81Og4kKRCavSSCk8HT5MoRLSP9A51+mdS3NK+Dxp1KfsuQMPagM8Gb5I1JV68/zKe+ibob+KrSHaijzOtAVFWjNJ2DHk1GXnnmJdKmUrKtPLVfnYuDFdylsstZAr1uDYCDAijXBL+0AbQ5ldlH07fBZyoNmfVweIN2z/Nmmi6NiIfZWfcV5MTQqBbfQzvWPSoSaMgdyzLE3PjRX17jIQD8zSMVdI91KThD9fgDRPU8WgUew+4t/aaavPABx+7l31RL3GTOG33CDS0C/6El8nlsfSIWql3eVjVR93ocgWkmYxqFM5XdYM/9/0ZHGY/l/LuAJhQIlU1YbPbw+/aFqhLlf/nUMJPeskYaSGR6WQ9zPKm14427njEw02mHIAUgAqXReVZ/otkoYXtahv2231h8AYcDI+q5U3034zumj41zT9vYx+JxRnZHuCVz+8SC08r49sjszBBCl0Ylauizcvutg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1xMMMIo2Azm05xxj122OKtWuRpYdg8puOJZERJdz1c0mITkUVtlU4Uxx19cFIsKyTy7RXcIv2W7xL04i8g1B59ef/OSNqpMUFX/t7Szg8FPOqBprxxUynFqYvORucMVBu2F3xCmPTaWE1YsknffzpVqib8s9CpwD9vvrH6FjwhWd6dnWw7jMeeU3Ia4UumUtrV0wROQYOll6vXQ8FhtnAcUeMxlZ44imEHzdM1PPJ1KLeTMRC8v7p0vPkNIXaePJk9gmwBdg4xDjCvmp+nbYNoDVSqEd5QEfGgBU6XxM2/xm+FqakZVz3VmJ+FCRqXSlhLNpShV8nIUwj+XJO/uOk61Y5cJluS2BNBYvYE3d/ea5WWf3vVJnMTCKVFIkFBkFzP0FP7HCbt+mOO+uVO+k1hOb/nmS/hXU/qoD+/V5nbj7lGE8NOI1dmHHIlymQvjf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:55:54.1396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c718ffb-e0da-46df-5d6c-08df07a23f87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

In order to unify suspend and hibernate codepaths without code duplication
the common code should be in common helpers.  Move it from
pci_pm_suspend_noirq() into a helper.  No intended functional changes.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 75 +++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac8..e3d352c7b31d4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -818,6 +818,50 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
+#if defined(CONFIG_SUSPEND)
+/**
+ * pci_pm_suspend_noirq_common - prepare a device to enter a low-power state
+ * @pci_dev: pci device
+ * @skip_bus_pm: pointer to a boolean indicating whether to skip bus PM
+ *
+ * Save the device state and decide whether bus-level power management should
+ * be skipped, reporting the decision back to the caller via @skip_bus_pm.
+ */
+static void pci_pm_suspend_noirq_common(struct pci_dev *pci_dev, bool *skip_bus_pm)
+{
+	if (!pci_dev->state_saved) {
+		pci_save_state(pci_dev);
+
+		/*
+		 * If the device is a bridge with a child in D0 below it,
+		 * it needs to stay in D0, so check skip_bus_pm to avoid
+		 * putting it into a low-power state in that case.
+		 */
+		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
+			pci_prepare_to_sleep(pci_dev);
+	}
+
+	pci_dbg(pci_dev, "PCI PM: Sleep power state: %s\n",
+		pci_power_name(pci_dev->current_state));
+
+	if (pci_dev->current_state == PCI_D0) {
+		pci_dev->skip_bus_pm = true;
+		/*
+		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
+		 * downstream device is in D0, so avoid changing the power state
+		 * of the parent bridge by setting the skip_bus_pm flag for it.
+		 */
+		if (pci_dev->bus->self)
+			pci_dev->bus->self->skip_bus_pm = true;
+	}
+
+	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
+		pci_dbg(pci_dev, "PCI PM: Skipped\n");
+		*skip_bus_pm = true;
+	}
+}
+#endif /* CONFIG_SUSPEND */
+
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
 {
@@ -907,6 +951,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm = false;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -937,36 +982,10 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		}
 	}
 
-	if (!pci_dev->state_saved) {
-		pci_save_state(pci_dev);
-
-		/*
-		 * If the device is a bridge with a child in D0 below it,
-		 * it needs to stay in D0, so check skip_bus_pm to avoid
-		 * putting it into a low-power state in that case.
-		 */
-		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
-			pci_prepare_to_sleep(pci_dev);
-	}
-
-	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
-		pci_power_name(pci_dev->current_state));
+	pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
 
-	if (pci_dev->current_state == PCI_D0) {
-		pci_dev->skip_bus_pm = true;
-		/*
-		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
-		 * downstream device is in D0, so avoid changing the power state
-		 * of the parent bridge by setting the skip_bus_pm flag for it.
-		 */
-		if (pci_dev->bus->self)
-			pci_dev->bus->self->skip_bus_pm = true;
-	}
-
-	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
-		pci_dbg(pci_dev, "PCI PM: Skipped\n");
+	if (skip_bus_pm)
 		goto Fixup;
-	}
 
 set_unknown:
 	pci_pm_set_unknown_state(pci_dev);
-- 
2.43.0

