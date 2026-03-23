Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501D1F5821;
	Mon, 23 Mar 2026 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235771; cv=fail; b=vAuCSrP97uR3H/R3tNIRQc3AAPjPcdhn8ex6Nu3bOCvEqpw094/ZgnaobFcAhCgIM1twiQmL2Zl+lzPSsms2OQPRRqGpZQWy4hA7FvY7pSfd/u1eWyvaftEIfbKB7nF5JRrtju85qSadzO+puiFJO6FZCJmfBsHSiTO1j2A9FFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235771; c=relaxed/simple;
	bh=DQSLH26ddC1EMtwNntY7VcJBcfPHqAXdvkDaNeYWJsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8uq/GJt+W1HCljYYIqnF4Zn4DmkWmwx4v/RZ3Tp6vkF7LEUwoE4+2rs4iCM6D2DSm7ng2CVnydKx+D+L0KQ1aN/V/lBVf1RR2AfztVPpnurB4lI7idjRXmXF80E73AW9DRVFD8VTDkjRbdA08W5sroPpjl1x5xtavTfBw3fbCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=l8xCtXay; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="l8xCtXay"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKNLfBoeqyOInO9LkA3cZiHL9/dO2ZnFo25t4XWAEUbSPvfVkrHrVsOxnesyUJNxlBMYCh7hORHmguXNCmM13cHi/pGTvzTm7GztkhrEvFW5aFtpETwge6/6+/Md0YIxxcpOZ0JosJ8HFUe+RA2/tF2oZw2kwR4cojqVqYY2TDPol75WOI5lPSPYbTMZxAFBO/326+8q07vO06c/CstMGZajdbCFLIvKBHaLGrCF4Q/A28kk9Z6+KfzZShc2Dk9jRUlm0xvy0ahB+VBCaPhmeKs/56UoJ2dq87ZfypLROmxeQUt2CpbNws2RKsL8wvAHcDMNpAWoEoMt7KI2nvez8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwoJ4fD8ofZ+rV5jN+pcWS8DvxinyDUWYKMi2mIwnio=;
 b=WxVMs2qwI7oPj2uVj+peFz1fV864yPk31gf8VE2hypLL/rfgDGN0e7vXwpf6Dp8EbMlESHCq7cviVLPyS8lFZpNBHZ+gr3oug5ColCS+Rl6ct+Kq4+srBqzRYZ7WKHCYOuGC5zvUiw7KHSjN75MpauLVK3rrUBvzDc/HeJuH0NQeVxzE5ETCvSjrN8BkdddRoGJ2foxCoFRlkWRUtWIP/xsCO2q982/KGkj5G440Act7uxtAwIewiSYxLVZvlHKYWQ8ApTQi4+kP8Ko49PYKlQgsKMdN0HuR3pgyzMPHF//9GohRPoEK6FAsHRT4PximBujn5Yt6wVSCU+X0HwoqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwoJ4fD8ofZ+rV5jN+pcWS8DvxinyDUWYKMi2mIwnio=;
 b=l8xCtXay2mJGsaEQi1k9ZcYN4GXcJ3d1qXNw6jp7ZmXsuZy3j66Cqr+imKJT1DwQTRTxU1zjY3OtLVZi5JZA7lk5ROVMbygl2tMrReC4ktJZIAB2kPxXJoPPF4ffnakXU46LzB0S0Ws2t+YRap3rVHR7ivr+m13NUyiunZ4vgDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2385.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:16:04 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:16:04 +0000
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
Subject: [PATCH v3 06/10] NTB: epf: Document legacy doorbell slot offset in ntb_epf_peer_db_set()
Date: Mon, 23 Mar 2026 12:15:40 +0900
Message-ID: <20260323031544.2598111-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::19) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a35fdd-e57a-4fd7-b278-08de888a84ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	jKfHkgkS6TZ5cxO6nLz+fnY0cTqRp8oVKWbyaPpOYR+zmqI1muESY7rTkAZfdIEY45IPXrClINqYbBDEGhVhLvfbfIg8ZKW0QSKL5RFUTI8iTTNZb4cNju5fl6s0cg9TYwYDrV1n2cgXDoF7jKPuE4Owr7mLTrIaG9sGBcv8vP1lM5AkBCfrqkX0wC5Z3t0Om64OyjU4x2pJsuP/rWT+gOmz3qjWlvKuBLZLSo60IbatpbsvZYBBwYFgRrrXc40YwAtWma0w5+mBVON8o8/AZ3WNtBfcTWC94u6P7UHCUrmeNjh0GCL6xZ16yqk29U7Ybt6IPdTwrt5k7dvbGTSMn9A28IwuLmXgerx9PjQ/xp+g8cOq74QQdliqPSeqO8gy20A7INXX8wucD/Z4b4Cq9jPt1mvBvcgu2mJXPMs2W+E5cjq55ylh4XRgoPYjZlo0SnJhFD74IjDJWOg9fzcbPlC6tVbRAQVm0502FTIloNVoJb3CpnEgTMCk0lhRO9pfcOCC25BRDL3jfYob6/p9LlcQu7gWdfaYUll/ARYA6FYAUtweMrUOfuY7nkUiy6qHh/vIhWLuA4SfmiGB6Ra0t7sC+4X7XqaWbVdQ0cIcYs5IpBAmmOoBvJvUPTK/gOjexd2AQY00R8uYaY4AVjCo0yIQL2+qoM3CQKBLmikN1xwj2G5z+VVmuIxnLJZtorANE6h0tg3gN+81WBO+5k9aC2dQYkpCLGCKquaJYuEq7P38pLAQXchnhi9+YeUUAmPvRakNk4MRrRL3lee8tJ/SpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yLPgjp8KKI61imag5OThwJRuoNDvDSsK9SWJmmkIHGpKQrfGZVCiddna4zYz?=
 =?us-ascii?Q?b3LqS/mhr1hn1NHYhsRRCIEkd0MVh/3xpHF1maVGegjla2XO2EYC1AGbev59?=
 =?us-ascii?Q?r5hV4XB2LaDuy6U2F4Vd6Fa9yJBrvI//q4r5mJ6TlbRyIG4PhUkMjAYxggKf?=
 =?us-ascii?Q?EQZUQahCA8V7zgPOI6dG6oNmPzk6tqOaY+xocuDlBK8qNU8hUejnO7auUkl+?=
 =?us-ascii?Q?p57ei2fSh0BfNPoDKA+xovsA7pk+Le5RSkum5agE5w7Y6TeZjCjHbNrmYz7K?=
 =?us-ascii?Q?3FpjyapMvJsHFQpgUaJENWECiU8qMF12k78NxfYSzn/bT8OwxibmQYmCg7kS?=
 =?us-ascii?Q?w1SNktLGIohaeBuuh4b/Y5irM5XZr+PzZayT708kNeLyVwuh1Xl6i/bCVyFs?=
 =?us-ascii?Q?aXqYCYTbXiwRuvs3WeD9TjJIsHX6j92XRke/b36TcGhxyNc6C1bg8/7XTufx?=
 =?us-ascii?Q?TN93eMD+Be4NuD/U8DFlBBJ3vB+7+YxIlFaaUhHMHyrzuaZeeMbde2+wTq4C?=
 =?us-ascii?Q?qHYNl4h0mfrUCY2jirdXeXLvI70sjtojCHGcbX/+a6/fpkpidMNmuvQ/pBvD?=
 =?us-ascii?Q?f8FgnVBIKy2DdBbSKlAaSwkaLMqlFnwcGb3GD4U9boK7b89x09WffLwYqIen?=
 =?us-ascii?Q?Y5nx2fcFDIA2rwj2UD3l7v6Ro9+12VHzAublTIqwu14ykyXRjC6qZjsxWC4T?=
 =?us-ascii?Q?rgESrB+M+lKgbFdmPYOdiL/l8jQRzALVOqnGcfyjCkTndyhFxvL/sN9FXKRo?=
 =?us-ascii?Q?dSphnErPxna7T8IpviIe9iLzXPXJRhDFPc2VJBlqP/j2QjXns4uPGWHeV3Mh?=
 =?us-ascii?Q?EfGS/H/8237qMjIcJOj0N0Ubdsu2wUMC33qZDE18FV00rTWrshWHALmBrf4o?=
 =?us-ascii?Q?uQVduQKSzO7A6TyocGMrw4bVOSfPDWGmYeg6HKLSoNsfnXQSYH1t5KaFYZTC?=
 =?us-ascii?Q?SG7uuzjwlZkkGUQtG7nIJ78N8qh2Dn/FoLAa3wiIs5g1wklIiLMREMLFMP8B?=
 =?us-ascii?Q?4fcjSIKkRjAzozCo5HCd5tfz+ODurG0kVdIirX9kAfEeYUg3TtpIsx8yQxDD?=
 =?us-ascii?Q?Mu0s7nZaR3IRzhZJg6sgguOstuaYycghOipdH+sTL8LF3l9pxLWGJHA5MhUw?=
 =?us-ascii?Q?NFTPwY1Y8Wo2pO5DPinks3OLaevhSg9APS+aVWWp8NV2OcQmzVjvMM4ompDK?=
 =?us-ascii?Q?q2FNQ2sZSJb6SPjLKQ1E6X/rom8bLoFSoopIF1jMJxlAs5lJZ4nmBgK1TdOW?=
 =?us-ascii?Q?wv1kz9EenKY+Izp3p06M70mBf8LkyQBKXeke3H5o9uwD9M9zMWXDD2fCRcL/?=
 =?us-ascii?Q?sVTR7htE7PnAu2UqlynR/Zs5f6yISnm6ZnIxFr9K2+qZ/GCQVuRiDTtuxzvM?=
 =?us-ascii?Q?2fhA8TZQFq6r3ulSfJpBxmdVqsr1BvSaj2Wh0VrHlR5emzvQJef0ssg2irqA?=
 =?us-ascii?Q?ttmkpUWCboKRPOM09rcnpZg1FTj2Y5olGXoptnH3wGVeUbMGlUax1EY7kMgI?=
 =?us-ascii?Q?ekPBWkLxgjetJSIZXuYeSOj1E6jCdENxdodnKKKaorkZvLHe0oLYC5iQsgrf?=
 =?us-ascii?Q?wAU5IEdK3Ct1UByVDvNjJhYok6Co4sBZWqoTUcys5XS+HjxV/HkZT1BDPFrP?=
 =?us-ascii?Q?BBk5S8SIbiz84cN5w87vXV8ITILKn4aWeytdOqjHyLko+fHbiSxQjwpoESP1?=
 =?us-ascii?Q?AGRNZeL/tIukP66aRMYXjytTXgiBQoKv3ZIGVa73aUgTYedgWEY9kmsiLaDU?=
 =?us-ascii?Q?4zEz44CfcOZDHclyw4mo9dkQYz90v3cC0RV/GBpSUB37W1tJZm8h?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a35fdd-e57a-4fd7-b278-08de888a84ab
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:16:04.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95D9M5UQErCAhbRNM25ogxFj5MtI5fvFwUYSolABD6LVhIubC6BA+xANAEE4wj+Sz4HvVK5Y4Yy5vZHoDgce8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

ntb_epf_peer_db_set() uses ffs(db_bits) to select a doorbell to ring.
ffs() returns a 1-based bit index (bit 0 -> 1).

Entry 0 is reserved for link events, so doorbell bit 0 must map to entry
1. However, since the initial commit 812ce2f8d14e ("NTB: Add support for
EPF PCI Non-Transparent Bridge"), the implementation has been adding an
extra +1, ending up using entry 2 for bit 0. Fixing the extra increment
would break interoperability with peers running older kernels.

Keep the legacy behavior and document the offset and the resulting slot
layout to avoid confusion when enabling per-db-vector handling.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..bce7130fec39 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -43,6 +43,18 @@
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
 
+/*
+ * Legacy doorbell slot layout when paired with pci-epf-*ntb:
+ *
+ *   slot 0 : reserved for link events
+ *   slot 1 : unused (historical extra offset)
+ *   slot 2 : DB#0
+ *   slot 3 : DB#1
+ *   ...
+ *
+ * Thus, NTB_EPF_MIN_DB_COUNT=3 means that we at least create vectors for
+ * doorbells DB#0 and DB#1.
+ */
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
 
@@ -473,6 +485,14 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+	/*
+	 * ffs() returns a 1-based bit index (bit 0 -> 1).
+	 *
+	 * With slot 0 reserved for link events, DB#0 would naturally map to
+	 * slot 1. Historically an extra +1 offset was added, so DB#0 maps to
+	 * slot 2 and slot 1 remains unused. Keep this mapping for
+	 * backward-compatibility.
+	 */
 	u32 interrupt_num = ffs(db_bits) + 1;
 	struct device *dev = ndev->dev;
 	u32 db_entry_size;
-- 
2.51.0

