Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D02400E18;
	Tue, 11 Aug 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466858; cv=fail; b=skmlj18pcApedJdswS4+iptQa6hdfNfiCvt2omYpF+xOApT/3u85GYOy98bN36/cKvI0WOiND4B67cPa99jEjY54qgZP+d2tPjLPWqROPtNMquGYEs07R7Xp8gJAEo4wnxIwsskkvjjuFIGRScqs3lSpSASrT41YA9nzDBo/6cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466858; c=relaxed/simple;
	bh=BjVR7rLROp6G1r0WR44s3Oyf38Ttwpv6ZKrLjMblUz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWxcidVswLEIML6ga9WPQKje1SL4SfsRIQhXuIK9GuJnZRqbs4Bic9aBcGalJkpdlavxm5LfEsg79aeMTpjMX/zF2fJZe2/ynn7NAhLL2QVUloxvuJQHZeadRjJDq+7fQcGA/RT5+3jf3SikFm94R4QDs1Kynx7k5fJIFtkPjyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S6oK5ak+; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S6oK5ak+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJeq1D1hrVtU7lnFO0sD3JkbFKODoKpQ2D1lIcMTWwZFmBu9eHJITVxd7yzWsaOxKyVmAd7RhrOc2m38AFGThA27vOeG8yIESKJHAb3L/M104r8KJFQDKqop4gFuNzKuVDeX0wWjJiCUoQsls06KZKTAR8HV220cpiMKVPKFrBV/jppH5XOE3arjV+b+KbFeROBBrAoLn2A03m7wnNTG/o5FdJadZA87Fn+b1FGhSIoQtK97d/taMwGttF0hF7DOl4FfQPvarwh1OX8XxkxxUW/2p6LAJfVbm6GKDS3UFBA5lT2s+7viL1W84gZxmYaP7azDkimYxRyJopItlytPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGFTfF7TMxpbTzV/jzTlbqcBqwnb2Q6G+sRNAXNLFoM=;
 b=Rh4NhsawMjGpJ/gj6kgqXCAH63LKoLCY+Aad3XpcqCOojcrPQnyoAhh2ncs+qVR3Ql4kBomIuPlrfoLpVBcuwZ8/jMlXBmoqnWbRPR5iej4NRip7Z21fsDdh2tlQ8p2crnpG12ilQDXrhZ3m8zgBlwyB6XYPhUgIyA8SIEedvAEpBaCzjfoM31vU7U2iYxbUL77PblcFPncDd0qNIHdMwssiX0jKm74lhLh42NqF8Zt0/V0n0LdFyOE8mbMcs/w9Y1Myl40LV39Xp5K0Q/fM3IRnCTEbc1vm8cJyqMODYS4JxiLC/FlvEhc7Cq57Aj1inE0MdpcIkV4MYyx2l0OA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGFTfF7TMxpbTzV/jzTlbqcBqwnb2Q6G+sRNAXNLFoM=;
 b=S6oK5ak+pubdqu/C9/r2j3GZ7rWiWSAp9WKE8qONRGzArJC7nYHUQvSDBQzbfgzaS9cNS++Jt+Fa8BU+rOLwbInKM3auVX/K+PRf9KJJks0SjTuWsPeXJXQ2k+/iMF7SX++3OhvfIY/NVfMZnMG1BX5odvBeulz7hBs1KBIf2Egv9P/lIdLSu7+RGTrSjyYat7AgyyZ7AMe02ZxhFpW7HlDIUCqdRpqxfxeaslydco5C7Xj41/SkpHySkvZ/Z5STXs8iv3i/rtrRXpZTspHBDLFSXAkw/JW77NaXrd4pnEc86bHNlbycE8M6miB6RZzBHz0eHgsOQs7RNTMLIYO0UQ==
Received: from CY5PR22CA0008.namprd22.prod.outlook.com (2603:10b6:930:16::31)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 16:47:29 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::7) by CY5PR22CA0008.outlook.office365.com
 (2603:10b6:930:16::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 16:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 16:47:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 09:47:08 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Aug 2026 09:47:05 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V2 1/4] PCI: Add DEV3 14-Bit Tag Requester register definitions
Date: Tue, 11 Aug 2026 22:16:37 +0530
Message-ID: <20260811164640.587078-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512163012.2336191-1-vidyas@nvidia.com>
References: <20260512163012.2336191-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b94c9b-e088-4061-4d1e-08def7c83b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5+aflVM4Jra8pkd2UNQN765EENU/T+IvUF0eXx8o6W0bI+2L1BTEAMwDJZHPn+mO+EWLFEuvMy+lgTyUIO9s6Axl39D4z2sIucnMDj+lTlNJjaG3x2LswW5rQaYaJPPqWZKE/9u6YQxyLDLyFn5chhv56KVJbZoplTNVPpewvSuCqQTQdw0mRu+gJiXPx3SrKwjGCjXtgNtLIoaqwusUPN0YiPpHuOSUlMOqZ+sXDX9zx3a0M4vmExw8VRNibRlUl9ghyV21ueri01+q4FbUhW3TgAddEqSS40fqshCv+kqt2arUMhH9TlCGDq588mGj/ITdkepGIMMP2xZSTkotrQfnz9nU6egGUnXLcf9qQiq0RLOedlOGuoN5KpLRaDPowBj0ARktXPNqbPcCcKuTUWpb9PRwiMNKfg6rflHRyF9WBWyGdXftrPsZ9uWsA/9IzIOVLZjpGqUlR1RQj/xlKcDjGRlEh9b26zOKD3AxJNyxl5uyW72H/9xhsINO/eazL7l9GWaJ+hoTdHi+5eekXq4pc2mIA5jfAJ9Ep/uw8o/IljjyuTMdRGJEDUnBvHmtw3nZ/WckEQlr9Kvhn+/9IwlrPKoE2ahSstYAiPGNebh2gE5Tr9RheV/TAHJ1G/PQR32RxLwM+2MrBuXyefUjZ7+DxOHJUgJWsESb1U2ioxVW2QPh2jNwe/MQ/YM5uDKwFGun9fpJoyIAHhpSkfwZ6Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TaHo98nznY9RBl640dfWCU14alF/Wuq+XIxyt3PUkHt0apy/Xol/XmxpjPVQWr2/45v9aeKj5tfBfZ2zPILXjl9nLY3RzFTor5UpmOK4zSnNkmXzsJFy8/BlkTL/DFZA5kGL6Q5zu/dlgYe+Oj2YnUp/pBhz9FAsVMCug97fV99QAS6g/LkPDxPfQcqoQCgpImKtBBo/fLFQOgm/+3owysBZ7MD60sMKzlTedKzGLlSGFeE5WSne8poLsHpwtghRr9UuybgpSH7IPbNUsAcPX1KNTMEI9VfijVqL5peKg6hndFwP7aabGHisRyv8QNmgoGmaqNZZtsC70uXElBD6Ei6kKiQGrtybhHlnxzBO6ve3o+HUnmKrrtC5NSvqfIri8SXCWMqTFsss4XeRPM8qWombIRbDyi7oM5lCt2daubensCpc4peQTzsVhiDQ5dK8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:47:29.4108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b94c9b-e088-4061-4d1e-08def7c83b69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214

The Device 3 Extended Capability advertises 14-Bit Tag Requester support
in bit 2 of the Device 3 Capabilities register and carries the matching
enable in bit 2 of the Device 3 Control register.  Only the register
offsets and DEV3_STA.Segment Captured are defined today.

Add both 14-Bit Tag Requester bit definitions.  There is deliberately no
completer counterpart: a completer reflects the Tag field of the request
it answers, so the spec defines a 14-Bit Tag Completer Supported bit but
no completer enable, and software has nothing to program there.

No functional change.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* New patch as a result of splitting the V1 monolithic patch

 include/uapi/linux/pci_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..b2ba5c2642f0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1254,7 +1254,9 @@
 
 /* Device 3 Extended Capability */
 #define PCI_DEV3_CAP		0x04	/* Device 3 Capabilities Register */
+#define  PCI_DEV3_CAP_14BIT_TAG_REQ	0x00000004 /* 14-Bit Tag Requester Supported */
 #define PCI_DEV3_CTL		0x08	/* Device 3 Control Register */
+#define  PCI_DEV3_CTL_14BIT_TAG_REQ_EN	0x00000004 /* 14-Bit Tag Requester Enable */
 #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
 #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
 
-- 
2.43.0

