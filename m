Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794347792;
	b=VEdIceKcqdQsEFt4TwGN/OX6jsxqF/eIx8Wq5lFG506kJBW7txGMyz3aPJpP38EcfKIx
	 cgjpNclrK131jiEiPiyb5/pcw2YQcx3FIMCmq6imR5IRWRYhiQ1k3rizFAgaOjwOHBOTC
	 oJAf6QScV7JosUP6Z8XBAQEnmQb2jGnUqUEWRGY4Ep6JR15LjHKKkThQ4LvXqaTMgRBmi
	 4pZxp2+ram1cqQgRF7Ep1Lu6WKBlxZxnM1SOLGM8/lLborC0B14l6EUWGoWknibIUqXeU
	 AVJOulmW4jDh2gXbYybcHPQuw0CFwHyISAwIsbjtR5druLfB9JWln/g2J4nqpBqjNRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347792;
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
	bh=lI+KQK0PYcchEjcPgc+KQd7gAgfXXkSi/crlepHkz+A=;
	b=Z27CkDOSFDFQlmrna5s2mM7490g6+cgtKdCjBsxWl1l3sDWN4V041phSPAj8H3pRoOeb
	 rq8HZEtRgQn96lA3MQWYg6KQgOJl8r5xjq0OlHW9sIXn/rGt2QC5fvrXURT5v85dU52c9
	 WrI3/vHesMSoksMIbfnORXrFzuRsKrftMLnROjAWsm1pJncFwWCb0jIBwqW43+cB2/zRH
	 M4Mi2gMKlJKU/4sgkK9UcImZhCCtB/ooCkT2jZ5exO7Yxqg5l9EUDBvx5oPBj6cu0kghA
	 iKN1vzDKRRhbbLbbPlkc3Klpl82oy4GykbQf1SGcYUEYtV9AXhSbNrPMPzBCVUwu1HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5KvlxqVi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.37
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F266606C9BF;
	Tue, 10 Nov 2026 21:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F266606C9BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5KvlxqVi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULG3BAf9SoHdO77TzWpe+hh19cAlmgleTYFaZWsENGlGyX5HUdOUDHRuU8o7M2b2hKBkzELtkYWrEK0i2mgZ9XOiri+mhSN0Xeksht8zpM/8tJi8241/y0XBC8Uwv1c7FA8UnD8f0rcJ1JrIg2MjOr7/3e8bRKZD9n6D1GNZbVA1R9cNdI+Xh1vNyrFUUq0wu9T7/y1byKrvyC8ycYQCjJmvpKvhZnnC48LTSAM/DmPkCbPgNGJ1xw9Akr8USEnuIcwewFu6QsVOihb+6hIOpX9tG4MI4rZCv9Sv1AH7wGc7vqw1Gu6aiHmPvTJfB2Xy3aScMNYRifnw8AfkOuteTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI+KQK0PYcchEjcPgc+KQd7gAgfXXkSi/crlepHkz+A=;
 b=HYvH+vt3X3Uqof78C+2+NJ52CFHlXa5Ne6tszyLei5mBj4plDiQtNKn6RtSG2mRR07AJmyhYUlQ9gFjLnv4OLZGTxOUO/cK1UwvMc+EVOsgJi+cBLrKAv3krTquijc2n/TF6KLwMm3kuz/yXzWr4Yzk3theJATDZ+vnahmjvvGPSR3/bUjWRhU7z4F9Qij1ncBpyLNG3vW5csjFjzutstKyxKZP/W9qq1DLcddY+lcC5YauVmu2N7qPQBBdWR2Sp7UFngB9qSDnnUx3kmBRwKJsaoJ1ceqGU0g7g+xpZYJ0CIdDwZtamGwmxpEFBC3gO2WT9ZgZDV/7q7gsKCIXdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI+KQK0PYcchEjcPgc+KQd7gAgfXXkSi/crlepHkz+A=;
 b=5KvlxqVimaRSCsMXRbVfBV2DCxH7cxT/bWN+CUsadm0erWWL53I8BhkH558cpHBgFy6vQ0W7JpV/ABl2NfY4/vhjRyoMgTAR854IfXiKkcPDcV/KP4N4gUbTfC5noZJoitpoQsHLsC++12NArOmiKpgP0xSgoz4q4qR98T6tcrg=
Received: from BLAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:32b::17)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 21:56:27 +0000
Received: from BL4PEPF000003F0.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::8d) by BLAPR03CA0012.outlook.office365.com
 (2603:10b6:208:32b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Tue,
 10 Nov 2026 21:56:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL4PEPF000003F0.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 21:56:27 +0000
Received: from quartz-7b1chost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 15:56:26 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 4/4] PCI/AER: Hide the "aer" sysfs directory on devices without AER
Date: Tue, 10 Nov 2026 15:56:14 -0600
Message-ID: <20261110215614.3931232-5-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F0:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fdc7dc-74ab-499a-e5ae-08df3f757859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|13003099007|261026121527099003|261009223027099003|261021123027099003|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nw3U/qCkXoDXXG3/tqRz/eEjrd3kfbdR59B2UaPLie6vDv4NKtWF5QnIWE3uhqRae90xHz8SAaEuBudjq6+DJiENUDvEIWhrgyCf0v1a9VNRoBN7157q25xko81XtAdQos4mTRvJjNRkV3VzTMVWqlWxj8cM75ciCc5CEdvWuLkAOgDdeIPHX27ceexl+aiVYJujBNmrZNxzVsLgKguBZQlzl3R1Y/ZqbiELusEuQ6VrUJ9zwvwG13CJhEGDLjEzjeobB/+fNzkrAdnuEfBsoZJjAzylztGxm18V1nMLwZZ81M0lPzxHK260PBc4akF2TT5yVARe9BlDnDqziXXKI4oDh3jnIF0mIm1HBaPQPaYajBu/Jh07lpsLFTZZ+RpGUN0LotKLy+88ptIAc+bW5nLm0sbgm9C51yd6KFaESb7w37z340LR3aiLPoJQlsyc3dlzU6seBWzylhp9HmwplfRjP2oqv8lSmDUgJF/vO1ofrtyjJXm3lkybKL6VMPDp8b07O0w2104yermSvXnnbMtNxS69dQftn5ufh8XYi56uxv+5/bsRRmSHoLZHcKR5sYHWDKTTnAvoN3gz3ZjZjeOZWTtNWCRpybf2YdRVgrFwquXdpCgy/0McGRhmABZTFyK+uTpsRRd4cNULg5WXRVq1EpW5JDuWikDiI1sgQI8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(261026121527099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9DhhbZjGZqcU1imMgilrhm6J0PnuyJBULn+/xCeoTKUThdmFoxPZn3D7jx1WxYOjL6fdriKg4hiTh9AMfME0/qAiSsaN3ubHsuDh3wtTpMp5PSM2pIAryZ3A9T8lF5zj4RPo6RWxukOOqymF5blG25EiLMWCNzP5xxo9PFTuHVvGH+fiGHB8weJGrGur+zYK7nMtNz/Ic9VBcFEGU6TdO/ut4fA/i58Xmvu8eaYsw0Smh9Kfgdzc6GcGgIpQ7LkqXH5xT+xhjqFVK2TCaBrr58yIPszqgF4SeVefZIN4dVDCt7ExpgFW4f5tVPW3A+z1tSxjupLhAVuAXAUnzXHOR/MliuflGprw6YrjxdLA22yLWuj/xUP97fU2d+SjVjEXqgBclQJOBJBW3UhfladS8uztXPkkeD3z0jO93uA2RUDwtNMlWNrMLfT4KvvTWV+j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 21:56:27.2347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fdc7dc-74ab-499a-e5ae-08df3f757859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507

aer_attr_group is a named group, so sysfs creates an "aer" directory for
every PCI device. aer_attrs_are_visible() hides the attributes when the
device has no aer_info.

But this doesn't apply to the entire "aer" group. So devices without AER
end up having an empty "aer" directory.

Switch to DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() which can use a single
check for all the AER attributes.

Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/pci/pcie/aer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 32a4c9101946..5ea81a506a06 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -778,22 +778,19 @@ static struct attribute *aer_attrs[] = {
 	NULL
 };
 
-static umode_t aer_attrs_are_visible(struct kobject *kobj,
-				     struct attribute *a, int n)
+static bool aer_group_visible(struct kobject *kobj)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (!pdev->aer_info)
-		return 0;
-
-	return a->mode;
+	return !!pdev->aer_info;
 }
 
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(aer);
+
 const struct attribute_group aer_attr_group = {
 	.name = "aer",
 	.attrs = aer_attrs,
-	.is_visible = aer_attrs_are_visible,
+	.is_visible = SYSFS_GROUP_VISIBLE(aer),
 };
 
 static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
-- 
2.55.0

