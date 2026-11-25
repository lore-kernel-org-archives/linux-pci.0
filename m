Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795577347;
	b=x61e1yHw0/hmHN1Bodp/+md6+iFCYpvmtmGSTVjtDMh/ifacU1KgEQ9s9IBUTj4BFqRV
	 VWjBejtir27woibzXOXqsYjAUfnHgfyJ4duFXenRHvt5v+dwSQCyNlqtJSMuTsUDQK03J
	 8AvpRuYIioE8xECK3K/yS4x8JkB7ITNe8knQ9TlyAliUt5xCIs1qUAmWthrZ5TFrGOM7u
	 psyX4Okqje+SpyFWc/H5GhPcNHm+TNx5XOBBx6l3HS0tj05hJVt1BIfnB8myt199hXVTJ
	 4vhDVN+PXsfPzO7gRF+zjjjsiBGD6Ui3S53WHcAti/RVwFm6wLK1Y0aTuW9ERS7zkmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577347;
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
	bh=4YrIK1idyYA3sc5sRmmYYS1l+iOFL/vgHnWeAIY2u4U=;
	b=uCJxjZy4D+wz6dZ1p44FtEFLG6744BOj1nuQJrQDhD6WIKL2Fz/yyM0JRwpUwo4Kaxz/
	 JBjPeRxJcXyWz0J1l5aXuBx0YKEOcJveICmnxgBDvN4IR8SILn0fm2/OUKLazahTAcPlt
	 2q+CvmUWcgqVcz3ekMhN9WXrvtL/H/667uQ9selE7rkTmb1tLzPV+yOLjGjyK5D+bU31n
	 FUpBzHNdDSPrgcKgTF+kM5zHk3XC7Ag+GzpUaIv1AgdVr3MY4MZ3lBjPg0fUPWM4svVXr
	 oSlTAbBznN5d/OwSQpX5g6RdXAf0Y7cxK4qfemdnvECeSfNyVPnYZNi4gEXH8YGboRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZkZmcDJY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.22
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21164606A326;
	Wed, 25 Nov 2026 03:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21164606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZkZmcDJY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyZjQ88phiRWnMO75/1FC+s9hqBsnJrUmntUPHSvgNSQOrgj3+FxHQVAUuhfxp48RbGOHOh8O243MXxeMEjZqRQW5GsBtrzt3xiFA6k5SzAENNj0bUDW/GaLH0+AGoKm/Ftfi1Vh/Libv4AqBXaS9DckK2RBXewL70fXnP5XAvfF1mxTBKKKUmFWnHv3LnxbEEHYBFRsTEQPVDZOAix2BnotvRsKxhdV+qA+hI3dPPCE6+rgkUy2ETrIHno1On0u6oY5vhfKxO0YOmZyCa1DPGr5a4pDJgG6DG8FL8bYDz/1KEIYzTKS3DmIQXuxpv9I/qgKSIDTWvz5FgNMMpQewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YrIK1idyYA3sc5sRmmYYS1l+iOFL/vgHnWeAIY2u4U=;
 b=l0spUVnS8/lTLIYT8yvgQgCTPSVhFLV/K7H/M/hFzWUAao6Oy9A9B40Pm1+Z5T5xVGrH3BKg/f7zQeg/Cc1ujGUEZprxQIW62BLwtWuzdzTH6GenM0jKk5La5FwX5B7NkqSLLi+eLBPyte9OVPrDwIf4IM4BUMPEZXNPbEM31VuuuWRVchMvSZ2VE+AvWk73Rg4DeXjwiAZnuypLGvZGjdNzhxF6JfejvCpPe1N/4sudUam4hsa3tCY+pmOA1mM3AHt7BXmurDUoreIx9dAruFJN6s20zf3iemjm9OQ8WpKmcGygNdHkga4xZSooDhc6ZL60H4FSw/l7JOtmoaXdKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YrIK1idyYA3sc5sRmmYYS1l+iOFL/vgHnWeAIY2u4U=;
 b=ZkZmcDJYsqvOsTOMDz2E2+93yMD+xW/e+9IhnTtLbrxTJMmSRgeFsRxs1rz2XLFwkbIkyUg0QHgfK6g1RFNrFu/dbogHn2BSOzjvFGYS8DlwgS6QDYCxboFTd7hA1X5KVCGmVlOGWaxfPZyiL/a+Sbz0Qqakom7u6wL+zZoepFw=
Received: from DS1PR03CA0003.namprd03.prod.outlook.com (2603:10b6:8:450::16)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 03:28:57 +0000
Received: from DS2PEPF00007109.namprd05.prod.outlook.com
 (2603:10b6:8:450:cafe::55) by DS1PR03CA0003.outlook.office365.com
 (2603:10b6:8:450::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 03:28:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00007109.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 03:28:57 +0000
Received: from quartz-7b1chost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 21:28:56 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	<bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh
	<pandoh@google.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 1/2] PCI/AER: Reject negative ratelimit interval and burst values
Date: Tue, 24 Nov 2026 21:28:45 -0600
Message-ID: <20261125032846.4019744-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123233859.GA1120797@bhelgaas>
References: <20261123233859.GA1120797@bhelgaas>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00007109:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ac2091-fc16-4d6f-21fa-08df4aa43d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|22082099003|18002099003|13003099007|260925022911599003|260925021911599003|11063799006|261021121427099003|56012099006|260925021311599003|261028144727099003|261026121527099003|261009223027099003|261021123027099003|261022105027099003|261026140227099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	LEPKh58SjLv0A0UIwrcx+t0rGThiRZ8BFLgocU/66alcDV1Px5u6IG/Qh6vFOmoJRSEMocYmpaOrlEs9M3aZqgjPZM8lLOd/oP23QymC1R3xrtzIWFvSdy1sDvsQb6aAMNhU+bay5qblMhWoeJxiBYsaxQRpLFjokz5YgadoPdldZDwLo6XvNUdgPAu/LgwmOMwGge+9QKKlwekcG6YFmkLyJFmXWojZfZTxvc8GtHH6rnLnZwaDoq6lQaKBK+ir3V/ZC1i+HZlCjAdJOoKVCMsRXB07hsfkgefTeoF/bFy+XfjbE1lE4hziWxB3rtHMpDPI4YSFw6OBxogmrhPtjJXILeuFR1eMmfSLPXsE7ONBhzLJDE3sFsKHB9qaELAeSPZTSQ4fQZrjfh1/G3ngZlX1yfQj/lq6tzrVWRUTPV61L16ehZY6z118ax09lSZ2c01E24IIdEHIeShIFuBrMdY4jLbkRFU2hm+JsnSs8oWLLWN/DxNC5K8r3nYMxqZGNizktBzO6LVBZBH+dwAUpfpL5x6bRY4l0ePvWQFpFsHernuPzk4C2VaONqkntR8GKXUmuV1ghBR1nvslUA/C6L3uOW+0Rgjojtoj6lN4yeh5Ag6QxL+8zcKf1895qlwHNbTYS7NX4nEZW45J3lngq3uImfSuQLwjspENJEqVyRI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(13003099007)(260925022911599003)(260925021911599003)(11063799006)(261021121427099003)(56012099006)(260925021311599003)(261028144727099003)(261026121527099003)(261009223027099003)(261021123027099003)(261022105027099003)(261026140227099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hZHI5XynQW5e9Z1rY+ikfgL27koVfJhI9+9l3Y5f+iJNUe+vdF2Xt5irEPJwvpIgkDhf49ypV5MZXwaoQ98XOvTD0IOwSg+q3Q2YVGIiEPr317jhDmdwhrDNknhqlbtjxwyl1HlhuLQZn1iKHDQoLfoMb3IUEhF4HrsNxFwob5dCg+LFawVxbJbAKmtA5uu7tXhOnhm1ksPb5T9jxsNvhgAAcpxeQ2Jr49g/+vUsk1dDauKzVt0ZyIGT1BckNzcs8yg6mutjBlI+PcrgXxHLR+LdkbIXu7NZgo9LLINYscQ3rNCzg/DSKChBcwEGOtN0rQHImPYZT9J6TPuKm12F2+uJFHZ9Jxo/T0BMatXCMwiOdVnG7RPwYtmAYd/tjuucCmuEqgTXuhHfZlghepfGDjjW/rWR0H5AgnCW9T8TsjDx5MDm3Nr3c2sorwabpzV/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:28:57.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ac2091-fc16-4d6f-21fa-08df4aa43d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00007109.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

The AER "*_ratelimit_interval_ms" and "*_ratelimit_burst" sysfs
attributes accept negative values. A negative interval is treated as
0, which disables ratelimiting. A negative burst is stored as is, and
___ratelimit() then warns about an uninitialized ratelimit_state.

However, a negative value has no meaningful interpretation for either
attribute.

Return -EINVAL for negative input.

Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Replaces "PCI/AER: Clamp negative ratelimit burst to zero" in place on
pci/aer. Patch 2/2 (docs) goes on top of the pci/aer tip.

v2->v3:
- Split the documentation into its own patch. (Bjorn)

v1->v2:
- Return -EINVAL for negative interval and burst values instead of
  clamping. (Bjorn)

This no longer touches the ABI file, so "PCI/AER: Enable baseline
capability error reporting" applies on top as Lukas posted it, without
the "or any negative value" merge fixup in its two interval
descriptions. The rest of pci/aer applies unchanged.

Tested in a QEMU guest with injected correctable and non-fatal errors,
for every combination of interval {-1, 0, positive} and burst {-1, 0,
positive}. Negative writes fail with -EINVAL. Every error is counted
and traced. Interval 0 logs every error, whatever the burst. A positive
interval with burst 0 logs none.

An LLM coding assistant helped check the ___ratelimit() semantics,
split and rebase the patches, resolve the conflict and write the QEMU
test.

v2: https://lore.kernel.org/r/20261123165050.GA1741477@yaz-khff2.amd.com
v1: https://lore.kernel.org/r/20261110215614.3931232-3-yazen.ghannam@amd.com

 drivers/pci/pcie/aer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6f2460231422..2c42d6e8bd9a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -690,7 +690,8 @@ const struct attribute_group aer_stats_attr_group = {
 
 /*
  * Ratelimit interval
- * <=0: disabled with ratelimit.interval = 0
+ * <0: rejected
+ * 0: disabled with ratelimit.interval = 0
  * >0: enabled with ratelimit.interval in ms
  */
 #define aer_ratelimit_interval_attr(name, ratelimit)			\
@@ -717,10 +718,10 @@ const struct attribute_group aer_stats_attr_group = {
 		if (kstrtoint(buf, 0, &interval) < 0)			\
 			return -EINVAL;					\
 									\
-		if (interval <= 0)					\
-			interval = 0;					\
-		else							\
-			interval = msecs_to_jiffies(interval); 		\
+		if (interval < 0)					\
+			return -EINVAL;					\
+									\
+		interval = msecs_to_jiffies(interval);			\
 									\
 		pdev->aer_info->ratelimit.interval = interval;		\
 									\
@@ -752,6 +753,9 @@ const struct attribute_group aer_stats_attr_group = {
 		if (kstrtoint(buf, 0, &burst) < 0)			\
 			return -EINVAL;					\
 									\
+		if (burst < 0)						\
+			return -EINVAL;					\
+									\
 		pdev->aer_info->ratelimit.burst = burst;		\
 									\
 		return count;						\
-- 
2.55.0

