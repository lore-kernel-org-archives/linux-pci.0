Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020081.outbound.protection.outlook.com [52.101.229.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AB2DCF67;
	Tue, 17 Feb 2026 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315579; cv=fail; b=OJiVKARCKeyWDrV0pqMN7ODv/gccQLt8BGSPnCyLts1QFRFp9TtI9e6eMx9cpwFpbF8mbaFEJHLeWkOnf9rGAnxLI0s0wAw1msv7RYf5Pwg5FrbYVvoI+ank1o2YV78a6x4WyHhmiFX+ZutFKnIpI354cdx1zy6utKf90XeNExc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315579; c=relaxed/simple;
	bh=ow9Rvr7Xa3d8sCp5pYSBL2pgt0eQ7sbODVSx/i7UriE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wj9Uxi0PbV8zSsEJNvvZ9hHXI99cwhCrhtjAu3LA6ScXq9AwEHIj/8UEksD8t3h6Z7xWwifpakMEg/o45UBKEAvpd/OlxwiiNT2xvKHhYMrdBiZZUWSdOrjoFNDDvvvUuA1QCdr2KjvOpPyviWdSrp9mAlb3svFTKxUQc5Uwzk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=t6DOuzWw; arc=fail smtp.client-ip=52.101.229.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="t6DOuzWw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syyBoT2++IoWwAFVFoo6mkX8+CTS44RCuM6n6TiJDyvf5UftutTZ76rF6PJPBg3J0Pdlxoq0ENmmlND9+D1zh1hRayFbbnCBBKFnO/CqdIRGF5Yr6880Z59KSioABa8dkO9s29GH2QhcZUw+bMsuBVRCC5dSpYplCDKAe04jaQYtRyA4KF0r/34T53MXxkApqhDXIubNHPpVdw2JgxRF2pcH2gHz8gLjgFvtdikJ9ptwXG+dz//IUhqx0GjQ0pjQbbLZf/0wwqkquWqYh24II7vxsakzUs144ANrifeDEDHG8HH38QLQywdU6Sf/Pz3FjLZx1c8JRjvWsFOooYnJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3y/7aay/Q1opMjEwmwzIo6Z4aSJnX3go3WXe7OfGjmE=;
 b=DxFEERiA9DwhZVn2c1EzP1RZwUORbKuCseEQhewWMfE1fpjnSMT1zyqB/9SOcqhl6+KZAPnnXqBTtm+mgYIiYzrhxi67tJAjpxkep/5TxUSnHfIyZ617jYF/bmj/3Z+vOkdHail/L2T8LmPCSWpYhPG/N4aOvB2VWsipYDIAPn1EQDo8z397tdFS1Z/2+4V6mMHR4aFP5/nzzYAVcwfqLpbwRqgB4/SBIpM1MoWMU9bqB0HqvKATUSX74c7vHy3iqxlz79mx4y0mEdL2vVeVl7p0QwmcXQ+Re6AJYJFOKnYCdJk5qqTcSGlap2SpW4WgTHddcYWrglIXwRSfGpV1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y/7aay/Q1opMjEwmwzIo6Z4aSJnX3go3WXe7OfGjmE=;
 b=t6DOuzWwih0qfdmS0vIdkIPW0UvNwxnur8iMomR5YusO/ZudFFFh1/39PvD4mAr4YRKHL2m/RC/iVQAoj2azme8yb4MAcAn4yF+xm5pHuiXvPPUiTwduMa2KX1e6IbpVx3iP/ia9OG8RTCFwtBxZXTcI0NmU5crT9qcs95cKhgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 5/9] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
Date: Tue, 17 Feb 2026 17:05:57 +0900
Message-ID: <20260217080601.3808847-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217080601.3808847-1-den@valinux.co.jp>
References: <20260217080601.3808847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0116.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 62545fad-ccb8-4051-1fb5-08de6dfb6a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RhN3ImB8LUxfhwAxI2NFlgVl+SThf73RhVcL0/lQKYFLlxY/UCfQ4s88ld9Z?=
 =?us-ascii?Q?Y0ZMnNyJDpQX05nZQfSTZ3DlFvn5akhRTphh5upZVUhwGSCcp4z5jWECqN+l?=
 =?us-ascii?Q?XDoVNCGU0JHv1iuBFcN/Oh5RuSbt8IbUiXHIjFN7OTcB/9g+BMKN5+8XyJtH?=
 =?us-ascii?Q?BKXHTLckg89G062cM1wr7/mZy/MYRnRdevPXJKOfKNCvdMHPB/uglQzCNnTM?=
 =?us-ascii?Q?qUhIvZheaIiQZjwsIX6XSjp54T43FnJIfF6nOvUrk7FHvJGHzvthJOMoao0H?=
 =?us-ascii?Q?t9B/1vH4Drcp0uqPL33SOK+go1S81XYzHRE5nWQXLPayp6J49x5HsOQ6bY2U?=
 =?us-ascii?Q?ScwGe9HG2KPWdkZs3n6AXxlQBtafKbrlHpYGZ1SZjdqMjykuM1yI6epMv2Kw?=
 =?us-ascii?Q?1oXARzMQ/fexIaE3M7LKV44+T1t1ckdKJgsj0lplW7t0kHa7XLdZ8X4dfezn?=
 =?us-ascii?Q?hSFvQc8a92xTBvvCmZMsGH+g65LhsAdjklRSj3JN+sPD7/PYbDJFo6czg0s8?=
 =?us-ascii?Q?32UV7P/LkU1rzMa/L9rNTcBKZjxeZ41KiAWWF3hAVep7WHtjB1kbQqqaYSX3?=
 =?us-ascii?Q?Sd8T1lYBZxuFUuAlU3jy+UOfg8L3Arb2nI38oMpwONikMU9HrpOAW6nnMCHv?=
 =?us-ascii?Q?5PjAYeSGz+CcBCp6gb+WKGqtjRSoRPIyIfVseT06TAYuEAVrJ7WiRM4K8yNf?=
 =?us-ascii?Q?ta+1SJumon1PVZSdrYIlEW9xyx13ye1vztdkZaIEKfqrslthNXs8wtVGB0tx?=
 =?us-ascii?Q?14bvKskN3WwV6BwgyuKPcl8LACNILL8qaLkLGGTJ1Bql445xiZ1dZcKDeZCN?=
 =?us-ascii?Q?NK9TTseLKGNiFasUzhbcdNkr2UNO1J0722yf8LalcKZkeBMj8S++OysUPEd+?=
 =?us-ascii?Q?iHsRVIYsXtWVQ6N39L+oh5A9UPr/l4U3qnhvW9Y12Fnu8FfEgCIsWG2459AR?=
 =?us-ascii?Q?daUFM+G+kQ7zljB9mweLr7ojost5TdUAcFcbFZeqmCYKCAZ7gI68c51YdL6C?=
 =?us-ascii?Q?+2nr1s76VZURjWtNdAsl5HSo1XOpEIkmXBfF1wV1P3SAhuS/sGwog5iHQ/sn?=
 =?us-ascii?Q?Q1S/LNKclIHAqNVqx83GiUkvED+BP4w+XSXE8cZRKtFUpvZa2prvAaNsAMq7?=
 =?us-ascii?Q?lyjsFgIXcSVN83e5XUpddEkeKHI4Ar77TKbnvvlwI1U1X+B7O6qP2vXWSRdX?=
 =?us-ascii?Q?m5C7H/vqR1sy57oImM+U0+cCGVsUezi/8TQU8BkB/pPfWcJOgfDIdmbeZ/fN?=
 =?us-ascii?Q?HvzWUPbuMb/7pOmt4yVpKMahzwxWGIreGtz+S5pf7vWH8qT6gGEoq3fdsGyp?=
 =?us-ascii?Q?sF95iLWt8c9gWJCF7TCZSlhdHWpAJY6Ob2ODKAzMvydaYriVQDunfq+AaEtw?=
 =?us-ascii?Q?I2+DG0kfLcIAzTO4RNwwYopmqsX+h7+ax8rWn61OkBlfa1rtPKzCpU4C84DL?=
 =?us-ascii?Q?QgQSKRDTBK2QHB0a/x9HgqWI/37Z7MaHpUCxf0ZWa87i5Rbp99ed4vZZqX4k?=
 =?us-ascii?Q?Yz4oEbOdalgZNxe/5YSJvxf8stclmihCxjXmu09Yx5yljcyOMuxwgocZ7qtf?=
 =?us-ascii?Q?4ewbzZPNoR+xwUOQEbyI5Iq7I2PHDPE9+sv6audX2iudKFVN46X8BZU6HbCs?=
 =?us-ascii?Q?hQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ee0W7bNaOmfz9UZX135XPPge+4HKhHwAnWjb/8TMOUZFwrThd2K0LyXRtzbr?=
 =?us-ascii?Q?/JGOAMS0jHwzKc6feoV9csArGIuXRaSZljBM5GEq0njf85JCQ88bk2zYi/5R?=
 =?us-ascii?Q?NxJxGLoU5O9pAu9hS9TMZV1d9wE/S/qHlDlpJ6bBz3zFGXDKQG71ATz7oxBX?=
 =?us-ascii?Q?m/t0ON7gJCUGVHqLq09HbRekdwD6YanAoIKC6usdViFSRsNerorP7wntr4s0?=
 =?us-ascii?Q?xDMF6tOwJbRplNfpjaPw0u+N3Ud35aTW+25Af5asINFMiDdvCp/Tqe84epVL?=
 =?us-ascii?Q?gbN09zW6SzKraxwTXyhpV8ymGz62aHYHGJU/JPQBiv7KnU/HEvZAtbITmnke?=
 =?us-ascii?Q?bd43P9qmKznePD6g7bd9vNeUAk9f8m33EnZp1ZJyz6pzPRrpKaJMWUDx71Qb?=
 =?us-ascii?Q?4o751mJ1qvr4qfcU0LKOSP7V8ICQeg0qVDRlImj0Vfk7Uo3eRSqN2ca2Z+mt?=
 =?us-ascii?Q?BPZEgWJ//tTPV3LL/ClOuz/1kJks/n15XUirZ3KFT1y3G8I93Orq2Nd7d+Zd?=
 =?us-ascii?Q?7A49FueDn3ByFCbshEltJANe61Pr66UuwtVGYKLXV1sXHiufjtl3e1RYb5Zc?=
 =?us-ascii?Q?kYR3J6e61D7LE9ePcBTnHVflnwNXamSOTsHQFz2dusJ36qm95OgdfK98XUqd?=
 =?us-ascii?Q?wqGbOuoaAooZvT0cAwe6tzgTISkzJUv3QQFkS3Ssg4yeVCdtAf+dBYb0yH6o?=
 =?us-ascii?Q?qwsZgkj/QOCtRDGxrOHogJDyIX1KR5WRcROblOXyga9/B8Rnvg7jZFEJC7aM?=
 =?us-ascii?Q?SU1VzvGUQyUGvqM4oZ55LBH7eMxO7+1FNiHQoYI0nrrYeegIweNYIdE7eUft?=
 =?us-ascii?Q?wh3JFf8Bqhx6nC3IJhQAkHOaeyLLDkLWvqIDBldSLqLmdd7XeIzkPnEuQRhd?=
 =?us-ascii?Q?hWMc1xTdEWpL0IJ9UxJ+Vt4DUYfr4qjjxB9Awqwm5xAqwGWFrDLeEyRzU1zV?=
 =?us-ascii?Q?N+yFBRPzfnZGupTBeD5DjL2JJekwbNc/abDYmsmk+x0oXCc5GmeMY1Bz7MWZ?=
 =?us-ascii?Q?GP2C/FnvB2+9ZHJYrW7n+MGGSR6MCK/hEwoRfbab5pstT/wlEdg7T8ROA22n?=
 =?us-ascii?Q?52Qx/pz2yhCsPtUBrVI0nYXPF8fPeksuSVeXu110noK/4VmWyUuiTYFggqFv?=
 =?us-ascii?Q?7HoG1ziBRy8GXpfDZMErTgZXXhnwHYwxIMixYa+M0y2Ww2cBje4SwzvykHPT?=
 =?us-ascii?Q?lL9AQlPa4Z2QyspGizVIRxnPDBhqZCZjB+L+qZ3v/+eXPmm0zdRHwwRLJS1W?=
 =?us-ascii?Q?cI9tYKIFmngMMXkUdr+U3Nsf6N1c2u7ybps2IouzvEm2S9FvbK4jkWNORNVe?=
 =?us-ascii?Q?xcwcXftXOcoPfcXGN56rM861YqEV19Pdhp6OgnOPmm4lZjiBWDX3ufQpmEt+?=
 =?us-ascii?Q?L8gvI0t3vut+BQ/4PJdR6nP6iXW25JdqRyO53uAFDgLAT1Joi9SBHck/VIh7?=
 =?us-ascii?Q?CIRW0yjPJxwwhEgQCivEXOCzPtm5QPsezQ9mjnencUchcWW55Oiq8e14miVT?=
 =?us-ascii?Q?72KCEDzUwisZphN6bEiFGDykP5EYoUnN7Pur/+30nAghapAU80RRa8AZPRAB?=
 =?us-ascii?Q?QULwPDVK37d0SWWLb2TvtFi2wsftIlyXuTKaXZaMMGjXpgHcYgNrz1+pL1du?=
 =?us-ascii?Q?UxnZI2pYtGYF7t9myrS0dWhVX6gpSNqMwxr/t8NCxzN3vsO6THKi3tRcNxQH?=
 =?us-ascii?Q?EgnTupXUB2nQxNFAP4+/aRj+TNdMNgndqslHCZ+Syy/Zi4Kwx8A2/q6h3hir?=
 =?us-ascii?Q?NDLcslx8iWSMqx5XNCqcxMPZoQqXoOr6lXqpJgdqF9J+ZsEzC977?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 62545fad-ccb8-4051-1fb5-08de6dfb6a1d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:11.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghjgU8an8G6AJGBv2fHL8qWY0q1Ng/WWEFMDheY1F6mQgT8MHcp6fosmfXxyuyuhYMiSls31+XvpGmNH/Ws9Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

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
Changes since v7:
  - Use range_end_overflows_t() instead of an open-coded overflow check.
  - Make it explicit that the write data is 0 for dw-edma.

 .../pci/controller/dwc/pcie-designware-ep.c   | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..22b6777d520f 100644
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

