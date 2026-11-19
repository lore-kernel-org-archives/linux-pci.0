Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795116090;
	b=WNrSDyXBQtyirBfEmYOYQgJAMWjtd3UHKydGqouwb5gHOHcOxupJhZJUbjE7Ji5VqjJ3
	 d5Z/f2RNsDDm6361OuBhwjt7EmunEHIvzo2q0W/Ivi4WJ0D5CCbn1tVaod+khSAE+bZ5x
	 pWl9a78liob4BPRKnsXE/R88iNiBgX10V2a3T1CO9IovRX+shwD2BaL0312RfQ/oM5f8R
	 qdSLQ/8F+vVn7iYaCoZEo7u26lNBnvxLrgDjPgUEFMh3toWI9CJGJCDbmK3sKf2QyasGc
	 9sgRPru4ymSxq5OT4yehPEZTXnMMuhZBaDocHNAeEKYhL0LQ5qZ94BB7jc10/pxn3qA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116090;
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
	bh=CxeNOcLrKHTskaNYsXcUEY7BS5yDKx87OX2PUILv0y8=;
	b=O4gyAmwcJL49fuN0nX2QosOailoXNn0oXUsQ7jHA5+KaNZwKQLLqEHjno/H7e47oFI8K
	 Z1v+Wbd50VeF3MOAv7lOwQ1zpN40Tyy1gigeB28Qn4Ag5/a28uuikyR8pBC3RBqHij/u5
	 OL5B0ShpPmTsQ1LF/yseNinm9woxMZQpkWcbhypdSYKIQWayq4YY+WAdCMlMMuKt33r5B
	 9wja2cuHxUDTvKStAAPMfFKKTtGOSxeauNXwdzBGyISEQw7+JNgkUr72t6HuxgaoLyhNO
	 IVE5+bEpWqskLcebrTCPpSC0VYVvd/I3MGo6YZmIbucFk5wl/PMYCfMFdJUE4vULctA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LybaAaAc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.25
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47122606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 19:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47122606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LybaAaAc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgcHF6gbYuc7M28ciw51ZyDNstXP+dzdE6ccCOzUGg870tSn7ER8g1ZhDBJOyVwMb/V6mgzg/waPMrB1ZN2RdIVBvJtBvnPy5GnOp8ZZ+A/5jUsUv+Y3E5ciGiuCO/JtwaTPdtGJxuLWWi5Hb3gdsXF7vTQxcSC/FCRAs9nLE5jlwrLGLLjnMtGCd1Xol83emXCMtynMyz4dms0AfgBujx66CWiGBdtd1/7GJIrz3kcvaZprjbn/PhMrOKTNAoR625s/s2OIr+e7HcDRWH0RXpd7H4yZ5DjONkWblY25l+D8hx6/82O4yFfp4MxegcntAJ47oxqvUaTN0pIQHvzpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxeNOcLrKHTskaNYsXcUEY7BS5yDKx87OX2PUILv0y8=;
 b=M4F+W1pmgaTQMcym4jDXLADMYnHeFqgwFnyhTLF5kMFo/U4ai3er3cJkerkdSegM032Y5TFvyKPcPP6s7Me6C9iqgbNyYRKt8YRaPgX92q2o/tpY5GsX2g8B4G4mkG7jLInCkCELOodNFAYFzdRHV4o6CnGwk0KgIV7jF0LskFvBzpJsvQcbFkreKW4rDEq7ZDJ3Pjml4bjjmAGS+q3LAULzrAjK/m2H6TbGD8/nHapFlgNwwB/0WEwjGcQQDE0pLlWlshnsFH89RPR27KBEfHiOBSPOB3zNg4PFkPtTU9W0h/KTGxj1URQJayflEsRTAA+aCPRpTHPqlHaYlmDcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxeNOcLrKHTskaNYsXcUEY7BS5yDKx87OX2PUILv0y8=;
 b=LybaAaAc9mnBA71NczM1OenRDQyn7nsZGA6OTNKDVWPnDhbpn9ceB9FB9KXusSnfwfRySCL38e1J85CmCt4a4yFrvxOtRoEEruFtg5pNdCLWT37dwPifjfRYN4hEzln6Ry6ppNOfvJ4sKrWzG5L34wdIVwaG4QmC6861K33DwjQ=
Received: from CY8P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::16)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:21:24 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:930:6b:cafe::46) by CY8P222CA0014.outlook.office365.com
 (2603:10b6:930:6b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 19:21:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:21:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:21:22 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v8 0/3] Fix VFCT matching after PCI bus renumbering
Date: Thu, 19 Nov 2026 13:21:18 -0600
Message-ID: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAC5M/2oC/2WNQQ6CMBBFr0Jm7RjaKAVX3sOwKNMp1AQwLTYa0
 rtLMa5cvuT9/1YI7B0HuBQreI4uuHnaoD4UQIOeekZnNgZZykoI0WC0tKDn3nPILsYajaqU1UY
 aYSVsw4dn61776a39cnh2d6YlP2VjcGGZ/XuvRpW9X0D+BxSWWDWd4JLs6UzyqkdzpHmENqX0A
 Z/ZL9zBAAAA
X-Change-ID: 20261119-vfct-regression-v8-d767fad2d1f2
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher
	<alexander.deucher@amd.com>
CC: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Lijo Lazar
	<lijo.lazar@amd.com>, <linux-pci@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1f63bf-7125-4b95-6bb0-08df46724d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|3023799007|261021123027099003|261102123227099003|261009223027099003|261022105027099003|261028144727099003|261022115727099003|261021121427099003|261022075727099003|261026121527099003|261026140227099003|56012099006|11063799006|5023799004|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L39Une4GZ+mLxJLBx4LjUDaesESCi0bYYwQxLjd5RG+t35GaxLaOjTpgobM3VLMVluPGX98vvCOS0N1pe7fWVkvMPYbiAvFIyqTHSod0NUPBtySgJXBUboKvjod/5wJTRLNXO69wkv0u9hb2O2U28WNg3mLv27e9QHR38YuS+YpJ14Pj8PiZgdr+9jb8pQ3ubfAoDoDo+nwEPZanECS7/+Auf/w9id5f7D0gmFfOp//5QPDqduyaWGNvq67qTWBgguFcwe8aZdc6IOjHEgZ9U4iSUno0mwGxTXQP9DMxV6cYgejgHZUakFPLzTVahSXyl0g3M5G5kHHJHCvHFOny1Lf28kiJNjA28555BdTlD+z8+ijx7ADBB7wVfRBD5pOuLBAMgQK759xrs9cguCWUgS9EnC00crNilN4GZCMi4UQ9pJDdfTEd/5+77RNF+oUTIhlbIhBxlU0LbOjdpHUp7czda3pbOJElcUcv75wumKo7Tz2dPuwVko1P2PPPj0o4+O4eE/amzm7GD2IOKkn40HVaeN+hP560jdve3Zl/03mXBwUtLXynHce+0jAZpzozj7bCwOZxXEJ+DEgpYQDonb2C9Rp2aWX6LVJfDQby6tZFgAsJbVIxioIlGf4aXY/SqE2Vsi7wRa2l6nECrtgrAL+LlnpOjLdl83Dg+Qfs26o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(3023799007)(261021123027099003)(261102123227099003)(261009223027099003)(261022105027099003)(261028144727099003)(261022115727099003)(261021121427099003)(261022075727099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YrRB4ejw9UCHX1/eHs/M1qub40OEpA4jT0YldXXoU50d7H/cL6Va6ZZzxDv6Qho2hPgiwX8vCpVVTIVq6l0FhLAx/62JANUkIczYcRmJ9+AD1VZ14/r3yT929CVoYMRF2vdzwgQUvBKi9H9vUrKQoYCIjWmMhyORoex4+KVCxyb43zLu1gdjhcPBHLt0ggaF6aY4yJ4lV+7PQnmcensCxpnpvleTqVhfS3b2WeNysESuo255EtKjtoyUUT2OLPpJXaVQf19y3zhnRqwPnV7osqJ57P31cX1NoHrlnjn2XuBMelFr/fQr6RLddeoVbo1lT+3DzF5Cjgl04pZ/4hUYJ0m5kzTwNiVij8BDi8sbuCqKUmYZBWag847hhkDLB/l0+W6NKmg5TNsp4nOUuTmyNqbf706va3lWUJLxUzAHfWB74TCexDl4d2Wt1jD0hADK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:21:24.2095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1f63bf-7125-4b95-6bb0-08df46724d17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

amdgpu and radeon pick the VFCT image for a GPU by comparing the PCI bus
number recorded by the BIOS at POST with the device's bus number. When
the kernel renumbers buses (e.g. pci=realloc), the runtime number no
longer matches the one in VFCT.

commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft
filter") and its radeon counterpart worked around this by accepting an
entry whenever everything but the bus number matched. That picks the
wrong image when a system has two identical GPUs.

Instead, have the PCI core remember the secondary bus number of each
bridge at FW/OS handoff, and make amdgpu and radeon match the VFCT bus
number against it again, using the upstream bridge of the GPU. The
value is captured in pci_read_bridge_windows(), which only runs when the
bridge is first enumerated, so renumbering and later rescans don't
overwrite it.

Patch 1 adds the cached firmware secondary bus number to struct pci_dev.
Patches 2 and 3 convert amdgpu and radeon to use it and drop the soft
filter.

Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexander.deucher@amd.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes in v8:
- PCI: Drop fw_sec_bus_sampled; pci_read_bridge_windows() only runs once
  per bridge, so it was dead code (Lijo, Sashiko).
- PCI: Drop fw_sec_bus_valid and the 0/0xff filtering; record the
  secondary bus number exactly as firmware left it at handoff, since
  0xff is a valid bus and that is the only number firmware knows
  about (Bjorn, Sashiko).
- amdgpu/radeon: Use pci_upstream_bridge() instead of bus->self (Bjorn).
- amdgpu/radeon: Use the cached bridge bus number unconditionally, only
  falling back to the current bus number for devices on a root bus
  (Bjorn).
- amdgpu/radeon: Return bool from *_acpi_vfct_match() instead of
  0/-ENODEV (Bjorn).
- radeon: Drop an unintended re-indent of the match function prototype.
- Link to v7: https://patch.msgid.link/20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com

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

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 42 ++++++++++++--------------------
 drivers/gpu/drm/radeon/radeon_bios.c     | 42 ++++++++++++--------------------
 drivers/pci/probe.c                      |  1 +
 include/linux/pci.h                      |  2 ++
 4 files changed, 33 insertions(+), 54 deletions(-)
---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-vfct-regression-v8-d767fad2d1f2

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

