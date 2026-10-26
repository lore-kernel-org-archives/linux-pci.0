Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029746;
	b=dD1oHk+pwUhcxP/Y1D60/snhkBhJGc9T4QfjLbCjbtgDGXWi40kxUJaeB0HK12PyfTUH
	 hT9Hsz48KpG2pj0tLL6u/7zv8Bea1dfaaRZqgqFc8nKMNDLqqz3yWT2hNm3nrZ17Qysi6
	 X1AgqAPwJILwP06CLEKyixXTDLoFs5TGihSElfxvhhfDG+qzxOcMaptnsUX9nhCRHxYDJ
	 VR+a96U3aOp/U9uno/xhk94BXRtw/ZeudE/unU/8tlTcIeBsoTqnJeTg3+eXhdNX0rSia
	 HlQkKsSsfLQ0J0uMMLg9nG84DViD3CqVs6Rjw37ja/dHGUT/83IsYbNxhtXd0RaPUoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029746;
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
	bh=EDM6TF+lMWG+Qm7AL/C5T7RcFsr3mhwsX2cqlSFsW9U=;
	b=ge76+WZPqyDiMd21iWicW3R8jdl6X5tvkkZser7Wm8hg4ZHWPX1Y5G6MCB9Z1O/G9eoH
	 1udM8t1BEVKYFL6Y451VoN8ruCPD+CHFvJFUkFxYyxRYp1bLK9IzHXFHI4bQApCkSD8AY
	 OdXrcp7jqwegZtZFdNhHNMaWop7/NHErtJeiLsv/6GPrTUun/RWy/wiMJFQTi6Q1xR7UJ
	 WeXGx23l6hKwYvcF4Vzjf+tAIRoXm228TPiMfrt9loc+zB1UYuUa4C6LQPF/j23yOZerB
	 4+TLzgXOHio4gc3EJCFSpGXVMhvHnwTy4mt1Utr9YmgAM4eP8mPVa3OsHxnS1uwTXgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0RgTJAiu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.59
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A14606A321;
	Mon, 26 Oct 2026 15:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04A14606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0RgTJAiu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xsr2e5V2edmhc9GAi/G09wC1qDrBwMryxB5Oio+HG0zLXj9qB5RpqeroDYU544eFYS1hfDIzflqEl9s8/mPNdBOhgpRpdbWH7UoiGN/KMq8T0u61Tyh6aIBcRoS0ZhzRTEo5BpxMDUfBd7YKs7B/5SqA2HyQoGyaIm07ptY9t2ebE/qOnQSH3PxtLMGqj0+ra1VnfNJgCCcoq6r5I2WLU8mATzlbLWHJXMrzmlWXc9ACYqTh6VxRpSDWF2CVokwyvEL8TCRB48y1vm9U/476jyrq2O36ZWwMZRnc8Vns/qJwaZPOEqmMZRfNc9NYq1bTKVFO5d44fiCyB0PY7kaXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDM6TF+lMWG+Qm7AL/C5T7RcFsr3mhwsX2cqlSFsW9U=;
 b=mCwJa10Sc6bQQdeswGFXwMFPTd9CTdCqS+IcqTR6ip65THmxQu0n+EemHWdGO5Z0V/CSgiEjV38ss+xuXg8azeSManyPrj6nAxyy6RL5fyeBljWtjEBV7gwlMnbWqopKcxgIf9mEySKUvx+TkYTupzZKDsxp/tsVi3vc5Dn/C0voYz/fS93cODs3sjj8S3FqvncoBE51+U2HKEkD81QoeUwqRUkPoqeQhFncKf2JrLVWukjinxk93k+iA61MK1Kk6lOCfZwkMkmb/JAvVK3BQlULZsv8IjV2Mc9fJ/fRFRH4lDG9oDjg2sP+fZgStXiDBYMsX3nIB3lRsutKq3gaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDM6TF+lMWG+Qm7AL/C5T7RcFsr3mhwsX2cqlSFsW9U=;
 b=0RgTJAiuHmW4MxGEFoFsQwVk9lG5ziX7q9ieHMkTUxYX27Q54yv+Il9WKx5nJIHFqpLkn7qfgqOPC2xsJTLqQsujfKWbFC75GUhaCErdm8LtDHNQ538Ed3T1XGydDTvchIqlBaky3tZjz2LT7pRTOJRi2RhgECRd50jBXktdqPY=
Received: from SJ2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:a03:505::11)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:49:01 +0000
Received: from SJ1PEPF000037A0.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::77) by SJ2PR07CA0001.outlook.office365.com
 (2603:10b6:a03:505::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 15:49:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A0.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 15:49:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 10:48:59 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/3] Fix amdgpu detection of pci=realloc
Date: Mon, 26 Oct 2026 10:48:31 -0500
Message-ID: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAE9232oC/3WNwQ6CMBAFf8X0bE27pQie/A/joXYXqAlgWmw0h
 H+3xYMmxuMkb+bNLJB3FNhhMzNP0QU3DgnUdsNsZ4aWuMPEDASUUsiax8ZO3FPrKeQtB1lAYzV
 UGgxL1s1T4x5r8XR+c7hfrmSnnMmLzoVp9M/1Msq8+1+PkguuTakQUe0rxKPpcWfHnuV2hC8bx
 K8NyUZQdYFSFlqYj70sywtgNg5h/AAAAA==
X-Change-ID: 20261019-vfct-regression-2142fc52852a
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A0:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: c51cc683-c0a3-4707-9a12-08df3378a7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|261026140227099003|13003099007|56012099006|11063799006|261022105027099003|261021121427099003|261021123027099003|10067099003|261009223027099003|261022075727099003|261022115727099003;
X-Microsoft-Antispam-Message-Info:
	gyYVUVVBfWI25yDUcCEUFo3QFcbJ34lwLbATByzf+M9xgpEcVjHfsRVpMwTYCpko/5qEpJ2xIc3C+8dXerkUztDm3IVn4nZykt7P5XTuEPXch3BtQC/kXBVeXrWOw2jHsqZRu7Z2HD8huSSDYlBI3lVFgg5+MGSxudzop2DXGflLt3/wu0zhe7NTtlgfuyN//0ftd2XrdNh+7uMHSI6syFUaRgkhBZktNVO4abrIQPgCT3S82245nsq+RYHlgXOrouy9HQYQEF1Zl02JYw/6d/DJ8kr47I2M3PnW59wXqYCi9cNiMpPkjbJ9dS8VKCiHu7v0Dmz9g1USGFmQeluBkUNNMuwyIvJboBBeHWHRZ7Mi/qN+xejvU1M8s4JC29SDCu+h/9sq5YVXeDLTHSDovnw0YnYNRL0DGxEKMpN+ZkZ4CtxS2oE7H7c+7KTtV4679I3FuDiTUU/XqCj5wCgwYM/m8popty61obklfoGtWsJQFNtrV909eEuQv257JiD7VtNmUANMqBNB8k2BobMrxA8jbr5pdA1YF+PP56zkwHpTijwNVxT7VATHUx9rL8qwb76Cobdmb5VOcAnMfHg9yaw2jGw+8gQsx6kOdHw7tRdpfH1ZSGhfhlKoLRmjpCKXzf7aSGj0cT7LGUR36cn07w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(261026140227099003)(13003099007)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(261022075727099003)(261022115727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+cFTDiI6qdM7qxQ2YxoHw5OEaKjVXuO5XjS92qEwFCnXtgw7aNGljlfshXGvf4mTDLzeqqtXACY1mql2F7cCtTqn7EVgAjMMzSJYHsvYQ58vEyr+EWTsCpKH5UmUeht1C8iqECGJ+TbmQh5769exeUNuCe9jo63GD0uTizBvwPN1Pwlh7IWFcOqzZ2EiWyklbtygHLGSBnN4ya2Q9qUzOi+adijB1xOEF5rri5jWuv0Q+7fGg39Z3jCAFWsWtf69aGBgZRzraFAuX6HNZIBPLqIzzJieAdNNwr+BcUIBWc60qdLgRMGsvCzivU92On9njgsjzkPmth3lBjJ+csPKiRGwVj0xq5Bwy5w1xpUZUEV1FK+19HYxD0kGR7Y55aTC/BNwUZZUlFHHetrmGa8rFrh+M9RO2MX34TN80q8p9XeQSYZIMhIZnS5ZCUzmuez1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:49:01.0412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51cc683-c0a3-4707-9a12-08df3378a7a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473

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
 drivers/pci/probe.c                      |  9 +++++++++
 include/linux/pci.h                      |  2 ++
 4 files changed, 17 insertions(+), 28 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-vfct-regression-2142fc52852a

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

