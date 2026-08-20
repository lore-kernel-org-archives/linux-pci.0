Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6403E16A5;
	Thu, 20 Aug 2026 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217040; cv=fail; b=Ly4XSwqWzMly8uUYhYL7PYgf5ydCQz8PqGpLmfqTWmwzmifzCLUuRe0s0mi2+mGxih0Zq8Wtsk+XXpgZZeqPM0T3uZh99hBunvMwCWjlUWzFfBkdHa6RHfRQNmidl3hKuXVZVBxcLqUgSgikY57/3R9MHlLfHqCv0iK0xhTS1jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217040; c=relaxed/simple;
	bh=HM9TrhCCjLdljc4DIQjiDNqadIFTGnr8GsOQuL7n1mE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NG19ELEGltGIGZsenH09cb9W+zHRwshMGFpcSOIfHYyz1Y00M+smTPQTezvOU6eP4u9opvWuBHMpCQ70+3y31GwXh4yVwOgdGSoix/zE/WMhoHC0tZh089pwNi/jhsndlgQu5+QBS1FIlvYzYvAd/u7A0O40i3ENOlhW+5nQnCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FnxdfBMZ; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FnxdfBMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1Z/h7Lxjgkhv0/1zNazHI205CX6YpzJYYwF7Rvp5QLg0k6EWDPsneqKFdr20Lp1ToX78MqQ1uSs0p/tSHaVTBGE/30nxqJ3hFtBdx7XPEvrvy0Cv6DlthJCbwfD9v3U1ita3xUraQnYZGxPyX3EVP3xzqNQnU9Wg9G09aMJzcsScTmfkmO5aE9xrbKj2Ilih7k8IXWGWzav6H6i4CqwU4hMZKmYDok+Zq+ouv/hSP9fXXD/O7SL9om5D+T7NV7A5osZ5/gHu40qi4974mEK3NZtnsGP8uSflG5llEekQsrmQAN6KA0KI1PtCoTMSS6PVASOyaEivzE8g6aRF9sUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zT5aBq2yTyYPf4OusyTnyI7mbidNwbqOD6Abvt1218=;
 b=SkYIn08Y5/786s6Pb/V2ByRTXoTmbHgxoDpjTF1nTPZkM6zXcsvywAJ+q8kzcbJlZggk1HYsP7MTkVIQqgY7fpa0h60/l26iSOqXQl1Hheln4aCwqtUg2H9rWdnwPphauDwblewvsx5WG5wx9KdCOsAquzAOM5v7Rp/J7l4HnJ7s8xLUBxoxxhYVHRPpVyp7T36lkX01SR+Bk8WZIM5cxmJ+LGvAwdX1EKP7n9rphUZ0yqC5R+G8y1tXQUsSOCuR47hXXOp+TLMPipjgKBrf9IXZo2CO/rronR9gZgfFPscCfQoP9KSx2WalSMLiJiiD69uqWxmrS1I9fSN65jsG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zT5aBq2yTyYPf4OusyTnyI7mbidNwbqOD6Abvt1218=;
 b=FnxdfBMZFE+9+qKl5uo79jkHaAKQYstDeLFLpJJ9mLfBwdayrpj7vWAa8/rqTtiYT2Ci70tqckTHAnxgrfgmHm0QgM/m6WnmN01OxXDKgheRq0Zhla9uBzrfd+rjRdWb4WNRXj9wX5GeSvmQzp9W/jW+Q5+hn0/ttWCuwnRDtn8=
Received: from SJ0PR13CA0175.namprd13.prod.outlook.com (2603:10b6:a03:2c7::30)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:10:35 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::7d) by SJ0PR13CA0175.outlook.office365.com
 (2603:10b6:a03:2c7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Thu, 20
 Aug 2026 09:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 09:10:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:10:34 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Thu, 20 Aug 2026 04:10:31 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v5 0/2] CPM6 Channel Separation Support
Date: Thu, 20 Aug 2026 14:40:23 +0530
Message-ID: <20260820091025.683506-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: db6c5ba0-43ee-4049-a0ca-08defe9ae4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DUQXYv88mTKWoEeOv5It5xWntKg0BWVjc39pAxKBHHPk8o1Amw0of64lJw8guTZQJCqM8euHnJtKsCCCUqCPpjaRK2v6F0DF4Ys4/0jdatCo4IljiIikMqi9eT737Ry3rh95gnh8gnu3lcajZNBaV0KwDO0ZFusmjiR+llYXwGdEJ2TBxNn+c6lV7gS8KX4YhMz1op3KZq2c/YuVYi8+V1iejgtu5TmAHqzOobKvhqelGNumDe4iLG2PT+wE8ZXvT0JTU4CmU2ekiEyLuATX/msUtiXLRj+QYzkd2y1oNHJQsP9aWiWhfL+jFltbjaeSdYUc8M56jLZQXcetj5pi9MPcr697s16g2aiyxNTXVB/FDsN6IqmJqJveskJfkiN29x/TkSpkyW9Sk/qhvOaSeOLyGxlUCOi40GMSu7NNVGwhrt3as1sAlSFErgmFG6B9vUefKXVTXsrbE/zXR9+Ppnrg7zUiPxxnQyjKJCM0dIli9Zj6NGz5vD9ugWk/ZLmPExqgSfT3yLCvIKt+gH1I1nGTPH4WOKdrsPZM1cb1znyXJEfVZH4LRL9v6Ol0kfCnIsAuXCRF4Fa0CD9RTvS8Pp3tBd/17P0+ANSo77xdCp9tKyOH/odpSmRDavwLNBMLWGvvEV33Ydxp7bBSht8/+73yIT3NcX/B9XXqzHoEN1sMOkT44Qg/1nymCRh4YMVxxTMzZG57e2tgru503koc7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wb9SpUN795zA7uPv0FkwqGoJCDf9zqJztMDHxWjAfs131sVir+qehcOfl9U3iovR8IeooCPgbkUeEzaUOla/epdxpOsl5Dr7qZPa5xTu+BfTw1NE8poyO5DUmhh3j1F01zO8ltr1cLq6oThovX3soElkyub8Wd59aazDq65SEFajjrqAoQOIihl5zvvQraX7gUEAd2pHp2BeMjTdT9Kt/Wd0uyqmQCNsA1oxga07tSN/QIV9zJ9B5vBZQ2acFX1WwabbX64u+sKFYzSIS4xEgQCyyOG/kxDLt34GMpukCbXWdu4hQLNK+s9wlDHV9KkKmTMFT+nFuZFiyyb+hox7A6XS3Z+IW0uJ+KJQ/+mQUwUgOssLVJ4wQjtxS6MroQHUWnX5mHTxBXHq9NZ5D1ejnYxyJBE5wPKNt+DssUCkOQlZPKKb7QHPKmEvM6tRD1tT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:10:34.7938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6c5ba0-43ee-4049-a0ca-08defe9ae4b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

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

