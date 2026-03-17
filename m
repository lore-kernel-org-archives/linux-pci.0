Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332F19AD8B;
	Tue, 17 Mar 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774996; cv=fail; b=kS7iJSVaf53aZXYvuJ09Gh5ZK0sIXoPX6eOSDn5USvYVPQIEyCXcgvsWMuLG5Ppqbn7tFVYzavbSvqi3trX/pWLCsoUqY+PiTJv71ZCdXMfNNyHm5X+Cgkq92dsFSNY8rroyle2uxurO8rwql5TzehAXPJgh0h1qALCjk6PrUrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774996; c=relaxed/simple;
	bh=XBrN7lG6xJGay0JwkA0maAxk3vmXTdtXfRbMOyhF5qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4G/WLCekyAGjsVm5eYTUBa/UUgSn8u1zr7Z9Q6KiIp+E3aZh+X3npXkNYSwKv2FegAyCidc6lR0t1eCqMfz/ktQOU40eep4s/YtWiBbjFo+IYAb58bF0ubpdc/pFM3BTAPyD+X8Q31w24Zn42D0dACJAB1rDJujugM+psBZXcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SThumL/s; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SThumL/s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+IZriv45OT2HK5OKZFRb4kFmcAk9Yj3UCwqO31xG39G/+4nATnYRB7jKRzhk82bppwAGV+C+an+7+W5r/ZsqJzZOkxoCKucUOEQUdFXw9eVnvUH0Z4BBltn7GjgiPYDygO78GE6/FF6hsfeABhlhC8wpt8py5wBqm74IpBa4zY4IuX936ts4yx4ZEmbASC7kluUB7XjtmJlfqA2Kizyci6Ka2VkHEblCBypZ/F+x03qxMwIYRm86ZlgO2ssbBs0XWCAroHkkV/RBzGYHZw0qcGhWcjZb+zD8fuzjnw61pg2AX1Rxm7Y6LDT//eXc8foLkmKSlfHXcievGPUxGcHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP2sQGIIcHZGt2MelZ+hkUOiEKCYZtquuB0qBQV5X58=;
 b=Gpmdc3E/ngTikgpnLXDxQ6iOIvASvu9c/ZBOSZqNa7SSxicukImUf86bnHnfuFUNqudRPQQ/bZm4Dy7xHCGahDMGfeUC9qHO8HClw9TcZY3TKOSIw5BpqxUvJYUXZSIqBDpjq02ydbGSsHuR5ADDVb1G+oKh3HEN9iF7avIGXNNGU0y5BZpEZHoJCuZ235PQ2WOECBd8aeJHzdNNXtvcgDckzim7G2v6ig4n4xZA2V30MQZSS9dL98vzSDfSx+tzoWtl5G30nNYQZ4kz/jtlDK/AWnx9i0IhkzHuJGAgYL+/wXunbx3J11dds7eXDji5R90VbN3hIR9Lf9AATP/HZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP2sQGIIcHZGt2MelZ+hkUOiEKCYZtquuB0qBQV5X58=;
 b=SThumL/sbk4XYPiriQD5MgFLbtN+mAKwCH67PPWLCQ0QAgvXgnjyAl13nQxCEAQ11pe8RZtuNV7oXqWoNGXtXYQnMUb3vlivegFVOpRLBeng+5MXgHcLimLGKXWzwVt2aCIoZHRJJP6R+H6XMbPkdoUeQx0dqg2izlCD+FlDWJkBmiHmtLkTr0U8djpnoop6hsjXIXxHbFlonMGVv/kEQ/wh8K6QhIRZ1xSMhPHRKtWor3Mauwrcs9kiO7HTrojGbKVBoRFaYhKO/zLksNYPVi6whhfUDk4feRPGFS2aPVhH+MnurV98p8NEg3xwgu4d5+JNk176RfhsP6D8DqSsPQ==
Received: from PH0PR07CA0115.namprd07.prod.outlook.com (2603:10b6:510:4::30)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 19:16:27 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::9a) by PH0PR07CA0115.outlook.office365.com
 (2603:10b6:510:4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 19:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 19:16:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 12:16:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <xueshuai@linux.alibaba.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v2 1/7] iommu: Do not call pci_dev_reset_iommu_done() unless reset succeeds
Date: Tue, 17 Mar 2026 12:15:34 -0700
Message-ID: <21fa71d59c8ab787c0f3d8cf3e9fc725330fd0d5.1773774441.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ce1c58-e08d-43eb-3f9b-08de8459b016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oqsrSOtyGGWTAR5HOoGinwA+rlOsYrvqCHS3jRRTdeeo8mM14qu9tApLm+4Tsz4s0bY/viZ6oPbm61+NRAo9jtycYB8cMDHHebZVWniIu/+cs605AJA/LCx6HQ4vVWCIMTN7/va2gNW698diQlqc7wjvs6fleToORZ9v3wECbFOiQ0N4Tsk1Z9x71PtKfXkLjaGHokCmk/1aggf6xZjY5j9vdmlWIV18sovGCa6VpH7GG9WCttJOtUTI34D4X2N5EyQiyCdnmkbUiDvxe/moDhgjz6JtzlXHMfGJsaMZVcnm7+L/G7Y4ftlbk9xtTinYAumYyUqyzsdX4p5qtKXw3FsmqLF6BgbNlYl9qp42YkpNo/ZB0aNQWTZhIGCju2M55A5dbFW6igd8Ek9oo38uOP6Sim3JTeomNCouFuh0N+9ZbyFjQr/tXUan2CbJ/0iuNEwl5ybSAyK/QVTBRbKMzPWcx08HQUvcox9iMiD4MIKZbClffjqeziUuxVhFIFErHE0Zgp13hM8YvZOy9PdCEOQeCwIlL0Ue0RqWFjuJJDOMQanLFHE2oZWU7nRNC6NKboGlYpnaxjBVEKPS8ZnW4gmu07W1ldVCNoEa9PL/RFcSS306Bv/W7+fWTtOFhOwvuRl9fceHY5XHmApOKPdUP9hdoyoKxrMWfARphGYA5zn+7b07RYIwp0pWkXgKhOKmAJFDLL2c2y779ggHZXOHgJ66m1IyayW1nXRRwPM4xo9scPbS9XR6Hdb1JvBWfhXFpsog/moyufzw3DK0SEri0w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qKFLFf26oqUaGKPLrAdCwlLCI04clzqIqHkGutWbukBAqI7SBHV/Ikl4t1uJeDXtaDNhYpon3hSpDzp2yUQ0Puoq/zjtc/f/wH+bqk02mmNepCfOGmiwK4eWAIiBiC6qJu6P8Ad0SvwHWtA1EMAnTgdeasryoWeWCHGiPGA/cIyYzf+UPjW5oXiSiW9zpqGHIcHbaXtbQ/QAckHbHq/39Q5RsgvjhC5Z1QRj1vF1vA+Zi0wLWrlST2T7n5LnPZfR6wYnJ//hprC8AHPd1R8Kjd0AXRNnIETV+f9jr8jfIZBuDymH9gUFThcjlGlbYtGXWvpwJHMSibsoqaB9Y0iPheD4nd4BSymNudutACE3t4y/C1Uw252Sd7fFvH5cZfol9Fo0oBwsIp2X+lG4nT7ltfy/Iw859J8I/Rgo7B+CGzkEBQvoxXF1173an2e/pgJS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:16:27.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ce1c58-e08d-43eb-3f9b-08de8459b016
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
errors (e.g., ATC invalidation request timeout), indicating that ATC cache
might have stale entries that can corrupt the memory. In this case, IOMMU
driver has no choice but to block the device's ATS function and wait for a
device recovery.

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

The simplest fix is to use pci_dev_reset_iommu_done() only on a successful
reset:
    IOMMU blocks RID/ATS
    pci_reset_function():
        pci_dev_reset_iommu_prepare(); // Block RID/ATS
        if (!__reset())
            pci_dev_reset_iommu_done(); // Unblock RID/ATS
        else
            // Keep the device blocked by IOMMU

However, this breaks the symmetric requirement of these reset APIs so that
we have to allow a re-entry to pass a second reset attempt:
    IOMMU blocks RID/ATS
    pci_reset_function():
        pci_dev_reset_iommu_prepare(); // Block RID/ATS
        __reset(); // Failed (ATC is still stale)
        // Keep the device blocked by IOMMU
    Second reset:
        pci_reset_function():
            pci_dev_reset_iommu_prepare(); // Re-entry (!)

Update the function kdocs and all the existing callers to only unblock ATS
when the reset succeeds. Drop the WARN_ON in pci_dev_reset_iommu_prepare()
to allow re-entries.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c  | 16 +++++++++-----
 drivers/pci/pci-acpi.c | 11 +++++++++-
 drivers/pci/pci.c      | 50 +++++++++++++++++++++++++++++++++++++-----
 drivers/pci/quirks.c   | 11 +++++++++-
 4 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db517809540..40a15c9360bd1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3938,8 +3938,10 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
  * IOMMU activity while leaving the group->domain pointer intact. Later when the
  * reset is finished, pci_dev_reset_iommu_done() can restore everything.
  *
- * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
- * before/after the core-level reset routine, to unset the resetting_domain.
+ * Caller must use pci_dev_reset_iommu_done() after a successful PCI-level reset
+ * to unset the resetting_domain. If the reset fails, caller can choose to keep
+ * the device in the resetting_domain to protect system memory using IOMMU from
+ * any bad ATS.
  *
  * Return: 0 on success or negative error code if the preparation failed.
  *
@@ -3961,9 +3963,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	guard(mutex)(&group->mutex);
 
-	/* Re-entry is not allowed */
-	if (WARN_ON(group->resetting_domain))
-		return -EBUSY;
+	/* Already prepared */
+	if (group->resetting_domain)
+		return 0;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret)
@@ -4001,7 +4003,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
  * re-attaching all RID/PASID of the device's back to the domains retained in
  * the core-level structure.
  *
- * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
+ * This is a pairing function for pci_dev_reset_iommu_prepare(). Caller should
+ * use it on a successful PCI-level reset. Otherwise, it's suggested for caller
+ * to keep the device in the resetting_domain to protect system memory.
  *
  * Note that, although unlikely, there is a risk that re-attaching domains might
  * fail due to some unexpected happening like OOM.
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4d0f2cb6c695b..f1a918938242c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -16,6 +16,7 @@
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ats.h>
 #include <linux/pci-ecam.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
@@ -977,7 +978,15 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 		ret = -ENOTTY;
 	}
 
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1..80c5cf6eeebdc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4358,7 +4358,15 @@ int pcie_flr(struct pci_dev *dev)
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4436,7 +4444,15 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 
@@ -4490,7 +4506,15 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 
@@ -4933,7 +4957,15 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_parent_bus_reset(dev, probe);
 done:
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!rc || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return rc;
 }
 
@@ -4978,7 +5010,15 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!rc || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be72..d9a03a7772916 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -30,6 +30,7 @@
 #include <linux/ktime.h>
 #include <linux/mm.h>
 #include <linux/nvme.h>
+#include <linux/pci-ats.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
@@ -4269,7 +4270,15 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 	}
 
 	ret = i->reset(dev, probe);
-	pci_dev_reset_iommu_done(dev);
+	/*
+	 * The reset might be invoked to recover a serious error. E.g. when the
+	 * ATC failed to invalidate its stale entries, which can result in data
+	 * corruption. Thus, do not unblock ATS until a successful reset.
+	 */
+	if (!ret || !pci_ats_supported(dev))
+		pci_dev_reset_iommu_done(dev);
+	else
+		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
 	return ret;
 }
 
-- 
2.43.0

