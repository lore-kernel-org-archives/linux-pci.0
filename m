Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576598;
	b=LpuRfAiSX/L26zO2C/lKYa+WJ3TwBXzamef8Q8w9KkSG/w9mumNDj2F5V8b3cSi/iTmy
	 lzw0uUqHFg4I4O9mVaFjGJCiKdyiDe8v9KKSreoRjDhKnWO9c6312Yms5Mk8fLHCB8lKu
	 pt3H/4Qp/u9qAd9LLWrMHwx+rXXaHvshplLhMh441g9/Ky/VJi7+pLxuVfrGAKxjoJ6W5
	 qt0Fz8M6MxyVFn14xKVb37jyZ6q39GygWUa0GfgexMFKIs+7cxRWAnOzupYsZ46NpGVR7
	 VK6DcaC5vg53o0Biz601BrbnbXK3ro5lXXJMh5qFmOmxADVDonGX9BKg8MNljFin3AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576598;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zHgc3sRjAl9l+NyOzFrOKyH5QUrUkNELfmMZSWqz4/o=;
	b=lTuOw8GMM5m5nLpuSJj+3ih5HpqwWN+LH2n4DoigLUCm46TQnNtc3VJI3VIi+kgWDMEp
	 7YHCWHixkQaYX+rfGCiQBcGe9pnEJKrwR6KwlYNNkpRPnSwG2DMOJ6vkeqLjG4RIvVBe+
	 qW/kIpHBDPqoDUzVoYDfqzGrfdwKBAvzosdSwmIvL7mm0TgDCNrd1xTN74rGy8ZTnjmRL
	 BB7krDmw/Bsdiiahk2mbGwTp+MLMd9E+8TYJXDwlAtt2F0qICA2g4tr4rYtT5ZLA1PCv2
	 oV3DDuk5cH+RsH8jGJAv6xIRDJ7uUIeaqWa8eC9qwB/eJbu+e2Z37bF44/BHaWu0Hpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=oMj5zDkl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.90
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021090.outbound.protection.outlook.com [52.101.125.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1660A5BC3;
	Fri, 13 Nov 2026 13:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C1660A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=oMj5zDkl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5Y1IvXHqQlC4mc+/9KrNmWsqdOpmSsx95dMOkOUO/4n2xsdTAlU5PwDkhTWioO4cKZJgq9C8gj5gIRO57cEnTvH+k1ekqqOYtEryos9kEEtNXyT4tayZE0E4o/jsiXX62J0ESp5s4ClYXU7Lzh0NX3AYKcsElnmCha0pdOjiAek4rFDCZcXJSousAurlggbQWJd2A6N7ZcnOqtxXq5YiXPQEus2IWjdQm39Sap7UYxbZMhBUjkXMqH27xvqp+GX80Jdx3izuSrmRiVukOMykoGINvVDyDzG5NPXVyiA+my72/5f9rEdZZUcx/WS0xH9MrQextSVRbiddvp8zK5WCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHgc3sRjAl9l+NyOzFrOKyH5QUrUkNELfmMZSWqz4/o=;
 b=y94yqNP6I3UXhxnu5iaDfnQoFd2d5G2yu4W0mOAPxEWs1ZORHEPx9EPo+zEGopB3SPu68clHoyRfDfUSOtc0CBoIajq3/sY9cIYizjr6ASk0gtukFkITBgQm34J0TJBjqthefCyecyc3+S7lrZKZc6n0+suxNuF0yz/Deg6L4DgjiItGggES3iVEigUqnE+f+/4gzciiH4XDrUH1szcKuzPFImuINam8tsIcjl46eQRk3hiMiL9em4jEpmlILweFpL3PabrmDIkyxEnBk4j6GeRNb3stgH3lU4ydnHdqTEYbX0D4AhsTYoOyQBU5Ya22yv9Xks+S1PlDl3w5CW/RAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHgc3sRjAl9l+NyOzFrOKyH5QUrUkNELfmMZSWqz4/o=;
 b=oMj5zDkllDz6GpoB4B73GVp8SvHQ2BgK/X1r3pPp2kH7AUfuwP0xMx8WG07kCydmQlK9a1R/Z6NpHOaQaJW8XN33u32ABFaqaokETFP4j58Dkcf8FyMHzbnHPZ39vdqXTGB1HALcdJlCOo/R0CK/x9kBRgSbxJbg+mhilbTlYBw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:55 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:55 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v10 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a BAR
Date: Fri, 13 Nov 2026 22:29:35 +0900
Message-ID: <20261113132935.4152566-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0035.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecbb98a-755f-4456-6e0d-08df418a3489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	X5kvmRDIh2KS9ohkK7GxCiNxu7ARnOfHGS5MgJ55sDs1K1hrswe1w5Vxh17uRNyx3PBiWOj89u74/NxP03RGFWdGws76OqaBjEPi6BCOLUsC0kAvBmtt5GcoP+Z2mAQGZxOKis7vFfbXYCKPXbQlGXCmIYztR2q/QW/chmakwIHYpKeeedwMDuRYgvsxZ9s5d1viDVyRKwleRQDo9vOzv3FKKcg2dVtn6f5hXkpYSxCs4sE/D5EIrr501qF0+cbI/dh0IT8MxRXQ3fyKq9HbKMKXPjfEOZPWC1y+qFNtvrfXlkhubTAi9gjNRsL9BpMkyBKEg0Vv/6Ltlfid1XzYtUFcNmJ4yw0yAMH17RoKfnp6E4qHbgnE6hozFR4ofhqJxuHQ33wv9rtKreZ5NpX844Co+ctMrSsVA+moG/VVCvVbM7DuG0hXPHEvUVv9N4GPnf/Zf2MVsGToq0OeEsgnluGzV/AWfm7pQqw2sJPR8gvrIn9XbaEfHrcVBfL6qPy6tK0vj0q/s9YoCEffa0uHlWKE4vS6lO2ZlwgGo0RebtmdptRdYRZb2qrvIPHWxHVox7ipFZ6/7wMoul2fb9F48gxFamt3sY5Fa/6CMKw5ZelnryGa7lgGDTh+0hFOGv6fXU+huQwz2M2eSKNSaLPbodVoYQvFrocTkg9SiQmF8Jo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fF+vYWqV/8xjDz2M8w1p9pUcxmGF9w5cxDiiSisoudSNVEiTQPECQze+bVjV?=
 =?us-ascii?Q?rPXg9VawicjdkA0axu+4EISh7Qgm2X7UpHRdywJISUCnXsq4rLeNrsAx4cs5?=
 =?us-ascii?Q?8RWLqLD6Z0FLAjSc/K9sJg79XxTHGJyuiBB38X5hghVQnj/BlxtlsSsE7/qM?=
 =?us-ascii?Q?/lOk1rsZkJJodRZKGPs049D+RPy5qHzegO5u7UlxgCwpFhrtQxZt+y4avK5T?=
 =?us-ascii?Q?DaBNLN0R8cns0r/Ul1i7fYXjVeZGEneNk6q7a/YFDyjYGW036JIjQ7RxgEe+?=
 =?us-ascii?Q?RvRE3PxXL8wlyeMhhWKzcqJw3NHGCBdFoTkpXYse3SRMpgFYN65dEnSjluy/?=
 =?us-ascii?Q?z+rmwWeSx1In6FJMfPQjIIQW/I2pLrIJSIq1QUafZB/Q+s8oLhOUHShxwBYw?=
 =?us-ascii?Q?5fgkH7AEDpHP1gfNV8JZ6E8DDkLjCYCa20WvKsilPAOQPHJ4aJaQFKCv3iym?=
 =?us-ascii?Q?UyJ0b4HgXP0rsOyTUYM1i+gKbHRuEyEpYKpSBzXzUJQarkBR9LMd3hKbgL8O?=
 =?us-ascii?Q?pfcJUr005TTKikHSZeJryLhcoRwjvtV+OHvbS0X6nchnXudSB1BYFB6Ejh4y?=
 =?us-ascii?Q?uR9bvVTMY6sPMPCzYlDtSrBKWYEYuxR8EVdY98EPtSJe2aNrvLE8ttJlfpx+?=
 =?us-ascii?Q?32rmQVAyScDYePYsOjCDWDivWCib2VtGmsAco1S7ETyFbWbI77opgmEI3X1p?=
 =?us-ascii?Q?7+4fwK3QgPYeZt8iQrxJqYex3/xA3CscIO8ky1wysQ4GfheGOZJmYxqXZSva?=
 =?us-ascii?Q?AER49P9ijDEjqqJlr3FIDIF6D4GXQcjdSAERpI+Mva1jQ8tibVyreIyIzmWJ?=
 =?us-ascii?Q?KtQO80NgMP67Z6cZT1cDY4l5IDrtSlj42vgMnrNpZwgURw2FmXiTK90jfLGd?=
 =?us-ascii?Q?gdzIXXQsUvGecLc52h+fNfr7x/S9j+bQl6A4k0Q3xgYDsTS8WvfvgcgaysW3?=
 =?us-ascii?Q?s0MnWYiT5yvJ02dMZfEpjH4meReQSaq7uFeahKvJjdJ52bFQs+cAYw7pXfnu?=
 =?us-ascii?Q?dh9xbC7JI72ZuFBInhqsMagsrNYDqXh/1NodsP64wI+6SXnedv87wHZ2+elX?=
 =?us-ascii?Q?/MSxNGi2zazUBtiybvS+l7dXuh34eWLwZgGhOQ2WekW4IfiRO5eQO2TQLnhl?=
 =?us-ascii?Q?gAXTGlQeUhwftpNzwGQvktMNZm8YPehN2/k0Ky3ulPKoxigQ6xyuibQ10MMD?=
 =?us-ascii?Q?62PeXvAADVG7yRiQSla3kKYk7KAeNpkGJHyoL6wGDeu0FRleNZ/faOlL3qyS?=
 =?us-ascii?Q?vWVHrd7EH0a5g3SLSuH9WoKyYfK155lxU+A6U+qil1Tp6rwUpr+fcWieDafh?=
 =?us-ascii?Q?Tq90SctSgvJDEP+MYkHnepeSdGZ5R6fV7K1QVhECPHVL6hbyHT3KJ/gEcbRc?=
 =?us-ascii?Q?iS9BzRXy6iYDER+eQqzEp6adfItIXEzsWay9bnbFCV5r8iN1TkYwb4R0H3kq?=
 =?us-ascii?Q?6Mn+ASg0BCmWfhegdKNNRIQMd1ya/tt9lMC7SVftCbmmbv0qkztDWwYU2cPx?=
 =?us-ascii?Q?X1zmYAg0KoPWLEQuWWaWSwEjZvugRL7jH8Y/wMV9gTWQ7QPmfa/nc8hwVDcv?=
 =?us-ascii?Q?CAsSLbjKAowc+r1JeSoDqpdnY1hFxQ2+yF8hAaObq/r3/PTYkqXS9TiFaCb+?=
 =?us-ascii?Q?VQfolKoawB+tAAik9mF4dPOWJHyA4OqogXTa8XWbQ4OyxCn1UzbWwNvcGdCb?=
 =?us-ascii?Q?gXRAbY80CH+YEIt62ZgCHlIYwIm8UxYpjZencetUnPVer9+OVYzxg+BI4r3W?=
 =?us-ascii?Q?H4Gm/mQq9sbx88HASZ5Xxei4/MoYG0dniNkB9XtAjvKdty+in/KM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecbb98a-755f-4456-6e0d-08df418a3489
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:55.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne02EeBWBo89irW295C0bUtw9qeXqR1r2RQHuMXEE/f754buWxG4BDL2qVohoQqRpYab/zlN41/MM7NIhdaACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

A vNTB endpoint can place DMA resources after an MW in the same BAR.
Limit the MW to the advertised boundary so clients cannot overwrite
those resources.

Advertise this support in LINK_UP, including when DMA is unavailable.
Older endpoints ignore the argument.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v8:
  - No changes.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 46 +++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index a70da2b4f187..0b4ae28d30e5 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -377,6 +377,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
+static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
+{
+	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
+}
+
+static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
+{
+	resource_size_t end;
+
+	end = pci_resource_len(ndev->ntb.pdev, bar);
+	/* The DMA submap offset marks the end of an MW sharing this BAR. */
+	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
+		end = min(end, ndev->dma.submap.offset);
+
+	return end;
+}
+
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
@@ -415,7 +432,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, bar);
 
 	return 0;
 }
@@ -519,7 +536,8 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP,
+				   EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
 	if (ret) {
 		dev_err(dev, "Fail to enable link\n");
 		return ret;
@@ -696,7 +714,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -728,21 +746,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t offset;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	offset = ntb_epf_mw_offset(ndev, idx);
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+		*size = ntb_epf_mw_size(ndev, bar) - offset;
 
 	return 0;
 }
@@ -840,6 +857,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
 	int ret;
+	int i;
 
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
@@ -851,6 +869,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		dev_err(dev, "Invalid endpoint DMA layout\n");
 		return ret;
 	}
+	if (ndev->dma.submap.size) {
+		for (i = 0; i < ndev->mw_count; i++) {
+			int bar = ntb_epf_mw_to_bar(ndev, i);
+
+			if (bar == ndev->dma.submap.bar &&
+			    ntb_epf_mw_size(ndev, bar) <=
+			    ntb_epf_mw_offset(ndev, i)) {
+				dev_err(dev, "Invalid DMA/MW boundary\n");
+				return -EINVAL;
+			}
+		}
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
-- 
2.54.0

