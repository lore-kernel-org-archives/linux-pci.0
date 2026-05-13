Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D473909A8;
	Wed, 13 May 2026 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640587; cv=fail; b=NenwcmVGyxk4+3OjkETNIgQ9BzM3zBhHldjfsLRZuhnZzI885fxr4HZ4rP/qHvjycr9nS8W/fA5jblEAaHkvxhXXJl+NANioS0iNPDXeVUPx2O6McnQP+CqrI5jYeVoZUl7ds3rHtCLCZtPYXacjWoDpFL2VQ24hVGtUPVtvefE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640587; c=relaxed/simple;
	bh=v3BK1tgNGRfWBZK/VjX9bYB0S+yAkIK3sGBEjxOafE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8OrSekKeZ6BIVjbnyEH30yilfXU0meuf4dRY0qapqbwn2CDnMqGQHKttfkvNi2vsNsH8DupA3+MTHlelQsmx9geqX3z2KB5SAdx6sExlMyf3OLZCqd17zxZ1vXUPmKqbYThgwWKyJe0fvO5pq7frTTmqTJ1EY6qQ8pBQ2F6mt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=T78TLw72; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="T78TLw72"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbk6IymHrjCzzaWAtkrT1ctJysvbScMeNjeXBK7txsELwhbabs1QMduXzok8DYL6hcRnI/uTv8xpN/IMwn8eegd5laMgN8B19uH2/5HtgCJy7X25VRM+HGMdmLu5+sGFxTDk1adbYyTtr4DXZ1YtbGNQZmwApyAgjvLnxdtv2jNH1QwqDPbN48762tIA764X1qn1kRlmoGbPPEX9erOqcm22rLM+ManfzcuX72Y2NrIqdpphoBFfBpuBewjifKiBSnR6qH3MVEdNWtmtqyYDlF6M8VIK739JMgfQUmZ5MeYeCDo5jG9IqT3tngFJR6vNjIWHyfbM+UMkUmLXkUO9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjpaZYSJ30FZ7ENugNSNc8Qfkkqy493Gztkxe4vlFvo=;
 b=PlbXnhuvrXonzGhE+lje6EGQ+0qzeNjkVhNT96uj7eqKQPuMoblVp3inrJ0diaL8hV1inKoJrzz5AJOIRQgopuv/yGTNW7VJvalGjFcZlYvvrpAtsyQgCNLG6pYf10WBWetWUlYBgQ9vyiN6TNh3LQ87Zon9rmaeZ5dYCubQZWkLq2YXmVultJXXPYnttvEW0aT7UoWYHKR9jipzUnm5SKWwerb1eIQfnz4PJpFrtA7mYcPebrnYwJzmgL+7zp3ziLzDLnURbgvavLQRpevganc2Xgu7qBA+mnV4rkmitJoyTdobWCaN7ZjkPqOmZrDGmqWwXuzcH6zVU4GXtw1DgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjpaZYSJ30FZ7ENugNSNc8Qfkkqy493Gztkxe4vlFvo=;
 b=T78TLw72WEQBhIt28JavgGz92xNWCRZM/3rPz09NfUd+oOAXlyp6KLpuS20Iw1CrZfeNF6ej3EIfuDMiiAYP0QN/+KUOZUKfBJevkAWUGnUz9N6hEw+9bF17DheraOt5EwjSCdgXNpawQ2R/ZRnPTvtRo2WmLto2n7c/96w488M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5170.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:31 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 05/12] PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
Date: Wed, 13 May 2026 11:49:16 +0900
Message-ID: <20260513024923.451765-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3370f3-adf0-41d7-6ec5-08deb09a41f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mB5ZKipyYfRhnTP1imnJibLm5Jd4+ZIXs+VHI4rKdnTvC0kHcjp1i9H13J5iyO5KC8zCq0oed+T8QyhKTSC2OTZ/vyS8act6tg3U74XCjU1PXdkhvVXQnHF+LnlQ35GJLxeKi6cGcrB4KHp4nkcURUiNdS95Ha+B5XmMirQkYLEAxB6AIcRh0DDRh9RINExYbCpHvddZPn5hVpeL5AeR3B9FF9083aaThuQDhTHOozOo5F6Ed5wYJDluiFFb/2i3aWdjluIbTTSh7jo95rlYNamTXohOkb8V3H5OPf6nj64sUtodgvKubnZIBHl/57LEGiZcSSR35xEKutmK9YIU6ZxHQuZql6BDTMNOVTqZYlwHsFkmPX7USthCfcpfeezWc9dolTYixarPq2f1EjOoPSSTHa1EiNuQORH0jiqSjPbEeMfIkvIvdnQ6lj3wqaGG9PPRy00iOdrUettRudeY6DMLjqxW9cq8WuUQUAkfmcgJyMWSZUaV+1owv2f59ugBSvC2tZT2BKFIFYoF2j/vXXlt5P2mhSWOKOail9+c61uqpiBQKgAxj4n8Pd5K7NbGYFOJzDcvEH4a1/i/8aKYhD+a2UV0eHyZVw1QAZeaQEjyZthShEQkaRAvEMZus4bnIftlKpCto9plsIXBg1DIPIUicu2bhB8avm3p8FqOiHWv4CHu4PIrncQ5Xth/GVgGHWx60DAlu5OZbd/FnMi+WX4R1nnsKHXUJd3mbpUimqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCo9e2E0dVdnXdf8pfBlvkl/QCiGDOp/1Udpsv9ha1jyHVezLRrzh9CR5CX7?=
 =?us-ascii?Q?K734OM7VgAaSEfJVHToNeWdGUpYRQYJRK9RJm5oBvTbDfPBKw62Wxi1v8VSm?=
 =?us-ascii?Q?99HXYYb1doViDYFNm7ovyY+jA5VCHTHLMoB4+3hJX2pqJI3aDsLAQqVJJluL?=
 =?us-ascii?Q?aJtLtnIpgkksvlQkSKR3EoKxXC2e2EADW8VhlGTY6OUZTJIWvWRqPqoSjNMe?=
 =?us-ascii?Q?htQxp58OG3D86UKpYFRURlbQUGdrbNUl1A00NNqVLtSMoHxJF55P+dyZlVRG?=
 =?us-ascii?Q?wrioPzgjhOfk5dbDHi5iSDYuxepAQkIul/NE16sZYn8ynUxnX3rDEaWVf42P?=
 =?us-ascii?Q?4G6/CeXQNJIEfty9fB/UBccw8J2MH8aMx3vP40GcGwz+EFZBkF4jsaFAyXlu?=
 =?us-ascii?Q?+MpaRByKaWps8DmNleNq3rvvgPe2QinWdZwVO8ctIxqYZz/ASO4vFvIeHkbk?=
 =?us-ascii?Q?lqLGa3t9Vp0r9uAoB9zpysItu3fz1mjEX9ZQSSNAat9iBvf2r9D7g7DgdvI/?=
 =?us-ascii?Q?TQz+W4Z97aQ5Z+xnI/YB0c+aNHeqxZ9TgwvFoeWfBNtik0mzdmNW98r63ov3?=
 =?us-ascii?Q?1qKsB3LijXVBjdRj2WTLwK2hJmANer4VSmMYIau+H5IEHHkTCBOj1yv2AZVs?=
 =?us-ascii?Q?5v9MjDXOIUCgzSk+3EP5Q3xy4C+fHE+k18Pxx+38l7Jt5R8NehqKemLAz68N?=
 =?us-ascii?Q?f2B2RsZIGuUkYAIBw6gUo4JZaIUklwzkSxZK/HBXxwzpQkIdmbnqKg9McV4h?=
 =?us-ascii?Q?dS/4pEDqd0nEkI0XUUkwj3A7OhxLrVEb3ypYTUPCXi+PUGpmn03LZUU7cgcw?=
 =?us-ascii?Q?Bl67AkddOnQgKoni6VGt73bOFdlanZq7s7olR4Y6laAPKS45nQSlTHJlgjoF?=
 =?us-ascii?Q?mLiST+BvTxE5Il9B1AMG445ii8oxnLONbKqB6AKNUrajnPZ3MjcTrfm9aX4k?=
 =?us-ascii?Q?+72aXwjNTpZB6E9aEJBexzNtWR7urScCdeY8pIgE/6jS5ABh7jYraicXNA0h?=
 =?us-ascii?Q?4F1Yy52y9lLXdmRtoeJWA1cZWSlluWUwrlyxvJ64YsfWFQd4dzsKofe4zLXo?=
 =?us-ascii?Q?Yfkxphe5tSh9rgoyEZm/7pVgte/gO8x/s5qS1l8pX9cqOQXcrK87NNdZb/6V?=
 =?us-ascii?Q?85hLBsvzQEcIzGfnRfBTRIFOeRwitJ3JYMixgL12WFykjkHTG8uLdnvQQIPu?=
 =?us-ascii?Q?lERTG57xw5Yap4Olh2wNGDES8g3O15VG1KPQNjNC/tBwmMbBMHK7NAQJT+qL?=
 =?us-ascii?Q?GfMGycsrJLf2S7kJi5T00E2gnuVpjXNVf7L6bTE97QawZzjqLdxYq61znEqI?=
 =?us-ascii?Q?7glXa7/R3cpwOA3G6SVja1lmyy2FIWtePvt8irky4wxOU2o5Mf/yJjA2CQp6?=
 =?us-ascii?Q?wKOty8GMdL3mfBv+VFYuxtvvuOREIGEcOezrM2pGTWwxTToCJp4id1Cbjhp6?=
 =?us-ascii?Q?KowTI6J7pQmubniraJTnJVfb+tc9Vga//7y5zVVhnNqRF/wIrdAx+um3pkEO?=
 =?us-ascii?Q?rju1nnqmQShjpdTLDXBANnowB0aqaJU2Glpk0YXsxwl5uj9epIChRoXQiYtv?=
 =?us-ascii?Q?qHc3yCSTOLrs9NlNgai43dhwXL/cx2CWdVGp6LPbcMtwBPJK6BeegkzVqcRi?=
 =?us-ascii?Q?i6cVIBlrlhlFvhTLKd1roNEW0N7zX4JTA8Ivou9m+18rPZrNmztVNS//r7g7?=
 =?us-ascii?Q?ksjR89dXgbYu1iaZ+4sJgPqizJF5MFD2OH62qLNPCc/YUt6oKIsD8YMPEIiH?=
 =?us-ascii?Q?l/AkOVmP+NNOXzWhDNqA8DToguO51siu7PsfXhSGWqp05ErdY/C+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3370f3-adf0-41d7-6ec5-08deb09a41f2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:31.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pC0zd6I01UBlgzsdGNXA5RaGYOG+/3cpCsfaK0ceQcvAGVnZ4F3ZV6ImMKAH8Rf9nnqzUxRFvxcKpwNsZXjhdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5170

db_count controls how many doorbell slots are allocated and exposed. It is
also used by the doorbell mask helpers. After an EPC has been attached,
changing it from configfs can leave runtime paths using a different count
than the one used to set up the doorbell resources.

Reject db_count writes after EPC attach, and reject values outside
MIN_DB_COUNT..MAX_DB_COUNT before attach. Now that MIN_DB_COUNT documents
the usable doorbell floor, use it in the store path too.

While at it, apply the same after-attach guard to the other vNTB configfs
knobs. BAR choices, spad_count, memory-window counts and sizes, and the
virtual PCI IDs are also consumed during bind, so changing them later at
runtime is meaningless and unsafe.

Return -EOPNOTSUPP for after-attach writes. The value itself may be valid,
but changing it in that state is not supported.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - New patch.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 41 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 818ae5999976..524355a8b4be 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1020,6 +1020,11 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 	epf_ntb_config_sspad_bar_clear(ntb);
 }
 
+static bool epf_ntb_epc_attached(struct epf_ntb *ntb)
+{
+	return ntb->epf->epc || ntb->epf->sec_epc;
+}
+
 #define EPF_NTB_R(_name)						\
 static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 				      char *page)			\
@@ -1039,6 +1044,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	u32 val;							\
 	int ret;							\
 									\
+	if (epf_ntb_epc_attached(ntb))					\
+		return -EOPNOTSUPP;					\
+									\
 	ret = kstrtou32(page, 0, &val);					\
 	if (ret)							\
 		return ret;						\
@@ -1081,6 +1089,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	u64 val;							\
 	int ret;							\
 									\
+	if (epf_ntb_epc_attached(ntb))					\
+		return -EOPNOTSUPP;					\
+									\
 	ret = kstrtou64(page, 0, &val);					\
 	if (ret)							\
 		return ret;						\
@@ -1119,6 +1130,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 		int val;						\
 		int ret;						\
 									\
+		if (epf_ntb_epc_attached(ntb))				\
+			return -EOPNOTSUPP;				\
+									\
 		ret = kstrtoint(page, 0, &val);				\
 		if (ret)						\
 			return ret;					\
@@ -1139,6 +1153,9 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
 	u32 val;
 	int ret;
 
+	if (epf_ntb_epc_attached(ntb))
+		return -EOPNOTSUPP;
+
 	ret = kstrtou32(page, 0, &val);
 	if (ret)
 		return ret;
@@ -1151,10 +1168,32 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
 	return len;
 }
 
+static ssize_t epf_ntb_db_count_store(struct config_item *item,
+				      const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct epf_ntb *ntb = to_epf_ntb(group);
+	u32 val;
+	int ret;
+
+	if (epf_ntb_epc_attached(ntb))
+		return -EOPNOTSUPP;
+
+	ret = kstrtou32(page, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val < MIN_DB_COUNT || val > MAX_DB_COUNT)
+		return -EINVAL;
+
+	WRITE_ONCE(ntb->db_count, val);
+
+	return len;
+}
+
 EPF_NTB_R(spad_count)
 EPF_NTB_W(spad_count)
 EPF_NTB_R(db_count)
-EPF_NTB_W(db_count)
 EPF_NTB_R(num_mws)
 EPF_NTB_R(vbus_number)
 EPF_NTB_W(vbus_number)
-- 
2.51.0

