Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792570048;
	b=I2LaTLsnVwG+LsGZ+hjsddQkKTzalMaAt3TgVyw5ZGwZUOYYzdu7Or2wEPT9oMveaxAM
	 VQ5OXhBYry7LpTnviGDM90FLvFBMM2iFRXWhmqA9wkZlxY2gJnESDFh7cxI2sQIfPxBe7
	 qEchEWxzzhhAhrNA4as0Yo+X/6f8IQ/YpUPkZjyYwSXfbDJNEEPw6qn/1yHldSXHSfUfx
	 7atnc95MrbS0baf+CKom16aJWpL1AI56Ysmjj47Lw0u/o6XvkcxRH1CYdLLIh9rtf96Vy
	 TY9cA30L758S4tDr/QLYinZYg2EAQM9F4RONelMc05+IfXor5v/Q++Etp0blCOynmgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570048;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-NVConfidentiality:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rpc7aXjKNVMU22gEpuCrUoJPA9qwbNbP5ptgikv5yaY=;
	b=w+6Qnrh4Pq8ZOP6PtNKoiiAtPyX+QtzLNbqhstMJ0mT+CmbPifIw5w9zq+hMS3zhPqYk
	 +bhmhA8j1fyJ+tti2hwLkQys7GvJG/EeUVFVWnEMAr6h7TqzaHfTXobKhZX8NnEPVS9fa
	 zuKHgkZRykzIx+nSRQub9tzkGVhjkdP62FYJ+yYhd0/8LlkQ9N5jhUxJlJh/IL+WbDqBq
	 +QatgsAvubWT51evAGtkMSBu6eHttPv/haaLy7rmBDIKb5vTTdkvTHS8sx9mrGGWfLZcv
	 UaRHSmxiuGsTBKCVRTSSje2KMzqeUkth1JuKz2vTpscB4nDiGtecM4jt24WMOJOTUEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RIpIMtRH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.25
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915B606A319;
	Wed, 21 Oct 2026 08:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C915B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RIpIMtRH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLXUuGALdfGfX4p2ikj5lq6DDe2xrb/i21P04nxIJi3YMAJoZY3q0b9dYe0rFTXLCfhWPI7TtKmNuFQW8Km/YhM3urVoZ43aebXahuVpVM1gcFSP2yT+3x6zH2eMd4EBtmH+ObSkK1XtClzyzriEMuqsW/zJeVbXbDGCt+B0UZ3wtqeZdAS+/vnetw3MhKeyd8MgGt7KsipbRmFHLuQL75E1Bu7e+wtGzyvGWcDBeuVLPjmHUPls2KkKd+th08JJGIcpArV4AYYy4xGuqA4ptDvP3/2VIxVL5xHGrVaL0uU/v/tTUpao7EvY7JvH3yOzCtOnwg0EH8flY/XAMqmAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpc7aXjKNVMU22gEpuCrUoJPA9qwbNbP5ptgikv5yaY=;
 b=fPbHdvXENnq0wW5h/LTY6MfFxZi9cNgY1xlV9I6Mh7mHS41ZaXMmNaEOzg86z1NLx85lBskx02WnQJ365m+rdEPyIYh+twtUdNmoCOkJPNMCyeMAUZTch1t01WP9PFqLtmu3Ru1ckeObmMK5GWkY2/D4vj7M1WN5mhO/csPkC6g9L0ZMNxebwi2Ai2KOY38AlxaaOBlp3Yu4sOkvDXVyFAbrpxDwSGiF6gI0uEH5MUSV/tcy49iasIYfS8fc4geLxmj8rtSK2N8knsQug81Rorx0dzvdG8bKWDiArLjJWEZXKEMd3yiFVLxRXOy4sBRuH2yReDpWGYGOL8AOCuQnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpc7aXjKNVMU22gEpuCrUoJPA9qwbNbP5ptgikv5yaY=;
 b=RIpIMtRHsslCt/Ix5Hb3pnjKlNJgRvZmHvU/kVSr1aZuCPF17/aqmRlOPtPl3bs+ohk9OPlRnZlSiMWlOkHK4I/F4RniWD+7nGnHK+qU0wJMi/FahaWZLSMlewdaIusiIJD+7oGq/UFHWfjyO83x2ZRRvIUGVA3r+q/fwCO6nSObo1rx1HYArf3ApD/F6oRNrwHKBvd++FkBXBenDsVYmcj761fH9mXvOFnNbm5efjCw0OfaLv9597oZEdn3t7oGcFf1M7J+WtswfFZ0oWmYet1n9dbVsd0t5VzHz7QNiP3ah+yuYR139QfgvzC7fQb0TvGBsDglkD05WWgBg0Dr1Q==
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Wed, 21 Oct
 2026 08:07:23 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5f) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:07:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 08:07:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 01:07:08 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:07:03 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>
CC: <kishon@kernel.org>, <Frank.Li@kernel.org>, <bhelgaas@google.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <vidyas@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v1] PCI: endpoint: Skip upper halves of 64-bit BARs during search
Date: Wed, 21 Oct 2026 13:36:44 +0530
Message-ID: <20261021080644.1346549-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd2e15b-4e07-4a84-3087-08df2f4a5660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	v2SdWXJvqiF8qezvAipiUyAsFX5o6e9Jc2DZjb2Jr3kImkFlo3jNibcG3pIqljmACflXhbtFJjsTgqKdYJgX6XUMsMI36t4NnsfsK3SlWK3eGZRFfPU8kxn0D5946SGJ4YtjMJUEsf+hPjh/Ws87jk/DVma5UMfU9MO34wORivoc9c6t7BhCUarmsExsc4DyzXUp/OPrh1q4PnV4wBMQPJy90op7XzaazHhRqLdw0AqE6zDbYtOZw667BjNU8LZd1ICZ63opNneltzKGyIrVAF5CalwHo+rlE0oeZYDQ50sdmf5vdU9/sGJcgNE3rr2gmYeEnR3UJRajHz163/kE0SfXhkU1GCPTOeHvLB/A4W8vD0589XhWabGD2P82wlEvR1d5vynW+wt8PMNiDukEPGMpy+W9xfoczfXbwKwq9+vmNJPOtllK00kh+pzEpV07nEAp7Ett9tvlE3UfiFQ5t0HI9Hw+yiVENcy6HkdRQvmoPWpWPXyxbVAZ+xSEDM+tY9MBDjRfxd3gvFtu/f9dd7LBIbFJS5gARDoxwqi9Cwqzbcd8U6w3/ObXF6t6iGx3ziS7taoqWy4G30pGCUap44H4YdehB9DgDiWcyw2388q3dsjjiPIGBd9g4qqe7DwO66mw10/ygJ00oEqNyYah3TmHxJ93dEHI/Q9pKMujSQNGX3TRYJgbrnn+MCC2gPM0xuRdZY/xXZ4lDNYwOn13kw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5lDwl0n3sYy7OxX8hf6tiliDyxr3ayVRCcuS4Z9XAPPKcEUirEdJj4uhgqgxCyST75aNfubhpWMnOVWYAWM2QdRftJF6WYcSCefjRaHeuFNLy0oNtfFeqqKTxdMhXQe/obefXXeaRXi2VjuYTPbsvBfLZ5lBf0dEdHsi0aJuXZfyhhofuHk2kuI3oVbtq4W9drW/WYuvhhJlHiZkCLNoeF9grckzS2BfT4GXRjvPSdrcA6S7S/cqBseMY5NhR+AaYEv7rDlaWdyuylVnLes8gj/n9H7anFYly7BFWTAXSKe+3DW+LQyLogcEVdEmLAVQui/JsyePlu/TdOUnYckWEbwlfECJNyMv5NyXNgXPhjjXihSZSoTDwUx6YaPgjAJ935bqJwhwIo44Fyjz6aUT2saH+H5urMdeYJDwnh9FFAekb9ZaiR93fcmP/wn/QWFl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:07:23.2828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd2e15b-4e07-4a84-3087-08df2f4a5660
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233

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

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
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

