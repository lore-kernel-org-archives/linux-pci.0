Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AF485505;
	Wed, 14 Oct 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962958; cv=fail; b=Q2IVAkVLkN1QVJWLcrF+/hUlT6nCx6GMURZmx4h52P6YTMl9iSBZx+0xKZ62wpKZMe2PFbuMBhHZ3vOmDBTHgx3BuGFAFxBCnDWmsDCSOTtwmKNkBiuMlxjywc9rJ083V40KX1ELkRq8dnuDG+ID4bhSyrGMzp2e49t2ucpL44I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962958; c=relaxed/simple;
	bh=A84h6QY9XOYlV7FpEpO8TO8c2uX+VoWWx21oPnQ0hlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KL4fHDetmd4l38wVx5VGGQdNaRROFA7E3gBoFgmM7ZZ4nKp8QYuDiGMVqgoeeX+Zio3zhBakYQTzLO6soegH0PYE7huWj3pbbcvUv5g/0k1gOoYhK7WXrOCtG3YUH39LF0zvnI5hFT4ubzPETsFaE23tx6TbrJVQhQgHoqOJ6UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sBDnaEjw; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sBDnaEjw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuqYH9fSmGk1t4jleLOCmMx8aIr7JrLxYDFIykIY8A0JTT/r8BQV6drZaJ1/Sq9sSX1UMTxJaFhCLoSMVW/RtSD3hEgJ15JnHhDWXkTy4fSCMA6tfukkzmZsNSzFR8wAVBWMnKpL9IdH9pBpk1YXpgyBl9vAnaJIENQmpDavGI/wB2f2pKj0GckjOyVGrN3sIfrsvIC7HariUzGKyDbWUXtHq9dgWcUW9hVIbxGM7psONhfx6wR1tosgQZ76OVCoT7tcnFNkDrYHOCJtgxTW+PNyu+wSx9OqvfCFNnI+LbRr+eFS4cW62/ucxYSiEJt9esrhtVVyAJJCUIXFv6jWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn9k7bVfc/ZSfPM+hg6a1UCR/RjsCQqDoQb3gblawgY=;
 b=n5wdpO6pwh/z3nNQEvuOFY67PeS4e9FbTdpuLnkmU+gEc/5nsznRgqIv17kIhZXK4FY4ACH4Gk2so5lzbsNF0x2siUAoiGJbsxHcXlYg449o9w0bmy0ns9pDaLE7Rek0fNADtmcdBVv5elIrNn78BoFc4bkn+mJcIIZ8uuZ6O2MTK64yO4pBWho0O+fRek13ettaxiW8//WIKsv5sslAf6SIPYjrowPkRnIH1i3dljhxAqkXUSUs9JUP+i6XON4AaTlI/OthOmYv4EvJjJRW3hKWe2C5vBHVLvHXklSU/fkLoqRl+VrGX72DF9mFkDHu8HUbZnPsj91SHopdaqhWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn9k7bVfc/ZSfPM+hg6a1UCR/RjsCQqDoQb3gblawgY=;
 b=sBDnaEjwipJhc7LnCHftOZU4BLH1vlLrO0QrDZ1G8CBoWJ9yZwqgEC9rwxTVh2FXEKelu3mFierG5gPTkv9K7QiBWoY8ejilFGxLHrE2L9X3g5crRqYJ8orQEQKOKZYs0QmQnlCXXj9vLi8zZ9VFFv1tF6aY8JssCVYy3qxOG6M=
Received: from DS7P220CA0079.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::11) by
 BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 07:29:12 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::67) by DS7P220CA0079.outlook.office365.com
 (2603:10b6:8:259::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 07:29:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 07:29:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 02:29:04 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 02:29:02 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v3 0/2] Macro Ordering and Typo Correction
Date: Wed, 14 Oct 2026 12:59:04 +0530
Message-ID: <20261014072907.581539-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 026d35ca-701a-47d6-a0c7-08df29c4d789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|18002099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hVwUXr4VR8pGHCeGMqgkfOMCaXOUhX/pcCyMm3RIgiPOu0NO7X0E+3Ev3TJ3VU12IWuA+F3bw1BesA82um9E7oiBK+y11nbFLetpKlX0svMOmugE73pCBqtEJNJQPUWUbk407j8LoaJI76/7i9h1LI4k0++ZMQV21Uzew7J1zU7PwsJZq2VNqf1/vwTXARii0BCN8SRSQmr7L/mosM+0yeEu36u4yax6qw/QIVekHj/L6bf0dovgamFaE0xx8e1Cpvse+wPtjJV9sykm4UjxjW0xHbvOzJXO+GomhmPJa9XUAJwykin6ziVfVNF0Soh/aX/vpLTGGvsyhohJuMZ5Lsri8LMaT6HZuSX9n3ZAm6JSVzjvDjVBvURUv6C4wQZlxtUmgqZb1huSuOsUKUm0SRWAucKdOSekhWBglNkNjVrp7G3myEF75dJCewSTXSbw1DP5zoXUoybaGmg4cFK/CXz1S1NeN3Voy8vCU05cau0zf7KV5hz5obD4ihoNAmV1F1ERkaNNlE4VqKjktdqkzAM6MV/UmVCdE9Fynj8qUfYD7x95uQc0V+COPGHtdKlMaAp201RJwhPqH+QOQTTVBgLXYWbo6a9wVKQ88l44vhOiXgs1IdK/q8t0CW/OeoSpHXApe6TE6DPh3AVF//D98Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0LNDkhl778ytJSf3WJ/oIZtL3xTls/VY1Rd3k3tT4xuPxWsM/xcOlc58mOrEJqeZPpb3jPmkhOn17BCFF0sO8MDpCZpfcWL/ys6vvt82IH3PPsCwHbR97dqxc++55XhGbzv2FVDdrPwHGKbVrV7vNvwj1LtGOO8ZqjUF7zsxVhL/gZP0/coe7PPHRv5HdE1kDcOwgAh2hNiVVSzduW8PGorJdpfLkH2hPXzDmok31XnOcnNIoO2uJjI9w8N6rkECzhZu/K9FfWMQWOE7fX/8VXCLccREaVf4pDwKMooRZoDPh7P0KRovXSbRqCpSMXVKLT9is9sxLivd/v5IyKDoi5bAfXUnyxPDjxbB0T2EiJaYK3OVtBpi9GFmOkxiEVnJpJwQz3jEH3KBP4m0PcTZgA+JaBLZvGzcLtHZeHTh4rO0dzQYLwoak5egYCbxROuu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:29:11.5477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026d35ca-701a-47d6-a0c7-08df29c4d789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

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

