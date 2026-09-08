Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5158FD37;
	Tue,  8 Sep 2026 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886863; cv=fail; b=P193W7m3kcuN1TaaQtNU+hgo/tVdzF47znt+70qDv3TaaNLhsyYjCg2ETbt3yQquoaxi2+p0C9dqglsc4xvGC1UnWIBCCgiqAGl2iYQeKCDhBY4IoCyEjHz0uA0yCt8198MsyvZhbtIZHCIA7YY0cBJtigMoMMUdaHpLz7GF/mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886863; c=relaxed/simple;
	bh=s3uv43v6SyM0umwl2EeCLSIyCBdoD3RgeEoYqdP7X14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0XO685DDf1wu1coAcZ3Gyv1vZc6bXkRPlqm2WRXfTlh15E3rQqph30lv78BFLSJahZsCODO2nvoIu5/hJ224X20AtuSwIAaciWAMnWnYELpFLqh0JI4MRHj9Nd+EDviXCoOog7pKKxIn+x5FzeS8EWWOk0iLx6qVQQp0j+Kg88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hV5y4b5j; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hV5y4b5j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1Q9M62NHCEdiB2wLO/AdePIGzTbEoOgJJOYEbILs0W+DaDBgQmJvgneAyxr7mx20Jbaw4ZVl/99pMSmNXATyDepYeacwscOYxgBHMD9UFLcCfkTQd0k1GuEC8gTUz+l2gwNBVXPuOlAzxGVuEDJ9O6UgDJhD4oITxAiQV8GLjp7YEv2BMPk+dJ5nThuGEMEE+5MsnIH0YxvhOCsfmq6eKcuTAlzuPExpzIAF3pn5ZjNzXiX3BTkWOo4Tfa22PGva7dF51qYKyL4SQlOhaduoJHEneyoRXtOhznbRxYuZn9X1+zfYoyP3IhoJqJ6VDkfwoL556c55oV6DmKY+20Eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyMxvmYX0c8y3ZiW+EMjBjAr8dn07SBCbG2Dtd3qO7g=;
 b=ton/qBDBVt7ZGjGVeeOidqgwjzVram8rAB4gyD79hKWwVx+4AF+xFYxB6StrSBc6Lyzo5HyRCDnTFFFVZ3+3KhpYs1jbvLe8fuWyWt8avH+D6VUKEvHMUqZICWyaR3drND9eK3ZI8Lb391R2ITtfErFgAz201ZbWWM6UfpF8cnmED8lU7VVRbyL9HasOU2yG8O8oOwFRkh8LAYMI1NMUTQT4uGUJAYIW5HLuZtDKETLdo6G0Rdt79EKSZlNy8+NJZpVK9rT7eGRETMXqVSfMHt/Unim0xoZVbHeqdh1/EcFLIDrtchFkGL5aG6hnvhztB/N2LHNWmnkx+7XDlADQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyMxvmYX0c8y3ZiW+EMjBjAr8dn07SBCbG2Dtd3qO7g=;
 b=hV5y4b5jIYFmbOU3appoxE3xen/PylUl9aMQdtx2YkqXH87wyUgeGbuYbCQGOMD4tOyIYHje7xPF+v5bBCzQYK8Ol23PNLMbGH7YPVI7xwcWeNQMDzlyPJVfjB31+xiHC/6rpMWrB0ID8vn9yTF76QuRiIjZqMAjLvUO7HuPO7Y=
Received: from DS1PR05CA0002.namprd05.prod.outlook.com (2603:10b6:8:457::10)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 8 Sep
 2026 17:00:56 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:457:cafe::2c) by DS1PR05CA0002.outlook.office365.com
 (2603:10b6:8:457::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 17:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 17:00:56 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 12:00:54 -0500
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
Subject: [PATCH 1/2] x86/PCI: Disable enhanced atomics on some AMD PCIe ports
Date: Tue, 8 Sep 2026 12:00:34 -0500
Message-ID: <20260908170035.160166-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908170035.160166-1-mario.limonciello@amd.com>
References: <20260908170035.160166-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ffd9d4-7043-4e84-533f-08df0dcabfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|7416014|36860700016|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QOtFa4LCe6iaGArR8ddiFN479FHUE4ahxa7A7cb+/5tW4Cn8rzKhlS3IrSt3t7dYizYj/hGXFqy6T8egCmPg6sK3Z43wShWptH32XFH8c1FNVuwvrc4h944/fQUwew5baQR/rhKSZyHMxXqZglhghrH0GKY0RM0vROoWgs5qDuYrB9lpr1fB0ySkB6Uvob2n0GLHUlhPhDD/jkMtewUzKMbu+bdgwibMqhhDEGDf9NLCUS+qAzfeRKYctyOAZw9GYJ1fsc7rzc64GCT5q1KSwdhXhuuL+OVb+2LdFPyqxlZaeIVD6EY2VfBogYqgD8zks9Wf0KGq0A7SSh75nOEQ81fXcQmw1XYjHnnsFf+y/bwKFWOrd8aXiYKoJ+0FLEodB/dkz/TQH5kmmr7po+ThpJNVWYE7j9HqjxxwULaTIhZ+zYrHIP+cBsTmPbnGsViF0sgfS4qgJrGBIHC5sZ+9v3ypjdkHIUDdotsFP9RgGsVBNhl5oUZYSXsIAEx4Ka+9OtDXqIYpINBPafGfTzdNEYcGt1mwOGoB2xlzkdguM3nHp+9B8ehEsZ9aWoGF8pnYroAtRB76SPpGK5YV1cRktUNKFP3dteNeY6tp7QmpQF+E13W1ojastgScm1ArTbv4+hXx06vImeS2rhuQCoLgK1CKPl9uJZ/cy7frECYZjJN9ByrRpvz9RCsVrtp7VtBYX4NDvIX4Vq9djlL177O4cA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(7416014)(36860700016)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uaQZPqW+lqPKupAYqafeuYyOaPvqui/gkonPGrbBYA3buOWJXXsqI+H/RJVxxl/8zKCS9Iisy9DZ8kMXFXnYDwqvQxPAM5y1jYb1AuPimB+QLKckutSb1TzRQVFtDF5OumK3O4SJ8wZP3LDFCvh5wUQm8hjjSSXmPj3n0OanJNm9QDcCmu3WCGQI1iatGXAiMR5FTV1QJ+49pmSvaMWiqYcRMQsaBFzj1KQgVbh+qQZJ17MW3bf3yYdd6j0ZXM9IKPOThWQfA2KcDMjKza5g6vpEHr0Y+PhQNpBj9E1693Dx47rPQmh/F08DETDhEL2wPp+6rTZj/JMy6J+dD4hw6xFFF53DyCyDiK5EDFeO6JBM+yPdOJTbJXmbiUnfdBjTrJCp4nn4tSxEYFT1s8sio47HnkEv038GyTTD79PKPdsGby9jHOSmlRuqrE4m8HrP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:00:56.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ffd9d4-7043-4e84-533f-08df0dcabfeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

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
 arch/x86/pci/fixup.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df753..0857fd9365ec2 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -886,6 +886,99 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
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
+
+/* Strix, Krackan, Strix Halo (NBIO 7.11) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+
 #endif
 
 /*
-- 
2.43.0

