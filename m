Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EED5A5159;
	Tue,  8 Sep 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894387; cv=fail; b=jBm/V60uT7kpOBfQiHPCLA0EM/MBnGxeOT0UmK/PyoqD2N7mggCmFEwaKJ+fphlFC5jU8KMrzGuWnDZy8IGnSTI7R2MsoZ/E+syN+1e/ONo1zewmwHkOfJZmNeE1dkzXm/Xm+OsLmh0tbkV2gSDNlQ8U3N1xa39lIBcoPDrC1ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894387; c=relaxed/simple;
	bh=UAx/uvkRrmZ3phQyzdZ2Le3CMFGFmxjYXOwu88K6RW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HogTAGmYjj71NOyXnRKYNQrYRzcH3XD0pJ48JS++PWSr36YX2XecklHdTcXbiX83gNYmwV5xNM/xkx4vVeGSXGKdeue635gQOLuFCOimk42vUT4Px28HOusofFJcSrO2tf/fhspAU4i5L/GyE3QjvphYWSx/bbO8/nYJ2PIweVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NkHn2TxA; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NkHn2TxA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzTSUacTPjur3hN6VBMH8yT6R3pN866um1bA+KLpH4ftfwfESb9ClZ2K921MtX2si7PKJTwQ+3aoHVwJsd/o71JmoaFb0WyBMuZdVwjSXPpI1R5Vm6FXbYr2rNxfq/CuMEZr6mV8m9P4TeWvSziSkPkJH2Lt2ByTqqEGu5eKZkRn8SX9ka8kUaT3LGJSWjmI4fRUFoX2nBh2Jy+Wx0SabTlmIMjyvU3cpL5/rvNi3dZfKUmChxYODTep8NlWrJBinnQQWq88KWXXbnE3W4OM5qhQdFAfMnxiNk+xIsztV2G4s4zuTkeHlpWAkXWJ4A/lpr0JD0Iul3l7QXDYJ4UEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/RTpl2mPAQEB/tr+A4BbNG+LIodcvV/r645uNWbnRQ=;
 b=cw0NC4Q0hs4RVYfYK0MNf6xqU3U2dFXb4alxR7xy72Fo3UO9MhiAQOzipmUTkwYSqGd6vIUPFFjJxO1NMvHwVUmxJwPd/QQ0gxSS/o5e5yDfjkmFa4lKBir7BC34KdmxT4odIzdkQ/eOGSF1DvRxhx7GXoIAl9mW8sIrsW5GiIQWDk1kKOV9Clirdub2LeDr9pyy/yOVmM2l6ewFafS4NGQtWESSfP5va8d1cFM9GDw4bI9b04wu4MpwaN0KL/I1jKcu3EjwXmKQVE4Bpdl6FM9EBXf7eJG2zvUzH5KUp0GwMAUdljJNYoEKlWJv4SKd86QV3G9kqbad4/1/+3+6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/RTpl2mPAQEB/tr+A4BbNG+LIodcvV/r645uNWbnRQ=;
 b=NkHn2TxAOT92q/xYYoh63BEEBU6TcJzRBsTyorQXdIdzAn3UbmmTc0sCuKS6yFJJTPV5pYA5l4K6oz3+aJlyuMVaAJmJzXfO6crultisLsSd+f0bLvgrZ2IlgGf/BhlwVEA/o++qc+askc29MPAw+oK8A/T7tHRtcG1JV+ygJuI=
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:06:18 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::35) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 19:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:06:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:06:18 -0500
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:06:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "open list:PCI SUBSYSTEM"
	<linux-pci@vger.kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>, "open list:LIBATA SUBSYSTEM (Serial and
 Parallel ATA drivers)" <linux-ide@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <david.laight.linux@gmail.com>, John Smith
	<imjohnsmith4000@gmail.com>, Lennert Buytenhek <kernel@wantstofly.org>,
	Roland Waltersson <roland.waltersson@netinsight.net>, Mikael Etienne
	<mikael1022bzh@gmail.com>, Arthur Husband <artmoty@gmail.com>, Alvin Lim
	<alvinwylim@gmail.com>
Subject: [PATCH v2 1/2] x86/PCI: Disable enhanced atomics on some AMD PCIe ports
Date: Tue, 8 Sep 2026 14:05:59 -0500
Message-ID: <20260908190600.226485-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908190600.226485-1-mario.limonciello@amd.com>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 358b2e8a-f584-4dfd-5418-08df0ddc4391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fAGnB1WI3QT7356DZUqK7KFS5j5vMaPLzG6hGVUMtcR1Y5TwHwvCp6C11jNRlXCfn/PnLCKSNbTf6i5cCkFRHpNrJFKUPEPaYDTCoyIm+fMwvHsMExY9Nh4D0s/A+Bbp37rsgPVNfaFiVT2DH5OqLSGiAsZ0kJgBIYTCWFR+XsOO/QjMWUDgbRtWAPZW3BlRdshBlvbUutvUX581fXdjt3bTIg86FOqwloQxjqg+S79eWSroZlnS9xrUlp7Mm04jIJ1bAxvrbdPXV4PWPKxXB4a6gTbFkg6Zr15ZWXIdVC/c9wC6E6MhCNWrpyr0DvaKpdQjL5xrCkAbScF6qSYvhcLUDVaaJlpSRflIVTt9zXJq6WuogSW4pgbgzYFr4FVL6IPTPji4Kf8Oi3IE6J8tozNz1CtTf6v3MKhhrw0x8l4ven8HN8naz46w54B7SzWtWbViu5ihHopjbOfgzCuqcK5ap0JgmBK+e8jTERLpikzFTCbTLyL5+sekRQFv/c6iEkRo5ywtEGdQlMxsLQ41s2QarBzr6w0g3ZPb/W+0C3nuEGqE0XMx1cw3WTPQ3K/Erf7sbiF9cco8I4QsnVlmiLld5vv1UokmExjq40NrZy0rrrVot/oK21VuguCyBQoCKV4Yp++eDvrMak70m8ZWvU6asf+k5VhH2yCgyQEgBMu8vgdhTcW0Ic08muHXx48Mo92IqtJyqI83sojZBpJR4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4bOOIAh3JJG5EJvhmhQMolF0CAO+DK3Y9t0M+kDvQQST1L068iZo/ZdFekh8O4IW9OasJVweI3D524cGQEFtdmBNS9sJgyHQ0lM327NtkXPz0ijLjv2ZHP61MA7GdbZXY/iSdHV5v3AS94z5n1Pm5isaIFyxHvuEYsRRmUYTBDKkvTGGE6Fr5xfg//Wy8jwLoUUT/N/PR32KKjVxfrC8Bj1268YyYpy07lg2n7qmc/DlqHzIQr98FfCaKhUzV2tpZCHomLerQmLhwN17enlZRTou2jyYOLOEM6g2/0tiaUfCeO0oyVPhKpnADwQXKG/k0nT7JpEW2sjfN9PfPh81vNW7zdzGfoVdotyOh9dmbdpr58BK9Q46fVBOKXWopg37+QQpsoIqGVEfD3J/Qwt1zidwBbTlfcJJX2thc/NaCuKM+7FV1MF9mNS1k4s6vwfC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:06:18.7042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358b2e8a-f584-4dfd-5418-08df0ddc4391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483

There have been multiple reports of data corruption that can occur
with 64-bit DMA when the IOMMU is enabled. This occurs due to some
BIOSes enabling enhanced atomic operations on PCIe ports.

When enhanced atomic operations are enabled on PCIe ports for some
models, data corruption occurs when the 32-bit IOVA space is exhausted.
The problem is reported on storage devices, but can affect any device
that uses 64 bit DMA.

Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.

Cc: david.laight.linux@gmail.com
Cc: John Smith <imjohnsmith4000@gmail.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Roland Waltersson <roland.waltersson@netinsight.net>
Reported-by: Mikael Etienne <mikael1022bzh@gmail.com>
Closes: https://lore.kernel.org/all/178789300872.392066.15963676631650361573@gmail.com/
Reported-by: Arthur Husband <artmoty@gmail.com>
Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
Reported-by: Alvin Lim <alvinwylim@gmail.com>
Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Apply to suspend/resume as well.
---
 arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df753..79e4338e4b876 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -886,6 +886,105 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
+
+/*
+ * Enhanced atomic operations can cause corruption with 64-bit IOVA
+ * on these devices.
+ */
+#define RX_ENH_ATOMIC_EN		BIT(8)
+
+static const u32 nbio_7_7_pcie_smn_addrs[] = {
+	0x111401d0,
+	0x111411d0,
+	0x111421d0,
+	0x111431d0,
+	0x111441d0,
+	0x112401d0,
+	0x112411d0,
+	0x112421d0,
+	0x112431d0,
+	0x112441d0,
+	0x112451d0,
+	0x113401d0,
+	0x114401d0,
+};
+
+static const u32 nbio_7_11_pcie_smn_addrs[] = {
+	0x112401d0,
+	0x112411d0,
+	0x112421d0,
+	0x112431d0,
+	0x112441d0,
+	0x112451d0,
+	0x113401d0,
+	0x113411d0,
+	0x113421d0,
+	0x113431d0,
+	0x113441d0,
+	0x113451d0,
+};
+
+static void quirk_amd_nbio_enhanced_atomic(struct pci_dev *host_bridge,
+					   const u32 *smn_addrs,
+					   size_t nr_smn_addrs)
+{
+	bool changed = false;
+	size_t i;
+	u32 data;
+	int ret;
+
+	for (i = 0; i < nr_smn_addrs; i++) {
+		ret = amd_smn_read(0, smn_addrs[i], &data);
+		if (ret)
+			continue;
+		if (!(data & RX_ENH_ATOMIC_EN))
+			continue;
+		data = data & ~RX_ENH_ATOMIC_EN;
+		ret = amd_smn_write(0, smn_addrs[i], data);
+		if (ret)
+			continue;
+		if (changed)
+			continue;
+		ret = amd_smn_read(0, smn_addrs[i], &data);
+		if (ret)
+			continue;
+		if (data & RX_ENH_ATOMIC_EN)
+			continue;
+		changed = true;
+	}
+
+	if (changed)
+		pci_info(host_bridge, "enhanced atomics disabled\n");
+}
+
+static void quirk_amd_nbio_7_7_disable_enhanced_atomic(struct pci_dev *dev)
+{
+	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_7_pcie_smn_addrs,
+				       ARRAY_SIZE(nbio_7_7_pcie_smn_addrs));
+}
+
+static void quirk_amd_nbio_7_11_disable_enhanced_atomic(struct pci_dev *dev)
+{
+	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_11_pcie_smn_addrs,
+				       ARRAY_SIZE(nbio_7_11_pcie_smn_addrs));
+}
+
+/* Phoenix, Hawk Point (NBIO 7.7) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
+			quirk_amd_nbio_7_7_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14E8,
+			quirk_amd_nbio_7_7_disable_enhanced_atomic);
+
+/* Strix, Krackan, Strix Halo (NBIO 7.11) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1507,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1122,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+
 #endif
 
 /*
-- 
2.43.0

