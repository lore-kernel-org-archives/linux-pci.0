Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99B334C34;
	Thu, 19 Feb 2026 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488809; cv=fail; b=Flp2vStz8VAfSSi9QdBtyXFQ6731nbUm+mvRFeoXW6Br9L0NddF/9ryMnurNuS610vz7BVc63/Uk5p6MS/uNKvGuEE62lDoouWIs2X+cQhChPym/mTQulrNgTKJbX0lZt1ABkY4FhXy63vC9oAK0qiuVyw1wh+cNDbzxTx06woo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488809; c=relaxed/simple;
	bh=4kc/Dl3fa2WfV7hQIEVn/Z6caHLBHWFPVT8UnVtFkco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0r2aaykjIvsnia8HcX9wNLK+sxDzDgY2Wcg9BkQEQp/NOJwdMZNiGphvscYX05pqEUBGi5+0ywrkxAJnbRtIOgGVoZVVTUGN/AMhjJ3MfIkXkF2vDt3fUQOqi3e6DV7MkQ7Ws6ErURYWKfPu3wDr4OcpTAXAMAtNvgUp9FSH8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qlE7o7G2; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qlE7o7G2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE1ipwY8goINeNZjVfW0I1aaFejVzTghYKYwQMJvx2adaraGQ43lNYRstHo/yhjMssIeY0BrgBd6BHNTrYhDUlD59B0xoOkGN5H8F8WaU8+JB+I7YoJapJ+R1ifQE2xmfzk246N3K4NVr1stPTOS51tNJZbasNjRYnk32xTLD4d4L692NQ1RQ70mXI+initj9eNzfQvDAh2IfDByHXT7FskI1JLveNQ1y9S/NywPcfWJ2oIFwuKhfUwe0HSpgMpQizelnEQMLioa3jjmJy4Np46JKw0npJ9TTNvUJ5R2706k5MFncZ2gwQneQFMLYoyJtX8L4x3oIpUzLAOzMpVyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU9Om7ps5PYQ6tQtBQfQF23SidFjmj9NTXGez67BRDc=;
 b=cz7eRwrVcVflotNbuMyV1vUYOOSo1ZA388+C2knoD8cZe1GHBSlG1wW6i/JIRavMm8b58K8tVXwCzFsyqduLEd/M178UEV4rJTz5fmB+jOYflMO0qpe2sr4ho/CvKRhoQ+0b7rgLos7JhUIOW/TTpyIWPmKvDs8jccU9vRyRtNNDwyCEBV+h3aar1zQYkbk5Ni7dVCnNE5uOVIR53kg8ZHoP0qEZ9ZBurbNizQmEKyK1P/e/pZBKSCW0L/5ZmszPYJGla4L5G1ybPjy6ieJP5ab4sZ0M3opWOMPafbeXe6rCVQwIP8JawzIrzbtb1DS2lEhNyaDDdhSWUgSjMIS2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU9Om7ps5PYQ6tQtBQfQF23SidFjmj9NTXGez67BRDc=;
 b=qlE7o7G2x0qZRfp3gxrtkP2/Agk6OCU7gLkdvfxY9D2LZmW/kxnq0vXKUz3bhky6QTLL2kbSPXt1HXREgKGfOVCyXM5JrGdvEPb2cCvxhR4uQPFDqKaRQeGtcs+VCm/wT5rXuFobsaCRbiGuvW+d1rXkHEC5qjXG2PA8VWSzuxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5862.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:13:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:13:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 3/7] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
Date: Thu, 19 Feb 2026 17:13:14 +0900
Message-ID: <20260219081318.4156901-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219081318.4156901-1-den@valinux.co.jp>
References: <20260219081318.4156901-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4c53e0-a803-49ec-cbaa-08de6f8ec072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TyPSIhccE0x+5dx0lbMjnoH4KFsv5dTyLRPLRVwtfC/8t+SsPw9LtvUT8PVL?=
 =?us-ascii?Q?qLR1yoin0+HHWt/vsRFxv/6129QEFAoob0hjdHH4feIN0sxfisJXBxxd/PA+?=
 =?us-ascii?Q?MGh9gf9OuH8Lri7VI+vfm44CZnnZrHT5U/IqaT8VIpV/+o4Yjy7IQhBQfRFd?=
 =?us-ascii?Q?aNjOonlz7rV34oW7GnkY1WZkqZF6+apvPAbFlkoslRvLFaCFsq5wHZQxC6fj?=
 =?us-ascii?Q?G97lQDOe5PENp3U5A3XLBgIIpviFdjarQVeHAr1hrVh3SzPo+Y3WVIF2EiS2?=
 =?us-ascii?Q?4Rb1cZz0bZ42AQcNYPE2bhx8eErbKQuVWJ0IGgORErYtc0Wj1JszZbSznFep?=
 =?us-ascii?Q?A1PtS2E10T5PehqpsHVG7bHzHORkQl+Es4whrZ00VAJZuPsCRrIwfzku5RmS?=
 =?us-ascii?Q?EGcZAe0n4WdSk2004dwUBe9bCEf/i8L7VvUVKsCygYHOW2xr9zyS1f3xc0CS?=
 =?us-ascii?Q?6LNQR2MKZCds88KfCa2g0tX0xWycYmPHav1f4ImhNq2+haHbsj6jWDXGTI+q?=
 =?us-ascii?Q?4OEM+60L3x/jE6rvTjjSC8fDLa+95DkuWth3Zg8nMxu/tmWJMI/ll97s6Ii7?=
 =?us-ascii?Q?6C3p1vLoz+AeX0G2I1GwZD813jDpjf2sMS8U1nB10OsqTfx4MzsxDLmCOYhQ?=
 =?us-ascii?Q?2b+IKT34/CPnX037PmsPaJXrPeLzC8NL85Vn95LwUB2eDtDtNXYm7QXtSjZq?=
 =?us-ascii?Q?dX5baujx4ohK3GhRSoqbdF4tY6h0akZ/gMizV2vcF9Gxb6tNcZb8jSqM+vQw?=
 =?us-ascii?Q?kmTxE9VM/PK2MR4jnLrJlCTqpwKjw1XyhPH8e7yDDfKQW/6M58lp/bK+xjO6?=
 =?us-ascii?Q?p1SuS/GmAQcY3Yvqn6qHyjNNwG6ELz7vGVmCSh8L0/y69rd7oODKeFYdalG5?=
 =?us-ascii?Q?uY3QVfB1Ita3qutbSjj11oRjrp/pYv4lAZmq7EBxnpMjCKrneXmBIPUDa4jz?=
 =?us-ascii?Q?j28Xsz9HStySGfF8FFrcbEeC/LwXitDEfcvZRGoBMiMpmJCuFEPzkVhLp2HA?=
 =?us-ascii?Q?quRK7SOWBMOVGGHiIZ0Ug2wKozysCcufpn0VfJhythvBRpDNHVbarzqecgGG?=
 =?us-ascii?Q?sbwB9Gy8JPtOS6iflkrnJu3snBP6pU7S07qw1IETW+Hubxyz+GRzM5mgmh7s?=
 =?us-ascii?Q?K+nGW+d6rhrGrj6hvi8aXN47NE+4Tct53B93pEL8017VzznCOluymh8Opx3a?=
 =?us-ascii?Q?yDeW9bfLUGYvVxiyPuIe7HdJQKO2dfG17f/KEQ3F36EQ89ikXgIPrcaqxfYQ?=
 =?us-ascii?Q?qIeNz5vBGYW52Zm7ik4nhUZM4XHYEJOFWOUMO4Nq0SUGQK01M3FYWzbG/XNL?=
 =?us-ascii?Q?SEcOw59LHzrZaQs/qV9F5elB5IM6j9hjsEhGe6OGz7i5zL59v9wujy4AwA7l?=
 =?us-ascii?Q?HPMWfFpFz6qEwG2CzzFOrZ7zYc2I2aXIwJJ/1i686+0pmwYugVe1+l8gZ1Xc?=
 =?us-ascii?Q?h1AAteYbXglax/rCt6Oqou7jTjcFBq8iRS15AbEbR+Pa9q+ihv6VFiAmXGEs?=
 =?us-ascii?Q?dTv4w/wBgsVwPRkDx1r4yIYwoQomAt9XM7Z/DG2V8xd6GL4IVvQd6kf5k87B?=
 =?us-ascii?Q?DJMrb9NFK2UCSYLGsYE7AzV2otKEKON+C8pczfMSq0RAjRnIf8YcVnolXPte?=
 =?us-ascii?Q?mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8i1YTrGWT8Lzc+4kCVvVSK+r0drVpDvuH0wyk8E/gH4A525LEAz9yZvb6qq/?=
 =?us-ascii?Q?b9VKKsiTr0+kZ9Ig90etHJlJJMT+4EVvre+7o0tRO02yZcbJcI8blTp2qtLk?=
 =?us-ascii?Q?CCUBkaLh7Cs8Du6/CmMApR3vCV2ZlujLRpy3qMTy7R+3OflhpkxHUCYCdseH?=
 =?us-ascii?Q?pyG7uA/oAetNmFv3J6YQGiDtgogMyNGRVUY/TBdJQZpfaPxnJ22WyqLBspPi?=
 =?us-ascii?Q?tPJu5ZvDEAKZgIzv6U6gaYL0BOGdqQ9nu/dpnB47Y2jUSCjSVkVm0tg9ad/S?=
 =?us-ascii?Q?og9Ta0KbfzZ2CaDHLTnhNGKtu6FRReMyOrtVUBe61HnTaugJMaATvBozvs7E?=
 =?us-ascii?Q?lGM9e1AU6RbM1oPzRTnkPI8U5KC8XJW57Uv/W/t5ShAiaGPz4Wd/etRY8xBc?=
 =?us-ascii?Q?AxfdquR1YKAaDkMfgKu7OX0tUkxyt277wZ3X/+TVJjaANdAN/QavjhQ8Drm6?=
 =?us-ascii?Q?TYqDqzstRCFn7QeTDlMeFZEM10YsCGJWwJL6PhT2X7Up52lMWVrcfqFi2LnX?=
 =?us-ascii?Q?oWDk8u2NUFHCtiLaBpAQM1fXO4fW3d+UfOtOvBkFPUcVYdSg8EjCI9bmNL8n?=
 =?us-ascii?Q?80ycateqmKm4XFpFjBfxhkFj1KGhxZXvSsGHKiKbXJKLNg5UxYnzp4dAgyqW?=
 =?us-ascii?Q?ZPOLJegwHoIFLQ/rdOf/k6RPVACRhKmkE0qWdJsJgoToQaf9AjPm9+Ho/CQq?=
 =?us-ascii?Q?D3Wlt0dcT6mcpYl2sElh//FKb69ZJLQxnAvF/2/DK5K5nPw653YqV7deI2KY?=
 =?us-ascii?Q?AhoKTYkxR513xi6iNs9VWHRLVN3IQUAr88cRg68+4q3esD24c3o1kLv7/Lwt?=
 =?us-ascii?Q?oiIDNGMO4KMM4vANPRCt+MR2RWMpWUVa1/pSreCQ3fCJYCD1Qy/D60n0DCrc?=
 =?us-ascii?Q?2RAemwQkoSDB6kDQM9efKyXoD2FfYsXjd47wdxHUucLLOUAPCemDTUJb+zH9?=
 =?us-ascii?Q?Twq3WQU5ZtczLvnrCM4xL/CI5mc/yOe94SGlbTLZRM/qxk8oDwErkSceYQmY?=
 =?us-ascii?Q?dfnmoZLdlL+dOwkmUObYuS1AM7jWuIkQQHYR9ZcSce7jFxg9a6TaxFLYP7sG?=
 =?us-ascii?Q?B+AEDGG4JI/Qo71WJdtChe5AJh7qzTScMnHs/AF79/tJVW6dS2s/zSCxwHcF?=
 =?us-ascii?Q?n0GtVbunsy6xlIPyFlytYk2genD//1s3v24gZItMcTynfDj4SMpfMeAXCGF5?=
 =?us-ascii?Q?TiBYppyGKkqidiDcWNfl9NFmW3ZRRhxT1QTysK2AKx9c5bTJY3698toFEki0?=
 =?us-ascii?Q?CPWf8doFDW5gCDujQHMMEO5X9fy1VRDZd1Nid75+9aKHDGX+uTKn1pMwgabi?=
 =?us-ascii?Q?pHn4+nvu8Bv0eQ+PKqehkvc40YJhsE2QecKYNJ+AjKchmCspOpx04fUVSvxy?=
 =?us-ascii?Q?RwzudKdSYwM714DCMN0C/FwswzYIC94mSes2L3+D4ZX95abyICD6xcNM62nJ?=
 =?us-ascii?Q?ld3LzGMS6Z05BvJAIY4Ka71k2HyeXRKSk9ifi0sLjUQrWmwtzGjvjklzSm8a?=
 =?us-ascii?Q?L5DH8yRnizfAHZ2ZbyvLFVdesB4OkWv0bW+TOhKRCVgSORsB5K7SC3vfeCvP?=
 =?us-ascii?Q?InhWKadTlp/f9DhKc++byUfX+Mf950SZhtIXIdK0RWd5i1IY5WcuM02Zh0Ow?=
 =?us-ascii?Q?ejK7ZsHAE52148tg6mrfI0UFxw0LfeETyC3rSbe26UElCeCiln5FS7qbBa5p?=
 =?us-ascii?Q?1blpvq/XpSkXQ4zbYziNUsna1yYnjwa4hwHqXCAyU+YI+2HX3XodMinYA8Us?=
 =?us-ascii?Q?bZ0kOb6ARq6t/KakutAA6Ka8rXJf9RC8hd3q1rmonLSrKhElUFPq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4c53e0-a803-49ec-cbaa-08de6f8ec072
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:13:23.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq4QcnpTEdfw9m75BGvZpdQ9LbyKWLnMMA+rx7f3Ch5uas1vZpafIvQinjm2qyjH62wY4XX9QleuaKR8zel5WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5862

Implement the EPC aux-resource API for DesignWare endpoint controllers
with integrated eDMA.

Report:
  - DMA controller MMIO window (PCI_EPC_AUX_DMA_CTRL_MMIO)
  - interrupt-emulation doorbell register (PCI_EPC_AUX_DOORBELL_MMIO),
    including its Linux IRQ and the data value to write to trigger the
    interrupt
  - per-channel LL descriptor regions (PCI_EPC_AUX_DMA_CHAN_DESC)

If the DMA controller MMIO window is already exposed via a
platform-owned fixed BAR subregion, also provide the BAR number and
offset so EPF drivers can reuse it without reprogramming the BAR.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5e47517c757c..2408ce95c103 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -808,6 +809,155 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static const struct pci_epc_bar_rsvd_region *
+dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
+				enum pci_epc_bar_rsvd_region_type type,
+				enum pci_barno *bar,
+				resource_size_t *bar_offset)
+{
+	const struct pci_epc_features *features;
+	const struct pci_epc_bar_desc *bar_desc;
+	const struct pci_epc_bar_rsvd_region *r;
+	int i, j;
+
+	if (!ep->ops->get_features)
+		return NULL;
+
+	features = ep->ops->get_features(ep);
+	if (!features)
+		return NULL;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		bar_desc = &features->bar[i];
+
+		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
+			continue;
+
+		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
+			r = &bar_desc->rsvd_regions[j];
+
+			if (r->type != type)
+				continue;
+
+			if (bar)
+				*bar = i;
+			if (bar_offset)
+				*bar_offset = r->offset;
+			return r;
+		}
+	}
+
+	return NULL;
+}
+
+static int
+dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			     struct pci_epc_aux_resource *resources,
+			     int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	const struct pci_epc_bar_rsvd_region *rsvd;
+	struct dw_edma_chip *edma = &pci->edma;
+	enum pci_barno dma_ctrl_bar = NO_BAR;
+	int ll_cnt = 0, needed, idx = 0;
+	resource_size_t db_offset = edma->db_offset;
+	resource_size_t dma_ctrl_bar_offset = 0;
+	resource_size_t dma_reg_size;
+	unsigned int i;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	dma_reg_size = pci->edma_reg_size;
+
+	for (i = 0; i < edma->ll_wr_cnt; i++)
+		if (edma->ll_region_wr[i].sz)
+			ll_cnt++;
+
+	for (i = 0; i < edma->ll_rd_cnt; i++)
+		if (edma->ll_region_rd[i].sz)
+			ll_cnt++;
+
+	needed = 1 + ll_cnt + (db_offset != ~0 ? 1 : 0);
+
+	/* Count query mode */
+	if (!resources || !num_resources)
+		return needed;
+
+	if (num_resources < needed)
+		return -ENOSPC;
+
+	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
+					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+					       &dma_ctrl_bar,
+					       &dma_ctrl_bar_offset);
+	if (rsvd && rsvd->size < dma_reg_size)
+		dma_reg_size = rsvd->size;
+
+	/* DMA register block */
+	resources[idx++] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+		.phys_addr = pci->edma_reg_phys,
+		.size = dma_reg_size,
+		.bar = dma_ctrl_bar,
+		.bar_offset = dma_ctrl_bar_offset,
+	};
+
+	/*
+	 * For interrupt-emulation doorbells, report a standalone resource
+	 * instead of bundling it into the DMA controller MMIO resource.
+	 */
+	if (db_offset != ~0) {
+		if (range_end_overflows_t(resource_size_t, db_offset,
+					  sizeof(u32), dma_reg_size))
+			return -EINVAL;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DOORBELL_MMIO,
+			.phys_addr = pci->edma_reg_phys + db_offset,
+			.size = sizeof(u32),
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar != NO_BAR ?
+					dma_ctrl_bar_offset + db_offset : 0,
+			.u.db_mmio = {
+				.irq = edma->db_irq,
+				.data = 0, /* write 0 to assert */
+			},
+		};
+	}
+
+	/* One LL region per write channel */
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		if (!edma->ll_region_wr[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_wr[i].paddr,
+			.size = edma->ll_region_wr[i].sz,
+			.bar = NO_BAR,
+			.bar_offset = 0,
+		};
+	}
+
+	/* One LL region per read channel */
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		if (!edma->ll_region_rd[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_rd[i].paddr,
+			.size = edma->ll_region_rd[i].sz,
+			.bar = NO_BAR,
+			.bar_offset = 0,
+		};
+	}
+
+	return idx;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -823,6 +973,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0

