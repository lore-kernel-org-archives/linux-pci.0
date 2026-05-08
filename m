Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FEC33D515;
	Fri,  8 May 2026 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220610; cv=fail; b=XeIDoazIjkbS0j+5AQzdGc+FtLeeRsb0s+9be2IEV+zvYn3DlBRsDPhN9f7NzgMIULiU3LEZF+TEeK6XBgHjE4T89KnmR/14MMtt9YwFB5k7yhEza2eA3nSjgrmzFczFy93fd8yU6uyECs5qcaiNg9J1HdsIUJRAEuqim1Cif08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220610; c=relaxed/simple;
	bh=Xzffqq58skJ1NK1+QHza5G/k3ydtMwD39bW6QL+20VU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AFcnoNamdtIEPYH+fqSgPFUp/GBNzW6IZaad08VS6TbHlugyBDVAhzYfw1EnHIzLmTu97HmCGiZgvBxs57n8rnoPD/y/1/oz6vgbYIzhV5Il64xsfvhQaxYR5wGaSvgA4eSw3GGNlNF9PCIPJfccOGlI91uVSj7N8SoDpZU96WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IKPWsMMB; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IKPWsMMB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b12tzY3HnSt+RCLpkE/QrwnFKL2OkMR2Psi90qJuSBcIE/Z+kdkAq7LB2/SRTHg7Hfog6Bd3FhELw+BxSLpyIxDitjuuOxU9/BdlMXAohQOvXIN2PMWlx42Aqod6Yr9fOunL2W7mNlXVkGjQ1Pp+Lu019jaUL4CoyEZTSORILXvnX5UT3kD++IzaBcoTq+1SPKTjX8ag5kZMPvvB3YKuWDRGSrFPpHgH2djYTQF0URhSN3muV1jqnaXpQhsA6+6lvQUkCuXhYrSM6VwoweE/LO49qo6LVQNa3oP+IZpsJeGTvOyqA8VRELnHxl2Zn2MLwCofShFk/hpAY0En2OOSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjife0XanYDZglXm0oLTDB4RwhnWbTcXxwgBqQXfrjs=;
 b=UlZodM+KS1N5HlLZ79or9jXzU6vWIxOBHMqZxKOgtXn6Zx+/uS2ri+x1yoU16n/oRfG+vpZUznNppxA1iEYr6ifvCT++RiJB9jLQlJqM/AU2DKoPmF0X1OEHOIQYC2HULWuBnj+2XB2mA+fuqyIbSEExcnyzwbA5jPNoCl/cHl+tnVBDanyxotS2e9NWbOt7+KJ1MHE2GVS7BDLmwvLVEu6f+aDZ3kFFEC5uFm/701YOb3EdiKzKMaqWtUBqczcTYMVN6o0chnlEEJCm9trkxgU53cjNAxVOBiDR+nAH0m0edxplsWuHFymGCp0xW4tb0N+chp/SUO9VBAMogam0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=cixtech.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjife0XanYDZglXm0oLTDB4RwhnWbTcXxwgBqQXfrjs=;
 b=IKPWsMMBNcPEfBryiW3lS+TGupaRgsP/8XZFHWYfgD2UZ3EE9yuKTVc7LSsw4XgwfewlxEthOyWSVAgK7UPEvCS992GTjZrjcQI5QnBPxGfDvnN+GJeo70B6tCEGNakKS8+9f4h/NXKaKIByUZtG4L0DtMlp/slVrxUpOvWV43Y=
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by BY5PR10MB4354.namprd10.prod.outlook.com (2603:10b6:a03:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:09:58 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::9d) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 06:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:09:57 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 01:09:55 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 01:09:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 8 May 2026 01:09:55 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64869qwd764459;
	Fri, 8 May 2026 01:09:52 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<hans.zhang@cixtech.com>, <vigneshr@ti.com>, <danishanwar@ti.com>,
	<a-garg7@ti.com>
Subject: [PATCH] MAINTAINERS: Add Aksh Garg as PCI CADENCE reviewer
Date: Fri, 8 May 2026 11:39:51 +0530
Message-ID: <20260508060951.840233-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BY5PR10MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: efbb3632-3f8f-47d1-8807-08deacc86e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tIBve/wY3qCr9XICUimYZbGSxzS3kCy3S1vOckzqJXjHE6nf/k15TYqFLvQMq9eUNjK7dPF6QySWKy6hHSGT454xEk254OSlFz1vJ1LihUdTHXngmMClnb2+lfu7NZlWq20rlY+JSJFJ4DuQiRcI8LgTTfGqzflgXg91AKTZNWd4uns32uR7JUEspgRKM7jMjel71iy2eatsiaRd9Idp6BFrsvVzOz8sIS9IQij6hKISJI5/Re9828EPceXaUF0cNNSHUljqkM+sOnbDl2sT+fQLsa9o+XTn0KLrk4eXCLcFO6qKe5yibMs+fE7P0XYG0NlEUWkj2ALEVGWVnky3KFFRh9ExErdk/vJwUVUaUo+yHzPCVAKJdqgcGzuiTIMWfQOQbAOxjZa/0VAI/+oXgayj+y5Gf8Ib2fJVRrfYTy2fXFQdq9ODWgQPtUdCvibzUlhAyzXqzUJsZ4HQ0mhDhxu3Sso3cbgkvJFD+zl5lXDNf5uA56eYGSUlezlHcemTsHYubtwuI+GaI/cGhBAVecDnCYBZkZ+IyAV26d+ZmmYYXxQ65tiE8HBAsUFlNm0RDna2NX8Awz5ilgSPfucpUOeMPc3E0FJyLu8+34mpqaHLbDEI50XSYzahWUu/9gfj7gOEOHpIrTlPDe3Caboj9B6uK1G8zjmhER6UGIaOykLM43vaoM/xK9D4ZtYnfEY6P0yNVMOtOQToUp3+9SZDf3G6xw+PvtAnKTyvyOZMmos=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YJ2j15RJSaPJQoKF0bYJ3YXoIiSaFIoLNJETF2WGkkfdqqT7rSkg89AkT0KnK1I7+m+fpRKBbDiwvrM4lAmBoRLOUWkjA7eWAFYwBBGIAuPmHogvara3VG5GaJaKHC+Nc1QmJEYr7gFUj4MJlk0T2I3xUcuNNDeSFLnR2Ytf0KZNwfBUkkXyF4xuAlvmlyLDcgHc68B8UyHBquZZYLGS2hD0JJgmnYjl6TC+uk9kiDIeeBneNKAAyCC20NfSvJgLWC3kqBmU7E3B/y2aOp09JT3w1YSA0L2rudS1Tihir0xHRoYP1iJ/XskTLkxsTYEYswRsAsOo/KruKA1drY1ibYW6wAh6M/yGMMwb5DeyQeVzFCDZ5P6DY/0YvzA2W6N7XycFLkK7kpPcFVytT3X0PUMatLiB00y6UroXmVIyT5PQAzgXRqQV6JnrB0XY8jWr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:09:57.6301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efbb3632-3f8f-47d1-8807-08deacc86e50
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4354

I wish to contribute to the review process for Cadence PCIe IP drivers,
hence add myself as a reviewer.

Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..e2c188a358ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20315,10 +20315,11 @@ F:	Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-armada8k.c
 
 PCI DRIVER FOR CADENCE PCIE IP
+R:	Aksh Garg <a-garg7@ti.com>
 L:	linux-pci@vger.kernel.org
 S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*
-F:	drivers/pci/controller/cadence/*cadence*
+F:	drivers/pci/controller/cadence/
 
 PCI DRIVER FOR CIX Sky1
 M:	Hans Zhang <hans.zhang@cixtech.com>
-- 
2.34.1

