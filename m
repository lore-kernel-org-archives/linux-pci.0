Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131AB3E16A5;
	Thu,  1 Oct 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870172; cv=fail; b=YmXwSUu/4NJ0pCGvitTGNqRE+yiadExWZmRvy1LOdIYTR3Hsampbz8iScdIhkjuXPulK+5TDLPG41POrt/Yj1zHgm8c5mSDROkQCLfL+AR+AtF8BXhomSWhc38Lme5ZlokX/HpfhMVCFGoPEna0uC1lIaViAc8AJJjaXCmvidmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870172; c=relaxed/simple;
	bh=AarJf7yj8GzB+uK6SNYAg1mvOYHZYYavTSqtSHU4KfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MmBRuxX58+jbaRJN+BKfg3YbnYBEDAkPqNtZKa9D3hO8ADjop1lE1jMmnJPBDtuhXnp+lDqFix3RcvtkWe+DQwWdHTV+M7x4tXta3Q0VUqtOqbK3n3CgcuDbvSJk8oxHEHRDqFNjRl7LbhHUwnM1TvY9FAd2ejo+e/fD75Ay8Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UjPPoVoU; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UjPPoVoU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APBq9SBm1iZDiFr73XGaCdT8F4mM/TKUaIOOtO2XBuSVYRiIDFnsv1eHmmZkvbqCmCF71Grm5UlpmiozT04URltVbjeeMtlV9pQ1q3CUZEQhvnaFUNuZPnaBqu426XwHsIiCyXgdFe0TL0uzv7M30t5dQ6JrqzHNlwN7atjLh9TMuHT23aosgCCALMJEpJTivSzIz1mBMLe9Y16sa2CSDolC38gDnc7Y5qNWG28Ju494+Qx/xf5NUvKVBFn+w37Ny5fMeSLa3SE96uD4BH9PfDij4xxJnOmFGQDHKhYM6MmcvPSR0JI7BKp/2l2wJK7eh0kGen3NUkw/Gba16E57sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y53DZBq3w3iIvLxccCDsl2GKPGiozh3eXQJts4MZCpU=;
 b=IRLw3QSVoKm6tgAmavVK651VzZ8MYHklY2NUb2zvxLRhrUSmpeCKCLOMZwwa9LTHrOhspzD+amQqyKbU3PZ8+hilNhSKWGfR5zdnYOn+B6VbUmv0WfMDRCcdpQiVY+QRDpHD0SkK/GpoQb7HLAlfyrVEn73kqiiQ26UT0XXZfrxPZ/QR4Ys5ehmQ1sWs3xSHVldGCN0Xt6k7d/dmioYbdhFhoia/mcDpaKG7K4nhwjqjzvM6yzUCT0VhTSU35Xeu64aOJN7lXJOLdhaEQ+iibJVeVJdecV/8KWNDoh4E7W0hr7RGK7kZS7mIxiNZtAAqcidASAxQRD98WQefl1roTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y53DZBq3w3iIvLxccCDsl2GKPGiozh3eXQJts4MZCpU=;
 b=UjPPoVoUCm9IR3+AA2YlBVIk2bMwgbch4u5vq0gSbqzu9n8lcW8vXJUvTAEJOoxfEBg20UR8BTyOFOhvUcn+NVz4mIHO6eWFzjA/+JES6Gxn9CrsTBbO17J2fSCfBRABB1KDDs4Uni94AeGCdrWmhVKLFoInC08MIsp+RyroEt0=
Received: from PH8PR15CA0006.namprd15.prod.outlook.com (2603:10b6:510:2d2::14)
 by SA3PR12MB598757.namprd12.prod.outlook.com (2603:10b6:806:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:56:00 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::39) by PH8PR15CA0006.outlook.office365.com
 (2603:10b6:510:2d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:56:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:56:00 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:55:56 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <fengchengwen@huawei.com>,
	<wei.huang2@amd.com>
Subject: [PATCH RFC 0/3] PCI/TPH: Expose CPU-to-Steering Tag mappings via debugfs
Date: Thu, 1 Oct 2026 10:55:48 -0500
Message-ID: <20261001155551.4182899-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SA3PR12MB598757:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfd1e1d-7a5c-48d8-eab6-08df1fd47d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|6133799003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5mWRP8QuAYxzkT87PRuhRbcsTlUZpGws9uUSuM3bEuZvJphV+pSawiZBWai0mxtNva7yeLEch52+Mp9aiHu8IPdT87z/hJD5ed380FV+Fk31XT3qUMTjgizt47KOWLVvg5LX9iJqFbFMRhl9pNdOe2Cpzs5I/lyYYPF30dhOYWqsi+PkfZI12JxXGHDaul5cWDKDXqVR6UOtpAOsMqwqjYz8vuMadY1oUgEyW6ECcLN93c9UzLn1Z6JVn97cqkxMUonk9L0lCGKTttEgWTk40QONDv1c3ewUl9dhflvGaoJwYPfUyEJGnUftSFMc9Hd1c6J1/Nocq6TmL9OmoanCOMMMMXJXVDICpqhjYYqgmvMPeFR9YZT8TNU4IpgMMa0WyqT8zQ37DGLX8kd6Ic1EFkzrVpsAL4edM/oxLs8XiA206Ws5wQ5sDRSaI9SlI1l2UQr5eM1pL29VCuVEYbUGacQW3K1lBJZS/jPY1dboi+CU4an7d6djaDP9dvVTjREw226IEmE6oRIZRCrN5esxcTM2izZV9zaQUtHHh1DXfmuGfLtdY4+fzr4UgjGiVSCkZgovLztLe92S+Xo31Em1Fv+7hr3Vm7EHR9uAbPMU6gT1BcQAXQYrXjBq+tZfyTN//RpiYEzk3TX8AMKwISmDvrmSrtzExTc8OGBGgr1Y+7LPnEWNDowTxPtkKAM1oqqMXawnVUMQ/UOY98REoVvv9A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(6133799003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NyfRt2D/0/3+wqDX7gNl2T8+OtZckU97qeyF1D9mWciWZtokN9WRV3+tJJ8chqbkaAAJuKP9Eaj0t+eSmfG0KEUHfHLaarrSZzM2zqLt09E6DonavR3ZGYxlRwd8cx/n7hfbnxPldZpFViX0cXRxr76UpxJzApyFeUUn/FR2clxXV5p/nBusLwQ+JMgl7CQd3VopELs1r7078ZZPvWdnUAMURd1CnCHvTJ1wL16Vc+hcT0kVornGqVZIp5wemG+oZp7YlsQXwYHYt8cfCeGvB57meHP9Z2Pua7qKclmGTXiEyW5AobA8GbYyBPXUVi4VAAWzMIb/EL1JXNkCcrajappID61CIdFk7X1sGNT3UwIDU5oC9mK07o4FGfzRg/u5E0QgMSzmt7Fy9tBnEg+N+Rtm5c4ZPkdVGTUMrHwIVMyFUwYtZcI9oqR+3VN5baFT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:56:00.0810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfd1e1d-7a5c-48d8-eab6-08df1fd47d16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB598757

Add reusable per-device PCI debugfs directories and use them to expose
the firmware-provided CPU-to-Steering Tag mapping for each Root Port.
Factor the ACPI _DSM query path for reuse and document the new read-only
interface.

Wei Huang (3):
  PCI/TPH: Factor out the ST _DSM evaluation
  PCI: Add per-device debugfs directories
  Expose the CPU/Steering Tag mapping via debugfs

 Documentation/PCI/tph.rst |  32 ++++++
 drivers/pci/Makefile      |   1 +
 drivers/pci/debugfs.c     |  60 ++++++++++++
 drivers/pci/pci.h         |  12 +++
 drivers/pci/remove.c      |   1 +
 drivers/pci/tph.c         | 201 ++++++++++++++++++++++++++++++++++----
 include/linux/pci.h       |   3 +
 7 files changed, 290 insertions(+), 20 deletions(-)
 create mode 100644 drivers/pci/debugfs.c

-- 
2.55.0

