Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EFB4A015C;
	Thu,  3 Sep 2026 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436924; cv=fail; b=jH9HsfFi8r0QUVM33PsjYaqhgBjGFdkbUGJkj/xfflp4iPDTFdl7jZyE0Ymjqvr/VEduXWF93Ki6p4DVajDbVzAl9SxFTVQHPacGlxW4Pw2bWVZiETzr4q+lhxmVroseEhcyaQ2U3Hk/QcwkuwRkfrUIQ8Tftl399IzV/LmZg7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436924; c=relaxed/simple;
	bh=zznkR9TE3fGARYeIXWBFs3nt8Dh0BGJnTzgNCH+EL4Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wc19CmUwcAtO3etk+JMMAVToU7jA7kRQfHCu1ApFJTbCPiAytzOwpB+AEOo71wUK39Ahkdr92VeER5rHEmQhmE7xKxT02RIgTB2T1LJopCuOAAYnz6jy+YWUH2dX3QLkSAzPBDnMt49wdgtyaE0wBDyrvqN+R+xrMaUjXzEJZVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eUyBn5cm; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eUyBn5cm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYCz2DgMMl/h/azKAi+g9rFIERlhz+lmL/jbn+23QG7PDaiJMSbRR9rUVyc/hsshz7D6z+vNOWfkHxXbA/I0jcZ+JP3gfnqL0xGXDI8FMMT/Afa0Szg8C5ts1a3E88nHYzE8sPVKgluqP2KKaRfHNnQVAoSjxOsLetAm3rJbLuNzVZpapQoBVCQeIGf+ZDiLc84SBGelT/piyRKhBkFBM9N+NvaDKP2IctNW4b6L2AN6ZpSDQT9AXUHSX6i4E+C+hd2LbN+0S8c06ciibP2H/Njeu1RVEeg++4qoKCdZjdUJz9EfeYSeJq7IIKFlcUF5p7gqfGQWQ4NWXV+aX8m8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w83EfK34fHezYG09hdZ5aYUNzlJ+zuNgSubKcwVWaeI=;
 b=abmMxx5r2Ura3QQXX9a1mtU3rwRqyh59/vdC5U2cpDaIRCynQh8NOr6rj2DoA3BxxY5UJcisoQafJKECVqSk4+Y0ouwKHzvhBHMRTRFBhNUDENHPJA030kS5+rL1+Sj10yfC6UoOlAhbK3d+KqZ5BB4qynKRzF38XkUguf2jjPhbE96LGM/8acdo6fadLlXcvcufb4OIXdHzojizOVHnOuhC3IGnOxswRb8en6Rk+Iyn2btufLMK7G8H2nlhgmFrdv3pBzIvNY8bKZWTqxNckb7/zcqzeOf1t0NOrkYV6s8H03iUCM2xAZ1BLTmeqevb8L1BCe8RAFWljsXZNuOObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w83EfK34fHezYG09hdZ5aYUNzlJ+zuNgSubKcwVWaeI=;
 b=eUyBn5cmxuWb6PBgHauyxnqgoITxTJWBDJhkIFM4F4lalMpt7q3Nru0ELTNF7sN1E4gR1VKBXdfcgTvK80WNa14MYwbePbLX965t8c7xdnFnMn/BIDqi+J4/alSAFDxbRqR5z8FIB9eyNQxL6zzfxiqrvunFpG3TpzZTUxbPDB4=
Received: from BN9PR03CA0199.namprd03.prod.outlook.com (2603:10b6:408:f9::24)
 by DS0PR12MB999104.namprd12.prod.outlook.com (2603:10b6:8:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 12:01:57 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::37) by BN9PR03CA0199.outlook.office365.com
 (2603:10b6:408:f9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 12:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 12:01:56 +0000
Received: from sriov-SYS-7048GR-TR.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:01:55 -0500
From: Nikola Prica <nikprica@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jerry.jiang@amd.com>, <haijun.chang@amd.com>, <andy.zhang@amd.com>,
	<christian.koenig@amd.com>, Nikola Prica <nikola.prica@amd.com>
Subject: [PATCH] PCI: Accept AtomicOps already enabled by the hypervisor
Date: Thu, 3 Sep 2026 14:12:18 +0200
Message-ID: <20260903121218.4955-1-nikprica@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|DS0PR12MB999104:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae14a2e-c6f7-4786-4a3f-08df09b326f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|5023799004|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pAvqquTlqsYpjJEBYc82wv28xCk9uIbu0mk4+Z4NrfdMkp8ROgkU6jqJ5UatypfEySPwtdYk34wd63/mw+YeYlNe0xrm2ga3pe7RQtc//syESRMrvKIY/WXdVVImr338FI/GBa2pm1CCYruQu1fY+bBLbYdfULpYnHpoPBY4WUnNZktzPyaFFsGGYvJPYxGxeb0nBaDM5Q5aLw2Us+s2y/vJNP2+4N2+oYJDwMDqPTBNFhCkvl6TYOQvA//0KFyLOYfRWGN4/VfDZ2GVBnIHyOX+GLmwEHEjUu4iK+fQnqvtUdzCCNz804EASOtPccRM5WzXzhOSmFmd2LJHotxyMR9lAzMOE9TUVghsjtn14CAyRxl67qENQYL/jM005gBWd4K7eNDxR3Cx/2W1sKdGdoaJXy6EwX2vE3e56swHE1yCfBXM/HBk8Ak0XBSM53yxvCFsrFzGQLIlgEFUZdf27XGCzFbCiVyInt9vk51sGVla/5OcVSZeEehvnvPlBfAVccT4ZkremGKex+2eAc7NjC2T4wjaaAOO/vBerDovq3dscWh7t+iFt/6/SNNz4KAJcniWsBwx6Mm7opzZiuQCJH8HbOHVhU5tH8FqdgDljzXfY7gSSBQaaxnCeEsXV07m8use9paBldwf/asuMvIz7QcZUS5BR1rnKxlG9LDnWZAm9rB2KywyB67Qh5Iry00Ap7lgw7+Qjn/y/emW/nL2Vg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(5023799004)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w743vpbKjVEAtZLmKkqK3Kj7noYK7bUBT6sfnJoIRZtqcc6Aokx3Zm5Zdu/HpEfuNyK//KeXQz9LIr065n2w5YQ0p32PzpQrlCDDZH1DMXkhhlCgPLhUVO6QXjR6XULv4uV+o6Ar+T0mPnNWvFU3yFZVl/DUcsst7yM8bdF7xXrWgn8HMiFQ3CcfgI0XMJuKrpLb3oCa88IvoK2F6sPsFBFStHP1dZhnmuUn2rNc5uD8p0wLmCx67Q5s0Y+lioqCOyVhqLnVHKgtvz4AgdHva+4jB/v4cRfdzWIK84Jz/ZjGhJBgcvcMCDNU/gq76iD8LC+nGCirF507OHqxY2OpikVGQWikdB43bfCp+oB9En4usljXHSTAanjprvihNYNcsj99cxq8WiFCoBu80nOcrdvBDbAk6Djp7E6AbECp8g/7WW4qzuy4eWzYlxdLJioH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:01:56.6921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae14a2e-c6f7-4786-4a3f-08df09b326f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999104

From: Nikola Prica <nikola.prica@amd.com>

pci_enable_atomic_ops_to_root() currently fails when no Root Port is
visible. That is common in passthrough guests (ESXi, Hyper-V): the
endpoint is assigned to the VM, but the guest topology has no Root
Port above it.

In those setups the hypervisor may already have enabled AtomicOp
Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
treat AtomicOps as already enabled and return success instead of
failing the Root Port walk.

Signed-off-by: Nikola Prica <nikola.prica@amd.com>
---
 drivers/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..7c62c7f31757 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3768,6 +3768,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		return -EINVAL;
 	}
 
+	/*
+	 * Some hypervisors already set AtomicOp Requester Enable.  If it
+	 * is already set, there is nothing more to do.
+	 */
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
+	if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
+		return 0;
+
 	root = pcie_find_root_port(dev);
 	if (!root)
 		return -EINVAL;

base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
-- 
2.34.1

