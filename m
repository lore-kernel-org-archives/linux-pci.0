Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6033F8C5;
	Tue, 19 May 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162011; cv=fail; b=p2GD/EpbUudHWKi3VCldokFjZaE5srcotln5k594+aBxxwRnaKVeBdvqi4pYEnqs8YkWuA5t7eCV/8UIjwxCnsUsIXvO1j3m2qSr171BX+vL9kOhXWRot0Udto0GLEzHoalZFfXBEoAJ2OCj0YcmPMF3AGZaJiO2XUKuFzJbu64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162011; c=relaxed/simple;
	bh=FmE1U+rtMmcYogeBqqpMe11zknVY86zm38nw8U9+Yzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QN5I41udbJ7xX2tIyh4aWet6kBgq5xmsnHLrPTH4q/T8FusxsR1Pjg8fsuQEJKQStg36yoQMz0DUYM11nhRY3Ku6dwiQg8buDFnDc4saXGTfwPWK/m1QrVYJTWCvasw+Y0Z1xBbA2a+WtCT0Y2CpPwyGzQXoz5INyaS2AQfvmoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DzrbpIPL; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DzrbpIPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWsQmnZOuGsm9vHAU2juVGa8Ck7PzHivVLR4nG6wyLZ6g3NAJ0q5RXwZirqLNisYEiYm9xV8LEBgHW1cg27a91vurqt6f9y5J/FXauXBUZTxpYP+RuCgI8TQZE3CMfZmPnRqDK8iPMIZL8LOzQ83ZX9JlcvvMHhg1ysFbJsEl74PQkord270m7EsSWnk0seFzHIrc7qA9+74RlwjEfn1OKsR7wQyeI1+nvE7dny6kDMBi/sNIj8B5A12CIFoWTPQ9blkWTv4rQKyWBGZQ4XRapOc7g+vfnhgMAX5VueJ+AD33xLu4JZBsUpfzxlkY3Ea6Z0YfJxvvmabFkpd0Ot5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1TkWI/MIw/boaSzLsiIu7OVjl/6Mx9M9JMEqgTG8F8=;
 b=TR3LpYVN1ozcvY2pkGpw/ydG15+0UxsWWUP00+QrKRiXylIYzhHnHow4hRU3P2+OjWclp28mpXZWyhCXmRYudYq9xoHO24goGrwNCnuXW5le/uTwVInh3aqj1Grzgau/aOpb4F3t6kB0M7wwr/q90nHv6AUzkRg+mKXtm6jurRdfw6LNNnXE2ZcJhZ71tuQz3fJCvEoIC3QWEHk9eKophoWOcsDZ6O9C/lgJmTalzGGqGy84plYowEbeFsYLWC//3zZvTECdZHI2LJ0ktIc0dJi+JP/AYd8vpL5TDr84wxvlGc21/zPjW2hh1uBDryFqU5dClGzLhi4YHvU1YE8HLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1TkWI/MIw/boaSzLsiIu7OVjl/6Mx9M9JMEqgTG8F8=;
 b=DzrbpIPLJRdB/q+oX89ruz8ru6uu7Y7C5Tz5uah3kDPM3REJrHNSKos3cRdRv54yEalmErrgy8fCQYL4o3ufDBBNBXsSZtEdtqhvFUbjKEISB9tGL5WAFrRCZpyc4t6cSTqVVMceVv+MNlMVyC2rqNECWTZiXg+cprHsc1puvEeZXAMzvTp7655K5gFtDdosiabAvGZ9S0Htrt+TIyAMmfnUfc2MF6PXc1WM1XyuN2IuGohrYQirtgiRJEc2jvGMVcOIikm2waMqt8aOOtFnrE6ig2YUH8XssNCKEtf2/oI2XnGXqNyi04TLcXnYlr9izfV764k5+aN6xdBkLfz+aA==
Received: from DS1PR04CA0014.namprd04.prod.outlook.com (2603:10b6:8:44f::12)
 by LVUPR12MB999160.namprd12.prod.outlook.com (2603:10b6:408:3a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 19 May
 2026 03:39:50 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:8:44f:cafe::27) by DS1PR04CA0014.outlook.office365.com
 (2603:10b6:8:44f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.25 via Frontend Transport; Tue, 19
 May 2026 03:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v4 10/24] iommu: Add __iommu_group_block_device helper
Date: Mon, 18 May 2026 20:38:53 -0700
Message-ID: <3c376e5915a1e7d700425be119aa84dde6af89db.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|LVUPR12MB999160:EE_
X-MS-Office365-Filtering-Correlation-Id: 754b0f59-0011-4b05-b376-08deb55847a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FAuEv6XkXp4yKZKx/aA5YB2ZNekmwdYy3kesHG1Za6EugEpz98b4Ki1xcXgUY+F8mepHNb/2UzYxIa4oZL8hnFWkD56VglLbjJXArg2/NePcA3DnihL/w1589pZ0+YArPzte1b/xQy2bFJv/mJoj2mRp4XVh/F1Rx0akuXVu3Tz2poSijv4jZM7KYfYzPXQACieHNlkwhZWfFU1pYV0SF+Ab3FgDaBFd7ck1ej30idWf3XwcPTT9n7yhKfpBC2bQo7q/uMiIO7nqZBPH/LebInwAvH9ojeUExzZZ3MAdsK2x7qNgmVItRIdXZpmNm0SrG5vLy+2oPXys6fis7vY2qsuVDPrJHPepmSg701dQb+ubKvzfGFgSQJ5kX81pPeijPHtxyp7ec5BLBqBR1JYK4PQ1OcsVp5liroxNUSAkErBJS8eb3T6L1QDetYnnYSB24+aOQ/CqfZCqBqCiWD5NfHE/XJke8QPxJafPn4tEZIyX8IbOmcttIYycvm64Cp8n+tfXSQA5e5lZpgAOUfcw2lgQ2b+cgx5Xg0z8U/t9+q3huwY/jj8ndQkPpCy/J8WETIm3z7uE0nudCH2pAICxqp1JMsOOTPOrBBUUFkLispqk+nRL9ZLxajM1fhQkdCb6IxnUEptr4K0W8AoSmdg8+DIcTKT0xlA9jCk6XjW6BMZn3Bq415EbgDNYotgcgK8lnR3fRn/GiWA4LMLrU1PIxpnKq+22W7RBKBdCOLVjWiQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W0I5Z6W4xDJPBeOPmAYopwfRfnwwfqsEotfkdafEccNwPCmUFM8L5fa24kiZtif6/qyh7LeRlHYOTXNKfiX2fJxvsEaVXY24zXsh+DeULO2S4n/YBXXKeIUGSosks5z1u3yu3J1aNs+/T+iOM8MSrX8eoA1SvYkKE6HJ9BsrCQx87IHCSy+tvw4I6t5QqYWgm4u0kIPMizwNd2Bj/vJA3LDz6oYVlKya8j+U6Q4TGjYg5zKOyBruNu1BISx8lkrE7cDkY4yw7iEHWZpkVXiBVEbWVqS7gAw7fP8KP7JQI51fUzV8GfxA37o5Ekp00zlQpp9rND0lWPG/p/kiPeUhWTAe3K04twDPfViGBi3/luZzozLEeismuXKrFrnhPJzjH+SnrA0N0uk5NvAGFrGsffLf3KVGadA0Lgzwb07+3Dn6d2xQKLPDiiZrQiHnpViE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:49.5358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 754b0f59-0011-4b05-b376-08deb55847a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999160

Move the RID/PASID blocking routine into a separate helper, which will be
reused by a new function to quarantine the device but does not bother the
gdev->reset_depth counter.

Also, document the severity ordering at enum gdev_blocked.

No functional changes.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 106 ++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f745083c032d6..b150d22d8015f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -77,6 +77,7 @@ struct iommu_group {
 #define dev_iommu_group_rcu(dev) \
 	(*((struct iommu_group __rcu __force **)&(dev)->iommu_group))
 
+/* A bigger number indicates a higher severity */
 enum gdev_blocked {
 	BLOCKED_NO = 0, /* Not blocked */
 	BLOCKED_RESETTING, /* PCI reset in flight */
@@ -4053,6 +4054,62 @@ int iommu_replace_group_handle(struct iommu_group *group,
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 
+/* Caller can use this function on a blocked @gdev just to update the @reason */
+static int __iommu_group_block_device(struct group_device *gdev,
+				      enum gdev_blocked reason)
+{
+	struct iommu_group *group = gdev->group;
+	unsigned long pasid;
+	void *entry;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+
+	/* Device might be already blocked for a quarantine */
+	if (gdev->blocked) {
+		/* Escalate the severity */
+		gdev->blocked = max(gdev->blocked, reason);
+		return 0;
+	}
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		return ret;
+
+	/* Stage RID domain at blocking_domain while retaining group->domain */
+	if (group->domain != group->blocking_domain) {
+		ret = __iommu_attach_device(group->blocking_domain, gdev->dev,
+					    group->domain);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Update gdev->blocked upon the domain change, as it is used to return
+	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
+	 * called in a set_dev_pasid callback function.
+	 */
+	gdev->blocked = reason;
+
+	/*
+	 * Stage PASID domains at blocking_domain while retaining pasid_array.
+	 *
+	 * The pasid_array is mostly fenced by group->mutex, except one reader
+	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
+	 */
+	if (gdev->dev->iommu->max_pasids > 0) {
+		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
+			struct iommu_domain *pasid_dom =
+				pasid_array_entry_to_domain(entry);
+
+			iommu_remove_dev_pasid(gdev->dev, pasid, pasid_dom);
+		}
+	}
+
+	group->recovery_cnt++;
+	return 0;
+}
+
 /**
  * pci_dev_reset_iommu_prepare() - Block IOMMU to prepare for a PCI device reset
  * @pdev: PCI device that is going to enter a reset routine
@@ -4086,8 +4143,6 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
 	struct group_device *gdev;
-	unsigned long pasid;
-	void *entry;
 	int ret;
 
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
@@ -4102,49 +4157,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (gdev->reset_depth++)
 		return 0;
 
-	/* Device might be already blocked for a quarantine */
-	if (gdev->blocked)
-		return 0;
-
-	ret = __iommu_group_alloc_blocking_domain(group);
-	if (ret) {
+	ret = __iommu_group_block_device(gdev, BLOCKED_RESETTING);
+	if (ret)
 		gdev->reset_depth--;
-		return ret;
-	}
-
-	/* Stage RID domain at blocking_domain while retaining group->domain */
-	if (group->domain != group->blocking_domain) {
-		ret = __iommu_attach_device(group->blocking_domain, &pdev->dev,
-					    group->domain);
-		if (ret) {
-			gdev->reset_depth--;
-			return ret;
-		}
-	}
-
-	/*
-	 * Update gdev->blocked upon the domain change, as it is used to return
-	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
-	 * called in a set_dev_pasid callback function.
-	 */
-	gdev->blocked = BLOCKED_RESETTING;
-
-	/*
-	 * Stage PASID domains at blocking_domain while retaining pasid_array.
-	 *
-	 * The pasid_array is mostly fenced by group->mutex, except one reader
-	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
-	 */
-	if (pdev->dev.iommu->max_pasids > 0) {
-		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
-			struct iommu_domain *pasid_dom =
-				pasid_array_entry_to_domain(entry);
-
-			iommu_remove_dev_pasid(&pdev->dev, pasid, pasid_dom);
-		}
-	}
-
-	group->recovery_cnt++;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
@@ -4256,8 +4271,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
 			dev_err_ratelimited(
 				&pdev->dev,
 				"Reset failed. Keep it blocked to protect memory\n");
-		if (gdev->blocked == BLOCKED_RESETTING)
-			gdev->blocked = BLOCKED_RESET_FAILED;
+		WARN_ON(__iommu_group_block_device(gdev, BLOCKED_RESET_FAILED));
 		return;
 	}
 
-- 
2.43.0

