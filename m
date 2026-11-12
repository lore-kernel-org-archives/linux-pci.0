Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794526940;
	b=GGtQ0f2IWzzIa8Ff9z4wdOE38Uy8qNBZO2d0SPVXr0W2T9D2ltyHBoPLUa6AlbUYa+Hr
	 uj8xo1n8SOt5oB3Z91DNlDquJukvMKrNJ2mCrBfkvl6eO1CqoWyqkxuXl099KM5iVdiY7
	 UIdglE3UnCgWC+HfISXEvoIAhwO2tax6UgWGbuiQIdgMA6hFXxJ2LoKwVWSE6N6old4K/
	 oPfn7BqWfvcEU+oOx5xg3o0toRvhkXUPm3JaYPZQcskdUXFNxLHnepdVc06BScvOnh70a
	 ue7DdgAK5Iz35/5iSE2anviFpnuSOfak0NrKhvumUq2tS9HU/nhdq6IO/TgYBEje33g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526940;
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
	bh=6zPkleiqsljKb3sKClsAxvVbU6og2wa2OyvI62mMUIE=;
	b=Od1qV00akYPL4zWt6Xyj/RL+0jijLcyo8bPyv005QiaADHNdVBeDO3JRgwp1KQJ+FPe/
	 wT2a6XbCnKn1pvOZ26i3J2nYIx1+quIuMMYbIqJ6XT/QyuCBU3rdAm2tMr2Gz2ilXMYtf
	 gtznPLCh2mQlGs9U6mND0IgN88xzYAm9T27b/TWPnaBcH8ZQe/FU9UR8kOYmSsKcuSXuW
	 30xNWbjjXf51klOeRGlqtBd8D/X4tc4/P2CS5KvwrjGGyeduDNTFP095Cth+DzH4fYrPV
	 spE0LDuJ+dyAbH2A4FpyAnBgQWj2/7ogwshDBoa45JAL91ocYOxVH/q36xgq9V18dMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lBkjfJYX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.39
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEE606A31C;
	Thu, 12 Nov 2026 23:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1BEE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lBkjfJYX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2tOnhL0J5wL2gGwGizEXvNcfdCGxjnVzp46/qhONztRgpWj92G/DqIeA/6DrEUo7cpys13YZDBLpO1l1kpoVwyfINHZpSXSDGyQb/SgO96GOx2EGKmZRdw8+ux4ePPWLYgf5I2me0g0VggNRek4Um6qmbtOHW0k3dK89vwtRKhwjOteuy+mhX6Q+pnK0strDJ/mi5/UdyVtM40ELxRDnLc4GR6nkHLZ0pTRJbPaNqSQdJ3nIiWsR/qgEYjjAWr2dMdzkT9ZnKdFF+7+0aE+7Nt619FHXQuV4BO/xdcAYOot0BpMSOgoqTWeapknFIgTecAl3rKVoMASc/2YPoiLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zPkleiqsljKb3sKClsAxvVbU6og2wa2OyvI62mMUIE=;
 b=J/3gHgK7D6NrODYolxf2HPJGOTRRcOJYuDDH8CCGtIdJezWu9Nq5TUtNHSofPSu2LQwwmJJeGYx0l6kTwix81JIYVAUdW2nvBkfJ+izrmFIuW1Q15N5N08lSTyTpSAglvu89YxqUXKJpzFivd6NeDDhU8Vfqeicq4vQJWpVPJ5rcPJuETfjDofBYs4ZzKr84O6ftU8RNYSiOVmIv34otCPx/rxYZ3VhT5BwPnXZzb56g1E2yzmZBa3wp268swpW1HGx8n72XYKQEySssE5CMkuNe/Lai4yizGDxVbJ2UQf9xY6IBGrOOn2Rv7j+DcomeV5b0B+ulCCh1geYbel3/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zPkleiqsljKb3sKClsAxvVbU6og2wa2OyvI62mMUIE=;
 b=lBkjfJYXg3Z/BFWAXzJnkRxz8EPOv3MpFMjqjEAsI4jQDznrR6KnIsAetwRUIoH43fnFivXRA0q5Pl5FiuHbxOLTRobbL74OrWpcBJhomDbF2N+igiEN7SrQEx57tnMfxyk0uxRxfd/Aeg54mTXDZL/g+7GVQ1+Q8/2KHC5jots=
Received: from PH8P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::21)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 23:40:32 +0000
Received: from DSM2EPF0000000C.namprd02.prod.outlook.com
 (2603:10b6:510:2d8:cafe::ad) by PH8P221CA0025.outlook.office365.com
 (2603:10b6:510:2d8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 23:40:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DSM2EPF0000000C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 23:39:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 15:54:59 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 0/3] Fix VFCT matching after PCI bus renumbering
Date: Thu, 12 Nov 2026 15:54:52 -0600
Message-ID: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAKw19moC/3XOTU7DMBAF4KtUXmPkGf/FrLgHYuHY49ZIbZAdI
 lDVu2OXBYkCyye9781cWaWSqbKnw5UVWnLN06UF+3Bg4eQvR+I5tsxQoAEBji8pzLzQsVDtXY6
 gMAWNg0bPmnovlPLnffHl9SfXj/GNwtxneuOU6zyVr/vJBXrv//UFuODaGxljlHaI8dmf42OYz
 qxvL7jSKPYam44onYoASgu/1XKtzV7LphM5PRiKxtlhq9Va271WTQuy4ARJFzBstf7VAH98rvt
 t5ZInN8CY5FabtYa9Nk1LJ62z4zgaWunb7fYNCMBl+fQBAAA=
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
X-MS-TrafficTypeDiagnostic: DSM2EPF0000000C:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d1c63b-c4ea-41d0-f4d5-08df41164165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|18002099003|261026140227099003|11063799006|56012099006|261022105027099003|10067099003|261021121427099003|261102123227099003|261009223027099003|261028144727099003|261022075727099003|261021123027099003|261026121527099003|261022115727099003;
X-Microsoft-Antispam-Message-Info:
	fQTZe5j/awDfbk5PGZ/GwUJJrXWXKjpaUK6+im+4nrfjn4C8l1Lgz3MOClmyPRvMXJ3wdKi9XKjgpCs9oQc7SIKqwVr5JE685FEnwFr0dqkFsw/GAjwej8klJ+dWKquHufLzQ4lfICozX+R2ZWhc42v6m9Tp7Eem+27sZR+60l+/ErFtRN8JOX2fOUFJWBAab4xTmvKpgqtIW9dCDVWoGDPdto4t6iQjodbUTVxhNOT/9BJordm4tql1dJMDlmV+BBL0HcXC2lRfy64imjl0vtEbkij5IaGDTrlL3ySK6Kg17hHN1Nn4e+1YGf4v14t0KKfXLT/ZG7hFU0V7/OWSRchH2m2jtAPtQPolsxR1ehPHT1f8UfRdsUUH+Y4Ybrq8Kqk6v4kfsROnbXjuSWJy5cQHDYDaRgPd6DKp32AwHQQzcOUhGE/loT9c5P+KfycmLh5pYKKZ0tAfZ05O0zzJSJxqgiFF05NnkE2Iytd+eL9AWlEIgmrtj1KkyL/j3lOSnrmpXkzd+E2FRekrH8ZZ9GxUzQruP3JbzevSxOMFfuPWZ8KPL22+A8YG8YvwvredRDMWrLrHwCaVcLnLZYaBchsKRK+AwlRx5twzJg5n9aTGzC3ZDl23oyivfxGcmuPNJDnuzdT1+SqcKmyc+XGMiDIKud1fISd+eKDr5Q2RxUM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(18002099003)(261026140227099003)(11063799006)(56012099006)(261022105027099003)(10067099003)(261021121427099003)(261102123227099003)(261009223027099003)(261028144727099003)(261022075727099003)(261021123027099003)(261026121527099003)(261022115727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GA1p11qcOizRmaoNvd8MFxZNaoY5EJnKYr6a8MfzN3+S6uqetKzvRClyRFVfFvRIBORitzu9uTwc5oTyDYULpx74wkfCWbs/tKyhsElwNYC/ab9wNVOOSx97st6rxFrkdQu62I9J4Lwe2Ka32NuBqgWEPvFlsAPiVrnTiM8OGn8aCw2Z3cqDtuNEHYVL1KUiJJ65U1uU17EvhxuponJ+S0xjziYanS45aO0a+8bp25a/sJNeJJxiQooQ037q3+CMZCMimiE/FJJd8nDLx1mnrn9Jd7MlISFhn9ECHAUqSZvCMgQlH7Dy8Bs+18VWnWuIjzKGtIb/jDFnJwsMLLPz/wju+crD4LyGQ/u+27qNM2gkQeoxl7AnQIlAcNTvglKuYlrApU8xK/+coBKSgtZRRhBfh5hJSSwoKat79ucdGRZpgHeCOhgIT4Tw3JZXd9Po
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 23:39:55.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d1c63b-c4ea-41d0-f4d5-08df41164165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DSM2EPF0000000C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132

amdgpu and radeon pick the VFCT image for a GPU by comparing the PCI bus
number recorded by the BIOS at POST with the device's bus number. When
the kernel renumbers buses (e.g. pci=realloc), the runtime number no
longer matches the one in VFCT.

commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft
filter") and its radeon counterpart worked around this by accepting an
entry whenever everything but the bus number matched. That picks the
wrong image when a system has two identical GPUs.

Instead, have the PCI core remember the secondary bus number the
firmware assigned to each bridge, and make amdgpu and radeon match the
VFCT bus number against it again, using the bridge above the GPU. The
value is captured once, when the bridge windows are first read, so
renumbering and later rescans don't overwrite it.

Patch 1 adds the cached firmware secondary bus number to struct pci_dev.
Patches 2 and 3 convert amdgpu and radeon to use it and drop the soft
filter.

Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexander.deucher@amd.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes in v7:
- Reword the cover letter and the PCI patch to describe the current design:
  the firmware secondary bus number is cached on the bridge pci_dev when its
  bridge windows are first read, and amdgpu/radeon match VFCT against it.
- No code changes.
- Link to v6: https://patch.msgid.link/20261111-vfct-regression-v6-0-393797bbb6e3@amd.com

Changes in v6:
- Capture the firmware secondary bus number when reading bridge windows and
  ignore unconfigured values so rescans cannot replace it with runtime data
  (Sashiko).
- No change needed in the VFCT consumers; they continue to read the cached
  value from the upstream bridge.
- Link to v5: https://patch.msgid.link/20261110-vfct-regression-v5-0-f49fae981bf3@amd.com

Changes in v5:
- Record the firmware secondary bus number only on the bridge struct pci_dev,
  guard it with a validity bit, and keep it across rescans (Bjorn, Lijo).
- Drop pci_bus::number_initial and have amdgpu/radeon read the saved bridge
  number when matching VFCT entries.

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
      PCI: Cache bridge firmware secondary bus number
      drm/amdgpu: Match VFCT using initial PCI bus number
      drm/radeon: Match VFCT using initial PCI bus number

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
 drivers/gpu/drm/radeon/radeon_bios.c     | 25 +++++++++++--------------
 drivers/pci/probe.c                      | 16 ++++++++++++++--
 include/linux/pci.h                      |  4 ++++
 4 files changed, 39 insertions(+), 29 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-vfct-regression-2142fc52852a

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

