Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022089.outbound.protection.outlook.com [52.101.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC413BED7E;
	Fri, 26 Jun 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503417; cv=fail; b=fbc56kogZ34DPh5KdLXPYD3B3SCGjLSFiRi2CTdWCy/URiOkHeG42Q0QCgxLSE39xuQ6+ilOamdkkJnVhisYjwAxw3y7uVuMNVWmoSXI36gmYGJs3ACQY9Zui9yPlPKGWoBpIHZOnf+lm+160Fc9Oi75Qqiapp8voCBKu25JN9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503417; c=relaxed/simple;
	bh=iEnXy8hi7mfUE1wsqlrCRWwdsgyS6SF8petWt+yJ9oU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UqIIKzrzWFP/lmV3guQtlaphr2Gk/ioy7RTeNkscox1Bp6pMbVUIMzEsuu6xdWTjFS1MLDb54A5ul3BsHQYRVH1+26r56HEJbKm+JADPoPt/j7WS++1k+96m8bFeHOsevJGvP1gxiRkL2HSd7+LfY96Wn61338X1P1TqPBzv78A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OejVQ9+p; arc=fail smtp.client-ip=52.101.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OejVQ9+p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpcvGkOBN7ayeC3ErfIbEsLL6HGV10G6Q1xd0IvyYWueRNdvwWhjBjaftg8ZwU4Z6TcCVUeV+lXFYpAqopWgxxFyZJuzRCqNJWb0HRNe0md829DUaUMB1RLV+VcKO680B9qB1VHaBTdY9QFADty/1Ia8eLY4sd7VFaFn6Ge0StCYXzdBnkXi7ShG6lcNYFDG8+8YV3GWv8H/JKah8xDGtKMaE77v5w3uOlVyMCFVLOeGoGVSQLtSzPImFcdauQqykzHilKp1sYKAftf0mN2AL5VVazPKbuuhdcx4QXXNUjrIKAXh7tVOAyWlSgiXoTFqZHv8KD9ZjyWZw1T//dLwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcuL1r1Cq2//Dr5Xo3KRw7qVMRMX9Vgg11W9k8j/ItI=;
 b=GFB6ZyrfEvPiCileMqxFe3D9TAw5tZsXtDMo01JCLcv0so0bHfhzqWJg9TfjOGXNPtsBtcMduAmRTFyhpZikQpVTH15eI2n+TNgbEpSTpgc4zZf0xMtCuizZBvlRdra375Ci3GVALNjD8dvqHLdmH0fYuFZhc+XPv5j2O4pVHNWM8tGXyGFSXCrzIfs4Fsfc3AwcZSw3gY0cUbf0sBeJtEASkWMpcQ1etMGVqf5te5OW7haBC/6L/HU8yQ/R0/5fugH0wZPvpHzKVPsPhNaBNLIANyaxTtjAPQdLfeSI34jwTC3QbpSoDR2cU/pH4351xWm0mHL14jxGJ65L0Xk4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcuL1r1Cq2//Dr5Xo3KRw7qVMRMX9Vgg11W9k8j/ItI=;
 b=OejVQ9+pqYohJqkqFMInfPTkrMNbnMHwqcq6fR5KpZySgBzvOoSnNFE49WO3NmOeYIn41rLA4HMLHYNki/W+RLEFlUu0maTj1RaZBWU6ffo8L2DfHRQ6AK55+tUqjTnzY54ikFiiLc6yl/uj3JvCA1hV/gi3qnUJhRPutwAYWY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2905.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 19:50:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 19:50:07 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 20:49:38 +0100
Subject: [PATCH 1/3] pci: make pci_match_one_device match on ID instead of
 device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-pci_id_fix-v1-1-a35c803f1b95@garyguo.net>
References: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
In-Reply-To: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Zhenzhong Duan <zhenzhong.duan@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782503406; l=6579;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=iEnXy8hi7mfUE1wsqlrCRWwdsgyS6SF8petWt+yJ9oU=;
 b=BlOT1kBdr0/uLk14P97VQKo0JlTd9qhenKGn0GDZyUOAXFbrrY5ONZeJwtkCYc+xrE2jkkVH8
 qQmav91BclPAkJQWHQtZL0tUBqyMoE6669vApvL7VPrTjEZ3KhjEgGn
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2905:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d84451c-c877-4dc5-4de3-08ded3bc1faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|376014|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	jHzAJbAyFujJZUS4h9dSqSltZf8D6zcfSxd8EJub+tgll3M04VZHHiGBm1OZVNBbegGAV5/dq2Ai4E+seYulSLjm950UokZCPk9am+gPCsksYfyw036wnrLpmA286u1qsSDw6Wsa8x64LXwD2u4/UmuBWrwvBXL3AsbBHFBDB9JqnCjNsm40aUxJcqgvfYkg2/smqaR6aAv9OcaLNdlRBqksgCbZINh6r4AbgOjA0udkVbDJ1UKjGkIYS3qi5GxXojUSYlqTYMPHfTPv1RBctG9LifOkS0sWj7cd1/u7P6Rk+YIBEWyiSfgAAxS0j0Dx5Jasi5svRX1YXPFEfb3Zhvuv2Yzr4G1VL7pw/Ap+GfIOBDy3BcgHPOfI/dV+UEeIDeDWL3fEvQZRlmPJQooH83DC9tX66zyCCKDtZjV9IL7/yJNLb6Zmlxbz8MxgEr9eS/vj/148U44a+dMOwLSaTvqhJI02qe1sLoX0Fed7jsv1tefwxgsyaVJkZU3Qg8R8LAVUzn0Hkfl4NGTjqn+IrY3gNo9E3pyVphFzR8wX+knbwASTdvwAPdUkHftUh6EyL3tCORL5UyLqrKDTDoUA3l7KLuP1oi4L/3+XaoDj7znOPKskp06NustEPkwmnW6ywC23+vqKyx10CMkDQq5/sNMGKdrCOi/dgT8lkwHoHn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2E4aHE0cFlHb2RMRTRvejhVSHJOZ3NNSWtFOS93cnpyK1hEZ0E1NzZ1cUVL?=
 =?utf-8?B?TEQveVFRYytzZWRuWVVVdXpxd1Z2TzhPVnlYN0grbnFEU3hsbk1yVjFFVG9O?=
 =?utf-8?B?YjhWUnZqak1HaUFBN29lZHhtdmsyOUxrdXBQVlFUNVk2cUxMREp1aE85MHNZ?=
 =?utf-8?B?elkrUnRoQ2tBR0dPVDZ3ZEdERVBYOStjL1lLeTJrVm1TUVpNNUp0c0JvcGhQ?=
 =?utf-8?B?bGtzdDdrK1VETVcvYlpCanNEZW01RUZ6Q0NhMkZsWjVNNWtZenBuZzNRemp0?=
 =?utf-8?B?UDhHZ1FYL0pYQmZMT0FURXdST2kvQWVsa3JIeGt6SGtRR25UQ01rTFk1TXNE?=
 =?utf-8?B?QXF3YmNKSVZBak9SZlpnUHpnT2tqOW9qNm91K0VoNVJYUHJLejI1eE4yNUFi?=
 =?utf-8?B?Kzh4clljaUsrRlY3L1llb3ZLWW42NXEwZGU2ajBxZEhyNVhBd29USEZsT1Z1?=
 =?utf-8?B?OENKY29DbGtlSXE0U2cydnI2MEN0MVhabC80V1pOdUl2TUdPZmNWb1NGNUxF?=
 =?utf-8?B?eE9MU004T2VXc3hlaFlBa04xM3FyTEVNTGoyVHFDbDdJUmlmaENTUk5sMm0z?=
 =?utf-8?B?ZDE1dTZOb0Rma0RmeE5UaHpjQ0tCdHpaMERkcGRLMEpwR0pMZWV0eldrUEVG?=
 =?utf-8?B?ZXU3MUR1UjZFVDZWQzJUNkdMYjVOK2JHc2ZYNlZlV0JKWlFPd2hYZ3RDaDZq?=
 =?utf-8?B?c1A5WGNmYS9pRThwMTRUZE02U3RrOEpvOU9nL1ZNdnhXaTZDZGNOajI1TW44?=
 =?utf-8?B?bDVFRERtWU1JT1NrUDd4OGF2WWRBU0JMVDhSTGF0Kzc2YkU4NnNNVlpzd3BY?=
 =?utf-8?B?QjlOYTQ1b0RpQ0UxOWhqRkhsTXlKY0l6MVRwNWpIbXRIL04yUm9ScWNST05o?=
 =?utf-8?B?ZER1dTRvcFVmYWpTUWkxZjFOajAxNk9SeCsvczZlUVR0YVI3UHRvNU9WL21E?=
 =?utf-8?B?Y2hvM3Zhb3JNYVhjMnVQTEozdWpVSUU2SEhIeWpFbWxFRjRoWEtJbXZ2b3ZR?=
 =?utf-8?B?em9DaDh3ejlMMFhQR051UmVtNmxaeW1KaTE2Nm5HSHdscHYzYzlSalVwN2Zj?=
 =?utf-8?B?K3N2QmpvTUVSRzNkdklUdkFsMkMzclBBeG0vb3BIdXVVWERpRFBLVjlpaXRj?=
 =?utf-8?B?MXkwa0ExcVVQN1ZQaS9NbmZMcGpmOE9nbFRreFVpcHVuUnh0bmQyZzJKOHl5?=
 =?utf-8?B?NDVMU2phU1RmTVg2T3FxQUdQUWtTWnU0WHNKa1RkUWZsSVBpTDkzV2s4Qndv?=
 =?utf-8?B?SnFPVmZIelRTbVQ2VFRwdTlaS3FRdFFzSDFOeGZZTHl0V2xMcElLZUVXTHRD?=
 =?utf-8?B?Ni9IUlplNERsMTB1VGxUL3BVYm1NdVg0ejBXTDhWYnRKblV3Tzg2aEsrZUNi?=
 =?utf-8?B?RG9ONlJyQ2t2S3g3WHMzNG9tMVpsWU0weE0xWlUvTE9nZisyMEZ1dXp3TFoz?=
 =?utf-8?B?K09XRmpqZi94NWpTUTM3L0lUa1dNdnV1ZDBCNGp2dmprS3RzTmRmMlJVam5y?=
 =?utf-8?B?N0FKU0plWEtlTTU4aUlxTTYySjRkL1ZrWjhwNDNDZGdzWGQ4SGErR1hVVlFU?=
 =?utf-8?B?ZVZnYjVRZVR2blAzaStXWkxSKzR0aEw2RnRZTC9SMkdmSXJzTnVDNGNZV2Mv?=
 =?utf-8?B?TlhCTDBzbnlQbnduTUd4UjRXQmQzcmJFT0NjMm9ScUkrdGxiUHBnL3ZSeVRo?=
 =?utf-8?B?L3hyN1BYcExiOUd5bG50VFgrOXlnOHZHZ3BrNlV0L0ZKc05QVUVJaU5XOWZJ?=
 =?utf-8?B?bjI3QWpLUFF5NkswUGVLbGs1aUFrMWt5YjAzZXlrTEd5SHJyY0FvNWRCRHM0?=
 =?utf-8?B?SVJLd293eUgwSWVNanppUFNmUWNuK2g1VS9OVUZYS2pSbHlqMUI2SDNEenVH?=
 =?utf-8?B?T0NsRUlGdnQ1YXQxQWwwdFVqY2pnd2FPL0RLTXpRdHZKNjh2VGdFdWdSQjk1?=
 =?utf-8?B?RVdPVEdZNVBPVk4zZnVXMGI4djdGbXFld2h2L0FkK0dIcVZoOURSeEFDNnEv?=
 =?utf-8?B?cU9uUUZUUStXVEdrV0c4QlpmZmZIWS9IWjBhTS9pTzd2T2ZBSnlvUEQrMWlv?=
 =?utf-8?B?Y2RPMWcrSmhBckphQis1OTBpRUZ4RU1yczJaRDlUYjA2SHpLbWNlOC9wa3ZH?=
 =?utf-8?B?c0tjMlhXNFp0NkNvVzYxYU5hdmJRQ1pMMnQ2RmR5Qll3Q1BsbW9KRHpRSG9Q?=
 =?utf-8?B?QjQwQklIN0N4ZHZqYmlBWDdoeStRcHlMOGN0WDNnN0tjZWxEYmh5alZoRWdn?=
 =?utf-8?B?TW5QeS8yRnNmaHpuTUZPbmdaaldYV3kxYXl3dmtnUmpkOU00V1pZSTJLN1Q5?=
 =?utf-8?B?TElnNEMvRFdZMlNaRmo5Q21ETDVEeHR6MW43b3ZselVUMjJlWDBlQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d84451c-c877-4dc5-4de3-08ded3bc1faf
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 19:50:07.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6sILEcN0+JJ+GukPOYyMdUatPTBgequF/vgdAHSY+hguYTHH21dzA+2XoiUIg12pvSSBLfL5L95m8OGuLGGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2905

There is a need to match just IDs instead of against devices. Thus rename
this function to pci_match_one_id, and add a pci_id_from_device helper to
make it easy to convert users.

Similar convert pci_match_id to do_pci_match_id, however the existing API
is kept due to quite a few users.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/pci/pci-driver.c | 38 ++++++++++++++++++++++++++++----------
 drivers/pci/pci.h        | 36 ++++++++++++++++++++++++++----------
 drivers/pci/search.c     |  6 ++++--
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f36778e62ac1..0507cb801310 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -90,6 +90,27 @@ static void pci_free_dynids(struct pci_driver *drv)
 	spin_unlock(&drv->dynids.lock);
 }
 
+/**
+ * do_pci_match_id - See if a PCI ID matches a given pci_id table
+ * @ids: array of PCI device ID structures to search in
+ * @dev_id: the actual PCI device ID structure to match against.
+ *
+ * Returns the matching pci_device_id structure or
+ * %NULL if there is no match.
+ */
+static const struct pci_device_id *do_pci_match_id(const struct pci_device_id *ids,
+						   const struct pci_device_id *dev_id)
+{
+	if (ids) {
+		while (ids->vendor || ids->subvendor || ids->class_mask) {
+			if (pci_match_one_id(ids, dev_id))
+				return ids;
+			ids++;
+		}
+	}
+	return NULL;
+}
+
 /**
  * pci_match_id - See if a PCI device matches a given pci_id table
  * @ids: array of PCI device ID structures to search in
@@ -105,14 +126,9 @@ static void pci_free_dynids(struct pci_driver *drv)
 const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
 					 struct pci_dev *dev)
 {
-	if (ids) {
-		while (ids->vendor || ids->subvendor || ids->class_mask) {
-			if (pci_match_one_device(ids, dev))
-				return ids;
-			ids++;
-		}
-	}
-	return NULL;
+	struct pci_device_id dev_id = pci_id_from_device(dev);
+
+	return do_pci_match_id(ids, &dev_id);
 }
 EXPORT_SYMBOL(pci_match_id);
 
@@ -138,6 +154,7 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 {
 	struct pci_dynid *dynid;
 	const struct pci_device_id *found_id = NULL, *ids;
+	struct pci_device_id dev_id;
 	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
@@ -145,10 +162,11 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 	if (ret == 0)
 		return NULL;
 
+	dev_id = pci_id_from_device(dev);
 	/* Look at the dynamic ids first, before the static ones */
 	spin_lock(&drv->dynids.lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
-		if (pci_match_one_device(&dynid->id, dev)) {
+		if (pci_match_one_id(&dynid->id, &dev_id)) {
 			found_id = &dynid->id;
 			break;
 		}
@@ -158,7 +176,7 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 	if (found_id)
 		return found_id;
 
-	for (ids = drv->id_table; (found_id = pci_match_id(ids, dev));
+	for (ids = drv->id_table; (found_id = do_pci_match_id(ids, &dev_id));
 	     ids = found_id + 1) {
 		/*
 		 * The match table is split based on driver_override.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..0567a8762baa 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -442,21 +442,37 @@ static inline int pci_setup_cardbus(char *str) { return -ENOENT; }
 #endif /* CONFIG_CARDBUS */
 
 /**
- * pci_match_one_device - Tell if a PCI device structure has a matching
- *			  PCI device id structure
- * @id: single PCI device id structure to match
- * @dev: the PCI device structure to match against
+ * pci_id_from_device - Obtain a pci_device_id from a PCI device
+ * @dev: the PCI device
+ *
+ * Returns a pci_device_id filled.
+ */
+static inline struct pci_device_id pci_id_from_device(const struct pci_dev *dev)
+{
+	return (struct pci_device_id) {
+		.vendor = dev->vendor,
+		.device = dev->device,
+		.subvendor = dev->subsystem_vendor,
+		.subdevice = dev->subsystem_device,
+		.class = dev->class,
+	};
+}
+
+/**
+ * pci_match_one_id - Tell if a PCI device ID matches a needle PCI device id
+ * @id: single PCI device id structure to match against (needle)
+ * @dev_id: the actual ID from the PCI device (can be created via pci_id_from_device)
  *
  * Returns the matching pci_device_id structure or %NULL if there is no match.
  */
 static inline const struct pci_device_id *
-pci_match_one_device(const struct pci_device_id *id, const struct pci_dev *dev)
+pci_match_one_id(const struct pci_device_id *id, const struct pci_device_id *dev_id)
 {
-	if ((id->vendor == PCI_ANY_ID || id->vendor == dev->vendor) &&
-	    (id->device == PCI_ANY_ID || id->device == dev->device) &&
-	    (id->subvendor == PCI_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
-	    (id->subdevice == PCI_ANY_ID || id->subdevice == dev->subsystem_device) &&
-	    !((id->class ^ dev->class) & id->class_mask))
+	if ((id->vendor == PCI_ANY_ID || id->vendor == dev_id->vendor) &&
+	    (id->device == PCI_ANY_ID || id->device == dev_id->device) &&
+	    (id->subvendor == PCI_ANY_ID || id->subvendor == dev_id->subvendor) &&
+	    (id->subdevice == PCI_ANY_ID || id->subdevice == dev_id->subdevice) &&
+	    !((id->class ^ dev_id->class) & id->class_mask))
 		return id;
 	return NULL;
 }
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index e3d3177fce54..c8c4bfe7817b 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -245,8 +245,10 @@ static int match_pci_dev_by_id(struct device *dev, const void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	const struct pci_device_id *id = data;
+	struct pci_device_id dev_id;
 
-	if (pci_match_one_device(id, pdev))
+	dev_id = pci_id_from_device(pdev);
+	if (pci_match_one_id(id, &dev_id))
 		return 1;
 	return 0;
 }
@@ -418,7 +420,7 @@ EXPORT_SYMBOL(pci_get_class);
  *
  * Iterates through the list of known PCI devices. If a PCI device is found
  * with a matching base class code, the reference count to the device is
- * incremented. See pci_match_one_device() to figure out how does this works.
+ * incremented. See pci_match_one_id() to figure out how does this works.
  * A new search is initiated by passing %NULL as the @from argument.
  * Otherwise if @from is not %NULL, searches continue from next device on the
  * global list. The reference count for @from is always decremented if it is

-- 
2.54.0

