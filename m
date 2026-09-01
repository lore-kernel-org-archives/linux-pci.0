Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2433672A5;
	Tue,  1 Sep 2026 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222886; cv=fail; b=dkdrL8FSydi6yLd6WwXSmsGJnXxKk758nRuOEwicLy+h27vBIVrU56x3ibEK31E9UxKpWPi/jC2kKJXMf2s1/9nrOZr5+ksEFXctV2itk6h4q4UHXQ+7y3aDNEi4kau0rojh4JAkQ8eqoEHenOajUs8s3odAfXXqDrVfwFAG3C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222886; c=relaxed/simple;
	bh=Z/TE4TwBl6CRcX/T/te9ElpvIHeBad9fttsgy4+MDtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6Z/l1foa+IHSV4ZwXhPHWzSdfHFbHALIWhN88CapfnoXG1Umsf3ftGgZqjUoJi3IzPuDQazwXwyEuMRHYxYAZI0rwigRdSKTrkey3yfE3uV0ukIqAGFLm0YqFdFOFA9OfXoNIBwGMoetPEbCfkoGx3iaR8XUXCqLQsVvyGrQBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mpv7XuQR; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mpv7XuQR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh67qtDrb0OEXgt48rt9gVj6Bpfv9rgrAFhd2FJC2YahgNECb8S7vKPOeei7AWTQYI4PdHiZ7iMniy+st2yb9uCvaWDSJ70qcxx6Q6+Y7aafKADQMYONTOzurzIvo7IcsYGNPgDhVpoSrwWN7PdDe3wZhgs8p6EWEqPv4iD7zHsMyiFEi2zAJB0oVhThzYV156RpFhZAm9zRrOpyR43HV12VRiw6YCNSYaReb3IdEqnGh37GryS+c8JMOpezK1EW64NErHL3WfhlpBzmPTbaoYsD1SDZU6nr96gF/aOTGpwBCnBvsrUBhN4PznNxk/IrC91Wufunp0sz9rjamQ5y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OfXgiW5sChWR5MLjnHrwMf0u0a6b2/asDFkVIKeBeM=;
 b=gBQQJkQFtkPngqBaDeQZwZ0IPK2hancN0zuosxj5ghVKIwCWOT4nRstM+MWAPPtNzp5re+4gkdG5OA1qSkjECjkXvOXjrpoGH2ZbeJI4nWWesTOyAnfa9RKTwfJ6AoFlc8crk04vOPTt3JQ0oQpOHOhuJpT2zBun1P/QHH43xaG09YVMWW9YkQ6Cy7IXqpG84xkbM0eliTl/VYb3CWLGcHjayZ6pCm44b+N275wST86plySqpbRRSFYH0z75nQ56Z2qVD3Ic0dwf134jqecZS1K2KxkQRWlmmiABcwb1xLAFMqX/JMOxXLd+gyv7x+pMOeVsNNcGne1KBbmYY2+Iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OfXgiW5sChWR5MLjnHrwMf0u0a6b2/asDFkVIKeBeM=;
 b=mpv7XuQRHh4JgOYgLx5nSuyIWJsvKgAIUnIACpVLPlO5sVH5a8GpvlF4OqolxZHu+Sp33eJEWjQEe5gDoPKC9gBIF6VFBV7vvJ0wTkpv4dMgo/AIooHrkUBWBSJDcWEcjEeaznRNx4N9dEFO3fNBlgeV2NGuJ7LidwZtHJijBT3fB/WDlrD4e+cC8m2b8AwJhTLgD8NTasgNLHYoiom4fFHxBLNEO5Umr4ratUiUEvxIv4f61+xLMEtBTFluNGXXJ7bQPwghgWLIpWF56Ptl+iOPGtzH7YBuInXutym8QuoG33EhZCZUJ6jDmhwB1lP+zbm017LeAbgyMlm8DwCJFQ==
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:38 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com (2603:10b6:303:b7::4)
 by MW4PR03CA0100.outlook.office365.com (2603:10b6:303:b7::15) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17
 via Frontend Transport; Tue, 1 Sep 2026 00:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 12/13] PCI/ATS: Export pci_enable_pri() and pci_reset_pri()
Date: Mon, 31 Aug 2026 17:33:37 -0700
Message-ID: <8076427d234c9a4dab4ddf3da3737c61d02c1230.1788222486.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a312d96-e686-4f5b-e29b-08df07c0cd12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|13003099007|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	B/A6BlvPm7zm2Onhewo+e2wMpftZhNj9LpiZNpRcfYOhaioDCx22+NGULEHFMaqfZS7M+7URY20jE+B8cALbCaOjO4V5Xz8yrhqHFY8h100zrGtiyLtlYVwlkV2yXli4HQKtyKDhJZhAQ0BOr3FYD5dgU6e0Mf66rfU0D2+WUPXFGJmuokrhKUaF5lzuPAxX2i+hKEcbgL9GuCyB6+zjWoJAxnXm8L/o1qJw+h5j2eaLFC2LehNmU9CsP4vQmzBG4clPSpVeTaoA05SKCsKOq0NvAmpAbe/+pdCyfgfOozJGrKPJTj27/05wcKP27zf3L8d9Y6y3SkIt8ZNxMavgNEACW3i065JsqcfbCFu6YI8sVHuEW0uXGWc8RtYpVLnpgeHAv2N3D7kyC0NU0SiOmPPwkt4EzAttwVNh1WsFdrTKCRDUWQ/hc2rjMvVSKPEUCuAvs446Qzw+X00xoNoN5zGaiklAQwZEC+5XP4B3T5Qn9niIQ/9mf14phX81Xnr3cAV/Xb/4kRhQQXO4TJlqSg8+4k0GKrTA3vy/t8nqvmrSfUi2LkNkbz1BQnr3ifUHUvu/h9myv+wyhCB+aRIMLnMWRCz1PaR5AYGl8PPlJMLl8dkyP9XAzZsSYXr/XXBlqsjP46LhChHAA8ZV2oLQ5BQbd49Yj3+gjLjrk2gabFYf9ToA48ohW+RhZFvOOz4DFHr+K6Q0zLdkGCuuG6JPhA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(13003099007)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Xn5YQ9RZ8RXSjw5Vz4moZLy65q6/qZg7TZpY61h9vmwuzF9+KhTtLt7ZTB5W76Y4iMLWFHaps3ceG7PLXcgJhJKI980XNzHRWqzAOBMzRQRTFrubk1YaIIVBBR0ykELI+CAFio+BV07Q4yTcplo9x4vLtxzNoK64cdwPXCJm2i2oZDajhFZr39cBDy3Mts460lFcvPAE+dmRloYYxb/82PszZkMx5D5S2OINYnrdJxDw+A4qRkXUxYNeQz+yoJcmwHK/VhkvrsYCui4mYUvgkO9X3M4dox0xM4tuSGkWQmYh7R8OdwPGDtu/vdPkAkccbdl/AJ8p0JmzKkZEL1IZXqBmGeCqHT1F8SKRhHFjo5QdYkFukbspTDNn06d8WCAW2rVLKqHH8fz6XmEp/NtKsXWGvZpj8JwOaX2gZEo0UXkrBiCTPvCRzec6G72E35F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:36.4173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a312d96-e686-4f5b-e29b-08df07c0cd12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Export pci_enable_pri() and pci_reset_pri() so the SMMUv3 driver, which is
tristate, can use them from its probe path when built as a module.

Link: https://lore.kernel.org/iommu/20201112125519.3987595-9-jean-philippe@linaro.org/
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[nicolinc: drop stale or already-exported APIs]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/ats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093dd..b6de3c858d390 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -320,6 +320,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -399,6 +400,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
-- 
2.43.0

