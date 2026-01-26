Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1B2C2340;
	Mon, 26 Jan 2026 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411770; cv=fail; b=WUy1P4uLMX3KSiT28VDGD1dzvpikiahgC4pyeoj4EdWHXLZdmauY2CtZyqCv0J82kfHOULsi41XSJpCJUkFapUYmGq0jDguOi7+9zB7/pRHRbs4KJxpuAOy8R3esvJnyfvkYLVVRtE+WPvcNM6M4elIB7pOSZeBhfFGThYR7R+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411770; c=relaxed/simple;
	bh=Bf2Ec5QBUM8LeNhHeGkTL8aWtbuHrkT4Rc1fBrLB4L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r47/Cntwcq79O2eDbOh0wnHyh+R64+/E9cK+IKGifBf53iC1O6N7DxPUhfYU9KTAtRDfO/g1i+uMIZNm9T+l7j76FEE85iMCbLuMRHtOeo2JfDist+9eStnWQ0/G81DK/1LT8PwB2ksPUch4ViWHsSlnLHFL8fCyz9NoJMlmntk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=u4hdTm79; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="u4hdTm79"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL/Zgb6mxt3LttR8wTAT/xQCOjM7uyz1ep302mp7gDqaO8SvByJuVQBHkf1+Eds7cCL/j+gvtijQzGUEqyqP3pgnPokRsxGOz7KNRWPPXrAQbMgMLKUB5xH6PLLtkpYkeMp0+rt/p1Ghp038ZQ8M5bcHafLx/aTAFGUvyzk2tBlimGriyUlGuGrGdnDyfuTAgqqHohPu1cyfcsb3r6z0xZ3eJWO5Y8NmfLBMaAQszFiyBDd1z+KYuxMtS0jxGjAnVVUly9Ct47Ik6saNMYF1f5OFhUJzVE9+mmn2CaLBhdtHf8Ld4uZhso5zVr09p7ja5hV4ovkPrumxdz0KOR6eUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF9A79SBr+lIwHNoh88aFS+QAwTiruwaGBVdzONKrCk=;
 b=qY36nN+UeUzJxAfigbusrT0ZYUqu5PexQxg+czFsbOPKE6WlJTXOomTQaa1Iz0eqCDNfU3kzYuQ1lUYbwueUoYkzI00/2MFREGAz7TJEeZnsJHsSWxWUSUTJ3ULTzoPVv1sNOyOSHZLqUK574ZYccDzXLjnimw7eMZ6MPRaMDTKJsDt0tEjAYXGtHcjcDa+NJrYWSyE6cD8yZ00iIpRJZdOc9G73Y2dhDsEKlF5aw48dKxfyPgCOdenF9Ej8gjwZUtVLMC/aRysKI/RCXwSOfXO3edoSbGRbUhk9rCADFuVode71S5MoiZIxox/Pb/IfLGeo53hp07NxG5200G5M2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF9A79SBr+lIwHNoh88aFS+QAwTiruwaGBVdzONKrCk=;
 b=u4hdTm79MfNb6NekWrZtvAf/SnUjrRHf7X1y1tB23U2B9o2/ubnNCmBWD9I1GcFFX9pOu8Pfh1fWNU8zQy9a+j1vG/s6sL7b8Ml8Pm7xfwbq5X/7ljLTxAJWa+3UafEEKxC8AE0KmWl5SJ5UIZcKC2CmrTob9CNjc6dw+4ICd7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6973.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:16:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:16:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: dwc: Add helper to query integrated dw-edma register window
Date: Mon, 26 Jan 2026 16:15:49 +0900
Message-ID: <20260126071550.3233631-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126071550.3233631-1-den@valinux.co.jp>
References: <20260126071550.3233631-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: b71005b8-590a-4f04-9c80-08de5caac382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcDJdoVTACUcp2MnB08L1k3rjBTbZkWIQRX8c3vpWN2T5vA3rRE7p7wnah9K?=
 =?us-ascii?Q?JsqSvkLXSQagpk/VYFbx1MxKQ48p2SE24ICEteJug6KpVnvhRZgNxnB80U6g?=
 =?us-ascii?Q?zXDeDT+39uWSXUbdE4VB9l6JOrX1CGJq2eRIbmlmBYPxJYldnlS+wxz+P3TG?=
 =?us-ascii?Q?/JvVfcyPj/MYC4nWBVltg/kqP+AwZZLQaxx8RrYntgJxewf1+ea4yfsN6kDV?=
 =?us-ascii?Q?h3kxnhAfjVEZspXa0KEJ6gr34vYoT0oaLQdy+S8WA+3Hn4uczPAR+sXNOLTs?=
 =?us-ascii?Q?XSBHInSM0h0+jHh7pthwn0O/pBdrr6PbUlRQBXS8eyDAwKXKqEyt+DPwmhse?=
 =?us-ascii?Q?svT8wyzVO2wN6viBntOY90o4Gz0Ps7L0dKW8u+pIkDdRhyL2fBoMALJIyTQj?=
 =?us-ascii?Q?oRlnpjdF31SoA9eBupUeY5nrIPJQ29qWe3PK9YjcgaAaldkFcAwrgEg9jtb8?=
 =?us-ascii?Q?2QQA4/uxzZfuqIL+x2GFAxGmhZjogsnOlEKX8GnQgq34TFMf0o93aB8odVfI?=
 =?us-ascii?Q?FqHOrfoiq0NfKUwZek1b8/FjIaU9yvxURP/FoYDj/f9lZFsTxrhzGXj0K/W+?=
 =?us-ascii?Q?a87r9y04Bratf0H4OAuWxrqsS5zW3haiawml8pln8iCIs1aw4AFdV25XxtVb?=
 =?us-ascii?Q?5i917iMb8w4yfd9RZTmSyNJz8/zETE++AActsbfBKRGU2hT4Ku8yLaKv0hIP?=
 =?us-ascii?Q?h9C19Fz343d0jdhrPdSUT/nkr3D35Kd22N8OHLrFhSibzJ6Z3WOOrgmNQdIt?=
 =?us-ascii?Q?eVLUUOz19aBkSHQtkl3hdXx1bGbCtaQzUON0AzyHUDQtYQbMC2m36b5gw4Pp?=
 =?us-ascii?Q?q7u5Ckq92bgERqgobObh3RHEyyiXhe2R70joX6DN8rf363voGMSZ6h9+xdlZ?=
 =?us-ascii?Q?y1bF0cL0GsdhYt5lscDh3IYUswtMJr3Jny28qXUzSehdgwp7xbp1U6acPcA4?=
 =?us-ascii?Q?nh3cCK47PSND2R/PS7T52YGay/jv1fI7tXemntnbQK2UqqYAFuztasen33Wt?=
 =?us-ascii?Q?vizbGGe1aLa0M26TXIuFMBPwIPIKgDgELA+xP8spyY26wJirQWBXJb9ooHgc?=
 =?us-ascii?Q?9Hd1Yowy18wguYVBjl/zKuIKIyCi649NrK7DFGA4DplFbGtBbyjzL0zVz9oR?=
 =?us-ascii?Q?8gxngNqcgEdIRKZGWe7ap3eaHKe1c1MPAML4d8WwulyKlAo6EzBgWzWdoA4Z?=
 =?us-ascii?Q?NH29IhpQmBpqiPng0+vrwoKe3pi/YMHKXWI5t6j3ZWjnWbPLBea39fxssN57?=
 =?us-ascii?Q?WSTxFic1l7nGdL9Ei2043u9ejJb7N/MtTIJvJ5+tm1o9ArgZJhXsjv4/JSab?=
 =?us-ascii?Q?38UgOw+qnZkB5Dw+m2K8Sv66z0T9Fi+EH6KvbflMOoq7dT5QvbW6il3+b9wZ?=
 =?us-ascii?Q?xAbIxDmygEG3IrWzAJqNJZJNVY2T8plTWUM60Q9kj18EezMbGMJzR2aItzsk?=
 =?us-ascii?Q?Or07R69fBkFsOM6HAF3HNhMv9lOKUAD/AyxyrI67qxpRXKwrGfIPeHzvWj6k?=
 =?us-ascii?Q?qyVbBoSRg6WTtx6F4IHV1l0RLlaUwsQjgJeYajP3a6HVavwpBKyQ94eXrV7S?=
 =?us-ascii?Q?wr4vNVq34Lf7XG8o2Hs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IM6Rh4h0dVXA9ItsVVZr/jYk/rqVuqbYl/+4m/i9AuE91JMgkwnGdfz6/+JR?=
 =?us-ascii?Q?oOodH70Ii1yH92/JXzWTZSCwSYiuDn1zICwep3wYYaryN1waTtBd2/1xmtaD?=
 =?us-ascii?Q?pdrsNK3w+66PfwdZMBVXXmEC9oMgSoBnGFE3KvKpm4wlez9F7+RNmA2GDxGv?=
 =?us-ascii?Q?5m6iAprlWHfcCiWQQhu1XdkTrk5A0p9O/kUn2AtYU4XcjSCbOFkxiklqviUN?=
 =?us-ascii?Q?pjY51WxgHQOcEbV283/jucyhIJ5q95o4tVamRvvpjYRb3iSfJeDM6ixMAH1v?=
 =?us-ascii?Q?WCaiK1P2P1Xb9uoHLPfDZPmizIYf03s2Vr66Dm186YEsJALozGxhKwdXNgNp?=
 =?us-ascii?Q?4XfBhd6Vlt3eokaLutdkZ6s5hCD//jhy1r7qmAbsGLJeaLOtqb2ThI8EqT1D?=
 =?us-ascii?Q?k2m+ee2YC3/YLAWPYYs68Ad89SusgpxSRNAoxKUYWgbbNtZBCSn6O5BnKHix?=
 =?us-ascii?Q?myX3hf+yXDgGlkrTOI8Xu1IFsbMjWEPjAM0yp3cCz12nTwJ6uW9bxgbOA8tB?=
 =?us-ascii?Q?42z/Wg4Om6b90czUH4ebc91S3sbY/rtAJSqU/o6B1vMnTlhCmqd3Dl17Rtin?=
 =?us-ascii?Q?N6RB1GkF9JaZmeu7+o/dG33QD+qQJcjjCnKh7cL1dIhamqX/gsyFPLTYPR/l?=
 =?us-ascii?Q?1gWX0trf7YGQpXPYsh7B25Uda3qMKUsrf1WNIFCfToPYUVoiTPF7A9n8qYNE?=
 =?us-ascii?Q?CT9dOeFqZ0LDC+cIOmOYogHb0C/Nx3LQQQqGQjBlF7kTmtsthm+zvdei4kzQ?=
 =?us-ascii?Q?pZBpJYjfknTF37s91QsRe2IwlmljD9v9b0XoiU7goW+HPK72xWdWXYLwp3mR?=
 =?us-ascii?Q?cbDr/j3UJGj+LIjVzqrIZWbhxJCkxc8VpsY2lMD0kFgslRX1PZfk6vHOakj5?=
 =?us-ascii?Q?O6z3G1k52RJjlF5TWJlNA4xN9qvKQFmY5RoC9hwaAWY8rWf3RvFxgz6sHNPQ?=
 =?us-ascii?Q?oCyRqHwQrT1MBx4VGkUYkGRacQRPkDBToMe4oBhK32Py1GOhWhdC+N9YlgT+?=
 =?us-ascii?Q?HaPxcskGUBK1+QylVi3n7TVn4wCpX6xaPqCXrIf+gyjOKdHAan7Qs+aCIhXS?=
 =?us-ascii?Q?ZHLFzfCI+BEoEWpQgnmSUyiKV+LlCYKvK+AObVDNl2/TOmaeLNclrDMKyWGo?=
 =?us-ascii?Q?SQ0/mHBPvR21Xi60zbO7FLRQuKDFblBscZoCDSnz4ajHZddNyYla0fJrDGI9?=
 =?us-ascii?Q?ZE5Xf2FodXlPjmsrjGy00x4TqyShXlBHI1hSahOWrumTJndXdkqymwR4XcXM?=
 =?us-ascii?Q?dubRzOKcI1KmL9tqt0Q+FySef+Dqkv9QNpOR1l2Pgqm+KrSZcNJJE7RfCwi3?=
 =?us-ascii?Q?8bibuStgDJR9hPCQI22qp6cYpERSyFDJWOaVXo4y3ERRTeWpc0K+L/8lj18R?=
 =?us-ascii?Q?IArZNt7BSfWCwriRU3BZn7PR43XQmMQvvALwN2WNg8qKr878NPPQcpEkE7W/?=
 =?us-ascii?Q?+EbD1cMxW36yQhJhvnyGH42/EQPUptF1RutRIGmye4FHXzXZm1D6iKvcvyEH?=
 =?us-ascii?Q?su+jacNflVW+cIt/NWzmKgG+qTnmW5FloO9fc7BfWIywNqfn07qmZTW5NTnn?=
 =?us-ascii?Q?43fLIAfHy7CKYlixGSGt/4KQHu8zr6HJ352wAML99uoHqq201vl3tGOkCVYs?=
 =?us-ascii?Q?YpbNqN/WjZcqiDPHJIRgmVDrp1Bl7ac+MnKH8G6+za7O+MBfFtcX6YPk4y3K?=
 =?us-ascii?Q?8Fsndr0K7W9R4ebaVuXaLAOXLaAPx+qx/HgZyzOsvo38nv0uE1UztC49Q6RF?=
 =?us-ascii?Q?ZSqLX+EIThSuMWIkgbassWzV1935UJBUqRcFyGDsZCiuqTng+L+c?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b71005b8-590a-4f04-9c80-08de5caac382
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:16:02.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyiXkedxCQZkMZEB6no8/radZdbf3R11LQdTtqqNZbO12agyYIWyUbs6e8Hl3oS9DBNsx3M/e2iK/fl/PRjN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6973

Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
instance. Remote-eDMA providers (e.g. vNTB) need to expose the eDMA
register block to the host through a memory window so the host can
ioremap it and run dw_edma_probe() against the remote view.

Record the physical base and size of the eDMA register aperture and
export dwc_pcie_edma_get_reg_window() so higher-level code can query the
register window associated with a given PCI EPC device.

Keep the controller-side helper declarations in a dedicated header to
avoid pulling eDMA/dmaengine-specific interfaces into the generic
DesignWare PCIe header (include/linux/pcie-dwc.h).

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 MAINTAINERS                                  |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c | 29 +++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  2 +
 include/linux/pcie-dwc-edma.h                | 39 ++++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pcie-dwc-edma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..fa0cb454744c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20066,7 +20066,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 F:	drivers/pci/controller/dwc/*designware*
-F:	include/linux/pcie-dwc.h
+F:	include/linux/pcie-dwc*.h
 
 PCI DRIVER FOR TI DRA7XX/J721E
 M:	Vignesh Raghavendra <vigneshr@ti.com>
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 18331d9e85be..bbaeecce199a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pcie-dwc.h>
+#include <linux/pcie-dwc-edma.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
@@ -162,8 +163,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
@@ -1340,3 +1345,27 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 
 	return cpu_phys_addr - reg_addr;
 }
+
+int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+				 resource_size_t *sz)
+{
+	struct dw_pcie_ep *ep;
+	struct dw_pcie *pci;
+
+	if (!epc || !phys || !sz)
+		return -EINVAL;
+
+	ep = epc_get_drvdata(epc);
+	if (!ep)
+		return -ENODEV;
+
+	pci = to_dw_pcie_from_ep(ep);
+	if (!pci->edma_reg_size)
+		return -ENODEV;
+
+	*phys = pci->edma_reg_phys;
+	*sz = pci->edma_reg_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c3301b3aedb7..cd38147443bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -534,6 +534,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
new file mode 100644
index 000000000000..a5b0595603f4
--- /dev/null
+++ b/include/linux/pcie-dwc-edma.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * DesignWare PCIe controller helpers for integrated DesignWare eDMA.
+ */
+
+#ifndef LINUX_PCIE_DWC_EDMA_H
+#define LINUX_PCIE_DWC_EDMA_H
+
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/pci-epc.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_PCIE_DW
+/**
+ * dwc_pcie_edma_get_reg_window() - get integrated DW eDMA register window
+ * @epc:  EPC device associated with the integrated eDMA instance
+ * @phys: pointer to receive the CPU-physical base address
+ * @sz:   pointer to receive the size in bytes
+ *
+ * Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
+ * instance. Higher-level code (e.g. BAR/window setup for remote use) may
+ * need the CPU-physical base and size of the eDMA register aperture.
+ *
+ * Return: 0 on success, -ENODEV if the EPC has no integrated eDMA register
+ *         window, or -EINVAL if @epc is %NULL.
+ */
+int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+				 resource_size_t *sz);
+#else
+static inline int
+dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+			     resource_size_t *sz)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_PCIE_DW */
+
+#endif /* LINUX_PCIE_DWC_EDMA_H */
-- 
2.51.0

