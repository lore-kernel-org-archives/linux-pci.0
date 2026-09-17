Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412E4B1292;
	Thu, 17 Sep 2026 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641071; cv=fail; b=EgK1FQAZeMS0szMCnnrseqJJOk34uu92ivwSMwYO/DpH0fAtCpVgYQd/hAY2EVLLiw+OPBTCgtinxkv6rEIbgQ55ejOV1xlQrPSkK+wGgWoCOaveiNXg2sd3ubsvFcEndZqO8U0ZSwLSDyfHceuf81xZQM4vUhClPwTjDYli6CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641071; c=relaxed/simple;
	bh=zrXTtrup/npbIoDU/RAxyVOp0tAcLrBYeo2UjdMutB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FuTxVqHbMhkv604DAFUd9jqcfQnHEyI3qJSFmUa21VxDSNIWkd0/LYRjpooNAWAWvePMdfM81apx5wkK/5r803XqS4z9PGOwJMdvE5vzLRSBf+gBMWdVYLPcOiVDZsMoMY5O7Aqeuh788ANO8dwWI1hEuZZM1tIHGgDRkfZZexk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fxj9/nFB; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fxj9/nFB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwdDY5wNexNNt9/RTrfWJ3Xuc5YHK0aAxHTDU4NScs/rWRHabc2pEBDV/4c12oqiF7HzSScx6fQttdR8kpTugsl6lz5gNtr5YM5scLHwfoS311zx7uw7XfBZtXsXuYnqc4pHCV5gHv3gP1Fo+lvff+/lxv7f2U5U9625KR3n+RBjv/tCrPWbEV3RUZdAjZgpCy48qmIdPqN8GoKsBUVzoQJUrSgYBhPsh/RUz8qY7LZP92nUB9l0W7OcxdSrNZm+Ge7l3UtLCR0PRufwey7j+29AGgbrQ8/7F3TBB419poPK0i6kVX6i239i1eXY0YMHVCZEKqd2OU3a0oqd+TqHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNu4yT6dZFnxpdr2cY/Jeh6VP8qQITjMZ/BumTOIuG0=;
 b=N+HhjZ4Oa2SFguJgc0qZjv6iKNjDJQHdqvVbZvYDitRLgR5r4VaOo0Fg12NBcfqE8oYs5rWyIQ/1jO8e+Uyv/DKr+4fAPXBm1NTVKf0/1hYnqSgfJUvJx15jelze4xbzN+9rk8/QMLKORddC6pYpnOYhm/EWKF6U9MeamJ1MgM85py6SzOQReSzlW7GjD+25bXFLPh9YP/DZpXxCfpHqcuyTpDexJzJA/j9M2Jd2JxowzJbGdrSkUk2kO0nyO5PjJdGES9zmjqR+PKwPPrJD8QOhCxtlvihG3h8D2vnd2JFIztedXvfvj/iVUV4BqRyjIJFznU4QlXgn9f+m/kT/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNu4yT6dZFnxpdr2cY/Jeh6VP8qQITjMZ/BumTOIuG0=;
 b=Fxj9/nFB1BtJuQXhenNpfQZXlh+9CtayXCQsMDclJqhSs2lBd3HVSPNxWaq4ygn/oOdj5ah3qYDOlZYzd8eJ9iCSv2DuiQG44zh6lHkH4CB+XgHLuJCFK4uxDGzcCCMliiaXvp0COamEckD+381Pdn1+deYepvstYOp4M0jKtdA=
Received: from CH0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:b0::32)
 by DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:30:55 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:b0:cafe::77) by CH0PR03CA0027.outlook.office365.com
 (2603:10b6:610:b0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 17
 Sep 2026 10:30:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Thu, 17 Sep 2026 10:30:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:30:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:30:54 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 05:30:51 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2 0/2] Macro Ordering and Typo Correction
Date: Thu, 17 Sep 2026 16:00:48 +0530
Message-ID: <20260917103050.1020982-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aedd4b6-4a30-48ea-5194-08df14a6c15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gOd8z2b4YuKL5CbTrfIGdi+U4E4hx+W5Jb1m32n44dzXjyDcpFvF1R/WCd4hB46OgfKhxldBQJo9xbgT5DNfa2yXfPRNm8rQqpwo61hcBF4OVPv83mR7aWkZOj9yG8Afod1h/42nhN326RDxXsK6ePyqT5ei2ZhHc9FZ3hxLRhrJLFeOR0kGGKznsskwjTUaOcOw4OXS/sHKgrOCD5ifuhiNs6y5QnG+mg2q1Xdeyq6s3gzCxtsVhP+AoxCPYRhSa1YDMmqgj24WFu8PnD1wVJ6CIFLUP9RJZTA8Zq0QQNmLjGJU8/WFEOwPDrLQ812YLJr8RdLJoWSI9fAhQk8upMY4+Za6IpaOm/RR5eZAPkVPHaX/AsUcxLCvou9BiRLAwKjJeJUTaC62gsbTr27qvHIoBYObN/ozKj6S0Knyy6+MQbaClMO13h40h1vVvei2ZVJ99XjFtTVulmA/JHGDr4M0JjLkdctqX2RfjwL4wkNxOD5/BlZabw2tkkHRa3O9wV3HcPGX1q/HKGgspaigwy0C3KHMTBtRxNp3JooVQosDIyRGbbZg0wfFzyXiP2HmvFlUZTsk/+xRUipp4bl7snA6r9kf9KMi7mK2jDpT6Tfz5avvzwEHU6JBlBNoFYAuF4wIz9oF+LkaTlm7ZxHYanGvgXhgAAB4kucqhieV+iM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EoHUc7r2f/l9goDrpVe2tRRWTHZnXYowJhw0QOkkhM9IxLuzE153fvOdAXi7UlCTfcI8wcQ6NFih721nigejhoT+THL4SEKyoY8+od6Hiv2b8R47LARFfUzd6l48ehef8E4iJNLkzJlhyGkx/roFb22uA9Lb2BsUY5YMdHLlOhsOs7e6TegWcMuLo6/7TrH81ARYV0eKpDMq4QysOUd9Wqg1cvKhwfDqYXJC17VAJbaNrshMuQyyeluoWBD7Enmn1bkc1j9sdpeBhiVI9HH2mw1gODZeMYJODOx8SOKs6W5nICrTBruscj3X6iV0WjOhttGYX/Y9sVfAy4pm0SQ6D4v5qil7b2IJUO7YsY/ytE7wVR/+wbhYTw/s+qjyRbrctu4tXzPJptMjeaPchFC9yxPT0hvN5+LkBFOjGzjmk/K+DluiNSwIxY7u+9EIILe5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:30:55.0508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aedd4b6-4a30-48ea-5194-08df14a6c15c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589

These are minor and cosmetic changes.

o If the macros declaring the bit positions of a register
  are in order then it provides a good view. Corrected
  the ordering for once such register.
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

