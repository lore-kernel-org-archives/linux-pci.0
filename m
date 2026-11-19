Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795082847;
	b=K72T1o0OtTxMmSaD/3lsWMhtQuqWdXxMbMAdWfPYQtvqr49GIeO6K7mBUstph4si9Mjn
	 co9xpegDUNcLGN48Pq94iH9kpQ5tASrDbM7GkIrKg0V1dI8D6zHofn4vWd9aC/3f2HFB2
	 QCDLyRZvveAexre9Sz8D18ZnZlhRd/8dwepqbab6UN1phiQRr8kCFtpfXBUhsg3uZvixq
	 Lm2rmi+hipOMPf22rirGw1mwJQ0HWyrQcDEK04HKdNo4CxLN7+kPrb1ryeXuEI4b6DdWd
	 J65TBufzJrxpvO+qFkveI3slQcg03XWWhoz0Wer2WaosA+zF65Tj+EJ7BYKTsGTRwEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082847;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wlv0ZPIQyDqEFSUjYhPoX3hZ9v5K2PeikUavZRZ7Kh4=;
	b=kTHHE29j0umls4ROG0zPoiwYf31a9qrrbYm7F796Q5uX5I18MWiCIu6iX/ZcHuRtS8IX
	 MgOzm49/V9QrB+DQM3mEan40d1wWH2HS16vKVU0XMkauwV/vZIvphaz+yeMaa1jTn3Z3o
	 JUyPN0TcmzojDGHm+SmrLLU5BDOozMdd2Xjvsvx0+J3A6zw6n3rkdgCZ9RyKab62rkPVy
	 2/BYdWmpynnDnSmSr9LyFAblULHYpzt6R4y4w46nqoq3N/R9LKw4CQaaQAYITI7RHyje/
	 trN9caQAuZrSXUmVByGhUvjTaBzzaUdilmQwCndhT/5D30GNQSZUSoxvbLC0ac3Ud9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YBLg3gRY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C26606A320;
	Thu, 19 Nov 2026 10:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C26606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YBLg3gRY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyC6cMm7Fg5lf7VsI74awJ1fczf16VDCde0RB9IeFJFgaH+fSeO9HquzAu6zZxP2wXNyulhGEimcQh8fvGxGwP4091zW21r2C9BS/GYn/qutdt9gP1Rf26D+2q4o63pxNK5h48mE3XRVgOqktDyRM9uOS2FkKfOCE9K7mW65hcH0BXd3jYcubgCHi5g15nSj2zmgcB2oZTCWzoMwvAZanF+FGI67isrCRJCG7FmqxWaJL4i523U9XAJG0fxkPR68uQhaO9tAestJwXhUTExulSM0LS62wfcN78n3RlxjGsmDW/Z9lZQYtcxzaTrQrTBxsOgY2NKdEcRpTBzD6QviLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlv0ZPIQyDqEFSUjYhPoX3hZ9v5K2PeikUavZRZ7Kh4=;
 b=hXGpmS9Q2dwhBgCYtI8BqwXVZJBRaSIfxfsWksG7vCPo6//15VVrNRhIsdwlqlV2f9uePMwFSuBli0qGgHC3a7y7qi0yVsTIFRJVj4eDhaUiMCyhU94FBdY7dPOlXvO6tixsN2p416Pc1mAq1OrYkJJB8RRuCxD/3oXrGHdZ2KXN0fg0MqLlnIFz3ixGQurpb98Dj3qdR/DSyVZl5EoURmkPNCIEhmRwatUb4FrHjkN1H7ZzHV6Euv1jSNQcI9kIrIjco6aJBbUR8hA1Egse0r+rSzr5Px9zI1ymmH6xAH9Ch3PkEdtDaLpzs9383I1eFHqkOil06mGMbAfoioMfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlv0ZPIQyDqEFSUjYhPoX3hZ9v5K2PeikUavZRZ7Kh4=;
 b=YBLg3gRYtc9EZdJD91LiKA8yZhueh7m1dCQmzf4GPGDeGe9yxXbnTfZlhg1cfmPgFoLpnNFu7ajA7vFdRPBFyR5n+CW+kU1Qv71iRCI5/caZqnrLqxEZA+26JGGDu/iP3dSxzt28tYphmbhmMOEPRFA99UT3q1mffrdHsEjJ13MKO9ajCufR2U7YWFw10tynnJvjSQv5HnaeZboVplwZpSr9zcK9ZeAWofRtMc4SBb9j+1mECDF5k6dMyJCromF46CpUWUqaNm1PxC+GRCK+WMNxETl4tHeVevYYTcbtYJrOoiHxiUSzQXw+TCLXSeoebgBHbC2n0IUA2Zwg2fwN0w==
Received: from CY5PR14CA0004.namprd14.prod.outlook.com (2603:10b6:930:2::35)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 10:07:21 +0000
Received: from CY5PEPF00000E88.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::32) by CY5PR14CA0004.outlook.office365.com
 (2603:10b6:930:2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 10:07:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY5PEPF00000E88.mail.protection.outlook.com (10.167.247.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:07:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:07:07 -0800
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 02:07:01 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Joerg Roedel <joerg.roedel@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, "Nicolin Chen" <nicolinc@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
CC: <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
	<kumarahul@nvidia.com>, <sagar.tv@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH V1 1/4] PCI/CXL: Don't offer 'cxl_bus' reset where a bus reset can't work
Date: Thu, 19 Nov 2026 15:36:25 +0530
Message-ID: <20261119100628.1948990-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119100628.1948990-1-vidyas@nvidia.com>
References: <20261119100628.1948990-1-vidyas@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E88:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 649871e8-71ca-46ee-95cb-08df4624e6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|23010399003|22082099003|18002099003|6133799003|261009223027099003|261021123027099003|5023799004|261021121427099003|56012099006|11063799006|261028144727099003|261102123227099003|261026121527099003|261022075727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ljT1mmsuqHr3ghOqTKHBOrk/mdG9LEnYBOX9icqwV6aoP3PktZpLDhL/LXQaO2zlNmG5DFUzguh3UKDOsjwdF3o8l1WwIAmQ/XDa0NOshvuzTw8G6kxueow4eppjY7rvzT/O8Nbswt+0+6znLoae3ZH7h+RKpLw5Oyc4cWnPsaicvAuJeTtRAV0roJUkBfVUy/ao72LWi/52eL+pd/6MtmujuGGrYJg7owKF5OGaj34llyVSV0uF+FzMALTq+trqKPa/Wcx1sRK735HxGeEdR09/h792yI7ClGqHu2/dkr1CViOqYcdtlckWfXYawv1EAluaj+qe84SKrDWE6Pv+KyFw37GWlX834VjJZYd38A5xfJp2s+wnSdlTFrwt9wTKXK4jzf5hGQIcnRzrMITb30LXTv5En9tOSwfHCPaeltEf40AsVcVsALVplkS5rr1D24PHrs7qYhebCWoNSNIKSH64ZNZa7HaVXKw1wSjiGXYRSW6fvgl7Oq3SYENXTzpvnVi4js3KMUyia5R/aP6IE2Xno8xX5tmex7Zg92kFT+Cq0ZpPP81smtgwU9othmm0zCqZmiGUealRk32nnpgXAgzjoJraOvtBiLHuGKS2aQxnWNyLK0XvoFhB2SZ2kkm3xovpanK0Thm3vkKGbiTAmhJdnWUEhaFTImxGpf3uL0vUUKO1iDdNDllUlPvyfu8jgJB07DJxBI2XrvR57nMalQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(261021123027099003)(5023799004)(261021121427099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+y3Gqut0X3YBpYvEagi7Xl8s8gbZm11TAZ0ubyyum2TNU0ZuH3L7ZFrB8VXXhW+X6oTeGCitoS/4oXPprCEPNKtOIRtKw4PAg/eB9HE6kVpLVVBmM2VVy7PxYSje8YOvbd7v5ZXf64ucM5t0Q4Qprd//I5xymb+PRRYOdYISR8vC3HcRTngqS2qvJjbTV5O0L6IgF9/WsaMiVj4VhH2kq7AHFj00dSU+bTcWz0yFxEJ5xdWNeyngYF8K+IK6yZpqzXzutnEyPbuSai98dFU9yOibQd1BwA4OMComaAZRwCX5W+yzvrZXFAQgyBl04Vq/jdr0nzQ+Xczz7A5rL5sghzxw1oQW6YzCtf799PSk2U4uNW032H7iH3a6P9dcUoa20HOWVAiiFt174kOc+iH62wKeAch7Twt9j1nBFggYpcLNEf3/MnYloR+UN1HJfzAV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:07:21.6637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649871e8-71ca-46ee-95cb-08df4624e6f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E88.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802

cxl_reset_bus_function() reports the "cxl_bus" reset method as supported
whenever the device's upstream bridge has a CXL Port DVSEC.  The reset
itself goes through pci_reset_bus_function(), which can only reset the
device through a hotplug slot or a Secondary Bus Reset of the parent
bridge.  It returns -ENOTTY when neither is possible, e.g., when other
functions share the device's bus, when the device is a bridge, or when it
has PCI_DEV_FLAGS_NO_BUS_RESET.

"cxl_bus" is then listed in "reset_method" but always fails.  For example,
on function 1 of a 4-function ConnectX-8 below a CXL-capable Root Port
without a hotplug slot, "bus" is correctly not offered, but "cxl_bus" is:

  # cat /sys/bus/pci/devices/0001:01:00.1/reset_method
  flr cxl_bus
  # echo cxl_bus > /sys/bus/pci/devices/0001:01:00.1/reset_method
  # echo 1 > /sys/bus/pci/devices/0001:01:00.1/reset
  bash: echo: write error: Inappropriate ioctl for device

Each attempt still temporarily sets "Unmask SBR" in the Root Port and runs
the IOMMU reset prepare/done hooks, although no reset happens.

Move the slot and parent bus reset from pci_reset_bus_function() into a
new __pci_reset_bus_function() and use it for the "cxl_bus" probe.  The
probe now makes the same slot and parent-bus checks as the "bus" probe.
"cxl_bus" is then offered under the same conditions as "bus", except for
the CXL SBR mask that "cxl_bus" exists to clear.

Fixes: 53c49b6e6dd2 ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..921d076c4c1d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5030,6 +5030,21 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	return true;
 }
 
+/*
+ * Reset "dev" through its hotplug slot or, failing that, a Secondary Bus
+ * Reset of its parent bridge.  Callers deal with CXL SBR masking.
+ */
+static int __pci_reset_bus_function(struct pci_dev *dev, bool probe)
+{
+	int rc;
+
+	rc = pci_dev_reset_slot_function(dev, probe);
+	if (rc != -ENOTTY)
+		return rc;
+
+	return pci_parent_bus_reset(dev, probe);
+}
+
 static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
@@ -5048,12 +5063,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 		return rc;
 	}
 
-	rc = pci_dev_reset_slot_function(dev, probe);
-	if (rc != -ENOTTY)
-		goto done;
+	rc = __pci_reset_bus_function(dev, probe);
 
-	rc = pci_parent_bus_reset(dev, probe);
-done:
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
@@ -5072,8 +5083,12 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
+	/*
+	 * Unmasking SBR only helps if a slot or bus reset can reach "dev" at
+	 * all, e.g., not when other functions share its bus.
+	 */
 	if (probe)
-		return 0;
+		return __pci_reset_bus_function(dev, probe);
 
 	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
 	if (rc)
-- 
2.43.0

