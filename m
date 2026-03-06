Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C303288A2;
	Fri,  6 Mar 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789073; cv=fail; b=e/+JeVW8xcSUL5s8hLyHJDuh+l9wchVvZCvWXcJ8jJsgwuM/KmbLB0UQuENAKtoIgcQ9BqVLVsYNb34eyh3u7yJsKxbkrYsRg2ZNk19adtFBTzygVja55KVKwnrdGdoOVy89I3Hm35zvtbsWRjA6oVl7OtGonmc/PJ85EEicLtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789073; c=relaxed/simple;
	bh=I/SrlM62UJDsteeoaIR4QveDniYzzGVCEn7YR88uCnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpNsfHkPKhXn9QOfO/BjPtKXriF3N+/7EBqccBVulvGkAzwmfr2oMbGJ6kuKff5tkolEu6kXSwLMrDhxq333nFf6/gYpulPZbYGzF26R2R/OS2N5B0MUBelNPDFOJzvhCWSTNgofJD4p7Cx3AYuvbHxVAZ4TUX5oTszLPX4iLGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rsAAS635; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rsAAS635"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgK8xpt+5lLWmYUN6YQhVT15zElz/UjbA/h4iDYenKxFotyukJUBzvMC8sPrzn6Hke8y460l/zsnP84ZNHiHrosXzMxWbSM/6bLsCme9luitcAIWmwS6dLpK71c38MeyLL79jD0vZEnl777MqjMLfIO59jfGZRoOTpY7xBUoN4uHCT14gggZ4pUhTek42uEREW396UDJoiEAFdVE6pjZaAF52Yei+NFRQsoVFp+BYz61GPiSVTeyDMrDja95xO3MKae1auoDb20o9oKIUzD2PKL8S2OhTVDqoSa8gwpn4jvzUWJj/zk/Ih361PlP0phkWklbcVSWDKT5FWYSO4NzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ld7CCCBlWqaCK4Z8yiX1vJcNKPNbwjjYNIMZ6wscd0=;
 b=pU0ynoHE5fHq9aTedlLzqcbx4jsXKRRpwGpmlSXqZtTb8FVGvP1SoE62rWjY7H1iJasrXgGdWwucuTbLWLCrbAOYeSMwdyd+F0upuv6X2wg8hGHBzJ9Au7Rk59smC+WakAgLADDBQ3b23/y6Dpk3ob/s+dMY3HydYwEQYud/3u7/Hjb+MtXIz9DD4zrRNAzM/gPf7KtPma1UUA3fF/9VhhBPzoMhbdFTWefBpHqrHtfhrx36Wd9gSTa6CsOGOhRtwiELBTTX6vlZslcl8J4CMFQnRFM96e+5SGO4Tanq2m0AluJoEPyY6+jGqi7YeA6WJUXmsepE00d6q48b3mh6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ld7CCCBlWqaCK4Z8yiX1vJcNKPNbwjjYNIMZ6wscd0=;
 b=rsAAS635BFQmziPCvdELeBGzV9Mj/scAjb88dJ6yBB335N+UE0QAP7IWRapkGN7Y4kgI9eQoPOKZZgFsCU8+VyYaBkVLQSwWonoIW+1x2XlneKLuABWnvvxXeaZiEXmlR1kx2IX90uQh8Ffzw3snUp2ej2OgW4nUr+Bd/cGa5sWdmxbgh90AzAVRbFW9+sKN3eC7W96Fq6WLpRgiA2449qqujBi13B1bVwJ+OjYDGGWV7Ge/tqGuZc66H+w0sFwgL829Brh1pBL62InsCF+THTMJrFCYLOvs5G09lEH+QVYTrc4vfb6ksXI+MB1hB+AjAp4ASDb49xQXTRdMD5Io1g==
Received: from BN0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:408:ec::34)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 09:24:29 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::78) by BN0PR04CA0119.outlook.office365.com
 (2603:10b6:408:ec::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 09:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:24:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:24:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:24:03 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 6 Mar 2026 01:24:02 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH v5 7/7] Documentation: ABI: Add CXL PCI cxl_reset sysfs attribute
Date: Fri, 6 Mar 2026 09:23:22 +0000
Message-ID: <20260306092322.148765-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092322.148765-1-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 4339fc4c-779a-4c6a-80c1-08de7b622adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	FGfqIQSGTo+5I76Ip8fjzNRT4A+WAB0vXB4+Rx2zi91oFvmv9Pb9D4NPa+MdNpQnwFIxoWuL97+OX4DGdsTWb5FpHdUjghmHS7VvKY14ecaXtnVxY3SrekkCGs3NBZJU7Q1ww5XdDOq5QaItpgJx19jiULQBdejCAyV/5MAS5Q4sLYAP3Rd1JE9MqBDqwQQuu4ZSICRjI0LdPTWaWgdkj62U1c63SFELbVV+jIngq8pdw2EBWhIe6yNs5l1QHFSkiZuUv5LK4A8mKyEv3oYcrVUdX0ELRW0PJ0aHr6QvRcJPytSstJ6EzmrQcINmMAmrkU0odzUYMuYEJycvZ4BM0frZc6f25NN1ZIHOSacreH/qxOe0Dyxk1YP24OxbBjIRFvGRjPhMLbayeZR0Rt4+DFMYlW2rI5mfRGEGni7fcBN40ctii0tpx5GjGUcQRflUFAmAFR59Pv8+EO50bhWVKD1fI43PKm7JQFw/QcDKgeSW7+jldoOQpxGvhBi99w7S4YdT771GVODFIPsN4XbteOz2+tRbG9U3J7Dhnv2cX3Y/F0YK9nAcABJC+May7wwxFW1EP5uIWB1/wqBB+2nXPLOcjYRQ6iBDNPtag89ytHIB4OkAl1gt7vCx0htVaKpyzYtM0X8ovpqNB3TSSPhGYwdkQUKi2/jQsRlFXaWjIawEumsYRMTne1BdtbIVciHNUbMhM71F73tCrJlKJdNG+94i4MqBRxFoLMnpnGaio2A7lxF8gLQ0jJdnrtslP9OVcm4myGq+Go3tQXP+kdz9Dw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6O/p4JGGd2bA55XiQZtRYqIDOdyBI40NZzPDFFeIoUtLCe62cxgxs0e8bX0WUKen+jE0yGQnQ3CjGblH5rIbpDRusDkqj06goNmkb2LXAETPGQhEkhEs0Y0JUlfpy8gPy6wIby91LL8LoEWzIPhw7e4CgyvZhawn1VilRfOBMh/h/VsWmIWUa3dXL0dg7ZTH7SBya/w1nVFwL20NjzQoS4GmYYFsWKGlrmwdZgHDUVz6Mgu5XUAbiprTG3Bew09zaM1SdMXCwa3bKUN0lXldiQiZrJ+/doLC2Z+mmEECNNIxH1TWzX88j1tRFeC37NWSqhchLY/aHmsN9Qnfla55fgkt66TPoDjyAlPv5ruz8A4wzw/UjberFTEkI4P0NQ0H1+72MX7//r+fTrKcmvqCj/kRRTKgDBE3vLUigXh2HvNjX0mDjlP9QE1v7B9L+O9U
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:24:28.6358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4339fc4c-779a-4c6a-80c1-08de7b622adc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

From: Srirangan Madhavan <smadhavan@nvidia.com>

Document the cxl_reset sysfs attribute added to PCI devices that
support CXL Reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2c52cb..d67c733626b8 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -174,6 +174,28 @@ Description:
 		similiar to writing 1 to their individual "reset" file, so use
 		with caution.

+What:		/sys/bus/pci/devices/.../cxl_reset
+Date:		February 2026
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		This attribute is only visible when the device advertises
+		CXL Reset Capable in the CXL DVSEC Capability register
+		(CXL r3.2, section 8.1.3).
+
+		Writing 1 to this file triggers a CXL device reset which
+		affects CXL.cache and CXL.mem state on all CXL functions
+		(i.e. those not listed in the Non-CXL Function Map DVSEC,
+		section 8.1.4), not just CXL.io/PCIe state.  This is
+		separate from the standard PCI reset interface because CXL
+		Reset has different scope.
+
+		The reset will fail with -EBUSY if any CXL regions using this
+		device have drivers bound.  Active regions are torn down as
+		part of the reset sequence.
+
+		This attribute is registered by the CXL core when a CXL device
+		is discovered, independent of which driver binds the PCI device.
+
 What:		/sys/bus/pci/devices/.../vpd
 Date:		February 2008
 Contact:	Ben Hutchings <bwh@kernel.org>
--
2.43.0

