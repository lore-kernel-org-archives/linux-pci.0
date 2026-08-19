Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE547FAE5;
	Wed, 19 Aug 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160091; cv=fail; b=cYE9gic6mODQkCQcMDVmoKa0gZQkl3+QN0xHVcJaNXIHkVWnctrjatnNO0PXES27XJPr2n8osCcAqxKkpTzJBkajZEB0fI2ReAFYk6UKUpiR1noeGdvOGw+RPKdR6enIEPU7vjPRq2SfoJgMIe+f+VMNqLUbu644p7JWiEW5Ptw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160091; c=relaxed/simple;
	bh=bobRyfHDiQDg/kTG/bYsVq/FdX/gPexEgCkzlVcNK6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X13dmpq34sfmD3V2XGiLV8NneN5ZeAFdJQb/wPMEJ/V+5xiMA4xJQED6Ma2Ke84uKJGdvm9cq/dGfyuhzkv1Pyqmxwy/EVXQm06lGDOiGkGEgXcWrjRcjkMgMVoGoS1UubvLqVowsdRicY+u2pehMX73oI1B3GRtqPmHOb+HoXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tShjUhMw; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tShjUhMw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfY/WoCI0byZHMCpzFsXqYaXXRQ5dFaCTc6sN2dOUoni+EqV9BYIz9uKY2txeZHLCC942SSnn/WfYhbHbZqxWazIiG62CWFdRxISyCAVmfg7bnX3stqFGKdVBq00b1OMcSZWTYuQ8pc7gQQAspaLwvGF2Ws9YoIUSNytiKMSvRIXqudu4sxBvsLjkafQsACPGlDTI0sCHZHRKDkC4Ub9noNsLZOKM1URstqVE92ncYrqRScZdsECXp2HAor5SYHyEvw2h4qQRr4e9y5DFEjnvNi2SLrO9V/ipAXQugwE6YbszEQ4SaWg658n4xbbyp9pHMc50z8nXJH1tg0IRuMdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSl2ebvEvT+9bRoLO8/xSakK4k+221iaQr3p2CNxr4Q=;
 b=F+FWMyWLojDxBM+BfR81Z7WBFnaVlIEmOocj9kx8brSk57BTh9sj1nn6vu3/F56/eHVF6gySn4ZvVodlqYqvEPyZxRA3+oZBqCxpbaAJJ5f5jvLUBtNAIYWthlqRJpVWi7PUNhmDsQOomRr05ZUOWaVpVuRq6HN7xHhaVQdCmy9rH7EUHBzJQPJbhxw3zYEha0hzNzMejxNnFhNREMteYd/dY2Y1g6GfGJvEuMEW8uk1fNwo7FXstqFUvAfgBET1qCHVeVg73Y1aGyWVOQmpClyOJ/YLqr8BBx4XvOBMf+mISJvVftADlBFW8fOqOr+flziESYv4f7uu7nfj6E9C7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSl2ebvEvT+9bRoLO8/xSakK4k+221iaQr3p2CNxr4Q=;
 b=tShjUhMwRvhIoXsvR2QYjm5wON9wUAzGTaK6n8N11yRyJwB1Pny1B8gOT8bsy2qHHkkB7Ka9D2Ywz5n2et/nU1EyWZO2u6Xeu4BC3Ld5G3BPuuEfEjiw3tt1VmWkn01YIxBsf+onllB1FLY1YcqbyvjdpBXhm4KA5i2NOeXxJC0=
Received: from CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 17:21:10 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::7e) by CH2PR08CA0025.outlook.office365.com
 (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 17:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 17:21:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 12:21:08 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 12:21:04 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v6 0/2] pci: AMD: Add Versal2 CPM6 PCIe host controller support
Date: Wed, 19 Aug 2026 22:50:55 +0530
Message-ID: <20260819172057.3636214-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: dc23c4a5-dd73-4108-4d0d-08defe16432d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|7416014|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	pujmOeHb5wHY4iIqdwkZdq2kscm6KckKdUgmWf7AYsyswEcWoVcY7TaqWSfxXg5s644OknDwN6Klfc+N/8bUFrn39u/p8t2bclU2vXCYJsh/YoSVdUjhebQujX7x8YWKMIMOxM5f5ICBxYnyWmz9q4zg4PP5gJji7g8Ctxz34nzwP4XU7/5eyGOep/yRiaSLUTbavp3fDYt4QohSdymo6iRVwkqULGtMclTPUNOTyKkwrNZe3+JHZ+UtxD1gIPAgRU8ZfY8qCWZcvn9o/Nf/jFPpdhN0Sjnh4aShNMziX4Xb2Cs4B1J1og+KrOVoEl4wCNoZw0P3i6FpGQcfxXsZjof8V+TnbeXVRbEba9LnBwRzqJO5ZD5ucwfcQqOZW995BxeV2syr5BG5hejLMPE5aSZSfUInMxu2NJKWit4MZYoR3DGZcc0xLwtedoqEZQH4OCD6RNwjUYDSzkDcu4ou/hSrIEfCzV/jLGuaplBjDv16xvs78j6sSO/IXpsEYaAoYfDyZSV8bPsyvX7NVTgjYDH8XOq2m3nPmBzxeoOFx4vXM3UY/LEN+BPtIWBpY5Ykyh6HlTmaduNQWlJWeSpww8Y0JUfWAZnks2ryoCScmbWYJ4H3BijDPMq/6sviA0jJx+pfCsieGPp+vWJkqSUzpUhA0pwbzDNH2wbvUn/8gczeyEYbKppVOtRKGoJgjpIft5aeVANA9ZNc/m7yxSXKCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(7416014)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PmX6KkXB9yyiskDfy1Oht+zbvnxKWNJODSDIgoWjdCuZkweQKioey0aJkY9SMx8PNs/Ar4nu1sK0jEoCaawODHgVGwxSPeGX8a3ZiFGrwFZlyMqO6gIB2XtwKgZOvV189HPxJHJRb/FxQwGlinfVnZW17YS1U4YcOb1b56XbqT2G549Q9Tgkc4v/X2Ibytn7GDFAILD2c36q4GmOxCCYoaUBumh7NitU7IG9BoWT987gClBbtvU8u3TpVoAE0ZY5K/IcTk/E+BPStFCyJ/wAVsnnfjqbKtNyfxjOjFHv6rjMvqZ1fNnlfKBRde9YMvSp9WU5e+eRmlo3fRvwW5ChibStWvC4J9bHOTDeRRL4Hq4dX1I34LUNYnBiV47rDEaOo7WW9We6rgslC4nryNjae9tl4Ew3P4CLXBM3V9WSioO9BOIBbQxinWpRmdMu1H9A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:21:10.2392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc23c4a5-dd73-4108-4d0d-08defe16432d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

Add support for the AMD Versal2 CPM6 PCIe host controller to the
AMD MDB PCIe driver.

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add CPM6 support
  PCI: amd-mdb: Add CPM6 host controller support

 .../bindings/pci/amd,versal2-mdb-host.yaml    |  41 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 367 +++++++++++++++---
 3 files changed, 343 insertions(+), 67 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

