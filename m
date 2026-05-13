Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513334B1AD;
	Wed, 13 May 2026 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640590; cv=fail; b=m17hWByx/0nft95NII4s3Zl+tyo1piOCjmTJEmMMjDUnpvkSB2XLPt0rTFt2CuF3w+9WSxHzuin/8MuTCrexCCBHVrndooRFjp74p+JomqrAMcdsrXXhkLRwPSmO7/VMvRimW4J/xBK3vhwtRPwQ/9rDsNcFRZrZBAHunEppqiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640590; c=relaxed/simple;
	bh=4XP7fnhiZgpjCVSj7C7JiVh+C0vEt6wzjwc59u25X+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mtftnl40OXtz3er9+NUB6nbYITm1BZBf2Sw+kW9MmYyZoX4rt3q/5283uwE3cG2RTSPZcYKg440wFRMXnVpxfGZPAN/i9UqaKqQ71xU5rNweFDOwxqNmfM2Pgqyez+JbYLce9rQs62gbDaSo3Naj1ua2YMteCbrZXGiHBz7PbJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VZOmmeyD; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VZOmmeyD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dewahtIHfTAoi+7RfFVeSkz027+c9ozatkr18g+P8G4+gQ7jmBITsRfkU96hkdEebAVZYGnecEmUHkC/bnz9V2YF2LIMAMnWlnkeabMppppq9zf+HRBDx/NhvM1FzT7Jgiusf2ZUDD8Cr/nphwiz/eu+MqJP95dxrQUz6f0PZqgELh2kUY7hlaPuy/xlyCdWmKXHGUmYbmAe3JOAxp1zRbN24o3Nkvdv+ITN5KGl9fRgKgeZ+/Yu6sry82nwWhsO50QZM2K/svW0+0E9KZEpPn2tPumDjZJyl8BG5gQwhS7OyABaGwbl9x/t1NURXunyfdXpRKJ5IDkRMPKJmZ2/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2BHlkcjTy9zumoiIygniA/TlTDB6jSPIWzhi2bNzSc=;
 b=JC8IvF9A7cMYHZVTSCvVyfL3xNz3KUVEqGua7nyKgF87NmYVdRLz/n4BQWPmQXfYe5kw1s3rqhOnoKT2eoTC1B7tpsCnmJG/IF17bAjSKgVgDujgr82/RX4ZzlfLKW0EsM3GA/5G0jsSYO2oD3Z6IMQhqWYqQifr5y7WsHwXtFGYdzLuDgzvti7uWYbUBooC0GfN896/Zg6LO3Wugpe8zW6bhxBj55IbdFVb25rtm0xkEbfSg8eouKHKGK3gkg0KY7TvceNOrDw57PEKTq0o1nRaiWe4hICE9g7GsPh/I6tZjyEz2aatJ2WbwL63PtgdxwOJSkh55HSuWu8jWCF0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2BHlkcjTy9zumoiIygniA/TlTDB6jSPIWzhi2bNzSc=;
 b=VZOmmeyDHojfh8bmOJzv0EBhk7JpYAaBUkioZ9eRUjlHl+1qqZL8ouHvrllMHfAPBTYlUCRMP5y52EmOBzZU2ds1OG1mn2ukmJlxiGjB6tSDDcytUTbqFnWSH9zGgR7w4cTfIQwAyNRZJxlt7Ly5IdlU6X3VLzgXFoQ6QqMtn0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5170.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:32 +0000
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
Subject: [PATCH v4 06/12] PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
Date: Wed, 13 May 2026 11:49:17 +0900
Message-ID: <20260513024923.451765-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0228.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d432f5f-dd4d-4caa-84cd-08deb09a4265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gpri5NSuRrFBDJeuAQuiHSYTltp1UwEyqdFvgmc1bHO1rVyVr9q6ufHIsv4qpnj2Xvcv6DCPc3VXtHqJSGvwfdYbThDgRw+L9g5eAitAaS4//oL55L+BfW7Poub5x2sBj81t3moMzdwO3Un7bAIiYpsecXd0e2q415TOI5PW8ltPUZ+uQ6gGxidgbPSXncG2qUHsHl/HLWJ+eINtMvef/zn1hvzx8RGO2JFta2gCCQFxA3HXLiXazqBltpLkukh9gzCdNxPpYt8f6Lt/VALgwSjpk+scPBJijY99GjHrkh157C9YSbj0reDAOFEDxfcmvMEKzW9MTAc7EJwnSKnWGdsTYo3VWMerlqpgT7eEPCfsTBefR5KF2tkOSPyhUhsAa35YPcrnZ61OzZKvmGBRGYeLHRkM/V91tBB2XjQFMuSvvJgYZMkDTzHfkzXmFWKLqXZqR3s7c6mDce9CHLnODqYFkTegmiq2/1n6nWSAyatgBLpeFuAGD+zolgQx6O5OOCX6gX0U9vP/m4mcPNr3rscKs+pEZ93Qu7GZV5CObU7EVbH0hFKzWN6MOfKSFXVH4XmRBKzDxOOehTWcb7/3jm90r7iywACxNvwF+HptzuhDWS5hDil+kpw23+7e8IMN6MZqeU8jbCAtU2SOKGjIvsSIPAyD2J5Zu5qQz2mjGWO6UBPoN1eCOGNIrG931WtU5+u3eeeqW+cQTATUseyGLrBR3Nlek98Gkx0mAXz/A7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cM/yLm/AWu+A15F+LAmg6VN/rZIXBtpO7EaP2fQeyRAVRIZVFGBtfKlZ2t85?=
 =?us-ascii?Q?tIB7V5DY2RG3RgIXsWFN9ksQhf/+OXctFRNGp+OFSNYVayb/rKSaep+Pp0wY?=
 =?us-ascii?Q?ot1bJnQu/bNUF7EpCX0auNlkgh25orOghR8zYFtQgqk/XmWmlF0gnF+CDXAM?=
 =?us-ascii?Q?W6DXJ02c2Cdo0bSwaa2mmR1qMoYfsfEHj2lrp1B9BwPI8kGV1oP0RV5Ut4Tx?=
 =?us-ascii?Q?C+nlDabZxYPbHCAb4OLTkbxCiRfCxR7TL0PG4wTWeiLAvzobrwf1iJyUvmui?=
 =?us-ascii?Q?35g3LKM2N/ISHDd72Vgo7Ex7F8J7CSD/EqO0iorvsBTY0kLkE/GovCPE0tmt?=
 =?us-ascii?Q?zFIQ9iI7BJo5TM6gaYhuvGNmwYGZVWeDcGUbwQYA66JIt2/+fzkP0z3bMhCU?=
 =?us-ascii?Q?gJPq5VWJF2djaKjNk0DpiGw+0EzN/fWSzLxRmBEX39q81Vu7s3YZPHj6Xosp?=
 =?us-ascii?Q?cYh3A1MDRPPWCfHuQ7Lp28xJno+dssvAf8OqPMI9iwFEvy50Yaz/k7sWCzln?=
 =?us-ascii?Q?yptfcF5+FANDrLyyEp29pYjXHBjSqavMeSeK0M7IsZAyqIEgqFjLQOqR48Hf?=
 =?us-ascii?Q?1y9EF8Jy/84IhkGJR9gkj/ZYAneiVRjuMs35XXJixw9FlGXSHBPr3frut3OU?=
 =?us-ascii?Q?At+9u/QG7+sDEP1coIs2eEN3Ygyc7q+pijLBCWcrdx8m1RNLFNMUPuMn8Go/?=
 =?us-ascii?Q?dqlwncSt103YO2/iVFa53FSG7/32nfOm9EvrKYW8AbNjOuMCXcx6uZ41mc31?=
 =?us-ascii?Q?yaP3jZVJxXexG7Pna1AFJBb2comEYHi0OrB+4xzbTBT4z945l3lZC3+FYz4W?=
 =?us-ascii?Q?E4aK0R+0BQ8bULRHPSBgQbQrU9tLx70dTfvo2DGV896/lkHr/0n6odRir5P0?=
 =?us-ascii?Q?uo0c4xFT+F9Z4jQkLE72xzoeelWHy0TNBygUXKDnLWHyCXQzT3YD7agCVJML?=
 =?us-ascii?Q?vzcAvFbS+f8C7FkRbdlyYU8m2VVMIVu7o7RE6/w/1b+CtohECFsUgxLaidGY?=
 =?us-ascii?Q?tk1w498z8hFjxO1fLCGeiJUa6bob8bOe8iOF7S8q6OwiZ3an7rX+IcyPWIpY?=
 =?us-ascii?Q?BEnwpYhHOPpvB5aanZDaHCk9lAN5Oq1MNaREbj+BHpuy6bihn/IrsDXEG9pX?=
 =?us-ascii?Q?D+IGZP9qCFItwSErkui+3NSFoVR+yTrNo8nm1Q3uC7TBMoycKtL0odUDa/mu?=
 =?us-ascii?Q?s2XgzA2adv4JLyANonb1DTShIY7aFydpWmZGqWxTyaYHiptWXDVEJga8FxmH?=
 =?us-ascii?Q?/Cr8/6sFbzLk4RLtRrK+FK9NKIcq3ZSAqep/QWa4b/WgMn5E+hhVgqZZ0cRN?=
 =?us-ascii?Q?Wl+tGk3Kyx3XyjxCaVgl9X3eUaVhUsKMgFvIa+YL5h9Tg3YOSpmMngSjEC2/?=
 =?us-ascii?Q?ASfrk2RlpPoMAV2tKYg2w8yurqG0DIU9IRJC/yZ4jJXeSDwDzLJZzXfhOqoX?=
 =?us-ascii?Q?XqJjLyt/pjf1VhSeShCFSLTlzhBfJttpP036LqO0L5Tj8iNMKjcr+bJKIrig?=
 =?us-ascii?Q?roh2sjpK/p3MDtjz3B/VeTxW4imcMER6sWdvumN0/yr+vJn0fMmtQX6tev8Q?=
 =?us-ascii?Q?3x31gGMTY4+chxkfDwIFXO6Pyey55Dc4qKtap6Zz5ei8wzHPLBI3caEa3Vr4?=
 =?us-ascii?Q?vSvXM6yOA94PF8BCbFeyFDXvNiS50Ko4BJM0pHXnwVPxJW6NYlTIRhXMeI6M?=
 =?us-ascii?Q?TTOLpx80FNFzvgOd4YNI0GM+phaLfjHJvpQ4xHksUyNa84GBvgTN11y+ZMs2?=
 =?us-ascii?Q?0ycRwzMvjQ+2XWKwkHlRr3ozuzTElvDqe2CGfL2vTg8dFSWWL634?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d432f5f-dd4d-4caa-84cd-08deb09a4265
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:31.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxVvGa7swXbnrH4U6Oo35FjPbbaEYZ4kZENnYfTfz4BAcSpBLAXviL1Ptfbnfr2LCrOlcFoEX9gSyG1AYlsGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5170

In pci-epf-vntb, db_count represents the total number of doorbell slots
exposed to the peer, including:
  - slot #0 reserved for link events, and
  - slot #1 historically unused (kept for compatibility).

Only the remaining slots correspond to actual doorbell bits. The current
db_valid_mask() exposes all slots as valid doorbells.

Limit db_valid_mask() to the real doorbell bits by returning
BIT_ULL(db_count - 2) - 1, and guard against db_count < 2.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - None.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 524355a8b4be..58e41d95d029 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1364,7 +1364,10 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
 
 static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 {
-	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
+	if (ntb_ndev(ntb)->db_count < EPF_IRQ_DB_START)
+		return 0;
+
+	return BIT_ULL(ntb_ndev(ntb)->db_count - EPF_IRQ_DB_START) - 1;
 }
 
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
-- 
2.51.0

