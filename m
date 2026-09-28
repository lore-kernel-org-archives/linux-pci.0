Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90408439F83;
	Mon, 28 Sep 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614387; cv=fail; b=ARr4MOk0kIb5gw9l5Xqp2VBrlpaz2qWx5h7aALoYQqeX9L0Q1N+SEgpmFDPdDZHD7OCDlomb9GmJIXsA17Y2ymJU79O7xjbXs9iMCoSluShM0KRw36AXHPeEo8Q+eJEDv/buzXE8HfH8Or0njgLgeqMBWluIUaHwIU2FPydgbPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614387; c=relaxed/simple;
	bh=Plmb9RLus9RxA5+TgmBIj7nF31wDbhxKPeQX4awZXsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJGdCc2JnmcHOuSn7J2PdMlguJEONvTSMcDKSw8hgSXtq6UPofnIJwnfvEPYLQlHWhbAzil/6kh/gmGicp6glURup9gRuq91m5fgkhAni5ZYcOjvGqwW9nsGDIhC+uxpfE7NzuJ0UalMjS5qfQQxum5/NB7D0rDlN8cmzkqFuxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JsBzkxil; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JsBzkxil"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMDSTxF6CTHemOwMCFICNshhP9zZ9FaG4mmYDIekEFrNhMGJK2wU4Iq419NN43fltvuGKhycfSe3WlijK1IoDHKYmHuUkTjoDa2q0ODSsu61JFkjWINnFOoEOsan7BeicLlveBFhkO6hsnEyGyTr28IpgSTp+1ybcPzGy/wtBqcZBDOmeEPVGF86xi999xzFTVTG1W+qS4sX+znuwHO7Iz5fyfDhjK43DgtuluNmYwW1JQZUQKSwBJar0Yfdeeae2hHlWfvupvY4wbQxJyUshLKwNv9gcRrR/qoytlhA7aEVmCSKquXLiPxII3KUIh6B6toA7z10huLqO6hFISmssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SkaAbY62m4r4sxtz/+y1VLYKteSRT1EaKy2kUPyxO8=;
 b=SYawQllkw1BhL/L5y0aidwIGMVQS4r4BWm0evDRp3dvL4UhAxgwd8PQmF7OMDNM6CDCQKqyW/bDVrd6enCtd2pCCGMn/R78jJKxkpwfubalfcPEOOGHLmY1yU8nxldE4ftDZx6F2MMrOKX8ITcOxydCAxtX7MmEEeO2UvggejeIKiZp+OAgoWmdIZLBHFC+eGrVBiA4iKDq+JJBIh+Qzwp+8AGGipfBwFwB4LFHvGtL3XsPt3K7572drdOi9GaHpQOtl39OmkabNn1insFbb63j7ZK+1KIZND+6FWfE3rg0LKAIJaJ007AsvzxGrzq5Ez/78gKapb/KJSmxY7/llPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SkaAbY62m4r4sxtz/+y1VLYKteSRT1EaKy2kUPyxO8=;
 b=JsBzkxilgR1reDM4rF5TLU7RD9C5Y8JC8terRufGcARKElNn+H6IaO0M/g9CNMSbiNnle6iBxg5CGwt/psR3LiHIyde5BP5u6eBZssKGsnKktBwTlwGFlUqdtlF0U3zfpoYt6hOd4bQX/iK3oPVw2lxAqpqQud8hCHIJrlFMRkk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:00 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/15] PCI: dwc: Add Renesas to the RAS DES VSEC list
Date: Tue, 29 Sep 2026 01:52:16 +0900
Message-ID: <20260928165230.3397664-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: a198950e-766c-4cf0-01c4-08df1d80f484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PUpvbTOD+YyCR4sH5m/smJ0xO9jLvv2ia21iVF7RRJuVvppR0L2XhZk6Ec8vJYHBdX84Cwy/NOPAuahv8aUTUcvr2XR+NVGCAz8lOyrsS0UbN7CIfS3/XF73D3QHnw1s7vXHFFUIjKJu1kPtce/fW4xPeZP6Y6q8/L5Jog/Y2kGk0C+JUtEZVc32KtV3jyM+By+f2g2MVu04bgXouhDI5xDCKkcRZ5y/JZUMOUoZlAa2IaO6BXPj+OVyvVAtcEXnFzIt9nqaWFpmrctngOtih7FlkxHyqxpDoUveoBmJ1sJS9/zhNfpeyy0x0fSwQ8q/Fp2zi7MVtuo8rXqKQtld+lmja5X9s0k7+Dkc7lOC2Uj5MwjFqDGlB2aaIbW3rxYpxjxKI9IgGpmliOMZ9U3GHwhdnaOpEC4J9U6KNEolBmXsmpOTEkiwmJiMDJzvSdAI1JUnHlbxPEoQbtKX7rZAL4JKWvvMzbiHCtqf0lpNo3wERp9kVc1AMWustwCucHvjVzp6zhoAB3oJGjxnUg8VyyiyGJRAjiozdpqIMZThSqYLetJvccqoE5r3508EWB62rngnHaztdxChJTSXcewptzcCWhWiSLKUeiaAex9MFWrSsHKQJRqboCjSrfisLgaj9OKxrEXSwBjRT1KLlyzNdm8QrlQG0nlWAPwe9/HyttGBEGWSSFZR4yA44xTWuR95kQ8nP/s8CFzPoZmSqhRNGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3NoTw39Hcj0jqoUk75XmP65AM095uQYLoRNV4KfxZeT2Pe+9R4u1Tj8ptZhB?=
 =?us-ascii?Q?ij54lp8eo9VMeVd9bf4KAOh3cfE/6oJq17yRFNLoAQVquDdMOJknQaF2pajq?=
 =?us-ascii?Q?HycXbYPb+PWnBTZbMEKDbja7+wRQlpE/9zE6cRxk9QUm+f07s1SahBKJl8GD?=
 =?us-ascii?Q?7VFRJqLrVv07zis+BRo8Y8IBPWpJ6yHLoI+b65ee2YNLKLzUBcn8EGNJfkxV?=
 =?us-ascii?Q?wIJestNO4VTvSy1YOOXBYYnV4AXCDlIchXMKPax0er+bSPYF+CUqiewJqMVF?=
 =?us-ascii?Q?DLqXix+nRZuZvF2Oj/oVKz0pJ+yUA2wV3Ndeb/VPLBM55YOVdmoNQu0oryF+?=
 =?us-ascii?Q?D65rYb/QVy924HF4L484b2cGc3x/DJP0qUEM4eTR/JRv98O4U/KcDLuIReK3?=
 =?us-ascii?Q?UjWWRiOUsI8r5mRtnggsbHhCAPfmIB5EokzwRizOwQWtw242/jg/Wpj/mrZB?=
 =?us-ascii?Q?H9BBXJVNWW3t7g7/p2dy26yeoozXtojge7PUSWfPOh7r8qovnNtn1L+xfZlg?=
 =?us-ascii?Q?N0wCJosRT9eBB6QcgGGBcbLAitT3ifDnhl9YMEMd6+uSV+T/1+00mK0GGa/9?=
 =?us-ascii?Q?6YTD8RdTwXYvJvE61JhNYhnZWPtjgVjCyCD3dv+tR3agbPTqSBPGtfisYxuQ?=
 =?us-ascii?Q?WJtk7CQKlyTVhk3Yz3aPxz86o07/klnwiv1JLrmRtQgsiz3tebNO1O8syq4b?=
 =?us-ascii?Q?E53OHMy816arUwD9uW3Ok0g3y7VGfA5t7LAGcCBX1PkShig3W1xHGNgC3dm9?=
 =?us-ascii?Q?zogWQg7NvXpQgmw10Oy2e+RWgYyx1RISdKrnFqNChPE1u4WXJVuxFrSR9jVc?=
 =?us-ascii?Q?klI38gMyZvyCX+hWaDvPuqpPhRnMmSuO1MvEqdQKPf2IywMLVDwtSgGjmblb?=
 =?us-ascii?Q?0+GHsVt/+pUDeekxkloc0HvuggnGwqogGucxcTC9O9jEJtuXCj91sALqIPKf?=
 =?us-ascii?Q?jNWj3SeafRITh3FvxDxnZuWdiazfMIox7X/cmDCnUeiiHHudlLzy/HOeQR6y?=
 =?us-ascii?Q?z32tVqzHuNwdfDL/vk2Tqqxo1Z96qX4z8As1BVf4AGxwpEZ/S5HgbOiNf99x?=
 =?us-ascii?Q?Rc1PNhQvVG+heDGj0naHuTLroz1svMsSAraiAV7DGmAxEGTDMmMg/DfIuO9J?=
 =?us-ascii?Q?AIEShEI/CBvlklxTa3NHDCjCSieEd8oDaAGJpgZ2C48C9M4YxO84HLyLeIgZ?=
 =?us-ascii?Q?UPx+V5F0V6enokA/8A5EP3V8e2dIMF2H+g0RpCaSsd5k7hgFCE7YIchDDwhh?=
 =?us-ascii?Q?m6e2Ca+rFYNW8DuRp+R39n2LPgl1arK5TjO0eqlIMsERsbAXRH3PLsnEKtfH?=
 =?us-ascii?Q?KD8hUPAopDxFkhXQR4hcdGjc5Wpa5wtcR8hOXbt68Pi6/HsYxgvtSOHmEvIg?=
 =?us-ascii?Q?qr9rRFkcqi+GvUOfnhtDbFEDx7E9dATdTuLlxKk8z/Q2spZvZt3sCihvaWPA?=
 =?us-ascii?Q?dtwBiScx4yhsoggJFobGbeVDxSYVnUThZHAzUh5VvGfm9x5T5ZL1JrHb6sH8?=
 =?us-ascii?Q?uISxHJdai9LyRRKG08iKNmavc//kb83C6HjQX/pkMlnKtIh8v/W6fSzKmXCH?=
 =?us-ascii?Q?j6JwfmV+DSjCHiAVlCfhIfO65hWFweJG+djjXAmbW81rSOG09maxvak8H3Oi?=
 =?us-ascii?Q?AsLPi1rG0e1elP37i2MhK39dQJTcrSN+bGrrNsNy6xhKua2ZyXdnDU1GQSG1?=
 =?us-ascii?Q?F4wFqlzl0MDlEB5i6Veyo+RwIOtx/0ogbsi1HPBWHTAXR+wJLdbDd1NqP07Q?=
 =?us-ascii?Q?VL/02cB78PquMtzXoxhBIZcNX64C1Z/XMTSSxAJrg5c+U9GHDQ75?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a198950e-766c-4cf0-01c4-08df1d80f484
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:00.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muX8kBrVffd8L4eiIVurVHxX/y0rBCsLiLzjdCV5yXHRL+hzGQh8s6wM5+hIsdLAK0068UzYaz0LCgArD60hOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

The Root Port on R-Car Gen4 (DWC 5.20a) carries the RAS DES capability
with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Add Marek's Reviewed-by tag. No code changes.

 include/linux/pcie-dwc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 097e806c714c..e5693895dbd5 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -38,6 +38,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_LECARC,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_RENESAS,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{}
 };
 
-- 
2.51.0

