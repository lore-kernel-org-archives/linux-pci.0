Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794351022;
	b=JZsSRaPy6Efi4dRAD1aIiyP165BhqqCVRilU0kJu0c5JTWAPcWRCGFMM9r1vMuoq4u92
	 MLTo1KoxiniHqD4M9AEXb/11YrrFhUWCTDx2EVaT7UAVOOnTfHaxaOgKjemJ6cC2EUouP
	 +Dfo2WP8MkOyE7dXqVzURwJ3QjD/fMiUkre+4d49Vp9nkOCXAHPurMC/a8rJYkZoqniGH
	 5zSgmB+4D+yJIG1ZNILy1q0hkppTs51U5ZpV6Mn78IGEFFRRJXUbYPnHaUBAGkBv1yPiq
	 IT+34SRNStrNcKY8kLjUchrVkk87YXxZpo58qiH/DJepAT8B6dW35OcCATC6DSR218w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351022;
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
	bh=RmmTW4DX4MJjjdBN4roQ9AvmjDIecJUmvRTHhWR1Sm8=;
	b=Nux2faWkUqxg1pEteNf2x9uUh0RBgZ6AHGZxU5oJ6p6M7AMeytv7rbEafV13/tXFblCP
	 1o6lQh2lJ7UWviG44pp6ZJ33AHqzioFK5H0JfsL6dNjbpt1clmVfEWTqBvnLKKbac45CD
	 WJSXD8ALPpFBKq1zo0wWmnQRHoNdnDJBBAWWwD/6FRb/CRgMoYUNzTtIPs9f+mMcXZRgO
	 mcRFtZsfbHWFS0tXnoLigSm1IVdpvivIeu6eQNQHdCt3uvG7JRd/iveu0SEaFm5VBlXfv
	 o8h9YG7Y7dCRtTZhrRAgIBIPqRCZFvRvmfL238DEkVdyPdi3QSL0TITh3NSUcu/Q+bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RckBByqh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.64
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA67606A326;
	Tue, 10 Nov 2026 22:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA67606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RckBByqh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcyQJXSvADv3PncUZK2zHvkbly3NYwHSxBnK51Hnc37IA/uHm6TCxwbmEkh7mWaZ5RGFajepVH8761lBQbgAt8ZeOgabjFU05QP/GXY34fjhwI23nRgEjVELnheTItTT69nfDS3cBb4QupmHnwh1/yMZPD6wMIkCwcI7tQryUKZBPafRyD29euXEv7FBWigA4mwn3J25PsGEeNBNucBk/zbkJAVPi2EEZNr3IW3ojo3+95SxuneODPP3YXe4mKru4OUt+VpCi7lAZ7miadiiU6yJ4wzB28csiU8sCz1FKavBOZDKuP4WAjRynnJRbF4uLzosBnOmqhKl/DCCdULGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmmTW4DX4MJjjdBN4roQ9AvmjDIecJUmvRTHhWR1Sm8=;
 b=fqeibzNXRNQu6srlXsqVEf20Wbagum5Fkc45KHVear4AMk9FDGJADHZQcJ4XqhlAbkqU31pRFfhvkYLwMFAHxm49urPOkvkKmJnUvg4AFjVBuuSdFmZgkyrbWv3GlO2M1SEsKtI/gQQ4DGQuRVPSC9n7ZgsAlbYMa2MUibMcfDvlmryifdmMSoZt7jPt45WZ2ZjwlMf3E7sZJvfBVnCaFeFlxh0P+W8ZXf2GatkRGK2I7/wGxk3lDOugnJLew9zzFouLEa7wPB/K/f6jXl10YK8O9GZarGFXNpxXyaH/ZU3iVviZJeOaQt5eTJt5AOwdKNqhc8Kzmu06ZHTT4DgzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmmTW4DX4MJjjdBN4roQ9AvmjDIecJUmvRTHhWR1Sm8=;
 b=RckBByqhkSvB3oGCjBU7SdXEt3CTf1thsY1/1rxVUmHd9xC/HvuQ5rblCk8lKHXb2V5fcXvbiis3JBkpXGy5Iz/rdvuu63hEFVnafcm6jv5jp2mKuVLpDZJWF1F6uQDGIG9ccjpx0tsZPI3nZFTvaMzM8zgCjQmos6Rr97mVuDc=
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 22:50:15 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::a1) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 22:50:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 22:50:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 16:50:08 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 0/3] Fix amdgpu detection of pci=realloc
Date: Tue, 10 Nov 2026 16:48:20 -0600
Message-ID: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
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
X-B4-Tracking: v=1; b=H4sIADSf82oC/3XNzW7CMBAE4FdBPtfIXv8k7on3qDi43g24EqSyg
 1WE8u614UBQxHGk+WZuLFOKlNnn5sYSlZjjeK7BfGxYOPrzgXjEmhkIsFJIx8sQJp7okCi3Lge
 pYQgGegOeVfWbaIh/98Wv/SPny/cPhanNtMYx5mlM1/tlka33fr1ILrjxViGi6nrEnT/hNown1
 rYLLDSItYaqEZTTKKU2wr9qtdR2rVXVAznTW0Lruv5V66Xu1lpXLaiTTpByAcJTz/P8D/xZtL9
 4AQAA
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 71604548-6448-4bf5-c550-08df3f7cfc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|6133799003|13003099007|56012099006|261022115727099003|11063799006|261026140227099003|261028144727099003|261022105027099003|261102123227099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	qZ7kYD2BE0z3vCP6L1j88s9j6y/ZWwFy8fIXfb9dvCcaxQd4uRcJTh9MkKZkbxtPOrbj+9Pwmt9cp8SamX7cxEPtqIe2REUmzQ7RLyzlxSvHW9UIYrynBKT96CENMndjuuzxYOV+XJQhzEr3E0X0mUZYESPcNLb5SA81ZQZE4S3Oj3JpCIQQ9xuPQ22I85BgVup9n/gEKozIPqacZQKGNuDyPEyt+fNinxjRkdmVZdogDzMAikg/Bf18BhNQHpiwKdT9IUS5Y+pGckHmrz/oR2HtyKYJqno12mhKYXmgilfecSSzI+MlQkRkUnaxdQ9+7WXRtw5n5Thg7ofgmgNI2CElQULZhOVOP/Rvf0nxHSQ/2Jh6gS3KYMf1Zm/mfnzAdwMLmJqzA4FQb8qNUbtosa3QeZ9/A54GpYb91d5kEWe4voOydF1FQRYE8CrLjQKEeCk99zmcrLgHn84qDnmApR+sfSJfsBqwFn7O+K6ZMUrztkaLizf1awwBx6LGlfLijUgRkqiqKHvDk2U0sxCT74YbTmPMgkcRscvTeXWxsl99yxT4E29NgdP3+bgtQki+0WtoREmPHrukv1EcjXlDhfPMwhJohzEd/4MYXDG6Pk/LiZrwD8v7te8/6bPGiGLfmW/wxlknDUFuvyNa7tJTFvtQ6RSx+p3br0b93GiGf2E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(13003099007)(56012099006)(261022115727099003)(11063799006)(261026140227099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y8avOZ9drYXZaDxW0DyMPe144VL2xU9ThxGLJMlF/3at1c6RFQNMwXPdVMZd9kKDnQxjHY+ytB9bb84N7Q6JAu9s5FvdIkWqv+qHHKFLHhOJG/tJ7BZXGzVXDsapYLm4+9Ir3+/z5UAxVS0vMskV2ItQJTZ9Sn6ajy5/sXtNzROvJIY2Nej6zxdo0gQfTM6Lb07LwrYvtmcwIHbEwtMGd3JRoKr5i06HzmsSvQtlIRGJ1Q4zwCEOBXGK4BzYgvkvBUFaRP0doxJnlNCttoJE9HAIvGsEeEvjDDl0m9qHCgimz8Qb4LzKjgrkxLX68SZre5pw5iZdA39XyiLtDq80lhkmgRysQbydL1Vb1aU5oKvQMLebzYf3JSq/x5KQy+p2iTF29cn0kvuQ6ca4p6zn5GBWj6mRNp/t7rHWXkNRh+0yTxYu7/QJTT/okVbv36A4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 22:50:14.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71604548-6448-4bf5-c550-08df3f7cfc32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

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
 drivers/pci/probe.c                      |  4 ++++
 include/linux/pci.h                      |  3 +++
 4 files changed, 28 insertions(+), 27 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-vfct-regression-2142fc52852a

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

