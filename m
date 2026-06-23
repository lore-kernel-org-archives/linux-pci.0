Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF03845D5;
	Tue, 23 Jun 2026 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224124; cv=fail; b=mPPhdAGqUbStOW047Ayh0VkvbAtGYI8J4ArpeTZT760g4cYBVerhw899zjvZWOy7/C9Hd1Q2h5hdMXXEZVuifWLMglOsd0un+p9yseBFbCanMhHkEbzC8kLhcY1OfNmxdKm8USNs3VtI12xOBwCc2zUQHy6Tl9eF2ry2//B22TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224124; c=relaxed/simple;
	bh=MLE87N7ROjc/OtprzIZ7eKSQTBOK5o+jrW01ddbsbW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e50U5D8uawwA6kywyLPUag1C9JK0p58fDNoVRXSWfMnG3XmL8pHZSz6gshoojMHxnARa/MJ+WnX8XQ93DeL6JvaS0ulVDMdj7mk+ddT6dwB63K38Q1i6b0epTSXtWmY7lsJ66EUshqSA27NVapJyKqxsgwKwO+VCTlnYRfie6JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sGfdDEDi; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sGfdDEDi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMRX+c7yPoslog9PGEiS+j8acXynKxJqhzBkEU1Sj6XcOmjCFXKjY5IarUtFW+/bQtfyOM/koTw3ze36PkOKXs1RsvTjeGE6yfa274VUtdVK26JRfQljXBfeeNKip8cL43NiRzxGF0uWZkIvb0WdYuFsl/JrZkTDBz0gQiANTYguwCTbAbJHziCssN6Zo2zLVTB9rBAhU2pV9dxIcQ63iod7EuytJIXl/ZIrgn9dExC1zdNeqrbGX2Zd8ITbMVnTwFn+2YMH6BNuxuYzllO80DvEAszS6sh1n50SJj00wptkISiJFtClHE2mJmCNmVtCucLLFFv2pUe7GP78w5J+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCsRuveebSTGt4TUZ/NIMgppCSYrMEjnJgd1+YJK5wE=;
 b=taaMDqbl/dTntQm6kWuECPlMuXmz/sd8+OXg1aw2meeKoVr7L0MM0pAPD6TdXTdOLUkpTeGXiPdfijjMWSHQ2MJ5kF1mGjflMXer8RUwT7UTF6/Da7qvxaCFY3nmj1npsmLdtBMFf56dI09MBmyI5nSW4WuvCBPNnubVwKhHc8HzUM4+WhbRRjc6Qes4Dg/rNZAsx7zTBvoLoxaqNDtuG6fVXmnUTa5UuVt8WyIcPVkjwHO3vEqTPDRGeYNEJnxfhJXLM2+CAwSDNx0qTYuCWZQAMreHW3vMHV/uT4Kdpf6IDPf/eRqFjfuwM4M8C+OdXr4yrZ3VWmiLeoy1K9sjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCsRuveebSTGt4TUZ/NIMgppCSYrMEjnJgd1+YJK5wE=;
 b=sGfdDEDi5oHZbPtc4DstDhn3E6+dCW3aa/9IwO0Q6qn4N9AOhCnf2RZX+FWeOra+cglejcRmjpWqbX9RBhfJktAPVx8cjqnUC2GGHu328h9Xgw+6CzxZaa9HgVwf9l4uREJcvtjD9lV8LZkEKijoU90Izq/9nn0B8QAbzp2kaFE=
Received: from BLAPR03CA0078.namprd03.prod.outlook.com (2603:10b6:208:329::23)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 14:15:18 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::5a) by BLAPR03CA0078.outlook.office365.com
 (2603:10b6:208:329::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 14:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Tue, 23 Jun 2026 14:15:16 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 09:15:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH v2] x86/video: Only fall back to vga_default_device() without screen info
Date: Tue, 23 Jun 2026 07:15:05 -0700
Message-ID: <20260623141505.1816786-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eee260a-937e-4692-7ab1-08ded131d990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|7416014|376014|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	v+Rxf8lwL8+f1R3aMNUXqbnoNcIyFLsCVAMLaxWS6fShMR9RZrBODo2qTVAwRrfeJfQb6gTQj8SbK5aPzuEbbVl45hRGazdIhTfUCMqWYOyp+JIOOWjQAtN/biQ3IR/MIiocZds6fmQ9+h3ZncSym60sR2/ZqyVlzWfqFgZTbTA/g3NYBryMDWPK49FyWwmphehapPUqxCHnDgLYP7qLqEv2/Dv75lghL0VZVfTl/QlyvDd0dU7PbTNOFcAp7xIOpvovBnbCEdTMMgYPhQMJl0BknrLwtGDna2Ql/NKM7CBoIK4GD4obV7KUjd7fKyBe6jpr5CkBwx6cvF4lz8Zbzt3sQ2eliL0eq4NJhz3ZhM4pY5i6WMR/9L3aea6OZ88M6IR76rRqHvaoZ5nH4lteRDoVDcS3mLMAhjws+3vua7n0fuYJppYi/8mGgsJGrGW1Ub1Jvr4wqFU1atNb5ndLbHBz0vwoO0Py3W0LXgVsY98SyV2QcRoE1VogFJpeURUQG83K80CGPxCpAgde6gneDAk52rVHkbgl04K/EtbdJormaylw3aRBLEL0h/qV4KybQldVdayzZeNXzn3aFPBuqpC1AQMa/9LQ3BcreQcsXq8Pu7YOnd9iZ+Pu1oLCS4vBHjLNNV2fILbVmyP8TOpIx4UjdzdQ5kRgKeIcDM1iUCLt5Lr3dMdSWXqEn37hrBHl+AsW9VLD+taHOMSlgjVsjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O0ryhj8fARhDwBKPWV1PBDCGysT8VAfxRO+crXrXZwbJrH5OTDWdt/mdL14ttFvYfP3EqtKb7lU3IbrXJTNR6ZtiYk+O38zOX2gyEcmQTtbrJb8a4BCfRtVwvOgMD/GR80NFkD6wlYron6yakaG2GEICmvxl+0DhLBd8JwLaYSAbZW1/zTHhxOW8/KkhGZHZAGLVkaQY4D9/Vu516cn/iEt2S9dtF9rqFxAGGNYMRuUqDnieAhFSoZ5fUSa2e5fz0A1BosLmkoVz15eAeF/gkY9mzYi6oRqg9CvrZHtMobOd7P14U3QFp3biRcqquOvckHHxooRLtkabOgm4fqQDZOTmwLL3nDgXPTyOo2FDYaGur3gnzczGfBAGQW8MXEQ9MAPR8kBUrf81TFWX/qgkis+aky9uZzRzqzkfARRb7o681GhIef042GZKAVWrlPXV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:15:16.6491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eee260a-937e-4692-7ab1-08ded131d990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107

Some multi GPU systems may have a VGA compatible device, but that might
not be used for display.  If due to enumeration order this device is
found before the one actually used for display then multiple devices
may show the boot_display attribute, confusing userspace.

When screen info is valid, use it exclusively to find the primary
device so that only the device backing the framebuffer is reported.
Only when no framebuffer has been set up does it make sense to fall
back to the default VGA device.  This ensures at most one primary
graphics device, preferably the one with the framebuffer.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
Reported-by: Aaron Ma <aaron.ma@canonical.com>
Closes: https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma@canonical.com/#t
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
  * Fix subject
  * Keep vga_default_device() as fallback instead of remove all
    together
 arch/x86/video/video-common.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 152789f00fcda..8ed82fff7638e 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -43,21 +43,26 @@ bool video_is_primary_device(struct device *dev)
 	if (!pci_is_display(pdev))
 		return false;
 
-	if (pdev == vga_default_device())
-		return true;
-
 #ifdef CONFIG_SCREEN_INFO
 	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
-	for (i = 0; i < numres; ++i) {
-		if (!(res[i].flags & IORESOURCE_MEM))
-			continue;
+	if (numres > 0) {
+		for (i = 0; i < numres; ++i) {
+			if (!(res[i].flags & IORESOURCE_MEM))
+				continue;
+
+			if (pci_find_resource(pdev, &res[i]))
+				return true;
+		}
 
-		if (pci_find_resource(pdev, &res[i]))
-			return true;
+		return false;
 	}
 #endif
 
-	return false;
+	/*
+	 * No framebuffer was set up by the firmware/bootloader, so fall back
+	 * to the default VGA device.
+	 */
+	return pdev == vga_default_device();
 }
 EXPORT_SYMBOL(video_is_primary_device);
 
-- 
2.43.0

