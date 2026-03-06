Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A932FA18;
	Fri,  6 Mar 2026 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784053; cv=fail; b=fxMsq988Zt+L/3a3VL6vtYkAHWcLM/51r1hNAhwX+T671NVOxi0ZG12LUtaxM7wfMXLuXxtf6ReT9m+T+dj0FIqv49wV1Aro1PrrfQ9p4WXaykkhIKN4tAizooN5RMrIARmyARRNZtHlhenfeEitxH2b1P97sGNSseYrT4qY3I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784053; c=relaxed/simple;
	bh=znDKCtvo9z2ZNXcxE+MBco84O5/uqisP+Y/4Rkio9R8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eNMG2YI2yahVXkhxbb3xzz/WLzbC9VXOZ6IdNMW1FV/zi10R0JjjDSAQ+5pHpW2mXXtUIzDKDaLeFniNvK8bIyWNlpjplUvF0+fRfgvMbiBZkDayhD415QL2SNGeO4ZGjoTzDV/c0Ca6vouw1Q01fFAr0W4ZqW6OYWPChqQ+Rrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHPEbX5k; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHPEbX5k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2V9+55098Al3N46QemP7mYMGvXb6kBPWsGMeHkGe9TkRV7sAP8cQlWaZ+rVvIoyqvhMyLYSdgd7OIehQnHmsm+ZqBK0af9oS6J4mVrP7TQoiASLyUZ13piK/cVuE/OwT36lEMYeua/FlzmFK8/OOJm3o1S3SAEIHJyA/kVngvWiiwMLabRNJ0Z1EJMA+Ep+4pGngYO2NOau4h1/+bwYS2mTQF2wn76oTcLwyrNmlyKHwYUWPg9UOkEX2K34xjshddal78FUmkcqsROythJt7L/MJBq/7O6C9nWt6b6EhWlQpbqtewZjBh4CCfaFMPRYMLmeSOJGFqItiHJhDVkJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9kjCajxHJ35TWriPLMuWh8QOl3s91Vir0jAzn8+TYM=;
 b=j3HkZnCxs6/rg1tRLzXWTmx+68fCEx6GAqpzdgMTLpxwsQf5dW1jtWWS4N/Kxd76evy66pdhsjwb+KWNE+9Z7scdhK2tQ/2jD/drBKYpoL/NJmyAzknkQRFMOtsTLBUjszx2eaV+t0ULxuRNfmKG2i+Lf9YYgtCXdaKcy5OOEjD9fBKXP8FiGJvRvD1tA0wcXRVCTlHfCxHqicfkBbWI8WdPhqyTszueLJnJ5uhpGvmVwJBoIYxRZ9DjbKIEnHoHYJuT89s7MX3IslOfjZi1LCRA3ClMcspHRyqESuVczpbtrpaueC1+LLbJGIcJUVpwp4EWNaYArztxPTjbme7HoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9kjCajxHJ35TWriPLMuWh8QOl3s91Vir0jAzn8+TYM=;
 b=mHPEbX5kyzD+o0brO8pnuIrTIECwqQ8P/0T67ojt/kQxE//iOHOen9GQ4s+JudZy6wXsbx6wz+/+j00iDWYnxn+1T59gXO8JHzYoENHLh0BtdP704qV5he/oq+jNsyy92tdh4oOTOvxF0LEFV+7PPRquqIzSKVez2JImSO2BGWK0cKIQWzlU3jmZUDW2kljHtTTfh/bd/0MtDe1+3NcFDt3BSPCrp3uG2KzQuo/Bzj7E6tS+6imHDIqoGJkJt12tRwYBYmkm47EtUYO4cU3qVJOy2h3CnhJ7gFq5Y/VFWIm7r/03aKPBM25MqeWYVP22Dsl8xaBZpeea7qNRlt1q4g==
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 08:00:46 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::cf) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 08:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 08:00:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 00:00:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 00:00:33 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 6 Mar 2026 00:00:32 -0800
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
Subject: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state across resets
Date: Fri, 6 Mar 2026 08:00:14 +0000
Message-ID: <20260306080026.116789-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 059b5438-c535-49bc-ec64-08de7b56796d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	F/pgyL8DFObV8vlPLOVedjaA8/3aqVuUQ/tehwJ0Asd49aP0OHydlnaVXXVo5O1cUwXkrJJYZxcTKzu65n7OpXwrsjdivRBmx8cY3wci4juzYrGKnv06vPXsJdet1Lv0DfK8k2Ml+1wHYBJZht7brzY0xW0jrE9xp3+5E1iTgnCEdCncQ0aiocc4F7ln++f9FIl8Jck+dJ/jWKZEKo1O7IvSAC9wiTpMLeH7kDmaziLvQFATm4pNNOwn7fNLwMnm0HJaYmQOX+2Pa6aBytRmvc7eAiZYskCcxlZwCToHXrh2gHxNM8woNijHX7pr5fm8tLRubZc45PNHEoinKWrnSsSTGm68NXtaaMWrlvgvcDcQxeIA5BigjTnndYqQFEopx7FAJGAg3rvr8ZPdBrBVRTCmmWGrsCm/Co0aSELtfUmyqYU6MKLs0s8RTrV+D2pP58KdPSpXlLow1DRQUTqNlzGhBFS11R7fm5nVdzx8zjzVXrrrgaOK89PTuhmj6qDiteP5w4u4NhUqwOJYZmxU4F3otxXONs9m5FVkv+C6q4hcVqfNG4xsegukH5Xeaj9bJ8HPvwKYOz9O9WIeeWFxrdf5F6bRMCObQtv5MVFrI5ozWLloyzi7wjzMSMx29cL2G9no5rtZE8R1htD+mSz/PbQuHQPDS4VWrfs2Wh5VbrTBCHoHejuEVrDV47iwxOyCDnpFORARvO5dI9Sxwj9FfUB3ABuvxhczgfwnGlXPuyvn8Y5KMwurFjIvIGBtSbgHM+mtiOw9wKJhR3XC7g5iJw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HsKsBzLevroPhccze6MXy4mo3zRonbRWexNjxyf1k9wsYKdx+CcDiTNa/xNsZq7EeNFAOXbYU7vMoYukD/DgJa7wuNkqflA2nTQ26GsePR318c4EnDl/CzYFYluVFo4g3UiPxKj2BZpM6qxT05OEjobidkMufoFAmYlkAEvNtP3LYnT4KP3irKLV7vtWNihwUWbRewAMysNQxHR1ZJ1iu/s1uapnpG4gXbpRCLMruU+2OFgjmdSOXb2zWuJsHp4WYvi3BxADE8pHNd0UIfA508Kz/hvlSB/4x6HMSkaq1ekGLPfw/VPXcydC/N8FvGtkOBfARXTM/vN5USD6oaPuuP6Ft3NI0zTwUS+2SlkhOxxW3hyuj7QKuhvK2msWCW0xmpqeilKBUh7SU5kMdhdboB5FCBRIDfdg1tw/Hv4z3pCe1qcyeSI1PSSUqL4HmGx9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:00:46.7479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059b5438-c535-49bc-ec64-08de7b56796d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

From: Srirangan Madhavan <smadhavan@nvidia.com>

CXL devices could lose their DVSEC configuration and HDM decoder programming
after multiple reset methods (whenever link disable/enable). This means a
device that was fully configured — with DVSEC control/range registers set
and HDM decoders committed — loses that state after reset. In cases where
these are programmed by firmware, downstream drivers are unable to re-initialize
the device because CXL memory ranges are no longer mapped.

This series adds CXL state save/restore logic to the PCI core so
that DVSEC and HDM decoder state is preserved across any PCI reset
path that calls pci_save_state() / pci_restore_state(), for a CXL capable device.

HDM decoder defines and the cxl_register_map infrastructure are moved from
internal CXL driver headers to a new public include/cxl/pci.h, allowing
drivers/pci/cxl.c to use them.
This layout aligns with Alejandro Lucero's CXL Type-2 device series [1] to
minimize conflicts when both land. When he rebases to 7.0-rc2, I can move my
changes on top of his.

These patches were previously part of the CXL reset series and have been
split out [2] to allow independent review and merging. Review feedback on
the save/restore portions from v4 has been addressed.

Tested on a CXL Type-2 device. DVSEC and HDM state is correctly saved
before reset and restored after, with decoder commit confirmed via the
COMMITTED status bit. Type-3 device testing is in progress.

This series is based on v7.0-rc1.

[1] https://lore.kernel.org/linux-cxl/20260201155438.2664640-1-alejandro.lucero-palau@amd.com/
[2] https://lore.kernel.org/linux-cxl/aa8d4f6a-e7bd-4a20-8d34-4376ea314b8f@intel.com/T/#m825c6bdd1934022123807e86d235358a63b08dbc

Srirangan Madhavan (5):
  PCI: Add CXL DVSEC control, lock, and range register definitions
  cxl: Move HDM decoder and register map definitions to
    include/cxl/pci.h
  PCI: Add virtual extended cap save buffer for CXL state
  PCI: Add cxl DVSEC state save/restore across resets
  PCI/CXL: Add HDM decoder state save/restore

 drivers/cxl/cxl.h             | 107 +-------
 drivers/cxl/cxlpci.h          |  10 -
 drivers/pci/Kconfig           |   4 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/cxl.c             | 468 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c             |  23 ++
 drivers/pci/pci.h             |  18 ++
 include/cxl/pci.h             | 129 ++++++++++
 include/uapi/linux/pci_regs.h |   6 +
 9 files changed, 650 insertions(+), 116 deletions(-)
 create mode 100644 drivers/pci/cxl.c
 create mode 100644 include/cxl/pci.h

base-commit: 6de23f81a5e0
--
2.43.0

