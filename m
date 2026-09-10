Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82E39CCE3;
	Thu, 10 Sep 2026 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082283; cv=fail; b=uN5WU+J9r/zIZFB7JBAjwHEGYwvEc5h2IL3aADbNpAmvwjWBkIwZKS7QdgbULlKZy82JzXhb0bgvMWo70e7rMzlRbQ803Dx1r5P+Ox/xeb6Do3KXtz4uenP1BaZch7P5arWEiOIBbHl+woJ8atEwJl4fHWA/0XXS0i2L7XaHwa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082283; c=relaxed/simple;
	bh=crL3+hZqf/vqmu1lMYb2xcMh+ZutIAsXFKo5OUqIedc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtYDCm+v88pcPtDydkca5dz13Iv5TexNzryW11IFrUV+LmcDIbZ06yS9IKYcdTEySTkfBRlX4qstagxssgmMUjTs7aX5n2QdnSL1Q43aD6G5f51kS799qo+AOmzNEKDjPRY4z2a48nsQPWQYPZiflDAp3eiDD5ICVi9x/WJaegc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHZG+cxh; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHZG+cxh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLES5+EdKSyjD8z8kvKdaKBX2QujOewbhQ9B0qTROE92xdtWkseRy6kWRyYmJiwQlCJsjW43e5MZvXdD5HvLCbSkv1fgoYUvhSIiqScDfs0MBINicfAK3VX+6x4uPvd+rqCAnMCmRClcdHZrbXeARg3bzTxQ1fE0V4Q/ro8Op+RTxfZhtJTJqx8vDg1AkN8OZeqAq/ZOu7p4b0700SipHKfZ8XF57wqP/3m5tMALx/1tWva3RnAi3860uvLZsfQJttGzECD4A+/6QByPRwgK2ApiGpz/gWELfBBzdcrEUW/cPV/SxPUH0sE1ueGsJpc+S5hIhbkxP3a1zTMwy36n8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnovKc7WNb552cKj4bphsrhZjDxOLKEnpluZjLaQLwA=;
 b=Kkyl7NndW50w7BlqqBJZvmlxFfLcqZdaolQ48tYPkoNkRxS8PUpR7b+vEiv59YO5veZCyir+gAFxmTtz20LpghSPY4d8oQ5VPEMrm+FBxLYFTf5tnKI2mjbTn4lQPHpjsgmRp6zD+yuiDhhzf0aEy4dOnCHWRBdaJgYa2XcAhoIXKfyGniWp5I2mpRnY2iM4RbJ66c7aQyaxUBKU7hUz2DpTAtaUS4MSB33ZESyaq/cH9HlWDwwDkuj73FKHUSyrKpdPVhcMZgFxGJ1vphdRMLnXOBtFcvZNtZWH0hO8SMI2Mg1IkbIxlq1RP989pw4pMsj45XPQRxK8WYf8EucV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnovKc7WNb552cKj4bphsrhZjDxOLKEnpluZjLaQLwA=;
 b=fHZG+cxhczeivgLu4n1qSJP5dTHXDUojHqnODuJHg+nMmUEaBj8Hk2Qna6LVvXCpoHDXqVJGUg+q8CqCPE7n3l5nB8spGmxsuZnfrAbct/jMiWJ6QRbuK6j/xQ0NFRELeAjALWGY1e3mqfw+g1mgma2sYoe4Aa5LTYcmzAjP4i6P3/gm/7TmZhmJU5J3BquVVYxPCDlQgwupPo2VaV8emS21MPi0HsekotUS7ZLS5jAOiBb1F9FbiltWqXhOUeJe4k4snoJYqjjZeX3TuIoZMRpOc68yya92LgSPusyqb0blSXDCiqIzblYIngwT4H2xLEoSNQadyLK3bbPuc9t8fg==
Received: from BN0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:408:141::12)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:17:54 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::64) by BN0PR07CA0001.outlook.office365.com
 (2603:10b6:408:141::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:33 -0700
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
Subject: [PATCH v4 10/15] iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()
Date: Thu, 10 Sep 2026 16:17:02 -0700
Message-ID: <cbe6e6f578af848f4efdd8d1050181032effae37.1789081084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: ba84a20d-f378-4a8d-b8a9-08df0f91be08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lTRBgM+U2WCxCuvN8lMCqy8qNCCHut+Cl9TH1qkXEJeg4/w2xlrmtnR/vwfC83vmhM8WKKVl0y7KKzBTMXnCCc+K7+OIjRbh0pUMpumxC+F5ZwVP20Gww5cvfRa4dSE9EFkxogTcoWnXb/K72jTpvqjgFDJj40rJv46Bxue5BJyg3QS4wWluTCvxV812FuO/nniEoHMqYbMsSx1pIAEs8eqd26jvLeff9Eh/udY5LtnK7L+cHav+qEUnq1mzWjCTIgKvSJsBpI7xMcplFrbwBSP2NaOzhlYt2OP5OE8Ww+sTvDPkD5np93qMwqEsB6U7blIAeoMUMMTUEutbDtvoQz0wYHywF51dXGe1HWxS2TsIcuNiozFNYdHl5oT9F7btQKChPDu8i7K1CAeNu38Qm+ILYjle3AaY+t5npQIpjY5VkwQw6h+tryHay43AhNj0t32sZ32Zv6lwrLYFJwPGdzpzFbQAMuhPZLuLMypRl1NkA2/24ef9LDL0qI+lSrNaLltvFZVW/TsWzTtf5oLpxowMSwemVKO9BFqQw00SG9FtfG+x4bcmoEpNcAjvOtlCFxsUg663qGS97G2+omWaJpQ8DImC7fJau2gTP7IY/TQpVz1MuHkkidR03YBmsHNutUxXPGfC2YCjAGmbYGnCW3o7Bm9AzY1s6CQE6U735zoLMSxQJzVAQd2ke84NnKsJCc3hu/6DxAmm0vgRNoseKA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CLH4ryewxEIpbxohRp+nO10mpNqjvJISNCwunHN849TTwFWz7UGHTKrOTXOooPLbVZUYwiqkat817SgTyV4JZ9zEDYCaZKO37mH6nvou/Yk9Ic62n3j6e4MtCSEmvLgPDiDKSdYlhgsg06glCPst0fqahgG9l7Kwz5VQd7K6S6+YaI44EV+2P1URnC9g07gtYDvWLRhB5bV1z46yUvaCPSTOn3X68s/PiRcMYfxKjHX0V8SjwEoaR+IBZEbX8DfKX9Jz2cPFkeXdgVICdCOXNQwJSDeWU97htv+9uKG7aQXDCfvJYrJQvDCuXlHIAmRSZgscwbzAiOVdL2y01+5w+cOyuHagJ/RqkcaY+buLjBg+CYU+oOPaLj9D3eeT+GaHNOgyOJ/+kgeipR3h/oGuUbrbziIEaySsDTTysl7VowyYbeLfxih+8cYyODcpRJib
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:54.0904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba84a20d-f378-4a8d-b8a9-08df0f91be08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277

For a PRI-enabled master, convert every PRIQ entry into an iopf_fault and
report it through iommu_report_device_fault().

For an unknown StreamID or a master without PRI enabled, keep the existing
LAST-page DENY path. Merge its two messages into one ratelimited line so a
faulty device cannot flood the kernel log.

Discard any PASID Stop Marker (LRW = 0b100) prior to the fault report and
the DENY fallback both, because a Stop Marker does not expect a response.
The IOPF infrastructure requires the driver to discard it, as per the doc
at iommu_report_device_fault(). This also matches the intel-iommu code.

Note that master->pri_enabled will only be set by a later change, once all
the PRI paths are ready.

Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 43a6029cef430..c631c6344685d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2370,6 +2370,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 {
+	struct arm_smmu_master *master;
 	u32 sid, ssid;
 	u16 grpid;
 	bool ssv, last;
@@ -2380,9 +2381,47 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
 	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
 
-	dev_info(smmu->dev, "unexpected PRI request received:\n");
-	dev_info(smmu->dev,
-		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
+	/*
+	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
+	 * must be discarded before fault reporting: see the documentation
+	 * at iommu_report_device_fault().
+	 */
+	if (last && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))
+		return;
+
+	mutex_lock(&smmu->streams_mutex);
+	master = arm_smmu_find_master(smmu, sid);
+	if (master && master->pri_enabled) {
+		struct iopf_fault iopf_fault = {};
+		struct iommu_fault *fault = &iopf_fault.fault;
+
+		fault->type = IOMMU_FAULT_PAGE_REQ;
+		if (last)
+			fault->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+		if (ssv) {
+			fault->prm.flags |=
+				IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+			fault->prm.pasid = ssid;
+		}
+		fault->prm.grpid = grpid;
+		if (evt[0] & PRIQ_0_PERM_READ)
+			fault->prm.perm |= IOMMU_FAULT_PERM_READ;
+		if (evt[0] & PRIQ_0_PERM_WRITE)
+			fault->prm.perm |= IOMMU_FAULT_PERM_WRITE;
+		if (evt[0] & PRIQ_0_PERM_EXEC)
+			fault->prm.perm |= IOMMU_FAULT_PERM_EXEC;
+		if (evt[0] & PRIQ_0_PERM_PRIV)
+			fault->prm.perm |= IOMMU_FAULT_PERM_PRIV;
+		fault->prm.addr = FIELD_GET(PRIQ_1_ADDR_MASK, evt[1]) << 12;
+
+		iommu_report_device_fault(master->dev, &iopf_fault);
+		mutex_unlock(&smmu->streams_mutex);
+		return;
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	dev_info_ratelimited(smmu->dev,
+		 "unexpected PRI request: sid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
 		 sid, ssid, grpid, last ? "L" : "",
 		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
 		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
-- 
2.43.0

