Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892574;
	b=M3w3Ov+liOAX1ZnAr2RCkZIVmxgzcdv4u8w8bkRRylCUcHge5fCdGSW999zxzN1LAAYq
	 Xw/vyHlPef5wpqdDp0BAYsRuINPYwwHghZauOXWGTFJi54p/cm9kJ8PUzInfSKQE5e9xy
	 xVJPMNMA4qx6IC3rXanoFe29s87rEFtkiIL7daxuT6lMQYsxk5apwnpzoGWSzyvklaqqT
	 qPY3CIc4OgwjzhUACsh3S/OdDXo6UgvZMlmqZLxdwMdvTDOdH7iuwqwQtqUr4Ls1szSAk
	 90GgwHq1XRgHtex4zZceGwEGz1zWVTxjqjG0c2xW9wN9y0j4ETGfBofr8lpbBM2siTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892574;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
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
	bh=tUIWaGJZNXIuCt/zYRYjGwKAmUHwt326aPwOTd/fdCI=;
	b=MphzhtsYw0Rx2NUcSqznSUSaqPAlXR9FtikleFnAGZi4zXZ+afCPrI21Ked4aiY42Nqf
	 T86p1XcyKDBmJzYF0juBNx41msV3vXiXppt1KJ+savXvbWsqrf7O7WNrOSDmUaUcy0XjD
	 E4g1y443HK3+Gtv6AvMIfEbgaiFB7Q1O17kfnilYPkne+xI5pVFcxK/Hctfc7DcBt+Edn
	 +2GfiYpbzMT3BRk6tajMxyOyvTHhTF6CmO/VQWvlSZnaQ32Is01HsWLsAsY4QZPHC4R0B
	 xDdROP0uZugMwoNEXk+641MbO2TMpxgKaDNdGRAqaIc3wjEKS742rEeSQe/DTPVlYMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sviS7NVX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.16
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAC606A31B;
	Thu,  5 Nov 2026 15:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FAC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sviS7NVX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp310NiTe9jb+WqLJtXYNbs+LQjkctSTBrHQIzVFMkwswzrr29DlBpLIqNUMr+GCirqPHtTFDO+jDyn51JS/h8dRsRocIAJgQJ5QLeE52ahb0EbSj8na0Q3j8H6JjJGNdPcWZvEzKhpL78k+cyiDosGjn+493KtG9Bao/hb66AkiqNogWcZPak2epcAcsuseFNnJs3iTYcsh4HAA4tJ/2jHvrlp6M8X2cGvqxFA+unvB0muSNq2BbgUpYaiXs3kvGhjRr9egg9ZwwB16J1iODW2bQhI8pOsgQkiOGaEbObfl4MR2JSS5dTbwBHi6BkylKJClpAdhPMHIrC9PgQyCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUIWaGJZNXIuCt/zYRYjGwKAmUHwt326aPwOTd/fdCI=;
 b=dlHAI3L30SnRgeb7cNF1joTJA58+Yqfl96t063T4mUw+UNuVKJno+d88qMqL8GiYgWoU+RRxPxjF5Sy6UQXzaiiUo7E8I/dTGvaXdg25eUWW4LGmh5jSXI6faCj/DkeAm/9Di2hQCgBiWh5YH+QE7dYz6XqiZftoRcyow9jMUDrJ4w5xEVSWE6Bq1qCuMGmzfB/v/L35hiDRIX7f0qFR7PtmT5xnSc4hS/xOSxuPnJMLkDwLfPHRcjdQ/bzSoGrxwnuBf/CLQ9txGQfcMCkZftcSphPmLkno2TUUmhqbrFX34j9jcqyfd8/DugBJtJ3stfmVVoZuoKwcxvD3wUdseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUIWaGJZNXIuCt/zYRYjGwKAmUHwt326aPwOTd/fdCI=;
 b=sviS7NVXpwelmiMBXoBB+uGUOJd8Ied1F5ILvj34EYy8R7M0Tf/ll6KL6UBJscywl7+1F1XHon0TD4GfzdcOh2jUPOsjvFjba3CwBw3FhO6soNJm8Ds+qMNTRbIaY39/Hy4WKlJIhG9zpBpZqamstJ+cAuGbnIPfQBvA+BCHrvWABscaPMQz6Z/Qxsq+qhSUZ4KBxJa0Pgu28WeI358slwXBD6qY1/C/i1clZAmKe/xKhTSAVTWS4h8rBDt2kta1sht1atpPRFzp5lM7zxVI2aMFKQen+xd9N7HaivWA8lFhxze2AnmCrQNTdctoPU2ESrhfL+hHBkR4OiFCAErlVg==
Received: from CH2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:610:55::30)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 15:29:26 +0000
Received: from CH2PEPF000166C5.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::4f) by CH2PR18CA0050.outlook.office365.com
 (2603:10b6:610:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:29:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF000166C5.mail.protection.outlook.com (10.167.244.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:29:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 07:29:10 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:29:10 -0800
Received: from localhost (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 07:29:10 -0800
From: Ankit Agrawal <ankita@nvidia.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <jgg@nvidia.com>,
	<aneesh.kumar@kernel.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <smadhavan@nvidia.com>, <ankita@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<terry.bowman@amd.com>, <nik.borisov@suse.com>, <brads@mainlining.org>,
	<lukas@wunner.de>, <rrichter@amd.com>, <gourry@gourry.net>
Subject: [RFC PATCH v2 1/5] PCI/TSM: Create MMIO descriptors via TDISP Report
Date: Thu, 5 Nov 2026 15:29:05 +0000
Message-ID: <20261105152909.53452-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105152909.53452-1-ankita@nvidia.com>
References: <20261105152909.53452-1-ankita@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C5:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 42734fd9-5d8a-4e4e-2d12-08df3b519389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|11063799006|261021121427099003|56012099006|261009223027099003|261022105027099003|261022075727099003|261102130727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Gpwvvkq8fwF1xtAZFvqJ9TSxaxXy5RAJTNdQDpymrgUiWKNlFKkeg1jqviSMNcjJrx5CkIFXxMoSNKDyrQYeNGtWedPJdREWK8PXWgr5V2+5UNxzmsguXP6ReqJxJETLrPuu3zfvbJaT69p0mA/amUYXlNCZbpFNsAG1xxiVhExUZtyXGeXAlSqeSdHuiO6yAQZX6diPwuK738vo9xGahfKsPM/qwZXIONZl/h3EKTCt5XmYNJsUwHUHahYkiSsFGHdjA+9Fbui6+Qt5da0/F5vP2J1uBpH9vEmfErAamTjVQ889QlWzID8LNNO+TUmPKd7UIHl67LEaKnrv/IU499iqBKxdmvA3R8pz+FUPJzc98pBpoPFchppQaeDJd8rzUyom2cHDlqTRX4KFYkWDeJP1X4mHc5fMpeHzx2mIdr/2htPmDherfgmCThyhZR9eXsvccdAHN0Nk7RWalp8L242MzHFcXQsuqSYX5WWf8PJfcy52cLtfr1MP+B3QF+9ZvjbQrIIW0crBp6aRjPfP1NgIHZzpkM8NvRlicbKCnOWfhR+rwXHRcv48QShC8+Jn4xLt37fGZfDzdBIUFuNkeybgM1c5sENnJpK+udHw/t+0aR/P32JzYpclE7nPGxJMQuWl4+OrDutx7MmJdOOh8ji58eftGA0Ck8xt5lTbtP7IA6KZFEchErBQDBf0UdPnpXTvSSajVKX3eg11yPFNUQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261102130727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NfN3N2q8RNaFoJ2qcZRdwnZZf0kcvTRdJMs5/rNgeD+vgGz6iqUQnh74qTqfuGmMOzefzix1nCwugFzS/kQe6elG5X0IPw+2DXPZwPc8yFZYXNfHwdaUrLyZz6GbYb3o6Moq0GBefgfPB0vZ3M3TOwQcJ5xdeuUGMzG7rtV7DOva1/TGYobwZSPZPguH0Piv2Mz2755ongklywxCK/Sj3jLOT1QQUgEa5jPowbBA35OYK3emaw4scL7UWy0wYauE6Cpk4+WNS/0LdUtEMAXfrBxGRQ0RKGg9M8kxnM10mlXW05ZFkXIeTTG2WW8o0dXfF/YBN+YzrQjmtyfPukdNhl3wVh150wxZIZRgBpQMTpjY7koL9gk3P6yUpku9SlG4OALUQ46hDSna315qJ2MLlD4zwIKo6gmXxx579LdcbI6bowPbGPdPorino2a99PTE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:29:26.2058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42734fd9-5d8a-4e4e-2d12-08df3b519389
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

After pci_tsm_bind() and pci_tsm_lock() the low level TSM driver is
expected to populate the TDISP GET_DEVICE_INTERFACE_REPORT response
payload for the device.

Add pci_tsm_mmio_alloc()/pci_tsm_mmio_free() to parse that report into
a set of encrypted MMIO ranges, and pci_tsm_mmio_setup()/
pci_tsm_mmio_teardown() to mark those ranges as encrypted in iomem via
a new encrypted_iomem_resource tree (IORES_DESC_ENCRYPTED). With those
descriptors the TSM driver can use pci_tsm_mmio_setup() to inform
ioremap() how to map the device per the device expectations. The VM
is expected to validate the interface with the relying party before
accepting the device for operation.

pci_tsm_mmio_alloc() also recovers the obfuscated starting address for
each encrypted MMIO range, since the VM is never disclosed the HPA
that correlates to the GPA of the device's MMIO. The obfuscated
address is BAR aligned.

BAR alignment is not mandated by the PCI TDISP specification. So this
relies on the TSM implementation: the MMIO reporting offset (MRO) it
programs must be a multiple of the largest BAR size so that the
in-BAR offset of a reported range can be recovered as
(reported address % BAR size). Arm CCA specifies this in DEN0137
section A9.6.2 ("This algorithm assumes that the MRO value is a
multiple of the BAR size") and recommends the RMM pick
MRO = x * 2^n with 2^n >= the largest BAR size.

Based on an original patch by Aneesh Kumar K.V [1], and cherry-picked
from Dan Williams' upstream commit [2]. Major functional differences
from Dan's posting is due to the lack of evidence-store infrastructure
yet (device_evidence / DEVICE_EVIDENCE_TYPE_REPORT). The
pci_tsm_mmio_alloc() takes the raw report bytes directly from the caller
instead of pulling them from a device evidence store.

Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/ [1]
Link: https://lore.kernel.org/all/20260705220819.2472765-15-djbw@kernel.org/ [2]

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
 drivers/pci/tsm.c       | 239 ++++++++++++++++++++++++++++++++++++++++
 include/linux/ioport.h  |   2 +
 include/linux/pci-tsm.h |  33 ++++++
 kernel/resource.c       |   8 ++
 4 files changed, 282 insertions(+)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f2e820..d074bfd18d40 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -9,11 +9,16 @@
 #define dev_fmt(fmt) "PCI/TSM: " fmt
 
 #include <linux/bitfield.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
+#include <linux/range.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
+#include <linux/unaligned.h>
 #include <linux/xarray.h>
 #include "pci.h"
 
@@ -898,3 +903,237 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 		       resp, resp_sz);
 }
 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
+
+static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
+{
+	while (nr--) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, nr);
+
+		/*
+		 * Entries past the point where pci_tsm_mmio_setup() stopped
+		 * (or that were never run through setup() at all, e.g. a
+		 * caller that only wants the resolved range from
+		 * pci_tsm_mmio_alloc()) were never insert_resource()'d, so
+		 * res->parent is NULL. remove_resource() dereferences
+		 * res->parent unconditionally.
+		 */
+		if (res->parent)
+			remove_resource(res);
+	}
+}
+
+/**
+ * pci_tsm_mmio_setup() - mark device MMIO as encrypted in iomem
+ * @pdev: device owner of MMIO resources
+ * @mmio: container of an array of resources to mark encrypted
+ *
+ * Return: 0 on success, -EBUSY if a driver is bound to @pdev, -EINVAL if a
+ * range is invalid, outside the device MMIO or cannot be inserted.
+ */
+int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
+{
+	int i;
+
+	device_lock_assert(&pdev->dev);
+	if (pdev->dev.driver)
+		return -EBUSY;
+
+	for (i = 0; i < mmio->nr; i++) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, i);
+		int j;
+
+		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
+			break;
+
+		/* Only require the caller to set the range, init remainder */
+		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
+					     pci_name(pdev), IORESOURCE_MEM,
+					     IORES_DESC_ENCRYPTED);
+
+		for (j = 0; j < PCI_NUM_RESOURCES; j++)
+			if (resource_contains(pci_resource_n(pdev, j), res))
+				break;
+
+		/* Request is outside of device MMIO */
+		if (j >= PCI_NUM_RESOURCES)
+			break;
+
+		if (insert_resource(&encrypted_iomem_resource, res) != 0)
+			break;
+	}
+
+	if (i == mmio->nr)
+		return 0;
+
+	mmio_teardown(mmio, i);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_setup);
+
+void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio)
+{
+	mmio_teardown(mmio, mmio->nr);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
+
+/*
+ * PCIe ECN TEE Device Interface Security Protocol (TDISP)
+ *
+ * Device Interface Report data object layout as defined by PCIe r7.0 section
+ * 11.3.11
+ */
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_TABLE BIT(0)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_PBA BIT(1)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
+
+/* An interface report 'pfn' is 4K in size */
+struct pci_tsm_devif_mmio {
+	__le64 phys;
+	__le32 nr_pfns;
+	__le32 attributes;
+};
+
+struct pci_tsm_devif_report {
+	__le16 interface_info;
+	__le16 reserved;
+	__le16 msi_x_message_control;
+	__le16 lnr_control;
+	__le32 tph_control;
+	__le32 mmio_range_count;
+	struct pci_tsm_devif_mmio mmio[];
+};
+
+/**
+ * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
+ * @pdev: device owner of MMIO ranges
+ * @report: raw TDISP Device Interface Report bytes (PCIe r7.0 section
+ *	    11.3.11), e.g. as returned by GET_DEVICE_INTERFACE_REPORT
+ * @report_len: length of @report in bytes
+ *
+ * Return: the encrypted MMIO range descriptor on success, NULL on failure
+ *
+ * Unlike upstream, @report is supplied directly by the caller rather than
+ * pulled from a device evidence store, which this tree does not yet have.
+ */
+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
+					const void *report, size_t report_len)
+{
+	const struct pci_tsm_devif_report *devif_report = report;
+	u64 reporting_bar_base, last_reporting_end;
+	u32 mmio_range_count;
+	int last_bar = -1;
+	int i;
+
+	if (report_len < sizeof(*devif_report))
+		return NULL;
+
+	mmio_range_count = __le32_to_cpu(devif_report->mmio_range_count);
+
+	/* check that the report is self-consistent on mmio entries */
+	if (report_len < struct_size(devif_report, mmio, mmio_range_count))
+		return NULL;
+
+	/* create pci_tsm_mmio descriptors from the report data */
+	struct pci_tsm_mmio *mmio __free(kfree) =
+		kzalloc_flex(*mmio, mmio, mmio_range_count);
+	if (!mmio)
+		return NULL;
+
+	for (i = 0; i < mmio_range_count; i++) {
+		u64 range_off;
+		struct range range;
+		const struct pci_tsm_devif_mmio *mmio_data = &devif_report->mmio[i];
+		struct pci_tsm_mmio_entry *entry =
+			pci_tsm_mmio_entry(mmio, mmio->nr);
+		u64 tsm_offset = __le64_to_cpu(mmio_data->phys);
+		u64 size = (u64)__le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;
+		u32 attr = __le32_to_cpu(mmio_data->attributes);
+		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
+				    attr);
+
+		if (bar >= PCI_STD_NUM_BARS ||
+		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
+		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
+			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
+			return NULL;
+		}
+
+		if (last_bar > bar) {
+			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
+			return NULL;
+		}
+
+		if (last_bar < bar) {
+			resource_size_t mask = pci_resource_len(pdev, bar) - 1;
+
+			/* Transition to a new bar */
+			last_bar = bar;
+
+			/*
+			 * Determine the obfuscated base of the BAR. BAR
+			 * offsets are never obfuscated.
+			 */
+			reporting_bar_base = tsm_offset & ~mask;
+		} else if (tsm_offset < last_reporting_end) {
+			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
+			return NULL;
+		}
+
+		/* Per spec the tsm_offset never results in overflow / underflow */
+		last_reporting_end = tsm_offset + size;
+		if (last_reporting_end < tsm_offset) {
+			pci_dbg(pdev, "Reporting range overflow\n");
+			return NULL;
+		}
+
+		range_off = tsm_offset - reporting_bar_base;
+		if (pci_resource_len(pdev, bar) < range_off + size) {
+			pci_dbg(pdev, "Reporting range larger than BAR size\n");
+			return NULL;
+		}
+
+		range.start = pci_resource_start(pdev, bar) + range_off;
+		range.end = range.start + size - 1;
+
+		/* Only record the TEE ranges for later consideration by ioremap() */
+		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
+			      attr)) {
+			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
+				bar, &range);
+			continue;
+		}
+
+		entry->res.start = range.start;
+		entry->res.end = range.end;
+		entry->res.flags = IORESOURCE_MEM;
+		entry->tsm_offset = tsm_offset;
+		mmio->nr++;
+	}
+
+	return_ptr(mmio);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_alloc);
+
+/**
+ * pci_tsm_mmio_free() - free a pci_tsm_mmio instance
+ * @pdev: device owner of MMIO ranges
+ * @mmio: instance to free
+ *
+ * Return: 0 if @mmio was idle on entry, -EBUSY otherwise
+ */
+int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
+{
+	for (int i = 0; i < mmio->nr; i++) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, i);
+
+		if (dev_WARN_ONCE(&pdev->dev, resource_assigned(res),
+				  "MMIO resource still assigned %pr\n", res))
+			return -EBUSY;
+	}
+	kfree(mmio);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_free);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index f7930b3dfd0a..122f1eefb4b9 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -144,6 +144,7 @@ enum {
 	IORES_DESC_RESERVED			= 7,
 	IORES_DESC_SOFT_RESERVED		= 8,
 	IORES_DESC_CXL				= 9,
+	IORES_DESC_ENCRYPTED			= 10,
 };
 
 /*
@@ -240,6 +241,7 @@ struct resource_constraint {
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 extern struct resource soft_reserve_resource;
+extern struct resource encrypted_iomem_resource;
 
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a6435aba03f9..e54ad057fa8e 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -199,6 +199,34 @@ enum pci_tsm_req_scope {
 	PCI_TSM_REQ_DEBUG_WRITE = 3,
 };
 
+/**
+ * struct pci_tsm_mmio_entry - an encrypted MMIO range
+ * @res: MMIO address range (typically Guest Physical Address, GPA)
+ * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
+ *		Translates report addresses to GPA.
+ */
+struct pci_tsm_mmio_entry {
+	struct resource res;
+	u64 tsm_offset;
+};
+
+struct pci_tsm_mmio {
+	int nr;
+	struct pci_tsm_mmio_entry mmio[];
+};
+
+static inline struct pci_tsm_mmio_entry *
+pci_tsm_mmio_entry(struct pci_tsm_mmio *mmio, int idx)
+{
+	return &mmio->mmio[idx];
+}
+
+static inline struct resource *pci_tsm_mmio_resource(struct pci_tsm_mmio *mmio,
+						     int idx)
+{
+	return &mmio->mmio[idx].res;
+}
+
 #ifdef CONFIG_PCI_TSM
 int pci_tsm_register(struct tsm_dev *tsm_dev);
 void pci_tsm_unregister(struct tsm_dev *tsm_dev);
@@ -216,6 +244,11 @@ void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code);
+int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
+void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio);
+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
+					const void *report, size_t report_len);
+int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
diff --git a/kernel/resource.c b/kernel/resource.c
index 0c315c917fbb..7bdf3c2ac141 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -56,6 +56,14 @@ struct resource soft_reserve_resource = {
 	.flags	= IORESOURCE_MEM,
 };
 
+struct resource encrypted_iomem_resource = {
+	.name	= "Encrypted MMIO",
+	.start	= 0,
+	.end	= -1,
+	.desc	= IORES_DESC_ENCRYPTED,
+	.flags	= IORESOURCE_MEM,
+};
+
 static DEFINE_RWLOCK(resource_lock);
 
 /*
-- 
2.53.0

