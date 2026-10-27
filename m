Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118172;
	b=Cmm4h98WRdLPDqQ/MaTHMXH2VG+tWKchhCrrGZcd04Dc483t2X23w0MYGlfu+DS1Kcv5
	 UzxXyIK9Y4ge2xsW3yBgY6xtqh5s+veoV3pqlXENQW/1ZEeh34kp8J8aJDkt/iffHioAb
	 FqcH1593E64/YU/wcWlO2bvlioIG60VoZM+SiAxTscxBoxQGxV3XQaavuEBsnLBT9d31J
	 0ook9YxYszkvJ2fKm/SqV1iQCeqE8KtZoHYmebCSCX7IE8lL2lOVVd7Lfkk9yuzlnHP24
	 z1mN0tHuQd9RRUVs7g4EVnXvfGwgSooePdPiBlgAMZxn5rFr6S2GBT3moQjl7v0DgSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118172;
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
	bh=6JXeRfuxj9YlxzGXyyPkCJ+H6YU+8PeBq9nFQTYV28M=;
	b=cyYd0eMU1mcGstCQbzWnA2JXkWe7E1zre0HzRUpJBmdbWf3PSmZ+PfZKaZubn+a7y742
	 VsX7Zr1zsjP1z+MvHgbyLOcOhmAPn1eXhP4JmHKTX12YRT8KgmG1YgBClj2WwFAglSak+
	 FA01wWyvNYykoqK6odyYNaptb22Ele23Wrwm4d+5IxJWpmJNCw08m1r+44Xl8hGtEGAzV
	 h7K3JeZTbP14PgRIv83G07opxh3v5q9FRAba0YqAQcZZb6RQgsYMIK0A8iXevow4R1xcD
	 JgooZ7kuxr6Q8QENOaR9vxuQp0EPrZ+P6fGa9TuCsdfVQQF69jDHvgkxpsqj20w93cA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Kxo9CHAL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.30
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDE606A334;
	Tue, 27 Oct 2026 16:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75FDE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Kxo9CHAL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv70IUHXUrK8yq/0JijtUkbuBR1znEkNaO7o5JsrU6iDUuCX/cu/MbbLnG/y+hVCJ60pUl2sPD2DSY9S3OrBgTSCskEWEV/MMjSgvjjaDMcEJXZcPFaf07BUp/movfVmO4J+qhYUpjziz1Xb9kSnQ2LA/dM28FvXzwkDKSBYAlEQBWWVbFNv+RthDVvwzLNrK7l9vvg/N4bpRwFTDzPsXKxvlCqEvwwvS9oxHel3YAVQln4tRMFqh2Wcp10/HFz4pxHIg2qR/LTpt3HNluSLZBO3vQ8kE7kk0UQKfhuez8Vt6pbPWGS44Cg0korhukhxAMZ30+Em1QqkKfNb/0z2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JXeRfuxj9YlxzGXyyPkCJ+H6YU+8PeBq9nFQTYV28M=;
 b=e+qJYe5rzGlC9JUrSVKJ88WCxhZqRFIUbs5JPnsaLxHiGM3Io4Aga8Za37JVRTR76Gj6GaH2AQT6Z71hZvH6kciEAY0Xgp1TX2ByF9De4xBB24PR63SLCT9xvQ4WowAhYeL4kAiUn9nzT9e0c8fjU+7jFPtYvz9YxEMphWx250MbzeViStZCLIOr93fXIKc7GsirUxflvEgwDnZzMCIcy9vEKGtxcshjqVipSg/xRtrbPEzJxqRcWex58sLjNF+A6FDR1D3aViuLxgEGX9uv0hSiYXwQ63jC0I+cuRQxy/n/VfVE/AO4cbuQIezV8I34ZhzBxkgPpyozbI7iAML/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JXeRfuxj9YlxzGXyyPkCJ+H6YU+8PeBq9nFQTYV28M=;
 b=Kxo9CHALand6WjpY8I3G8Lb98BvJAr3nJyoqA7xQKdM6MVmnR286IXvm0ZqjdOdhOYFxo7795+2oMPcwiC3zs5Ciu1olKglZAIPvsE2KfhnBOuoaEsARVELCJfTTOF9H5h64BWKQ3oVPvXaqVd3GlWrSVZ5AD0DPADDWqboLH5U=
Received: from BL1PR13CA0413.namprd13.prod.outlook.com (2603:10b6:208:2c2::28)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:45 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::9c) by BL1PR13CA0413.outlook.office365.com
 (2603:10b6:208:2c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 27
 Oct 2026 16:22:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 16:22:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 11:22:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 0/3] Fix amdgpu detection of pci=realloc
Date: Tue, 27 Oct 2026 11:22:24 -0500
Message-ID: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAMDP4GoC/3XNQQ7CIBQE0KsY1mLgU7B15T2MC+T/Vky0BirRN
 L27oAs1jctJ5s2MLFLwFNlmMbJAyUffX3KolgvmjvbSEfeYMwMBRgrZ8NS6gQfqAsXS5SAraJ2
 GWoNlWV0Dtf7+Wtzt3zneDidyQ5kpjaOPQx8er8skS+//epJccG2NQkS1rhG39owr159Z2U7wp
 UHMNWSNoJoKpay0sL9afWsz1yrrlhpdG0LTrOuPnqbpCZktQr46AQAA
X-Change-ID: 20261019-vfct-regression-2142fc52852a
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fd0acf-4724-4981-df23-08df34468849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|261026140227099003|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261022105027099003|261022115727099003|261022075727099003|261021123027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	kZ2yCn7xd/rSKVKHApjfI4wC4Vu11yvYzeODcTxb/CmPBv+d69bmELDu7SIVnlCj9PCLuxTUHYuH/w2TMJIWKY+J1RBKd7LMDHEyYp+OzxysmPJOpeASnPBvd9t3wcv4jt6SYTAR+wYLM6eByWuPK1PkaAws7Sn/+xaah3M7zmul+Qew25iocYTSgczbZUY4YRzzDQZsUSYpJT/XsdGKNHljurXARB3ak9CwIKKxrrHvhwC2c8eZxvr1AiujDHoKffDfjMUwUtFLZvu6bhNY8L4eS9ebgpxeJk6hvPsB123YKRftCgcXih1KftM15vO6BezUZMhCG5As/OZcUoKpT5xUWhyhR7L1KdFpEs+ixe1pLXIpxDWdx9vuy9mmU40VU99QO932ZgBlHc8DlFxS/e1pazS1YIt0NQxi+xnXnxg64c9v+rls0F10lnwnyzTsR53GCa7/IsBq/12vQECaH9yheH/rSVjwltbtr8zHbxsYd2qFo6BMWRg32/2YR9JqyGlkVu55wbSsm/4d0SMZv0woCKuAHm0RVZg2CfMHeZ7H+uIZnwwFcix1zJpbMQV8OW5rHbYIW2j2waPOnQtJ+sKNqTOJ9D/BOy1QE3jnx3BBgM/9zn0uWAi0Zgr6q5UkGOum/QECsaxmoad5lD7H7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(261026140227099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021123027099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3JKU2Z1+RnDv06H9+0nlZ8TDuRluYfUVWVVjaQz/4tsEVdJm8x0+8rUY428ePqr3UmpQFDqgWkn8NQRQgsBYWqBBZYnU/jR/aBXnZiOl41Sx7AGUiZv2vBkpj54ZWjPepk4G8PDDj3isoA6nZG3uXfEkCz64IFtjzxUkEaQAVzb0eH51+OPmbufAgBdOu/LMMdOFVkroXHaqyqynnRvgQ+RW7CBgIOcDOK/MybBooDA48sZYecJipnbEP5ipJkb5AYtJpRhBHLlVYoZgaoXEqfLpQlPZgnbDjiIX2G1D+oJGQ1Ut3uu4vVqPhZG08jrLdzZYF0JhfWxs9f3VZ91vpCXgOsltyGtV7Tx0AEZwZlGDp+mo2QHlkut9n3XY6Qlt+z7ZKQ1GW5yTmHCkEhzXxHUxApwFho9aFFgqQLpmAQhwjPeWbCB8rX0OgsfiN6OL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:22:44.8361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fd0acf-4724-4981-df23-08df34468849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715

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
Changes in v4:
- Retain secondary bus bus number for a bridge across rescans, and the child bus is initialized
  from it during allocation, before registration callbacks run. (Sashiko)
- Rename variable to clarify it's for bridges (Lijo)
- Link to v3: https://patch.msgid.link/20261026-vfct-regression-v3-0-fe9586ed6978@amd.com

Changes in v3:
- Preserve the firmware bus number across bridge renumbering, capturing the
  secondary bus number before pci_scan_bridge_extend() clears it.
- Adjust member name in all patches
- Add tags
- Link to v2: https://patch.msgid.link/20261020-vfct-regression-v2-0-d2394d11450a@amd.com

Changes in v2:
- pci_alloc_dev(NULL) remains safe.
- For buses behind a reassigned bridge, the PCI core now saves the firmware secondary bus
  number before clearing the bridge configuration and carries it into the newly allocated bus.
  Devices discovered there inherit that original number.
- Add changes for radeon too.
- Link to v1: https://patch.msgid.link/20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com

---
Mario Limonciello (3):
      PCI: Preserve the initial bus number in pci_bus
      drm/amdgpu: Match VFCT using initial PCI bus number
      drm/radeon: Match VFCT using initial PCI bus number

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
 drivers/gpu/drm/radeon/radeon_bios.c     | 17 +++--------------
 drivers/pci/probe.c                      |  6 ++++++
 include/linux/pci.h                      |  3 +++
 4 files changed, 15 insertions(+), 28 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-vfct-regression-2142fc52852a

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

