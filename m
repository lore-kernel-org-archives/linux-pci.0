Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981746F480;
	Wed,  7 Oct 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368381; cv=fail; b=CA6LmQjI8WjE0hJ7VauXaY1cIT6226le3ZawiqpQMxfQF1BlMg0hyzyHuWCLWNEgvfi6aY8IKAEiFL/jvKil87wqhaMpfAhgEsi8KL1FQ0qiVFkLV/8NyWJ6dXQeRABNNW3/xigFl5VPUWZbwXtOA4/ft9Ql3oUXF9QZuvZMNYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368381; c=relaxed/simple;
	bh=zrXTtrup/npbIoDU/RAxyVOp0tAcLrBYeo2UjdMutB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NJOgssJfDwAqudTqN/W1rx+nURRsnPsNeSKDtwZbcnV4jOEyDrfGDZpSLnYNsVn8FQXtZEY0QyYoehVCPL1AKm08qhviKfltPqx9qXcZ8y4/q9dmPdhAvusUdjPIn3+qEi3HBn+bljwgCT6uM8fs+uXJP6J6Jgr0/6/latnlU48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BDQyuphN; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BDQyuphN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouwZ+wh+AvmdaNJXS1u1R8uFQzj7scdp7QUeFgyDbljeLhDKejz8aAlGZGIA6uafX+9D4Kn7WyI1NTRKbSZKHU0ctCe32tqJMp1ZtB8M1l/4ufH144PdYSvtehN6GQyg/I85jI/L5bSb0ZyLVY52O8HYli3HK81cSV7OxrIJBp4RlVUpQKmgO32Y1DPbkxWYmfIlPzXL3ak50LJQBalbqPE+EIgG8Xnzed07/paeRfMnmJsfqew8hDUnLY7VeQI5QxCkuD3jTKjgA9WRTpFVPqUq4x6PBLgsaQHIkgG1SB8U2reYMPsJ6H+Dsq6r9nCRxqIjMG3Niv/Uj0y85YCQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNu4yT6dZFnxpdr2cY/Jeh6VP8qQITjMZ/BumTOIuG0=;
 b=aMs9qpohBpJV0K0GN1D+oBm/CXagZouqFbb6KS8mqf7AphnQSwr6W12MyjuWBoWHZBDhj2A8QqEoRGWLjS8zt5R3vURMG32Vd3/4ji6vFytrD9FpUpXEqihSOavIdrgqZbHkhdBG4st4loWN793kfx16peKDqdA7shzew84QgxX2a1XTShQwu0yI+02PSx/bW7Jyj9nT/bkk+hyEowEj5gS+DfTu3c61XnauGR9IwJv3xdQi1dKwkhVntbMoqJB8EGxFjWVFmGaCMYpCVIZp9T5xWPWtE8sI4A7mzreLljRfyMjtg8HKuGny+dBY2gpEkvVzF6m6G6JIXRSqRLpELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNu4yT6dZFnxpdr2cY/Jeh6VP8qQITjMZ/BumTOIuG0=;
 b=BDQyuphNGiy9KRibBRMwEd+/wYVEBwQM8LyKWVTKoATX6VLVIQmnuqDzzCBHduvaNJDLuBDayTHFaNW1g/wbRTErvKVDtGHq8eKh7Anj2tS+5D4zpmqIeuGAOCvBYtFeiIJp2bZ96N33zy+bwqcOP8jqDiBI1Y84SfUAuYuzSno=
Received: from PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::15)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 10:03:40 +0000
Received: from CY7PEPF000000ED.namprd04.prod.outlook.com
 (2603:10b6:510:348:cafe::6b) by PH8P220CA0030.outlook.office365.com
 (2603:10b6:510:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 10:03:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000ED.mail.protection.outlook.com (10.167.247.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 10:03:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 05:03:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 05:03:39 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Wed, 7 Oct 2026 05:03:36 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v2 0/2] Macro Ordering and Typo Correction
Date: Wed, 7 Oct 2026 15:33:34 +0530
Message-ID: <20261007100336.4009004-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000ED:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec75324-37ab-43a1-6bee-08df245a4371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|13003099007|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	t88tYQBGIJWv+qGSZVUP5yErHOwN3pa4XHFyWnEw5uChC6sxf9x+Cgju/xk9+OQDL/CqFBDkT/gtOVPR2ABhFl4fy0WABZY1B3mjPqenxXSK/gMRFARn1r9JC02TPPPOp+yzTm+mm7WlYqoe/ODZFEg17ErRJAu8VG7uYYZKfbFb9L32e8TN5b9I5K127cCkr8m04q4vbJXZyqOz+5eX+f6c6XNQLJmDxfTaSYWdEzAxq2sy/LmAdQHgi5IAi5LFf0LeVMADC2FtsfVlXNhz2XgGY14uDHGA+r9YSf462ZOcNZv7PW6YGICyrm0s8GlH4rYvUvBm/+Jj2zAp+1hPfRJTYMMJ4BwGs0PTMLfY1FQ7q7vNjV8c+1Gf0Bq2/vcvaV26LRqTtpeacLovNJQeZND2NmQQuKH/a71Uf1wGyBrJti52pjVYlCb3OFsp45AzuBHfQ2GvhyGuTdvPiVkYbsVRtFh5JieiEhutSnNFddBLBy0HyJSURw+IG4+yuU1pyoCbwvVuiJl44erMudkC+K7zUDnW58u/1WZtbVKCTxwhOfQA2kgx1FYLXQxn1OWze2+0j4+aEG6oR3NnSOwZ3ZJRGfzd5YA2V+7f/4ZFAWW6rKK0kV2CTcQAYdYaD70qG1wmqvHdi1HeasjrqlFIhxEzyveziLFGNGTNf9tqlHE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	06ramBKr6dGyXrbFXt4NHsM7ik1aheedGkWmbZ7tbj7DRWz48Qzi+t4jDzIxHwfYE+VJatERGhNAWQAyNJqJWyxY1T4wE36O6tBW8mILnIn15RlAPw7vO5tNyE3FuMwDPLeDj7ua7imAN9Im1+DmGavUzkjnOHtfJx5E5FxHepyGjAe3cCYqsGvPgLSUVqWmeNhzsquf2hv7vhvPSatUxYTpInPHUKLGIOuLxzYoInqBsZGHxOFXh8WEepQjdko/S/3vW1nvBUvSu8VWcoMfe8C3hYl/9a9r+/bTx52pdt98KiVRUgAiemWsMT1yp3h/9t7URArX3eD/W7DRJigfA5ctM4M2IEQdcshD9/XhytV6wdY1JNdW93tdkMevemONzpNo2e38R7w43uUqnKbS27yd7tNKopI6fteJ9UyBZrjM8ETWzyq5foSLdiFvZY8I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:03:40.6155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec75324-37ab-43a1-6bee-08df245a4371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000ED.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289

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

