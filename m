Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020114.outbound.protection.outlook.com [52.101.229.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C4374170;
	Fri, 27 Mar 2026 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583681; cv=fail; b=CrOqQeAFWz5cioOaiuEwPx/k4Wd2DHaXtVo/gMN9rQy8CdyyhAIsQTZ8beqO41CPOzvObmojmleCvCxhKWH3WF4CtNBCuIzlJYTRVdeFRA7YqvU8PADUDgPFEJhkk1R4TYdUvEqC2XIDe30y4B/ez41GGZGsMzulW4OrhyG1Jis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583681; c=relaxed/simple;
	bh=sgRjIYZasZJZC6aHGGTqAQ1lBQJuj5jFMHNuey/EsmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYoeDRhYMJ4bchEAUa6L0mFco8LTU6MahfiG/fwpNG/EEWx67tI9WLejVJhejTa5AH+ANBye2iqdD6sAX5qQkdlJh0pijFZD61bpcKsdTI0iskmvuGjpdEPRP7BFEdXNfVglTsmUmu/n9ezt2RS2g17QwZbcqq9zxgtfnDWR6dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZK6KhayX; arc=fail smtp.client-ip=52.101.229.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZK6KhayX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLy6OVYBR2193vzql7+9gLUWGS7jMLSWGqyEpxrS3FzxgPMDi+mg91RrKZ24dUobLsR40YoQwFeUO4ZYtrVi1A+l2nr8WkrI//5Cz7+kH8ACik3m2uCYrdpvajx5xrv9mRUtpHWieMwNP7JK5btZC5nYBlP916KBy1Elw7NMFIJjP3ldwCYHC9DwwkXxlRXTiWdpSKlReYx83lY+SxZ/F0LGnExuziyGFgdSl3/wtkjcuvPtZNqYwvWL7Lz0NFz3R2vpuzGABBAdeTC2rNDpOQf4kcr66QcqL3P99Cuyh4QyVwMyO1w4wnntY53V+uTbfVFGLivf6zaU0pPIJ/A44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b35G/jLYtQSzKulf5UWuDqd43jYQoJdbINzQbTRfmH4=;
 b=L/s/865EWkBGPNyKR1B/1aQG8uvqLF1XsIrROImp6evlTOr7pMoOvCTl+TuJ012JR1KViSqYVelsez/0cOyM8mxq7ZuTtXRDEFz9HIKM4L5/OffLuGYsdJJsED7nzu9lplmQhVdxq7cnnlkk7eG+XN+GWGMNvIzw25OI9BvYVfRdf2GyNwHtAn+3ZV7dgZu2CPKH/u7s24oojMrBHrPJRPJaZOheCs6BqjeOZfTIiq5vX0iDBfg00X+21d62ryG3Etfs7xfr6gx+Y9RgLWD3tRHPE4T6bgfekEHqU0RQievZSGajJWMA2zsz5G8qksPZePkzQyYetXe3Ox47hqCrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b35G/jLYtQSzKulf5UWuDqd43jYQoJdbINzQbTRfmH4=;
 b=ZK6KhayXZ69GoXwK9a/7e/OWQRscM1ttJXCUjcI86TPc/d1ufSFEbX9w3LERGNwGdo9DEBr7jIEIHzZX15hBBO3rkyEaPMBIShquG9/OZ2aMyZO5ZuGdy3ZwRj/wHXcRGjIUS/RF6lED+PSyicYw56HjGJiuEE+LgmpGufacTfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:54:30 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 03:54:30 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v12 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
Date: Fri, 27 Mar 2026 12:54:20 +0900
Message-ID: <20260327035422.4020455-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327035422.4020455-1-den@valinux.co.jp>
References: <20260327035422.4020455-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: dacf073e-86f4-45ee-9c0c-08de8bb48bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7PskOe0MMRy+I0zA1uDcwBbhg3eU0IEghUsUnztW+w+k3Y0Dx3g0OAtd2BDCf66Pp6g7stbQ1uOMbg+KzzT35LZz/fBJtHkaSoTJcrQTdPHXBxhXVYUhPOahk0BdmDEVW491pZa+aOvYJjWe5L5loGQtseDKPJl13aSvmizLTyp9W5SUB6eFebFaYyZcYTMq0n7MD5DWNv+VOCUeNI7c+DVmC+RE987jKs40/WkDQhMyYDI86YvenRpeziW9y/8IUxFFy851AYMUlafXdScnCGlznEylSr4YRYIaM9AAACIPLM/j3RPrm74o5RclryffMs+cZimyWBftxSj0w3f3fCo20EU0zcX8CzxmlzYhqOUcXvary1BUPVimf0eMaCfddJdBw5fyGsdVourXj9GmniKBbkcLu/JNJrmuPBzyqUnpr7VH0/4ZtKcdfdcmi5LYukqBQgH995wZHsmurTzP7uiVBGwDqRQIK3EbhS6Kb0X7DiWtlL/uyedhn46U1Y3XAU2mNBTshKEhWOm/hQ3i+mOkl4o4mmzWq28quKTg6GozM/HExeeFZAAnXpCF5v86XgT3VT9g4UP47iSbIMCd6sClCjJ2omPuK6CajCtgdKHoWBk/0lkNF0/o4qNGKf3F4OAS6T+C8GOQeOSmTxWxQ3rayiDRWXrPY89jab5/3HgAyEtOSxcwXSnW/hsKC5r8Ib1SRfHk7APfBqQ//7ZNijR5lrd7dC9iZygqO555U2m+8Tud+XFGZzPklCBmZ1KnM9WF539ta5tF6yosi0BbZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alJH1FOrzhVxCCUE6x12GtSE94+bTAFLD+HosqegBgyPJrHdOjvquyj5sVkm?=
 =?us-ascii?Q?MiQuZ/0MfAvCLRjl/6ye35DDwFGuypZWKVNxM3utTdatgPy54WFC3CjaL9WH?=
 =?us-ascii?Q?FS2IE9vXcHMsAAQJKPZWlq0sYbkQnoeIIn7nXwK7nkvnH+cMmRIMz2cGOn6y?=
 =?us-ascii?Q?f1rUBwCcoxcfPuFXVOqivwNkq3Lw7s/GWs1mSuBZRfOcFUeNd3UJR1Bmi7X7?=
 =?us-ascii?Q?CC4uldFr1CO6f72LR9thMqeUvXijiZArJAIuOZVOITr/8sDAKvND7N5T0qSg?=
 =?us-ascii?Q?3rhj3JSCl86Sd7Pr4v/it7WeZBI7Wd5r6ZgN89hiDdgafRwxup7teev9JVke?=
 =?us-ascii?Q?KT2DS4kE/Ub6unpEHWy3VTFCmn+O0GSm7WlbV4bJA7OSKk1QMKAe65eF1cpg?=
 =?us-ascii?Q?ryi2oydx3nETyLGBPexLIQRw5dM5r2UXu4KrNPGQ+H1rrOqucuQVZqLGHTsA?=
 =?us-ascii?Q?YRbtSS6gyTkFKmtnndJRO8/qSvq0sgKxVMLs5kKoGuxyktt0z5lD4gH0+hgr?=
 =?us-ascii?Q?R9rzDF8BeW6q1mRqLKVW3KcyVaRlocnFbaytkIe9mf5wDrliJKlIpUKegMVh?=
 =?us-ascii?Q?ZaHdHrsL3zjtJKE8bLWr/59ol14IVjDRda7uaiwA7ZWgX3qPYmlWurARvDeS?=
 =?us-ascii?Q?Rg8jWsyvUoGQ0ubjDM/1iviDzasi1SV1ihMNS5S6YdNmRU2YvwlscasEcc84?=
 =?us-ascii?Q?ZCKOPi8akjSBXwC7HrMDpS2Bfd/F5yefedhMi0RsHneagjaIUfzIfPggROq5?=
 =?us-ascii?Q?k/fhKAaCuMrfgfLpwQ+ci9NBhGUzCo2z5KDxewEOTEmYGoVSjlumfIqEzZeC?=
 =?us-ascii?Q?Qde1+VTaiBXgwz1ANuzsGkYzA6sbLxmM/ppKG1EKpLsm69k5hjk6H8FPEOCO?=
 =?us-ascii?Q?MxkkuWWL2ql0RXRYcIxcf+8LVU1UBOKlrOQUp0g6oOY5ALy4rpBY8c5FuVFn?=
 =?us-ascii?Q?3n/AeZUCSaeadxhm6FDzpZ7PnpJGRt/J1EBPSb7LTci9FF4sJ969nkKMaKvr?=
 =?us-ascii?Q?ktUTIe8mLIfMH429rzbFlt/v55hfSA3qBG7/9eCiNQPv9tA20MYwuQlYwgUT?=
 =?us-ascii?Q?gpridXvtH0XZ1z/QbFqaYCB1NTEOdpE+TiAffR+M/Z3dJy0z3AevqgjFum6s?=
 =?us-ascii?Q?xyoyPkSo5/aZqPc0QvZbAiPAhOkivp49aqMkpCo4NseKJXAR5S75wPj+VOCT?=
 =?us-ascii?Q?l9GvC9IQ+HslhqmCZfvstVqlsgqNmTj3AuO8PPVuyvjuOBsqB9BVSw14JiEU?=
 =?us-ascii?Q?vuhPFOnlMNCKB59VFkIm8ONT+eIIr5wTjGEvc9daqZw0u9zUqoU2flZhsYw1?=
 =?us-ascii?Q?g1jK82brwo4DYMUeDSVhKFexQJTCEj1PFBsO6hqw5BvX8B2kVtDDnN5yvjcA?=
 =?us-ascii?Q?MiWxO9dErxHtA60auMXum0PUoFCjE1Yvou+XbL96x9qeZuK4WauU6Ucw+w63?=
 =?us-ascii?Q?gXzQYNr6Ybjkes2jlpxBiOCT5Ns0zsjDDMiI1ZKCESo6nu92/sqLpN3rdXnX?=
 =?us-ascii?Q?olNo0fv1rkIq1NIWj3jZ96OKO7dblVM/Ts/n20hNZWHm4C/Don5ZDQM+WPK3?=
 =?us-ascii?Q?V6RhoLgQ7vHICctWCpIj65fPJXuMJ3ZPRppr2HQTffzbLr3o5FUrsOjscnhi?=
 =?us-ascii?Q?IJTraELXqrIeyTjza4QI3GGMGHospLyYO8F927IlF+YjTrxQHg3qoax2bkdM?=
 =?us-ascii?Q?GU/n0ptw1z6nxlEQP7VjGPGpm738eQoGC7tHV8yLh0ZZ1By+XCCgg07WGSg3?=
 =?us-ascii?Q?xsNrimr8Wbxi4IIltA6I22zMuTKQ6AQy3qHpLiLocbHKmGl6ULZp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dacf073e-86f4-45ee-9c0c-08de8bb48bfa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:54:29.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2zFZnYrcdsVFIu69jPjbsgmDQ+JkIdmYsOs1hcVl9Z5wH+ry9zCBXxYOMA1KquaSAKrLSOANiUmibWRSgEjwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7090

Support doorbell backends where the doorbell target is already exposed
via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
must be requested with specific flags.

When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
pre-exposed BAR window and skip programming a new inbound mapping. Also
honor db_msg[].irq_flags when requesting the doorbell IRQ.

Multiple doorbells may share the same Linux IRQ. Avoid duplicate
request_irq() calls by requesting each unique virq once.

Make pci-epf-vntb work with platform-defined or embedded doorbell
backends without exposing backend-specific details to the consumer
layer.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 61 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 2256c3062b1a..b493a300da4d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -134,6 +134,11 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+
+	/*
+	 * True when doorbells are interrupt-driven (MSI or embedded), false
+	 * when polled.
+	 */
 	bool msi_doorbell;
 	u32 spad_size;
 
@@ -517,6 +522,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static bool epf_ntb_db_irq_is_duplicated(const struct pci_epf *epf, unsigned int idx)
+{
+	unsigned int i;
+
+	for (i = 0; i < idx; i++)
+		if (epf->db_msg[i].virq == epf->db_msg[idx].virq)
+			return true;
+
+	return false;
+}
+
 static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 					    struct pci_epf_bar *db_bar,
 					    const struct pci_epc_features *epc_features,
@@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	if (ret)
 		return ret;
 
+	/*
+	 * The doorbell target may already be exposed by a platform-owned fixed
+	 * BAR. In that case, we must reuse it and the requested db_bar must
+	 * match.
+	 */
+	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
+		ret = -EINVAL;
+		goto err_free_doorbell;
+	}
+
 	for (req = 0; req < ntb->db_count; req++) {
+		/* Avoid requesting duplicate handlers */
+		if (epf_ntb_db_irq_is_duplicated(epf, req))
+			continue;
+
 		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
-				  0, "pci_epf_vntb_db", ntb);
+				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
+				  ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
@@ -545,6 +576,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		}
 	}
 
+	if (epf->db_msg[0].bar != NO_BAR) {
+		for (i = 0; i < ntb->db_count; i++) {
+			msg = &epf->db_msg[i].msg;
+
+			if (epf->db_msg[i].bar != barno) {
+				ret = -EINVAL;
+				goto err_free_irq;
+			}
+
+			ntb->reg->db_data[i] = msg->data;
+			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
+		}
+		goto out;
+	}
+
+	/* Program inbound mapping for the doorbell */
 	msg = &epf->db_msg[0].msg;
 
 	high = 0;
@@ -591,6 +638,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		ntb->reg->db_offset[i] = offset;
 	}
 
+out:
 	ntb->reg->db_entry_size = 0;
 
 	ntb->msi_doorbell = true;
@@ -598,9 +646,13 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	return 0;
 
 err_free_irq:
-	for (req--; req >= 0; req--)
+	for (req--; req >= 0; req--) {
+		if (epf_ntb_db_irq_is_duplicated(epf, req))
+			continue;
 		free_irq(epf->db_msg[req].virq, ntb);
+	}
 
+err_free_doorbell:
 	pci_epf_free_doorbell(ntb->epf);
 	return ret;
 }
@@ -666,8 +718,11 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 	if (ntb->msi_doorbell) {
 		int i;
 
-		for (i = 0; i < ntb->db_count; i++)
+		for (i = 0; i < ntb->db_count; i++) {
+			if (epf_ntb_db_irq_is_duplicated(ntb->epf, i))
+				continue;
 			free_irq(ntb->epf->db_msg[i].virq, ntb);
+		}
 	}
 
 	if (ntb->epf->db_msg)
-- 
2.51.0

