Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6A375F9E;
	Sat,  8 Aug 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786186391; cv=fail; b=f3hTOSEWu60xA8I4v+lI+sYUbxpOG7AlzH479yChtuh5UVWV31bVjCveZI0AiZsUL0dhi6jNl/yK+KKoTWrNR9lWor6Hm8T/fLnz9nXKStRC4mT3lFko8egAC/fgtoA7Sh9F2xGAgFCTqlIiL1Kd/yCV/0QngyQ7QlV9nTWso0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786186391; c=relaxed/simple;
	bh=9l+I5dfMBjRNtyCEC3JqDdyq512Vgaj4/0Gk6jtY7M8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ncSq7seb6liB3SMDVC4Nc4R89PEi+NMufoazrAg+N9aGtKuEb4O93rFI4/GGxIZOPcmxnLNdUgfkEsnPECB4ofZEKM9ODPaaphS2KK+u/EhUMCphXTtzNQxlfETGm0oCej8O8X2Svf9dO6kUl8CS6Q4EjO36a2neqOOmM+LbUCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dpByO5Gi; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dpByO5Gi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZt4g+RKjUcyqmTvjK1JnJS2RUC0k8k0Oqn8DrLGyi+5jNSPVIwOcQQpfiNvm2te5xmvp6+3Vb7I8Z2hnc0HYlUYrp8BRziXQjTuyE0SPwGqhfcQDUAuCjs3kAgRzg0da4iZyr5ljji9nYIxE0XFx6xmah1YBm4Wk8jlQOUGPElCTTrpWYQKEQnXXSmhubL9e5/291zxnAZj0x3r4pgBDXiZqdhBvLeVrUKGwFNqBOoi7aNG6S5DLh5qg/ws6OYYmG8iwhkCKtK74Gnwc4Q+FT/6xTwlp3S4SXo2hIRWJHntDM/E32d8Me4oz/IeBFWWqDdkvuq2eE30hgv1Qu45vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhmkiUoQjd1hRztXCoi+o/qJeTzBHgqKPDhCVxww7W4=;
 b=TMjpjzLd0Z6JpKlnFTW1rBxGdYK/ToaTNjL/Mt5ouFtVhDZS7eUP+Oo6rW7s51ZsDco4YC0BjJ2CMjk5KLxbpwytAdXhI1btBzJRubx/2JB+u6uKRPIg7pYeh3R5m0nPqYia3arM9UHhQOJS9wKECcbPF9NPAs671E38GjFgThjJyq+VI3Aat4ERxUCded4JhEV2IztunD0b5TkGUnFPbqpZFx8WcG3R1EAfjfdSKV/00CPS52w51GNoHq+lJ11uMjcjJ4UMcwDdb1JLwUbM/OmBnsluLpALPcb30Kd/FLb2j0gNOFK9PkCrEBwnTQO3Jo2YtSrbZkRGcYocYmDrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhmkiUoQjd1hRztXCoi+o/qJeTzBHgqKPDhCVxww7W4=;
 b=dpByO5GisoBPvcJCmRE9zlrELfW5c97/d0AgiWiMB5uslm18q5zzDwY16CSboFiYPgS7zs8hcgWl6u5Wcc7/ifVlxHEPEuJyOhV5M3MGIdocQmPepXfhNEFwIx2YxyhaG0tgHquxWgFTyqFeaoc+edQQqG8zuF8ktKJLDUoUN7g=
Received: from BN0PR04CA0152.namprd04.prod.outlook.com (2603:10b6:408:eb::7)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 10:53:05 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::8) by BN0PR04CA0152.outlook.office365.com
 (2603:10b6:408:eb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Sat, 8
 Aug 2026 10:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Sat, 8 Aug 2026 10:53:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 8 Aug
 2026 05:53:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 8 Aug
 2026 05:53:04 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 8 Aug 2026 05:53:00 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v4 0/2] pci: AMD: Add Versal2 CPM6 PCIe host controller support
Date: Sat, 8 Aug 2026 16:22:54 +0530
Message-ID: <20260808105256.3705889-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: b610f3e2-0de5-4436-51a6-08def53b39c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ucLAbyZZ2/1+Y/3FVgJT9JMK7V0q5lfr+CLmq8NYKpvYVXERdEuZp+zuvRx7TiVrYXR7dpfAOV9F7yB6ebLgGodSs5JPlAgbyzIIjf9iu7kpV+10QwDve2V/U1vj0uCXKwxQA6n+CTDrHjLo81MSwq7gRKrCcJM2YatGOp3eAktLWhc3iwbvxHMqB0ZfNcXwZiPKbceterrNWEKO6E2dFYnOOihZyLBveFtmnvru3VzPN2/mYcZHj9gxPkvS2M70vvlmtAPDqvZQluHyS78lTLm23JAvJjuFhxu+OyD/E+9W7IZOmsD6GrpfEVYFXcHD5UfVclVRhopoA+tVrAvC2kcE0FrsdiCmME713xyy8MkdDlxeYRV/AOMSLQF8sIbIVfI3ka7y+Zlgaib21dGHwHbXty3mQ14ACZLTJ94+/2xXM39L/gp3O7U2UTACJr8Hh0Voyld0B6e1878/MeU0pisj+o/zAZuH/TFyYC682gBNBP1jhy3qlBEnJaajjpvDW5562G9IKPnLrJd4eFhUS/5H3OmfXhsmWVgsNyECfLPYxPQeACp3EzwcGgIPV9SkEiX9iuZUg+dC3iUBz35qouVTIiKj/cR22zbr+nRB6JaTVeLurU/jb1nz8rH9YjoQrIeZVTo4dgRj6S/rT3kIdnfWbl6JWu1eJQiqxojd3Hnp8vo+AWohq55k1w1XXPDwIkIgQKN8UHnIZpSYLb4JdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R04rzJLV0Cn/ActS3wi3/3YP+YfXwf9mUGpcOrGNGawuCBmQY1e4uOa2iapprfQT37n/kkL9MqDKEN6hbY4+KevPO4gvTxRNkDZi+yRwRoSJ+4q/MSrMaYXufz09ovjHyyNkXVwQWpkikxvmkemH3vlcB904WvvXhrpYnxQqBw152SYjyngUVNgOUepzsZJG549xbqjyPiITngda8lAyx964wGPRE6Kdtc1H4Qa95L5s17yOZo3YeYcmQvK7ZFPZ5FO2CYUxIh3B3HBkloszoshYHER7zqWvnBlBkA0DmQFEHblkBTEgG854oAlU1XbwTqLDVv5Volh630d3f2NQ7tq01OFeyuafJ9rtXtDIcFW6HeCSJwJ5wDvSwFKsVODwwSnxST/BhGLb2FsbmztvxNuoK9kvnvrI9mmxMqJbmxkrRiURtLssaF1uAYM+VCwW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 10:53:05.4168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b610f3e2-0de5-4436-51a6-08def53b39c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711

Add support for the AMD Versal2 CPM6 PCIe host controller to the
AMD MDB PCIe driver.

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add CPM6 support
  PCI: amd-mdb: Add CPM6 host controller support

 .../bindings/pci/amd,versal2-mdb-host.yaml    |  45 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 424 +++++++++++++++---
 3 files changed, 405 insertions(+), 66 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

