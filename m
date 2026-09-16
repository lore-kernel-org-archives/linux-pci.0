Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24803B8D4F;
	Wed, 16 Sep 2026 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535458; cv=fail; b=HYtRmKmbeZStrZnWV+PLKxfczcs8JVZ8egkfS2zj71LcDaBaQTjvLRIRjG60ieFew/d8Cb5pclW1H0LiAjcT7aNIdctk5sarZBJa+RX3Zq8kkJY3EAmXMW288NBvbqyhTni4H9jDtBW6fLndf1ejH03uH+DJQsr9wxTiwGQ6eGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535458; c=relaxed/simple;
	bh=KzTQnDGH5lll0PgOVRcBoXJvv4pXo7mcEz8dxYbV+B0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qf95vcTBlSzbkb+AKlF21pQhzeGomXGLRgfirV86qLky2Mrmj0BWaybUC6IYtXF8eTyjosJ5gFYuYEADwqYgruq7GAYr10N1rY/FLNXgRX5smxWUt5dyclM4lZwSNBAPN0gPDNrGzVv/MuOAaL9z9d5YNwHEK7nhwLHob7aDaCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gt45fgy0; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gt45fgy0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPkUrWgP0eyNWrCuLNvr94B8LIX21IPPP68etL2Oi+nwcwU+zurlw0Ij1Fnu1dKHX186KI0ywcUVbHY/8m4ZZcB3DZDEFLzhFC3sd2pJMjLbg0eAbVfBsdX7byTID45eOS4YrUho2nd3v2nPCqocR/hDz7LOOm+la+razOWV4Bil4VVRO2gU9XjKMSNr4LxnGqXI5uu4fno9xqfp3HDHMRYuDvuTwP60s61tTn1uIHi7eN/a3o7Zu4CnJ7wPPGYAwwxXOm4yodPlB0KXEKKOX1LitObAwZdI2RpOerJGcae1o4fYxgwEcrLx0gVbm9ytLwVjLBeXC/Id7tQJJsd/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLFk6Z6SoOEAm7Zil6lvrZt+kUqESv6mhwVUrEs13/4=;
 b=XrTt6ifyVvex7byVD2xF8roVFwlixkCqs4Ihkv1q3TrJr4NdtQsVXZcHmOcSlTvV1C2SWJRigCtxYs1m9TvjYzxScGtrPBWageY+OSlBAgjnWsokO88aIKK5cI+FDCa9pfAAFrRY/ge0CxO/t/1Olb28oMZ++DgIU4nFuWGKCJdbHLbIHs+H2b5pEVNTmIBihBGskDBg2KZlXNH2x+OmPuJcM4zU/vjrPX2yjU9DoAt6PUtIEznvemNbwV5kKv+4Lwm1E+L7VLgFKbmh2Mtv2WnZIGkH4c7lR7dp6gH0kvGM6DwyW7m2CF9vNtaHgpocdDz4cm2CmfjRiYErkU+ueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLFk6Z6SoOEAm7Zil6lvrZt+kUqESv6mhwVUrEs13/4=;
 b=Gt45fgy0aAWeUqjiq5tdIdmmc4wVnw7rCoU8AquwmdjnfC1vMAw00VT2ctBhMEYPEaX2cQbv8NVQlzlpHftUvrnIypxYcsl7uD1jO9WYX87PHhemAWD+Fys7L2AvQ/81582/GO9Lu4NXq86szlJBdjvqdwHPDe/BlFLh43I47mo=
Received: from BN0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:408:ec::20)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 05:10:51 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::8) by BN0PR04CA0105.outlook.office365.com
 (2603:10b6:408:ec::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 05:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:10:51 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 00:10:50 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v4 0/2] Unfiy PCI suspend and hibernate paths
Date: Wed, 16 Sep 2026 00:10:32 -0500
Message-ID: <20260916051034.180226-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5fc5b2-d495-418b-3eee-08df13b0e085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	l698veE18tGK0UuJLouXOZ6xW7f7iTt0YntUW6k/bhtVJvEbIcmfgZMDpnFq1yvCkkuiLdi+MnLvYImNXAFZekT2C8ghg+Vi25/mRQGNAuiHXRpYLRZp+AeKbNnhNk5vShUYmqg7jMt3CA0LMyjQaDFV0XJpexaT8luJ2PTIo4CNvLn9qsEhwCO4M54aH7GVd6KNyma2OevyQHpHKHj6nKicAiv2iDlvPt2RFfMr3uCK4BGTRCgd56LLF5U91OehfbW4Bj213in4o8xJgsy+u7wxAAT7mlscO7+WfNabLxENBvmqgbq4VmquaNR3dR5utZWCIGiDgSwMpwRccY/S2zGlcsbcRM4IeVoFUh0swXxeGQMDnkxPCShXacZ8wRbE1v3fi0qzZUuvk1V1Am+XeNvHMV3x6Igc1CiMurgpxwnEupw+CDOTnlYdUTVRgs8++VHPaIeopFmtZ8XLgLOEnBkFThd8IJpxmKWtYPQXzsQdnGrHnj8o0QIslb0D005rzkWF2QKlMBil9hlNuzjy+8SpqQ0LFbdK28HvHEoXvDpcwxIRpslJuq2m+XkW6DvZgxfvvI5DaPAK4UsTKR0DIUkt9w02jY0xilN+6WcK/4t2KpQCDp3pzXWPxThR4yq3xb/Bdgb0s+2eWw1h+HOTOk3uq/AgEXQa7j8jBRWvTUmpbCObTm3GOrFOShUMOXny83rEGsADh0lmlcJVOQe8sQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n8h6oP2kbvXlKbY2ooZXn77Vayuye8+pyqwkRhI+Vzm21Zct1zFBK4n7EuBGUD0SbTeSIo6HNjSMWqigcQJ764Waz0wK8iaEgDdlCp/94Tt7QaTNZzB54N4iQCAsC2sSVQZ5CyZ+ec9tjw2xlcC9JKX2hnuJwPe5Y/9prFxvOShX7YBzl/7enG8ZDpG+K5WI3rpLnWUCGlYblxqhJZGwJgGr59IISlVKuBig8MLYf5phUcn4cft/qXmskqc3/yv9WNRLYAacFLQQ/xuhkRe1fvT/8q+rSqCo4M9EEfbM7hePggz4GGzy68t+Yr3YyX0AADBCWtVoY+xSDu4Q1aJga2pdJZlsZ9mt3QTJVlDzeyHZC5mHFBgRsT5FS2zlOTf53dQb6hPBjPAh1zkizzFR3yCOGVwy77UU0p/t4e2ZTfmPA45vNqXWvWlmAXkoHNW/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:10:51.1473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5fc5b2-d495-418b-3eee-08df13b0e085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513

Many cycles ago I sent out a kernel series for using the S4 paths when
the system goes to S5.  Some parts of it got merged, and Rafael suggested
to split the other parts into smaller pieces across multiple kernel cycles
to make bisecting easier.

This series attempts to unify the PCI suspend and hibernate paths so that
PCIe bridges with downstream devices are put into D3 at hibernate the same
way they already are at S3 suspend.  I have been carrying it, rebasing it
and personally using it for a while now.

v4:
 - Change pci_pm_suspend_noirq_common() to bool (Rafael)
 - Drop patch 2/3 from v3, mostly dead code (Sashiko)
 - Rework patch 3/3 from v3 (Sashiko)

Mario Limonciello (AMD) (2):
  PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
  PCI: Put PCIe bridges with downstream devices into D3 at hibernate

 drivers/pci/pci-driver.c | 86 ++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 30 deletions(-)

-- 
2.43.0

