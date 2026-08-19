Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532128B4FA;
	Wed, 19 Aug 2026 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123404; cv=fail; b=VNK3y7tiN/U75RI7EYu8SdCCwE+VexvPEEBlmCnbPKNO+/gNqbjeGC0rFB2GyknZS1yAyct3jzTqftE2Mboj8DLRflfXwbH74HWf9HBz7PLpL66VL2FMBRPyfH86XTzGoMi8tC3nhn7mHHn7pGL0pvcTDUnLhuwc/HP+R4czmwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123404; c=relaxed/simple;
	bh=HM9TrhCCjLdljc4DIQjiDNqadIFTGnr8GsOQuL7n1mE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ztz5pfU1CEtiLHcq5Uwf2oHmCTQ/tfEtjEr8VzNaYScCmDI0wcNm1yVQPYVOUdCGegiEhJJQhiwVh5XoxeQukKHc2XpyZ0YLiSu6NbJAFkvH81xb7VQK4E80O1t9TqC1L4lcVFx3MrFNl3zfD/vCgWXZkU4XEk/DeaFTYqn/LcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XyB5fDat; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XyB5fDat"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOJNK5OFPIYhAc6JENDiePi8iQQxVS8X6Gk3+7jxbV4QC2qmR52n+iqF2nmHkbAtbytvZg4fxU79pD+5vwZ3N3hIHdF9c+8jacPaXYaOtpCkbhOtauT7aL/z+zmScLOCaj+0kS7gw0FXZVOmsfRQ/UQ20bcEawwZGO9PhGJdEbl21ZmzWS0BV1aKmMTHdvqpvrndT7m9+hzTYigkmiyS9RdLrTHa/jjrgeXQWlfqcQKfnlkLHK9Pp1yZWOCUevUgIcpcsfj69itRSYbDlG/V5rHzKQMGKFrqI0eSl6GPNYYXxYgPOCx4aa02HGa78+UqvhTM5vs1YJrelYQcdgt45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zT5aBq2yTyYPf4OusyTnyI7mbidNwbqOD6Abvt1218=;
 b=tSb1uUHM2ayPGoxZJb60OmkmgmfW6L2eYR3ddYSlGqb/9iMqZ76uAvcFbO+rKqr+x03v0m2PVvUSHKlOrRVpbVK/y0CZBmv52WLkh5lgxyLH9JlzvdYBIBdXczGxbIOGsePdVcMX3SjbuFsgsvSIxk+jzwjb+PT9kETFjlE/XPJM7vjjzGRe5+2P/0KOlYcSO83HKzv1JZXnf17RQ6F4pWYGAcwyPXWyHNx71bSSkTR8/u0ChlvxTRiRtZP7YXZm7d2m4buZocDRTfJdqjSw3M5dnQYHaH9+UYzhqu8V0O0+ABSllAGs3pcC5Jw5C37lN2k4x4yCblh82UviTumMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zT5aBq2yTyYPf4OusyTnyI7mbidNwbqOD6Abvt1218=;
 b=XyB5fDatrT4PTwLcjI6j+pJn9WwyJ5HbhjloyI9JHRjTFqvL/VxDnx5LaDkUWdm9A+D6yxLANuf6ixV5FzDgASQUCzlSQ75i2sTmUWOUyuTg+aNJ7Jty+Wj0tKB5v1OzL19N+dyTwPLuyiOonKRBsYedH0okQwkpZPa/MAwiRyU=
Received: from BLAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:32b::23)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 07:09:57 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::89) by BLAPR03CA0018.outlook.office365.com
 (2603:10b6:208:32b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 07:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 07:09:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 02:09:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 02:09:56 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Wed, 19 Aug 2026 02:09:53 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v4 0/2] CPM6 Channel Separation Support
Date: Wed, 19 Aug 2026 12:39:45 +0530
Message-ID: <20260819070947.4080389-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS0PR12MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d4b767-d4de-431a-daa8-08defdc0dfff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wdJYNN6tV6KzAJ19A/0wP4MJknGRr4E0++V13u+ocDUU9lWTG4U+TRh6S96i5d7w1ul/vNXptdUbPtZY7REXLAYKU8MBE+dTFZ97RG7dEsZJDVoDNn0jJwkdxatyvZV3W4NTciwxL7/7pziZTv/BV7O17tcRlnwFhSPrAJaLcpSWHvCpprCwd41TOihxCVgCE3Zn+enpTaCWcZ7cyK4vxSXmOxbUREr0Vp+WzNrO0ziVMSdRxQMlY/qNMvSJ99zGFw55rgreFCfypse/dzL4D1w076uGV6sBoqM3yJYiv7DmTSo/tTKfI/cQZZEj2tbLeKu44OXnpR1O9P+3xtKQv3Sxvt6pBx6CoLPQ/NEx9s8DJHsPwi5ICIENVnpWUrdImb595lcIgnu0GG9zecVxeBz8qifpXWH+J3G0F0PbVGZFQjVuBkim6JKAyAIA6KXFnzcRDAJCmMJnKwjRXbw6/bF4Bn9bV2QS/ABq8LAUJdjqee2+nvRGEKPy2/3gfZy2PS1G5N0SVDpfKrLvqCKoqSmlwbW1MIcjjngJ4NJl13aR1nQAWbrUjwistTTfrbLMCHVaj6iiOtFZolsMD3eHfCyiSkAqL/wUXo5ZeBsb/CkmAsBnvBggtGCxREO90qstAHyqpZ98LxZpAWkIiimCqldJ6vzt4UYtZz0S13RfwLIfbMyIO2bL22GnKshq9CR4+oA7lg/PB28++jvkjn8Fng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+aNaNFrnJwQTXL884LbaoFI6iIEED0AV6cVjcimsQTSB5radka74tDKizgMS+G245UYoLOP6RrqvModAaMnSzjZkjBXoFXDpygtV/EGQuKvPK90qHDrcoToX5hgUFp5gB6/s14MzaDddAH+vI/Z9HqeR/bpMP2plJj+Srbf7OzhjAbL+8z9A0YxC3zKLGsznLfuc+t9Kkpkiids+ybtzRpgMinCzYNMnImbpAWCgxF6jj57/WV0UM4tPT/0O4eYc4srEvAVw4+PYw696UeCh63N+Ztnmauqco+ZkSoi2SogGhbb33GYtRmL4bNYh6tNRN1ky98CCKscr2wQ8ejU13flKF1OMpGghi9l/asbTYKdAAC99Uatpst3Odddrj2SoE2V7SvxmwlIDDEQ/YilK5lcM5duIOpndEh/4BPRl/Vc1OYydmmFsBpmutVQoA5HK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 07:09:56.6479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d4b767-d4de-431a-daa8-08defdc0dfff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726

'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.
In order to use the VSEC functionality following changes have
been made:

o Utilize the existing VSEC implementation to retrieve
  the channel separation and translate it to correct size.
o Modify the structs and functions to calculate correct
  DMA channel register base using the channel, direction
  and channel separation selected.

Devendra K Verma (2):
  dmaengine: dw-edma: Enable Chan Separation via VSEC
  dmaengine: dw-edma: Add changes to support Channel Separation

 drivers/dma/dw-edma/dw-edma-pcie.c           | 18 +++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 23 ++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 17 +++++----------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 10 ---------
 drivers/pci/controller/dwc/pcie-designware.c |  1 +
 include/linux/dma/edma.h                     |  1 +
 6 files changed, 40 insertions(+), 30 deletions(-)

-- 
2.43.0

