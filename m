Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422C46C4B1;
	Tue, 21 Jul 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649492; cv=fail; b=GujR95fZ7RfmCfPtI/X8D7rDqCjaBccNX68jhX9kPhWUHHAG11NCl5d58pfRgmPm4uGn7tuLeblaut39qlpNiimYtbyy8EBsH41+l87/74AlE/orChGc790PcDA1owwRtdTwI56HvDVX3iQpaSTQ9OHH1TJgIItBkElU17LmF54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649492; c=relaxed/simple;
	bh=HyMpFGOE40YfgZsemYJ3c+D5Uuf2Cao22ChH7UV10F8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZjcYYSiDvYHZgNJzpCVqzg3fkSDA6/juDAJtieiTLCadMXqjTCC81YKRoqEY8C9WeXt1bwHNbHd7DXbEoC7BZbJYNrQ/LTDNIWfCw3DFyD1U1pBdWUIJNb8jz73VJyvkSSpbb8oAB7uLPAIpTMIRnkEW8XNTJNTf39D8l4p+4Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=o4uyGkAI; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QvN7EoKQ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="o4uyGkAI";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QvN7EoKQ"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LDjKln3231775;
	Tue, 21 Jul 2026 10:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=9ECexg9MHu9Wl
	rjsn9DPeTTcyYXEi131txLVOLiFCmo=; b=o4uyGkAIecCz4JIP1i7NDFHzBmbKK
	OzJuIlH7yS6Q50AKcboMRGQg/rbDs42nGcnKOctjmcGwZa9geHIsxbBvcG/Z5ZOD
	pkDieB5plMHpUNHrYe4fk216Rq+KhQsfT1qHfiyscrofWPf42rWEX0BvIIfELDa3
	WDkloTYExauHWG0nLR24j9G+GGlV/uvRjPfz94JuPwZ7Cvp9cfg/8MmH/VaaYL2+
	Oo3Rb9V9S4MI9NtfY9ywA47q4cXHWbBhFlctqE/k1wFRKYsqHdgTV6xM7mS2Wolb
	mwtQc9N6hahXLy09HUXSle88Lnecqr1Z1gd99pXoyLJD1cvO8n37O9siw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fj869hj15-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 10:57:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5VonHyRfQJKEXKmcnz1cdCKIWGRD/eBbTEdzKFhNJCvI26yFHfCkN5DEKshqdQ+1JmLsFspwYSFoA9WJjAlKxZMKOowyDyIZcrPtqMcR8YBWyVC5bmTazHqIye2ez2YB+y9D7b1nn1lPMnNGSvvZawixg52ekEB3Ow6Dex+koG4khczD93liHQvu0UlEx/56x2yy+XEWpGZ5cLjYfdixx4aj0gh6eLVR4nOq72kqa1ES51wXoOqqXCyozx3UYEfwZGfpMXhZRcJgmeyjlhGCuh6g1ldh7+9G5Ly63zSRj/bH/3G/ZtSMUAojZFHrL6Y4hH6/3jo7TXDSR2PV0VdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ECexg9MHu9Wlrjsn9DPeTTcyYXEi131txLVOLiFCmo=;
 b=hZkd8CpU7X/+EpOiohHnK/taCQAeqFmshshFAns8kw+lVy55o1nvUFOJ+OG0knbqFFfEnMYCf6ETYbFU8u7S9cE+nKjfFB9HjkU4cc9zHkPqmRBFXYaZVMuXhDCDPe8OV9ppeHptvdkh16AhftF18ttJY7xF7r8OHfJgcd3ss04bCtnVs4jAyvaH6Fg3mHvyQasZNG+9fgiq9BZN0BUV9O7Dwyg1CI2w+1kf3IuO7NYD/yn9foF4Vx0ltnWlkPisXw807BC0mQlD8sBqE9lRONuesk8ijIGRIGg+/CKKTB4C+ylxOaenbmgr3fnWiPewnpfQhD+SIgk4rZB0zW+Rhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ECexg9MHu9Wlrjsn9DPeTTcyYXEi131txLVOLiFCmo=;
 b=QvN7EoKQTswmTyKYwTIFePZD7eYyVij0Iuc8lbQsFoQpi1BVY1UcCLcG85AAv0cahc/n89mWhJhxyuJ2eyK6u2hid1hQm+gED5YVE7yEkA+szyEtZe9omjjmjitlOi1lk4JA6vFW5fYig6T9GhyNL2efUDA/HUWVhUXT9hsdfIE=
Received: from CH0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:610:75::14)
 by PH3PPF1D715CB68.namprd10.prod.outlook.com (2603:10b6:518:1::78d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Tue, 21 Jul
 2026 15:57:44 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::80) by CH0PR04CA0099.outlook.office365.com
 (2603:10b6:610:75::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:57:44 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:57:43 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:57:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:57:43 -0500
Received: from udc0488417.dhcp.ti.com (udc0488417.dhcp.ti.com [128.247.81.71])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFvhmr1075688;
	Tue, 21 Jul 2026 10:57:43 -0500
From: Takuma Fujiwara <t-fujiwara1@ti.com>
To: <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <mani@kernel.org>, <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: j721e: Fix incorrect max_lanes for J7200
Date: Tue, 21 Jul 2026 10:57:43 -0500
Message-ID: <20260721155743.3347659-1-t-fujiwara1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH3PPF1D715CB68:EE_
X-MS-Office365-Filtering-Correlation-Id: bf511526-0fc7-49e2-1721-08dee740cd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	0YnLiJadx66MOPPx5uji+m5Yiyd1kJoZD3Tcy3Ys8uNbR/ezCtZwHjXrsWAAm/VmFuO6JbFHgDVKBuBfLzsJ+jVRQSJrfH5k+82uc5xKLJpxcr2KmsVblyAYOl5+huqckymZTBp2d4w9lO7lyZBXcDWtkv28a5W1qJnigk1xd8+CgWOPwUxNKF1FvluI/mPHvg1foyB18gCtW7isiNLwqLybPlVIqvp7C8girAe+Z1yJbi9F9XQUNttT8/yZ+emLGUBsUhEVCrOXt/dGenWmUanyojLt/t6gV/ZJTViRYZhKEf7ZSES1KLYh5+/ldsUrf5in8O4LMPHd5WwV1nawAGspWH4M+V0ofUn8iX1AwHxSd0wb4iK3vB96Cudb8BrvOxwC604vLqnkS2rQ2BkvEI5SVoRKN4QCcpJRhHvy2KH2tXPPKxfiFlHEeeg2Xml9ctlHRes3JKKT14YaT/XjQ6meimTmROYm/FQvQ98ygJ/OV9pu6bzzf6G1/rQBlQDwpSJYcuIFzx/tY9BpOaYK4GWmHtip4ADvl3qNHTNPh913v4CSQ9ZMgMYz/IICkzAGQWUSZ8y1P9qtifTh0RCIAPOl9rP9AZfTf4gqPemxem5FGUBr6NDkRXTeK3Y6ehp6/Oip5z42+qSJxH8CNuQRpBjtwJFFwfJMjv15BcUAW9IEonOHWd0KWYHPHOUdVJnqRYan7MDFZBqvBRVw2Dy+ew==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uLYmmKMhT/+THhENqk5csQhVpYHyYdvorSa9+9d0aBzbTeKY6vUhKktjgXnbmn6ArQpr5ulZTZ+/MT9852CIQzCkaFB61YZvMmi7qC3oCPOHVUaNRXIAwIhLp9QPihN1Ykw5sBUnGcJrzSg5NdJawr2PhT3xZ1XU8ygOoDX+tMHB0R46ROVvO8hUUoMiWYQc3Mx1eY+RREGKeydZQdwfBgWNclnBN9/OYT8FV2CZPaYnI0CrWJV9TfXN3U9zbxhYyfhaydZ1On9mnb2AzHuudfl+mu2VNbU3A7Zkqd4WDDXoEqyff0BynEWB3KCq/WCUn/gxLusDYqFPfU41UG0A2sHCuDp+AxS5BhdWPFEJzZ65rriSVtfy0ys5BDvBmS7b1LixDOAysFELZ7fcvlUJWuiw/AqOjojgSTacj9y3GyKDsLGzCb7/ipggi9FRB+eU
X-Exchange-RoutingPolicyChecked:
	irzxL1hzoB9J7uT9lR1FJuoV/8OCB64Q3NjxSM1Nf8ccInM6YKeyqwSgZIEXmvkYd787FWYTsbOqCmeJinJC4zoDz4k5FCnQUeCMyZbGAkx0kxX+HtDar/pgtcSgn5C5PNkDrpYaF3QmCwvYpeli7Oo6kdzNm7jUv/02sTl4SGrDtIBrg67mwMIfkIzeUrygbVqRCJAHGz9jYu+tqZnP2JaENmxC/NSLF8N0A1h9ZFrQaLBnfaa2bCyjIxVdkANIK5yhm8isG77SgvRfpOC+Q+GAm3ODZhJMM844r87n6IrbuTOoXORdiTt83oV84wKWIyqt4Wjqhl2+obWWZhgHQA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:57:44.0217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf511526-0fc7-49e2-1721-08dee740cd48
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1D715CB68
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2OCBTYWx0ZWRfX2c5r1VwgyUYk
 vVlp0sPDHfMhwOJCQWx9TUSDJ4Q672LmQRvIDL0LZWsztJu/I1+LHVfyC+oF2+ZVbX0LJV3UWKP
 ZCxBp+HM12UxV7w+jXez1+MwYMd6xOM7kRR5QOVRIBeBhnF9xZPAN1A6+dUA6+usRbMW5XI4lp+
 l+lnHX8dnwpKl9ephEFNLwXRsvy9y6DkW8q03F60EW184V4As2Xg2xnHcrfWVD/C0IAakTMcsDi
 7gQz6kFGIuk/4As8HOCc0rYVKU8zY4oQmOpaSnCSvcKkLccYWU8iVU9YD8JuwhxITCbmbZDLDwt
 MFf9Lxmt5MQsISy2sMpQND1u8j6cXXRkSAoNLo+MgPAX/vx0YXDGFT5ZjGxez5i1I/b4A5ugVj1
 Oj1E7IlUyp00Jf+5Ucwqkt60AS9lDOgChKd63nlrT1EwLpV9tdVn52ClOFAAWAimD/xXruzdfXt
 1Ilf6S0l91cbjhoBGUA==
X-Authority-Analysis: v=2.4 cv=WbI8rUhX c=1 sm=1 tr=0 ts=6a5f9703 cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=qMGItftXEORy81xHaKgA:9
X-Proofpoint-ORIG-GUID: syzOhcue8BZBvScaKYlqlzFdur78IvYV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2OCBTYWx0ZWRfX6/swKK1fcCRd
 eXyAVaExAtCw/RB1X6jmKSIGp4Xn9Lpfvkb3RYhLPZT1OiT9p6r6geO/jCkh1SKTd0e786P2Hwy
 hmyUT0gsAx6aEKIUGCDFmVjQ5H5e5C0=
X-Proofpoint-GUID: syzOhcue8BZBvScaKYlqlzFdur78IvYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210168

The PCIe Controller in the J7200 SoC supports a 4-lane configuration.
However, j7200_pcie_rc_data and j7200_pcie_ep_data incorrectly set
.max_lanes = 2, limiting operation to fewer lanes than the hardware
supports.

Set .max_lanes = 4 for both j7200_pcie_rc_data and j7200_pcie_ep_data to
match the hardware capability.

See J7200 Technical Reference Manual (SPRUIU1D), section 12.2.3.1.1
for further details: https://www.ti.com/lit/pdf/spruiu1d

Fixes: 3ac7f14084f5 ("PCI: j721e: Add per platform maximum lane settings")
Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index b29a35fbfb5f9..a029c4e9c05f6 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -381,7 +381,7 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
 	.quirk_detect_quiet_flag = true,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
-	.max_lanes = 2,
+	.max_lanes = 4,
 };
 
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
@@ -389,7 +389,7 @@ static const struct j721e_pcie_data j7200_pcie_ep_data = {
 	.quirk_detect_quiet_flag = true,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.quirk_disable_flr = true,
-	.max_lanes = 2,
+	.max_lanes = 4,
 };
 
 static const struct j721e_pcie_data am64_pcie_rc_data = {
-- 
2.34.1

