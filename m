Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F1418A2D;
	Mon,  3 Aug 2026 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768275; cv=fail; b=Sx040f/fcNKPIDi/l1bad2Vc9Nh861iJVj6Ex3AeZnvb+MAgim8sAK033oWZfdwlG5C986okzpGQezA/SsBlSywq9lngDD/v2P4gQRgej4aRr5doSXpGYQB1FigZv1llNDuHuaMuUQ1RAhhnz+QZzxAVgyrYqGDi6lz6tg53KKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768275; c=relaxed/simple;
	bh=QSSZcZblqQ/teChVeVE7GnvJLIzrX8vFcCE9n40nGzQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KpZBGrN3nJlWyp5S471uJomvjH8Ag6KdMaPkrZdH9ifva5o9P4wF5HT3JL+c1lnw1uM81BLcWjpiV2/qApVrfPsu6sC192JUMTRTYCDoSR35FZQ6QRXsbk5GnCDpIkRYrJeDN/CJSvMyrcbAMgTi6BXuiHM24B5/HWi+L2LNJeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SG5EXVA8; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SG5EXVA8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/VqIV+JAfnpIkXP0D6TLIioLifDKBzsaUuYwoTQajhzrPtd5Nr38Rv2OeWbsc3JArmlnY0sc9jTILCd7PEgZ8fT+H0+Scrm0Kd0D7BGFCFZlgevDPBHHZHzAUDSTeZSlvs3bSjudvs4w2QbaIW7jXBlXWZigJJKxHwiMtTID55hHfa+4AaLXpKCBWCIAC/PgHUT++zsh5NWzg2S9t828LZvWEMIx08ZLBDr79RAJlev9PdKjI8W9BLGOaybM9pRiH9NIj+Ngsm4dlgNdOEBc58318tq59JdsYqAC5wYvYl5TD8N8P5BEvfJw1fOMeP6AvlTvLVyFtuL+Oo7oJ7WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vax2om5mPPpFPMCXmIxJ7NZ4qMA+5grNcrAQG2j3JYg=;
 b=sEFTV4RE3krEy8ooJfIywF8qxMoXEKAXnLD0IfZ80onI6cOyTnI7l7jyNthfqTvk4YYwfwLLgCDFBEt6K79KGtywlK1yAhPxMqPgKRoZRMXKi4kELZkGIClWXkf4sxqLMOXFx7bdYrS3Wt9MPVBObJCMtl7BZgTorjlmnKc8Cq6NAsq876+s3vWI50gU4Q6WDEjNET8yqxEesndFEvrz6UmXiIjNigmQ5bpz1DN7M5WrPenMyjEy6zhwW2BVQ8d3sAZpxKrUTb8jV+WOWPzS9LrfZE0d7FNFZ23Z0z4XucKhCQdGe52dWt7CYl14q5Y+/RQdDJg3HULMOMPCfzCkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vax2om5mPPpFPMCXmIxJ7NZ4qMA+5grNcrAQG2j3JYg=;
 b=SG5EXVA8m0c0hhcKz1knQiziJONXrQbpdFeFlasyi7pVJAbPSmbUNlvtyC2J+zJNF9BqD1MZmh0n6TRKd9TYCJpC7R6eIEu4lSF3oKZPW4dyuKyO47F8Tx6M+Ts8LS1QOytTbgKzhbg9HqLY9lr50UoAFRQNrMu11pmEjewIXvM=
Received: from SA9PR03CA0017.namprd03.prod.outlook.com (2603:10b6:806:20::22)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:44:24 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::5c) by SA9PR03CA0017.outlook.office365.com
 (2603:10b6:806:20::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 14:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:44:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:44:22 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 3 Aug 2026 09:44:19 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v3 0/2] pci: AMD: Add Versal2 CPM6 PCIe host controller support
Date: Mon, 3 Aug 2026 20:14:10 +0530
Message-ID: <20260803144412.713639-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cda2cd-309b-43e5-7f3d-08def16db5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SEeoaPqkBprhreJOvxp29lCgEmkDKzVH1Z6PyiRMyNsBPTha6S9qYZf19wjFHYE3X+1hkq90oq9pc4Ib/dLFaE2KyM+CCmdw93sIKjUJk3GQVMCQOVC32Ck55h/7SGqxf36WSPOOFpZA9Q56pxsnD8EC8F3Mt+1TlShckUVH0MT/S9Z/e4wz4vuNNGXF7fLPDZXe4lh7ivQjwSenomebeWHZYmMXySx8fUmg+uqOJLvSReUKm2osX0G6cAaxOURgW6TNG5FBhYxfroE5yJ6CoeP7PpvmGVch6dYjM95S9TjvnPMMPB/gkSfk/iAYi49U2xIJaJIYBXyj5JAOhHxpgQ/tBdpmfunMEBuuIeJ3nGISi84Rkh+TGFYX88v3Ii2L495yWuTkHqJjRocyjqS5C2oYLP4ZGF1kRVHblklGj+RD3+jtmCUC5LkwzP5mybcBmMA/fZiOsHTOLZqDvbIC1ZGLDsSaU1U7VES7FQ9Zs7NU1CLL1o3WEAkUpgCNLdILPFgFuxyO5La5vXXIjexzqY6naxkGaPK1OZICOaWLivpiWq4gDvb3lKUj7fLyDsAKWIjqifOJ67jPq0aeH3dN2H9m0mBCREm+6CuE7gWPF4fzGCWf1GEi8T/RiNg964gAm5czNw6uCMkDUIrJBehFIZYBUKR7fXQJewmUW8YbAupMyU5SlZzuI34C2qjCyu6l/vlji82h7qv9BBna1ITpZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CVNaCposjd/YTOZ3AR3cp593t/MwvmLBXrbuDYt27ttY7C25VtIOL9l2b4WB2D/gKibEawqw4WiYI5/611IOqKp3I4mhQAGyDiF59hQ7hs8dYkguC5CwMPDi/iVyxMc9a0iKIcyISD60KbSPADiUm6NQV70R8hWHEbi/U1OOliN2b8Pz2Of4KFIWLzDQdsFWrZ+Jt5FtH9af25lbRY0l7zY0YcEwqPIEWqvkFKIKlnTCKUGsIKBYSmln//MEuIsVtiDZfuUjct6FqZquJdC4eZtFJOyRBvgYp0G3/MBve/DZkhJKefPIkRjgK2wiUlr3OeXG19GtTKgDN9sdBq+TR5VQBAAwScpIIJ43Mvbrumpj8Euqr+RHhGO1zq56CjT5G5P1YhDfRvEKe5Z7FWrglLW03ezEx9zt7qxY6sLL1hll67ImaX8j6TyXpOdPaCy7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:44:23.4319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cda2cd-309b-43e5-7f3d-08def16db5ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675

Add support for the AMD Versal2 CPM6 PCIe host controller to the
AMD MDB PCIe driver.

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add CPM6 support
  PCI: amd-mdb: Add CPM6 host controller support

 .../bindings/pci/amd,versal2-mdb-host.yaml    |  45 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 413 +++++++++++++++---
 3 files changed, 395 insertions(+), 65 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

