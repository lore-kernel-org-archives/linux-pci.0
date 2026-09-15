Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557D4B1268;
	Tue, 15 Sep 2026 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490380; cv=fail; b=W8t+H36m+MAMC6+qlldqaTnbF2cz8xdrNM1MSKHnSjMoyXIUTbytZSnueeiFovNW/L25Bphk/TtKqvqPFRnAGbsBBs62/AQPu4ecA2rqPrF65uu4eXYRRa0kGVsfBs8jGxRqWUe64ln4sR2vOEdUzvnJoJ8hJjI4C7jbBWcJF3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490380; c=relaxed/simple;
	bh=/H+5ubah1W1yVci6XnFrpJpAxO+CSFLM5sza8lmwD48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhxLOAAMpS9QljLOTCrINHJwNQyyq24VU6VtakZpM67RyjCu0kalk/js08DsxJXKxi2CjxXoKW96T0C7IYO3MiYdOunDzZed6FgLpA4OOXiMet/+HTQ+aHd7RyyN98FADGjIwlvY6bBqG0Hc7EIs//9Jh0kOp98IljvZy/vrxus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kTF+YLab; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kTF+YLab"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p83RItA7JR6sr9qL2C32uwXXkzYUmNeEGDdy5bzEtpSw0JA5ByTQB0l/eWVJNP1MfV66zsAXggGQrJlKEKxtEs0mL9h6Vey9mWFY3d7gQhXcv4tUKv1DEgN66AhGJNiW6gLRZchFi6ZF4pcxEMOj82KhaLAZ84BzNnnpBeUsgpLuTtFTvl0TrrM6PDtRUQ33vnxmWDe/AI2E5ZGLdFhI7VVkc5JbU/6T5Y15YqjQ9hG44IVW3e+oBGLDfR2FcuzPo1QBD8OG2GKIhKIEInmtUGpJpNmHd+JpRsd+6+c4jP+LLzfDfhX9yN//H0kXFYNxsGhxtpDSy47vLyLZyDVRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4v8M6TZQ1VmtJGXFaLzk3h6NLJ/ycuAO8t4dOQz6O4=;
 b=jI8XDyfxEQzngoUXKdVIKtpzOLP6kMGnIwAIvszA5xLc4rIfdA+rJTr98kslW9NnLbjQ9RWhvnlpDEAIeR0Eo1hTULKD3eZVX4vZv+FFSeHCkai+H76NYT53UBlT2CIxwbKFcctn5cSx8ycihm1ptuHy02IaFs1SML/Q5WEVFrf0kraufbrwMbARWtbuNDIM0L9raaUwcapoYT2ZcL3tKZvRyabP9Q47nex8xJaEzWTv/UL6m9jnAI3/8NywgB1eBQn/I5y5MS9BPIV+UVERodcoBNRxs3ozBl5a8jkPZAn+lBsTu9TBYU5ADbumyB3oY6X8Oa8qMz7MV/CqXzg5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4v8M6TZQ1VmtJGXFaLzk3h6NLJ/ycuAO8t4dOQz6O4=;
 b=kTF+YLab44DWzm08ejgmG3raSw+j9byOrHltisp+8rvkCmkdR5tEGiZ+aULP2iZ5I5C6Gk0IG4Wv1pMq9QUpxqIA/SJvCDTvVrkQIeFgRNpE9HFjdDuwoqmyPSZOAoYytVwxCPdkUXpYhjS1LKhukZvxs0BBVO076br4MB2KcJqtPTxcQoUeBdQKPlPNBxQc+ApkCKp5WZDxRG2kgKCbHzn6ALPLnJLKZUOcTLq58AqyvAVdLDUyoR86N8H7WHCAcklOt2ZR6CTxNvGgxMz8T3g6s1u6B7yDtTgeAveX4GnEb/9wMHEcHk3hCWh3d/fnyRxI7gDCO/zLvZCeaU5Ksg==
Received: from BN9PR03CA0336.namprd03.prod.outlook.com (2603:10b6:408:f6::11)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Tue, 15 Sep 2026 16:39:18 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::71) by BN9PR03CA0336.outlook.office365.com
 (2603:10b6:408:f6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 16:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v5 13/15] PCI/ATS: Add PRI stubs
Date: Tue, 15 Sep 2026 09:38:25 -0700
Message-ID: <17b39a2056c9128f195a5fd0764df0b6c5f7e980.1789446520.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: af0de1fd-e6d1-4a0d-876a-08df1347e2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|1800799024|376014|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	cK5+E0ZdXRdzy3Vbp0WIz0V24Lz8xci5u8UsHShEmC3lwsl8erWF+kT/vmfhV1ibiIvU2Og0Ma/Bt2+8tWLdFmZNIYfaRgQ9tfW1FT+qZmd871QtB2mON/dEFVpLLm6rsSvndU8Xp/wGmmRw3iO1Y7FHmLxln1ZActFaw9jOIyPOfKVI54w2c48Gou8Vq5xqaIazjChXeSfYT7w3s/1g+XSXV8xJRDxdTQ4RZtUilyO9rMdF5zFCtAMMck+S3SNjCsFNpc5vp6SLD7ixNFesbHj81S/AYFQekT6/P1c6Jo3Sa4d3B/b9+I28enBFtaxiQZCoyXcA8YtqrkdO//vyMh79XWRqSDiZEWSnK9DCXPFtHDZo0AjHjeV1RqIm6tdjpeW3DLsBAiiTj2hTONjU3pN8U3cR67IMdU7Ia6BDAarcvotqSniTluCaqRZWnRcCS++eoxmxLyv65ABAh6bmthLm7/ZPK+Ipfedy9oe1DQRPx1QYgBxVQo11iZHaVYuCTXNH7LaMVncdaKaKJ38qCYyL4jGl5Q/tetni7yn13IVCf2hRCpu5Cp0NN3WIKx4qEEnoKWR9vqvJ5Wpc0G1aYlGyJBumoYlQ3L8uoJOj4AURLH0PaJ9LQU8hoNaxUKrjHMOoIIYzp8kfHx35CL0s5XiDV8HI/MM+z7sFoucvYEkBElE0XHk5qcSSm+m9oSD/KfnJUEJQF+olAfv7uyrBeA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	usdwlLiV/heq9Be1xqsT2VlgVdHbNeg3DTTJpq++FAtNdhRZMgIOPz3oJnSGdLpFGswT5+rY+sBwUciRHMmGHx0P4A17zGZc6u6pUBv65q77o8jw5IAAbuhaXeSUv+3Iiz5zPO2RrQB6l3CMhXfRxjAPEevD9a1MZYHfmYee+x18WyJIGsxoT9amkg59TGYPjaTyBiRTp4XrqTceswNBXWZWuliE8+KRY5GissFVm59FLeXmb2zlbFqABROYPdau6H6X5Tq07xJhihJHmP/YpYhoLzu0pZbpHTPQd4U2J5j2DSCH3ik8tvIwgn2PwrF1xyMOQPN3iPgNmCmVAE8eYlIGH9Rti7G2kp+aBHCChpxl83lWervIxRoLHpSYq6mArMa6/DVUNCT2K3KyrycJtiPM+F7fsvTf9VzhUORk7YrvAm+83915v5F45lkx3BQY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:17.9906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0de1fd-e6d1-4a0d-876a-08df1347e2fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The SMMUv3 driver, which may be built without CONFIG_PCI, will shortly gain
PRI support. Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove unused
PRI and PASID stubs") to re-introduce the PRI stubs, avoiding more #ifdefs
in the SMMU driver.

Link: https://lore.kernel.org/iommu/20201112125519.3987595-8-jean-philippe@linaro.org/
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[nicolinc: drop stale APIs]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 include/linux/pci-ats.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index f3723b6861294..07d24c1c3acdb 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -36,6 +36,11 @@ int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 bool pci_pri_supported(struct pci_dev *pdev);
 #else
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
 static inline bool pci_pri_supported(struct pci_dev *pdev)
 { return false; }
 #endif /* CONFIG_PCI_PRI */
-- 
2.43.0

