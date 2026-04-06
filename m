Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852E332616;
	Mon,  6 Apr 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491052; cv=fail; b=XrMBDFDzCFtCJsz06XKFJFxCp0Zi7NEJ9yr1PGsQe6s25Hw1Qvh0X9NOH8RxNFaED1sWEr61oXDWxS+XpX4uTlgfyUaVsVaS2QJ9+TcJY8xtNQMrmfZP/KbZqKhzKz70odvgGpYAs6CfaBQigKoUtC+Ebm9NdFhvz1Dh9YegYvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491052; c=relaxed/simple;
	bh=sgRjIYZasZJZC6aHGGTqAQ1lBQJuj5jFMHNuey/EsmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpx8TUzQc5UO3vcGyFjdugOCXKA2W0zcSY0ueuFnDJ8yDbJhOqTEEss5b6oZRhdSNl4pYvqvI8l0r1hIYNfbyP/1fqvzm3n/ublV7pqLjcTDv0TteyUZvs8FNTfbFCYU18+xO8hsDx4Z4Onr64GzwVVJ600InI0xjsD9JyOwrSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OJFfeWuj; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OJFfeWuj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKuqiIaB4sKVyqBFXiQpFDbjaguRs5Er7sBzmiK2mWSDsdm5cMZECEY5qLQ3pFuxsKWONSt+jzHQ/XwzYIXtaecIf7JTN9+JJcBDgAYtMWP9s4s4G3y0XhoKdQG36dd0whla9t8GmQs6TSQAxcrrbgubqw/yieYwhAoFKKk9bcwDi+NBNt9fdnuF9MUiyXZbt6Dce2XmsKJJek7z6IiU31qMNM1AQixsDhw9DWKq4zcQoPFya8fNuCjOeyYDTvrxbpZSvZjzRW3DHGxl932QkQZVblAsn8JkiQITNws3GlalOIWUkKRCjqczTtqHlHMvqnFWv4zjoFieVCte9UAlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b35G/jLYtQSzKulf5UWuDqd43jYQoJdbINzQbTRfmH4=;
 b=bzQTTefnO31zfkmz4Jp8U8YfRaWC9mIacbmYbSrvsJPTXqunBBDWPgvwFLuAdnuDDczJjtJJbpuHLg6GQjB+ac5WVsftLM0IbOagaJYpJKP09u6vRHdxZM0aXtMukhUwX+m5axusq8Wh1sPVBYFt3Uok8kD62OLjEX5qMdvkiGK2XMQz/FqYkKzAbW82v0HgxIikJIBSohwhio1vf3tPTDU9RQv/p0khcrjuy8sniG5+XrGimDfYU1tZRZj6P9bDy1s2EZtiFId/v35S4unzGhBDc5B5Ya0mAl3sL9oj0N7bbijRqxFyPoE9ozpTxoR0zn/Vh94gOSITJCReEnsmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b35G/jLYtQSzKulf5UWuDqd43jYQoJdbINzQbTRfmH4=;
 b=OJFfeWujwJ0SMz13e/978tDvMUfXED0Ar+zDeQm8+xOh18cX/OYeMy/XX474nhW+bMt/X/pZPL/BWEUjT4vbkr4bzTxKwghm7ScQWcGP+vrc2ohFloo8dMjwlRO2PKmd8izx/DPuy3V20q8j/2AXIbhOsiXndGQ/giikZdoygb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4187.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:57:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 15:57:25 +0000
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
Subject: [PATCH v13 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
Date: Tue,  7 Apr 2026 00:57:15 +0900
Message-ID: <20260406155717.880246-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406155717.880246-1-den@valinux.co.jp>
References: <20260406155717.880246-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a863273-c597-498f-eb12-08de93f53277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	fSvfNz7TXok3gppaHig+kt5s98wspXPquYem2XZ5dz5XgWnGZtfMsIDvpydFdYEjo6rVs8Z4+qjOiy0lgLbuc2cqftDCfwzmZk92o7n9CxY5ZG7dnFP3/lM0V9Wai7fwqCdeEB+v/7jLVZWSgJ1CVEHXhJB2xZFhuKa7dwAHwM3S8QifJO4ZNpPiWQjGStjizrShJlXR0Bt/mXD5EFPydBKd7AR6MX2eDx9q8zAMw9/wuElItMECZyR6SonW1tPPbN0pmdGsmW4Ju1MnRqp4f+7jWV6ijWdVE5y05p8XaqatAuayNWfE7hXzig9cq6S2eywhiLEvVe6PLcyA7TXewr1H2iH7b9Z7hkD6+evSaJpQX/mmqIcLO72tpnrhzHiPikB0Gytw19vNTWWBeVMyD6ZXrvOgCgnTNIn4mOE5h6uwR2Ok66qXVg5vo9++t9DyXKI55+IxoR3vnBygorZ5haCTKFRvUaUmd2F25czuavsfHAgBqwSeEgxmdPbxdsL2u2NTnYT+Mbx0pABL/EnCN4QwxaWU54xDQjxLPI8Q3fur2QcwSFAI7SaNagD3uqcWeJhmB+06Lw4dmKe95qoN/A6C5DUI52g0ryxeko83SyudnOqQYroGPjn/r6mgP8Jta81bi6cPBNr4HNbdyucyWS38xKuUyLjv/QmLDSs8lZpZEG2T6lxmijTnhx+JSvHnG27NQQLKn8yxNgawwFF4U9ui9Tp21uAxJ4jQxiQzP0/TSwmp9mHiBS//Cub6HdHGdTi12kTjW68xxjmNrh2r/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZZYAluYiUk8PNN06nmFj5hwChlbsTVqMW6BLpiAYJVz+zQTY6Qh6DzHh7uz?=
 =?us-ascii?Q?tYN3dC59gffAv0Wk0gN0316Snyc/qIuM0De7i2dDimxSeVtWsszPAHhcuD0I?=
 =?us-ascii?Q?9ic0vRpD13+oclimNvuDXBELnBMWujFiUQSEfy7I+XL5+/Nt/gpPQ4/xGD4E?=
 =?us-ascii?Q?Y4XQO7KVQ62I8bdLQTHL1jK53qfE1rzqUW4Vd/hQLp7Fu/20C02XJPDL7RSt?=
 =?us-ascii?Q?c/e2DIh10DVt8Cdqmt0YRbp/GFIc3MpTUOSTINcOgdwsFK4x1eLomNBteYWg?=
 =?us-ascii?Q?vjJKkX/92XUKNyZpsZIjFY3VSgqMx7tvqpM+i3nbi8JEenbabqcVbEjVcMbY?=
 =?us-ascii?Q?cQKUSGTqm0It0KOM8AFiwoA6MTeWxCcrxFBafsDJcAeydFc/jIB3HC1GVx1P?=
 =?us-ascii?Q?7F0c48z4eJyUyjW6g0UYKDSAdT2PdQmAqy/WwSv5DU8m1XcUu4EpHsgu4e6B?=
 =?us-ascii?Q?vmrSu1bDUfGDpeWzo0ovldnMUv5wPrLr77NtHPNVk8miSyk6aIE9ZWJcKpI0?=
 =?us-ascii?Q?8T2Ec38c/V29TqDyV5v/nehuP76j6fCufoob33QCuOMYWSlzKUg2Oj/VVD5g?=
 =?us-ascii?Q?InFTvKpW0F6FycWhpATYM1XZwdLRlCyF/ybS8occrLV8iD6RyyElIEXl4unJ?=
 =?us-ascii?Q?4LyixJloiwLl0NjsIg7QsAVL8tNWPJfL62Qz0kqVYoXLcgsAEMReb/dvG9Ay?=
 =?us-ascii?Q?Q1Mdrjb3zl3qZ5kBadAsa/xQJhSwFc1jh7bevYaHN6lylqkeKraSEv6QFlxQ?=
 =?us-ascii?Q?BGSIbS8rww4+W9s17Q4iruROXqLxABmoh9IrTcfEJw6z2ALt2sLUyn5XEqfj?=
 =?us-ascii?Q?H89Db6ylo1q90Dg3YsT/RdBwunhkASdOUR9KmccQVvtO2Pgjc3JtPBit2yRi?=
 =?us-ascii?Q?odN0OaD6QvCoyP8Bo/dZk3FEcUy3tV5lW/7jb3saSO2FMk9pmx+jx6e9cO31?=
 =?us-ascii?Q?u7VbKYB7XLroqwT6MFfet5v/l3N6l55pvDuF2i9xMLh3/yvJ9cmGw8O+Rkx8?=
 =?us-ascii?Q?SV8h5ZjzgsRA3c7jtTlJEva5eZKTj+7Q5L2v6bMmRRYHRAzOJWEx2gfpna/g?=
 =?us-ascii?Q?4FnDOqGarP8U5XwJ+Yj019woKIaRSEfjwzE+ArTIE9uvMyUx9F0P/JUSw7iO?=
 =?us-ascii?Q?aY/hlyJ9uA8UHyFIjlzOD0cZc6v3cZXZDpA31RYwO3lORtEm4Yo4WUa5YPRx?=
 =?us-ascii?Q?sYaQNq3s7oFEcCyM58rZqcu3MD58T5y1ZrIfJkUYJTgrC6kxXg3OeNUoL/DL?=
 =?us-ascii?Q?/f2cMlypfTpHGTPCaAco4jRRk2yAM3ulsUrcL7YPn3zaOkf7kb92dRX6Fyo6?=
 =?us-ascii?Q?M3cFQ34bBoBWHmKPn2nDmVIkgvBd3PbVfSj4ASc42iFR5oBvCJm4Fg0k3yL1?=
 =?us-ascii?Q?+ReY7RbIkYEgLMzBCfU5QfG1xZuBATJTjxdUoNX9knnbySgwEoZ3WyoAN1r6?=
 =?us-ascii?Q?Tvg/t6+0j/CakUSm50KTrCjFYq/tW0Cd2BfdjC0QWbkqN5XQbDlFvOx898Nl?=
 =?us-ascii?Q?p0R5MgKpwj4I5TYRYtt8NBNIRhJcfCzIXZNmmnAAO58e5V01Su9zMr5Pl4uW?=
 =?us-ascii?Q?IU1JLnmJbVO2cea7xEgLCiMlN/c5pk42OvstLJ4VBERYQoVTCceSZ6HbI5Re?=
 =?us-ascii?Q?U4X0fDOehv1i69sYvqWDvegW61bvIdmXNQvFROktdtp0ok1R5v2dsmATVaKM?=
 =?us-ascii?Q?oU4++RedNBUnPKvab12KZWjd5bokVdOIOzJEvIApQ99u5E7nnRUvA3Zf4TIw?=
 =?us-ascii?Q?DdOmCPFBZiR2pByb3fyrPwh9hxmvOcrCIqRBLG8++/lA0zRA+B8i?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a863273-c597-498f-eb12-08de93f53277
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:57:25.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4qBAd6zJL5jSWtjMSvEoM3wThzPTO0o6+gyS4LFD412BVMryOvq0mw0w3bLNYIcTRN7W/Aiv2U+/VJXuVskkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4187

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

