Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020F4E430C;
	Wed, 16 Sep 2026 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592084; cv=fail; b=cYo42VrwP9Xl2uaDGpoyj8IzJqhFIkWQj7UpheQUKO8znv3d9rttVGzwMzpgbqWfBw2aXHN0QyVI4zCtdYsvKNDPn3ppz/UHERg3EQnrKGxsQUyYO1AE1WU3A0Zo1t5b9yR35N+uQRbWC5ePFd+TfBJqBjSELmG6DUmUSbTPU8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592084; c=relaxed/simple;
	bh=qq3AFeOIaTOQ3MpJQKX5fjZhCUHlhcKRGvYPfO0L3MU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jc3Mc1N5aRkSVvuxi0Czy2ap0vyVFsoC/MUNwJCwVI/0GTG5B9X5hLZFLGv4yFupmBegsmIAHlbsqOaoI1z3BhLSXV6UweZVic59ypLU40a+wOkrD20tqEAO8p4GBJiGrWTidgj8vY16bPp2K7I5RbNTEjb3JBo6lf/k7YmurO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XmFMzfIe; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XmFMzfIe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPyUvZZscn02RrHDG1IR2pQuzboY2qDZVmyb6I3cSpYrO3aUlEZhhsk1ox/Zlmwj8trMo4P9Mz9Kuc2B25oWKLM0zrGf+n4Cj8mJEsYqROfIF+rIhfrA4iK941D+KVWV6tEwVdkeR0gkhudRNRgq0saBnIkvdCvHDL/Y/iqEwFqrZHUe7Pq8AKJgGsKNSWuNvez+8cZdKsn0OgO1IbcFnxtXIncvhwxsE2BTnQmrjX4g24gWjV6Dh0xfSMOipWBkjzYYdI+X4YxT8yQDnZcAbpVxj1HEtxIfLbfaYTE57ibKIKT5jw627PXNDqP/zWrvScZss6FzJn2QT40sWxQ93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwkaOtGBfFBzfGQSkXtc1Ds2f3K84fD5x1aBIQTPxrA=;
 b=pGxt0bnbEJzD4uo6W7QBx9ICVZErV304qti9tKFJtQ2SwqHuGFcA7yOj8rBEq8D8Rr1duwNkwqc3deIxw7FvZQoHboFY29dLQU46UT8628aAUNcyDfS6RySwmftWnLqMG4+xh0uyVPvJEZrubxGIsB/aj1XKWK/iQWU7WJWQzhhTKmHcbL6ziJfd1zIpYCNWZ+oOdOAriL9a4KX/hElGi9e5y+aaNHQCafhPnn3OtPPWa/2Jp25j/cKoisbztzcmYJKVk4Ma2BjRaLNiXv2jEKF8GqX0ywe4atIBam5+z4gQ79X7zVGyp8qhSaGZvPUlPwfWSzLQl2g4jANYE9c39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwkaOtGBfFBzfGQSkXtc1Ds2f3K84fD5x1aBIQTPxrA=;
 b=XmFMzfIe5Wnq9IADHM6jkj0N07ijGgxrtqVBHTsMZd4gJfITTR6/RR3H+5LvBkCJHDIj4j5OHRuAxqO4yPnLN1RUGJK+z0Q4ADSURHVWc4ww6xcVbqvanvrFQQcnQYBLRijnuzmHKGwccky0xFFc5UGoU3rGlo7swvzvFPCq6GY=
Received: from CH0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:610:e7::17)
 by SA3PR12MB176418.namprd12.prod.outlook.com (2603:10b6:806:513::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 20:53:55 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::3d) by CH0PR03CA0222.outlook.office365.com
 (2603:10b6:610:e7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 20:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 20:53:55 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 15:53:54 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Eric Naim <dnaim@cachyos.org>
Subject: [PATCH v5 1/2] PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
Date: Wed, 16 Sep 2026 15:53:39 -0500
Message-ID: <20260916205340.2466679-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916205340.2466679-1-mario.limonciello@amd.com>
References: <20260916205340.2466679-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SA3PR12MB176418:EE_
X-MS-Office365-Filtering-Correlation-Id: 122c55d0-28fb-4ec3-f7c9-08df14349f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XQK2Lq2oc7+HjAcg2T/djuTV9+PO6Ls3CXQ0JP1ph1uNfn7DWyu0n3pfREHMxQGOwKPf5Sn3gYqy/ksJkHA3FhfVe0jxbDwhVkHuWL/sPsc1sB6EZFmVdKqFeC0uOHNeS0GODv6y7bQNsF8Z6Hs0yDQYjMEsmQ5geUYi44uh9TopiHGFJHVagiNYpffsBdCi9tYB5wEWJNdllMlx4ttRzu58O82MFkkTAXFSmZyireKMdD/sjeN6+xem+C1M0ZIiZYMPyjElKP5S5KsjP3UJLaCPZjMCEYIVAbYeSt4l/q3LaZDIII99np+r1plyEqgkdz3pF+uZZUpmTmwx0fbDUagIilg3mkf8BRM8X+kiSwZ+YB/z6LD+l4aoYUfbhOBdCPwWuchOHkqCe6z9/nKqJm7ibXShovPKGdY334IETb62NvewjsVwC7Y1ADXxmKjBeItnTUsskDpNqfhVVC/1el7sDQwo/J8vOpKxhFRhz4vQlhMb0Q4qiRbKcv7u+mGsnhP3hCH9OzH9AaxHMl59NnLq4Ei29PDqB6WhBLteXrAxhYcwW3WgP+0BixW5kNJKDLIDubIy0JEFoXTAL6Uo4aADEtfeaaDGSJ11ha68r0BvLvVMFAgPjas8Bji7PCZsrrdDVmgUMQnAMj2mHCN8fRL0aCw27Ln34eqK0tsg0SziNaT4JMAlUQ93aCRXOQkwQmMJf6wRkFzqfHNAVKGpwQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qbq8ztRx1hzkJ0RfpvrvgL08sMJUnf2mXYW1vZL2JHHBVTZdutGAKiAfVyd3kT47MPLL2SX/W2X9E7tOna7wE2x7PbVgJaTvkUBJz5ak50Bo6Wprybm2srYXIccg3XRiSXGdRMeMFWj7mPFw0bXYrG5+2WxIQOwf6p3xJa22yk/nXk88hHbbrtBHJ9GobJvw4IgkJLrPCo+4nO59vczSt7ySXY5j91vZAeWxlBCFyu315cWBfw1H2e1frJF2GFF1Cc6McuOeif1EIwqbmfMHZe0gQJzXSbriJp1KXEWCkpMJ+MarIsc4z6wlu7SrlLMTX82zgJmZUu8iw1+loi1taDlTpWiIhLWqgb0zqRgJg2OpJ6gdu7ayxG8U7w/JBi8GE49iTzYHoSrl5EqKRnsfUyvDjOn5GydCK56jwzQM7/dZYR+vzXdTijZJmxbnlA9S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 20:53:55.5837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 122c55d0-28fb-4ec3-f7c9-08df14349f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB176418

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

In order to unify suspend and hibernate codepaths without code duplication
the common code should be in common helpers.  Move it from
pci_pm_suspend_noirq() into a helper.  No intended functional changes.

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Add tag
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

