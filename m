Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792460689;
	b=ZkMohvK6AVZwH23LxgramLQxhOSHTzyf2eDlAcpaDoOJKmMHuxCpUJt+F4xpfzyuYrRN
	 Y344wMuaff0K/hC67LvXEQmYjsPPvcavFtjQZz8F4U2K7fBWttJRIfvvn/hZCRvT2jbNX
	 bZsZ7DM4gOLOgVMl++NkD6cHjlSsUxutGqfBcSOcnZv3AK6sTre/BkgIO7+Z8Mn53MO/G
	 hBAWyfytArgfUFSC8XycDb3HQxuJizrDcLChpIqFUUgD0u6ko5ynxBRVS4WDSGRdwns9s
	 bhBnuKDACBDVKXVoK/qHIq5OyVpS1Qhkf0QO4RdNGFyX//zmDpCctTf4iKcCvFLjjxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460689;
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
	bh=TiCEArIps0iqu06eKkijx5FOCAoVJaGKsUj5QufN/fo=;
	b=z/WU3oIzGYbisysBExIh+1/9tqVGmAX7Awhq7aLjFb9IlskCyEnudLia9hSo0PwKWCrL
	 7Fje2yfhJNkKJbOSEsYYPjsB9uitFKzqugqb58V62MXGlddX4qSpUs/eY2ctOAw23669P
	 FjI1xBnl6C28imNqwIN235T+O8a0HQMSC8kf/3FldK2COLMxRbW7joPKJeGL3/e0KqCwZ
	 mDRbpUQ5xrtxTYsasbahqiM3rQqlxCiFQwUSk95cVWoz+KEt5U9fj67Ia/dzl2jl66E3T
	 XdP/OEDHeGyPy4ukAVXPc7d55ogEmbWQTCOwwyT1wXA3Fu8oOsejQ36Wz9U9XQKGRBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a4t66kQu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.70
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC55606A31E;
	Tue, 20 Oct 2026 01:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC55606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a4t66kQu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbARnQgN7IHZSSwHvzXhb+LJ2+xSlRR3FwRQsZvcbQ29S2zPnlAS4d2NOZ0xWTP1rdUn4VsFa7mt2svKVxop1lYY45jQu8N8545x2lor330PlN6/g3f3n8V7ZT3bOFZMPlBNvBpiFYmE9JjhlXth44TA9PONRUlsvxrp6ZwcU5dJzN4WF7Dzbrf5MU3eESmAq3lJoEpr0EMZnAkn9ogd+XaL06JANh6g7fl2YqPT3bpWmJJG+QaRp2hIZOquMzYRViVCb2cNS/23kHLV2VfMIEJMmHaToOpHIcEdbe37tGkkTuJA5cAd4guPaS6NQ1SeJ3gygDFOdS0egm8JiBC1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiCEArIps0iqu06eKkijx5FOCAoVJaGKsUj5QufN/fo=;
 b=om6uoAx0bSKW8b0J/8Yy9xx/MDypUdpIKickJqcq6mHJDD8bpBHm7zKaa6PwfaJ8NtRiELimWXTCOyFro3PCR2LCPt/hNUml0SH5qLnB5wIPI3vrPciKyIZaO7Cw1VXaDV55q7PH0ocqGQs4I/iZKDF7+dLJpSOEwK+yGYjesxFOVhxxw7nHJNwW4dY8+dYszJ8YNS0J3y7CoiTgNT1V+1kHL5ZP89yPZwNCWkNNACPFe4Zg+3pjX0D7Tc9F8Qw0m+jMRFmm9PAG0HHw2r9R5JUjRBBtuyqCOqK5wV1vUE9Vmon+SFMViVWNNorL8ZlndB7ju6o/dKJR94mFm7rtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiCEArIps0iqu06eKkijx5FOCAoVJaGKsUj5QufN/fo=;
 b=a4t66kQuk9ut0earCTYzq3+Bpk+YM3NsiAt3UaoYNUFv6o4D8naCE5vGFGNlGkfV+l4OgPqDE/h7ESMvaUQn4hW7781h5DEFYTarqC9sjrDId3nR9kh+VKpofkhTLoEQZaX0bMuOAdFeIZDp2HBYFdvcdWYItL/AaSgMwP8IYuQ=
Received: from DS1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::15) by
 DS4PR12MB999077.namprd12.prod.outlook.com (2603:10b6:8:2f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 01:44:44 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:242:cafe::6a) by DS1P221CA0028.outlook.office365.com
 (2603:10b6:8:242::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 01:44:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 01:44:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 20:44:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Fix amdgpu detection of pci=realloc
Date: Mon, 19 Oct 2026 20:44:30 -0500
Message-ID: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAH7H1moC/yXMQQ5AQAyF4atI1yYxDYKriAWjQy2QFpGIuxssv
 +S9/wIlYVKooguEDlZe5gAbR+DGdh7IcB8MmGBuE1uaw7vNCA1C+m4N2hS9y7DIsIXwWoU8n1+
 xbn7r3k3ktjcD9/0Ar0p483MAAAA=
X-Change-ID: 20261019-vfct-regression-2142fc52852a
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|DS4PR12MB999077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac6400b-6d49-418f-d646-08df2e4bb776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|10067099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	6N3QJUweF8dOfeDXttahDYjd3izXSFpG/YsKFLyGFiNC4ZokZPg1Hn7eJMZls+dHqLQn+xrSWXe1AoYBwIgVSkN1l80M3KMRXUaAnrfEKHuuEWuUvcgmBoBHhzHV+k2hYYvdjmIJNgtwClFv1qJDy7W1o6+RSxpno7lPPcqzsjfQzNLJKqHlOyelBOr3ntFRzGZZ2mD7lLBhSF6SvLiHeMpWhvFNTXksu6DBk2BX+NP/qbiuMEf4jVrjZjYmJUJBGrwysJtBnebsIv+OHFdGne6nHbRx/VPeb5h9hdd5cZPGVXQJT+/IdIxLFBp7zcuWYGT3Y48V9CFs0ZUkS025apQa0A11khhbap4AElylaUFu8c0AJ7w2UMtAy9B/vNFDY/Y2D1f7ot+FmSPDi3RzZskzLQqMVVzWQQj4YwZTYalATZvdAKBpT1soHC82G18bQPV6vWTCIiAH7DCTF77cSVwY0s6laXqoxcha/OYo3P6VE+V0tOl0H5DU/1qdNrwZc6Wiki283rpHJtm4oB/tbTUK+LsIwer6RtmRbJcF6JUlXMvimj3sVFDQfWROgae58TuSx1JHlU2aqaClvwPGEzVo/rCnrq5uNtGfVaZ6zdix1cBVQDAsvsPmO3+K9Y6T3t+65ob2mjtDNzBB0N4CPQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(261009223027099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bl7goFAZZtS2IUMTuOwxUHChTohxFdHs5Eq6UxTsCr2kiKJJYB/WWbzaHoLU3mXUhATEu5YvvFGd39HoDRKZlJrmunN1CvW2AfweLd+s97YNlGc20NewMXgXVm7WU7sy5SB9h6jRuIz8fC9aSlOK5AFGHDvsxJlt5N62elnn2EmqAkSMGk1OACPidJwlejHzC4sdmOi+yB2XGlkpTRo7sJ28fv1r8LRaxXcndk/PkzTd/XXmZAsQBstWTzt8ORuveOsre5hypEkVfVquBjjmDBEX9IpZ741nZASjUK0JSLOgxjvyKo6Jo+in8mIVRtQgAaGxHpWM6n0BkWLAQN+qf7W67doJguRXNOiQUcTzVY+C1zZ9nSBwUf8mkUevpk7GyQOVXaHKpaRajRdWVE6YkHqU0q2fBhT/KM54+49MR4yz6d/aLKHaOuIRBK0x9/m2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 01:44:44.4563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac6400b-6d49-418f-d646-08df2e4bb776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999077

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
Mario Limonciello (2):
      PCI: Preserve the initial bus number in pci_dev
      drm/amdgpu: Match VFCT using initial PCI bus number

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
 drivers/pci/probe.c                      |  1 +
 include/linux/pci.h                      |  1 +
 3 files changed, 5 insertions(+), 14 deletions(-)
---
base-commit: 87bba57a9f33e2b5e90d4ad70973675333182a2c
change-id: 20261019-vfct-regression-2142fc52852a

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

