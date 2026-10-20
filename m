Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792505099;
	b=GtHMs6Dan9DCSsX+IGpp12GrxlCtVn+9J4xscDmgEVwUqRGY+yKW0zEe0w9T4B/sANpQ
	 kqyug1XQfgHPY9R9ZkdU+krYBJAvu6XDzbb/i61T9pJbu9GJHQDuILoxbG378LrgzaSAO
	 dd3x4u/6YLtHsou2ZGuz+mBh9W5uqqTddIoXBtskbFUtjw/qHteRFmCKby4Iwbft1yHQN
	 c8vRv20RkfZd+OkcPbGerDMny+A1eH6iNmIeYf5R6jCAObuTFC+vF2UpdUn3UkigVeieS
	 qmuFnQ6H6OtayG/Bf8tqsDuwQcRDPMI9bnq9OJ/Q/g24O3YJvpRuL5CeaICWqqmv3OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505099;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=p4HJP1cu+Lw7vu0UaWQGHovc0YFUDe4JPIlnC6h5x6Y=;
	b=ldz1OmB7dLWfHjuG9jm3aFnR82Bwjug4w7X5DSGbWUqGT8NzX4dXIWEuyXT3Xr0HNqEs
	 DEG2XyXHWaaeGnXX9YUkT4nOzst+KRSB6uH45XdorjLgQu48ugtZCvSu7hvUXUiRBtvmZ
	 ZydHLZMmJFv18Th4Y9OnbJRzTNmItWpoz9Ti3kL74yYTQ6ZTJ4ukn7m2gtED4A2bkMhmr
	 LHUB4oVh5UsUhhQNPR8Hk7g9kVkKiM4/HT6n950TvF9Oq3kK+0mdXlIxG8mkXn+jqN3uD
	 fKsju4PVyQUos1aJ1IQTlYR2n7GK3rOsSmoQ8d2oytx1R5122llkRxoUkYIcGTjQ3fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RaQ8CMg3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.54
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B301606A31B;
	Tue, 20 Oct 2026 14:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B301606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RaQ8CMg3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW+/yP+h6cLjsTZm7GYz2HQukKAdk3wIaKLneCQJOAQyUbUpPoSt/nRgdsuuLuxEQT7+91TRcJe8Rz++N/Sovj63Y8hmYSYYiJ6G03uypR0Vg3UVF/3F3c2tAJNfnxi+H8378o0C9ExkYBN+90McEFDKQd8GjzLL2EBPF5p98R1Bb+G+hNybpma+7VUMGFeoSXxMk9qDlGQZGHpW4hRHt4g2DYIev7S/3kB529k7BFElbxw4JUmHzKkoLWOyvok1xYRtWoOadZlPj6+yNQPfzj2WLUmt84P/hop0+2JoIh1CLbKfgRmExIFyg2zkXNGJLRRBc4zlREw4xfG13zhZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4HJP1cu+Lw7vu0UaWQGHovc0YFUDe4JPIlnC6h5x6Y=;
 b=LpezrNip0TF0zLb/zO9uyjGx+RsbVLRP2olKti35tHrkneb+I9CE548vpw7EsRszJlE+TfvsvX+6cEQE7z5ovvjTO9RgcOv0wyD4CERSAxImwXziJzkU7+36T7LvWYEWzNWTWNxHIur3LziASNcK1vZ78t09BNMKY8ku132ZGQMlnQ6Q9aOr4ugiKlv2ODWJcIZk1PWqPnaGFZGetnyaOxg9ribjkpGp9+C7KcnWWeaoPyWWcjP0Nl4lb0mTtiTqqq+R0uA7oqsTj9JSbZ2Cj9CiiDnJXf9Ofv6skU1Ujpg4Q/gWAy/iBHVKNIlmm7OcDKR7SSkMW1GPqNt+y3QcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4HJP1cu+Lw7vu0UaWQGHovc0YFUDe4JPIlnC6h5x6Y=;
 b=RaQ8CMg3xoeXunYE1s0+QSDTXf7G4AEn2rUo37RPx280qSEEyuEawXQQR+KcJdEhGfd8y6zFwcskKHibN5Kxqy0IvW4rdRd6qzvZETKC6gmpydsnZqxZ9IlNq+yY16zfYN9I+pjx6MRFxkK+9L8mqd/UwM4Jjl1RKqbzo30n3IQ=
Received: from CH0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:610:e4::6)
 by CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:04:55 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:610:e4:cafe::c) by CH0PR03CA0181.outlook.office365.com
 (2603:10b6:610:e4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 14:04:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:04:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:04:54 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] Fix amdgpu detection of pci=realloc
Date: Tue, 20 Oct 2026 09:04:39 -0500
Message-ID: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPd012oC/3WNQQ6CMBBFr0JmbQ0dLKIr72FY1M4ANYGSFhsN6
 d2luHb5kvffXyGwtxzgWqzgOdpg3bQBHgowg556FpY2BiyxlqW8iNiZRXjuPYfsCpQn7IzCRqG
 GbTV77ux7L97bH4fX48lmyZlsDDYszn/2yyiz978epSiF0nVFRNW5IbrpkY7GjdCmlL6Ogm9pv
 gAAAA==
X-Change-ID: 20261019-vfct-regression-2142fc52852a
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CH8PR12MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 203b43b4-a9d3-4523-2d7d-08df2eb31e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oAuVLCjn7gAMcYxmzKiNAd3BE6R/oKCg0y45kWKXvjhskZ5Nw0kFrwMXBVfBYJ6Oga8HKen8OfnT2jHJaJzHPDoDPOOdGHqm9XNZ846Rn7d36LQZUiodNS0mDQUcysqE0sdMbQ1EPfGnZ/jL+V4pTNSSlzQHI5jjlZiEiEVDFLsR8HyZcNVSxR95etYyHGtHuNldTLrc9dEDyZCDUUZLtFbg91niYsU0BQ+7QYkiebih6yzlmQhW7nugfTKTUWk8cI8DcHssQXi+uv9wacdy21uzeyp+GEJbSLjq/HpADHWu1BvEbdLFJELenjJawcnpJrmgQtsL6mb+SmHfX6ih4JdhBKyzH3TXmsFF6kKtSw6XeKva3meFq0G6I8AJdDYsof3Wnvhn/ea1fOKkJzfTpT7zelEugEAxxiSBbf9GUAzYh7ePF4q26osF7nb5TnoWNEbd4Sab/s/3CsNmeLzeV5+ZKvSHi6XjSIL17l6BYBtYWavioEl6P5jmo0RO8qcWYB61A6EYtiqc4jOedHdLfcwy+8UkZ6msx4BiRc5Md2kMYXuvR5xmqVh0rL/vDpUCCbUhYNYWnQs4bGngqYAnYegz9dXHOz1/NKwkgFzFMbCZYeG/5gRApPT7QjjmcK/Dc6mdskkKQW9BtCGHASzEhQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y+IcWZsRUFPPUZMcRb5mguKmsmDjF1oFL1o8igl5iCuy6MBKyJKbN0RVuIAfMzXHv/yyxWvRLGXmRJfPjYmopmNhqLz0ac7z4irStmosZ7G/y29TtV5NtNPgI1EVsBgodSs8YDJj/6KKN7dygQGfJXu5eZP/bIFLGAAJuQiV1TXccgcMNZrABElDB8JGZY5L5LuNk6hJDRAx4wrokdBqcN3va+s0Tzg+PJXnBU4nRN87qNBuFwXy4YL5E8ZZ6oG+mnxUWpbswHpRKa4PLWL/7ox759UpR614AgxrcBMdApyy2Joub66Xz9+BYeVFk3CK/Rz10r6nnYwW2gRRWw4PliXIGJ7mB17mPIUPKwlagPhJgKLXFYpbnX2pecNa2WXOopocaPIsCg9Huxi1LPXPvglBq7a1y83TDR8MnYLCVLSrErL/qMtfTEvvP8koFEb0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:04:55.4292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 203b43b4-a9d3-4523-2d7d-08df2eb31e72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838

amdgpu needs to know the bus number the platform assigned a device to
be able to match firmware images against the right device.

This was previously adjusted to be a soft filter due to
commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with
soft filter") where if everything but the number matched to take a device.

This however fails when there are two identical devices.  Instead save the
initial bus number to the PCI device structure and then match that.

Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexander.deucher@amd.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes in v2:
- pci_alloc_dev(NULL) remains safe.
- For buses behind a reassigned bridge, the PCI core now saves the firmware secondary bus
  number before clearing the bridge configuration and carries it into the newly allocated bus.
  Devices discovered there inherit that original number.
- Add changes for radeon too.
- Link to v1: https://patch.msgid.link/20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com

---
Mario Limonciello (3):
      PCI: Preserve the initial bus number in pci_dev
      drm/amdgpu: Match VFCT using initial PCI bus number
      drm/radeon: Match VFCT using initial PCI bus number

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
 drivers/gpu/drm/radeon/radeon_bios.c     | 17 +++--------------
 drivers/pci/probe.c                      |  9 +++++++++
 include/linux/pci.h                      |  3 +++
 4 files changed, 18 insertions(+), 28 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-vfct-regression-2142fc52852a

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

