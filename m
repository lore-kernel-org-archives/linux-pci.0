Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730872;
	b=STm9WhVCpET2LrC48AgCDVDzGJue3azYTjaBjB0XQ5P0CKC/rSMX0MoCnDovS/VWj5AJ
	 RBrQnAZdDe1mhAJkzjaf2peNElDHC3kvo1Cs4dkveHKhHrKVKGulEx4KyAOiAkHdw6Rav
	 1tvLMzYB5kkPTGvDr1kXcyFn4NALN8CYpgtmPzyrcOZdu697SGbZ8LVrsw9RkqSDL0QQ1
	 8T0BTBUeofOYbn7PZMOuNgjc8SdX+doOx6fGxt+Ogdb3WRDiu4ZHllalXPGJzKB0PjAsh
	 lzfhWoXVS4bBCXYkJudaQsCGAQ0hT8wbb61GQXsCypnJTWgXQuTF0B9Uobs0y7koC3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730872;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=p5ukHCZwxfqpVp1XMjnVF0wjjNjdfJwl/jFF5ZBz0oI=;
	b=gPR3EXhzHXNv5APwrRIbuvwiSZPqXG92rsSTknxmK9S0m9k31OD4wHncgYZKGkGjI+Dn
	 IgyGKDkVCRADMpBeux8a86WjUykLFqGUcsCGOH3mGXMpf7DU8+jzvdjJQ09SORbl8w1eW
	 KSkYrc534W1kxUhIOUUn+NaowPQOgNSGFSFCfJXUsuEkhgh8EE3/9qrMqe4wozRBRK8ox
	 EcawmrbCpM3cHXP+3rfgssSGRChAogZPnbsWN/KfZt94twKTFfzuOy1YalR8Pm7G3xi0o
	 6Hw8S8v3ql90rYZxqHT1ySZEGbNWW50XdyysOrkUm2UgB9p7lDEz51Q15+Nf63JJSpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fosj6dzV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.65
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA34606A33F;
	Tue,  3 Nov 2026 18:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA34606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fosj6dzV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7h8FcLt9aMgeryWt/SBL6/zso5bqAruFKn8qX1VrHipHMDy0xTMZOpIEf5dR3m2SX3frCxEpUWVJLYyoTqqhflz0sdsYGd9FxUc1iiwlM7H8mHWTgYR1fJnbQItl/8epijZQeYiQ2KL0VTzEImt45rJaVB/Ns9ooUteFknu/3PLUYv/bP5Ikwl/Xp8lDrUsSQznjOmgzP2qrn9yj7fg4d4FfJ2QMRAeCvCtxddpWyqVOT4e+CyYSNITaqw9VphIRCRKB1TTDsrC15ta/EPHjW5a+/sXKpXJQAlHnn43P0pD81H1AHexsrHrizsxK3md3Les8aZv23pM2RGcCi3ApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5ukHCZwxfqpVp1XMjnVF0wjjNjdfJwl/jFF5ZBz0oI=;
 b=bcttR5FSDP87eoG5yvhV5A9EN4vgR7wLcKNExak0tEHGc7XROSo4v7j5qUdIpyiP/kPgg0Sy6A2zZSyUzFAA/ikfGw4qvw8tz4G/D69owPmGqJvZ8VvM7GVkT5FHn1RmluhANhQT3nRBX76AII+L9sEGL134Z2PMO2Q2rzz3zAB8Xu+dZwGDSpHKXbXwLics++0Ac365zGE4Tf5N8Zu+BUhSuVTI01/D+oypi3E1uh+XNKax/cTeMi+5Ju2CnoJSNtnMH1Na2eqUbh8dkY5sRLzLJHZ/Qlv0vE1FyGSdqZKE9rzQuun69qm5j6KEbk/2IwEgXahbrS99sggyRdZ+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5ukHCZwxfqpVp1XMjnVF0wjjNjdfJwl/jFF5ZBz0oI=;
 b=Fosj6dzV0feIUhx31vS9FDlAkN5ISckkBIO73kWWdF/fIzpIiGPkuBgLNlNROXThIkY8rv2XNTOtmAmOTErx5Yd9kGzHXmbps9iCyGbjElCPhnBLNNVRmlwbLzDUiUUTJ7Ns4Mo20ldrVdbDaCe4tKu8EPrAOsR1larNBcwR4qGvhoPgp+8jh883BlRIe07wlhu/FNlh0BN4UOSJ9aPrhyagtISxk2dsj46OCxpYtX80sv4MnhL2+dTDmkiLjBuh7wy0DQJwxQCLUmsHUmFTMBSIvBjN4FVJAu8sS8A2khNiF7CNqZ8pN4S8koBSYFQmWh59N1YU/unRJkU9FS9k8g==
Received: from MN0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:52f::8)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:34:24 +0000
Received: from BL2PEPF000352D5.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::58) by MN0PR03CA0003.outlook.office365.com
 (2603:10b6:208:52f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:34:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL2PEPF000352D5.mail.protection.outlook.com (10.167.254.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:34:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:57 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:57 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:33:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Joerg Roedel
	<joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <djbw@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 5/5] iommu: Pass in reset result to pci_dev_reset_iommu_done()
Date: Tue, 3 Nov 2026 10:33:46 -0800
Message-ID: <b8a1c348a5ef457bd75d882aaf60b9156a5aedb3.1793729707.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D5:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 170f68d6-6eb1-4d25-ac77-08df39d9158c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|261022113327099003|261102123227099003|11063799006|261022105027099003|56012099006|261009223027099003|261021121427099003|261021123027099003|261022075727099003|261021135927099003|261102130727099003|261028144727099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QWvtW8i2mWGyz1qqI7pprdW6f0wRczaEBMNT+kPktxXtITKl2ikC2zDrqrfWmI8L/mVMisbP/0SYOwhf/KJLYX+ouH8lbBWkVPvZ3kkaVna3HuHybro7qj30eJnLvBAMJIWNay2TvJTLaNgvSrUSAW4x5pc/9+RZsdonbqajT7Oayh/HveFouAednx0InC6GB2saWVvxbIZaVzUwXcJ7npfhyR9t3wkSNX+AQ3zPgNv0vB1AkZ65sKRRtKI0biUgkcG7HerkYqTzA7Up5AUnJhP3Ci4ZW05Jo8jvWKAadDWJzdLjswbiOUoW5KbeBNOaLoCVi8FhvqwygzpzM5VGcploYws/NK6KclyRR7W16nUjDie5SFw628GGpSOPakwsa7p+LQF1GUs550uy9GZ2tlCHtPIv6bkj+B46SF3vSI55c8TBZYFNDHTmQoFMPPPHSu4NKvFyP+wsOZNGUMOiCsbBqx4SUuIy2MWGpG6ko+ktEn8AlLk2WouJ17OhtYgTcJuZuYedPriuA5pipo9xasswe14p3i2AMu8tq+8Ta7NaXNsZaMA0nKmVS8u2teZX9Ajx/Agol9CqQeNQK1zjIJTXNCnm/WZHQZI7bLkS7kIhYbEgg+FltNsCV8zqcWc2GJdDcnb0HcsGGJEBRuOpk31OTX1oCU48031A33QF+yfVGKtqltRyAHEixb1E7IXFxbzZNzyMFNzdfUcMP9L0Aw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(261022113327099003)(261102123227099003)(11063799006)(261022105027099003)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261021135927099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1iSCW3dM5ZQwcxAbI61FV07p27jGmtVJmF/Os8H6p84WySjLInnsEV5RQfWOyie0tKNy7gPaJFRIcmyAY3L2q3kMJr9/zZlQHbGGkYHUOU6g0SuslBGfAVCL0mhTbusELA7ML0bOgBh86fQUR7eaebhNT6jutlULd5eTziQ4i098Z4u/+nj/bIeq+gW1qGiPEYfKNj2PHbK16I9XtytaDwGZe/gp/45EJuynTkZ9wx2OTVbAxLgYR0DwvGTlziZVxOau2sQ5/VXEjqih91uLBqwl6mwIg/zQFr0MG98JCsCF/3jIHUwv6rXmzxfHGzigAnLdI5Eqrrt1LFFP09HFPoFH8bCpYa8JvZcA/z5GPfTMku+zyHqkqw87ereSNihUb3a86Uh9jhFAxkaGxMAVBklMPH0kUmydIYkvs0MW4nlx8J2xwjX8SfKoYLNps5nZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:34:24.0322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 170f68d6-6eb1-4d25-ac77-08df39d9158c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352D5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656

IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
errors (e.g., ATC invalidation timeout), indicating that the ATC cache may
have stale entries that can corrupt the memory. In this case, IOMMU driver
has no choice but to block the device's ATS function and wait for a device
recovery.

The pci_dev_reset_iommu_done() called at the end of a reset function could
serve as a reliable signal to the IOMMU subsystem that the physical device
cache is completely clean. However, the function is called unconditionally
even if the reset operation had actually failed, which would re-attach the
faulty device back to a normal translation domain. And this will leave the
system highly exposed, creating vulnerabilities for data corruption:
    IOMMU blocks RID/ATS
    pci_reset_function():
        pci_dev_reset_iommu_prepare(); // Block RID/ATS
        __reset(); // Failed (ATC is still stale)
        pci_dev_reset_iommu_done(); // Unblock RID/ATS (ah-ha)

Instead, pass in @reset_result to pci_dev_reset_iommu_done() from callers:
    IOMMU blocks RID/ATS
    pci_reset_function():
        pci_dev_reset_iommu_prepare(); // Block RID/ATS
        rc = __reset();
        pci_dev_reset_iommu_done(rc); // Unblock or quarantine

On a successful reset, done() restores the device to its RID/PASID domains
and decrements group->recovery_cnt. On failure, the device remains blocked,
and concurrent domain attachment will be rejected until a successful reset.

Note: -ENOTTY is overloaded with different meanings by PCI reset functions.
Some of them indicate "reset was not attempted", while others indicate "try
the next reset method and the current method failed". IOMMU that must react
these two outcomes separately has no choice but to keep the device blocked
on -ENOTTY as well. Leave an inline FIXME and warning.

This introduces a new situation where a blocked device is being unplugged.
Decrement the group->recovery_cnt accordingly. Such a device stays on the
group->blocking_domain, so hand that to the release_domain attach_dev() as
the old domain in place of group->domain.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h  |  5 ++--
 drivers/iommu/iommu.c  | 65 +++++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci-acpi.c |  2 +-
 drivers/pci/pci.c      | 10 +++----
 drivers/pci/quirks.c   |  2 +-
 5 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a365..36417d596bb43 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1224,7 +1224,7 @@ void iommu_free_global_pasid(ioasid_t pasid);
 
 /* PCI device reset functions */
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
-void pci_dev_reset_iommu_done(struct pci_dev *pdev);
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1554,7 +1554,8 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	return 0;
 }
 
-static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev,
+					    int reset_result)
 {
 }
 #endif /* CONFIG_IOMMU_API */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0d40eb4f15cc1..1e3a243a6f1ef 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -76,6 +76,7 @@ struct iommu_group {
 enum blocked_reason {
 	BLOCKED_NONE = 0, /* Not blocked */
 	BLOCKED_RESETTING, /* PCI reset in flight */
+	BLOCKED_RESET_FAILED, /* PCI reset failed */
 };
 
 struct group_device {
@@ -589,7 +590,8 @@ static void iommu_deinit_device(struct device *dev, bool blocked)
 			release_domain = ops->identity_domain;
 
 		release_domain->ops->attach_dev(release_domain, dev,
-						group->domain);
+						blocked ? group->blocking_domain :
+							  group->domain);
 	}
 
 	if (ops->release_device)
@@ -764,6 +766,9 @@ static void __iommu_group_remove_device(struct device *dev)
 		if (device->dev != dev)
 			continue;
 
+		/* Must drop the recovery_cnt when removing a blocked device */
+		if (blocked && !WARN_ON(group->recovery_cnt == 0))
+			group->recovery_cnt--;
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
 		if (dev_has_iommu(dev))
@@ -4027,7 +4032,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
  * reset is finished, pci_dev_reset_iommu_done() can restore everything.
  *
  * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
- * before/after the core-level reset routine, to decrement the recovery_cnt.
+ * before/after the core-level reset routine. On a successful reset, done() will
+ * decrement group->recovery_cnt and restore domains. On a failure, recovery_cnt
+ * is left intact and the device stays blocked.
+ *
+ * Callers must skip pci_dev_reset_iommu_prepare/done() entirely when no reset
+ * is attempted (e.g. probe mode).
  *
  * Return: 0 on success or negative error code if the preparation failed.
  *
@@ -4057,6 +4067,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (gdev->reset_depth++)
 		return 0;
 
+	/* Device might be already blocked for a quarantine */
+	if (gdev->blocked)
+		return 0;
+
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret) {
 		gdev->reset_depth--;
@@ -4138,20 +4152,28 @@ static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
 /**
  * pci_dev_reset_iommu_done() - Restore IOMMU after a PCI device reset is done
  * @pdev: PCI device that has finished a reset routine
+ * @reset_result: Return code from the reset routine
  *
  * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
  * activity, including new translation and cache invalidation, by re-attaching
  * all RID/PASID of the device back to the domains retained in the core-level
  * structure.
  *
- * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
+ * This is a pairing function for pci_dev_reset_iommu_prepare(). Caller passes
+ * the reset return value to @reset_result. On a failed reset, the device will
+ * remain blocked as a quarantine measure, with group->recovery_cnt intact, to
+ * protect system memory until a subsequent successful reset.
+ *
+ * Callers must skip pci_dev_reset_iommu_prepare/done() entirely when no reset
+ * is attempted (e.g. probe mode).
  *
  * Note that, although unlikely, there is a risk that re-attaching domains might
  * fail due to some unexpected happening like OOM.
  */
-void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	enum blocked_reason old_blocked;
 	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
@@ -4174,6 +4196,37 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
+	/*
+	 * A reset failure implies that the device might be unreliable. E.g. its
+	 * device cache might retain stale entries, which might result in memory
+	 * corruption. Thus, do not unblock the device until a successful reset.
+	 */
+	if (reset_result) {
+		/*
+		 * FIXME: the int-return values from the PCI reset functions are
+		 * not consistent: some reset functions use -ENOTTY to indicate
+		 * "no reset was attempted" (in which case IOMMU should revert a
+		 * prepare), while others use -ENOTTY to indicate "reset failed;
+		 * try the next reset method" (in which case IOMMU should keep
+		 * the device blocked). Without fixing the PCI return result, we
+		 * cannot tell the difference between the two cases. Warn it.
+		 */
+		if (reset_result == -ENOTTY)
+			dev_warn_ratelimited(
+				&pdev->dev,
+				"Reset may have been skipped. Keep it blocked conservatively\n");
+		else
+			dev_err_ratelimited(
+				&pdev->dev,
+				"Reset failed. Keep it blocked to protect memory\n");
+		if (gdev->blocked == BLOCKED_RESETTING)
+			gdev->blocked = BLOCKED_RESET_FAILED;
+		return;
+	}
+
+	if (WARN_ON(!gdev->blocked))
+		return;
+
 	if (group_device_dma_alias_is_blocked(group, gdev)) {
 		/*
 		 * FIXME: DMA aliased devices share the same RID, which would be
@@ -4204,6 +4257,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
 	 * called in a set_dev_pasid callback function.
 	 */
+	old_blocked = gdev->blocked;
 	gdev->blocked = BLOCKED_NONE;
 
 	/*
@@ -4225,6 +4279,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
 	if (!WARN_ON(group->recovery_cnt == 0))
 		group->recovery_cnt--;
+
+	if (old_blocked > BLOCKED_RESETTING)
+		pci_info(pdev, "Device is unblocked after successful reset\n");
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1150f2fbabf41..76a535adf0cd6 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -974,7 +974,7 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 		ret = -ENOTTY;
 	}
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9b06b360850e..90a38f2d0d172 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4469,7 +4469,7 @@ int pcie_flr(struct pci_dev *dev)
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4547,7 +4547,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
@@ -4601,7 +4601,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
@@ -5057,7 +5057,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	rc = pci_parent_bus_reset(dev, probe);
 done:
 	if (!probe)
-		pci_dev_reset_iommu_done(dev);
+		pci_dev_reset_iommu_done(dev, rc);
 	return rc;
 }
 
@@ -5110,7 +5110,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, rc);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3d3e95cb9f7dc..92e81460c2d8f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4416,7 +4416,7 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 
 	ret = i->reset(dev, probe);
 	if (!probe)
-		pci_dev_reset_iommu_done(dev);
+		pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
-- 
2.43.0

