Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657363;
	b=KUHYDqlvh6pUKps7u0CbdRVU/C7ekpbNHzQJnAnU4C+a5dEQg3n6WN6B3a4Od4FM/L6r
	 Za4TRRlbkqOiNXAP08ynQvpfD0DINZOJNh9bUFgT5XB8vBcv1qhp0Dn2YEK1hXQ/m7fr6
	 TXUjt891PDc50iunFEhcQ+9WaLwlj8BLqPsLRWnjHII2+7Ll478KDnf0H3hMuHXYM0aFg
	 xxDcchHGsfrju6Xh3IStxu3FbgsZPpChJQkpSOPWUZtPEqMZX7qTFngXSUGrdvrsShwGK
	 iz/pXnUn0EOXQtBmm6wA/ODqqXaP1kVSkNMm0iP1Z0eExkRnC1Bh9RlYQ82x3E/01Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657363;
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
	b=1OjE55q0RnEyty7PpKR1hT8yW/FKnWw5k8a/V/IWGxquqBzGAfY3KRKkIujbaxfihBzo
	 cisOCYviPkJNZx4rTK2od96GG5MvJH4WIqWFKTma4JchV0jFA1U6a4yxJqg6m8/dtMyir
	 NdQ7APegMSoRmcEjFLlaO3n+8x7CSzuD+B0BA6S8+FelQl1JufyE20IQ6uAXtFN9105ry
	 xNNQDu1HiIaTmmR0I2Fy0yYKyLquyT5zGzeWcLZpcq48knxMEDTE7lCFz9E2L7d1iDUa3
	 swtO6q1uOAGJ9WyccVc6ssHr3b87V1OKxIy6ldW+rY4fUs6OEVpbH/3PGiMBXneiQkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=nNmOg7Ye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.110
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021110.outbound.protection.outlook.com [40.107.74.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12011606A31D;
	Thu, 22 Oct 2026 08:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12011606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=nNmOg7Ye
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxGdyX3HgSSJkByp9VJGFHMUT1qzFToZdyLhpli+umlZbPB1KY8Fw8L9f9p5vtnn1mO81XdX39EDCUkfCKJ3RN0oA5rr8i7DLPnY38ecM1yKCfGy0laKxbv2yvJNaeVF7NPYYsr+M0tpJtHe4Eflds73/Pae3uSDGMpG9nt466WW2uHDFquSxXvthy8ApS1DkaA2xMdEYhuqIonyB31nEq0rt2Qi8fDDS4Hj4GaBoHiNGTzWwPhEFLIperdnuyP/1ZVz9BYnZN06UJ3aBIaLAQ5BmhhPs+I77PcvH24sPjaGc7oxxzAJTZi7XYHJW6k5aVa8fxqFo9pjNnFmopzgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=WxjMda2fUjMbD/pRQB5xufrGQF7+txjWxIZGmpxLghyKMIKEYVq/VWtVPHebRwX6kv/GBt9OyTQSAZifKjVkChT02xKGy2GDwiJcJyX+oIthIkg3vYD+gn6cdHIOKMdrkJ/FnTsf4f1ABz815e1vJqTQvizb+2G+zPyzvrBd77cOBQJJa/AjrKTFYd1anRe2U6hvN/QwIzMsVOTIe3atpVebHmgTzPuPl+w4ZpoqnFam1TjMSqEd6i0izkEQ6I2RY9ipET9/WdV726JPWVrHu41xy9McF40oUNKBcmmaoFTrNkpH4957Puu2DgC3BGnqzRwJhCXlqJBmaXh/uuCl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=nNmOg7YeVv0SixRqi4n6FoDu+nFyATYd8ROcDRsmYD16xX7+ps5CTuwxCPtfCZCIyQh2aQoARx4ofu50IrudOVcKmDTDjUoEI1vcQ3vf0M4Emp0YwvaKJ91HHdnKsGcdJtomwDEE9G5dulJ4y2KFIgctR7scPDN4Ft7x5IM3i3Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:35 +0000
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
Subject: [PATCH v8 03/10] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Thu, 22 Oct 2026 17:22:23 +0900
Message-ID: <20261022082230.3164834-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: ace64c3d-42de-4bfe-712e-08df3015a0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|261021135927099003|22082099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	gGHuDFq0dfrUlGI5wdPNSAOmcq4St8fbcNveaAQlipUFtxpixnL9Y+4XSrs1osCBTX30saZwabFfpavv7a11Skwa8mixud4pQoR/eI+Fn5OtTS1I8w4n4WqDHjMLzY6oyBaV3aUXr/cE0Lw1kiWLrwG5mlDlRPoavxI6vpDqA8rNYpUGdx0karZ2GuoskvU4ijwd5rRPaKF+cEXCgUBOXG/wh1RtJSzMEnxuSMsQ6AXT28La1h1wBQ+MBscViBFz+jXJCF1xFFioWxvi1vYyGr6ZruVh9inxx+VoXehDrfSkUXsYNK4Jm6OUMpFgpcWEHCSbLietlijtT+DQQzaDqysqMdqsG9VAf9wVvMaxcDZZ8XBEQMMce5iqrjE33tvuou7qi23qV8gD+UPlU01UiqNQcl1WY7/PYd2ZQdrQiLGlN9StXnW8HpFi5WyxQVBBqKB4xJuoVM/a0mtXRcn4hFn9GdOoErXqvSZXNhJEmktp3oLMxljOmrO5reHeSMvMTzu3u9Tjbbn8N6D0ggQhZhMSPCmy3s1OLTTCkHN/12fgSpV5/kTc5tygJt9px0nQnQS9I8IdHowv9SbthTLz944o4CCmYabLmDCHIK4GDagxnaMj+I9j1BJxDj8McqCnd/a5VRPG0QLRwX8lsYb03yXG4yascPCmGsDc/aSrAis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(261021135927099003)(22082099003)(261021123027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X7+DvZwZxR9JO39R9hc3R4ebs9xFU9lOUnhogUiKgw4yDhwdVTWcRYDk8tbY?=
 =?us-ascii?Q?hVCn7V+vc4u/sYeHA53nEx6qusBO0uWjDHMNIi/Bh8NvlakwbOea1ZYZJVF4?=
 =?us-ascii?Q?MryTT8avipICJGmwfOfodedHJORrMfcbdf6WXUXguEXPMXPQahFyNm69nlEQ?=
 =?us-ascii?Q?HFTTeLs6MMf2B6wR/mWazI6x+YgIouCsf11NVd3dOIGxsEYGiVydkJhpRw5P?=
 =?us-ascii?Q?gBfB60uMhq8g+ANhubJJUHLp98502QBtPw3FB/OU5iIM+7Q/Zwu5/DoDvTif?=
 =?us-ascii?Q?4ku8Gj3l+g3kaFlEe5ptXCSetgMnpFU79Ao1Ny/4hPLJkr/dolzIkIh11d95?=
 =?us-ascii?Q?ZiYyJYgl1fiF5sWsnbhmRxRHLGBqYn6zZ7s+Kf0jAoB30hF0VFeLof4Wwfu4?=
 =?us-ascii?Q?Yqh8ZThyh2FwT/6bg7UZRV0L8ReLdyQyC2GIvALIvpvpBhYJP7ZICWsdm9sR?=
 =?us-ascii?Q?nnZIi39oH/xU0VVC1HMtZ7KWjmyopPszGHq6u48IuywUDzhmSrB/bxBL4lgt?=
 =?us-ascii?Q?YvwYMvlDedmMS7jcVIXQCYgiuTPri1G4h8iFYmO3Fi2HYx5Mg1WVEAyDMd7K?=
 =?us-ascii?Q?eU5dTMsEeZK0rY1ul0Rq6eWpUdclvhmEkRAjJrbxkIevf0258tZmO106V2ed?=
 =?us-ascii?Q?Wu6UNFz+yd8Tnqx3QO8SJvpSKLC6g3Bp9mAstrYufWcONOpgJqjztUqRG1dX?=
 =?us-ascii?Q?KjK8OQ+2iUFCa57JqX+croXyqxtDYeWY91zdW9BgBld8sYCJUdTd89zOQqoL?=
 =?us-ascii?Q?EVZsMiLE+9AtuVGGan0LyICGNj6NaDrJk1gY7vx/057bQisnSpL7KfQX+FdV?=
 =?us-ascii?Q?yo27pS4OgB/r+4scVDw4A/H9+y2vnGxnIFhOcuOb3JZlBQ23Meszb/Ga5vVe?=
 =?us-ascii?Q?6BpB6pVRBNZzHVhucHgJyi+Jh0BFYbYiGPUZxL/BVMEoHKn3sPEW2gr8vMEp?=
 =?us-ascii?Q?RSEP9OqVyaJoE87dv8j8N2p0uDNPgGnVfyPCe7/zpf7C5Ssf6Fccn0zR4aFN?=
 =?us-ascii?Q?9kKyeD9hfcE+tQ9dzhj8ZHkemxQLEPD5BUcEU7SyFmkFvx/U+0UpJH/XcVMM?=
 =?us-ascii?Q?Wm3zUicXggHIrM/wM/UlpUuUwzuGvhwKlwpiDAytn5a+PUe/5P7ZLa/quzmh?=
 =?us-ascii?Q?ySDmJTW5nnircyjC8JYSMJdK/NOV1CC0NpZdQw59zKlTjKyIN1oNEF8SU2EH?=
 =?us-ascii?Q?NKRJSh8fQjcnZlEdwnyv+TvsHO2dofCMbpwHNu91gTNBY/7QGZ8Z7Wf4qkxm?=
 =?us-ascii?Q?2QbgUwwPgLfFJojw2uhB6UTbu1OSlDhRYj2gNew0rHl9HUMzH+jvVjL0wEbt?=
 =?us-ascii?Q?w3aRF9KAH9hk8rAvL5KSehDUsxmU1CHKR2id02A1Keb+FiuNw+WA89KRs9fA?=
 =?us-ascii?Q?o8d5PZF0wfrkJfnFbT6KlMEOsQYWvPLi4hQFBmzGnddIdcdd110iZXC36nE+?=
 =?us-ascii?Q?oCuOJ+shiijaDhXOP8d452pTFn4UB0iGKdJQyEI/7P11HQSyef6PRZfLDkP6?=
 =?us-ascii?Q?NdmHYicHFswITHkCzF54hjEL80z+Z5IYvLAEbBe3lOgYVh0Myqf0Vu+76+c/?=
 =?us-ascii?Q?ZkaGDdhdywAruOVHtDck0rIaPMFFGWJrpzAnciEeWuXzjbRHYfW9F9ZPR8KJ?=
 =?us-ascii?Q?kkBDimzpGxbO+DCQLMy8/TACz/Fou7nhayju6/zEYv1xfoCsv97QXFyF4j3r?=
 =?us-ascii?Q?bA4Hm7UuTWSSnwu8II4k3HQ+3Co+ThNdCNiiZ0COXWQvuQCEedrCeHRP4MtA?=
 =?us-ascii?Q?Gk8W9h6rdNX1HdzsOufZK4hAmIWFMFb7vtbb6hyGdZTiDcRP5tih?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ace64c3d-42de-4bfe-712e-08df3015a0a5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:35.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ip/zVFLzbMtlUWr8Y9iREhbrWXQScQiB1RZAD0hZ9YMRIra/A15EarrDBBhnX0FEbtlIAOSVuZI2b4tsoz6k/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

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

