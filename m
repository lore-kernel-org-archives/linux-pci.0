Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9D19E839;
	Sun, 23 Aug 2026 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787458055; cv=fail; b=nATYuzVpGt7CU60pHKh5GNpBdnhL3Ye010WDaqoaDF0MA6hSyA5XPqqOsP4Pr8qAnhy6ZoJMakeE4/tQmUmUxEcf3EdrDh6EOyptX5tCcngHC6KmFumyfVf1zuVbVwPrbROyqWp4eJcbFvNohQ2e/sIXBGwTkG71IJ+7uG4oK/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787458055; c=relaxed/simple;
	bh=RV+99wYDyRHhUYZtiQVzH+CiHs5FO4qL8+CB3sXXxus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TICGrvczK9yMsrNI+BBuJSnKpK0KLZVTq5mx/1FBXFCIkYIulJSB6mzzkkz1ghxSpY1hCjBwHWozDbLTxB9V+2cNuz/OfDDt8jTOwzzTgOxLeLkdcoRJMLJe7lHhuYkFpgHeQEhDY4zv1mJlO/N5+AFUNbbLQSMyLZGouAY+cqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c01J+n3h; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c01J+n3h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYhfLIWXKNAaCbULd/G3x14gSSRF44pb15OS8HMevoRbZkcKRDcSVVBnfeqA6mXqvj3VxtYpXgrzje1PKx35hK09CEcttNNYtIp3v1JASauVpd+QnNrkzm0hwGx8b2bUj/tWI53XEfDWN2559rH5/jYL5Z9tbg+Uk9PAy5BnEs7Vg3g/MsZ5yog95QK6ZrHdKemeyuAiW03Y6Fkw/HkkVv8DpO6Et5kCzjT76zIiyRV1iLXE4n1lPVtXtsSzB6/BRHG2BWNdcaEAWDq5pD+Pu5hxJ0+1QNiAbdAw+lKWPSYXiGkta0AC2ZWcLKKz7JTrN8k+Mh9YK097XDVlwUIJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvY42ozFxm5C/TPahpGZe1A9Vaw60s3gbnyZK4yg4Lg=;
 b=NqN7acsLlR/So2FfIDfECav5QH9125EfGIC+Ck+FGzUsYy+qqgpWXaNBSxaArnB+fR99ayKMbiWlXber9AiZEGSAMaA5FufDCj2uLG0Xxe7iGHPAd2x1L5Lsp6/RsDTEwU6yRGxP1re5/m6h9UNDML+7ufvoAxCWaZJuarNKn2TkBXMmhhRhz+o4kDB7fMCflyZrHoi3hW55Fgk0L3qB0WpTkn3pdzk9vfKKXTWy833mVxk+w5wBSM17Vkc1TM7sw9U4s6zLToGf/sRbg4xachLF2f5++eEuMYFSKz7HpACUkAbaJEDidsVXZ7KaoeXZUu8XcEFbpGgJifgKhsl9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvY42ozFxm5C/TPahpGZe1A9Vaw60s3gbnyZK4yg4Lg=;
 b=c01J+n3hHAfaTbL/vv964ySmnKiB6tuDaJOIHgTZm3cXjOB1fWR0DBCZWdTcUifoGUr/uRgh4s9kYdw3+n6DEm8E6e2cRvfDFwg2hVa2E0wIUscO2UBByrWoqkKjBhRRYilXcchm8WZ+ELuuCEPnJR7koSJOk7rJyGaCkuQwJJM=
Received: from SA1PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:2ce::21)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sun, 23 Aug
 2026 04:07:28 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::59) by SA1PR04CA0016.outlook.office365.com
 (2603:10b6:806:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sun,
 23 Aug 2026 04:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 04:07:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 23:07:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 23:07:26 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sat, 22 Aug 2026 23:07:22 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v7 0/2] pci: AMD: Add Versal2 CPM6 PCIe host controller support
Date: Sun, 23 Aug 2026 09:37:13 +0530
Message-ID: <20260823040715.204096-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: ce96278b-936e-4db8-0089-08df00cc0b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	cEjFWeHCz2Wj0AhCdnCZQr3qQrR1MxFe7j2V/6ZMMMlOQtzHACW51wV9Ekpit7Pv5stcAQuUelQM0tjwzpcCd4lpBVdNFDlnZaxTvdUUFlTkMsZpFHmIzVOIoQD3Uc884hvRbWKzmklJBOEMpoUvTyAmumdo/7lgSuwZFzLdw22oOHW5qC3aXfaiidrWxAuWViPd7qcHdS6lTnCrg2q7TUml+PAaMYty3jAzTg0KTbrc9dko+XpZ5mKfBGj6b58aQJYi6HljN5Qw1STItlkmeTp0WTS+b88FGYyzdIpv8T/f/ZRLpLrzRm8LuBVp3vOZX9K4g79uYxq/YpR7xIHuSd2ZXUEyqDrXOuNQKkqrKzAQImkihLkNbBCSVDy7QedBgmyAKg2vLhsyj/YCspcuAWps3PaYoLAza9xYUpEU6ChpSAmbptab/h0xE3dCphezNK8Hs/mwKjuKbZlLi5hHQuTyr3POkiPIn8C/m4xRZFZManrhwS0hjkBdkaHDMlic23wzambl0fCoH7AEdg7gjtmCjI0vsaCuNFdOAiPYFoHlfX76tgE8OCjx3jrl2kgmvnn0Z4liwttVAes1aexFrnSwZsCyk1JfL8e13qLQrbRRMDROGforr5DWlvA6Ph+Q2e9BH8B+l9xGSnXvtdkAHql9PNgwcVO4lYkc0lfJvZvJK/SxHnqjklQqr5CrrAHCQUxolH+Ko1sp4nkAiL6T/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mdXzWNmRrKoFbYm6BoF2NLvuBc6Hp6G5hlvCy0WWUwL7q8hpW99CqQZyqJVbdMyAIypeF7dkk9cTBjBY69eBobnWZEwBTzfa5I7PQ62G8IkNhflViJd1cmQH7MREKabqepRBGunt2/iveK7wIhmToJhh0ZN+BwF20dD8ObJOgSwEV0OQQkqyPoTTdM1JSsYbsaFaB/i30o0q4HLO7YWouzgqv28+6TfO0N4QKmPKuaKmH9XpzpiYs17eiccU9xpUmtdNCgV37S2PhyKrqg/2tJAhL6mN0HJjDfEFzZcDb2S9rcW5TEYz9hDh6EbE1VPx4GtqXDbXt2e2ZqiEE81HDMGuP9b5sp2h2L0tnkjwq7SFQ7/1z8irUhfvq+IBtzfvtZS7A0N6HswnW3ogZXdfxblMFQQgwrOijVNXLVfGP4jLLnvLaNbqDlqTu+2IraHt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 04:07:27.7333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce96278b-936e-4db8-0089-08df00cc0b9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691

Add support for the AMD Versal2 CPM6 PCIe host controller to the
AMD MDB PCIe driver.

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add CPM6 support
  PCI: amd-mdb: Add CPM6 host controller support

 .../bindings/pci/amd,versal2-mdb-host.yaml    |  41 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 419 +++++++++++++++---
 3 files changed, 389 insertions(+), 73 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

