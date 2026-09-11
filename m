Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F839061C;
	Fri, 11 Sep 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134225; cv=fail; b=jmWxUexvRg87MZI66t+ILyIyivYoN+qtBT/+8B3Jbh1DsSG+/oUOdrQE+xzykIXp/qELKz72E4pHv14QLxm2m0D/LKAJxcYkzhoGmRtxdvOSdaFHfPVpR2dPAZF4O8uJEilYH4N8w9SBv145B4P9ebyC24Pq/mfFKKlhROvWweI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134225; c=relaxed/simple;
	bh=181lRSRPOEEZ9LfkQcJi9FfAd8GSh/UT/Sou0Q5OwUQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hFgW9ZMFH4IYGtq0k3LkaIplTu883Na4/yIj2YZvH705OgpYBaUGCGGalRSCudgmqzcr39nH1KuxDeooVVpgvrBdpiaBC+q62cSFgjaBzpWncyfnLhWWywgUFkK5oSUO8dbVHdOmnzurei/5VQ29yILqH7OMB8k0X95IFEAwgyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ynRHlTI9; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ynRHlTI9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCrgzokGmv7ox3wY/jlkCnwhScMMW9ubCP1SK6str8tmLMyL0sPWKmOy1YNRV9+aeFrNhenplAoSV2aMYjy7Jl9H7ttsXS5jh1janhwpjIg6i+PWcMDrgNcek2kiPa+1ywhtFE7vhWGyHbCt7Rcn9mU1RI4CCH7Fm9bsdSQ+ZctAxQaspPYiNOj2xpDruVxrGBW0Ltw3Ov3HQLjyJkIfDOtOQqAHnyoyy1jjzjaI5HEOHew25wz/wDPE1XpTygWwtuVHQuY78kv5GzYUwgjQV8rEy/SHpkincoTs5vP/WQeGXAKtA1BIeje8/DU4K6Iyy1bPpJPf9L48IVV4OIL95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu7K2GfHORaPJ8HDjWChODhYH/SqZTvndoFyh9MnFbg=;
 b=liIK2I/TzGiCLg7NW/X2k9OeJArONCig5O8ai+MdiZMeJ2w/IpHrJNNplzeQmvcFXR4haAvG14jd+C/OsQfMcJUZVkTvhJ7Nk8Fh6J/L4m7AWcuXs3hsX6lZ0Va48V+cR0+5cyltrABn9vdUaXtneduJRGm6v25ynF0gUZtF8/K8AdcgMP/Yj1SRn2wGYt8tx0AmH59U6Nxt9u6Bzhi0BA4Hhh1b5LX8uxVmMsJTa37oyK3y48VirP5Enmk2Vopn7G92vPPmDkL8iy3WY1n4Fhxizi1oB5CA+eCV2ZicvADLPCPe0yXohoxCLNZg87/Yau8RLtk9swvwO86+1rBhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu7K2GfHORaPJ8HDjWChODhYH/SqZTvndoFyh9MnFbg=;
 b=ynRHlTI96sr3NbJ+1W6C7ylVGbM95Me0u6xpSfWuWO6/MgGrHbpiIx4pbcM86FF/XCW4pxZZ3Nk1lw4Gf02WhrxgzY9FgeQDzxRvR1ZJb+WBSFKeHvanC2vP/j5uK0FWmCEjT18SDiEh3SgLo0GTatpMj0FGpmClvIkRL4ts0YU=
Received: from DS1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::10) by
 PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:43:36 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:44c:cafe::36) by DS1P220CA0017.outlook.office365.com
 (2603:10b6:8:44c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 13:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 13:43:35 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 08:43:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <clemens@ladisch.de>, <linux@roeck-us.net>, <bhelgaas@google.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-hwmon@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH] hwmon: (k10temp): Add PCI IDs for 1ah/80h
Date: Fri, 11 Sep 2026 08:43:00 -0500
Message-ID: <20260911134304.226286-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: e1048a0e-bb41-4515-e07b-08df100aad7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nWUSi0GWhb8bgg94C6JZ6wCzpf13tqzMLenhqYEJxcHqjuvCuj1Cab52KWQk9hf3WQ56O53A53D/9Tc9wsFnQXJHRZsFBVe2cPUe69qxUcQM71+Yt411APwJCSDQPmE135Q1ac7BAEj1v1WXRQmILYjaMRqLtoWoz87xk+43PwQvN29iRnP9twceKf0gni16pdxnjev7W/LRhO7CDYp/LGatomzd4QXfT+/WnxLyd7H2NmHFaKA0Fi5mb9YRELu4PL4FioGXwWifZX8Wnp2Z19KG2hOTG6e44Guh/2amaH2Qr4fIjY3wd/l5iLfr+Bvstknyfwxz2YzKkFmZQOzDBOEXURN2Wzmd6WXGts+NDV2I3IGX/vSv5ZzBl9uO/4L9wzZQ+fV9K8jMWAsMvDg4Q4z6HSSRqZgxV16oNyOH6r6Ze5CGBLss6d5GkHVqz7b+FO714EQEB/89g/higWySdNgC3a2Eh4WNcEWtT1t+K5a7D1Ksq4bzykidZqUEhiXxET391GXdecmACd6Oi1dJ4UPWV+gqfLjdjAFcW0OgSG+2MARerQR7G4F2V7l0LkIbXvMsV9yaaocOgSC94JIFW2u6unMV4pZebVOPzit3CaCYb/pqMJJhjBuf7VvM1b516O7YI/PLajfn4ibdxJzhQerhhFCZ+ofBrvk3NHDTl7Ua9Uoe3qm6n+0x/ufYClH778FK4q8zrmFxeyaa0y5mdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1O7JZSoi+HCy9piRTwj96Ebz6CpL08a2oGqUFWEUYwr4S/IjofW6514vgx35DaDo+RWoyVTq46ATES44qzM7bC+ZQIj97IBCp+/ER2ipoa4iBc5dSPFv9vwn7cLvpsuQMILIbretLDSGqoX7TW8qI437jCVx/3jGVTqus7AcHSQIC4xeNSPNEZdxvUpOwEKH2SLbqDKAk51l75W9VU0Nj+lzp0jIIKkrEMIG9SV2SagHhImm6eieNaQ3yt4DlGDYuFcGHK2i8Q1d4gJYrqSxyMel1i/bMsevEXUSW05ic3ymEnjPvkygdrRr9A7mHxlL5AOaIyf2f0HI9sdWbV2OlYHR38psCbJz4kiSO5VdSJuGVKq6fUvJusVPmI+MR7iOIRsipQ86KIJ2r4thU9qIW5HvV8TRQFW/YrTPdG6lnUvviJq3M0tDO4chnGroVZSP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:43:35.5518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1048a0e-bb41-4515-e07b-08df100aad7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

1ah/80h uses same base as other programs.  It only supports Tctl.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hwmon/k10temp.c | 1 +
 include/linux/pci_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3e7e63edc6a30..b00081deb2e86 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -582,6 +582,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 63774ae2bf71d..57a4ad9984798 100644
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
2.43.0

