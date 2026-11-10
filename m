Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794347790;
	b=DD/6VPz9dM8KHz4gvDzc3Qpr88CigBbZTvgfiaDRiRYFtOyUnqi13CGdY4RcgV3KiEVU
	 SeBymICrG0hdu2igbE4kxKevwoS/fxUCixoQMVB4D8VobyWQTTPvtFnPIklPQsvh9Dr+j
	 +m/v2Kzr+HZkPqLQ6nWoDd7zNT4HF1cJl86d7JL19tbqO16d3fkRt8U9FI5sqgsLa74uU
	 GdUlCrRwlNP6AMndlfOSnpkl4tR9AUby9oYY0HRRkhPsa9LtpqJn6Ycti4axDbQbZhCKB
	 FNrOElxpINcbzGXfXEe7NDD45fxWaHWOwPsqw+1SYRpD+mi88GJw0NE3qknQ3IYngXg==
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
	bh=CjYErmufOolDm1hiDzVXRNzCKrX4C/HlUHLg3tfIGmY=;
	b=ZdCWnc5PH5UBPzNI7zAHFihukDSejwpst+Ddnh0jKcP+kXv12ZwsCvoxtt8x/7UVvlAk
	 GBVqttemOOd1VTgtqDSiQTlJKtoRkk0tNIhQvhhvyfpLVkaUCKsGIRCJX6l0d0Za9i0iq
	 qWI8l8J8OrWYG9hHddZDiRwJLwd5lPpYFLPHRgUKvBR8vshGacvaAc1RIU0XJ1DNvkchs
	 Ol04S2wi3MSYC5Zxs6jzG9FSDNnEvgsKhb4tSngtbCmugv25Sh/azqEbbz6awI8YXMMan
	 cH+Z7mByEcK2mNAMA7LqUthrPwKpg13cYAeoFIRJyWHl0JfLEUnQ2fHqc3RVCloBIMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bko7F5oq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.62
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72800606C98B;
	Tue, 10 Nov 2026 21:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72800606C98B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bko7F5oq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHOq+SxuvyxJU9bOxRrpUPdIyoJl8iGoiEvRUL0TyEpA70gbJZhQWfOOIlDl4JCGLwm557zxNyu51LQ0bW2sHHJqZpdcR9zjZIobuX55ELNRVlYBrCUZGhYsgAwB5nN/H0ABGIZYtK8H1QmAuuDDjKSpG3C4Zxfweo9vQXkexrBGZS2+gTLW976nSSIfbIgH+RhUs7krzka2eZmOggo5UkyPxqX88C28dRPeZF8JrH3LzU47h0x6aCTRuuunDs5xzT6kWdbFX0PqX3I8VbpX3BeB7zWMsISp8tgHWFgGpV+/pPVit3BYxNUfwQFZUxq35uE2U1ozQ72mRqGAOCe3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjYErmufOolDm1hiDzVXRNzCKrX4C/HlUHLg3tfIGmY=;
 b=aBwK6KSYsFG9MDu2Ha0WN9DiEvGZEWqE2B62/vHo9y+fA7ALGzQyD8FdX/j79DcMovBbBj4GmG3WolKY6ptMj+kl2WZq6rMgFO+s/QCnSFYQgn6qoJjalwJlgYf8RG02GUOM4jDMBWBZaqzabETGnAuY49e0ggV+uZB1lcZz5LT4PJ+gdkN5hE3v4brzEa541u6dKiRI0hGgfy38joVdZQ/waWzqtd6/1qyZ7TK86sagzqldiKJHvl6wpcyjRGLD4kacxtfvCtN6mfw9so3IXvq9KMwoEnU64BDhxBisG+X6U2tifdGGmwVmLX8h3jYkdUVkkdr+zoQpabrBg6d+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjYErmufOolDm1hiDzVXRNzCKrX4C/HlUHLg3tfIGmY=;
 b=Bko7F5oqdbj2ON90G9FJ8jpWPdckSqxnVQSH04ByErQgBEp2PVp/RB9Ds6js1NMG3ZK5Q64T/O5xqQQrl0v0dZ8AFN8rtti+y7jFn2D3w+wvQP+iStH0mvDP05C1Q43Wpjf162Rry7UiTnHfhtLPB3C+qJfMCsf8MJTtd7Zu/eQ=
Received: from BLAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:32b::14)
 by DSVPR12MB073533.namprd12.prod.outlook.com (2603:10b6:8:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 21:56:26 +0000
Received: from BL4PEPF000003F0.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::8b) by BLAPR03CA0009.outlook.office365.com
 (2603:10b6:208:32b::14) with Microsoft SMTP Server (version=TLS1_3,
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
Subject: [PATCH 3/4] PCI/AER: Report the ratelimit interval in milliseconds
Date: Tue, 10 Nov 2026 15:56:13 -0600
Message-ID: <20261110215614.3931232-4-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F0:EE_|DSVPR12MB073533:EE_
X-MS-Office365-Filtering-Correlation-Id: 32039e21-0070-4610-20d9-08df3f7577f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|10067099003|261102123227099003|261026121527099003|261021123027099003|261021121427099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cFnEnjaxaxidWc0gn+qRVzYXjkt+4f4JgHVTMivabZ77mZVkJhmN7IK7+iMaHj22KlX/1h9jculQv4OdlVxjItjC4ZDPfm6SB0geDCzCKkv6YHbRJ2Ajp2SdbqLV9bKQQCrsKDyH96Hmfvt3hnIqp44vfQv8zOKzn+AiNf7BGzkwwkNuqVtlq/B87Vo4xBlsLwe7cfpoK8EfS8rJ5hfqXgn1lgEOSnpowpSRmvl80T4xv6ivk8/b/Fel9dUCX4Xg5ibnN5RNc8chbalmGHXkDXFvZXRlEtV1NnQNWKqy4jOb7pdRBVSnHXwEO8bd+nMa4KVpttnu1ASMucbxX+xiKuA0lk4tCYk0qPUEqT98kF/SXBpue8FyDuBfHGDMCyux1ytjx89bbqrCAgNNnCYvx2sY4K3qPS5b8t9D0Pw2FkJsq8QdpGCNQJleamRyhU92tjE2joYmE3fAmlDzPvgbk4Sj1Q8efeyN5TcY9P8xOIeR1+ARXCZPh8Z2ursFAp/eX6rHyPMm/l3RyXQpJDYkU92IRc0XL4xkb1mGgcRE5nM4hw0WECuZoRIH95G2iDfAgB618GqC8sTyZqFHjtYXnAyOv7U1AzJ+FExeENkJnFMBxzFSa0HkembJOskWyagHBaidLY1KTB1VgaERwUpgV0QUxCLIrsrq2c3fonUU+ukqikPGU51eiRuHUyQd6kPEG3WrK2ozXQCmSWHmQrA3IA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(10067099003)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WeCzq2rBCevEaUybXh3t2f5mBYttper0VitG0hVcEtrtSjgp/f9gTbi4oU9gSGNyksL41mT9cbi1XbbVjlt1tyLtoBTyHW/K9dV1/zQwYMXdfS19RQ2/SgBUxlA+RsVhBhOshhUnwDQZT0Nc8CqlThxdspde6EArRjc6ho1ZsUQnjdeoa2d9mVgolU45ezQe4dfMsjXGb80LW49aKwSBUMH48vYn+qxZO9Kvqd15SsMBTdJeB95Qxtx2D+SyxKtvDatbJJUZ5Jvqkz8tFUeIDXMheQz01tthNCkZ05A/OuQQhGuk5JvG8YD5DLgD0m88bmtgfVQdmJGzoQWXcZ7NlA64GHiwj5gyCLXkB40tXashWbCY54YMdwPZftfir1UW9Z4EtVR6FtqUjJtrX+Apvz3A6v1syhIS1cGuLZCQuO21/26Jfv+9IUx6S64B9qXt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 21:56:26.5718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32039e21-0070-4610-20d9-08df3f7577f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB073533

The "*_ratelimit_interval_ms" attributes convert milliseconds to jiffies
when storing. But they don't convert jiffies to milliseconds when
showing. So the user is presented with the raw jiffies value.

Do the jiffies to milliseconds conversion when showing the value.

Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/pci/pcie/aer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 401cd3a1b3d0..32a4c9101946 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -699,9 +699,9 @@ const struct attribute_group aer_stats_attr_group = {
 					 char *buf)			\
 	{								\
 		struct pci_dev *pdev = to_pci_dev(dev);			\
+		unsigned long iv = pdev->aer_info->ratelimit.interval;	\
 									\
-		return sysfs_emit(buf, "%d\n",				\
-				  pdev->aer_info->ratelimit.interval);	\
+		return sysfs_emit(buf, "%u\n", jiffies_to_msecs(iv));	\
 	}								\
 									\
 	static ssize_t							\
-- 
2.55.0

