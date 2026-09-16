Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB9395AF2;
	Wed, 16 Sep 2026 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535456; cv=fail; b=WvlCO8BXVIBHqE1UIKTkZk0rk0iqEJqYVVqeBDxc6nGSb2sFa8YqnV7bb2LCPQhy1z5r4aB/fh+Mpz1rg0rY50Co7fTAR0l7TEJn7aSnvoOOKmaDtp6Waep6GHCJ3hIdiMCXxsKNpHkwUaONjyy+cPdlDvCSse6Egv9nXZlVfYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535456; c=relaxed/simple;
	bh=6By2Q1uVvDuRO45Y0b5asNRwqcGV+nK55ZJzySNCrkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gA/nWwoFn+9vgnggEnr3fScXXoueihPv6+nUaIPOKZn2THQtgvcjrx5Foh+HG4Iwj/w5WyZFUvWnpQTFK8MJ98M2x5wgArAkHOMpjDxYf/gomoK2QQpi9V9OVw05bFu2FrfHl1I/ZdEJUPa81voAEgGS2nSZe9P4slWaCpNzahU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SXKblxKH; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SXKblxKH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCfL1STqaXXfhwugCsF4AKP6ajz/qASb8ocR9lOQZMO1mf9Nar4rBTOKYTtuneAR2mjhzv8+1Z0NuXn7LrNI2Vm/5kop9/rF/FnKx/w2gt4CtRdHoy/z47gp4hjV5Hm7Ku58+p8sP0abAGpfHAguCEkwhmIcvksxfDoc5VDt/MDXlcbS4AXWdcPKdltnHqPTgyXDRcnSXZ1cYk7q4q4KY8B19VHWkPkcCAauZ+Wvl0GoPE/3OO46wLHTz9em8VNO/uFXv5CrAg9WTe+jq0gHoLIRU41PtrlT2vsWYGXND5yrgZFxCge22lZTYEM3nfzmyCoshSXjAmG/+MWw2mkDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8/FDeCufKOfLugd+rP8JGQibCSFhIVCissvLKvK5kc=;
 b=FLG5IS0cXwO9QS78keTkY3a0OuQYd/XrW9Rsry6bfWpuCry9W31WjRUDpJepGyMq/FVdbtBWsRpe+1PmJMGqgFkZ7OFTBfDjLfRPtLRTX5MquKSy6ugq7786Y6Sg0+EbakCAUHVKMvlTlxm75VYQgoJePjufW19zq3xYqtq+rEX0GGqZLLxc91zeFwKUfP4jFV0aEmzp0BbYlw1+gwFG0GY9JbTekyJOWGAjBkc1TSY5qjN8XaYruoU2vCe9q4F+O4dFswyJSRPE76ov2GPlJa3rLCllawcEsiigqi3oqnFpqLXxt6EbKVSyXUONFSZOR5Z3Wniuzx3DTGy2MtMpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8/FDeCufKOfLugd+rP8JGQibCSFhIVCissvLKvK5kc=;
 b=SXKblxKH1RPhwtorA8IpjDTaEbWs+b+JZVAjUmksJoc1jBgUMLo+NJDxfQDWV6EtHkTJWP3n0hofRzwGR0cTMRUs8SFx3uk3wtfJoVXsWWfszU1QX5QCUH2f2wzKaFfU+fCizhApxePPGAcG14rNFcwObYX/h7PTxpWKiLRo+jQ=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.14; Wed, 16 Sep
 2026 05:10:52 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:fc:cafe::a1) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Wed, 16
 Sep 2026 05:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:10:52 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 00:10:50 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Eric Naim <dnaim@cachyos.org>
Subject: [PATCH v4 1/2] PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
Date: Wed, 16 Sep 2026 00:10:33 -0500
Message-ID: <20260916051034.180226-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916051034.180226-1-mario.limonciello@amd.com>
References: <20260916051034.180226-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: b754feb9-0aba-44c2-785b-08df13b0e10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|10067099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	VC9KgA25nJ+QnVWNdRNOIeFWLHXi+2m2t9K5+2kiOct+SgxMULYGqiTmnb5gJHu6P9qp5CWgROeXVAClrzyDNln/r7zb84WlVLTCQFs/wn5Ut80N5Zr2YLasdcbg4OzXjgzSEJAV2ZcwomHT2g3MW7wP/4YnTvU/5UcPnpYfD5itvn08ZeVRBhEZLuI8wBVQxUUuW7LmXuoGLz4wMC1IaN5VdvBeQd/N3bC6bOCrAXI7adf9f4rmoYWx1AMHJyzGSfzoAFGZFTjRXqqHiaZD97g+QM5cKK5lISpzDjg10/emYeADNAHfU2OWSJWXnfIlZm+mHHboUz8Evoqc/JQftAsFADjDMkXGhxZF2JjJa6DkepH249UsmtrtCZa6l2762gAJl5AwHwlh+tsaMOIM77fol1nQvKKWJqL0DU6F5rCrztxM3VBFLY8iSY3M/jtP6uFRWIIJrGOdYP/kFesMDTIgALcNIJ6nsb5MZePHJDnhGl+AcnYdMqIRevX7S5NVcMGJGBp/qkDUjckuHJS2fwPuPvKFsy9lPefOgTKcucl7QHV6I+KLFKrOXUsjFsdVzedm/OZwTfCZHX34BCKzbSCa9rVXmL16/7kX3HhnAa5gy38/tTbMG8RLyPItJ3mnQ8WbbvlpTGxxB7Hv+ROq3xhm7oezt9+cFtOL69xTORCIG8J0WqFO4S95Sv5SQAlfFgp76mlHqHDDwR3Ct3j4eQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(10067099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	80wAB/dsUlifzyRvg//5E/g0DkL08q8Zlpc/knVcqLxnneLRvuD3F0wcCUIN1TN9+ZgN+xJB9+7SXmcOpJp3mBYnK6by6NJZZ9KsPBRT3B93TU1F2zwh4Yn6PRje2TCZDQPUfnQSTubnNHKFr+SvJvwJabAuhy6SnrS+1kwLs192YYofdkfdniRVNkXoAfp+Q85nZUOAmjVC6HmOaJZTAfe0SUn04DPh2Bf5C81Ku4obD0LreKzO+Ab8K08PZTgQA6AESOJOJwneiIO8nqyHk+Rm4fgElnZN+rgzK/7gN2pxdsrcVOTOuYqnwTAIlqe4AaQ5uLSsag4dawSpxDOgulsQ1t6FJdJEq6TPNwzmihJMffGZHwFyHJeLDnU/Fjmp5LSqtXebpghAmZXv4maCIMgZs+U3a+MMEow2QSC9w/AoJEL8nA1WIL9PQ/uqo3vl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:10:52.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b754feb9-0aba-44c2-785b-08df13b0e10d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

In order to unify suspend and hibernate codepaths without code duplication
the common code should be in common helpers.  Move it from
pci_pm_suspend_noirq() into a helper.  No intended functional changes.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v4:
 * Make pci_pm_suspend_noirq_common() bool instead (Rafael)
---
 drivers/pci/pci-driver.c | 77 +++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac8..8334214f8c1ed 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -818,6 +818,52 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
+#if defined(CONFIG_SUSPEND)
+/**
+ * pci_pm_suspend_noirq_common - prepare a device to enter a low-power state
+ * @pci_dev: pci device
+ *
+ * Save the device state and decide whether bus-level power management should
+ * skipped. Returns true if bus-level power management should be skipped,
+ * false otherwise.
+ */
+static bool pci_pm_suspend_noirq_common(struct pci_dev *pci_dev)
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
+		return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_SUSPEND */
+
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
 {
@@ -907,6 +953,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -937,36 +984,10 @@ static int pci_pm_suspend_noirq(struct device *dev)
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
+	skip_bus_pm = pci_pm_suspend_noirq_common(pci_dev);
 
-	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
-		pci_power_name(pci_dev->current_state));
-
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

