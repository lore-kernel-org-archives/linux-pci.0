Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D54BF92E;
	Wed, 16 Sep 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584005; cv=fail; b=IqH2/pDngmHcG8C3iotuzF1qH9Kt540WpXwVZ97VZYdBxR6Ll8K6dEyUVoDEdtFeoIKuvVwo4Ul1LuHAGuhtj3ugrvQG8cV9nR8qEttZRlbCDglPLlikEvDJtxamLexEn2KuYZw8OhPiGJZlUAz+ZXyUKeOXo6rDcdHMcgSOW3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584005; c=relaxed/simple;
	bh=dOyGl6vSr3INhsBi7u4MnV6zNbzI7TMh9C01VL4J0oI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEWgxvqCFerspn/IbYW25q7FdYwVObzCz3jvyncLX9rV/ns7HqGbb/hNh3y0hBl5HWC1nXrwgU2G0nYNE41JuBa7tmWiOoZJ/rLogdqz6Q8gXAZvvMnzJqO5vEoqEnJFmqqNVx0oPsH7sXck/5Pdw2gx2TQ3hQA0/xiwtF6YZbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q/zDtBJF; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q/zDtBJF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAvTRFC2r+UqrQPtx3cu3WiD9LacRb80csQhZSjbf7YNHyLEdehknuRG11dE74WxqujWLLyZJpAEIRbpBv7MiAH1ihJy8h7NftJHUWqurDCn0/di1G4fFphfCbrKmyes+MuN8OoIfPEvwCxwpJZ+rrMV5eV9cTR99ZnHme7EwRj6PHMZCZ/bEGjlDdtZSoQZ+g2zFLxeBrF1oMCplnsw4Bd+ep2HZV6EGejNbuqchN7x4xY/WFMGhUq3htgfSytgKiK1lgKo/68FfaXxLrCWxWx7uY0tAWYqj07m0tT3cjG9l4H1RNK5XObUId3GJFOG7S0LltH11VWBtzfV7M9UWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c05/a6oX6YrL/+XhAnMypM6wVPGQql+DJN96p0hwYv0=;
 b=NONj//4kKAozrIrKUVywiYtg3ELEI5Kjj09vYwdvL4n8knnxr2TZVz4G8i/G+C9su8dqSaH57bHGbZ/NbpB1ytxXQJk0vsssEM4eFgzaesvbD9UCqe0k3R59zGkzQvPYiIwCjkGRuthc5QdZ/aGzaos76WSeXerFYqVshJQtDRMECYqkthfqlWmMglfVgTAIgW0vPVD4c5DAN7hTgPL0V+3RTklbj5nwHGPH6CSNlyHSZATowMi8gjX+Uz4GaUdavTywQ3dAbdWbJXHPvKeT8c/3wwVUJVf4uowK/woCEUWHApMChUZLF07os7DyCLIkDRkLFf7NQarlnUPzNOl6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c05/a6oX6YrL/+XhAnMypM6wVPGQql+DJN96p0hwYv0=;
 b=q/zDtBJFwE4yjR95BrQDGFILqhJjmekHhPwl5SUu7WtqICOJWhMNn++PHQf9mEL1+F+tf1VMxES6fgz8/H7QpvzkAK6rab4ofp9yApBlZad1yd51sDLlEO9etvIRAY62KFajQaVwH4LmFcReyQNXQ7tGoTBKa6FWY5dIH4+IMELktSIa4lCmM5Sdupow+KpWb7mSbkH+p6JKwAu1/8Zj4fW4lejSOdXnQEtAnSTNVbEzLBG/JGV3O8BQKu/2mcPuC7Nv7dZRL3+PjL401ibuSFv83V20QFExMB+cgD6SxF6KDfdL5kg4yk76CFZJJsOEtGVERuDgw5DitvFFXVL/4g==
Received: from SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::19)
 by DSVPR12MB664020.namprd12.prod.outlook.com (2603:10b6:8:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:39:14 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::74) by SA1P222CA0194.outlook.office365.com
 (2603:10b6:806:3c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:39:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:38:44 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:38:35 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v5 17/27] vfio/cxl: Own the whole component register BAR
Date: Thu, 17 Sep 2026 00:05:30 +0530
Message-ID: <20260916183540.3813685-18-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DSVPR12MB664020:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf3cfb1-7410-4fe7-23b7-08df1421ceac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	/TzW1lV3IyDfqtiR3fUCK95tOjh8wmRw4eolGa/VBONM1O9VVFxhEMzEGZ8kVkYJXiE3Va9+AouSolvntJakfTtEu9CTc8uUBk7I4DrFA4O83d0vdL8ZVYMmSfn8JwpBGuEkoNdMIB3k28fUrSeGegoTSmq9+jtQqeNqxREDRpGuzrVW9N+UF4fSd2Frxg4IZPv0LFoQWDBPWXpW2B3I3tGhptP1HIX7FzCnOrcUerLt1JtDYp41x/+eclRGXbkrdJ2dp0rPvcDD1PgavRQ+V0x3rVWQhY5e7vZ+IGci24xm+GtGoQScHPZR8t14nfxdfD8CQ1vP9E8dTjeGI1U8JSYm3UYW9avEG5ftuI6t0AmdnOrMwXOIuI/k1coymUfGPbOIq+3hY7YiOFTmp8wnOvxoZj1DmXWV5avCJLaw7eAaCF94J9HE/IYeTlYK0h7wMACqlznoWMxKjhUAbq7LFFxzolMmGjm0J2bLSPIcaAMjG4AlA9f4X4vOBuy/JgY/zCNZOGvu+JAUBO1X9/oi1Hle5gGgy1ohkxVOPyOnWsRGTm/rAVst6vqd4t/GJXYtE5HC5dJZCHqaBQgprDKCKh2sdXfZWqESWccJLV0A27C9UCQ0EgxDsxw/7rKdaAgPpkIXG2/5yhFPko/yzaN8jk75rAQ4uDwRNPqxQ5XhTZM7UUdJyPrhH0/bneIh/jQbphlr4pUBy11td7eSE4YsqEfw7RPoUutmUzXIYbPMXHN1xsUmaoam6nzf7kkUYzxC
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vxORhvmwvujgx5dMWei3kucZy2vvIBzgnZHwGEUyGwv1ZvHgXvQCDCi3/QbGhDT4I/Zz6odoXt4LytDfWWqdk1MRKo9g/dDW7LzCxyXhO3aW+0Ar0bUKmXPf7XMvmGySO/g4xa5GNgqgZ91GZGHegcXNINmibsLii8kFlJdoh8h0oxGbJjuoTCeh2zGoBBWbr/qPeNjRq0M642QS0h5/6LskCeqDMRLSxYWSeGpGsiyzVKMOMmSFMJXFPCRqymXlMCp5CCcecGdq+dtT4CUCOcmZMqzTGr7C32On1mmpHH+jtXk6o7wdDC9fSgbeuw+BxScbQ6cMhNP6KMV3cVae3nx8wjS9Awj6zOcKRNglRBDiB/U/9DRGiZsDFSnGn4yuIoAGUyu/V+FZvCi2yx1YorIrt9htEtZJ9bUAvGCTTFpSkp6g2z4wWiVq946mwQ6b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:39:14.2219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf3cfb1-7410-4fe7-23b7-08df1421ceac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB664020

From: Manish Honap <mhonap@nvidia.com>

devm_cxl_probe_mem() maps the component registers through the CXL core,
which by default claims each HDM and RAS sub-block. That collides with
the full-BAR request vfio-pci-core makes when the guest opens the device.

After the component registers are discovered, declare the containing BAR
owned with cxl_reg_map_add_owned_resource(). The core then ioremaps the
sub-blocks without requesting them, so vfio-pci-core owns the whole BAR
and the requests do not collide.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 0d92e6a409c1..5c8a63833a43 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -89,6 +89,15 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 		goto err;
 	}
 
+	/*
+	 * vfio-pci-core requests the whole component-register BAR when the
+	 * guest opens the device. Declare that BAR owned so the CXL core
+	 * ioremaps the HDM and RAS sub-blocks without claiming them, and the
+	 * full-BAR request does not collide.
+	 */
+	cxl_reg_map_add_owned_resource(&cxl->cxlds.reg_map,
+				       pci_resource_n(pdev, pdev->hdm->hdm_bar));
+
 	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
 		pci_err(pdev, "vfio-cxl: HDM decoder registers not found\n");
 		ret = -ENODEV;
-- 
2.25.1

