Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0333BE632;
	Wed, 16 Sep 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535459; cv=fail; b=BTDDFNkh2bEzj9xrkJYtFtSWz1zdf/2Rpf1sJyP0ZhibG7EEbiOoranI5ounkhyOBfwqS/S4LQqAFBKFs2uI9r1hvLlwj0pedW3T75iNmj/sZWPuyGMI/j14paEv6cvNPM4JtfO6KF89lN7ZJWF72laP6A7BwQYlNbM7bi0mZsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535459; c=relaxed/simple;
	bh=690OWhGu9NmVasnDu+1ZXOmX5gUOcCxNRL+ZzBhmPdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keGt4i54YVQO1tTbiqzOcqAKgYzdUWnaexC/06pEMndxf73+4lwv2MXQfHA3nurTFbCHNsHd/fPSznRyMLymh8ISreOLWFLhCjfX0mpI0ALq74DwVGa+b5Eqn0tCqN2QvkI0HCu7NILiOwYO2Kh/pFyhx/Pucoq3BINYOqi6h+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DZjXu9ib; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DZjXu9ib"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbU4sQHVtJvbtXKnc+qQE0G6vuPf78DWsFieXgAeUyvFkt6avDrEGgPwDoeMCXzDuWePa6CRzUaPy4jIwdoBzg1yGwiLxc/vaDxxEEOXMoVAVm+pUXksMITay2mY+x4MvD4bfql4gqSy1V0OMFmstzZBq19pFomyKpygwqieZSE2QQ5i6eUm7DkiaVc9xcPSRcT6r1EsQFf7jlQfRCWnI1BiGZXCfsrvOICIKWoDksfbljpe5R6Ytr/AZOozEvJ36WRMt1XoA/0C000eZLT39Pz/v819m/nhu0rFBew9n19HRXruTjd5e6uw8UJHrCk5jKUNN9ySpj6RaCaKU4wCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZ0CWTq2yBr38MiWy5475quipw/iyLbm/EOtk+UzxmA=;
 b=rJyaX7Ox8fkjIl9ZuzYYO17eDFYyj1QO+9Rbafx+c/L0QwQ0DQIlMwn1mkI2XFdQ2Y+m8gafeLZvzIu5h4nrV40glfT6MCtm38SiZ2RejM0EBgxuRCt/kt69HBeTnyYL+jhWz39f9+QuqRC7M7w0wwQNtf7MWW9Y3/PzgCOf7L3xYc6h4SMM67KBCzioXisLtxCHV7lApK6+awZ2pHJeIgtqttR0N5cWjxyVlTvTvaeusCGfzLjeA+z0Xh18kT7XkImix3CeWobq0ZK4qg5XnLQm7nrq1tUwxcvzOFCWK+ufEPYmdgLoB9YJIUEI1YJNA28R5LMvSBEIP6lm+rKCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ0CWTq2yBr38MiWy5475quipw/iyLbm/EOtk+UzxmA=;
 b=DZjXu9ibk7c1ftbU4Ptqmp0ix4OQBFXuP8sdbyv8cjDLpKc7gv5BdFSidzLzdwGaTNZbX4DfPVNeeFRmuMLbYPsq79njed0gtEqLPRz0+G25a/inyfsLxL+K5D8mbHah+facDCYXMdDbOuYYqCmtB1k+Qv6Sy1RzuY/JEgNxnZk=
Received: from BN8PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:d4::20)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 16 Sep
 2026 05:10:53 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::5d) by BN8PR04CA0046.outlook.office365.com
 (2603:10b6:408:d4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 05:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:10:53 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 00:10:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, AceLan Kao
	<acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>, Eric Naim
	<dnaim@cachyos.org>
Subject: [PATCH v4 2/2] PCI: Put PCIe bridges with downstream devices into D3 at hibernate
Date: Wed, 16 Sep 2026 00:10:34 -0500
Message-ID: <20260916051034.180226-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916051034.180226-1-mario.limonciello@amd.com>
References: <20260916051034.180226-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: fca6917d-91b0-4347-af9c-08df13b0e1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700016|376014|23010399003|3023799007|10067099003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	nwY+DXn0GqZlsX83B6VMNE/bFcL0eARYWQEJq/bR/uchdRAYlM0RkHaQGKpeuQ1l9L+SRV54WmeCjpv2XmoLH1B2vT3jxxanaIcgi4vDWGTvdmuASCXMEalHjnwyvvkvNJMQQDq++zAXqzylOowzZkdWSraJGE76DBmjBSux+fbVuT/aBXfIijgD6ShTn9G92xVJZdA+sQlJLKf4V3vSXjTqkriZj2hTjUfl6pLrRq4ghmy6sRMy6a64zho5Xjt/hVz5QWGJezBKJy4Fi8Y7NBuU8KXbfU3ygiDRzguWdm22nmqnyO09XwuK64fCZoSQlrPyZWFIY6dDnkJ8M9MjdIGiWFq9BSZDOj58vJFqqiFUzunaWdm7vpI83DhWcFwYIgKmwZhfw3GCnOUW3V7eGO78Kr6MP9nKJN05EGJnE0OSKDubyT29caMV0ebBCaAJxBDudMrrFI0t3grLNE+THgpcmoqjjpl39u7xzZ95mS/GXu6/HG8QqmacpDuboIWWOTPP3ylVcvakBbn9WpBXwAT/db8H6X6R9Oj3VK0e3RC1E+kVgXGe8MtHTy/Q04LrZr0fOTuxBOTQ30+Lr4l0amcoFgg9stGxvQyA/h4YUqf9eR6fcue5kAQVXA5o0KXkzdBeN8FsSY1IpiL3skcxI4RRqQTfRdjDgPE9Pjri10tQWPAKztiEsrjYTYrBQgQkj8OwmxXTU1axqvCqOg5VBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700016)(376014)(23010399003)(3023799007)(10067099003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uvbSOo+zpUMq9z1dwWyeJI1vcWsWJ2P0jMyTJqq2jt77ZHtu5E1cPxVt2vQrpXk2traZ9mNle49HHQ41ETSCpymEwpYvS6EGJpFrdBuY/b5MNHxUEWOlTGzaQdfvbhfz3VF30I1KJdVWoYOwosHRlWSzdtx4hcC12o9OpHhGm+Iv8xlIHD+KyXti0PbeGvGqi0uYbCGFqnSR6dLVABWxnt8lWYy0RZu3a8pohdLMUg8JjpES027CefQVWWEgrCb5tWW893jJqFTATj7sW1E2z26D2vgOP35mq1afPxjNixFKhs0KsMd4Fea5/lENrHmZcNLYz8dermsE8hz7jb10HpunMyYHO7AB3JOweUqWEQ1CvXzEt66AzAWRGXTPlFCYuI6qrDLmYCo3SoNrAfukT+N0pt+6zVQjShNY+IZH0ox1DxJ8bmwYFk7kU4VpwUFn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:10:53.0737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca6917d-91b0-4347-af9c-08df13b0e1aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

During S3 suspend, pci_pm_suspend_noirq() puts PCIe bridges with
downstream devices into a low-power state (D3hot or D3cold) when the
platform allows it.  The hibernate poweroff_noirq path never did this:
it only called pci_prepare_to_sleep() for devices with no subordinate,
so bridges with active children were left in D0.

The platform firmware leaves bridges alone when the system enters S4.
This prevents being able to meet various energy certification criteria
for different parts of the world, particularly in designs with a dGPU.

Align the hibernate flow with suspend by making pci_pm_poweroff_noirq()
use pci_pm_suspend_noirq_common() instead of the open-coded
pci_prepare_to_sleep() call.  This reuses exactly the logic the S3
suspend path uses, including the skip_bus_pm handling that keeps a
bridge in D0 when a downstream device must stay in D0 (e.g. a
configured wakeup source) and the pm_suspend_no_platform() bus-PM skip.
No restore-side change is needed: the hibernation image is snapshotted
during the freeze phase, before poweroff_noirq runs, so the powered-down
bridge state is never part of the image, and resuming from it goes
through a full boot that re-enumerates and retrains the PCIe links.

Because the poweroff_noirq path now mirrors the already-shipping
suspend_noirq path and is guarded identically, bridges that must remain
in D0 are unaffected; only bridges that S3 suspend would have powered
down are now also powered down at hibernate.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Denis Benato <benato.denis96@gmail.com>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8334214f8c1ed..3f80c8e6e0e52 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -818,7 +818,7 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
 /**
  * pci_pm_suspend_noirq_common - prepare a device to enter a low-power state
  * @pci_dev: pci device
@@ -862,7 +862,7 @@ static bool pci_pm_suspend_noirq_common(struct pci_dev *pci_dev)
 
 	return false;
 }
-#endif /* CONFIG_SUSPEND */
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
 
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
@@ -1217,6 +1217,8 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1259,6 +1261,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -1280,8 +1283,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
-		pci_prepare_to_sleep(pci_dev);
+	skip_bus_pm = pci_pm_suspend_noirq_common(pci_dev);
+	if (skip_bus_pm)
+		goto Fixup;
 
 	/*
 	 * The reason for doing this here is the same as for the analogous code
@@ -1290,6 +1294,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
-- 
2.43.0

