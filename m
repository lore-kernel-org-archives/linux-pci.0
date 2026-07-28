Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2641BA98;
	Tue, 28 Jul 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230257; cv=fail; b=XuPFH7WQTnU6Mj/5hqsKSln5uLyZ+2ujJCqm0RwP3R2gHWNkr3b3lEYSVxIgA1wT1APUyoiBa0GvbRvwoEf3huL8E4601pqGwQQwn284et7bYn1YuooR1uSXtZVKwHn77Xdn8l8Zg52J+Gk7WLIo2kyNH++9JkMDfI98ydizVug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230257; c=relaxed/simple;
	bh=WXYwx7TAW0D9KcAyqdwFlfteuAJ0Ezcqf1CpPY0Y+tY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhlZp3JPRWWLiN978RtO4BmxMayiYgCnqZl4kCfBym2yd2NsLDHaMq+I3qF5VYe6vnATKpd9JMWncVIywfLlGfh89CEax/PShyYItkULo9NqqRA6ULm5SA4oSmhqO4aePtPIKdLR0Ma0yrDXzxxngBsBDKvc5DfJrdZxcP3tvag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UGjJpoKV; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UGjJpoKV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6LK2oNH32nPRAGL1s93tIbqqGGyuDIxC0cHobwSuAFhEL47ClqTvNO7noXszSJz1J+lLGLZEq4Gc2zH3ORYQINF6m3HMa4i5gKQLhodi/5+yhuoVkMfzrC227ngduvVk3iY0dqcY2v+JGf7p+8acosLjmguHKL1wPuXAX7FxxXx5uPBoq5NquEaMoUjGCcX2GHTGFzenYgA6EjYyMoAykSzMoPGZ0KCfziGeiCScdlkOXrLCAepcGBI1QbSUGmQOh8Co7anN/NQZDe/fwbsXqs4MeSSNrjJvu5rm8l5UnsOwG6maXp8USed2hWXtnAcm3bEmfcsd4y7J0AqbZP4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH4rJepcp3qMXhqdxfpkIJfKdz3cNLfkzg4EbWHdZA8=;
 b=LKpH3n8X7MjQjzDDJ4GRA/91VQ01mp3kbC9fa9xxtKGWHYYvNIXnHKcBZ1P8e6wwHh6GXwRvTI1zGWtffIeNShRAZz4j8NPemdf/CO2qO+4oMSxGVwzuRP6Gw6egElyVTfLrHjAUoqu7rtdBfAmPiHd9UNp6QawX/77RT2O7NSSszRqs3HMyfONJ9fqMLYyUFvUhuRl1rJpbV4OkDEJ1ZPTrYo8fuae4T/1z7xbJpjWD4Q/pzbPghBReP/bg2ch2QWMTe/2jtuJU/Y7Y1xKbOU36+xQaNuhENrmrfVA4zCnq4BBinNqUHVB6alkkyBuEQcK/nmfISfRAqdOiMkWdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH4rJepcp3qMXhqdxfpkIJfKdz3cNLfkzg4EbWHdZA8=;
 b=UGjJpoKVzaKP5H03ybOr2bAFK2+4azifQjNTp5DVm8wEXQv4+upfSgzYcUJ3JDh7qMyXeoi2dsN5eddrsmat4xq6cgP1os4mNSLvwdKuGrtS7vJoXEYEa29+W0UCldmJqpOw1okBv5YHIXTlX01OXNzkEDW8Y4qUf83ABRDvQ8Y=
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by IA5PR12MB999299.namprd12.prod.outlook.com (2603:10b6:208:60b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 09:17:31 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::8f) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 09:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Tue, 28 Jul 2026 09:17:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 04:17:30 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 28 Jul 2026 04:17:28 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <den@valinux.co.jp>, <dmaengine@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2 0/3] CPM6 Channel Separation Support
Date: Tue, 28 Jul 2026 14:47:24 +0530
Message-ID: <20260728091727.1086784-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|IA5PR12MB999299:EE_
X-MS-Office365-Filtering-Correlation-Id: a1456d0e-8066-453e-54cd-08deec890d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|10067099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	0GZTQ9y2BuQndVFzwUpp0lmyGQuHzPeNOd8o/81neLikJQ4k2EHmPgnLETJwgsyNOeUiAJdMj3/37Qy/7VlGtLAJSV/OR8P4IuL4fsMYar3n2UCdlp6mcBJviMzxbFIsOoq74LgfxW6XcIlGXV3i9S0Btl/m+vItfSIeU1pBpwAFm0ijiRLoP0v7mvjTdabRCkP9PpKrTvd1WkvpmCP60tJJbIcxYhO0jYk4Gzvj24hFLJoMS99buFNaHQWPOaA/r9sK7ikXaltkEqsQMTjaQB3WBBjcXiCpFykg+nZjaNa1Mixo2D6Wa3xebVm0/qi6X+6MqmYFjP0AnvAaq/blwkgf3zFlrMI+3lgIruhaSo68TZLEicAJbxFHoS6QTqPcWO0jOFlzA+iYgPhYZGOYjBTu2pXmKDVx1E45yUSWKVnSSZPfgLFVLBXwsJND2+BRpkVbr6JhG4m4WO7L0UqzEDzfrb+WgvTAxQGOnqn8gKV29loEi+W4DZSEfPzrOg582fOuvzhl/s4IMQAcmX6FZ9PYTwA9JqXJYyDzu8xvYLPvFRmeBpVbilX6Zu6WL30q+MY3YZENlU1lLK85bwXZqb8vFQ8Dg3Zk/Iv2CqrETgNE5U1foVITGxHbJjW8Bsjdw+jLY70wx+yRhC/Ohd427urAhSP2UjRJVIUHP+lFhaCtPAlIdB+KzmmxY8D+d/kS2eg+Vib3GFNC+qbVkyfXtg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8uDk36Tdo4KTHQEoHz+xMR3P8E3cXzSBZjz38yiSjItvY2835J13O/YVemKviKNP54mTgGm/Dstp5nZHSi90g/RbRlkXCXW7UMepln1EiK/HMqaPrxgC77PFahYLq53041rjoggREi+mA9zooMQ6cDINNj65qCachpW4Tq51FT9BzcCloYDblqtK2d3DtkJ5VtumGa9eeY3GwimINdEZBvpGA9H3Rb0b4hJK3YmEEBMEwkJxnmgxqjB5xmCZn2f10leNErWWvv/cWlVd++RFWb2D+4kC+5ABrW4AMwcAP82danLs3+Y5d7GVoCcChP9cf5Ay5hWbdwZqPCjMhFwlRVQOZQE6iM1qjI7X/XWMPRg12H95ryo2ur4ALcjtxg6QLhTpIVDqdN2u1n3idU2Ie0Z9Uv4ISO2ZD95XVnqiYv1zwaeR7rIV1Cny0lIyneae
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:17:30.8969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1456d0e-8066-453e-54cd-08deec890d34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999299

'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.
In order to use the VSEC functionality following changes have
been made:

o For Xilinx IP alone, the macros declared are made device
  name agnostic to expand the usage of macros for similar
  functionality.
o Utilize the existing VSEC implementation to retrieve
  the channel separation and translate it to correct size.
o Modify the structs and functions to calculate correct
  DMA channel register base using the channel, direction
  and channel separation selected.

Devendra K Verma (3):
  dmaengine: dw-edma: Make Xilinx Macros Dev Name Agnostic
  dmaengine: dw-edma: Enable Chan Separation via VSEC
  dmaengine: dw-edma: Add changes to support Channel Separation

 drivers/dma/dw-edma/dw-edma-pcie.c           | 81 ++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 23 +++---
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 17 ++--
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 10 ---
 drivers/pci/controller/dwc/pcie-designware.c |  1 +
 include/linux/dma/edma.h                     |  1 +
 6 files changed, 72 insertions(+), 61 deletions(-)

-- 
2.43.0

