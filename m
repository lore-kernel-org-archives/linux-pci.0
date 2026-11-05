Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892575;
	b=GBWjnZXaSVsR3ZuxKZ+NPgFi0aNRCSKf4IIoljLA+/APjpxM9KVG9rx6SZbuNNygV4vt
	 qUO3ALubY5KSGjd2EkCJ+d0ZhUTpa0K+TNEEGWZKwpJN2UqChES4x4C8xJkP56n0Ddxsg
	 Hn/77QlhbZZCJpCBxJj18r0HA31DjsmviMUx+XPLJ0CXmMaIX8CXlvZ9D9rPIX1DxqkdD
	 neQiamRVLhDbPvamG723g6ByvxnZS5zgi+i9qjqwNAXu5vwHHXuxkyPNe0512nAaCbDwK
	 /USY0iMcARC8mZmIdMAq0WN1PyI21pOgV5/bDJpq1tPT67Dbfe37V9OBT3Zl2oGKbYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892575;
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
	bh=9y/2T4GXiMuoIGXBnH0sF+xfvcylJA7OcmvISnBbdi8=;
	b=LKo4T0s6zDQNKDKVlzu571Cle+26G0DvvvF+sPwz+aHpiLF/m9sZlYnlVVwJdBO9vtcj
	 j+QznncFhx1e021vr05785ncLHMtYNZlVFEZTpIVVzm9wRNlsQLa/MPDqUFCKqNkgP53g
	 fnmmgdmgpdaB3BQ+6jztv3+hr8v60azRrXqD4D54RMH9/Nz/RNAIoUZ+CH+uqWIa0kkMN
	 3rpyTqjeVr8yOJ2jAkIX1lDsIrbswkjOP52qgAzKJ1pg9DburR9LaBE0FwdWLEc65TlXF
	 Yf5ICshWwNRXTm9GsagQbzUgLKV1o90aOMaw0LBNfEHwVfz+3r9OBi8cTg8Sfy98lcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FCf+twgo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.11
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A416606A328;
	Thu,  5 Nov 2026 15:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A416606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FCf+twgo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/9XJkPqENdaNRlaWbi3ThVbrzltLXQXTuFlpqZdioyJLviIqzLPR1K5NNVNah4sdZSm6sOMp92M4iRIQvdsotvD5WeY0Pwt0rbfkDnk7FcclzVKTfYV8X7gkal0OAeVi9ABgTfDrEDcms5dEOUuWlREkvLxdKlf91XO6hHa5a4ZY5/e6Vt0Lsbx0qeKUV4vOJX/PBr1dk5NY97LKk2mp319IKybxymrNvATYCBzMHiGl97totkZ4o6qR6V4FTCRJnqQDuOSXjEoz7MGTKrvds+ouublj8LqUo6Yf8vGTB7egY10I2fmH4bIeA2B8NVHRsLvewu/g5XRNZEmLeUclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y/2T4GXiMuoIGXBnH0sF+xfvcylJA7OcmvISnBbdi8=;
 b=uBkrI0OkDxq6v/FxUBh1sbwvQsMlvzVvGAkjYxeQtueL26X9GsBsnPZRdAmvsjsyQ8017EdZE9Z74vdsBWVJtvuVQOr79izxgyC8JPovxoli0qx374UQrIYPkXsbmcULc/r1VN/jLeOuvIeniNqLB1Mw3vb97+zZeGNQnBDoV+8xbIUbXhDFjEoJnlBBRA3eFe2xiCD/b5+lkuPBpA+69mn6KnP8A2DnPnzTgmk5zgFBM3X6OUGv7TP5jcHPRTg7EiXcfgXRIsz/9szHzM03AwG87cwzBGNY1MMzBumrx09t4POuw5h3Lg9wlHHmMoHuWxWfTINkLRa3MRUX9PPSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y/2T4GXiMuoIGXBnH0sF+xfvcylJA7OcmvISnBbdi8=;
 b=FCf+twgoRLBcv8uy0AEjVZrH7tAsww/uOa2QhJw78O2WF6+TCs21nhdTS4yF3Egjb4rYNdCLCI+dURT+sQVESirtKruYQcrnD6tFr2iVZcdQIGA5zn7XQAfVJsaNCZD8fTMGjPoNN+WGpzd4EeJIPx7kiERmMZI7tQHuHalMrXBsw34Wuhj1+7cVqu8iinBKuieQrlWq9CGA3CjALDonrcIlQATfLOlrEzU4y882JHXkR3juDgtO7Bv9lIbVATKUU4dL5szX55v7/z1/20iBIgH2/v8DiVtphCIErWLfolGWWUHrI1SI08HfColcPXPSckAjx2BcZBUp+EUjpM56Xg==
Received: from CH0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:610:119::29)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:29:27 +0000
Received: from CH2PEPF000166C3.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::5) by CH0PR03CA0386.outlook.office365.com
 (2603:10b6:610:119::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:29:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF000166C3.mail.protection.outlook.com (10.167.244.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:29:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 07:29:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:29:11 -0800
Received: from localhost (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 07:29:11 -0800
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
Subject: [RFC PATCH v2 4/5] PCI/TSM: Support multiple coherent ranges via coh_idx
Date: Thu, 5 Nov 2026 15:29:08 +0000
Message-ID: <20261105152909.53452-5-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C3:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0ec4dc-bbd5-42b4-5f3e-08df3b51941e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|82310400026|36860700016|261026140227099003|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261102130727099003|261022105027099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RpWf9JGenjwmZ85DyzSnJmS9RO9zMD40f2SyqH7yp9wO8cQJ3kqP67MWOozC78PhsqOwB2z1GsTum7j6ZV6pGxyRc/qVIVabMM8BzVtXANvnNXpAmiwsZGcW82BsnHnrnePCvfR9oWQEzfNV3tDKwAo7wTZZxiYgtJgL+it0b/c2VJ2VryXCnSaJB/GYlJt9YUrJ52KBEKalTA2bviF4HlkdLFvKXGoX/vPX7ZynnJPzIlJEyqE9+ZY+wc7+wd+dWeFYV4eTQO5P1zVW0p9yTVBiCjuslCBMuqRSNmCtvJxpB+uHvg3gtqibvEi6WiAF/8RFrubh74SyhKx8u/VOj00ihXHBuWKrnKPHkSh6wqaPllY+R0tXl2+caQakYveXOfmMZQksXqpe/jUb6IO+9kid0YvFFnFtRUjJTf9wb7GPOVfQl2OSkTYNO9UiQIXEANdwWbLzFBDEFG6UJg8YYKagjRyyV1kWgIIKTd/c2LNCTiPT6gLxKLmvniEwL4IQKp0+k3hU/jSW1HsZynSTK4BpDMGTn39HOL6j6KeN6Aof/9CidMDwuhXHAMTTAX5pOJVGxGLIC9JCDH938HHLM1XKlp1uBRx4e0VYe/jKJxdYW+IEbWRm9b/zpBMzJ4t7rpUm4o5gyxpBvfeYV+CRH4E3/Eltd8oZzjraxqwY6AHTTN4G/tnPCE9vv4lBfkKS9kBy0BDd0MtaL5Bv2yhRwg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261026140227099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261102130727099003)(261022105027099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XaA2M3sMMna2eWildT2s5nCIeDcqaq23QvYP2bUWt5yunynlERRvWH8s0ywbaS7yOs/D7Y4anAA5WeokBM7VeMr/+jcdEl4B/SQWbzY9PqTcsImuyp8BZIFAlMAp8YeOt9YcVjDXZaIzCb+nmNbSM8Hhqw83IdTw25DJdzC21I1iEE4ZeLWNx0xg00XOkVY5TaersHTQOIPTYCWN+legxKxk4m10Ix5mu7tEjNQxyVWtlrSNuNyXnro13A9T+Df+Im+DtDPYf8gVRYlRuD2EvPTM18BIMOpdVyTikkqr3oMMwnRHaBWq0C4kvKD8OgKUaWCasYBC91RUDVnQiO2P74JRBO96tewuwxpka17FSu4oDT8EdJZYZUfxp9R3CN1SS+mJ0v5HqTOKqNDON/gcLhOs84MhOsIcqJ5jXJB5uQ5b0TUHBt7Dv/hUaKyCsbDE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:29:27.1774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0ec4dc-bbd5-42b4-5f3e-08df3b51941e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477

Devices with multiple decoders can report more than one coherent
window in a single interface report. Generalize the single
0xffff sentinel into a small id space:
PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_TO_COH_IDX() treats any range id in
the top PCI_CXL_MAX_COHERENT_RANGES values (counting down from ~0) as
a coherent range index coh_idx. This keeps id 0xffff (~0) backward
compatible with the single-range case (coh_idx 0) while allowing ~1,
~2, and so on for additional windows.

Only id 0xffff (~0) is spec-defined: Arm RME System Architecture
(DEN0129) section B2.3.5.2 reserves range ID 0xFFFF for a device's
region range. ~1, ~2, and so on are this tree's own extension of that
idea, invented to cover multi-range reporting.

Use coh_idx through pci_tsm_retrieve_coherent_range() to select the coh_idx
entry of pdev->coh_resource[], the precommitted-decoder snapshot and
relax pci_tsm_mmio_alloc() to accept more than one coherent region.
The coherent-range entries follow all BAR entries in the report
and allow multiple trailing coherent ranges.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/pci/tsm.c       | 36 ++++++++++++++++++++++++------------
 include/linux/pci-tsm.h | 34 +++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index bc3218c58ff0..a2a25bafc93e 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -1004,7 +1004,14 @@ EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
-#define PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT 0xffff
+
+/*
+ * Only id ~0 (0xffff) is spec-defined (Arm RME DEN0129 section B2.3.5.2);
+ * ~1, ~2, etc. extend it for multi-range reporting: id ~N selects coherent
+ * window N, keeping coherent ids disjoint from BAR ids
+ * (0..PCI_STD_NUM_BARS-1) without a separate flag.
+ */
+#define PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_TO_COH_IDX(id) ((u16)~(id))
 
 /* An interface report 'pfn' is 4K in size */
 struct pci_tsm_devif_mmio {
@@ -1042,6 +1049,7 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 	u64 reporting_bar_base, last_reporting_end;
 	u32 mmio_range_count;
 	int last_bar = -1;
+	bool seen_coherent = false;
 	int i;
 
 	if (report_len < sizeof(*devif_report))
@@ -1071,28 +1079,32 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		u32 attr = __le32_to_cpu(mmio_data->attributes);
 		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
 				    attr);
-		bool coherent =
-			bar == PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT;
+		unsigned int coh_idx =
+			PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_TO_COH_IDX(bar);
+		bool coherent = coh_idx < PCI_CXL_MAX_COHERENT_RANGES;
 
 		if (coherent) {
-			if (i != mmio_range_count - 1) {
-				pci_dbg(pdev, "Coherent reporting range is not last\n");
-				return NULL;
-			}
+			seen_coherent = true;
 
 			/*
-			 * No BAR names the coherent range, so fail closed if
-			 * neither a CXL region nor a committed HDM decoder
-			 * resolves its address.
+			 * Fail closed if pdev->coh_resource[coh_idx] isn't
+			 * populated: nothing else in the report identifies
+			 * the window's address.
 			 */
-			if (pci_tsm_retrieve_coherent_range(pdev, &window)) {
-				pci_dbg(pdev, "No CXL region or committed HDM decoder for coherent reporting range\n");
+			if (pci_tsm_retrieve_coherent_range(pdev, coh_idx, &window)) {
+				pci_dbg(pdev, "No populated coh_resource[] entry for coherent range %u\n",
+					coh_idx);
 				return NULL;
 			}
 
 			reporting_bar_base = tsm_offset &
 					     ~((u64)range_len(&window) - 1);
 		} else {
+			if (seen_coherent) {
+				pci_dbg(pdev, "BAR reporting range follows a coherent range\n");
+				return NULL;
+			}
+
 			if (bar >= PCI_STD_NUM_BARS ||
 			    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
 			    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 7c29f10e7795..ef4edf3efaf3 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -261,32 +261,35 @@ static inline bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
 }
 
 /*
- * pci_tsm_retrieve_coherent_range() - resolve the device's coherent CXL window
+ * pci_tsm_retrieve_coherent_range() - resolve the device coherent CXL window
  * @pdev: device owner of the reported ranges
+ * @coh_idx: which coherent range to resolve, per
+ *	     %PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_TO_COH_IDX()
  * @out: host physical (guest IPA) range of the coherent window
  *
- * The coherent range carries no BAR number, so its address comes from
- * pdev->coh_resource[], a pre-driver-bind snapshot of committed CXL HDM
- * decoders.
+ * Each @coh_idx names one of the device coherent (CXL) windows. It carries
+ * no BAR number and so its address comes from pdev->coh_resource[@coh_idx],
+ * which is a snapshot of committed CXL HDM decoders regions.
  *
- * Return: 0 with *@out set from the first populated entry, or -ENODEV if no
- * entry is populated.
+ * Return: 0 with *@out set, or -ENODEV if @coh_idx is out
+ * of range or has no populated coh_resource[] entry.
  */
 static inline int pci_tsm_retrieve_coherent_range(struct pci_dev *pdev,
+						  unsigned int coh_idx,
 						  struct range *out)
 {
-	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
-		struct resource *res = &pdev->coh_resource[i];
+	struct resource *res;
 
-		if (resource_type(res) != IORESOURCE_MEM)
-			continue;
+	if (coh_idx >= PCI_CXL_MAX_COHERENT_RANGES)
+		return -ENODEV;
 
-		out->start = res->start;
-		out->end = res->end;
-		return 0;
-	}
+	res = &pdev->coh_resource[coh_idx];
+	if (resource_type(res) != IORESOURCE_MEM)
+		return -ENODEV;
 
-	return -ENODEV;
+	out->start = res->start;
+	out->end = res->end;
+	return 0;
 }
 #else
 static inline bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
@@ -296,6 +299,7 @@ static inline bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
 }
 
 static inline int pci_tsm_retrieve_coherent_range(struct pci_dev *pdev,
+						  unsigned int coh_idx,
 						  struct range *out)
 {
 	return -ENODEV;
-- 
2.53.0

