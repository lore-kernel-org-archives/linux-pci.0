Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE733783B5;
	Thu, 28 May 2026 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957127; cv=fail; b=UE76reEu9GUCv6JDqi22+whInQo8+LlAOy1Eot2GArBHb89qibQlFCVJ4bHxSnEaKF6zmmPynU/+9D61umAyXiU9/TNj1C1Zi5yVWQLCsQJFYAyIV6OYHHyqUY2S2C1Gpj3KR/G5tfnOVVKTk9LImrbFhHWK/l1KSqiErjA5vjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957127; c=relaxed/simple;
	bh=RXc6h4LSKgyKi45dlbaqkH+beR20QfZkUNCUjK/1zhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WyJZHtJeELrNI+v9bGIVHLoIS1X2/IBSioGtKkdQejGlyj2YolQlFJ65iY8PkSJwDcWOKvbovS0vxLO3d5ZEsAKMhrhyPk8rwgST75T8Vz8p6Rwe9CPH0KE0VQi9RlCJ6OhplEZ30p36gpTyvwYYRP1tWyCxaWEuyC7uWZ9B3bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJ9RNqlq; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJ9RNqlq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOTJhcKtXbWF5aB38bvnSbSIaHO3acDjAUezYK6fF72Eu7qxpKqpu4ZA+yV79g8nLhQhlRqamJRa7epfLseY7ta4iMgMeLkQ/qwFsV2yCWgwKDwRrbKmaVeKhImBOcKimp1ipb5hd4JguXAWT0zkYnV9txKNBc7z6u37KR9/HC/HOlwCbGQjBwsldHGYmd2eThbtDYjUbmdqGEIFM1RnKSKwsdWREvEZhrLpdBFBhBa8fgh7WT4ZUlbARISo5Px3un1dLiPqrhLfM5t5ELppPkbMPGPwypKzw6Ml1X8f1MFuDwHIW2HV5In5amBl6WfF7qg2aOVizHLB2hEFRQr6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMBNqh6jXr4tSZhXYmT4BB8OeZhtSRPQiSpqFyC0NxM=;
 b=CuAqph9xTSiFNCN2bc4NvhSp37ErRFcUc7FFSJR4dNXnJvvjqpd4Rzl6UpqdcRFxoZazZYsdRuD3WGZMr6GIDx+flJJwANlDNdVG+ZMiK4nTwIvEF5NSuGTOi622gjAkuROtgjHDZlvL+B4sQM8RLKM7ePFcauQm1L6b++gLX91zRaOHERXJTA2g7jN2vyIc+04+kbuQqbylViRmTH6vnnQI8jp09rJy/ldqJVlht2VcLzRffcseC7eshTaxr/qgxrbioI1s0q0U9ogUAvXH275Pg3xzqDbFsM5rx9i4q0wkM8ew/Jb8EpGQWJ8kNS92uwAu69Y+NkLOj1fOmPYm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMBNqh6jXr4tSZhXYmT4BB8OeZhtSRPQiSpqFyC0NxM=;
 b=aJ9RNqlqYvGSPbzMr9SjwzGWWh5chai7ShD2moSD3nzOCr3as4iKOqRp5spq6y3BGn9QKMoRhx/EGEEVO/nAua9ED/lHFsDy0XgCWmtxDicx2EoD4fRkMKAT3X3d9vBsE+k2RxfYIgerEv1PArKPdeduI79lDPlv2gCm1upY45T3poP69D9NOtErfl2H5grAxJeF1hcMWW2LGdpFG1/EcV0wplstW/UNpyofxJTP/s3fd2xS5/8EV91rmdHHQ8EmGh1Dc+F8eHRknwXnsQFWTrrNaxetqiLC6i8HPsehInDKx4AHd4QGRBIR9JiTT3YFw9KOhVqwwhDtbjDTMJj+4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:32:00 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:00 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v6 1/9] cxl/hdm: Add helpers to restore and commit memdev decoders
Date: Thu, 28 May 2026 08:31:46 +0000
Message-ID: <20260528083154.137979-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::23) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 57820bb0-ad09-4237-8f82-08debc93964a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	B5XWZ8l7fGv1cwEbjVKDYFkF0VMHilBZawOXB33b1mXfP2WXbJgPxzCE4kiyPDuvw7U7IgCmMeHtdWcv0ANgl+9Gn6OGXeX0VHOJwHXAzBU2+oMcRpaiqB5FYHJdspTVlyUT/xpgaj+ISx6tbyXy1+7fXzZZx8q10J4/1zoblDlJbop0Zw37WzTd0KF9eFORbLtbtNomampyHmjzNC8S8PaCuhSh9agsB2/MwjWic17mrSnuat1oWPVJLZr6sSqIP6phsNgqG3/RH3bnKPZiGTAEEkKAN1wgb1ymkgY7qiUOBbL9FOpMn/zkxW6hFngdhAlQoPpCMUJ2MeMNCsHIo1RWCALM979uuxXmmHQ8dWXRlqSGsxPi+gSD1BUxrYF83V+3ZixR/uLrMCdV0zjLaWIVNLKIz2fLuZZI37alCtBWVC0CUBH//E4jp7DJqZRnVbiV79GCbRFhbFYRklveaRTshojeK1NMj3K1azBZHGmjnEji6xcg7S9rfZdwlUnSGgBRPFrq6f7RnUQ3oZdHicl/xk4IfAbHPNezw+JZfG1/bj15HtsIyNRbXhqNou5L1Gz+bMecUppyr4OIFnxShleNiMOy7OPECJ2VGxXPqxXGRb6RV9VPQ8vcbvPswypO65QlJ+G+yzcf/bh7qsKu991Ed97HpoTol0YljIkfv68B8/BaH2da3WDUr35xcq8d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeMpGDiaSaR3t6fX6Ak/7nIhUXoA/zyOprlUCPWLp1YfibKCXFyimmO/MM3T?=
 =?us-ascii?Q?8UgbQZeLkulcwZzOPd/tMUVNICwU8LqYiET+S5D/lKAZ2nMqwUhpGSv7ufHT?=
 =?us-ascii?Q?S8WrNddVOFzv/N81XbimdIpgUZ4NLMLoXLPUA2EXqPUlzqD1jTB4F+gdgROp?=
 =?us-ascii?Q?5Y0SWQAsIPWbCwIkkFfE5uOVEeD6eQw3CCBpcg3mFBGwZhRVXQRTMoZMQUMe?=
 =?us-ascii?Q?z7bFPdzMZEL6GmlggWNzTXfPfcoN3//ZfwYrt4Zee1wwrZwRHBlzfwdHVUU3?=
 =?us-ascii?Q?hv7LVOLN8Tlvrjt/Jsj7gikabyH9NMGEk5EsNGHk91K59d5BO83r3SOk2jOL?=
 =?us-ascii?Q?gfcyKWDP/8lpvvl4hC2rHqu+GCWO2hMiDH1zvEp1uRRdYwrujYYYJp74xpbZ?=
 =?us-ascii?Q?v0AnMo04JkM2z4P+nPQCRVXWek6lln/D3AFVEwun8XJE9fwGcdnfOYk3of7e?=
 =?us-ascii?Q?MPeqpF1ZjuxkTZ5y5B75Rxeh1A5XWGgzk8e5MSVQUJDsDBsNn/k93ZoojikK?=
 =?us-ascii?Q?cbhEXWMYuAFN8qZ1pULY2LAsZrXfoAreCp+iXVNIMQWUOtJRK4Pgk+r/OrEj?=
 =?us-ascii?Q?BLqpiydhhiQRAgBdCi84Q4OeVzUNCIP73oOXGSCg1NeQDJ4/WHMRi+FfGwlT?=
 =?us-ascii?Q?YyznHpy62DY7umLfcVw48mxUXlQS6eWYmVl9I5e5FB/Q8IGBbuB3JX6xD8Rb?=
 =?us-ascii?Q?2XM5RXEljvbWyUnkHAtJO+ptpJOYAeu3/gIdSO5amvjcWGEZzbqRfpO/8O+J?=
 =?us-ascii?Q?kAJTH5urga6ULpHdo0biAxums4D8aH2tCODP6erlNQREgf/Ek2tWPEWqec9a?=
 =?us-ascii?Q?GCD+O9HJRpnKaI4H1a5JUS+RCd+w0jl4CTWX6T93PbBDyuYQvM/Lnqa5AXtJ?=
 =?us-ascii?Q?p/Apz4HJbUTUZWaV5T8iti/BSiVLpvSzKsmYFXDMY9wwgvBLFXPINmD+vMNj?=
 =?us-ascii?Q?spRbDX0g+zC2AfCCiv+mdqgScHfxeFfjC+6rstv2p8H3jI5rmB/w0olM2xiJ?=
 =?us-ascii?Q?BPeXUfAofCUscyf2MMeiJzb8aD/eji2BUepDOmKXdzvnwt1Yim2SfOnRSg1U?=
 =?us-ascii?Q?LZkNehSxgm9PFUOY6Vh3hnkhj1DCTHIOvyPIp+tuGXj5dZ7REjfQWRJAYDsp?=
 =?us-ascii?Q?Ge5xdD4ZrkSG6BrRKKpXP4oyzqse1L6/kVY18v1UlZG+rMjvLsYXLvfDWsX6?=
 =?us-ascii?Q?nCkLuxMAect8TRsahUqNnMU12JdyLil5mtVLBMty/WzVnFWLpQ6hki/0/DUo?=
 =?us-ascii?Q?E5hr6LzKPZYe3L4qUPJJJmm1ElEs8SdfrZQ2JvpVr2mEcxn32uPrnZ6Qm3lw?=
 =?us-ascii?Q?edBSj4osWq/RhgwgYjPJrZp57jRyDKdcMg89viOYCP73cpCXU2hy7LOw3IKI?=
 =?us-ascii?Q?pAs0vChgVz2XvDxqU6OWsDo+w28wBYaD7HPKIV4HikfAds/CXy2+PlORSxJz?=
 =?us-ascii?Q?XsH06IQVgckqKkH95XDWBBE/E401TimwMx2IIm5kEH2CfnPkAzwpExhrMYaG?=
 =?us-ascii?Q?gP2SOp6a2tZsC7xG+8RkoUM17yZbVxs5ygZ9arWQNVchcga1ZnSP4ojqhvBC?=
 =?us-ascii?Q?O7AXbc92IiNrf9Ql/wS4/FzAcsS5dg7aueXzX4ePtVW7+J4uvVamrGfQI47x?=
 =?us-ascii?Q?XC9f+7vp8Q33ZvHMNsfHGyRtAzDGZbX0+Zopc1jKLlk1rCnjg5pMdxT2iocX?=
 =?us-ascii?Q?oForYjMCIiIvStEY4XJWNpjGB5XJDlsu+9igGtPbgu0O7lIvSGNwQ994J0q4?=
 =?us-ascii?Q?DMoqF4hNEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57820bb0-ad09-4237-8f82-08debc93964a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:00.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYwcSL9xT0bsYCrmaAav6bmH433HkRgX6VfsVCDfqqU1KacE9Uq9afYH8ud3SX5+S6PjpTTcr69TEpXIYZV6Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Add helpers to restore endpoint decoder programming for a CXL memdev from
CXL core's cached decoder objects, then commit it as a distinct step.
Callers are expected to have established reset safety and to hold
cxl_rwsem.region for write.

cxl_restore_memdev_decoders() restores programmable decoder state while
keeping traffic disabled. For HDM-backed endpoints it programs enabled
endpoint decoder fields without COMMIT, keeps the HDM Decoder Capability
disabled, and mirrors matching endpoint DVSEC ranges where possible. For
endpoints without HDM decoder registers, it restores the legacy DVSEC
ranges that model endpoint decode.

cxl_commit_memdev_decoders() enables the HDM Decoder Capability and
commits enabled, unlocked endpoint decoders after safety checks pass. It
sets COMMIT only after decoder fields have been restored, does not
re-lock decoders, and does not set DVSEC MEM_ENABLE.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 318 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h      |   2 +
 2 files changed, 317 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..f7af1041a9fc 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -679,7 +679,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+static int cxld_set_interleave_fields(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
 	u8 eiw;
@@ -690,14 +690,22 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	 */
 	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
-		return;
+		return -EINVAL;
 	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
 		      cxld->interleave_granularity))
-		return;
+		return -EINVAL;
 
 	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
 	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	return 0;
+}
+
+static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+{
+	if (cxld_set_interleave_fields(cxld, ctrl))
+		return;
+
 	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
 }
 
@@ -927,6 +935,310 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	}
 }
 
+static int cxl_restore_dvsec_range(struct cxl_memdev *cxlmd,
+				   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	u64 base = cxld->hpa_range.start;
+	u64 size = range_len(&cxld->hpa_range);
+	u32 lo;
+	int dvsec = cxlds->cxl_dvsec;
+	int id = cxld->id;
+	int rc;
+
+	if (!dvsec)
+		return 0;
+
+	if (id >= CXL_DVSEC_RANGE_MAX)
+		return 0;
+
+	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(id),
+				    upper_32_bits(base));
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
+				   &lo);
+	if (rc)
+		return rc;
+	lo &= ~PCI_DVSEC_CXL_MEM_BASE_LOW;
+	lo |= lower_32_bits(base) & PCI_DVSEC_CXL_MEM_BASE_LOW;
+
+	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
+				    lo);
+	if (rc)
+		return rc;
+
+	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(id),
+				    upper_32_bits(size));
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
+				   &lo);
+	if (rc)
+		return rc;
+
+	/*
+	 * Preserve MEM_INFO_VALID / MEM_ACTIVE and any reserved bits while
+	 * restoring only the programmable size bits.
+	 */
+	lo &= ~PCI_DVSEC_CXL_MEM_SIZE_LOW;
+	lo |= lower_32_bits(size) & PCI_DVSEC_CXL_MEM_SIZE_LOW;
+
+	return pci_write_config_dword(pdev,
+				      dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
+				      lo);
+}
+
+static int cxl_restore_hdm_decoder(struct cxl_hdm *cxlhdm,
+				   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_decoder *cxld = &cxled->cxld;
+	void __iomem *hdm;
+	u64 base, size, skip;
+	u32 ctrl;
+	int id;
+
+	id = cxld->id;
+	hdm = cxlhdm->regs.hdm_decoder;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+		return 0;
+
+	base = cxld->hpa_range.start;
+	size = range_len(&cxld->hpa_range);
+	skip = cxled->skip;
+
+	ctrl &= ~(CXL_HDM_DECODER0_CTRL_LOCK |
+		  CXL_HDM_DECODER0_CTRL_COMMIT |
+		  CXL_HDM_DECODER0_CTRL_COMMITTED |
+		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
+	if (cxld_set_interleave_fields(cxld, &ctrl))
+		return -EINVAL;
+	cxld_set_type(cxld, &ctrl);
+
+	/* Preserve setup_hw_decoder() programming order, without COMMIT. */
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	writel(upper_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
+	writel(lower_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
+	wmb();
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	return 0;
+}
+
+struct cxl_restore_ctx {
+	struct cxl_memdev *cxlmd;
+	struct cxl_hdm *cxlhdm;
+};
+
+static int cxl_restore_decoder(struct device *dev, void *data)
+{
+	struct cxl_restore_ctx *ctx = data;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_decoder *cxld;
+	int rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxld = &cxled->cxld;
+	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
+		return 0;
+
+	if (ctx->cxlhdm->regs.hdm_decoder) {
+		if (cxld->id >= ctx->cxlhdm->decoder_count)
+			return -EINVAL;
+
+		rc = cxl_restore_hdm_decoder(ctx->cxlhdm, cxled);
+		if (rc)
+			return rc;
+	}
+
+	return cxl_restore_dvsec_range(ctx->cxlmd, cxled);
+}
+
+static int cxl_restore_decoders(struct cxl_memdev *cxlmd, struct cxl_hdm *cxlhdm)
+{
+	struct cxl_port *port = cxlhdm->port;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_restore_ctx ctx = {
+		.cxlmd = cxlmd,
+		.cxlhdm = cxlhdm,
+	};
+	u32 global_ctrl;
+
+	if (hdm) {
+		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+		writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
+		       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	}
+
+	return device_for_each_child(&port->dev, &ctx, cxl_restore_decoder);
+}
+
+/**
+ * cxl_restore_memdev_decoders - Restore endpoint decoder programming
+ * @cxlmd: CXL memdev whose endpoint decoders need to be restored
+ *
+ * Restore only programmable decoder state from CXL core's cached decoder
+ * objects. For endpoints with HDM decoder registers, program the HDM decoder
+ * fields and mirror decoder ids representable by CXL_DVSEC_RANGE_MAX into the
+ * DVSEC range registers when present. For endpoints without HDM decoder
+ * registers, restore DVSEC range registers only.
+ *
+ * This helper leaves CXL.mem disabled: it does not commit HDM decoders, enable
+ * the HDM Decoder Capability, set PCI_DVSEC_CXL_MEM_ENABLE, or restore
+ * unrelated DVSEC CTRL, CTRL2, LOCK, MEM_ENABLE, or other control state.
+ * Callers must perform final commit/resume steps only after reset safety checks
+ * pass.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_hdm *cxlhdm;
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	if (!endpoint)
+		return -ENODEV;
+
+	cxlhdm = dev_get_drvdata(&endpoint->dev);
+	if (!cxlhdm)
+		return -ENODEV;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		rc = cxl_restore_decoders(cxlmd, cxlhdm);
+	return rc;
+}
+
+static int cxl_commit_restored_hdm_decoder(struct cxl_hdm *cxlhdm,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_decoder *cxld = &cxled->cxld;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	u32 ctrl;
+	int id;
+
+	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
+		return 0;
+
+	if (!hdm)
+		return 0;
+
+	id = cxld->id;
+	if (id >= cxlhdm->decoder_count)
+		return -EINVAL;
+
+	/*
+	 * cxl_restore_hdm_decoder() programmed the decoder fields first. This
+	 * control register write sets COMMIT as the final programming step.
+	 */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+		return 0;
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
+		return 0;
+
+	ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	return cxld_await_commit(hdm, id);
+}
+
+struct cxl_commit_decoder_ctx {
+	struct cxl_hdm *cxlhdm;
+	int id;
+};
+
+static int cxl_commit_restored_decoder_by_id(struct device *dev, void *data)
+{
+	struct cxl_commit_decoder_ctx *ctx = data;
+	struct cxl_endpoint_decoder *cxled;
+	int rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (cxled->cxld.id != ctx->id)
+		return 0;
+
+	rc = cxl_commit_restored_hdm_decoder(ctx->cxlhdm, cxled);
+	return rc ?: 1;
+}
+
+/**
+ * cxl_commit_memdev_decoders - Commit restored endpoint decoder programming
+ * @cxlmd: CXL memdev whose endpoint decoders need to be committed
+ *
+ * Resume endpoint decoding after cxl_restore_memdev_decoders() has restored
+ * programmable decoder fields. For endpoints with HDM decoder registers, enable
+ * the HDM Decoder Capability and commit enabled, unlocked endpoint decoders.
+ * Locked decoders are left to their current hardware/firmware-owned state.
+ *
+ * This helper does not set PCI_DVSEC_CXL_MEM_ENABLE. Callers must enable
+ * CXL.mem only after all reset safety checks and decoder restore/commit steps
+ * have completed.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_hdm *cxlhdm;
+	void __iomem *hdm;
+	u32 global_ctrl;
+	int i, rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	if (!endpoint)
+		return -ENODEV;
+
+	cxlhdm = dev_get_drvdata(&endpoint->dev);
+	if (!cxlhdm)
+		return -ENODEV;
+
+	hdm = cxlhdm->regs.hdm_decoder;
+	if (!hdm)
+		return 0;
+
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
+	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (i = 0; i < cxlhdm->decoder_count; i++) {
+		struct cxl_commit_decoder_ctx ctx = {
+			.cxlhdm = cxlhdm,
+			.id = i,
+		};
+
+		/*
+		 * Per CXL Spec 3.1 8.2.4.20.12 software must commit decoders
+		 * in HPA order. Region setup already enforces that ordering by
+		 * decoder id, so restore commits follow ascending id order.
+		 */
+		rc = device_for_each_child(&endpoint->dev, &ctx,
+					   cxl_commit_restored_decoder_by_id);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
 static int cxl_setup_hdm_decoder_from_dvsec(
 	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
 	int which, struct cxl_endpoint_dvsec_info *info)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..b51b1e9d6400 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -794,6 +794,8 @@ int cxl_port_setup_regs(struct cxl_port *port,
 struct cxl_dev_state;
 int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
+int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd);
+int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd);
 
 bool is_cxl_region(struct device *dev);
 
-- 
2.43.0

