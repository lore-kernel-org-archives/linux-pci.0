Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB339C017;
	Mon, 31 Aug 2026 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209768; cv=fail; b=a3B72+0UxJX4CimUpbHm+NilY1PKNZpD2FILSjTR/7DtCTIM8Yn3nRB9jk4R8p0mG2mPmS8DJDQ+qdx0FPrwLj3pO2MuCJn7lI49l2ydTnb5f1klItybEWqkL7e2tjc2wjfQmnhdvVmreBZfD5ZOxdHdsCQ9mMsvIlVf+KOI+fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209768; c=relaxed/simple;
	bh=R+OYr8Ay5Jobwjie7dsyHiGUtv5lDbXWhfZ67mZUszU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+imcm3u5si8StCax+1YPSAC03zgAoIs43xDgdiS+gmhtk/JMcs0ju+5ILqi+5RafIYdCAUaI+4oNq9bj66fAIA7CMlSHPSxcNxn7B3hD6RQ5xOp5XvbpBVNY45e5Nx2U9H4BM61UBTbEx6M+/hfxzzAFRAoyOQ2xmq74DPFCh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e3bexQdY; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e3bexQdY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgzWJwvltjd95+e5OHOCOFldLAKm56GJUvSFpL8neq7ZU2clPF7Z7/oZXQi9jxDDA+GYPdUzk5lcS0Lx6+aoUQxkeItXiapWqVfNSYOlu6zwK6V/HVi2xAdhEhI8+AbbEOZV9m6SHAe8UKJ6yU3wESXn+Mny3kTBKuUMFc8G1DeR0dA7vGt9SlDqJyu31xVfsot8K0kG3UYx4nIOGHFk6fKptmot8rPTXcT18OihGugJYAeQjW9L5tx/k73PtMMByIWwrgXwy0EEdj0Npvfu29ErSnZ/eyFMDavMWayU6bab77TG81dfJ5cbiZ7OZeHbuDp+jLueEfhA4ue11kY4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u53UC/oFOVSE/S7vJq9416o3dH6jm9xSuyx7qkZOcY=;
 b=cCH1cSFE0ObsOCc7lPUcUuJz/QdkgeoI42XFI+hVz4bGFFYpXOEVKYwp2cRR/lt7Edhv2AUSV4L/wComjNHt0Deb8eoxQrDtA02OPRQLMHL3e4MGAFtgd5A/rlmraHg/kO8vk+XqcEfPnlgJaJYZa3m0LNMskWZoomxfBliXlliNM5cfmx5bIKSD9e3DxW7ZIXdQD403C48r/1YmIN3MLTzdEVrPWGgzLvuUSdx18v0nLk1GxjlTXVIj0uo2Yk2XeYgMt8qr9hbrj9rzXM9y8rT7cwGVbCnrWkHL2LUVaxRRxm3q5M0qbA+yJGTVTgaD7ggtaC1YimmLZ3vhUCL60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u53UC/oFOVSE/S7vJq9416o3dH6jm9xSuyx7qkZOcY=;
 b=e3bexQdY2ra7D0WQtDoCQo1jJyG3Ax97TP+Mc/9fbmLT8YEEICDK2joHjU2BdadumpI5h7XPYcfac1RvVEmRoKSXYD3/+1o4JGdqoSOdy+7lmUby+R00TQXieX9Xt4ir/4wgNML3itMvMk89+t/vk03q97cFBA4Q03z47d8zkMU=
Received: from MN0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::15)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Mon, 31 Aug
 2026 20:56:02 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::1f) by MN0P221CA0005.outlook.office365.com
 (2603:10b6:208:52a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 20:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 20:56:02 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 15:55:55 -0500
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
Subject: [PATCH v3 3/3] PCI: Put PCIe bridges with downstream devices into D3 at hibernate
Date: Mon, 31 Aug 2026 15:55:33 -0500
Message-ID: <20260831205533.2325747-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831205533.2325747-1-mario.limonciello@amd.com>
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d86f3e6-b7b1-48f1-5308-08df07a2443c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	l/qFINQwDT77pZM7erz2eo2ZvQ3/pD43+3jLI65kBBUQmDLGWYX3kT6FLENjv3F86dk4rvTtPNcZff3Sm3GgJ0thOD7+N3N8+dYXEe4+PawkwvDPbEP//TDso3ZYhxtquQDAzF4I031tGeXR6CQ1NSfkWcsgCgAq9kLgRfbXIIQO3JIMezBKhLUr/CDiOVoDz7hxL+hiDLZMTU0+GtbLsLYsmwnorci7fQZ2te+hNiXTwYKVNQ6GMv7BEH5ifStBPaq4ZM8wQD88MPIoGqO03Ph6/HVVctMLXGSJzFaOwuYs+O9xqtqEMQgJdlt5kY9LadwWDjVCY+S8xrA5JTwOrRq/l6KazAHuUKXNIgvPDOFR6nCXU6V3hbC7BqG/4r1neM3wiMrHGWs6TpFGavRT0sQPu9bx36/pU5z/hT237b+daNxs9k4f1Tl6zZzLTNIJZtJCli5mupOg+Vli3qfoGP0llRFrMgvUcJ3chH7ZJ22r/QFz+hn0odqDjiTS152fP5RCIsldbTiUkqwxmsMvra+fgpHcG84bgloUCOqLOafDil2SVMvkmtDm57skbWBSHlXmed5pUCTiwnjK3TXfQF1Cay7sE4XlGj3VQIqEAVi/NEDfXAlfLMIqo1ObRbHLAN0zXP7im9Ava5HPnF8NkQ+p0Gim2gtu6wkgODmyxS5D+vmUZPnnp9bQIUFUroZyTVU61Twj5FEspZzaaKRSpA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	szeKpFTzQe9/lJcPfa7uhu2x4iWEunwkVFpwomaNU+ASU0s8X0Wq3RO8tbC1v0TWaVjlLu+fPZD1e/udmzg+o5WtE+oHKYjc36GwKmGBGS6DP7S9PsFeHp8pJQTh/vI2LDqbyCZ06wObQ0ODTHXj/ONz4BLMNlC+M2NS1s3NYK/uhYVwadJ+QR9+yJbSC9IyKcEBXY4wPDrQxlNZ4gmI880ibYt9UNj3DojvsgmXlyiEVrNdhAOe02q5byAa3OfBH8MJwSDIVCYH/6SSScyFwI76nHAfDKQprWQvJeRQcShsAPfwzK4FvS7X0mhzRKObHi/K4JrEB3LIQTc6w4ww0mduMQyXJw6RwEeQ50XgQhopK7qcV8ot1oS9qg5it75rtNMDbA64yA37lWMLi5qFzi+YkH7vq52uLRPyNwakur9o6F7YqPug/fFFAI/GBBcl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:56:02.0369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d86f3e6-b7b1-48f1-5308-08df07a2443c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

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
The restore side is handled by the preceding patch, which runs the
bridge power up actions when a bridge comes back from D3cold.

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
index d15b3eb55ec53..a6fb731378d9c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -818,7 +818,7 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
 /**
  * pci_pm_suspend_noirq_common - prepare a device to enter a low-power state
  * @pci_dev: pci device
@@ -860,7 +860,7 @@ static void pci_pm_suspend_noirq_common(struct pci_dev *pci_dev, bool *skip_bus_
 		*skip_bus_pm = true;
 	}
 }
-#endif /* CONFIG_SUSPEND */
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
 
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
@@ -1215,6 +1215,8 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1257,6 +1259,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm = false;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -1278,8 +1281,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
-		pci_prepare_to_sleep(pci_dev);
+	pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
+	if (skip_bus_pm)
+		goto Fixup;
 
 	/*
 	 * The reason for doing this here is the same as for the analogous code
@@ -1288,6 +1292,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
-- 
2.43.0

