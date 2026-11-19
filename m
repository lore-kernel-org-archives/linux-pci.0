Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120393;
	b=ZJQFllZKqUvBl/0TLd4xTrHZt9Ox1XyLbiKevdT2u1cBUyA70rt3ybEnQzduocdA5Upm
	 QW5GfkonMkl3s1K991tZQEtrexMHjVO5xaKsI6SDZArjMzpVI/uhL01KyKuThrAMExtan
	 9JicZCxAuCxNIrzFiJrIeMxuhibkUtou8WU6viQ4lld46MAThwSlD6JLYifNPcnBHfCQk
	 EOHTrHCvi2sRcKb/yM/sELcpslfAA1t+KSIaJLEl7jKzQwRgSZ91MLBNkxp5doippufwB
	 WkqYtOq+Hn2Y1DUYyB6elFfWAd7kOHoP7YZs5Uoq3UVJ9dkLmM2iwlyjs4d6LmUSpRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120393;
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
	bh=BNCgtGTGh0Pk2D7c0Lm6QEoXdYL4HaT+eu7h/lDar44=;
	b=CwFEflIKFSUjUoy9ImGS3sPqHRA5KXAzwnFhGZbDxum0IU68CPPoVZTMhTyXPNIqnA/7
	 WEFLGfBsMdTYQXpRKR3Drp3W7y7IA7pLIpuXxXM1xXPvxER5cFJEh78La05SzknSFcmEC
	 kj1wmqTjbENaUMesT9ks7DeOZb2ak6TMJFvzPce+8Htylt/dP9eLL4+JIu+2139oR7/Ct
	 O2+P0lqewgcOAUdZ2m35Nd1Hrc8vEpZJkpCJ3su6/FqdYnIS85MsgrnAiqEcqvwZoHqS+
	 gg0hIIV678uZxGSDBrB+9lRUPhUSJGqoPq67mtAn8JZA2j4yxYLXwQynVcAyLfHbxEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Aq8WTzVp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.13
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8760A3822;
	Thu, 19 Nov 2026 20:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38C8760A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Aq8WTzVp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBFrEVmP/91nGgGLcDBQPnXfIKVI+O/isCPnHAajzz3y5yB3R08rrTttKmWTz1e0pD826OIKhDNM5Sf035Dt5mKacovcBB/BNe9JJWnEHECzCHKSnXcAV+gIKEfZo0JviPji4hcX4DOTnwNTykLBhUonCd8hnGTAIVXsN02BAsDhy9wFhMWzNwzN+aky5QZQoRCOkzWx/Dj8JDwYjpSAD36iyBtqmMyMF9EIAxcJkc18lIRRpI5m3iBR6te/jEXUV0eMo27fVwrl+U6JRpRGnhF1LChyClxI1GX/J19GVu6nHISA9R3nlH0FhBqGwEdfP2bWOYmoX0BQcuLl3uDGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNCgtGTGh0Pk2D7c0Lm6QEoXdYL4HaT+eu7h/lDar44=;
 b=i/VUiHfZrXQjIystM1hVi6sAXb+LqH1ba1lTACFiz5zsZrECAW5SJgtPiSYX6Va3ZO4IoeKFkSO5ltIYH2MSiXr4rDT3BFlACGV9UIz4MKGOF8QtCOQOoZSInGMHfRmhBpyw0I0hhSkVUWDm1BiDPbtaD5xuPcvqzEL4C9m9mTOiQCk2vG4F58oRaxOzxnkFB7a8hVRb1EDmFRt6rI00beiS21bWimIswBwkqB/xARtSHPQf/fzy1Bed4TDp4YupHrG8vSTaQAGcbLnuFkBEryMhMaiQNt/4DMUEmIyp0jIzeWWJcaC29QuNp13KkShhn3PCL8PQQc3tfqI/61O4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNCgtGTGh0Pk2D7c0Lm6QEoXdYL4HaT+eu7h/lDar44=;
 b=Aq8WTzVpZxlxV3CDFvUsxYk4Wvq4mDIdKLdZvtcLNlXbp/Fkh9UMuEPfP5GXpcWJPujZ3uctglFyxLgW66g2ZMIxoenAywu0HxL41oxXBd0LeYYtfmxrVcgYFvGZmZvhTZ61ne09D2Vk1+tFlYc0DczvI1H7SdedEiYNnamyrsI=
Received: from CYXPR03CA0037.namprd03.prod.outlook.com (2603:10b6:930:d2::28)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 20:33:04 +0000
Received: from CY5PEPF00000E86.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::a2) by CYXPR03CA0037.outlook.office365.com
 (2603:10b6:930:d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 19
 Nov 2026 20:33:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E86.mail.protection.outlook.com (10.167.247.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:33:03 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:33:02 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 44/44] MAINTAINERS: cover SDXI UAPI, vendor files, and selftests
Date: Thu, 19 Nov 2026 14:23:20 -0600
Message-ID: <20261119202321.1734355-45-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E86:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: ac790d18-3498-4cbd-dae2-08df467c4fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|6133799003|18002099003|22082099003|11063799006|10067099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|56012099006|261021121427099003|261009223027099003|261102123227099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	0ElL7yWsPnz71MekYDWZBrAStiM+XPO5LofbJlTu4pUllu9gu48OFL+1Hmv0YJqLkm3NAZ/r295jqzrNj+29tLSIwWMegu8JGeNV0ANto3z5vG0f4zUZakzu0qpwnccWol1RazZLGmw8zigtbpHfDL6RPgsUuA0v2culR4kXaqxWT7xtLOhS+if3j3lH9FV+T/djseT87RojBq2TYyxEOsO+1GhYybGqHuJOYb62Pm2z63XrB9FMjEcA+rp3/TytiVPOJ/rPRyE2L/MNQMeLxG38+sziy9rMebDgf91G9rHD5Tpkwmz55P6eS4VfQtAW9canl+UDwTCHp0JQG7wqryL6d0lbBsIYofGm2dsYtdBUPknVA+L/fxzp7USHDNK31ZnStgDqt9hurt4+kUUKrASq6Ibis/vrKUvz9LdNGHrgFI5lUPv2/qbyZmxvpM2dmyZHj0J+E4DEruNm0L0yjiCKPLseHu1v2Xx7FdVkmK+Vbqol2ZIQVkjP1a8nUIWiS8CUqcsoCVa8QXK7/6bfkcCNkMMraDAv+glNLPpUt2FRABWN4CUgeX69OHQ0oeDiqnWvL8OXv1czw22IjY4PywOi7NZJ6j0wsVd3Nvk5cRW7GGFqass3VJdPFJaGoVuyGZmmwEjjtIcy9o+XqcXAxdg3wfiWmYzpaHHvMWby0BUlPVE4IiXvhw7PNQiE1lGbQDKALU1YYFIpyVQw/CBeVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wjkUA9Arrr8QkIrfaLD/6psNRb61zgLBAvY3d/faICGEB1Y3TP4bfEngyLPzJeczNLN4H6a5l3OVMIwxqMgtcPAqRQJK6zUhwjeKfhzjxeVTjY3IfOXUsMT0Xa/GrtYasW8KZB3oqLHDf5Vm/vwqfWNPQTUaausKbt7D84us572a19ys8ZfJ3HwOoGCfEdLbGwTCvN2vA6W4YikLeTkT7BGmndDeuXfrJwNbdfpmUK47qk1ELX8LfTnVStXp9BMzhOPqjEO2maSHC14dOQrid3QPUBQoo+Z8tz3tkFni4xSehf2v1kkzk/RXwzajTkb9JgikzsG9zuMFyHkpSJVx94dWXGBczgxdXa9gWlHnx3dEczypUMlx++nL8blgguO+KcGrJauGHzFBlpLuZJHP+w5AMRxfIqEPIRUg4/nf7h50cIda07fbFQRmFaW7ZLgi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:33:03.8779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac790d18-3498-4cbd-dae2-08df467c4fdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E86.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450

Extend the SDXI maintainer entry to cover the exported UAPI header, AMD
vendor support files and the SDXI selftest tree.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 721f06446435..63197b02b419 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25287,6 +25287,9 @@ M:	Wei Huang <wei.huang2@amd.com>
 L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/sdxi/
+F:	drivers/dma/sdxi/amd/
+F:	include/uapi/linux/sdxi.h
+F:	tools/testing/selftests/sdxi/
 
 SECO BOARDS CEC DRIVER
 M:	Ettore Chimenti <ek5.chimenti@gmail.com>
-- 
2.56.1

