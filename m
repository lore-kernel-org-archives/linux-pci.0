Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75F2D1F44;
	Sun, 21 Jun 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782064370; cv=fail; b=gPAhk3BdsvfJQGBR6x4u4VNiMe8+OXuEg3e1mdl+W/JF8pBWKyV1HUrnykPssxZWCvjGDXTmhdUzuqeAtLlVBnsiI8RUCq8sY+YdGxzOjj4uVETiDmU3hA8I7vejdzlyt4Cvufz+s4giFzhLfZLUxqeEC1tWgVzBhRPY9H1/dGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782064370; c=relaxed/simple;
	bh=f+0v+hJixnI8+/vorFNid4W88qqID66mxOR/iehvzUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ka88jFDwzKxD2adGct4Vx/kPBQpfryPoBxJ8yifrBEKrxE2CV74zO8izzMfGD3b+wfALSNZh1HyBNWhwPbW29mFTqqHngntb3SSrKgX+sQIoi5x7Ie+3tXBaFgCMISZQLy26IOGZqYODymBY1+iIcoU5ys17NbMOy95grgM/5iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mTfxp/J3; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mTfxp/J3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd5wrF0ZuiK+LBsuJr0sTe7OaIutHjdDixrL75RP7rKWTtvP2sdS8QilroK2IAMVNovQeDwvmFXzcRTRhQ7aUfdT49aLRQSgfETyN+EZ8uhJFPw6TIQ0yZL2DVdywpeO/yd7av5q0TiflbFgmJFRX3/wd20KuCVZeKwbOU9ZBm+ov0wJCvetvViLBBzUwwt13vIUjvfqZCTuV5pUG0lvVaaI0MU+IdVeYMDSnref7sBOfk9LT3ztRZlr+SPGhBWXGQF+piKw2mT6PWyAy1tgQvo4cUjvQNZf9a7shP1Bo4ewCXMGh+OrTSvU/RocAV/PnV4valeVKdryo+QLU+BQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKvNh13FRBTgadlANIetRIkapl/W7lp0gGhrQXsyhdU=;
 b=gGOCApA7Xr82S1kaF9iTQnpSaE++OQ9LuZnWfRURKcJlPSumzsPX7BVuhN7FZpX0T9PhWZFauJyzQtKldTVU5IN+d/xbP7hjaSlbfD0RuoXZzPK9/4Ly2uY/NzUeEa8cUy8/WvmuBx8PH18Wxk5i+qTaz9HEFXEFEQUaUsKU8/SD9ti3+CP67DGMwbySY4bSib0p/HO8WlADS+1fpeScqI6fTlHgfaYJ8MwDC6ZWxASnfOqQbnP5fxHFGLIAdsih6utepzJeI9Zl+sQo0JHCCbK+Fdbw+1jZm5aGqK9ix7nNt/TCE6eluWocMCH0NfXOzqVUWv+vznQaK4pe7uu5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKvNh13FRBTgadlANIetRIkapl/W7lp0gGhrQXsyhdU=;
 b=mTfxp/J37567MXzsz1YFZKunCQvoZL6AUDeL/eX+43IWEDbv4f+gXvOvGmLTzDQGksvP9KJKl9VJBVgafkaDpTpCssvVKFmVv+tUKdnMsFQcIRQ0FyOFB1cKE60zDxZ2NGvtctvykbECa10J+mnzBf3iMs8ONKKbnkagrJIYHDs=
Received: from DS7P220CA0122.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::6) by
 LV0PR12MB999094.namprd12.prod.outlook.com (2603:10b6:408:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 17:52:45 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:25f:cafe::a8) by DS7P220CA0122.outlook.office365.com
 (2603:10b6:8:25f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Sun,
 21 Jun 2026 17:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Sun, 21 Jun 2026 17:52:45 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 12:52:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Zimmermann
	<tzimmermann@suse.de>
CC: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH] fbcon: Drop vga_default_device() check from video_is_primary_device()
Date: Sun, 21 Jun 2026 10:52:30 -0700
Message-ID: <20260621175230.1453114-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|LV0PR12MB999094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd1fbf2-9214-46b0-8aad-08decfbde63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	nuKGUwq3nMGF7DnajtcWzLZz1azzBK+qxlYEtaTAK47xMD1mnTiidY5hdNwbDlQHSFZROhnPwitSCfUhQHquWUvNXxzvfzM4iWIv4bKgEvOg7112fG+y1em6BclJ9pEZqFxNE15iy6tr6ymzFS3hEUB8//1EhR74wfmyMZsxwqxyGsBICMB+kG0PDGX6SUa6XVT6fazr2+g7HqqwgdtEWUFW8JnfVH3lFjvyZGlkirNRWjq5SHeoLWBY8uNgGQqJYgc2z12V3j+BTpM8kTO52u8Gg4zPs9ZQhKltzytJClG+can9eFc01Zk3kITH7/6GbDgDnl9WTzvjJBCLA9w8bjd2ua7MVF39wZj8xQbkGQFmbF6+XglHumN5tW1fLbDAtOEtd613eH7OmXV2CwVnJFIJKLRysuyDm/Mv9/f6BBN8h3o97Au2Ds8x81aBW1XXm6zBImGhH2kdCvoF9eNg0C/TUE5+BZF/I1ch09zyHdirjnhCpAJSbdJnxsTJ5h9r1OGtEOJJodX+iEtyS6S9wnD9yU9x4abvnr4263Q6i4y4WMH/zq+ZgGjhFEZVqPzTN3DWTXMXuFumV3sZJR/iXj1HKFtkBVwPrC8aWoTr2HiYT+VV7V79318Qs/xAboQam/Vx/KTZv9/UJKyxivJyJlD9O28S6YblV2a3gCVR2AD79iuuKCXrDxRZ+HPOHI35zLLwJW0IhFAbVRdHKHlTNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(18002099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sIDvq/PlSpDXvMlB0cRNEUsZ9lbnpidTu7FokJnBlRk8SbrFinPw69Fu/BqLMDjCxQdN+Z8+X8gnzczAG3vHTL4bejSSLvdHG2VM9aAO4x8AtTUyc7xZzzhAUOPbW7+Ush5igXAOOjhtTHw4RPV7DPTRCV2tCdWEnMYg5XfamHx9rcfD74ZOvwh25kS/WBZcPvMooVP3qWuQ+W38Xs9cV+mP+ozL2L6tk54OljfJLjolqWG4E4wtECgCYztMcncw5w+7nteeJ/ONjed4ePo0x4f2VGovRP8eA3u8Z7r0ySNteb8W0fK7EbcVGM5RfWzC0H0nrOD4NBU3Sn7Kb0iqv4N5IXocOdB2IyqdtUZ9vfotfWY35B1fu8WIc93gAaAovlKLQvfHbiVD1bsasS/Qfd4rLHeTOps9DcYGmH4Bweu4QuhsJv5w23/9xdTwCYNC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 17:52:45.0811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd1fbf2-9214-46b0-8aad-08decfbde63b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999094

Some multi GPU systems may have a VGA compatible device, but that might
not be used for display.  If due to enumeration order this device is
found before the one actually used for display then multiple devices
may show the boot_display attribute, confusing userspace.

Drop the vga_default_device() check from video_is_primary_device() so
that only the device found from screen info is used.

Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
Reported-by: Aaron Ma <aaron.ma@canonical.com>
Closes: https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma@canonical.com/#t
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/video/video-common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 152789f00fcda..9440eb3a7b15d 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -43,9 +43,6 @@ bool video_is_primary_device(struct device *dev)
 	if (!pci_is_display(pdev))
 		return false;
 
-	if (pdev == vga_default_device())
-		return true;
-
 #ifdef CONFIG_SCREEN_INFO
 	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
 	for (i = 0; i < numres; ++i) {
-- 
2.43.0

