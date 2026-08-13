Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFBD4446F7;
	Thu, 13 Aug 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613987; cv=fail; b=Y7vyApXcXa/iObbggIbYHUJS8cNMD7XjA8j4hPdbtaNDUBpweCznYKF0n0iucU2+AtZQ6k0bAegyAw77CPVuXCeTkqxO4efVNutvTS+auXQ+WeKtyYMyqfweERHXJZW9WwH/v12PLkskETfnDng93DCadYAMgapPWr5KthaSTkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613987; c=relaxed/simple;
	bh=D6akNIkGUSbIux95uT0+SHTdNmxuWzKOciXJolnT2rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLEntMmw1bjgulTw3vKt9EbdMjfDRy2V1GZaFKMaxXye5/Tt9B9qO/FojNwtTUinSGu1lcxMnQnTZLgdB/T0GlwFaMu6KBeahdFMNfBcajSPGKgUvOqSdJftgmSppxpSSU9PObCkKhLPq0AIW2cgTh0e0xqQh4wtw0xpx9ZZnx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxxkMP2O; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxxkMP2O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+sChqy/lF6vzK0MNnoUngYcLS07TbIZqPH5MAadZW0adCU4WNbDMdYV9x9mhtniv913rxVk6uQ3xAjZ+PIkXgHkJ1fz0Y2l1H13ieuQgiaoIcCgacD1vjfyXnObpxR+PaA2h8PHfOZF7N9Sx6+8ITN5mLu1WlEpMIh+dEIMq2RmkO0LICTPU6i+tkkZkmSqTjoQcAWjs/lDwsox74wYZdpeRju3gvAAQUFTbprTq+0pIoxtKfeYQtCcz4H3JZmZf9XxD+rlN16a183dlWnzSnRGYE097V7yZJ8pb8dFigb3RDu2lHHnwsaKUEynOtrYXBu4Zh92KF6mZoZPLYMxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5BXKy+4XmUzqCsdpysaudrRS4yHrdCktJ3+pEDxt+0=;
 b=uu+A5HGw+p25RHjy5FNyd95lrkRO8NoDCPXfpdJW/943Md0ngPGSBN6FQRrceocKLRMTgeVzHPYZpLhdIZvYn9teqSygQSK6tA1ZRfanFjw+sf27N8E2Rdd1Q4G3XPbp0Z6kgLWZwbPXm+IOMC5tigYitUvP5TCc8lERm8/3HIAbRoi26z9Zv4Ri3digfDLTqfMhDpK53FLvAWiYUfgMg3m93jehGVMBVJ7kWZp8+eKTmqTRFD+wZqsn4b961aUy4ByyjynoZTCLdemgOpBIQvy+HMODZlN9NlxtWh67OIj7l6QNuEyvH/uabO09c2xkN4undhF14zggVnrlxHNocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5BXKy+4XmUzqCsdpysaudrRS4yHrdCktJ3+pEDxt+0=;
 b=MxxkMP2OkqyjRQNlt1TI1kDGO0xcCzIoWlBXhrmFNg/py2myGr5nbI+Nu902/4ce65gvTCK4s58stF1O4evNjAHo76S6VPdkQ6V3nvfn2SBHER7STmzUL1l4/SAp5p3B+PM3wEBa7+AsS/vxeHf1+jf/R1EDSn9w3ALqhazIBPSwL/Q65RPy9q63QzEcmdMy2GdZsbmUPCVE9JkSe0jocPjxEG0NyYioGcXHSTtD5m7kE/QOTTAIBuch7qjP1m+U6hDqhNmBDIZCcvw6yNcopJ5ZzE3pw11pF2Nwe8OPUgb7izBOuZZVapR0PLvNDWWNZJvV93AW1d6ZXUrshJy8OQ==
Received: from BN9PR03CA0875.namprd03.prod.outlook.com (2603:10b6:408:13c::10)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 09:39:40 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::41) by BN9PR03CA0875.outlook.office365.com
 (2603:10b6:408:13c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Thu,
 13 Aug 2026 09:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:39:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:39:24 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:39:15 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v4 14/27] vfio: Add CXL region type for the HDM region
Date: Thu, 13 Aug 2026 15:06:18 +0530
Message-ID: <20260813093631.2288172-15-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6f523e-152d-4c22-a590-08def91ecc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	KjPBzQ3M/NVPltqDhYf31n9tK21BnFbBD+24zXwgITd7SoQ1pomC1x1H3sei7xjOXLlzfNqadutr/wnK8bjkjoeAln/at/8xBkAZhAYWg+k3QURVSqWol4ZzP4imSnw9YprlghSXSMeYP6qJITq3PRjN6qsIb8g+WDHRiUDita4U2fNT1iFppqP2WnIuguiRq556nkZwUfsRkkJzO2aqoz+UVGLZ6lTzAy8KC3Fh0fezjZlt1UiJALGximlqosJ8CfUZ1ur6dUoJ2kTE6z2BgFYGV8rVWHnjrYzaRu8GLPFHLP/1eNl/ywa4HMHKSL77HSeeGt7TKTZQe/1hL0Jm65slevaxwhBw11v4sLl2m4OgnD6aXf0XHFxCeKW1WPw9EvJEK+dyKE8yp84sYHyYBVycGRzCzISyERpaDntWhYXOy9xdOsZzTD5YM6URxl8X9hbFIEbub0uw70vhn6SRr9N3dM1PAbkKlVzD10xstZfknaZwLiwPkl0DLCfEBNkt95FojEXPwtWVQxYgCm7g/rOS1UbJshrD/uvFdje3wbkoPkkZ225RY6XBu7G/O2y+d5zh5f8ezPax1B3pntm+9uhLhklClWwk5uRua/6ubR//aklqpHkZRLdd464kTwTV7X6/t2VZW0NRHTVZySe9XaB+sgcpxJQZheRvvtu/kmNojdOB6K3U2FXnG/rW97eQm+G6XwolD3wOlSiteql0ZLLSTMRfDu9i/B6UWAIbWdFPufxwUkR7SciroOgH+hC8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5ROnWtlZcV/GIAgd7CDgRz+MzLgQ0lXYCc+yYZ2dVIDUac5I7V3328qxcxVDWvZtZ2QVAcfFqRyGdK1/nBQCXHCcesGPNOkiwOoMwS1YLt/BxfBPn37iD0ziHcGPq5jPpx6wymEK4cNXCPpVwruydjvKfLWaRx8wX+h/dl7X2DHXdzvA35apH6Gp1PoeYxs+h6Wc+YD/UVLY6JZckZLcTtdNi6pLW/II+m/H9ld8nmNvTCPpDl4XfjDKCRdhix1/x8eSHCKFpTeGd2lW7P+pclOH13FzeXVe4BGRy3fN+Er5g+yYh4ElmrjfDbiW6uBMw12nqI5OJXxK8RRw2v3/hSIAtf90hTDYHKh6WAHbcKQXgrwGckKzxa51rSsUuufdWKqINhUKKhuiWHEP3rt8LWvatN9CG0DGWUGL6nrVSiVDqHXQ4T1SmDVXcXgGyLw2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:39:40.6271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6f523e-152d-4c22-a590-08def91ecc79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 device exposes its HDM memory to the guest as a dedicated
VFIO region rather than a PCI BAR. Add a CXL region type and a memory
sub-type for it; vfio-cxl registers the window under these so userspace
can discover and map it.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 include/uapi/linux/vfio.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..540e62312671 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -345,6 +345,7 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_TYPE_CCW			(2)
 #define VFIO_REGION_TYPE_MIGRATION_DEPRECATED   (3)
+#define VFIO_REGION_TYPE_CXL			(4)
 
 /* sub-types for VFIO_REGION_TYPE_PCI_* */
 
@@ -373,6 +374,10 @@ struct vfio_region_info_cap_type {
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
+/* sub-types for VFIO_REGION_TYPE_CXL */
+/* CXL.mem HDM region of a Type-2 device, mmap-able */
+#define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
+
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
  *
-- 
2.25.1

