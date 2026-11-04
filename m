Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793780619;
	b=JgbR6oPw7PSPJq0sLGsmtEnNaUYbpAwHvbKYlzYW0yL78KYqydcOuwgcOd0lF1GYd7KR
	 BmsQ97QRqBMBk5vkEZAaS8mSeG1rM6yyaZ+5x1iKJKsD8HIGb1IsLz9xiV5wcpI0W6yA6
	 kEO/no1nWvpnbOXahn9ar9oywRNyq9JvdmBN9lpB0duCaqM0PZ7j9ROetQQk3DwJvAXkt
	 CQv/ti9isipwdQmDgC4hnuKmjFOCs5rlV2/M/Cyv+MGe0lw/O4LfmvbM6pmNGsvUXVatn
	 xnmUYxJbdeeYb6q4ED84sPfeLlzKE9FTuymTek7zXxnBUsc8YEjijiZoCeU2ZUqb81w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780619;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	bh=dn9k7bVfc/ZSfPM+hg6a1UCR/RjsCQqDoQb3gblawgY=;
	b=ouRWVd+6Tt8dPQpOB/QIS55MFqDAdPphTf+AjgsqHsBQN379I1A2G9oLD1uWc8MJSks4
	 X3M6f/koKMzJIT/BnCX8ItdsFEGJ1aUz1pIe7xiOvI6ine/Qt0s0aAiVd0AKoYCrJA605
	 GkFq4UwAV2hkkr00XWvoF/ANVdB+ariDOsbXLfCBjJnnvDmQkD0uJU9IbxeWGNAAhR6bS
	 gyElk7vfew64MYxqjYR1rNpTg7L0eonTpjTvy+Tikgv1lS5Hh+NpxEe+kUL1FGC91EIAv
	 NvHq5HgBiR8siF+165AruXtvqB/Zgs6LvYiSFV2g7kOWpCfpE8RFpB4jW5n3LheJTKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0aB14f23;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.41
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1C606A328;
	Wed,  4 Nov 2026 08:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A1C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0aB14f23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEIeWHi8ruV6EQKUolIsnEvYA+3owggp5GjlZdu84/MQVENna/NRSWAkK3yYfPQOMTSVKd5aOjqYvKV4iD6TT/tke4I28J91yswSz/4tf1KQEBsqZQZOBy9tiOC2FrL+Zz42RPHDEngAXwShVYJSl0bG5FTYjMMnlrTRc+Y0xDbEpiK0xpvVj0XC/Arf0jYjvy7fV6b+BO0PLzW9niowu9vBbyZOPk0jXyqwGLRlkB+7KN07Wl+MhOoh9RdOdF0dKsBjZlXNfCSQnuf97DjyXtu+KNpGFH7sTaMouUG9lg7HfiGcVlz3toqMPZRluMiHEQ7i2tC9RLmDWyat4Eu4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn9k7bVfc/ZSfPM+hg6a1UCR/RjsCQqDoQb3gblawgY=;
 b=LY4fzHvWJ62zgT2Cp2xXRUGP/Dwud8KrkY80ijTCbYhSBWjOaZ7/8r/p7/eKFkhuHcIonkgnf9WDD+J4kqve3IFpcXHFBG0SZsyXygBmFpriv/Lmmcyl2lUdtTSfbJ6+maEbU6uE9I0ZQuHrK3U3FfFqbwZ9eQ5mEzE9OSl9A/4EAtLNk9QkJ2CTMdYwH8GxeCJzfWMUn5e+5x7ZVaVyUJqGWTc4gJ2aeOQq1th1FwU0fV/+O2C1t3S3vymO3d9SZOceTtfQ/b8mtrAAZOYiDsDPxCtMi6GOM0q0KeCzv8GXVxHFf2onZkdepi7izs+M+nYMPqLPBbcZYslUFT6D3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn9k7bVfc/ZSfPM+hg6a1UCR/RjsCQqDoQb3gblawgY=;
 b=0aB14f23yBbQzTzuSL/He5DzF8Y1oLQmsUwUgqnCDyy2Mx3hcAy8jXlEYOAPiwuS1bYZ1KsVTf3uf8gdCE36tZ17tFX13D07TzcySo0bFBbJIV9Q3J5ohhK/MyluwXmCd2Kl84zPN5nHKvpXwaMCnL6yrY15FWiEVqqMfJn5Inw=
Received: from PH8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:510:2d2::10)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 08:23:06 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:510:2d2:cafe::61) by PH8PR15CA0007.outlook.office365.com
 (2603:10b6:510:2d2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 08:23:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000057.mail.protection.outlook.com (10.167.247.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Wed, 4 Nov 2026 08:23:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 02:23:05 -0600
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 4 Nov 2026 02:23:03 -0600
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v3 0/2] Macro Ordering and Typo Correction
Date: Wed, 4 Nov 2026 13:53:00 +0530
Message-ID: <20261104082302.3819409-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000057:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 98eed75d-5677-4a88-cf53-08df3a4cda25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|13003099007|56012099006|11063799006|261102123227099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	vsOK7xId26kw/M3J1zAs7jt5pgjmem+sGXUWXL18QwzHM9GQUKYLEKSH/t0FL0cz0XBcy96L6dlZEUBzuIwM5zBcjUh462ufmGsNEZp7TZPM0jds3CUY8ny3zixf3J2IJx0VH+H/vto+kdNKQcg7c4tB8SR38WRCIPfnUqTZKmxxRAGATpODLZWlg70JuhISWU5SdPPmWK6xw5W+F9zBRnT7+6GtM5FSt4WK8sfyEUQ3pR9TZ86pHPKPmsdJqbjwux+910McYYw3xO/CiGIj+2AJ6sKXAAD83cd/NBNi/Lf1z3samfrjmrC0IaiM8KB8qq+sVeII6pu6uLSbxSP16Ex0bDxhHBLQYG+9jJuUjuHteyZgjIAZjgwtjtEbJk0d7OLdzXw28EJQyVtc9jkNUha/PQMvHZhVoI5LG/XCZ51PPQdiIOPv21jvKO2WctnzlphXQT1CLf7p4Uq2D+V6zTAs+I8kgE5yzOO8t78+SjL8WAf6oD6C75tMbms4C8uKI5gDIfmTdLZIZRQu86mYn2YP2UPLRwosgJSBK5qpmtxwwVJcISl78erMszLJQVnJ4czjIwcFGvg9yQ85eJ5niX09tGrui+9VWLqOOFqg1gsQHPNdbHTc9CdYnmKy5P2YHc3IppPaeQzJh/t2wWNNyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(13003099007)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cP3QxN5YH+c50fJp4Al+N24T+EX+NYramcMEq0DN5zYovfwF3QZ/aH71jmvNQaKOHPjt+cwvxaTjGbIzP3l/xTDx+U/GMXFuImr5/EKwQDKehA47voFFCcH+IGc3L+QpYUsGVw7haaYY4kcxlD2zr45Oaax2FYC4ln7EMtZNsQepzp7nyedY6Q+lNI/OGiKum9tKTvl2cyfcxVlOgUlxQxQOvOt3FDqFNDvBOA7bKqpVuC5X3OyolqDEYxrlPPBpOGMEE1nTIjME709BsYcuUBNr3vWxoe2OhZQTqzugm9q7/381sUOeZi/Uz3dsQnQ8k2gjopwdsJ/OSUl509xzpdFKB6Drfl59iKM80An2+WkUAdUg5jxKC9xAoQFo9IFWZ34lMNzWtmtyDDEXHD/S0nYtZd4TAxdaGqqtyxb+cwep2N/lT6jCW2TjytB6VMbZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:23:06.0846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eed75d-5677-4a88-cf53-08df3a4cda25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508

These are minor and cosmetic changes with no functional changes.

o If the macros declaring the bit positions of a register
  are in order then it provides a good view. Corrected
  the ordering for one such bit-fields.
o Corrected the typo under the IP related data struct to
  have the correct name under respective IP structs.

Previous reviewed-by tags were part of the following
review:

https://lore.kernel.org/all/aoW7vxy2lpXEbmRq@SMW015318/
https://lore.kernel.org/all/dx5jvko7ygrqugzkt3k74l3d7lk7iauikmxrzuhvn2b4bdv5ub@s2l6zl3alx3z/#t

Devendra K Verma (2):
  dmaengine: dw-edma: Sort Register Field Macros by Bit Position
  dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment

 drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

