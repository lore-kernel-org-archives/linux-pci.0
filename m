Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618628;
	b=AKSz+7Lz7zecQcvnlDZKlcW7tRjSyCgbs25stwhMsJUUpv2zzGnEvAGTRNm5r0dshEmL
	 ZjFQwoMODSgrUpGjHM75jLf56AA4EI0OxT1ZTf5wGAHfON552v/QZiTQGgNlQmOWPv1AF
	 DlEOMBAYRvtGOi1t4qkkQGKBmsHGOk/qfSVHVrXhUEhZCYe3RM6PXs2GRWSFsVB1R5hG+
	 kRmT0gkyTSsyIHWDSO/bnQ+dE59r8fmDnYjk5uvt4z/XpczXTpN/Q+WOQKG+0YhbPvzR7
	 uh7CEWRE7HTo/ADkYiYztlqBU7cj+/qVfrPxuLKfIDzLWHy9NZaeH0Sjq4DqEXxHsCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618628;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=2qToKEkFWE5SALJkn4fCzyvJoJUWxkJf9OYg3fko0MY=;
	b=umoNeht/fWjF/Oh1z+xPwQjSNPVEdj8HGFPOH3LbNf2HTR4yKgGHWglKfn0kpM+W5/D4
	 CIVwvokCUWDURO/7HKZiN5+lgSuC7z4q6hy1xI7y+cTsivZdIILCFYcgU1tVSXKkmwgyD
	 vKF+0AlVZ4v0S/u2n+7PO0UD/SIs43jCKvTmyOohGCOSKRQo5ZjeCstwSDeQV9+qKPuG4
	 3QmDQd6QrRGKax8rw+wZ3BnmEUctvcYp7V0pHabRfDFDmLzrmYkHZEipQmaQnRpq8UK30
	 bVJMJzzrQO56Eob61MTaGATe/uLEJhIKDiZWOn/E4Aoq3aRUkeVI6dLVYr5kaTscTNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lXcYfdCs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.41
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BF60A6F50;
	Mon,  2 Nov 2026 11:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA6BF60A6F50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lXcYfdCs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX2u9P9NfHiYieowjg2UYXpePDb1VVYlFw8YUAyn5d1Ai6kJM9fXDjBhfxXMJJabLuB2FWDo4EutEPzeL7AEf0jQTrLm9z1UoJ995sfLDapVkNYhesB4RqUMfcWGqKN6BbS+aCIxxwpOI9kzDGX08rRvoLSDW++RbPD5fnUJZkd3tleOup+EcM5ecUveOlyw7tC6A+mmKJW0/sCeHvaiwqkQN35OrTXBVWj1E3ZGrveVKiI28tOeuhJdtrUCYWm/i9h3xDukYpEhPrVPwW10JJb/zKsnqJIVzcsUfGks4uM/ybXH7MiiY9XY0Drs4RUR9ZoPORxthlnKGeRsFJReDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qToKEkFWE5SALJkn4fCzyvJoJUWxkJf9OYg3fko0MY=;
 b=FrOQA8i/cvA/1E3EXclyfo0dR7/8QRFBu+dgS4onYmL532K0Fmu9IewwT59Gy7m59bZlUifASDtS117WKhbZUALw6XiEF9hpIUOlR8mjzeAiuRqekl1tUf6fDR+9QAXgsMl2mGo2phV26apgImYX3QzZrsrq1bFd36xXpN2HH/wyS/VGVhyPft3uFxeZN/atgbCVoaOR1JkFgUUP2GtJzVIkGi4tyuy5u1f2ZTlqA8jXhDf76aCeVK/d4Nv6BeP1GQVdS11ZoODe8j/XmbOy38RR7iQVXtrTjFsafVUM2NveIXir/gL3LciTbgKYNEyQHl2zblp/UwLyUIL0uM6v8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qToKEkFWE5SALJkn4fCzyvJoJUWxkJf9OYg3fko0MY=;
 b=lXcYfdCsX6josEJxSzno+jxTIVzu/8IKYelOEY/LIOMkreZnqWINKHMdGH/CU9FdZb4cekhELphL9JV9Dg8L3yVeNbV16mgntgwladY5i585+iePOkoREkLvK7JrG/B+XDLD1R+as3lsKfFuQRAvmnqwnIv37iR03+88Rgekw5GMQ8dtpqfnrK3iPO4/NuFpUMC58onvDvjSNneQGZy5vHq61BsmNmR5TVS89ekTgjrUmBnrw/6JwKbhpHufg3kkgvxlA2Z9iuIHCJGD+oiBGAyoFsHBKi/rPI95k3xeVGM8itH0+FWQDOUSIDpDJmwwn8UJ/kTF854PUOBEl/U8eQ==
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by CH1PPF351A22FF6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:23:42 +0000
Received: from BL6PEPF0006C3DD.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::4) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 2
 Nov 2026 11:23:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0006C3DD.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:23:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:23:27 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:23:23 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>
CC: <kishon@kernel.org>, <Frank.Li@kernel.org>, <bhelgaas@google.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <vidyas@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 1/2] PCI: endpoint: Skip upper halves of 64-bit BARs during search
Date: Mon, 2 Nov 2026 16:53:05 +0530
Message-ID: <20261102112306.4018464-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
References: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DD:EE_|CH1PPF351A22FF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c32867-813e-4a5d-1084-08df38d3c037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RmpRvPTxl2sgMAZMNGE1DZhXxf+c+yC45oLKisD6huzGMf3aI/KH8wLKkiuFU9P/YTlYkgf5FzFVWkR92diVgBSaabb+O3+aD/5nfLFzvUEg5NJuaKYZWDu3JPoPmv1Wp0FGlLQDHbra1O9RT3XyY6PNDd6DNnU/G50LIs1uBSyEpn9Y4u74B1PW1NXrLlI/ncYBh0SnFcfOtPZg7pCwtNb2b7dM9PxW2/4hcHszi1qAUQUX9zvUtf0WTMQgex4nsXoxDgj33mzudflP2HRl0M/a5GuKEgT1oHirr+7H7ds52/TLnQ8naT8mpW78NFg0YMhYU7Q9+f+9thOZ1YdJJEVxYHtB5tfc4m4YxBu+iH4hL5yRw71fNTHQ79E+neXylINk2Umk+6lYivhb3Eug+dSyQoM37elIJdIvjijhsIZokYoKV/pwaAKUCjgJOtOnEilJm9VGQyR2uQNiR41CJFtGmzfbp+6vDiGv7TjLYGB3ck3v3qc2i0jzWmBXW27zP+zaDFIcjB+AT/psDFsWhU/qaYHGuecF4YLinSUzM5fkmx1mPv1M0cFxYFytPtoKQxG1KiGcV7Wj4fLWu7WO9mktdi5oi5oYoZZe6fsXp/l1qfXLf0QDrlQkYzUlxD7dCXOXkYwaWcrcrJHStj7P4P3KGneO4EB1F50JjiuvHnVbTYZpF8Y/E3kvANtKSOBquCZYaWMicurXeT0jcPS7qA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	InU6DiizEkpoQhNSCqzO3iERNAY8jckzvHrOnIJDoKkithJZRUUCLcm1J7I2GrkUwyMuTVHOBSPUY+4oImaIlD6xKjN4cnHUCeKKkFWs2tUR0jXLfXMUjWrDxY7YWuc5nQXWoqCR3az0msCJxugDUcalOdk7iJZpUA5YK+mSm9oalpInKZiVxgOMUNauzBkjruIMr6SYAnxa7Q/MwxqOAnXSEsttDlLmwRvl4HNVuVI2yLimux/wDJdCC8KEye65/+pDVT7zanZZ2doirzun4mu5dUTedY++o34kazPQknyAS/xnM7jBZ6/Jo2bjniOWm4i6EXLXcUDWEkUAjA4D9aNd7k6w3KsJ6JQ6cejKadnOL4GhbmWWSH3b7oNE/arxOEFISQZuL3bpnJk/rJ7bWLfVP/crCAjOHGffMqbHNIERAlTGNRKnPcR3FJ/rApzH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:23:42.2237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c32867-813e-4a5d-1084-08df38d3c037
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF351A22FF6

pci_epc_get_next_free_bar() skips the upper half of a 64-bit BAR only
when it is the starting BAR. If the search subsequently passes a
reserved or disabled 64-bit BAR, it can return its upper half as an
independent BAR because that slot has a default programmable descriptor.

For example, Tegra exposes a programmable 64-bit BAR0 and reserved
64-bit BAR2 and BAR4. A search starting at BAR1 skips BAR1 and BAR2,
then incorrectly returns BAR3. The next search can similarly return
BAR5, causing the EPF test driver to allocate and program BARs that
belong to the reserved hardware windows.

Check each candidate's preceding descriptor inside the search loop so
upper halves are skipped throughout the search. With the Tegra layout,
BAR0 is the only available BAR and subsequent searches return NO_BAR.

Fixes: 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2:
- Add Fixes: 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
  following Niklas Cassel's review.
- Rebase onto the current PCI main-based patch stack.
- No code changes from v1.

 drivers/pci/endpoint/pci-epc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..8d0df9fc1df9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -98,11 +98,11 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 	if (!epc_features)
 		return BAR_0;
 
-	/* If 'bar - 1' is a 64-bit BAR, move to the next BAR */
-	if (bar > 0 && epc_features->bar[bar - 1].only_64bit)
-		bar++;
-
 	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
+		/* Skip the upper half of a 64-bit BAR. */
+		if (i > 0 && epc_features->bar[i - 1].only_64bit)
+			continue;
+
 		/* If the BAR is not reserved or disabled, return it. */
 		if (epc_features->bar[i].type != BAR_RESERVED &&
 		    epc_features->bar[i].type != BAR_DISABLED)
-- 
2.34.1

