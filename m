Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F413260565
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068564; cv=fail; b=BduN5QMHR0JD0jqofwoWX+gNiRnNEVDeikrqmTVEU2ObOn1mTRx+pVFFqrOcjycuKr96oEFEVx/Dez1Kn5Hea7jWpNEFG2L0A8YT5SIXNyCW5qHwm9eHYDUXPavlOhzuBWW0VukvjH+hox9awREopHYx/VySnYOmSkBWHsGkCYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068564; c=relaxed/simple;
	bh=UPNRwk17InIrGvR/2jH4u7VKY2FUWYxV5ueGONtat5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CR6/P58ZHhUZmI1NtDx9/wJDL53CddUXHiJ1NvPIINaExiTW2FALVZZky3OMP0bmXaU0YuvHzCRhSUOQ24enbuYR9152SVEp2WpRfEHP73TblfTcjLciWLx0UtX9s4gwm0dLfZzj/5LloxrTW2nIoZvGUsSC7k4ljdScUQZPfYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ryw9u4hq; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ryw9u4hq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vtw8Nm1Qm8k94dQ/s2HV3zs2hbkYapcR09lnDHV01PEvUGzLixgTbHvoMTG78dJKmBZSrK7Ou/j2eCS6NSFxiusYDLKDeFZDjuPqnQqGnz2YRN2wZhCnmTUHO76jhp8NLp/kd+uh2ywL71LylLt0M0ZvFTjO4zEsbcIZeRcqY8lRRC9Viil8KZjGuzJk0EGtfrmdEn6cY7tHn+pKitNr++626d7zBS3LLrANVmkh9vQjwPb7LfREq11V4luY6jA+AlGEpp5Pu3KaaIXRMCbiXre4FeQoBVqSg1G8GcpaySTmq8GQ7s95lF+isilgR+wiPrw8JFV+cYZSbU8O6r457w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztxHBdF23VK3umRvj4vZJELv9Db29G8Ahs6OG6OcKwQ=;
 b=LHNJ54SyttTNGIqxlGETpvckpIll1FV7Q+8a1b0chufME2DD9wok16lfKRUYTgumLpvcNa1Li06uIQNySywCXmrOcV6D+HO3IBVHwQpWFAvokEiDM+B8D8ANp9fFUT8oWKjbFuV9AsaHCfSYVvW19EF7BLom+JU/TuGjBolkH5xldkuFNQD/rhHaJ7qnPTfjUnU55/1/vGualgRe0q+RNNOCzdUpHTM91CLBCeQzqUwuK3Cx8efZIbQEh6v1/eNQcc/qGHXz/5M4p0NoURV7HUjEixyhYFCOfED/gzA1kcANoq8AjsWg99aMzdN2vzTg1l9fg+Ksiml4mtoj6oF8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztxHBdF23VK3umRvj4vZJELv9Db29G8Ahs6OG6OcKwQ=;
 b=Ryw9u4hqx2/X2ilsg5DJlBBwla32cyXapRu1XwowOkusAz92cHyI54XqP1b0O2GMIOw9tufjgT9DkB62TEz0dZT/Z/r/KWU9Xga0DgOCiIbW5xdIfJa6Zt+wTZbqCVRz0b80xNpvZkel53OP/BIHVYx5T88RW/YbPOs+1sZt74c=
Received: from LV3P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::28)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 12:49:12 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::1e) by LV3P220CA0027.outlook.office365.com
 (2603:10b6:408:234::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 12:49:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 12:49:11 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 07:49:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <bhelgaas@google.com>,
	<mario.limonciello@amd.com>
CC: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
Date: Thu, 15 Oct 2026 07:48:42 -0500
Message-ID: <20261015124843.203905-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6394fb61-77e2-4d96-fbfb-08df2abab633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|260925022911599003|18002099003|260925021311599003|10067099003|260925021911599003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Uwoj3/NVgBRoBPPhL/QYr79eWxVynlaO+H6m5MqY7jtVcCyIQXRPbq7MIgJvi+5rrhkSNKu2YHo/iMuXAOpA1Sgw64LdnBvfz0phggxGidaJpluLmBGvP0mFXbNr4GGh0Geh8RePXwP4cB6CGZDoc75tRf8/zAb1s1SzzzfUWzYMVMWuo8DxC7S8lhI1XYzt2blHLgH2ItHw1j/yVMFLEhswLDxTcaf3DXSWRyblskcPkoWhww4ZiRnAi2xwv9tDTRDJk/SnuP23K0SLsOov71ESdYfoPPJgTLJtfzKBHmEpYHWQxRYBp+95DwlX1mRk+ZBCX22BdZW72sKVAAHvfoZexzKMQP39/AuPtTMlIu6hnNlO7nT/3vEJHw6w5l5uJvs2ZcJq/NWBRB+95IZalO9v2iLb2VVaRNsfXxjckduQKABxjJiDJaM8vja2zsHLhQLxWvzMT1Pjyt2eshnt6cK+KgFys5B3MVieyfi7bZ25aJvolMIN91P4rHXA71cYOr50zF7PTTp4doRSH1qqAYlsethLeEQlPyIsiOR/Z/fcXM3p02qRxTDHcOBO9rkCP60gKovlj3ZIoX4KbUuxS4xB5ufJYbD1ZZqr+jwCXJ+6HyDIaibRpO+V7f5SUTLgG84En4vClTsGRyQCDET6rQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(260925022911599003)(18002099003)(260925021311599003)(10067099003)(260925021911599003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7YBWXYnJwfpcLjnX3BWcH4CXWo82DqhcUnG+8qgQPainE13n4O3CsvI18AthOYiMO3vtKLsaxKF/V2ZNJoYUOPp0rQ3E9DJTHZKf90PpdUQilqiMFhK61Yky/CdFAGxIb4xREyCxSDYljCLwJN5AHIHv/BzARa9/Jb27UU/PgWS85D82XJZGBoZtwL94NzwVfroCDs49YgkbXFK79z9WvYSCHEhNqPqbGNMmnetrcjuXil56iH05kXx1HTSJE650wC1vOPsLxaAF4gM4b89/1dopoIMQf4448/ilMP19okHJIlqbwiGXl8AkGzWrdvaV2ZoEjBsdvoyXnCmF/X90qHIqZjGUvkhzYoHR+ZSggb7rhWeb2LJ0IJwtx3UNEWeZVJWnKds3sbGUrJFcvk+pAyrU1kxH885bujsL6MrbRW7SEl1th6dmwlJvF6qSg86Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:49:11.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6394fb61-77e2-4d96-fbfb-08df2abab633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

The soft filter system introduced by commit 11c141672045f ("drm/amdgpu:
Fix VFCT bus number matching with soft filter") has a deficiency that
it won't work when there are multiple GPUs of the exact same model.

As it was introduced specifically to help the case of pci=realloc, gate
it to only run when that's in use.

Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 15 ++++++++-------
 drivers/pci/setup-bus.c                  |  5 +++++
 include/linux/pci.h                      |  1 +
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 08ed1eb695586..75af9a59671ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -384,12 +384,10 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
  * @vhdr: VFCT image header to check
  *
  * VFCT entries contain the PCI bus number as recorded during BIOS POST.
- * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
- * resource conflicts), the runtime bus number may differ from the POST
- * value.  Match by device identity (vendor + device + function) and use
- * the bus number as a preference: exact bus match is preferred, but when
- * the bus numbers disagree we accept the entry if the device identity
- * matches.
+ * On systems where the user requested PCI resource reallocation, the
+ * runtime bus number may differ from the POST value. Match by device
+ * identity (vendor + device + function), but only treat the bus number as
+ * a preference when pci=realloc was explicitly requested.
  *
  * Returns: 0 on match, -ENODEV on no match
  */
@@ -409,7 +407,10 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 	if (vhdr->PCIBus == adev->pdev->bus->number)
 		return 0;
 
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
+	/* Allow bus renumbering only when the user requested pci=realloc. */
+	if (!pci_realloc_enabled_by_user())
+		return -ENODEV;
+
 	dev_notice(adev->dev,
 		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
 		   vhdr->PCIBus, adev->pdev->bus->number,
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed16ef7c26fa7..d9450585082c0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1799,6 +1799,11 @@ static bool pci_realloc_enabled(enum enable_type enable)
 	return enable >= user_enabled;
 }
 
+bool pci_realloc_enabled_by_user(void)
+{
+	return pci_realloc_enable == user_enabled;
+}
+
 #if defined(CONFIG_PCI_IOV) && defined(CONFIG_PCI_REALLOC_ENABLE_AUTO)
 static int iov_resources_unassigned(struct pci_dev *dev, void *data)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1ef..844734da9250f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -610,6 +610,7 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 }
 
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
+bool pci_realloc_enabled_by_user(void);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
-- 
2.43.0

