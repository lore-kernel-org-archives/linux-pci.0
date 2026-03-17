Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C31C862D;
	Tue, 17 Mar 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774995; cv=fail; b=tJ1D6RKMofr5w0OX6LQHUuoBCyp4IzfMSXVR1MiQQtFac90nzxvFa0ccd/GK50PpTbKbyGNF+EOdb/7Os3WrhO0UimeIf2O13Z2F3/HYV3VwCr4HaThDoqnZiW9tGWSqa8ESe3MRGOqokqaHwvKdE4jhWUE86i1vtzbFfGqLhDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774995; c=relaxed/simple;
	bh=UIOLCMzc6cPyRyxEBiWNi+YiRQPnIlO9U8QIYxioULY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsOFsXMQmsnsMbyTgFctaLSspgkcL9amQreLApIEIX8aCyQN3+tWoHcvozl0VSJ64LEuuXtWoUSjwWPbXHNYFKGvNJxH+KMoqRGh/vBw1sUsMvMxSIn36IvFDKTKqm80p7HkNUoT55aOhU6+aU5W505teexzPT7/JNzvK6dq6Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N9OMAmGO; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N9OMAmGO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQInAeNMO2izWNSNzlIE9xdEjAbQxDGpjxJaceqcv95dVPWB8LPPgWw0Mil3qM2lmuzihS/8DbPnCK48Sgo2Tdha8G3VYqczwPOPlAeAhjUbtVAk4/T0TYvZT+BbMZ0CFrT77JHTY82dnJLZDwXDFTU6X9WLajy0ZWI65zJfyvCX3fy79WUKGtqicVzbVAnBkvJ9kTVIRuqaLE84ksPPI1p65F3UA7YWaqLYBV3ytYDsSY2knXWSm4zG9WrN6u8OOwVSWhndB2YsBg5OO2dwGBsHTdNfaX8ZguplpH87CMUXGjkyBZB29YmErnpQIYCCFDSOq+c/GcFqLgh8zE2M+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKviejPpLxFR0KEBnmrbDk2Huubm20TRVcytIyTnug4=;
 b=ZapXMjaPkrihJJNhnj/Mpye3dFZmI7FytOIGgue9g8xCZefQRNhqWeZS67cpD7uKSlVDzO+q/SE3jGpZL+i9NNHU4T1YN7ZOtoynT10GLfPrR0zD7HeBKUlVl1BfeZyEpt6Q3dMWn9oGJdn4ZvxVXhA9oFZhh6N+fTqfF+Wyc7F3CzFfWg7oMWPiRY+hJOESJeCq67nhEoGY06jR4/2zK3i3D7ynPZKjz3jbnO0INW52FzrfKLRt/Ss+VyFEKiyUfkwAuKDICO6oemfBwe5Di8hOJCEQyYcNLYSG6SfNaKSepwVdivrLkhIAp+SoHGfffig5+8shWcK2vYPeVnlIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKviejPpLxFR0KEBnmrbDk2Huubm20TRVcytIyTnug4=;
 b=N9OMAmGOwp9Iq3owIYfTcGtkwD+wb3GxUTeIBzvAnc3USfzNn4863aQ2qbdl9FR7Q2rVnXjE9quRTi8DESHzopJaezlKBK8t6XEF5cxQPTILiEY+kve16iwJ1e150EUCr1vuyzqGKS9ySH4bzfEJXAdB2W7dZL+a2XJ1GPNXqLc7ndN8xd2NLzesZdTKwES5TZrzqEAJ5DnHFZQzgNFh3XfOvGPh32oesBsKFJO8d9dQVG8MnqctVObFuyqzdFe9L0erXHDS4F1gAVUk5Vyo27ChYkewcENsQM8m4DmqzOCjbwmmceb96muUGs5dJz2rC+6yfEtEpALOVKLSvGuODQ==
Received: from SJ0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:a03:3a1::12)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 19:16:28 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::12) by SJ0PR03CA0367.outlook.office365.com
 (2603:10b6:a03:3a1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 19:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 19:16:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 12:16:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <xueshuai@linux.alibaba.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v2 2/7] iommu: Add reset_device_done callback for hardware fault recovery
Date: Tue, 17 Mar 2026 12:15:35 -0700
Message-ID: <3750a106b4ab4235df842fa2b9defbc8226ebbef.1773774441.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773774441.git.nicolinc@nvidia.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: af1c5e22-c0dd-48c1-8f46-08de8459b07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ancfFLjTPmgjC1s9iQ97kYHzUFQvewbPLWlQW2+FhZkIOnaR+Pvs9foo6V+VlCWB3d0rX+m/Fz23hKuHq9T7OtFfrSBwmqbrLFA34b2k718qU2WrQko7bpLmYqvNlEMUB3HBFZXPqECEesEWbXOEnR1T1kSBsQknCFsgBlSXo2qJNYdQiNuHAwY+Frxmq+8ECVceJfWBF6WRhorNQI3WfS4dZdA1H8ZGxroFvTBFKbilTM9iAX7bXSB6q5NZzqjTo3qTEs8/dHK0cG9SaGDL0XQrmMf9JqePR8SIG2j8blUH1Z8+YETDPcW60GxKdnpPvuCEWzFdVodbJmzlNfZCrLHfGJn9IDGIyxdaSfdmGl2PsmhpnXNVIebc72YyfNYGvN8t1pidsyCI2uMBJnArUgs3g6ova2t+NRk84/H1FpNRaNzt3J2sZr1GlB5Sq+lEAplRIZpLbDfL5c7Q150htFuddP3PjUqfG7XCzN4gbCwxG/hOxFwgkKxHJy9qVSfIwW6EBKNxkRmBZxYb7x3RY5IhEssCKzNizvECxRl5dJ73mRlSgQ1QJYvL4iaSem91CzBcPeLxcJZk65Wv3yhP2DQsV0LC/B3Vpc2M2tTFh0LhVE4WQXVnw3uGe7Up8F+1Mx11miCF01Wi3JzLqQQgoiJS9epEmp1B11Vzhj/NtfkRtLgIw7L5u9zdzt3G1ogQhNFbj+zdiM0ra50hCy6QfcFiavXXZwdYta7MSvb6Ikv2L3ng/snVMv5nBp/LhgEns0XJtj3A4wuLLDh/uHxjkA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5ZzJoOb6Oscgahx1SVS2nG1wMArNRkEMwgVtxP55Zph0dsicSBCpldhuz8fGikorriKk/89nPplw1ht5oeyTzVrKmD5XEhlC/pSpX7ueTqsKcKGlvZ6TzWSpY3RttJCmRbFV4nWm1XFVwNO7uUzA9F+g3UAMOFM3wCsjK94K3Qhajkqof3KsyoJu69nBEefnhsbeXKgLSyzRXQ0+q2PmKD7uy6kWyaJ1tHBQWp9Cufs9hwo0S66z5dxQX5AqGtqbNjOLxboa9MK+h2T9ln0tQ17QE8dDU4JzoiTCwY/tb+K0IoA90CFtWewXXdxGPUbJx77SnB6GFxYJ6YTmSP8tN7nTF+Yszi25aH6YJXn/Zb//3YlZfe+N0VCV/ACGsnXQRmJ7WzKDT6xwmQepjVauIEMZOgE3/CzK9vIy4uqIjmHwubMV2qyENO/x7DpZj6i1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:16:28.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1c5e22-c0dd-48c1-8f46-08de8459b07e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171

When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
invalidation timeout), IOMMU drivers may quarantine the device by disabling
specific hardware features or dropping translation capabilities.

To recover from these states, the IOMMU driver needs a reliable signal that
the underlying physical hardware has been cleanly reset (e.g., via PCIe AER
or a sysfs Function Level Reset) so as to lift the quarantine.

Introduce a reset_device_done callback in struct iommu_ops. Trigger it from
the existing pci_dev_reset_iommu_done() path to notify the underlying IOMMU
driver that the device's internal state has been sanitized.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |  2 ++
 drivers/iommu/iommu.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54b8b48c762e8..9ba12b2164724 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -626,6 +626,7 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
  *                  group and attached to the groups domain
+ * @reset_device_done: Notify the driver about the completion of a device reset
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
  * @of_xlate: add OF master IDs to iommu grouping
@@ -683,6 +684,7 @@ struct iommu_ops {
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
+	void (*reset_device_done)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
 
 	/* Request/Free a list of reserved regions for a device */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 40a15c9360bd1..fcd2902d9e8db 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4013,11 +4013,13 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	const struct iommu_ops *ops;
 	unsigned long pasid;
 	void *entry;
 
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
+	ops = dev_iommu_ops(&pdev->dev);
 
 	guard(mutex)(&group->mutex);
 
@@ -4029,6 +4031,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
+	/*
+	 * A PCI device might have been in an error state, so the IOMMU driver
+	 * had to quarantine the device by disabling specific hardware feature
+	 * or dropping translation capability. Here notify the IOMMU driver as
+	 * a reliable signal that the faulty PCI device has been cleanly reset
+	 * so now it can lift its quarantine and restore full functionality.
+	 */
+	if (ops && ops->reset_device_done)
+		ops->reset_device_done(&pdev->dev);
+
 	/* Re-attach RID domain back to group->domain */
 	if (group->domain != group->blocking_domain) {
 		WARN_ON(__iommu_attach_device(group->domain, &pdev->dev,
-- 
2.43.0

