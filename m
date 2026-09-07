Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE13379ECD;
	Mon,  7 Sep 2026 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778507; cv=fail; b=TP1qc5IhCfeNBT476pudCfT24MkHlHVHJuL82jaaU+QckTdAkpbr8CN5r8yVQfkSWe4O0Wq0U9hatAvdGpz9UFdq7/dD2Gw2t09JNZaoGGP8nRJPXFpTpc4c+2oAIt0TdpMz6ui1Cb0Qer6X3B5bGok+uqfYrddWiE29h74eskc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778507; c=relaxed/simple;
	bh=akzFmqHCYEC9nSZ0KG/ZI4pK5AwLD+qqpTs+YnA6TD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BDKLxQ7KwVj599vEv0zmdycg9LnyTcMeYzrGtlznEz80N1/T9k9YWfyHEMx7nxxZ8x4elyuULJTbsquknl3OJty2Ttp5Or0q+8v1isxqtynUVdTFB6itbQw6bNOt/ziucr2sAcn1nt9Nke7ULL2j4qrhqG5+pDXnxt5T5b5N75Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhvUuHD5; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhvUuHD5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw3tRJdE1jIVJxP2ZSn/agOunAOqi+l410U6CKAJrXQl0RVdfkmh5CsqMI836ESz6A9he+kL9rbQiXXsSwnAsE9yLShM3ykzf3Nn3DgUYxaBBK0VK0h0g3pRwIHSlLhqPuCdE+aYVKM0CHIcxabD/EeXqn6Ioh9b/aQgUEdAt8bB2cXY4vrPRd1RtP+ELvyE+AJCIU8EII0f2lC6K48lqqbbW90A7a47bZ9uUWzH3CO4cJkUxQvZshvc2eot1OGXvTSiQE51jCOczOfu0DqeJD3XCU9eEyUgPwlvRvk/P+re8PGBL9PSq0hzrujecgjb85Yp4mnfm/xuS8Ngb5JBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNvTjb2HCtn3FIpM5TQ9yhwLNwFgAjGDSrpSKBAwJZ8=;
 b=bq5UhbRHkP3SD+ZN4YcyCNSn9BWfSgFStkzMgwIJzn0i5LY0LZC3TPuwOjF2PsZW6Qa6Q6g/draun6AHp0JDdIm1vTWR6rcZp4yHzF6XiD+AK+Ga+bWki2fCKkv1Zs4sDNEHCqrfzvv2R2igYk4VvGc7mampRYu8oDZMmZzrAPHw9e23/XcMrhRmi9c8/zsxSLqe2raOGeBReswjJLBUa2sY+lIKpvc1uFqM7ivkPdl5yWOmHxfWnTsIkrpxMLGY4T/AT9u/zlvEpqD9glZuZ0PQmBuRnP6OeMipl0paSmXFIpRiE1KhKF79rE4GYtcVuJWkzZzbrQnXDGXyzAhzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNvTjb2HCtn3FIpM5TQ9yhwLNwFgAjGDSrpSKBAwJZ8=;
 b=vhvUuHD5JaXlDnBg9Rna8zxUis2MPhblBbjj7LiCDmXSfsbX8NYfC6qEQX6Iq06aREzVmN83TCfJiDBgGyOlItNtMa04M/T6g3wMzh68xSLpjey9Rkd5TPMc7umSCvU0y4m7saEYviRTZ6NQn4bYiaAscHeBEw21rkg4y1iz0BQ=
Received: from MW4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:303:8f::24)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:54:58 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::9d) by MW4PR03CA0019.outlook.office365.com
 (2603:10b6:303:8f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Mon, 7
 Sep 2026 10:54:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Mon, 7 Sep 2026 10:54:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 05:54:57 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 7 Sep 2026 05:54:54 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v1 0/2] Macro Ordering and Typo Correction
Date: Mon, 7 Sep 2026 16:24:51 +0530
Message-ID: <20260907105453.1940646-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d23bf6-633e-4a5c-4c1a-08df0cce75be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ekiEwyPhEHlRPixVERovw+0KgWxwrju40xSytr9Mg3gb8pNwVEJf9NOpJ4HfGx253C1oS6UwAOBj9KktkE8sxcet1ro4ZC3+ilKfEFdmlBAEIWQoLYIo1N4v6zcAffNwR2i+tLK6E0nZs2vYiG29/mII61URPoz6RlWJB9Dfcqo0AaQM5QRDitbT6sOpRpyCebWFoOwSZ4Dj0OWA4qyZ8VylJFWkKv/mESidQJxrRZgc4jrdR37hO3IOWfzQwPWrrPmWke34FspDOfA1WHuWLz5ZsnrJiJhaYh9X1YSx19Tso48jlkrmN8zQqY04U6Z2C6ZV5iYLXz8ku+YrMig3UWtIgjDmpNyNz21d5hQD6ZsbzdQjFgAWIcq7G1Z06k/LH9bqbdWj+q5DCORVXV6ua++5yAQpyj+xNb/aGqmhau/paZjoTroVz9t6/hBGFKMWiGWVeYGUPmRwueZFYnztvmw7FEXj9RL3uBb5M15CpKcwDiwFCDWobziDaNR0Ls/VaoUKc/2cjKtCky2UbjfBvgZde8bqqpovN0K6DMdBzgGsmGvz4Ok9/n5T/w0HLm3kspVFSotARU7zRLa+VvJl+81iUlppYIqKWQxT/xFXoayd/nN2mlTGEsAVyX5/zA9SeOPyZfqbYVpMvRjb6hGW4MIqvrYydP2kpNcd+8wlN4g=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JtHo6NMLD7c7gVVQ5JNCZ4kReHDimwMD3K1cp6K7Eme9DuQIAKmJ8RpgqQggcNOArBEkInM3DbBdS49jaWnO2+X7ZfGONdJZ1bqOm8tpjEx/Kf6cAuxwWuGkonVFCmKc44r9sl/P1n7dCEFW/e/rjuQP8XZ2auHpY8IaDz/toNnAMdVrj3uCzkiZUk9fOaBsaMI+Y26qNDeJYR1nOJsmOb6b/gopymJc13/aBun1wEF2koBd2ha5WeHcEhoXHOjAuII21K+FNnr18gTQ4nA4IVo24CAggY/Ip6fbjdnIgO2NDdQQd5Dw3NaxG2wA+3QXgJmxsK5NjMbssgikmoULoepWw2CvrwkgSa6BtudUboulNfKJXRd0bedxsSbNqnO95yVhIckCO/vI5weYQjMRKDHiEet9zyWBCDaNh9zrcjvaf1qbofSKHnsUovPRm9ig
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:54:58.6759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d23bf6-633e-4a5c-4c1a-08df0cce75be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

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
  dmaengine: dw-edma: Macro order as per reg bit position
  dmaengine: dw-edma: IP name corrected under its struct

 drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

