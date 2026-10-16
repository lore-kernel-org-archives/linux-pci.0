Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF352CCD1;
	Fri, 16 Oct 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167652; cv=fail; b=mBP/LT1dco8OjI6/7pvbPcFhCNO+VOnmS32oTEpsndtpBLZTucQy+mh6ZayqVJGgHUwOO9ZrwrpmRJYWjVtyvjd5UdkjAy0h+sDrM/K4GE/MQBGzmyxRgexqtPczz5jMgm/43HbtE8in3Io7STgECZiNvnloy9QM+ToCxd2MZgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167652; c=relaxed/simple;
	bh=pOKScP2fyBn//Ak4UQM3VdtvHBa1fjJxS96cJLA2DRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKdhA+xlwHZp2sEIr+aHcPIYhj6jxMMtnBkWVK53gOYnT595rDBlHqWcIITR/OiR36Hbt+rarfc9gMHYttqm7qi0cK7jeJHR+DX7wUrXlIXexbP9+4RkX21OA2u63U0fk2t1dLUhMbXifsSBIVXofusmmlA5VTnXjHMd47oQVoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cENoDoZF; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cENoDoZF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJyDReNJ/hopTzvM2frtw/GSTSoVMfqCp+FA0z3GBthgKSAiKgrchcTpnufhfDssjRSuQfoAQkOd+1dOFcRvdNR/zLsoap25bOwEUsTQdXzSaORjITfKXrN2H8V3oLRSyIvY6iS6DQYpIabZEIg0EpDh1tsuOmdis1fo6jN7ISoLTRCLUNI3aHhueWGij1Q2OrIS2hUmA+XeGn0RMnWNKeMl5jP5wpj3CEafOg7WVoPm80h+MiN0ONgFw1s7y8bxEftrNT/JKUotx5sEDCYw/O0/ISmUQ7Nyh5rS24Y9KtnNXSTZwW3VZI0PzbRTQm0sR5gLtdcl2wnYY/pAGy03dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKR0JcNjFZZmsNYeQCyHsoHvtqyWJTxUnRLQT8qcMP8=;
 b=ihUy4/zAwQepOHoe5VVmdtcS4IMwvKdBiA8DUzVYiTq4quH7C4RZy3SlUhEqwTlFl32gnykjpLRLozGOxzbHUTB8zqjLDgTVAblWmhKMXKu3cVJmRtKiVJqd2ofkCLLhNKpHQvCFfzDIEhTm1fZWxBZQdw11bza/h1M1cKn4fCFfKeS/ahHIKVKEanqzmf6HWpDKRsEdK3PkzkHrNDeAbEl3OQON9NEtuBRcls/FT68Addfzf1Lku9gVfY95gBeg6WIYVh9OpxY/pbFrM6rcLt1JqZbB1KvMtpNheTDWT5B43cbLbFyxjdlQUn9U62a8jIfZdJ8HgeDrWdwghMdBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKR0JcNjFZZmsNYeQCyHsoHvtqyWJTxUnRLQT8qcMP8=;
 b=cENoDoZFNlpA4jwhA8xSA7e+9BCB3wCGxjThLPZlrSOKW8+dc3s1D7i/JoQFn3hE+ENPcoTnwsl0kBc1VZofmE8W+xB0u/smJ+Zd1K8CbY1IJOezNXmJiujFQMmxSfD47yyFViv7Szgbt6htLB7NQcV7URnt7yX0szbN2+fLM8dTRLoO4lcYv35buwT0+ocCu+osFKY1sO6JlIa8x4lYqSaS2UAnSK1gLE+wdHIrT2vqxB2j652xJoV5omENd43BJpZiJuNoXNOz2MHCKp8RG3HRX/Ku8bHL4t6oTEP/8+Gnx631q6lKZBPyXKNTYwbWLwLWzmXIGYMsrOrxcyvW1A==
Received: from DS7PR03CA0054.namprd03.prod.outlook.com (2603:10b6:5:3b5::29)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:20:25 +0000
Received: from CH01EPF000BE949.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::46) by DS7PR03CA0054.outlook.office365.com
 (2603:10b6:5:3b5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:20:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE949.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:20:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:19:58 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:19:49 -0700
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
Subject: [PATCH v6 06/31] vfio/pci: Add the CXL provider ops registration interface
Date: Fri, 16 Oct 2026 21:48:13 +0530
Message-ID: <20261016161839.2765592-7-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE949:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c3fa98-1032-4c66-8e9b-08df2ba1615e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|82310400026|36860700016|56012099006|921020|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AbUkuNwwSaehksUY9cwR763sccAFLrMdDfpukqJqFGyaGZ7/AcAFq39THThCPbSwWUTneHLO4XTRISCLcn745EjMDctYoAr57OxBww2kKXBrktTzojkDGjHmUWmNm3HKbsQByzdU2JCbpwARazF8oaB3Wd021kYRYhh6eT4VGaGRT85yfYL+YmWq3z5S64S3dSoNqYNs/KEiQW4xhG3Y0WMePWh0n/HhpDAlt+Eqi2YjPMJCXMzO01GqjY7wlnZbPrVXovnx0aGjmIsWRonD3GjOVMOuKTlT3edRHHbYdHBrxaw1ihD7HeE8TB3tzuSKSmedI5VsTQdVdZjM/akAwpp8PZOuO2WhwzHOsaT6lPol/4u/29zSCk4xfH7Rykmgn1b44lWU9KE/QDmpc/1obGN0e7m2a4Qhz8jbG2l5PiAyo8J7HvpGOQvt1NP/U/EIxnyDnfYzJmmCVBPftH/ZMA0PcZOW67Dm4sdKIrIf2YHL6+6hAYcB+6z/yzpL2pgslAd+f6vyL+Z6489GHY3vjeCVkSfRzmkp2qv8LoNXU3ogPAcFUEuIzftmSZC4MylAvSTueApttysF5bqpSlZRJMlMYlZ/++gfhMBpXlGSoDJ2cF2Cbfx+Ilvm129rJecGclgfnTaYcQZ6/VfEgafAktXsizbNxvv15i3XCbYfGthmMbRVsfCbE72bJ9GjWfW7rfSPAHrhf7nHLFFUv0G10ToVW7YdL9oepyZDt/QuvOhFoi+ZE4rYJLkM3YRjSoe4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(82310400026)(36860700016)(56012099006)(921020)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OSBjIDDlGAIq6IlKPuVBlvAMDlZVUeV6WkvFl2q73uYrBv1WQ2E8raQFN3+ur+zKs/sshvK3XNXPZSWyf4ky280stBNvGaFKkgskEdNQwxofpWhBIjl2cEnSlbfS6QAEjAIAkCI5AxOZQzC2MJVhNdTyOBwdH/eDX0OewQvimPVjP053eLjjFSAmTQLKJKvocKlPmALLavcm8PmH58CANZaPMT3zaUjhXYYXzxAgFqL3gMLobNsKht0iXqGz/M9ze6kCHDN3wRyat4LwUMSQAmd1c67MAuRSFlIiDtIy2HHxg11f53iqzQa6Woy0ZM2RYEKaALYlAjqI3PZ3x4pzpjKHShiyBxMGHj/D0jWZwaK+Wg8Qa4OVRzAEQ2Iwta4DvaB9JyvQU84acnSsUIC7+d3eUVxJAJnewiFvMOjQfllzt316kugazYmF/GBpDJu4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:20:23.1708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c3fa98-1032-4c66-8e9b-08df2ba1615e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE949.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356

From: Manish Honap <mhonap@nvidia.com>

vfio-pci-core must stay free of any CXL header dependency, so CXL Type-2
handling lives in a separate vfio-cxl module that plugs in a set of
callbacks.

Add the registration interface:
- vfio-cxl registers a single struct vfio_cxl_ops at module_init
- vfio-pci-core stores it under an rwsem.

A second registration is refused with -EBUSY.

The owner field will be used to pin vfio-cxl for the lifetime of each
bound CXL device.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 24 ++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..2cc5dd20396c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2178,6 +2178,30 @@ static void vfio_pci_vga_uninit(struct vfio_pci_core_device *vdev)
 					      VGA_RSRC_LEGACY_MEM);
 }
 
+static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
+static DECLARE_RWSEM(vfio_pci_cxl_ops_rwsem);
+
+int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
+{
+	guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
+
+	if (vfio_pci_cxl_ops)
+		return -EBUSY;
+
+	vfio_pci_cxl_ops = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_register_cxl_ops);
+
+void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
+{
+	guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
+
+	if (vfio_pci_cxl_ops == ops)
+		vfio_pci_cxl_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
+
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..9fe0d1a3a370 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -66,6 +66,16 @@ struct vfio_pci_device_ops {
 			       size_t nr_ranges);
 };
 
+struct vfio_cxl_ops {
+	int	(*init)(struct vfio_pci_core_device *vdev);
+	void	(*release)(struct vfio_pci_core_device *vdev);
+	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
+	struct module *owner;
+};
+
+int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
+void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops);
+
 #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
 int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,
 				struct vfio_region_dma_range *dma_ranges,
-- 
2.53.0

