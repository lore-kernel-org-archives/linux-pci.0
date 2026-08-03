Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D93349CC1;
	Mon,  3 Aug 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795627; cv=fail; b=tHJ+u3YwwlzCnATTsrlmbWPAez0l7ay0lk/5p8CbM7ZAtlOCOPSok/fiIUg9NDdQdHmom7UJdOpLSsBeRHQHQSQOE202l9NPyZZ5vhHsbChLVx2/Cf+DVXN8jJ0b/WQdKZT8eLwhCcs6Fv4vSMRDwgVSuxO1qjW5dkzeUL2HqPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795627; c=relaxed/simple;
	bh=cg2qtZia8+kECjJWzztIRHZ013dDKmTE+KT3StHVypg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRmd6TNIbaWe5qT5pzkGq4ZyUIsWZVWcT3mpMR2IfVn1NN1+MMnbmY9NVkiFfv65fhny97NsbYbB2BLBrhD3Jpvwiiw5qmPGAvxgNizE0RZLtT3S+un90Z9Q5YMlXYEb02p+4gzNNU/9CV5CB3ZfVV9kXpipJrv/VGoYHfuYe4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PZPbCwE5; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PZPbCwE5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxcWRtOpH1iBMyRGZV52AxmnX/OkBbz1iULwFzFvWw6mSta8YsmAyGUjzx4bWni5D4z01DNedX22zINCR/UL/XFMhLYHYL511bT6AV7k2a/Olbfvizm4+dsombbKtwD6pY0Z3DF9rhHDMc1ZWBtIE5n0GzLi6VnvI22fC/7znGjyWHNesWyIvfTvWnQIcG0Z6XBAkao28eAiKclq/fjjy585S3CB83zVsuXAoPZc7YNBeWcvPCw8cfJf0fJ47SHUR9hyQTNh1CeBIXZW54MUF9ISxBEZD9avMtcF09RmfXh6Rkszzy4NJYH/OB9UeX0y0tZIbm7tsLYKW/Eg8Pxqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d4hVfpowWH0sLIWEpi2UHA9emdZq+b/bca0c8wSWVY=;
 b=W5UGhEcG5JfdO573z0b//OHVUPH2UWqMJoxCIr/CyVs3XtlPD6Ln0ctXwwIk+d5N0K3FM22tLFdRLheFv5nBFcxgFqn/rNrl5eG4r7P1gFTMCpgymLcHFiEwr22dhQ2A9y30ilvo+THWe6poPHIcazDti5c1GDJwcRbI98LF3P+Cimbe/CU77C0cEbtRCLrir5bvyCh+mdWyPA9bZoyWHCL6rwC78LzbgI04q6ikOmngzSJPtkC8VdkMU2TJsluoSRQL51SjSf8hp2R8x68QVSYDHhWcFTWDSJKi8cYrBuLpt/TvbrgIhol+VO1P+X67QL7NE+VeNYU07Ip6jPmhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d4hVfpowWH0sLIWEpi2UHA9emdZq+b/bca0c8wSWVY=;
 b=PZPbCwE5P35JM0p2nT9OGENfliGQ7BgK2qJ0SFkMj3wtKexkM20ZUwwVOMz+2jn7MAyRuMkd0aEqSUjcruIUiV5B/cErp0pVHLhpH5nrw2HS9TL+7l4mJ57cwP9+crdlaNMDNwT2FygRmZuaLBiNLiLmPrPfe+hVB8VyrzmvJdo=
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 22:20:20 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::95) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Mon, 3
 Aug 2026 22:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:20:20 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:20:19 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 11/14] PCI: Cache PCI DSN into pci_dev->dsn during probe
Date: Mon, 3 Aug 2026 17:18:07 -0500
Message-ID: <20260803221810.3685703-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803221810.3685703-1-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 9685866c-0813-4dc0-8eed-08def1ad6779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OKwIOEKK+fwJWAGBxayM6IjPF/+V1mqXYCPPvSCzces5yaf4/UBfaVUbk+Hbp8taCbpwdpTDKER2Y+qHHcKzofc4oSMDaTG95yD7F1l/KDzHGIZ+VhN+w225BkZ6ugNTn0essLFUsVzfNOGyHycIBbbM12vttSnz6E+2c/hiOieOYrYEkp6grsKpZv2EA1vo7qMEN49fOBCjgbayDQlcRlMVrTpM2HdcuWpmHBKimVV7Y5vbrzoftQSpz4OzvhO3GCK1cYU5Y6zKo+qNeBf0nQeZaPzmzX/gnUIHR2w/itv0OO7dtfDLOD0HOLx2E4XK+jFreKhGVO0LoxdpXaGicwB54YKh2Zui0eVjxgv34VKTY0sLepYraiG8C3xkrcyAJkssZnNwJmC+pLLdpfIX4UFdx0KerP69HP/dKkqmIx22uTCBOUz3wx1RzvCCbRnZENCFDrdRZCWO9P5sgFjXquwKPHSgEqoQqRgAU575wNJYH4d5NAYR/BidnlM5dFY+lHki/Y0qjN7vWqAPwsxdv/oJw36UtvO4PmNoPStlyj3zrNO90XdTQi6gqMpYX6vq3toH5xgQ+7i6Ygw9ulHOmZylexxxtbISohg0JKJfvYatcGsJP4CdrrXqnNa3LBdYlfnfL7xNR7zc1yUnDgwxtLEsPy/MejoHDcSXFtxsX5RfyEU2LyYPTPEdcSBi6G1Naja3zRu2U+mOgYqHVneOMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mGCLP24S933tnrH23eNJwgfCujTYpZWPo4r7totFW+D/8/QWqpV4kEO8Ijqbw6kD3/3wyzMd9I1nQ/WihaNBg8DtjdIB4m3/wnkMiL8j0pwmQPHPO+CZ2OiFI4/tn2VY9hlWHsGceYuF2Ka5cb4Op61GSmsPUTR5IuW4Fo4DkSF22ujegrG/vNmKXxzDfYNriHpdZOjzf5E7A93u7SvG7z2rkLC2Pumo9UrO6o8nU13+mFuaG2SO/Lqy79dP14iQRyGGMm9Kf8avKNfl4nv19N5ByrJCuP/FNM7gvv+926XWSttw5RBtfXXsEENoTF6wyut8Xg15y/sqNX7RoWB2U1Z7NKMGwe5WAbwBC+g8Iw0HFqBI2py+v6vHmiF1C8bXY41gX72Y2O4wNMiJtaa/QtoKaq4k8r6LBWg18PdtKwIRWucpnMSLIW/Pkf+o+D9v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:20:20.0408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9685866c-0813-4dc0-8eed-08def1ad6779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620

Subsequent CXL error-reporting code paths need to log the PCI Device
Serial Number (DSN) as part of trace events emitted from interrupt or
panic context. Computing the DSN there via pci_get_dsn() requires PCI
configuration space reads, which are slow, can fail when the link is
down or frozen, and may not be safe in some contexts.

Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
during pci_init_capabilities() at probe time via pci_dsn_init(). Only
write dev->dsn when the read succeeds. The zero initial value from
pci_dev allocation already represents 'no DSN available.'

Remove the now-redundant dsn member from the pciehp struct controller
along with its kernel-doc. Drop the pci_get_slot()/pci_dev_put() pairs
in pciehp_configure_device() and pcie_init() that existed solely to
read the DSN into ctrl->dsn. Use pdev->dsn in pciehp_device_replaced()
for the device-replacement comparison.

pci_get_dsn() is not modified because it remains a pure config-space read
with no side effects on pci_dev. The cache is written exclusively by
pci_dsn_init() at probe time.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---

Changes in v18 -> v19:
- Update pciehp hotplug to use cached DSN.
- Swapped order in series with
("cxl: Add port and dport identifiers to CXL AER trace events ")
- Update function documentation for pci_dsn_init()

Changes in v17->v18:
- New commit.
---
 drivers/cxl/pci.c                |  2 +-
 drivers/pci/hotplug/pciehp.h     |  4 ----
 drivers/pci/hotplug/pciehp_hpc.c |  7 +------
 drivers/pci/hotplug/pciehp_pci.c |  4 ----
 drivers/pci/probe.c              | 17 +++++++++++++++++
 include/linux/pci.h              |  1 +
 6 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 46e60c53d3ca4..cb256d194de28 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -807,7 +807,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dvsec)
 		pci_warn(pdev, "Device DVSEC not present, skip CXL.mem init\n");
 
-	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
+	mds = cxl_memdev_state_create(&pdev->dev, pdev->dsn, dvsec);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb2..30aad3b66bab9 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -46,9 +46,6 @@ extern int pciehp_poll_time;
 /**
  * struct controller - PCIe hotplug controller
  * @pcie: pointer to the controller's PCIe port service device
- * @dsn: cached copy of Device Serial Number of Function 0 in the hotplug slot
- *	(PCIe r6.2 sec 7.9.3); used to determine whether a hotplugged device
- *	was replaced with a different one during system sleep
  * @slot_cap: cached copy of the Slot Capabilities register
  * @inband_presence_disabled: In-Band Presence Detect Disable supported by
  *	controller and disabled per spec recommendation (PCIe r5.0, appendix I
@@ -90,7 +87,6 @@ extern int pciehp_poll_time;
  */
 struct controller {
 	struct pcie_device *pcie;
-	u64 dsn;
 
 	u32 slot_cap;				/* capabilities and quirks */
 	unsigned int inband_presence_disabled:1;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb44..5336e9c9003ae 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -587,7 +587,7 @@ bool pciehp_device_replaced(struct controller *ctrl)
 	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
 		return true;
 
-	if (pci_get_dsn(pdev) != ctrl->dsn)
+	if (pci_get_dsn(pdev) != pdev->dsn)
 		return true;
 
 	return false;
@@ -1085,11 +1085,6 @@ struct controller *pcie_init(struct pcie_device *dev)
 		}
 	}
 
-	pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
-	if (pdev)
-		ctrl->dsn = pci_get_dsn(pdev);
-	pci_dev_put(pdev);
-
 	return ctrl;
 }
 
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 65e50bee1a8c0..ad12515a4a121 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -72,10 +72,6 @@ int pciehp_configure_device(struct controller *ctrl)
 	pci_bus_add_devices(parent);
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
-	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
-	ctrl->dsn = pci_get_dsn(dev);
-	pci_dev_put(dev);
-
  out:
 	pci_unlock_rescan_remove();
 	return ret;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18d..450e5090564e2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2638,6 +2638,22 @@ void pcie_report_downtraining(struct pci_dev *dev)
 	__pcie_print_link_status(dev, false);
 }
 
+/*
+ * Cache the Device Serial Number for use in contexts where config-space reads
+ * are unsafe (interrupt, panic).  Process-context callers that need a fresh
+ * value (e.g. hotplug device replacement) call pci_get_dsn() and compare it
+ * against this cached pdev->dsn to detect a changed device.  Note pdev->dsn
+ * is 0 for devices without the DSN capability, so such a comparison cannot
+ * distinguish a replacement.
+ */
+static void pci_dsn_init(struct pci_dev *dev)
+{
+	u64 dsn = pci_get_dsn(dev);
+
+	if (dsn)
+		dev->dsn = dsn;
+}
+
 static void pci_imm_ready_init(struct pci_dev *dev)
 {
 	u16 status;
@@ -2674,6 +2690,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rebar_init(dev);		/* Resizable BAR */
 	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_dsn_init(dev);		/* Serial number */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c1..48a1622639190 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -386,6 +386,7 @@ struct pci_dev {
 	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* Driver bound to this device */
+	u64		dsn;		/* PCI Device Serial Number */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
-- 
2.34.1

