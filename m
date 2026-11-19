Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120077;
	b=JNmCZ7L4GVKdkS9jeCcBe7pEAuc9tnhP0UfnlOdbs0NbmoTXZQagkDjd+troPtYXjWc8
	 tdin6nGb638aYtJzGmuEZUEXWmoQLx6fb6HbBBVHkFeXj8XZF2Ry9J+1FSpxpDimauvlq
	 UB9OFEEN/Zz2e66tnd6b+i5vrwAjvGegS7tYRX0EnzA6uMZ5UIRz+rXK0NbTYCHUZuXmy
	 1p8ZePfq1QXVAfRivJWZmol658uJuC8Fi2Iqqt2ws2K088mEXNpNO9jIO1ets3eDepwe/
	 CQ1o58LVobsk6i884TXv0TMvhWAujGupzopiO4KFQ/JfsDI+8Flv8yd32pQqphH5oFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120077;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Uj/e1dXTsfXI7Cc5N7RE25EkyXDBshKyX5HeXVjxPrE=;
	b=hrONxzb1QYcGYRHcDhDFLLYXzoFmKC8SjUsw3ajqIosQE5QsflESSwq4AfYovrdHExcJ
	 8gwia+zSFPa1gkTqHp8lqmtqwVEdZw6yWOV/wcOTCF5YHmjFZP4ek+NYhAbUSwKTy7Dxh
	 CF0VGfPmuaU2n30N0351UtU9tLW6qYg9KYTnqUr4vGHZKxhotSxKRcdNUY9bsCmuk8Sv4
	 CqapMc5ts+JmbkLwxj5ainAZc+LNZLXioyrmwVb2XvgvKAeGO+lwHpxK0/asvD7bgiMRo
	 scHqRYXB2F9OmSWmJfD4yIgxrDxZas/K3RSGnZP1E70HvzDSnUyhvE1C9Pp933ARRRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eitdTMOJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.64
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E460A260F;
	Thu, 19 Nov 2026 20:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E1E460A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eitdTMOJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbouj3VVdW7NsxT8eI1KmjemOhsa6DSpi9q4vtY259+kI59deJ+cwJb8Tf4wmvHsGNbPpb44n2RHyh9EOBCTv7qCMWhQa0oE/v+4iM09TyVERIogQUXgYObioXGT5ZYdFINNWwD1bacOYf6N0D+qgPM/fAp4qSozUX9c7SBYlABG4ffcG19S31ukP2MDex7cxLdV6ak2FWvTIdqVRFzOlMYRB9RcUukLNXyYeuf4BOpgcZTBl0qq4gCA2QJGrZHn434uUsY5oPKd7cfAU8utNT107N+1aMzn/4g13BL3KJz8SGxvlLPcadFs9QxfKNowEam3aiQcSKwgS8wPwEg5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj/e1dXTsfXI7Cc5N7RE25EkyXDBshKyX5HeXVjxPrE=;
 b=HMw1iz3vPO2sv2PT82Bf1WVdZnIWXCrYAp//d339EaE28WZI1HnBOKlHGFt2kCu6VVgbdz5cRovgn3bFDYPgUjFODNmOS4y200uQp5q8T91KUDU3ylR0FmrLoToP8P8cfvkpkxICk4vn8wjhifOVW3ZX6NZtgSk2SmzJMvz36COYG0ikSVUmWbGNt8GQJDgD3iz8c8hyG+In6XE6z5WPGMJpWr2Am0ydLLORhEvg8/sbvyz6H7xkcq3j325msK8LpNMs4Aw7eBHSoHdb8jC+FOcQcDygG81uY+WMBaa9idNEcelYUuhTAPifnIYST4Z/tWyQABGDOWZmi6fP4CSAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj/e1dXTsfXI7Cc5N7RE25EkyXDBshKyX5HeXVjxPrE=;
 b=eitdTMOJn/zE5IN7LYTcwK9XvcOnvkqjPuNTvrQvUzuBX7sTOMj69lB3t0ehxCe600xDHHNam9C/k1JQSMO4Vr2Cf8tTGr/ioTbqTkVwhpAVLE0e4Pjw1FDBOzdQxuLEh76e7lmMFSvjCoy2/TuK0vf8QlZN1OmnpvksE/3gqx8=
Received: from CH2PR07CA0055.namprd07.prod.outlook.com (2603:10b6:610:5b::29)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 20:25:38 +0000
Received: from DM3PEPF000265B8.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::25) by CH2PR07CA0055.outlook.office365.com
 (2603:10b6:610:5b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:25:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B8.mail.protection.outlook.com (10.167.23.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:25:37 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:25:36 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 11/44] dmaengine: sdxi: support userspace context lifetimes
Date: Thu, 19 Nov 2026 14:22:47 -0600
Message-ID: <20261119202321.1734355-12-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B8:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d35c86-18ff-4448-afba-08df467b45dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|6133799003|261009220027099003|7136999003|18002099003|11062099010|22082099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	suWdvtgQrNfVmj1sLrsXCZ/2TBplF8Kf2aQbdiyD4FSSRz2syX/SVYtAMV4qkFyb1/PiIK1nRqm+t0xXdVKVwJ4FkqdzhA9a1DPZq3gpJbzRwFDi+ftRvwVGgTcdgCd10D1d1bnT9x7fMaOOKoamK4OTNlnEGXQWTHkgupLrbwZogXY9L2pjbr29CKf2uio38b21XFjEhmPqO414tan102ocxLkSzusJ4ZC16+IukT8uau6hjDOw8Sl7oW6YZKoMxYfCFPwCYRKXrv1EUk6xWS3MyZYdtU4cEx4d6E50558/Ok88BtpOOwgTw4ICb1G7E4xiZ8NiNigH/2/W7iH7D30/LJBIvrdrOSpfI29Ye+zY5qX8VadYiH8By6qm5KiEZQ38h1pK4d5BorYX9uO/YUVGur6egW6CwhDkOSkB+uhMsjpRbo/0550oS69DA+w6cDtgBU78wH/lbghVu3sIDcqfYXTVIpjSKpvQVZxNDCxEJq77z6Q9PW4638nXtXor4fgXjOXjnlUAwhxRntPvkg17mGaJtxh0eyIVjqVGKENCERr/DVVVDynGL/eFA/lOO/ZomoGVadmNseysoZS4maff2bxOc9gSg0bb1ip1DW9B7U/Bphfa0o9vGbTQUkg2Pk2wPTRPzndRoqRogfszrgmgaGqe+7xC6Cu9+hKvfQ5WArhMzYOjcziAAuNTJDT9zIOfo0SbVUanunj82km4oQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(6133799003)(261009220027099003)(7136999003)(18002099003)(11062099010)(22082099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lu/TAGpY3fm6PJlak7drNp5NmagI2S5qMpyBicHuMTWaqXq1tzJhHaH5Yf3yxS9837jcqNcSwS8O84ZalDfzCPtz9OeALoViojrOgLLX0Nd2cVPWIbAVYmqmZTWpEet2ka9RjMVTMtaaD8/65kbb3A4ZNFQuGgKlRv1AM7VJDaSX8hSpkG9tnonyWB563GkgMNpuVmaaTCv2RGlwbYYQSBtc6SW3IiYMK7vh23kxRR/a/CbU8IlPhf+0fWL0HE4jMRmQmBSDI9q+6g0P09bbT4EjZ/1BScziGFkkkrEf7eGtjQxQGQS82uuRmlZhtKCMNSBqttu4oG0DLi96X/U8iGtAzwe9ceUyUxKhOntZEjyltCwLzTkuLusLyj+fAtJJqiKBqLbkPZ+MXt8nLdD6W4cQfsxEqoxGES3icXXVTf1lLlgwV2EwtJgKgaKp2tpj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:25:37.6178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d35c86-18ff-4448-afba-08df467b45dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904

Add per-open process state with ordered SVA and MMU-notifier teardown,
and extend contexts with refcounted fd/VMA lifetime, deferred quiesce,
fatal-state handling, and an internal PASID-backed userspace constructor.
These are used to support userspace context later. Note that we still
preserve the existing xarray registry and kernel SQ/CQ ownership.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/.kunitconfig |   1 +
 drivers/dma/sdxi/Kconfig      |   7 +-
 drivers/dma/sdxi/Makefile     |   1 +
 drivers/dma/sdxi/admin.c      |  17 +-
 drivers/dma/sdxi/context.c    | 731 +++++++++++++++++++++++++++++++---
 drivers/dma/sdxi/context.h    |  39 ++
 drivers/dma/sdxi/device.c     |  10 +
 drivers/dma/sdxi/process.c    | 186 +++++++++
 drivers/dma/sdxi/process.h    |  43 ++
 drivers/dma/sdxi/sdxi.h       |   2 +
 10 files changed, 971 insertions(+), 66 deletions(-)
 create mode 100644 drivers/dma/sdxi/process.c
 create mode 100644 drivers/dma/sdxi/process.h

diff --git a/drivers/dma/sdxi/.kunitconfig b/drivers/dma/sdxi/.kunitconfig
index 16a1ae04b156..f3c468fe26c6 100644
--- a/drivers/dma/sdxi/.kunitconfig
+++ b/drivers/dma/sdxi/.kunitconfig
@@ -1,4 +1,5 @@
 CONFIG_KUNIT=y
 CONFIG_DMADEVICES=y
+CONFIG_IOMMU_SUPPORT=y
 CONFIG_SDXI_CORE=y
 CONFIG_SDXI_KUNIT_TEST=y
diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index e01b5365c154..9b8416304ee2 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -2,9 +2,12 @@ config SDXI_CORE
 	tristate "SDXI (Smart Data Accelerator Interface) support"
 	# Doorbell updates require naturally-aligned 64-bit writes, per
 	# SDXI 1.0 9 MMIO Control Registers.
-	depends on 64BIT
+	depends on 64BIT && IOMMU_SUPPORT
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
+	select IOMMU_API
+	select IOMMU_SVA
+	select MMU_NOTIFIER
 	select PACKING
 	help
 	  Enable support for Smart Data Accelerator Interface (SDXI)
@@ -21,7 +24,7 @@ config SDXI_CORE
 
 config SDXI_PCI
 	tristate "SDXI (Smart Data Accelerator Interface) PCI driver"
-	depends on PCI_MSI && 64BIT
+	depends on PCI_MSI && 64BIT && IOMMU_SUPPORT
 	select SDXI_CORE
 	help
 	  Enable support for PCI-hosted SDXI devices.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 3f49bc9af955..f20a7c39dfc9 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -9,6 +9,7 @@ sdxi-core-y := \
 	dma.o         \
 	error.o       \
 	keys.o        \
+	process.o     \
 	ring.o
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
diff --git a/drivers/dma/sdxi/admin.c b/drivers/dma/sdxi/admin.c
index ed3890de8cc1..b7c8d4ab18e7 100644
--- a/drivers/dma/sdxi/admin.c
+++ b/drivers/dma/sdxi/admin.c
@@ -143,8 +143,13 @@ int sdxi_adm_start_cxt_sync(struct sdxi_cxt *cxt, unsigned int timeout_ms,
 	if (ret)
 		return ret;
 
-	return sdxi_adm_submit(to_admin_cxt(cxt), descs, ARRAY_SIZE(descs),
-			       timeout_ms, cst_flags, interruptible);
+	/* A failed or interrupted wait can leave the context running. */
+	WRITE_ONCE(cxt->quiesced, false);
+	WRITE_ONCE(cxt->started, true);
+	ret = sdxi_adm_submit(to_admin_cxt(cxt), descs, ARRAY_SIZE(descs),
+			      timeout_ms, cst_flags, interruptible);
+
+	return ret;
 }
 
 int sdxi_adm_stop_cxt_sync(struct sdxi_cxt *cxt, unsigned int timeout_ms,
@@ -169,8 +174,12 @@ int sdxi_adm_stop_cxt_sync(struct sdxi_cxt *cxt, unsigned int timeout_ms,
 	if (ret)
 		return ret;
 
-	return sdxi_adm_submit(to_admin_cxt(cxt), descs, ARRAY_SIZE(descs),
-			       timeout_ms, cst_flags, interruptible);
+	ret = sdxi_adm_submit(to_admin_cxt(cxt), descs, ARRAY_SIZE(descs),
+			      timeout_ms, cst_flags, interruptible);
+	if (!ret)
+		WRITE_ONCE(cxt->started, false);
+
+	return ret;
 }
 
 int sdxi_adm_rkey_update_sync(struct sdxi_dev *sdxi, u16 rkey_start,
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 834223e7b003..fe7996a024d6 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -18,6 +18,7 @@
 #include <linux/idr.h>
 #include <linux/iommu.h>
 #include <linux/overflow.h>
+#include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
@@ -28,11 +29,13 @@
 #include "context.h"
 #include "descriptor.h"
 #include "hw.h"
+#include "process.h"
 #include "ring.h"
 #include "sdxi.h"
 #include "submission.h"
 
 #define DEFAULT_DESC_RING_ENTRIES 1024
+#define SDXI_CXT_QUIESCE_TIMEOUT_MS 5000U
 
 enum {
 	/*
@@ -42,6 +45,8 @@ enum {
 	SDXI_ADMIN_CXT_ID = 0,
 };
 
+static void sdxi_cxt_cleanup_workfn(struct work_struct *work);
+
 /*
  * Free context and its resources. @cxt may be partially allocated but
  * must have ->sdxi set.
@@ -50,8 +55,8 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 {
 	struct sdxi_dev *sdxi = cxt->sdxi;
 
-	/* Release the id if this is a client context. */
-	if (cxt->id)
+	/* Release the id if this is a registered client context. */
+	if (cxt->registered)
 		WARN_ON(xa_erase(&sdxi->client_cxts, cxt->id) != cxt);
 
 	if (cxt->cxt_ctl)
@@ -65,6 +70,8 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 	if (cxt->sq)
 		sdxi_sq_free(sdxi, cxt->sq);
 	ida_destroy(&cxt->akey_ida);
+	mutex_destroy(&cxt->akey_lock);
+	mutex_destroy(&cxt->cleanup_lock);
 	kfree(cxt->ring_state);
 	kfree(cxt);
 }
@@ -81,6 +88,11 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 		return NULL;
 
 	cxt->sdxi = sdxi;
+	refcount_set(&cxt->refs, 1);
+	mutex_init(&cxt->cleanup_lock);
+	mutex_init(&cxt->akey_lock);
+	init_waitqueue_head(&cxt->poll_wq);
+	INIT_DELAYED_WORK(&cxt->cleanup_work, sdxi_cxt_cleanup_workfn);
 	ida_init(&cxt->akey_ida);
 	cxt->pasid = IOMMU_NO_PASID;
 	cxt->opb_000_enb = sdxi->op_grp_cap;
@@ -99,6 +111,81 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 	return_ptr(cxt);
 }
 
+/* Claim completion storage before making a ring reservation irrevocable. */
+static int sdxi_cxt_reserve(struct sdxi_cxt *cxt, size_t nr,
+			    struct sdxi_ring_resv *resv,
+			    struct sdxi_completion *comp)
+{
+	int err;
+
+	err = sdxi_cst_pool_get_wait(cxt->cst_pool, comp);
+	if (err)
+		return err;
+
+	err = sdxi_ring_reserve(cxt->ring_state, nr, resv);
+	if (err)
+		sdxi_cst_pool_put(cxt->cst_pool, comp->cst_blk);
+
+	return err;
+}
+
+static int sdxi_cxt_poll_completion(struct sdxi_cxt *cxt,
+				    const struct sdxi_completion *comp)
+{
+	int err = sdxi_cst_blk_poll(comp->cst_blk);
+
+	/*
+	 * A timeout does not end hardware ownership. Keep these administrative
+	 * blocks claimed until context teardown, even if they complete later.
+	 * Repeated timeouts can exhaust the pool; allocation then times out too.
+	 */
+	if (err != -ETIMEDOUT)
+		sdxi_cst_pool_put(cxt->cst_pool, comp->cst_blk);
+	sdxi_ring_wake_up(cxt->ring_state);
+
+	return err;
+}
+
+/*
+ * Signal the function that a client context's control structures have
+ * been modified so it discards any privately cached copies of them.
+ * DSC_SYNC.CXT is required before the operation can be considered
+ * complete.
+ */
+static int sdxi_cxt_update_locked(const struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt *adm = to_admin_cxt(cxt);
+	struct sdxi_slot upd, sync;
+	struct sdxi_ring_resv resv;
+	struct sdxi_completion comp;
+	int err;
+
+	might_sleep();
+	lockdep_assert_held(&cxt->sdxi->admin_lock);
+	if (cxt->sdxi->admin_dead)
+		return -EIO;
+
+	err = sdxi_cxt_reserve(adm, 2, &resv, &comp);
+	if (err)
+		return err;
+
+	upd = sdxi_ring_resv_slot(&resv, 0);
+	sync = sdxi_ring_resv_slot(&resv, 1);
+
+	sdxi_encode_cxt_upd(sdxi_slot_desc(upd), &(const struct sdxi_cxt_upd) {
+			.level = SDXI_CXT_UPD_LVL_L1,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_encode_sync(sdxi_slot_desc(sync), &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_CXT,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_cxt_submit(adm, upd, NULL, 0);
+	sdxi_cxt_submit(adm, sync, &comp, SDXI_CXT_SUBMIT_KICK);
+
+	return sdxi_cxt_poll_completion(adm, &comp);
+}
+
 static int sdxi_alloc_kernel_submission(struct sdxi_cxt *cxt)
 {
 	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
@@ -259,12 +346,33 @@ sdxi_get_L1_table(struct sdxi_dev *sdxi, u16 l2_idx)
 	return table;
 }
 
+static void sdxi_put_L1_table(struct sdxi_dev *sdxi, u16 l2_idx)
+{
+	struct sdxi_cxt_L1_table *table;
+	struct sdxi_cxt_L2_ent *L2_ent;
+
+	lockdep_assert_held(&sdxi->cxt_lock);
+
+	if (sdxi->L1_users[l2_idx])
+		return;
+
+	table = sdxi->L1_tables[l2_idx];
+	if (!table)
+		return;
+
+	L2_ent = &sdxi->L2_table->entry[l2_idx];
+	WRITE_ONCE(L2_ent->lv01_ptr, 0);
+	dma_wmb();
+
+	sdxi->L1_tables[l2_idx] = NULL;
+	sdxi->L1_dma[l2_idx] = 0;
+}
+
 /*
  * Publish the context control structure hierarchy to the SDXI
- * implementation. L1 pages remain allocated until device teardown so a
- * cached L2 pointer can never refer to freed memory.
+ * implementation. This may allocate an L1 table page, so it is fallible.
  */
-static int sdxi_publish_cxt(const struct sdxi_cxt *cxt,
+static int sdxi_publish_cxt(struct sdxi_cxt *cxt,
 			    const struct sdxi_cxt_ctl_cfg *ctl_cfg)
 {
 	struct sdxi_cxt_L1_cfg L1_cfg;
@@ -311,19 +419,325 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt,
 
 out_unlock:
 	mutex_unlock(&cxt->sdxi->cxt_lock);
-	if (err)
+	if (err) {
 		invalidate_cxt_ctl(cxt->cxt_ctl);
+	} else {
+		cxt->published = true;
+		cxt->update_pending = false;
+	}
+	return err;
+}
+
+/* Invalidate a context. */
+static void sdxi_rescind_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt_L1_table *L1_table;
+	struct sdxi_dev *sdxi = cxt->sdxi;
+	u16 l2_idx = ID_TO_L2_INDEX(cxt->id);
+	u8 l1_idx = ID_TO_L1_INDEX(cxt->id);
+
+	if (!cxt->published)
+		return;
+
+	mutex_lock(&sdxi->cxt_lock);
+	L1_table = sdxi->L1_tables[l2_idx];
+	if (WARN_ON_ONCE(!L1_table))
+		goto out_unlock;
+
+	invalidate_L1_entry(&L1_table->entry[l1_idx]);
+	if (WARN_ON_ONCE(!sdxi->L1_users[l2_idx]))
+		goto out_unlock;
+
+	sdxi->L1_users[l2_idx]--;
+
+out_unlock:
+	mutex_unlock(&sdxi->cxt_lock);
+	invalidate_cxt_ctl(cxt->cxt_ctl);
+	cxt->published = false;
+	cxt->update_pending = true;
+}
+
+/* Empty L1 tables remain published until the function has stopped. */
+static void sdxi_cxt_finish_unpublish(struct sdxi_cxt *cxt,
+				      bool function_stopped)
+{
+	struct sdxi_dev *sdxi = cxt->sdxi;
+	u16 l2_idx = ID_TO_L2_INDEX(cxt->id);
+
+	if (!cxt->update_pending)
+		return;
+
+	if (function_stopped) {
+		mutex_lock(&sdxi->cxt_lock);
+		sdxi_put_L1_table(sdxi, l2_idx);
+		mutex_unlock(&sdxi->cxt_lock);
+	}
+	cxt->update_pending = false;
+}
+
+static int sdxi_cxt_unpublish(struct sdxi_cxt *cxt)
+{
+	int err;
+
+	mutex_lock(&cxt->sdxi->admin_lock);
+	if (cxt->published)
+		sdxi_rescind_cxt(cxt);
+	if (!cxt->update_pending) {
+		err = 0;
+		goto out_unlock;
+	}
+
+	err = sdxi_cxt_update_locked(cxt);
+	if (!err)
+		sdxi_cxt_finish_unpublish(cxt, false);
+
+out_unlock:
+	mutex_unlock(&cxt->sdxi->admin_lock);
 	return err;
 }
 
+/* Hardware has stopped, so no update/sync is needed before freeing tables. */
+static void sdxi_cxt_force_unpublish(struct sdxi_cxt *cxt)
+{
+	if (cxt->published)
+		sdxi_rescind_cxt(cxt);
+	sdxi_cxt_finish_unpublish(cxt, true);
+}
+
+void sdxi_cxt_get(struct sdxi_cxt *cxt)
+{
+	refcount_inc(&cxt->refs);
+}
+
+void sdxi_cxt_put(struct sdxi_cxt *cxt)
+{
+	if (cxt && refcount_dec_and_test(&cxt->refs))
+		sdxi_free_cxt(cxt);
+}
+
+struct sdxi_cxt *sdxi_cxt_get_by_id(struct sdxi_dev *sdxi, u16 cxt_id)
+{
+	struct sdxi_cxt *cxt;
+
+	xa_lock(&sdxi->client_cxts);
+	cxt = xa_load(&sdxi->client_cxts, cxt_id);
+	if (cxt && !refcount_inc_not_zero(&cxt->refs))
+		cxt = NULL;
+	xa_unlock(&sdxi->client_cxts);
+
+	return cxt;
+}
+
+/* Free resources only after update/sync or after the function has stopped. */
+static void sdxi_cxt_release_resources(struct sdxi_cxt *cxt)
+{
+	struct sdxi_dev *sdxi = cxt->sdxi;
+
+	if (cxt->registered) {
+		WARN_ON(xa_erase(&sdxi->client_cxts, cxt->id) != cxt);
+		cxt->registered = false;
+	}
+
+	if (cxt->cxt_ctl) {
+		dma_pool_free(sdxi->cxt_ctl_pool, cxt->cxt_ctl,
+			      cxt->cxt_ctl_dma);
+		cxt->cxt_ctl = NULL;
+		cxt->cxt_ctl_dma = 0;
+	}
+	if (cxt->akey_table) {
+		mutex_lock(&cxt->akey_lock);
+		dma_free_coherent(sdxi->dev, sizeof(*cxt->akey_table),
+				  cxt->akey_table, cxt->akey_table_dma);
+		cxt->akey_table = NULL;
+		cxt->akey_table_dma = 0;
+		mutex_unlock(&cxt->akey_lock);
+	}
+	if (cxt->cst_pool) {
+		sdxi_cst_pool_destroy(sdxi, cxt->cst_pool);
+		cxt->cst_pool = NULL;
+	}
+	if (cxt->sq) {
+		sdxi_sq_free(sdxi, cxt->sq);
+		cxt->sq = NULL;
+	}
+	kfree(cxt->ring_state);
+	cxt->ring_state = NULL;
+}
+
+static void sdxi_cxt_finish_release(struct sdxi_cxt *cxt,
+				    struct sdxi_process *process)
+{
+	struct iommu_sva *sva = NULL;
+	u32 pasid = 0;
+
+	wake_up_poll(&cxt->poll_wq, EPOLLHUP);
+	sdxi_cxt_release_resources(cxt);
+
+	if (process) {
+		mutex_lock(&process->mutex);
+		sva = sdxi_process_detach_sva_locked(process, &pasid);
+		mutex_unlock(&process->mutex);
+
+		sdxi_process_unbind_sva(process, sva, pasid);
+
+		/* Keep CREATE_CXT excluded until the old SVA is fully unbound. */
+		mutex_lock(&process->mutex);
+		if (process->cxt == cxt)
+			process->cxt = NULL;
+		mutex_unlock(&process->mutex);
+		sdxi_process_put(process);
+	}
+
+	/* Drop the context's base ownership reference. */
+	sdxi_cxt_put(cxt);
+}
+
+static bool sdxi_cxt_cleanup_requested(const struct sdxi_cxt *cxt)
+{
+	return cxt->handle_closed || cxt->mm_dead || READ_ONCE(cxt->fatal);
+}
+
+static void sdxi_cxt_queue_cleanup_locked(struct sdxi_cxt *cxt,
+					  unsigned long delay)
+{
+	lockdep_assert_held(&cxt->cleanup_lock);
+
+	if (!cxt->cleanup_stopping && !cxt->resources_released)
+		mod_delayed_work(system_percpu_wq, &cxt->cleanup_work, delay);
+}
+
+static int sdxi_cxt_quiesce_locked(struct sdxi_cxt *cxt,
+				   unsigned int timeout_ms, u32 *cst_flags,
+				   bool interruptible)
+{
+	u32 flags = 0;
+	int ret = 0;
+
+	lockdep_assert_held(&cxt->cleanup_lock);
+
+	if (cxt->resources_released)
+		return -ENODEV;
+	if (cxt->quiesced)
+		goto out;
+
+	if (!cxt->started || sdxi_cxt_is_admin(cxt))
+		goto quiesced;
+
+	if (!timeout_ms)
+		timeout_ms = SDXI_CXT_QUIESCE_TIMEOUT_MS;
+
+	ret = sdxi_adm_stop_cxt_sync(cxt, timeout_ms, &flags,
+				     interruptible);
+	if (ret)
+		return ret;
+
+quiesced:
+	cxt->started = false;
+	cxt->quiesced = true;
+	cxt->quiesce_cst_flags = flags;
+out:
+	if (cst_flags)
+		*cst_flags = cxt->quiesce_cst_flags;
+	return 0;
+}
+
+static void sdxi_cxt_cleanup_workfn(struct work_struct *work)
+{
+	struct sdxi_cxt *cxt = container_of(to_delayed_work(work),
+					     struct sdxi_cxt, cleanup_work);
+	struct sdxi_process *process = NULL;
+	bool force_release = false;
+	bool destroy = false;
+	int ret;
+
+	mutex_lock(&cxt->cleanup_lock);
+	if (cxt->resources_released || !sdxi_cxt_cleanup_requested(cxt))
+		goto out_unlock;
+
+	if (!cxt->quiesced) {
+		ret = sdxi_cxt_quiesce_locked(cxt, 0, NULL, false);
+		if (ret) {
+			dev_err(cxt->sdxi->dev,
+				"failed to quiesce context %u: %d; quiescing function\n",
+				cxt->id, ret);
+			sdxi_dev_fail(cxt->sdxi);
+			cxt->started = false;
+			cxt->quiesced = true;
+			cxt->quiesce_cst_flags = 0;
+			force_release = true;
+		}
+	}
+	if (cxt->vma_refs)
+		goto out_unlock;
+
+	if (!force_release) {
+		ret = sdxi_cxt_unpublish(cxt);
+		if (ret) {
+			dev_err(cxt->sdxi->dev,
+				"failed to synchronize context %u release: %d; quiescing function\n",
+				cxt->id, ret);
+			sdxi_dev_fail(cxt->sdxi);
+			force_release = true;
+		}
+	}
+	if (force_release)
+		sdxi_cxt_force_unpublish(cxt);
+
+	cxt->resources_released = true;
+	cxt->cleanup_stopping = true;
+	process = cxt->process;
+	cxt->process = NULL;
+	destroy = true;
+
+out_unlock:
+	mutex_unlock(&cxt->cleanup_lock);
+
+	if (destroy)
+		sdxi_cxt_finish_release(cxt, process);
+}
+
+/* Device teardown has already stopped hardware, so force resource release. */
+static void sdxi_cxt_force_exit(struct sdxi_cxt *cxt)
+{
+	struct sdxi_process *process = NULL;
+	bool destroy = false;
+
+	if (!cxt || !refcount_inc_not_zero(&cxt->refs))
+		return;
+
+	mutex_lock(&cxt->cleanup_lock);
+	cxt->cleanup_stopping = true;
+	mutex_unlock(&cxt->cleanup_lock);
+	cancel_delayed_work_sync(&cxt->cleanup_work);
+
+	mutex_lock(&cxt->cleanup_lock);
+	if (!cxt->resources_released) {
+		sdxi_cxt_force_unpublish(cxt);
+		cxt->started = false;
+		cxt->quiesced = true;
+		cxt->resources_released = true;
+		process = cxt->process;
+		cxt->process = NULL;
+		destroy = true;
+	}
+	mutex_unlock(&cxt->cleanup_lock);
+
+	if (destroy)
+		sdxi_cxt_finish_release(cxt, process);
+	/* Drop the temporary reference acquired above. */
+	sdxi_cxt_put(cxt);
+}
+
 static void free_admin_cxt(void *ptr)
 {
 	struct sdxi_dev *sdxi = ptr;
 
-	sdxi_free_cxt(sdxi->admin_cxt);
+	sdxi_cxt_force_exit(sdxi->admin_cxt);
 }
 
-static int sdxi_cxt_set_doorbell(struct sdxi_cxt *cxt);
+static int sdxi_cxt_doorbell_offset(const struct sdxi_cxt *cxt,
+				    size_t *offset);
+static int sdxi_cxt_set_kernel_doorbell(struct sdxi_cxt *cxt);
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 {
@@ -343,7 +757,7 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	/* SDXI 1.0 4.1.8.4.b: Set CXT_STS.state to CXTV_RUN. */
 	sq->cxt_sts.state = FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
 	cxt->id = SDXI_ADMIN_CXT_ID;
-	err = sdxi_cxt_set_doorbell(cxt);
+	err = sdxi_cxt_set_kernel_doorbell(cxt);
 	if (err)
 		return err;
 
@@ -359,6 +773,7 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	if (err)
 		return err;
 
+	cxt->started = true;
 	sdxi->admin_cxt = no_free_ptr(cxt);
 
 	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
@@ -400,20 +815,35 @@ static bool sdxi_cxt_id_valid(const struct sdxi_cxt_id *cxt_id)
 	return cxt_id->index > 0;
 }
 
-static int sdxi_cxt_set_doorbell(struct sdxi_cxt *cxt)
+static int sdxi_cxt_doorbell_offset(const struct sdxi_cxt *cxt,
+				    size_t *offset)
 {
 	struct sdxi_dev *sdxi = cxt->sdxi;
-	size_t offset;
+	size_t value;
 
 	if (check_mul_overflow((size_t)cxt->id, (size_t)sdxi->db_stride,
-			       &offset) ||
-	    offset > sdxi->db_size ||
-	    sdxi->db_stride > sdxi->db_size - offset)
+			       &value) ||
+	    value > sdxi->db_size ||
+	    sdxi->db_stride > sdxi->db_size - value)
 		return -ERANGE;
 
+	if (offset)
+		*offset = value;
+	return 0;
+}
+
+static int sdxi_cxt_set_kernel_doorbell(struct sdxi_cxt *cxt)
+{
+	size_t offset;
+	int err;
+
 	if (WARN_ON_ONCE(!cxt->sq))
 		return -EINVAL;
-	cxt->sq->doorbell = sdxi->dbs + offset;
+	err = sdxi_cxt_doorbell_offset(cxt, &offset);
+	if (err)
+		return err;
+
+	cxt->sq->doorbell = cxt->sdxi->dbs + offset;
 	return 0;
 }
 
@@ -427,9 +857,34 @@ static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id *cxt_id)
 	WARN_ON(xa_store(&cxt_id->sdxi->client_cxts,
 			 cxt_id->index, cxt, GFP_KERNEL));
 	cxt->id = cxt_id->index;
+	cxt->registered = true;
 	cxt_id->index = 0;
 }
 
+static struct sdxi_cxt *sdxi_alloc_client_cxt(struct sdxi_dev *sdxi)
+{
+	CLASS(sdxi_cxt_id, id)(sdxi);
+	struct sdxi_cxt *cxt __free(sdxi_cxt) = NULL;
+
+	if (!sdxi_cxt_id_valid(&id))
+		return NULL;
+
+	cxt = sdxi_alloc_cxt(sdxi);
+	if (!cxt)
+		return NULL;
+
+	sdxi_cxt_id_assign(cxt, &id);
+	if (sdxi_cxt_doorbell_offset(cxt, NULL))
+		return NULL;
+	mutex_lock(&sdxi->cxt_lock);
+	cxt->mmap_gen = ++sdxi->mmap_gen;
+	if (!cxt->mmap_gen)
+		cxt->mmap_gen = ++sdxi->mmap_gen;
+	mutex_unlock(&sdxi->cxt_lock);
+
+	return_ptr(cxt);
+}
+
 /*
  * Allocate a context for in-kernel use. Starting the context is the
  * caller's responsibility.
@@ -437,27 +892,19 @@ static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id *cxt_id)
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 {
 	struct sdxi_cxt_ctl_cfg ctl_cfg;
+	struct sdxi_cxt *cxt;
 	int err;
 
-	/*
-	 * Ensure an ID is available before allocating memory for the
-	 * context and its control structures.
-	 */
-	CLASS(sdxi_cxt_id, id)(sdxi);
-	if (!sdxi_cxt_id_valid(&id))
-		return NULL;
-
-	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
+	cxt = sdxi_alloc_client_cxt(sdxi);
 	if (!cxt)
 		return NULL;
 
 	err = sdxi_alloc_kernel_submission(cxt);
 	if (err)
-		return NULL;
-
-	sdxi_cxt_id_assign(cxt, &id);
-	if (sdxi_cxt_set_doorbell(cxt))
-		return NULL;
+		goto put_cxt;
+	err = sdxi_cxt_set_kernel_doorbell(cxt);
+	if (err)
+		goto put_cxt;
 
 	ctl_cfg = (typeof(ctl_cfg)) {
 		.se              = 1,
@@ -468,9 +915,41 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 		.write_index_ptr = sdxi_sq_write_index_dma(cxt->sq),
 	};
 	if (sdxi_publish_cxt(cxt, &ctl_cfg))
+		goto put_cxt;
+
+	return cxt;
+
+put_cxt:
+	sdxi_cxt_put(cxt);
+	return NULL;
+}
+
+struct sdxi_cxt *sdxi_ucxt_new(struct sdxi_dev *sdxi, u32 ring_entries,
+			       u64 ds_ring, u64 write_index, u64 cxt_sts,
+			       u32 pasid, u32 opb_000_enb)
+{
+	struct sdxi_cxt_ctl_cfg ctl_cfg = {
+		.ds_ring_ptr = ds_ring,
+		.ds_ring_sz = ring_entries,
+		.cxt_sts_ptr = cxt_sts,
+		.write_index_ptr = write_index,
+	};
+	struct sdxi_cxt *cxt;
+
+	cxt = sdxi_alloc_client_cxt(sdxi);
+	if (!cxt)
 		return NULL;
 
-	return_ptr(cxt);
+	cxt->pasid_valid = true;
+	cxt->pasid = pasid;
+	cxt->opb_000_enb = opb_000_enb;
+
+	if (sdxi_publish_cxt(cxt, &ctl_cfg)) {
+		sdxi_cxt_put(cxt);
+		return NULL;
+	}
+
+	return cxt;
 }
 
 /*
@@ -481,10 +960,17 @@ void sdxi_client_cxts_exit(struct sdxi_dev *sdxi)
 {
 	struct sdxi_cxt *cxt;
 	unsigned long index;
+	size_t l2_idx;
 
 	xa_for_each(&sdxi->client_cxts, index, cxt)
-		sdxi_free_cxt(cxt);
+		sdxi_cxt_force_exit(cxt);
 	xa_destroy(&sdxi->client_cxts);
+
+	/* Reclaim empty pages retained to keep L2 pointers stable at runtime. */
+	mutex_lock(&sdxi->cxt_lock);
+	for (l2_idx = 0; l2_idx < ARRAY_SIZE(sdxi->L1_tables); l2_idx++)
+		sdxi_put_L1_table(sdxi, l2_idx);
+	mutex_unlock(&sdxi->cxt_lock);
 }
 
 /*
@@ -529,43 +1015,168 @@ void sdxi_cxt_submit(struct sdxi_cxt *cxt, struct sdxi_slot slot,
  */
 int sdxi_cxt_exit(struct sdxi_cxt *cxt)
 {
-	struct sdxi_dev *sdxi = cxt->sdxi;
-	struct sdxi_cxt_L1_table *L1_table;
-	u16 l2_idx = ID_TO_L2_INDEX(cxt->id);
-	u8 l1_idx = ID_TO_L1_INDEX(cxt->id);
-	u8 state;
-	int err;
+	struct sdxi_process *process = NULL;
+	bool destroy = false;
+	int ret = 0;
 
+	if (!cxt)
+		return -EINVAL;
 	if (WARN_ON(sdxi_cxt_is_admin(cxt)))
 		return -EINVAL;
+	if (!refcount_inc_not_zero(&cxt->refs))
+		return -ENODEV;
 
-	state = FIELD_GET(SDXI_CXT_STS_STATE, READ_ONCE(cxt->sq->cxt_sts.state));
-	if (state != CXTV_STOP_SW && state != CXTV_STOP_FN && state != CXTV_ERR_FN)
-		return -EBUSY;
+	mutex_lock(&cxt->cleanup_lock);
+	cxt->cleanup_stopping = true;
+	mutex_unlock(&cxt->cleanup_lock);
+	cancel_delayed_work_sync(&cxt->cleanup_work);
 
-	mutex_lock(&sdxi->cxt_lock);
-	L1_table = sdxi->L1_tables[l2_idx];
-	if (WARN_ON_ONCE(!L1_table)) {
-		mutex_unlock(&sdxi->cxt_lock);
-		return -EIO;
+	mutex_lock(&cxt->cleanup_lock);
+	if (cxt->resources_released)
+		goto out_unlock;
+	if (cxt->vma_refs) {
+		ret = -EBUSY;
+		goto out_unlock;
 	}
-	invalidate_L1_entry(&L1_table->entry[l1_idx]);
-	invalidate_cxt_ctl(cxt->cxt_ctl);
-	mutex_unlock(&sdxi->cxt_lock);
 
-	err = sdxi_adm_update_cxt(cxt);
-	if (err) {
-		dev_err(sdxi->dev,
-			"context %u release failed (%d), retaining resources until function shutdown\n",
-			cxt->id, err);
-		return err;
+	ret = sdxi_cxt_quiesce_locked(cxt, 0, NULL, false);
+	if (ret)
+		goto out_retain;
+
+	ret = sdxi_cxt_unpublish(cxt);
+	if (ret)
+		goto out_retain;
+
+	cxt->resources_released = true;
+	process = cxt->process;
+	cxt->process = NULL;
+	destroy = true;
+	goto out_unlock;
+
+out_retain:
+	dev_err(cxt->sdxi->dev,
+		"context %u release failed (%d), retaining resources until function shutdown\n",
+		cxt->id, ret);
+out_unlock:
+	mutex_unlock(&cxt->cleanup_lock);
+
+	if (destroy)
+		sdxi_cxt_finish_release(cxt, process);
+	/* Drop the temporary reference acquired above. */
+	sdxi_cxt_put(cxt);
+	return ret;
+}
+
+int sdxi_cxt_quiesce(struct sdxi_cxt *cxt, unsigned int timeout_ms,
+		     u32 *cst_flags)
+{
+	int ret;
+
+	if (!cxt)
+		return -EINVAL;
+
+	mutex_lock(&cxt->cleanup_lock);
+	ret = sdxi_cxt_quiesce_locked(cxt, timeout_ms, cst_flags, true);
+	if (!ret && sdxi_cxt_cleanup_requested(cxt))
+		sdxi_cxt_queue_cleanup_locked(cxt, 0);
+	mutex_unlock(&cxt->cleanup_lock);
+
+	return ret;
+}
+
+bool sdxi_cxt_is_user(const struct sdxi_cxt *cxt)
+{
+	return cxt && cxt->id && READ_ONCE(cxt->pasid_valid) &&
+	       READ_ONCE(cxt->process);
+}
+
+bool sdxi_cxt_is_fatal(const struct sdxi_cxt *cxt)
+{
+	return !cxt || READ_ONCE(cxt->fatal);
+}
+
+void sdxi_cxt_kill(struct sdxi_cxt *cxt)
+{
+	if (!cxt)
+		return;
+
+	mutex_lock(&cxt->cleanup_lock);
+	if (cxt->fatal) {
+		mutex_unlock(&cxt->cleanup_lock);
+		return;
 	}
+	cxt->fatal = true;
+	if (sdxi_cxt_is_user(cxt))
+		sdxi_cxt_queue_cleanup_locked(cxt, 0);
+	mutex_unlock(&cxt->cleanup_lock);
 
-	mutex_lock(&sdxi->cxt_lock);
-	if (!WARN_ON_ONCE(!sdxi->L1_users[l2_idx]))
-		sdxi->L1_users[l2_idx]--;
-	mutex_unlock(&sdxi->cxt_lock);
+	wake_up_poll(&cxt->poll_wq, EPOLLERR);
+}
 
-	sdxi_free_cxt(cxt);
-	return 0;
+void sdxi_cxt_release_user_handle(struct sdxi_cxt *cxt)
+{
+	if (!cxt)
+		return;
+
+	mutex_lock(&cxt->cleanup_lock);
+	cxt->handle_closed = true;
+	if (!cxt->resources_released)
+		sdxi_cxt_queue_cleanup_locked(cxt, 0);
+	mutex_unlock(&cxt->cleanup_lock);
+}
+
+int sdxi_cxt_notify_mm_release(struct sdxi_cxt *cxt)
+{
+	int ret = 0;
+
+	if (!cxt)
+		return -EINVAL;
+
+	mutex_lock(&cxt->cleanup_lock);
+	cxt->mm_dead = true;
+	if (!cxt->resources_released) {
+		ret = sdxi_cxt_quiesce_locked(cxt, 0, NULL, false);
+		if (ret) {
+			dev_err(cxt->sdxi->dev,
+				"failed to quiesce context %u during mm release: %d; quiescing function\n",
+				cxt->id, ret);
+			sdxi_dev_fail(cxt->sdxi);
+			cxt->started = false;
+			cxt->quiesced = true;
+			cxt->quiesce_cst_flags = 0;
+		}
+		sdxi_cxt_queue_cleanup_locked(cxt, 0);
+	}
+	mutex_unlock(&cxt->cleanup_lock);
+
+	return ret;
+}
+
+void sdxi_cxt_vma_open(struct sdxi_cxt *cxt)
+{
+	if (!cxt)
+		return;
+
+	sdxi_cxt_get(cxt);
+	mutex_lock(&cxt->cleanup_lock);
+	cxt->vma_refs++;
+	mutex_unlock(&cxt->cleanup_lock);
+}
+
+void sdxi_cxt_vma_close(struct sdxi_cxt *cxt)
+{
+	if (!cxt)
+		return;
+
+	mutex_lock(&cxt->cleanup_lock);
+	if (WARN_ON_ONCE(!cxt->vma_refs))
+		goto out_unlock;
+
+	cxt->vma_refs--;
+	if (!cxt->resources_released && sdxi_cxt_cleanup_requested(cxt))
+		sdxi_cxt_queue_cleanup_locked(cxt, 0);
+
+out_unlock:
+	mutex_unlock(&cxt->cleanup_lock);
+	sdxi_cxt_put(cxt);
 }
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 8e57565c0707..eed8cef453df 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -10,8 +10,12 @@
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include "hw.h"
 #include "ring.h"
@@ -20,6 +24,7 @@
 
 struct sdxi_completion;
 struct sdxi_cst_pool;
+struct sdxi_process;
 
 /* Use a 4 KiB AKey table, the minimum architectural size. */
 struct sdxi_akey_table {
@@ -35,15 +40,33 @@ static inline u8 akey_table_order(const struct sdxi_akey_table *tbl)
 
 struct sdxi_cxt {
 	struct sdxi_dev *sdxi;
+	refcount_t refs;
+	struct mutex cleanup_lock;	/* lifetime state serialization */
+	wait_queue_head_t poll_wq;
+	struct delayed_work cleanup_work;
 	u16 id;
+	u32 mmap_gen;
 	u32 pasid;
 	u32 opb_000_enb;
+	u32 quiesce_cst_flags;
+	unsigned int vma_refs;
 	bool pasid_valid;
+	bool handle_closed;
+	bool mm_dead;
+	bool fatal;
+	bool quiesced;
+	bool cleanup_stopping;
+	bool resources_released;
+	bool registered;
+	bool published;
+	bool update_pending;
+	bool started;
 
 	struct sdxi_cxt_ctl *cxt_ctl;
 	dma_addr_t cxt_ctl_dma;
 
 	struct ida akey_ida;
+	struct mutex akey_lock;		/* AKey table serialization */
 	struct sdxi_akey_table *akey_table;
 	dma_addr_t akey_table_dma;
 
@@ -51,10 +74,14 @@ struct sdxi_cxt {
 	struct sdxi_cst_pool *cst_pool;
 
 	struct sdxi_ring_state *ring_state;
+	struct sdxi_process *process;
 };
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
+struct sdxi_cxt *sdxi_ucxt_new(struct sdxi_dev *sdxi, u32 ring_entries,
+			       u64 ds_ring, u64 write_index, u64 cxt_sts,
+			       u32 pasid, u32 opb_000_enb);
 /*
  * Caller must exclude users and stop the client before release. An update or
  * synchronization failure retains the invalidated context for device teardown;
@@ -62,6 +89,18 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
  */
 int sdxi_cxt_exit(struct sdxi_cxt *cxt);
 void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
+void sdxi_cxt_get(struct sdxi_cxt *cxt);
+void sdxi_cxt_put(struct sdxi_cxt *cxt);
+struct sdxi_cxt *sdxi_cxt_get_by_id(struct sdxi_dev *sdxi, u16 cxt_id);
+int sdxi_cxt_quiesce(struct sdxi_cxt *cxt, unsigned int timeout_ms,
+		     u32 *cst_flags);
+bool sdxi_cxt_is_user(const struct sdxi_cxt *cxt);
+bool sdxi_cxt_is_fatal(const struct sdxi_cxt *cxt);
+void sdxi_cxt_kill(struct sdxi_cxt *cxt);
+void sdxi_cxt_release_user_handle(struct sdxi_cxt *cxt);
+int sdxi_cxt_notify_mm_release(struct sdxi_cxt *cxt);
+void sdxi_cxt_vma_open(struct sdxi_cxt *cxt);
+void sdxi_cxt_vma_close(struct sdxi_cxt *cxt);
 
 enum sdxi_submit_flags {
 	SDXI_CXT_SUBMIT_KICK  = BIT(0),
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 4b54b14fefc1..e760c8a2603a 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -279,6 +279,16 @@ void sdxi_dev_force_quiesce(struct sdxi_dev *sdxi)
 		sdxi->bus_ops->force_quiesce(sdxi);
 }
 
+void sdxi_dev_fail(struct sdxi_dev *sdxi)
+{
+	mutex_lock(&sdxi->admin_lock);
+	if (!sdxi->admin_dead) {
+		sdxi->admin_dead = true;
+		sdxi_dev_force_quiesce(sdxi);
+	}
+	mutex_unlock(&sdxi->admin_lock);
+}
+
 /* Stop the function and discard inherited MMIO configuration. */
 static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
 {
diff --git a/drivers/dma/sdxi/process.c b/drivers/dma/sdxi/process.c
new file mode 100644
index 000000000000..bc0552b554ba
--- /dev/null
+++ b/drivers/dma/sdxi/process.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI userspace process and SVA management.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/iommu.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+
+#include "context.h"
+#include "process.h"
+#include "sdxi.h"
+
+static void sdxi_process_cleanup(struct sdxi_process *process)
+{
+	struct sdxi_cxt *cxt;
+	int ret;
+
+	mutex_lock(&process->mutex);
+	cxt = process->cxt;
+	if (cxt)
+		sdxi_cxt_get(cxt);
+	mutex_unlock(&process->mutex);
+
+	if (!cxt)
+		return;
+
+	ret = sdxi_cxt_notify_mm_release(cxt);
+	if (ret)
+		dev_err(process->sdxi->dev,
+			"failed to quiesce context %u during mm release: %d\n",
+			cxt->id, ret);
+	sdxi_cxt_put(cxt);
+}
+
+static void sdxi_mmu_notifier_release(struct mmu_notifier *notifier,
+				      struct mm_struct *mm)
+{
+	struct sdxi_process *process;
+
+	process = container_of(notifier, struct sdxi_process, notifier);
+	sdxi_process_cleanup(process);
+}
+
+static const struct mmu_notifier_ops sdxi_mmu_notifier_ops = {
+	.release = sdxi_mmu_notifier_release,
+};
+
+static int sdxi_process_register_notifier(struct sdxi_process *process)
+{
+	int ret;
+
+	if (process->notifier_registered)
+		return 0;
+
+	ret = mmu_notifier_register(&process->notifier, process->mm);
+	if (ret)
+		return ret;
+
+	process->notifier_registered = true;
+	return 0;
+}
+
+struct iommu_sva *
+sdxi_process_detach_sva_locked(struct sdxi_process *process, u32 *pasid)
+{
+	struct iommu_sva *sva;
+
+	lockdep_assert_held(&process->mutex);
+
+	sva = process->sva;
+	if (!sva) {
+		if (pasid)
+			*pasid = 0;
+		return NULL;
+	}
+
+	if (pasid)
+		*pasid = process->pasid;
+	process->sva = NULL;
+	process->pasid = 0;
+
+	return sva;
+}
+
+void sdxi_process_unbind_sva(struct sdxi_process *process,
+			     struct iommu_sva *sva, u32 pasid)
+{
+	if (process->notifier_registered) {
+		process->notifier_registered = false;
+		mmu_notifier_unregister(&process->notifier, process->mm);
+	}
+
+	if (sva)
+		iommu_sva_unbind_device(sva);
+}
+
+static void sdxi_process_free(struct sdxi_process *process)
+{
+	struct iommu_sva *sva;
+	u32 pasid;
+
+	mutex_lock(&process->mutex);
+	sva = sdxi_process_detach_sva_locked(process, &pasid);
+	mutex_unlock(&process->mutex);
+
+	sdxi_process_unbind_sva(process, sva, pasid);
+	put_task_struct(process->lead_thread);
+	mmdrop(process->mm);
+	kfree(process);
+}
+
+void sdxi_process_get(struct sdxi_process *process)
+{
+	refcount_inc(&process->refs);
+}
+
+void sdxi_process_put(struct sdxi_process *process)
+{
+	if (process && refcount_dec_and_test(&process->refs))
+		sdxi_process_free(process);
+}
+
+int sdxi_process_bind(struct sdxi_process *process)
+{
+	struct iommu_sva *sva;
+	u32 pasid;
+	int ret;
+
+	if (!process->sdxi)
+		return -ENODEV;
+
+	sva = iommu_sva_bind_device(process->sdxi->dev, process->mm);
+	if (IS_ERR(sva))
+		return PTR_ERR(sva);
+
+	pasid = iommu_sva_get_pasid(sva);
+	if (pasid == IOMMU_PASID_INVALID) {
+		ret = -EINVAL;
+		goto unbind;
+	}
+
+	/*
+	 * Register after the IOMMU notifier so SDXI quiesces the context
+	 * before SVA translations disappear during exit_mmap().
+	 */
+	ret = sdxi_process_register_notifier(process);
+	if (ret)
+		goto unbind;
+
+	process->pasid = pasid;
+	process->sva = sva;
+	return 0;
+
+unbind:
+	iommu_sva_unbind_device(sva);
+	return ret;
+}
+
+struct sdxi_process *sdxi_process_create(struct sdxi_dev *sdxi)
+{
+	struct task_struct *task = current;
+	struct sdxi_process *process;
+
+	if (!task->mm)
+		return ERR_PTR(-EINVAL);
+
+	process = kzalloc_obj(*process, GFP_KERNEL);
+	if (!process)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&process->refs, 1);
+	mutex_init(&process->mutex);
+	process->lead_thread = task->group_leader;
+	get_task_struct(process->lead_thread);
+	process->mm = task->mm;
+	mmgrab(process->mm);
+	process->sdxi = sdxi;
+	process->notifier.ops = &sdxi_mmu_notifier_ops;
+	INIT_HLIST_NODE(&process->notifier.hlist);
+
+	return process;
+}
diff --git a/drivers/dma/sdxi/process.h b/drivers/dma/sdxi/process.h
new file mode 100644
index 000000000000..cb48cc3c20c9
--- /dev/null
+++ b/drivers/dma/sdxi/process.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI userspace process state.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_PROCESS_H
+#define DMA_SDXI_PROCESS_H
+
+#include <linux/mmu_notifier.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+
+struct iommu_sva;
+struct sdxi_cxt;
+struct sdxi_dev;
+
+struct sdxi_process {
+	refcount_t refs;
+	struct mutex mutex;		/* context and SVA serialization */
+	struct task_struct *lead_thread;
+	struct mm_struct *mm;
+	struct mmu_notifier notifier;
+	bool notifier_registered;
+
+	struct sdxi_dev *sdxi;
+	struct sdxi_cxt *cxt;
+	struct iommu_sva *sva;
+	u32 pasid;
+};
+
+struct sdxi_process *sdxi_process_create(struct sdxi_dev *sdxi);
+void sdxi_process_get(struct sdxi_process *process);
+void sdxi_process_put(struct sdxi_process *process);
+int sdxi_process_bind(struct sdxi_process *process);
+struct iommu_sva *
+sdxi_process_detach_sva_locked(struct sdxi_process *process, u32 *pasid);
+void sdxi_process_unbind_sva(struct sdxi_process *process,
+			     struct iommu_sva *sva, u32 pasid);
+
+#endif /* DMA_SDXI_PROCESS_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index fa6c3ef1c58f..c000542b5ce9 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -113,6 +113,7 @@ struct sdxi_dev {
 	struct mutex admin_lock;		/* admin submission serialization */
 	bool admin_dead;
 	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
+	u32 mmap_gen;
 
 	bool has_mailbox;
 
@@ -160,6 +161,7 @@ static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int nr)
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
 void sdxi_unregister(struct device *dev);
 void sdxi_dev_force_quiesce(struct sdxi_dev *sdxi);
+void sdxi_dev_fail(struct sdxi_dev *sdxi);
 
 static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
 {
-- 
2.56.1

