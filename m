Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299110;
	b=2Epzsp4Moe44lSpZOM8Xi7eoG7c5NEffIMes+nYMua7J5i9IkOXWytQsnpKdkMwIypge
	 mz/XpZTfeWALomxfW0pk2OFj1ep9xPnflAjNOgoIb5hKPJfH3etmT2SN84n+peyws1tm7
	 xVIfZ8bVKlhnD1RfgDOAcFhTAA8o/aX2Z7rByl+bPjNERpK+vg+EBmhwm3qPic7bV5u2p
	 kIDxh7uB5jIV73VDw9ZNKwtvTd8AWIe5z3ExAUalvYqmZ7IKeEJBMdQjpImBNvpx9Ytni
	 jVjXrh8SzKs3ALYBqiDFmwl25NOtjdzuvKeYKeZVjrR3Ai8fpfzJFfhFCvI0Ks/phig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299110;
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
	bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
	b=tSDuyi/LadDfmDPLsNhNj+1RHteh3RYwvjtwj52F17ptFSjWhgEW1k2rUMOkX7vm7S1x
	 LjO4p93BDpB0fUvzBDT0ntJsXRvbFxyVjgKEBNt7GdicmkNcTn1Xd4n4eg5fgG65/2dsb
	 deH98nLPtcFtJ4RvPAiQK0o+7XQc5ih3ayAJH/DyFBa2aHWv855pZOUF1sx88easAS5S5
	 Moog5MVy1BHGzHjeujSo+u1XVprZTIa1HUwFEYmS+WBgPyKid7FRZoD90XkQZWjTdr7uM
	 3wAP3oBtKufcbj7m37nM/atcsFgHuTqDzSdzSU/VVD+koWrgl2FU7DwKzW6KSuA/dtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=IDicl0FD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346560A2603;
	Tue, 10 Nov 2026 08:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F346560A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=IDicl0FD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvDX1euXAbKxJ+7H/NUQ4vRHSnpwPV/QWnixNqWm3oO/3gqj3CIdKko9gpWmrL88shsEQ2CXibfn62FdsT55a9dbX/VQU0QawSVUvITa5EkJ9Y5eJ7a60bYJtQEcgU/O9IBH50kNIRAx8Or6qvzXZSbiN3aeP6Y2bWICV09ONymuNmQqiiASMjz8VzV5mfDH1aTm4BdchVITrGd8htCfdLYNDZeywgwILTvRddWuDIp6p9+UxTSzON1iItO9XPy/xUPbTQfxdhrJE3tW8zGZ8o2qDJp2Lj3e8x3MD+EBUSOAXagQCGvo5g8w1PcEFmBKX/HMeZUU8m247sZf/h/UMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=k/8nKhlMhmShDjXqquZxx/uPA9A5UNnpy1/cvW4MFC1Jy/a/SVUjX8G3iINklFm/CzlOu7KKKs7Fivi0KU8lnyLE1e4Xcq6kGz8zoW7VtCdz0W135Jkt+4rCXg7aCbgRb+cchyIWtGnKfaljWiJXqsAowwYAaTlBcijZql3gbl4uDZlIGJmITjS4FRrvuxVQpOXuZn7LLh2E1OPRumas6VyDjr7i5zgSEcnN3072rmx+f24C5qRiBsL9yAPCleeIQUGH5PizMu3k2ySbrzh1B4oVIOW2Mr0a3gfa2HXBDXeSLuYGwx9W3L1O1qIt9uePYHpoLKz2wnb3w7SDYeEp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=IDicl0FDaC/zJDZn9cvwybCj0i/WtufADLWWp74N93s+9EPm6hOZ1Moq7c+/CxN+sVedVUC0xDkUHuV+0n+YMvz+1MLV8hSmtnXEr3TFCZkKGzB5SO58kPDTHvrAPMLCLLhwAZWGUxxr+neCqw8XAiuVx0grayZIgKEisfDAM8E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:08 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:08 +0000
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
Subject: [PATCH v9 03/10] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Tue, 10 Nov 2026 17:24:52 +0900
Message-ID: <20261110082459.1798763-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB3015:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bf1fb7-45a9-4de0-bb93-08df3f04218d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|261022075727099003|261021121427099003|261021123027099003|261021135927099003|261026121527099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	UUso021MiW7YQ18VrzghMeD93D8sWh4zDqiyARgYIASuRODqm/CmQKmGT3HnbA7TdOv6j6mtJI1pw7x0p9nwSOZMS7PK4oRBJufTdAZ1J/lAVQv+7KB9vgnlG6MKxU/txUjSKrMZwoxkupxJuz6gssblODtWAO+ZviJ8dv5v2Oix1vzPHnmLAIgJ2SO+EAMJYci4zhT3OueO6a9OzcC9QDXxyLZJJPNIC+u9STwcTePRY5LZQlf4eHCSItbhliNSEYtUiIHlT/m5RlAJzzJci3Dejx8fVnN4XEVc+8AlUKUNeHXfUIBCj5sWWEzLia47NI+JvbUnq1epqF6630UAEIxfKvbF66zF2ENTg17lf51dUmjeVUW5C7szsswCJObn496ny8rB8PXIbWS58LNDQlVUW8uRin/t/dc96NXHDh4+Yhg1aWBjiBherK0hnSrtqtoyZ6zGJst5mGXq4OZB3fcjElNaryG8PiAdBHjzAQIaSz3FhzcMRN35nxMLQF7NOYwKPlmEoVyHKt0Lhy455a79MGQ/lXtABZc2weoSngs0KJVOOZKQKm/d2Flf0ekbP3cAEmKeNaIQy0L5afqL+C/5GrtALxyRweeSzBhfmqC1/4rWJy3A9K5VQdcp/+9jLxREZrMiI8PdhlhRIyIH/f25fOlluTfmSAohIQQ5ccI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026121527099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WXZXMhlw9IpdzB/NvSX3Bv9xn63eshU6xKlcGdY9P0oJiB2jeHv759Ap5HMl?=
 =?us-ascii?Q?FKOYl5k0khXbs21XWvpuK9MxqurTKRCBk3ey3pLjxqUPQUQsc/RllsttchRZ?=
 =?us-ascii?Q?sZRK+ideewsk6qAKEMOHt5ngOZtU1ZKeHHWIt070fAznLuyufYaHdMUqgEqJ?=
 =?us-ascii?Q?UEwAlXIMxUiow07RdXBbpfMvd74k5mL9OD8WHOj36damwlnfjrrd0oGSIqHz?=
 =?us-ascii?Q?/k1FCrtWv0B6tzwXh7BDcQUrwnKhT07TqoznFoOFZ7mqKSfMzK+hDbLpiT+3?=
 =?us-ascii?Q?XLfBfi4vqH2ih1RXxciyxygXbZ7REWnfWG3PrjF9zNIeBrKuuVuqNPMrv9EU?=
 =?us-ascii?Q?AJb09694yJoHlTX7edbDHuEMFb5f4MEevhIzLl9QUt4v6Hyj+kHdhQGYR3XG?=
 =?us-ascii?Q?EWgJt5hZDj7XzzYVcxGuGN8r/AFjyoKpQObAWO6yAofl/EoSyW0Q4eR9Y4hg?=
 =?us-ascii?Q?INi3Xp1WnM+qk1qqzxee+a9fmPr6o51B7ccL4vECOXEmaj1Jdqfcc7mMAAVa?=
 =?us-ascii?Q?XrZc/7dytkwhH8iCiNRQQqVp7sdCV8mwS3BhmVw7vc8AWIa37rtOpndPmXko?=
 =?us-ascii?Q?julNU9MKHPbuSzvLUNpCVDP0NFTUEQpNbAQTXeqas5NP2xSL4akp34054Q9i?=
 =?us-ascii?Q?YYJKTXJNqta46TYy28aS6CSmThfjQD2YwFj/2djwecyezPQOAQCZE3B1H7Aw?=
 =?us-ascii?Q?w84b/SS8Tlf8V0nFnPJQqU8b92nq4D1gntM+tCgMe8p4Peq++Xbzvja+BVwt?=
 =?us-ascii?Q?A0nM/weZiHpboRBkYwutOMa4oCC7U/hqDkqAkNTOxNQJO3fpZsBUIjvKr8T5?=
 =?us-ascii?Q?UpygmpfUoXpR1weojyPkut9pUGJgENmLqIm5opnLVhQEqirRE167h+56wU7y?=
 =?us-ascii?Q?CtdI6VoaLA+X8C6tbg9/GmFe2ESNJ8Le2zvNVvtHSvpq6NQKnITAG779gBm+?=
 =?us-ascii?Q?y98fMCCygQmlwOUfQdXBYZ5f4j8DOq3IplIhMF/BQilfgaM8fIqlrnEDTGSP?=
 =?us-ascii?Q?AnZLhz0ou5uDqujzqcEuhIr26OR/rNJwNr4aPC48bwQlVJy2vCKi2L/tdo4V?=
 =?us-ascii?Q?zmX/AC9o849mGyu0yU8vIsUFbvnGPnwVphi/0KHNqm3uNHnLC1baZ7Za3spr?=
 =?us-ascii?Q?cOL4GpyaN1oQNDTn6xOYVC7bO4uZEvwxCPJ590m0BEKJ1OCqvgrX/+L34xMt?=
 =?us-ascii?Q?fhfbtFEINCsOedmE4pA9396t1+kFYCJ3Y1IbuOdpIsogDRC/a2KQvPVtaadr?=
 =?us-ascii?Q?znze940lF8Q3kOWvvwSUFTyRbPWiq5iVJO5E2ZEOw9qPogqnG/CyF+bWlWM4?=
 =?us-ascii?Q?J2rlO4HUyLc2He8XQjBSVRKRY3uft8hPAZtklsjoulUua9TiUAX6Nz/k7X/i?=
 =?us-ascii?Q?xRMnXtCr0xe3QjfX3v+e9P2mlsvvcFxGLK6bwl5N/n7hRDBIg/nX5m3KC8qC?=
 =?us-ascii?Q?YTtQC1r+q8zuXvd7FOP+HcCQw9I5/iFp+zEHm5SMFTW+rCctjfUBIWP0BaF1?=
 =?us-ascii?Q?pHYWS+AzH4JZz5lQyAVwWfVGq+3vez+tnYihIUtXckHa6uH5Tz+CciqlB7t/?=
 =?us-ascii?Q?KNZKffMkPHu6oyiT7XxjgL32MxeQTjVWyAxLdqxZYiXNO3831hVPqJWVnY3L?=
 =?us-ascii?Q?YzfC5NTjD9EPfY2r/qIsP+1T7DPh8fnqnKpZy9nn8o4dhlBu2uyD26ZOsUNL?=
 =?us-ascii?Q?aa9ANyiL8jVdFGpn6uBOKLuXrzHX2pOZpmiNPN5sAgJQVJZ6U3/4upbpmwrX?=
 =?us-ascii?Q?yndUO2xZNu2s4txhG3KzauJ6dXkGm+gOh4ZvCMQlSejAHp9+zgKX?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bf1fb7-45a9-4de0-bb93-08df3f04218d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:08.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf/v5LJUKrFl9dwRQyMxqKHJaL5T3EG56Td40mgPtzRVy3KuEusjwBVG3qLanrQ3idRdh8KpBEUcxSuRkJtq5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

Move epf_ntb_is_bar_used() up so later BAR selection code can call it
without a forward declaration. No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f77e28f2fe96..1a0ce31e680c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -244,6 +244,26 @@ static int epf_ntb_set_link_enabled(struct epf_ntb *ntb, bool enabled)
 	return 0;
 }
 
+/**
+ * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @barno: Checked bar number
+ *
+ * Returns: true if used, false if free.
+ */
+static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
+				enum pci_barno barno)
+{
+	int i;
+
+	for (i = 0; i < VNTB_BAR_NUM; i++) {
+		if (ntb->epf_ntb_bar[i] == barno)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -906,26 +926,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @barno: Checked bar number
- *
- * Returns: true if used, false if free.
- */
-static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
-				enum pci_barno barno)
-{
-	int i;
-
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
-		if (ntb->epf_ntb_bar[i] == barno)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
  * @ntb: NTB device that facilitates communication between HOST and VHOST
-- 
2.54.0

