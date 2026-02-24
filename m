Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020092.outbound.protection.outlook.com [52.101.229.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E93A0E92;
	Tue, 24 Feb 2026 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940118; cv=fail; b=YK5d1cCbLhFsFujGW+Hvpk+EbN1ygaYGFtn8SlAt/u/ispVoeuvbHL+jC4/2SlSAeU8/kVUXEqIVHjZTgv2bcmyY+K7NW8V36kY7YWNONZ8rZkJ5ykn6y0tU5e0iG7FXi0P+BabxsEZohrW32VF+FlBimpGCrzCf+FcV1U8MmG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940118; c=relaxed/simple;
	bh=XDTEW3i/JMlfzuobBL49A3+UZx3VWeWi74ihQxluwF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXXzFKT6rnQ4jxUbCwgXMdeMNHdgG2Xs5gWtWu+Zp9pLrxNN68baKeu/MsQ2Yg6eBse0VNzC+gAvmeaNQjrM57EuSUuPexw8tUQjhH/c/DgCQIjk6GhiO7RAUharZ9xK0YqbxhnkG3MzRBxNrA0iuYiSy68DoGIUfrgKbVedHqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DBUkAvzo; arc=fail smtp.client-ip=52.101.229.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DBUkAvzo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo3CvKVRxUcbijcRYaAgeH3NqunE36rjG4S1ioWBn9KTUOCs+Ad+J5pawRNH+wYUn2l5UgTvBttcUfTyZUkmQqFurbHewiz7AvE5t4AQWEgww8P9tGG5L6+8wObQnhInOEmxOevpzCC9OSmK5wzzdV3Q8Cq67Jwk7ahRpSH4ObAqC3CsMz78Y5c77p0W/GfRBQP4Xx+woCnLOYkJRaUj/ofx6aNk2ofAdrmUlqPeysitGTWxuPvd0vpTWFN4DbFS5Uyxf2lzTowxz5ZzyWFEPvNSndErFfDKWj65PMY5tZ5tJ2+ATwc8sf07yx7PDY/+cwTIM8bX79hay4Ve+xGS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfT8cuydcJnUQT3j/o/DTU2T8n4xkBX7BiwAWEF+DuU=;
 b=EBrqW0mamxX1BxnIYwjsOCptbG4OdATR36+lSnwzG3lYVwofzakqxfdszEx0PjGav4v/1WyNAOvbrwtdqlyouxpc8XH+/Hq4gWFzARjAteIw2xEVsa1AN03lli3G/akFcOcXytxaWvh0v4LuI7bhUFpYIf2noPlieDJPAuMmd/ijC6hRSHIINSkYYkS2IMLsqLK0qEhROZdAMdFtIJxfcDAaBdkab5/IRUYfzHCbGsCi2UsXBmeL6cgYJgya36SqdiGP5A/0FDzWcbre97zqr51jO5aYXDTXBZe2+Bla1gY2gH29oqEuJL0bKx8+ueqvAVvDJbpVg0bu/+0xdJGsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfT8cuydcJnUQT3j/o/DTU2T8n4xkBX7BiwAWEF+DuU=;
 b=DBUkAvzo1PGcv6ttjKbxTv6WPpEco0dNPaNbWHII0Ktuyl5TGFvYumBWJSHn4BVpd0IcTtW2Ba8sn4DSY4gMhsswfpL3xn0btjwMl74JdM8NYujYU3omXBzLsYga5/3siipts5vBxZDXt0ss802Wc3/3c/aWZ6XdE2a2DJn/5vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6278.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] NTB: epf: Fix doorbell bitmask handling in db_read/db_clear
Date: Tue, 24 Feb 2026 22:34:58 +0900
Message-ID: <20260224133459.1741537-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0173.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7eb2b0-9ccf-44e8-6c0c-08de73a9882a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s56OO7sd3BGxKIMt3dTUX9Aa3my6uvBDeXgCc5PhO3UlG0FqrLoODCraTJ1a?=
 =?us-ascii?Q?pKkgzHkMv5WWeJ2kmKFB7QjbizqDuWXqhW7toYE8NqtTXYppkv2RX1fmcxIc?=
 =?us-ascii?Q?2LAwr6bfebGnH+2bABZevM4Wi9Uy8yKCTxJ7ZCGxqg/8enQph1upK2Sz9uA6?=
 =?us-ascii?Q?XE6xNukSSFADn7xjd58IXFxJXhPlqQQRcLb+w5fpNdozrB26U/Gt02p5g7NA?=
 =?us-ascii?Q?BGArfIf5Khd5tiz3X32FG9djKle3H9431MIgZbCZN8kRSe7PC/HOi7jB0gCU?=
 =?us-ascii?Q?vTVfTsApWQZw2HcfdktovEzDoiXs1axZBj/CiUOxwIQ4Tbmcp0OH6DrlIg5I?=
 =?us-ascii?Q?cwEd17RMAw7JWwuFTIcY6HjyoBhl1VJOQ+4zf9w/9rLAHouCSK/C01VFGIm8?=
 =?us-ascii?Q?zN9Jorz5zeWEZVKJA7UedxS0TBgr4As2vpa3+xdr9FPah60hmy6wWD9qW4hv?=
 =?us-ascii?Q?Jcxo31VKgDuUZgy47rz0uyDD0xQQ7fQACvW6oLJ1xFMDgqVjUOj1JK4LW1PF?=
 =?us-ascii?Q?6kF6rYb2nzSI8QVHO2uhJbQkM5wSEaejW52LxzDJd1SH6K30274DEZ7x0maJ?=
 =?us-ascii?Q?BXYUggAcTp4wBFFGVGwVoPb3xyNSooHNI4/FUumX9emCtCPmcioXBVfvRiob?=
 =?us-ascii?Q?NTIOQJtRvABBYiK7lKavgzAMB5LVAGXQm0F8Tm1+Wru3AIl6ZWpydEkc+1r1?=
 =?us-ascii?Q?9ljfv5r8FC2Zt4IYTsW55UZwTDzjDFNYUoPKL8HLxvQafvZgrxaCOfHQryPc?=
 =?us-ascii?Q?9o/m8/1+s3vOSsX27Aoth5q/toxrX5dtJ+1C7QFs6da82pRxlTxSGeQE1ooE?=
 =?us-ascii?Q?ELn0cBa7DYHlp4XqpoJ2W+8dFyZUD1pN/lZKT34ObmGILXxBCJqdVS7SF6Fq?=
 =?us-ascii?Q?FqjI5gvjVpyA6Vdy1y8zF5RqbM3jfhjn3CcnpNfKVXZw6cSiVo9qAtZufk+j?=
 =?us-ascii?Q?dIXfUp1RNo2SLoGAMhkHm8T2a+GYZzqT5lZI7+08RbvLNYJVmEhkk8PlXbF2?=
 =?us-ascii?Q?NUUPVTtE8FzXigXnHuhMfi7EJ2HjdmgxNVTWLAem8pzF7LUC/f8QSCICtJTc?=
 =?us-ascii?Q?kjVh5RfpLR8KorL7ulsrrFhwK4z2d2x59LgHuwPPxX2aNkS4tLzpM+jxTtAb?=
 =?us-ascii?Q?A3+h+of6nnWzXC3UNJYj6xZ65RnOjbH92A7daT2ZYGp2PVt4OEyJw4kp+nbO?=
 =?us-ascii?Q?hbFEEiCvXRaYNblaq6hsjZG8jtz97K2uF3S4cfloS5XuO2l0LxJEMmj+vwfW?=
 =?us-ascii?Q?eoQr1l7i5BDtPp/JQIe/eG45nOPRwkv24u9zaQDw/LtJCF+Brb3PaOjPOt/a?=
 =?us-ascii?Q?OQkMorDzZ7SsKTCFiOijz3jt/6OfwYQqP2yeqPHOkyIWvph/XVcpfuHQCZfO?=
 =?us-ascii?Q?VoaOS/5BeatXZ9McdiueTwyRtVKQAxoUvqYUxjnWwmdkimE90MVEQp9iVQkH?=
 =?us-ascii?Q?8Zzwwk0ZHYUFTaHjMoRQ6aoD+p070Fm9WlY8XYIL04DhnEBdk/85daV9vXJy?=
 =?us-ascii?Q?FqTHp2aA7XXEdJAoOOaM82ee02kC3HckDal2nBN5St5A1b5QWAgqqIO8KMTZ?=
 =?us-ascii?Q?BGtjqayH0lBHWH5nkUaz8fJ1HtsOAUhbN6h/iNG2cBumzN4dUXP2HL7PnovN?=
 =?us-ascii?Q?Jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cNKoIs+JiUUPdoPuxsldbRphiDGyGSGfnskoLpWDgifEhjKOKxVo6Yt1shFp?=
 =?us-ascii?Q?msIweQ1T0zY6HTFPgSeJhbgmUWtxrltt32fUWdr4s5l2gaLWHa81cFDpElNt?=
 =?us-ascii?Q?cBRXNohmbg0w7Y6ysC7KaE5LDk4WDf4xYn+trCn1Xtmfxr8fNNgicq9wtHl5?=
 =?us-ascii?Q?EgetaLl+gG0Qn04TMH3oJwxUlREsvP2SRwEIjL5pg1TkbyCS6GCqKseyOvxm?=
 =?us-ascii?Q?33SkANQxPIBudf0Ptx7keXYy7DvlmuJwvyaM+fAbVLRSWFeYPpERd5dHO0OU?=
 =?us-ascii?Q?u87BJs0qDI59LCqXVUiYaClBwMTnTJbr5TCUfgQwg49wwzj0OYG5rF9yXBcY?=
 =?us-ascii?Q?xh+XbL7HeG2r0oIar3BpQrggt0gx3TZLXqFDhTBlM4R1wimlBouEx8l5YfwZ?=
 =?us-ascii?Q?riKTKtbr2qvD+XtqZ+rvLZYZI2kN/vsmF6kNDBmSCu/6TIoJBQowOjjOA7ui?=
 =?us-ascii?Q?8hklez2VEiPnMs/gmUODbWA+cP5PbDhb50nYLFUN23ND6czRfj/UdO1+TVVI?=
 =?us-ascii?Q?aSiFYvIHA8C9xGeO3Lvejug/3ggvMrVXAQxiD6EWusCQIlo7OkF2+1uB02Wl?=
 =?us-ascii?Q?j/IQU/eV0+o3C+PvqdtRrYC0aK6O9qXu0nc+TPNIeR/FEXzslECjklrdCN+c?=
 =?us-ascii?Q?3xdf2jEslDzrQ/jDF6INn0BWUtfB2tRrXB4ten6pPpvALRSdMc1a20tJAVTH?=
 =?us-ascii?Q?+TjpoOK0Im1V3O1v6Pw6OtT+REHxkZ4swlIUrfGqd5kOdzKEZ9I+cOkxbBRL?=
 =?us-ascii?Q?BBim14jylN3Ctj5o+34t0R9aj2tztxMB7W3Dsjk4DvLdPVfgAND0gfHQ7szR?=
 =?us-ascii?Q?uKAuqVwLEUseyZgKoWDAwasagzDh6I1f7XPKBBJ7H7WCihsV8jwLkPmkhJQ/?=
 =?us-ascii?Q?ggLfuP8yPUa50oTYgTgZgSHfpreLuJW7rX5XK32OE/CxAuyBUcB3oD/xi8yu?=
 =?us-ascii?Q?gUj88F99darP2oNG78ph0ir17ZjXq2JPPHz/TgXYv7TQEoFrUKVnEmbzYn3o?=
 =?us-ascii?Q?v2SM7K8O9NfkC2PxmwRaahITeTqrPF3sjKe28aOla0VNIva0h211Wh8TXXNh?=
 =?us-ascii?Q?5z2n1ydFaxNIJZj0CucRdWEfMwh8o8nXUJ+kziKQUQXeGFoKMpiLboKIN8cr?=
 =?us-ascii?Q?uqye8SyfSPQNruRyBCC5bp6kaAc/dEQSpwivTAknIltEDEnWw6bHFR/DUc/X?=
 =?us-ascii?Q?BsKYg76y1tVs/beygxaucuN4fFPwEDJxdjkadVTpGPEPA0ry9lSnbcbe11q9?=
 =?us-ascii?Q?h69Qo4rdcPSwx/VmEgZqdqwDDUjweay5M2iCCGeI2qUoBLqrxGUeXRS4N8Ms?=
 =?us-ascii?Q?wnAVyZJyLfiN0gVp29RSPiGB1umBGrcjvf2cdaDf5GZhFe0kczMnvs13vUuQ?=
 =?us-ascii?Q?CKhYrwO/oy/p0yhEnRcj17tIYyW06hBhjZT6xRuq3CAH7HuoBnIlQ5mWxYEh?=
 =?us-ascii?Q?CSzRFeNRDIRYAVHeHg4msSxONzwihG9YyX+IVKS5XYyt7HsdSCQwbk53Dhbd?=
 =?us-ascii?Q?ig1fKvuCK9afF/E38kS4T9WaR3u5XAExenhJW8i7IQcO48ss9EiMDOQuoSSy?=
 =?us-ascii?Q?TQ6r/UuA4jnHjaD6Vr+J5iv2iT6rIatlycHM5wwRdC5c/ebbunyAtJv9O6/u?=
 =?us-ascii?Q?+F4RUnqiXXEuU34EgnEMABQPzSWd4jrrIj2qYAuAVBr0DyU4GlVEnjyNjN3H?=
 =?us-ascii?Q?Z6OdWDT+Eu2bIKclQzpFMtllzQQdQMYEEsA2fuju/jtNYWCkeYa3dDq2eF2n?=
 =?us-ascii?Q?OdK5nuvxSUjxcdaFpmEwknRCTwKDDq2o0MKd1oG+VGPUMPdbV3sG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7eb2b0-9ccf-44e8-6c0c-08de73a9882a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:10.4789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5nl9jzeggZQwSikMz68yzYpySElW9tcj0pJ+xamj11U47m+DYTUjzgY+PYmoQDucagHELJlmAhn4x3DnmHTxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6278

The EPF driver currently stores the incoming doorbell as a vector number
(irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
This breaks db_read()/db_clear() semantics when multiple doorbells are
used.

Store doorbells as a bitmask (BIT_ULL(vector)) and make
db_clear(db_bits) clear only the specified bits. Use atomic64 operations
as db_val is updated from interrupt context.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 00956ab2fbf5..0018adc35f16 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -102,7 +103,7 @@ struct ntb_epf_dev {
 	unsigned int self_spad;
 	unsigned int peer_spad;
 
-	int db_val;
+	atomic64_t db_val;
 	u64 db_valid_mask;
 };
 
@@ -331,15 +332,16 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	int irq_no;
 
 	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
-	ndev->db_val = irq_no + 1;
 
 	if (irq_no == 0) {
 		ntb_link_event(&ndev->ntb);
 	} else if (irq_no == 1) {
 		dev_warn_ratelimited(ndev->dev,
 				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
+		atomic64_or(BIT_ULL(0), &ndev->db_val);
 		ntb_db_event(&ndev->ntb, 0);
 	} else {
+		atomic64_or(BIT_ULL(irq_no - 2), &ndev->db_val);
 		ntb_db_event(&ndev->ntb, irq_no - 2);
 	}
 
@@ -524,7 +526,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 
-	return ndev->db_val;
+	return atomic64_read(&ndev->db_val);
 }
 
 static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
@@ -536,7 +538,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 
-	ndev->db_val = 0;
+	atomic64_and(~db_bits, &ndev->db_val);
 
 	return 0;
 }
-- 
2.51.0

