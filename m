Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E3189F43;
	Fri, 29 May 2026 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053188; cv=fail; b=U+t45C8HvjoI86dTYFIskCABcdbD3VjjzyA7SYc0UZMuaCCm8yU0DgssfALPWe+okexNJhddODSYzf6rv+NQ84FKhWanVqOLo1WLUKgLh9zmKRXPLXQOKcJuBDHQ/B3N7iJ+3YPUsovvOR6FVNa+kqKAy1JNY/XthT27jxJ4SCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053188; c=relaxed/simple;
	bh=Kd7Txki9MAJryprTjGqXRc0Npo47OQtEEqYHwtkqGQI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=egq4Ou0h+4yG9nszs0zPHot0MFOhauaAnQjq+HSVeHmxjj8KT11mHPeQ0kUBm0NlkeLwDagDegWCOJCyJLY+9oPOpQWWeUWyZ3kF1jFDtZICQ/d4cSMswn5lJi74mljdV7qMNqJrrudVKsPlUPv10E6Jk0pFPjchuPPMf+85MoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MRceK2F0; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MRceK2F0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzZ5yrN65ihd+Xn91OOZtW32GF2926o3LWQt5TveEKodcgfWi7DzPbJnEerdWPm5g9jKLuYGvrptYr5rfiy5iXA8cD1PbusAVom62MXeNKiF2gZR2CHEEuTBt83M/si3LdvXyWDA5fHPsUuNfWTByx8ctxhQMYS6H7FhWyG71sCsmkBb9OHZTh+n64FhAmK4VPVNOwDAD0hJIs6KwZ9KKperL1FPYTQEv67Ant4L5OmzFGSkJY31Tqjle3K9gFD7SoKvKSA2MmYznXvN7b6R161+OlEQGzCEzKpE8yGJgo/OZjgWXjJSzrGsGOxzm47sRTzHgaiLWg9xAuU/DK34gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgubU28gNXQfQQjQTTvTChaiAYM3Jj4qTnpu2ApHc5Q=;
 b=KrfPVxzkGUdqQYs6UdTfcxTaiymCPJZdDeBg2PWhcOAwCAB2hDFlRIbzmiTWRD+IOhQfBpl1rbXHq52T+uh5E9N0ULAwmT1GTVMBrAm3oVPDtSTJZzXnfYUNSWEnlU1ufg8IkmfoXyzyPZhwX4AEZ1gTScyMyBe/7cBVJmjB+G3pO9+rij6oU8kGB+UENcT8jfGly5PGRXCBXrUh5q4lrY0loaO3A11SFVEyyyxwvuq+Z5GKEQX2wum591jvHyVysA0XNPzD4df5Fup99M0QvfmCi5kg2JXGzyjQw6x4st3dOrQr5iW/xwfclGT1Wh9M5RQyW0uZc8A3wTTS4zj3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgubU28gNXQfQQjQTTvTChaiAYM3Jj4qTnpu2ApHc5Q=;
 b=MRceK2F0uSCRm7CxdEL0qaSRJsjl84yFpA9awnxCLb9+3+JgnHa09gwkb3TPjEgW+P0tJEwojVEC+rSHLGfAXVwryJsaJAuK2xKtl8qAtoTZsAN6v1W1WJLlsmWdZajq2yRNRfnR2F1FdWFQF2gONXKXGNEowOro4UfW4MBPdcU=
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 CY3PR12MB9579.namprd12.prod.outlook.com (2603:10b6:930:10a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Fri, 29 May 2026 11:13:00 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::29) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 11:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 11:12:59 +0000
Received: from dcsm-trdripper1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 06:12:57 -0500
From: Muralidhara M K <muralidhara.mk@amd.com>
To: <linux@roeck-us.net>, <clemens@ladisch.de>, <bhelgaas@google.com>,
	<bp@alien8.de>
CC: <linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2] hwmon: (k10temp) Add thermal support for AMD 1Ah Family Models 80h-8Fh
Date: Fri, 29 May 2026 16:42:42 +0530
Message-ID: <20260529111242.2748206-1-muralidhara.mk@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY3PR12MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc4962b-7a17-4bf9-7e9e-08debd733e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	DQQMZvahaeqdtFSbZG2kga1D7huQfVjk+eaeHJJjbeioWswXdpRku3+gyAK+ebHuPgQQZlARzUk6jPIv+9NhJnR/dRzxVxNLPfUCu40nnItqJDgTnnEklZ1dYDRPxHL6/9fDXdmWlnkL7usp8BQBLbd4srEGyi7ozgPHfONt8ylPXw4tYtiv+Np/QL88r+zYhZJBPjrD5oD4frLj5m9A153qT/qp1cvVH8ZXogM5bjC1Z2zFbfMuGpGUgqsojO9uUg7sIKAD4Je9cJij07lQlroARhdM31ZzQN5lFer/Qu69vyU5G6sGJRnkZq6qBg3zxnDkKSvWo6PUIQh2hQCqDg5xeWnlt+ImW6Z9Yy3PbGlLjxDC+02AF+TeCaVwgTEWSnckcKDQnw4UMDXpKTdnXq2WRbTh+lmcpB0ewJGsrdXEa/J1VV+aWFfX7YpFoAx35l2TTwQokUUNBg9U4ZcfApgGcbw7yJ9bYKDSPxZ2sFAXP5on6+YC9xcDIcMvrySdMRWbfmuG9DP5Se2KGLJPveyX/HMWYsSOGlvT1zg8jGufdM80q0o+21w2WvLS5kou6tC4Qys3VX7Cqq+GBWAuYRUVgDCijrXbGc0bG4ifIVt7F69BFaQNBU5i/ADgHe4tTdKTGpeIqs1csHG0SMI90mwsy4Myr3FD7xdOwdcv37fuovBeCka7k3P+Qe1mhbiOqrKCeqPlpN8kL5ZmvC0+0hvTBlFDX6lyy1Fzdd72QjA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g+Lt0A2BbNvWgAazCEFpgXtKYLCD4W0VjrWnO1w4WSfPd5+1XIwfebhy9gQ/gJ+9jzQ5OHjKJplbNK+YWj6SNGd24tMCKosDJO5GGaQM8usS6kyLLz9j7A/xE3GHcuTEXnnS+IJCb0jrxh3z/c3CbyZhSbeVnfu4eYTiDQ/+2yNq+oSO2nQ5gq7j72erT0Tq/LSgcYZq4rNp4adyNe6OMgq3JeqDLI/mCOnfAWEkVC+e+dxJvKrkfvryQZf7dJsgQ2x7nBoi+TxEm7JIFffwF2Qso/RAGSkb2L+dWmp1GaHiE+bVuxtMOxY9jzcTGsatZxR86OE+cXMndNQ3kEck0dxObrFS3/WPkAb93IgKH4G/Mi4/WR3ih1baRON1h2SN7iJddClyxT1jOA/xoyN72wmcDwfvhqb6bqTIlWB2vl1pYuaSPsIUaQYdF+QWB6nS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 11:12:59.7112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc4962b-7a17-4bf9-7e9e-08debd733e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9579

Add the new PCI Device ID for AMD 1Ah Family 80h-8Fh Models and wire
it into the k10temp PCI device table so that thermal monitoring works
out of the box on these processors.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/hwmon/k10temp.c | 1 +
 include/linux/pci_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index a5d8f45b7881..8e8614cdfcda 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -568,6 +568,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 24cb42f66e4b..3301224c5845 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -585,6 +585,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
+#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3 0x1243
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
-- 
2.34.1

