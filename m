Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B5466B46;
	Tue, 20 Jan 2026 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948034; cv=fail; b=oSteECIRwu/18zmK0/Go9BnnON6okdqMMtoMjkyVFax7A1y9HYbjHPpXd1Gbgt2jaTY5LifYtTwrk3BQSh6fsSVn++UoimdC2OF5QQtCQGGlv5rqrV4VZK2RyQYgYjGN0Ab60K4sg0sYB95A2kWhSx6Of/WWlyyHbSb6bOysyTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948034; c=relaxed/simple;
	bh=afR/O7ieDRlb2jUUptKRW2Q+04tQgNrLTbrAhgJqqB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzaoapmQsqOg4HoDd0tihdVLqa/e8mARCxfYzWSy3TN9DySdGtY8OLO4XK3pf8c7Tl7H1B/KKG9n5EkqO3lkDh4lsQolBjVkPrP1SxkGRuoj8pFps2i4cqmsc8jwO2r1tx/J7S+kr5yacVgnKQ+loyFSKfUlrVlkK0w1VbIAxDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJujbB5V; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJujbB5V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0ljKEK8LrpgVn5ZEtluvWh6SM4vg/Zbi0CSyqv5KHBldOhso/ifY6UDU+QlSp3UnszT0VV5fFMwvTJnn9wTwLw3XZZoyX6wyh1bbXTHUwY6CqKnmF+Y+rIEqE9+73EOPI06cdOnvkaJh7A/qK0NDukVARAasRJKakVe5+4JPUSRqXpWmtD9LzLQYn9d0uZCV9FXqmSdu1xw5Fr6PXviZDRVuiJJnpOorJR5vBa2cCwwy1NdLo4zcrOXvVZ6i60VtBGTzxGpJ8WgKpAjDsAT5gzXs/VXJa8b5Wt1WnyEuAWeMzAxjTZ+UF8WRaGg5h5QKK9d0jK6COGWN3juveh+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pl8QqLL29egr9M64g574gMeB1uOp29Px0EIO9IhpRA=;
 b=oQIOIwxCin7J4MOZVZzDliXoWlJDk0lD/H0HG3gB1MJsXPa8CXzeM6N/93QJIG643FfDWfmqOiVbXa8pRmFionwb8o+oINzW4AljBmSt+J7ByduxZLToRDchRMRwivfOW8fU9HfyxwsQd3JK9Tfy5ww4//FDwahifj00qp2aGPf/rsLyuZvXz5RaoQwfvTomKo2Tf1g9Nt4AucyjKvVjSGPQK/SJAsns7juiJQZ/HeqQUhbXHnLGfobncPy6DjZOlSidW3SNifg5oFUiD1ulBk6I8L3DLALafj2wlqpziBDa9E+Mw5xtAZU0BbzdKQ7igndB+CSvX/IYcQxMhZuAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pl8QqLL29egr9M64g574gMeB1uOp29Px0EIO9IhpRA=;
 b=RJujbB5VHamdTHYCbzTEknMf67TqHv7QDkRf3+mRMLz4PkscFYxYcSXE5KItbiHcWdY4ISPc/ld8txbFbcaplldhs0E1maYi4Pmmv6k1LEAUt03zwveVFPHHSDlo2lnDC49alXK2adqIRLn/vBCG3OO77fwp3MDANzptfLZ5ETuDRxQ057lSzkb/bSuSu1YPpoZFYNQbBwStVM5zsV6Mjz1IDyZc76i5dZgZX6I/fR7WAngr2cvwv3imJS4HAkYiRSNRRaSzo4NUJMvFOgjff3CVUcszMuqC4HPWlEN9m38CIttIcflnC7b6gcvbnnMmrR3H/OYA2DQb0JL+gpATuw==
Received: from MW4PR04CA0330.namprd04.prod.outlook.com (2603:10b6:303:82::35)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:26:59 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::e7) by MW4PR04CA0330.outlook.office365.com
 (2603:10b6:303:82::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 22:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 22:26:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:31 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:30 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v4 06/10] PCI: wire CXL reset prepare/cleanup
Date: Tue, 20 Jan 2026 22:26:06 +0000
Message-ID: <20260120222610.2227109-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: c643024e-d46e-4d3c-0326-08de587306b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YsXFZafqiai4vA+qxxkPOIhuRqm8uHQ/Fvbo6+yHa32TZZ527Gk7Lb3XBW5s?=
 =?us-ascii?Q?GCYodc07wI2Gi9rM4Ke7pCEb3IgFsX2kHvzW6AEox9abUF+xJ7L3wwZIian5?=
 =?us-ascii?Q?aLl4sxuH3uhBtqOikHyho/bDfWfwVqUDHAnJ9g7sUiy9voBAol4LejqLyPki?=
 =?us-ascii?Q?5fHKiyiVBd6Y+u9+3qlSXj+rRs0MokUmXzLE5AniD2bnT7bZ+hgN1s9006Q6?=
 =?us-ascii?Q?i+/yQDe+LLnMOv1O/VoHArzo+bg1N3v4Wo1fhpZOXtpTE8Y13uwvsr1wQAnL?=
 =?us-ascii?Q?J0sLwvJVVllR05VXTi0gP74Y77QNGGwh+2/QFgdSSAIwimJwPhAP1/kFtjSl?=
 =?us-ascii?Q?MgGGSwu4s0rB0yhxxsdJcve8auA78B9uIEJgR1sfihf1OZx32MvNrmNDtqXI?=
 =?us-ascii?Q?qJZlCS4xLLjEpR9SopaSYew9wWdEbZn1QCVF06dX9hZ5MGxb7CxbzSgy33Tb?=
 =?us-ascii?Q?epGvO+WmhLHRFUTkdFAEgGB5eCrSNNMacfZw81MpQMEhW/yY8IpoVu8WEy4D?=
 =?us-ascii?Q?CnoZpWVT1INmSzb83ar3NTI2w+lRqJzHw4mDGAwnenrAjPMop6+HrigE8Agi?=
 =?us-ascii?Q?1d+nabpNkwrYRn44gRSvkRbMYWjyRiVBOf7kzQvHAnCtZc6vQw3lTXrYNo6J?=
 =?us-ascii?Q?NOBaOFqJnBZmCop2uMk+tdDcVSr4w0HW+i2Tg64J3NNcpnGVrPlCaFS6GMe3?=
 =?us-ascii?Q?+ZlwKy6OPvDP1Cz+cwNiUX9uEOrda5oglzyKwQfy323yGWuadAAi/0JNSPI7?=
 =?us-ascii?Q?qAbsvRln/gXbt/Jw12VhKuowZQh4A+JhzTLV0vWF+MVvWNn7/3KOFvZjwXCF?=
 =?us-ascii?Q?ArnRymKxUoqA8tIf9v29i5NKmUCSo/VVdaL3u2gmljcPJ9nKIpdVCLUDDt+X?=
 =?us-ascii?Q?xvBrdPFVZh5GKYH0+55fDyTU1CiPHJ5ZWu1bt9ozjQS8A9f0I5KqVaBMWmz3?=
 =?us-ascii?Q?WbGj8c074jBFvy+yk3c8unosavhCu19+rrs1Yq1Ifv3NCV+AdKSsr+qK7QXm?=
 =?us-ascii?Q?/YYX7s7Z9TQZxVFpthE6KLvbBj0o3RR78aeo/YOjYg89Z0i/S9e5nlnIm5sl?=
 =?us-ascii?Q?rZNPBMOqxUvMDGg+Fk01jIu1Oq40rc26xUakA6FOyYxSxIedQ8bOOsivxHzy?=
 =?us-ascii?Q?a1eZ+pToJMPe3xGddZTc2gzBJnhWRacBCrE/TA/X6FGKBgXqfgjtp4tmXIMp?=
 =?us-ascii?Q?3Z5sLaiOIqTpdqPwRmy4lLxg89NuiwNgyCFJUUSoSX8ZCoEsBuPC2VtRAwg+?=
 =?us-ascii?Q?uAz1DyaiZv+eI4cUVkPfpkEcQPAM+gT1N2Pbjpp271bYmRV5eL7l9s7XVh8n?=
 =?us-ascii?Q?Ia4fYRSAk/b/HkPEJwKn2Vc+3afWBhZYWjy/R5iXWjkFs8GH9vqXHOR89HBx?=
 =?us-ascii?Q?mRX94t4ouyXcrztcA+p9MitKhBnbPSOrKsMqPxqXAu9L2zJeotFpzW2cWH5x?=
 =?us-ascii?Q?E8EoSG51Wc9/0uFXbR8Nik8HSVRUWDEuHjzQpT90hvP6tZ194Xy+If5VYQJZ?=
 =?us-ascii?Q?d8uyU3qbWPOqRkXIX/PX8JdvoN+DL1c4C2PYip49C6lUfupFFtVm3nTuB8K6?=
 =?us-ascii?Q?hVDIPZpCBgvBcwCEhAi7XM7o95LPns6gJtLG7/9nctklFZ77ot95bG7tSyJQ?=
 =?us-ascii?Q?1J0rr5KvC3iC9tP5vMnw7laITf+e1XT/vyzXWS0IpjeW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:26:58.9512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c643024e-d46e-4d3c-0326-08de587306b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

From: Srirangan Madhavan <smadhavan@nvidia.com>

Wire CXL reset preparation and cleanup into the PCI CXL reset path.
The flow now validates/offlines regions, performs teardown and cache
flushes, then releases the lock on completion or error. This keeps the
common reset_prepare flow intact while adding cxl_reset-specific quiesce logic.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 19 ++++++++++++++++++-
 include/linux/pci.h | 11 +++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e2d5ff25ab67..18047c893b0c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4989,10 +4989,27 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;

+	/*
+	 * CXL-reset-specific preparation: validate memory offline,
+	 * tear down regions, flush device caches.
+	 */
+	rc = cxl_reset_prepare_device(dev);
+	if (rc)
+		return rc;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");

-	return cxl_reset_init(dev, dvsec);
+	rc = cxl_reset_init(dev, dvsec);
+	if (rc)
+		goto out_cleanup;
+
+	cxl_reset_cleanup_device(dev);
+	return 0;
+
+out_cleanup:
+	cxl_reset_cleanup_device(dev);
+	return rc;
 }

 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4a8c4767db6e..c074c2040b28 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1466,11 +1466,22 @@ int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 #ifdef CONFIG_CXL_PCI
 bool cxl_is_type2_device(struct pci_dev *dev);
+int cxl_reset_prepare_device(struct pci_dev *pdev);
+void cxl_reset_cleanup_device(struct pci_dev *pdev);
 #else
 static inline bool cxl_is_type2_device(struct pci_dev *dev)
 {
 	return false;
 }
+
+static inline int cxl_reset_prepare_device(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+static inline void cxl_reset_cleanup_device(struct pci_dev *pdev)
+{
+}
 #endif
 void pci_ignore_hotplug(struct pci_dev *dev);
 struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
--
2.34.1

