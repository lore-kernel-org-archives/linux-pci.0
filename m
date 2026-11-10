Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794347790;
	b=rhAJfQXD6bPOHhLIgPyQs73CbbngmHrB7dvfrW++YvFGlS3zyadyPtl8j45YiDvK4lxZ
	 CznyIFsyLZMRgXQPq1TRZs8JCT27g/IOfdAl1JoFebh0d0whRPghf8+2avOhSTG78OvWw
	 savmSHOFo7fS17qbEraCkCEV6V1LyIXdNpKXRvZ3J1wYXPlIUBe24+coe/vukldh8zMfi
	 GvH4IMan2NsRypENgLiEE7HFRuuOiFhSj1ZWNv6lIgbZsgygy5qPfT6nLl2RtIuXhmj9W
	 oboy3H1L/lTuaNn4R4JRvjRBYs+saxj5e8f9dJTG/ZQzOUc2I4fakOZAPVaet7Blfjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347790;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=d5G1KuDOAlFPJBeLSqK1HVrKbYWctIoSli8A7kkhLGo=;
	b=qBmTwLxVYVoM0KZAiJ5vovy3wrLa3ymaV/otJgWJgiR38pOO1/fyuIIYEhzWtSkDMExJ
	 uVo22l/lskKgrcEkGriyY55lR9+795tQyLFIDPC8fGVxilH7QiBerM5/qLDxcSp5/ZNfD
	 kajN2zllCENY9F1WItiJNxNlMIzfEfCI3AIRCaOhqPjxnybflCFa33mBfSGr1x3pqeFIT
	 4UHXgNTOtXKsiMAChAsLpswSucDPktAHtRzCu7W4R9AU/z1bWnlkTIHw3N95BV3//xyJp
	 QSOr8i2FmbgHCLq4ZSstcKor2pGhXLtXA/UUdyuyWmQhB05+uegeAV6RZIrxrmNtxXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vfye6nVB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.31
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F37606C98C;
	Tue, 10 Nov 2026 21:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F37606C98C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vfye6nVB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6/ROnIHJEs6Vf/cWGl24JFyIPtE38FmQqO3zkE74c59PtvCvigC6IIs1txRZEmy7fNqdM8zxqib5K6Oz9bahTKiiOut4OVjU4kzkyjRhRQzWYtoHWUhDqfWM4BoLDJw/B7c/jjPwQRP2gteBOjc9yy+x2r+u/0THjyDZF6dmXs0Jat1lsh4piCPjw4zjyURFG/H1cG1ClLNgnBR6GVjj3pUNuqf3WXuuwp7yeIq3qvJzcZs/gDUJD1OuG3mYHsPaPcICENdXo4BOdFXkn5DVgoPtbM2IwKSD0QoZixbyyunBKog3FwGoOVZil+X2C/Lq546xPbyCXPhfWm82AyefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5G1KuDOAlFPJBeLSqK1HVrKbYWctIoSli8A7kkhLGo=;
 b=qCGrF/yesi3Ar9Ce+d0rCj5LFGmblvOdSLwzzgpAIgEbZCFncjstZSxnSCV38Kljkg6J3cyEEyeeHiI/SvfIMqncBp9wsJRtDRAvJwl6x+nWh328lnPBJejLUP4kPubiyl1KoP8w2nGlW28HlCHaBA5wz0EkQleVXfQGpaEB/Wt85OmrKogBaX9dXwMRJof3mVvH/m+pMVzpjQ1SQiw2btPHbdrCapNVOi0DutSRmZLQGAi+P3lFiyXqTNgT5I4t6rgh9r3XXkyvSLSzIOSD+ce3/pRaXHKXaTPFvf8fY7g7C5AlFXa6y4fi3qPoQx0mfIczgCcD+NdvlhKLRmY3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5G1KuDOAlFPJBeLSqK1HVrKbYWctIoSli8A7kkhLGo=;
 b=vfye6nVBn4sKb54hn2HQjiAULmGj91qvwszVnDaHSu/TXP9/G0+jTNfSd86xNFPoXFTXWmJA492zPnnY+RJJCdvsxkpVvfE0o7S2ikMewYiGtCv1oW7IZJ7Zy5AYLX3H5aUtRH85wF5G48UOQjTHpCTgfKaYwx4uGhS1z0sdNEo=
Received: from BLAPR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:32b::7)
 by IA4PR12MB663679.namprd12.prod.outlook.com (2603:10b6:207:12d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 21:56:26 +0000
Received: from BL4PEPF000003F0.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::a8) by BLAPR03CA0002.outlook.office365.com
 (2603:10b6:208:32b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Tue,
 10 Nov 2026 21:56:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL4PEPF000003F0.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 21:56:26 +0000
Received: from quartz-7b1chost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 15:56:25 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Date: Tue, 10 Nov 2026 15:56:12 -0600
Message-ID: <20261110215614.3931232-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110215614.3931232-1-yazen.ghannam@amd.com>
References: <20261110215614.3931232-1-yazen.ghannam@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F0:EE_|IA4PR12MB663679:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afb0d33-a872-47e3-924e-08df3f7577c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261026121527099003|261009223027099003|261021123027099003|261021121427099003|10067099003|261102123227099003|260925021311599003|260925021911599003|260925022911599003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NbbL2d/20alZuL/F6XVK8U964U20cOpWaKYFdJJSTTolPksyc/8ayPxBlt8Ud7iky5YwuVSzv6Jla8yrErWyXd1mYv2OXI8+EWooNbPUHYJmeqbVQmp93xBcYCTF724kiBEArJ/Ct9vx06crWW1QFUAj/tKMOqaEQP6XM9CsufRSHk4pQX8z28HyJP3Gl47EJ01b3/W8quOLvL/eGNCAaQ3eO+BlJpRiRuxnhh898rnr2vyVhalDV3LYvTenrZ6aQyFu1MhbQCjYUwME7TIfRunxkTc5X3h6+QPearRQxCLtt/5kcmyrzvzH9Tn/EjJVXEbxlP0FOz0wXREJsvjkhMKLIoTZaPH36xC3FZBpflAJxV9Uvk1nZ1dctoVvdCM1QFlJdJHPNTSxjvoYSWqAaUrVqrlws7vH6agF8httTh0RAqOeTuA3maHFsSl0lR3UxIxBqJbBz+OyRxSVKcHYKwBSwRO1lHL5PiRDSH777kf4r6fBb/RaBJzgKPy0IUtWJvk9Yrv6LwNaQy9FuXW5FHrtcu13qToOYzAWDvA+vjgSaD0ofz2ZBM267tGrrm08PF+FqlndIwDpbRruUyyrKNgCmaxAFDsXAdBMseaxSG9H4ZqRoEIfQA21B8GE3CjN1S+VBl67sIaBaIAegQcbjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261026121527099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9IoyI6tIIxVyFzCjJ+k20gRLDWaIWaS70+0iuVBuaSN4BXOfYcooFlsbYNyNCqzoRceBJ78tR4gDN6KBjRY29dVUqq6OlbgZjI0vSwpTmhiEWltz5llTv4tuVT1wWM8ZYUflzdDdEui5gH/rLrLJ1RrXQvAM0uVMCIREgpVzlEBP7T7nGNlaZPkDLkYEuweFKk/NoO8Iq+MS1OTAnYQlC/4bbdTsuQ9MSewomxQwgnDz8Pjt31vVyjSlrdPWTpjsIZzSMixadFTOsUv7s5+WD8WpFO3LrIZgxU3S3VfUzocAR/1EzjT5qbqeFUm/ILxV5sEMaJMHEAqQgarkijHAy+vxdSaUACKsF+kWz1ry6y1ksgET6vE156gtzeXsQlOFfdAUTj/FWrY6k0KsC7i+sF7asKCTLr/IkeDYb9AsOIBdW6MrYtFT6KWwwsGZMeTH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 21:56:26.2496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afb0d33-a872-47e3-924e-08df3f7577c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB663679

The correctable and nonfatal "_ratelimit_burst" attributes store
whatever kstrtoint() parses, so a negative value lands directly in
ratelimit_state.burst.

___ratelimit() reads a negative burst as an uninitialized
ratelimit_state and gives a WARNing.

Clamp negative values to zero and document the clamping behavior.

Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++-------
 drivers/pci/pcie/aer.c                        |  3 +++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
index 5ed284523956..215cf8bd4c30 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
@@ -130,9 +130,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
 Contact:	linux-pci@vger.kernel.org
-Description:	Writing 0 disables AER correctable error log ratelimiting.
-		Writing a positive value sets the ratelimit interval in ms.
-		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
+Description:	Writing 0, or any negative value, disables AER correctable
+		error log ratelimiting. Writing a positive value sets the
+		ratelimit interval in ms. Default is
+		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
 What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
 Date:		May 2025
@@ -143,14 +144,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
 		before ratelimiting. Reading gets the current ratelimit
 		burst. Default is DEFAULT_RATELIMIT_BURST (10).
 
+		Writing 0, or any negative value, suppresses all logs
+		unless the interval attribute is also 0.
+
 What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
 Contact:	linux-pci@vger.kernel.org
-Description:	Writing 0 disables AER non-fatal uncorrectable error log
-		ratelimiting. Writing a positive value sets the ratelimit
-		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
-		(5000 ms).
+Description:	Writing 0, or any negative value, disables AER non-fatal
+		uncorrectable error log ratelimiting. Writing a positive
+		value sets the ratelimit interval in ms. Default is
+		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
 What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
 Date:		May 2025
@@ -161,3 +165,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
 		allowed per interval before ratelimiting. Reading gets the
 		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
 		(10).
+
+		Writing 0, or any negative value, suppresses all logs
+		unless the interval attribute is also 0.
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6f2460231422..401cd3a1b3d0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group = {
 		if (kstrtoint(buf, 0, &burst) < 0)			\
 			return -EINVAL;					\
 									\
+		if (burst < 0)						\
+			burst = 0;					\
+									\
 		pdev->aer_info->ratelimit.burst = burst;		\
 									\
 		return count;						\
-- 
2.55.0

