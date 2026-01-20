Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A2A3D669B;
	Tue, 20 Jan 2026 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948020; cv=fail; b=sV6Vm9roVvq+9E4SjkA1Vet/9pK5krS/u88qqQNab4ao18VMn/5OwHjp11CHEmssSpii0w2/RqvFeWfQcXlrRGnnzVY4/HHKo5XIuhdqwzWh9MVJscMU04Ud+8Zbvgl//uOlZakaWXhFIJzztqpro9jtwDAsB8JJFgXlADPPCbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948020; c=relaxed/simple;
	bh=ceubnSlC2vMXoGwkb93M3rdmA5+tG/WgwUNfocZxFEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fH65pCDTfpBQlIA1ZXbQvB4SAnuGootgB8kCg+wh2DJbQ78kK1/JwIWVl8x4qOvDRyYb5lAi/0Y0IgyBOtHnrWfbYebjPeH3gUpq4SNpKc+dRuVtPD+Kiy8ZoMWr21xwpT6csMQ8kcG5ob1pi3gNTbY3RKzKQSfnBHtPvi5pnRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byNFRs85; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byNFRs85"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmE35h09znkwbl1ftYAlrM3yXvxArKkUA1lViRCNEcScdUTEDak17449F51F4GGVADqBtnX7MkrRdVhyjVdNniKKlw1FNfxO2hvdHBkiMtRq4buegemMTCGvjJiqrVWZs+NPYG/weyeLgkosOBYG9SbpUXWuuzS5NCJ0fiRIzCQeGiFWhr8oOplHUdrVcl3kSiZHwXIYZMXY4fN53gOEvYOasjld2H00lxa4NynKwKUq4R7iZ+8bFWheJ2SJwNrXwrus8Vo/yS9uGph7LyAIT3s33xIZ2xXLjlTioj8nBWavh/XGuf3Vnl0uo037B6wOYgbekkG51vtmzOF844ijEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP64AfHQTEd6lbss/eJgZaRZ8eoAuWMLfi5KN6pwpVo=;
 b=T9w08xD/TLYBWlO8+gpSjMidEQDE2L/AhaS/DPktFe4n5S5q8SfOjis1HXCKltXbYk+DQLLwMXvujeafNHSPDguKsPh6fEs9opNtv97JcwWOM65BTi+Pt9s3ex4o/oubRf05t5wRM+AhMYZSnbthZeeYq07OPxV/F9TNCwTu9WGlyc2J3l7i/cKP2EkgyRHrKeUQrO3rHTW21dGtNIA+ImKKmnWXisyskliGqWDyZOGTtazmH6hAVAx2bnX2HNH8OrgAlQZMb50jlSswqvqp4Rbn2oED+nstLl7tYKHvECu8B/ksAzKDHTrYsN8EH6GLV+rcvuLDlgVCfRyMSmJF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP64AfHQTEd6lbss/eJgZaRZ8eoAuWMLfi5KN6pwpVo=;
 b=byNFRs85Cks6EWs3MXbqaCaIquGhW4o/S1U7QufuKNAfDlIPP5jMJYT0bdQ8QRkuRVs1Zk/PpsCZxRI5XGB9h3MsSEjHBWR+YniP1dhjjB0O6D1d7dJaxqUn32Y/iqNP4jd7w8AS42zPvLQ0TIGV66tIWz7EiA+faNUVdScIeJa8iQ1YPNtboknx5a1f1HhqgAcokdipQGHhCCcewWRkQ9WkFUdev5hBBEeZ0BDXywWNP0lH1Q0bTa8wCjDWu/lVbHxxLGeBOtWz9E6BDt68Iyq9S+Ah1LnQXJpOTk6IE0V4OjrlMPZSBd16tNf1ANd+RDzJ2s8NArJ8eU4WScAjgw==
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by IA0PPFFEC453979.namprd12.prod.outlook.com (2603:10b6:20f:fc04::beb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:26:46 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::e8) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 22:26:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:22 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:21 -0800
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
Subject: [PATCH v4 02/10] PCI: switch CXL port DVSEC defines
Date: Tue, 20 Jan 2026 22:26:02 +0000
Message-ID: <20260120222610.2227109-3-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bcc2cd-dd1e-4129-7662-08de5872fecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?trIaXCgYeawxPNl/NiLgYFkEVc5Fapb3ajz01BWEpBBq+Xhq2bUyaBLtGJwq?=
 =?us-ascii?Q?4EIRLWLOUv121UAFZb7qZg2X0J3QvUudgkWTYpcGUTaxsgcTIfDDu9RC/ZWM?=
 =?us-ascii?Q?9RSFJLaPZwBObY65rJ6ioahzZMDOCTZbxP8lO9wNQo6Mzspk26BnEkcmUxTF?=
 =?us-ascii?Q?sMXbSkGES8pzNxlR65d0ejX2IoYDucmi6suqQll1JGIm5IzMQF38koMjNpP0?=
 =?us-ascii?Q?ABM6EZrXdDsfqUct98mxBKaQN+bTWx4KYuS0LM+FuAfQVNML3DYplAOM4S8+?=
 =?us-ascii?Q?D9WAptw39O9BYEv3g+aekNoDh1/lsupOWIQ3w3stUoiDtAB2TUY1ZV2p2XDC?=
 =?us-ascii?Q?zIDKjmL5q7oDTqWQArIw3rqVPWDK/texonIj9+NapkHXo/2cuO1yf3dWUtmC?=
 =?us-ascii?Q?4kYV6/ivci8BVDt7w799tHTYyfgrV7sOZ6XvyPi/j227ihZEXKq4uhui3zCw?=
 =?us-ascii?Q?WTTDKERelbIouqXNaXvY6cSVWM7obFHGrKsyMAFuH18y0Xy0keOMz7xpHV8J?=
 =?us-ascii?Q?Q5IXaBJ7/ola0Px/Ddkfxjcn1dK4jHWqRJE9IFkWlh5RZnZBDNKsDCNenC+V?=
 =?us-ascii?Q?G7dhh7Cv7CS+DRLutAq2hZq0eMEjhOuzLr9Uwu9segDddHZHJ5mBSwunCSGS?=
 =?us-ascii?Q?sgX+ExxGlovWPMGuoGNn22l/h9bu2b6B84yflBN1aJFpxwPoHPvJnewBadLQ?=
 =?us-ascii?Q?oLPNfq6vLK7CF+CHqj4WS+jcN7hDzUuqRPNely6GAB6wy5BosyURCECXvGj1?=
 =?us-ascii?Q?KhiAm96RmoD4fzwrbx/wpVHuwsolxgO4CxkRJ1pg4+1/aC6dakw/FxDObfH4?=
 =?us-ascii?Q?vbe2mxgOXpJx8CmQwaCMHnIXaiQaX1lW8QiU5Jv1TsPdCrxzWkJGYIpc3JuY?=
 =?us-ascii?Q?NAlrbvuzsA+uKCu84cpnh4H7L+kp5FgU94ybzv2E0jyFkuxAVyGp8fNaY6jq?=
 =?us-ascii?Q?/zC5b06Svey8Ig3LAbPGecKBivfSVtiXm0X6++BADB7jCG/Ww7WMP7NsaMGb?=
 =?us-ascii?Q?pItLA9A0jaHB/VDJQLdIbH04MqBPyiXFe4L/4eRlc5sWaWf7dxqeIXsudUub?=
 =?us-ascii?Q?qeOFjCGNpPA5AB8xJHlktR6704zdPUHOgJbX7BkMQhju1T8nzD6Ks5a2zRgz?=
 =?us-ascii?Q?bs7L6+0HavFsD+fjoYjTums9bI7sCasMIZmfLE3jFBfeMSdGtfvLo7rk5gnl?=
 =?us-ascii?Q?3wxh3cdCj+mKQSod+hhjOFY9acrx7P6vVuvYKOQFGeUU09FWDth9s2KA6jkg?=
 =?us-ascii?Q?1H4GaJxkJdhpzSVm2Gs8JyfzktN0jzFD80Kc/aAAlIaWVpTrALc2pQJgON/F?=
 =?us-ascii?Q?Middysompde0LOpZr0uhui2gHuRBS8/LgdG8MrjbA8ysOgdnCxkczGqNa/42?=
 =?us-ascii?Q?uRCeW1FJ7LGAinRkv1uX+RqzFtNUWRoX4J4JKLM2KtkYtihbO3NQepKm3shb?=
 =?us-ascii?Q?NkmhJmUdHkn7kISq3lRQDgJxn83Aes56et/YHVv/lF9BglAqFoAM94lkz5Ix?=
 =?us-ascii?Q?e77rzWIFbJvzB2Tofkzu7EjPNA1dnRLY7dBZMPi1TahEwqfkFo3Dc4jB2RzC?=
 =?us-ascii?Q?YumwugQa4aw0n0yD2T8bmejkx+pmELeAcMDcA+bLDn7l4CV9Kmqmx8p9X6pz?=
 =?us-ascii?Q?3EaXM5EP2/dvbEmRuzb5EZBpCnBLhCiu0GnHjNUt6vJE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:26:45.6649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bcc2cd-dd1e-4129-7662-08de5872fecf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979

From: Srirangan Madhavan <smadhavan@nvidia.com>

The PCI core consumes CXL port DVSEC fields for reset handling, so
switch it to use the shared CXL PCI header instead of the uapi header.
This aligns the core with the header split and keeps internal code from
depending on uapi-only definitions.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c             | 17 +++++++++--------
 include/uapi/linux/pci_regs.h |  5 -----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..8bb07e253646 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -30,6 +30,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <cxl/pci.h>
 #include "pci.h"

 DEFINE_MUTEX(pci_slot_mutex);
@@ -4842,7 +4843,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 static u16 cxl_port_dvsec(struct pci_dev *dev)
 {
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
-					 PCI_DVSEC_CXL_PORT);
+					 CXL_DVSEC_PORT_EXTENSIONS);
 }

 static bool cxl_sbr_masked(struct pci_dev *dev)
@@ -4854,7 +4855,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	if (!dvsec)
 		return false;

-	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_PORT_CTL, &reg);
 	if (rc || PCI_POSSIBLE_ERROR(reg))
 		return false;

@@ -4863,7 +4864,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	 * bit in Bridge Control has no effect.  When 1, the Port generates
 	 * hot reset when the SBR bit is set to 1.
 	 */
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
+	if (reg & CXL_DVSEC_UNMASK_SBR)
 		return false;

 	return true;
@@ -4908,22 +4909,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;

-	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL, &reg);
 	if (rc)
 		return -ENOTTY;

-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
+	if (reg & CXL_DVSEC_UNMASK_SBR) {
 		val = reg;
 	} else {
-		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		val = reg | CXL_DVSEC_UNMASK_SBR;
+		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL,
 				      val);
 	}

 	rc = pci_reset_bus_function(dev, probe);

 	if (reg != val)
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL,
 				      reg);

 	return rc;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae2594..4f9e6dddc282 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1253,11 +1253,6 @@
 #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
 #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */

-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
-#define PCI_DVSEC_CXL_PORT				3
-#define PCI_DVSEC_CXL_PORT_CTL				0x0c
-#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
-
 /* Integrity and Data Encryption Extended Capability */
 #define PCI_IDE_CAP			0x04
 #define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
--
2.34.1

