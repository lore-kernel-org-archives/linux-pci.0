Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020078.outbound.protection.outlook.com [52.101.229.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45D30BBB1;
	Thu, 15 Oct 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028660; cv=fail; b=jGeCXyQwbbCqygj0xSMNMMhINIuV7KuXYUbsXP7s+LbtaOY6txyn3XsUS8AQChZZRWg8YF3khWHQ79khbmdTDTO+FI5Y1Zl35yIoVy60KjutPR1UcmQ9YIFyTPYut2ar3e16UFluQBt+F73R1gC+JxISQcJZIOH14S97Y8gyETs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028660; c=relaxed/simple;
	bh=K5CtTO2MybXH7Pz8zohR1UcO4w56F1sr7xd9xfD8m7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCM9EPE12SHlWdxok/rvUUVA5egrGZUprnA1HgWf056es8lXkJvl5FV/35jRC/VqwQBHGI8dcsVLZIabAgCfkYlnCAqEhQaboRm6d9RW1fLNC2Y4wu9Smf8C8qjl+ifFkQtt+JreRC/hHjtxNolh+1IYuq4wLmfCAAVsppXU05M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=K535qsph; arc=fail smtp.client-ip=52.101.229.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="K535qsph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecrO7H062yEv/Dp58Kx2HUMFpGMzCWsPATxtn1NwwPpWHnFqRmq5NUl6EdjizXhOL18xI2mz1F2bXhQKTNczFsoKHAYXXTfdIIxj+QsVBMBg7fbkgglFUHFgjoBFUvncgBvoWm72RrWlaJ9HMGB+L31p30uQciI7CvG+Q3nxheOwT7O/duBCui8Pqk8bcvpy7Wf4500l/DfkefIFNFeo/q2z89mhw2OEIRTdwQ1KhnHFXBlfi9xGNQ7Rm4AqI7Ajp9OeCWwDxeluRUbfQIjcnfneNO1fBSq5zgySBIk2+zgz/7lwsB3gSNzy9WUFwuFJDUHDd5v8tI4THEMZH+499w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeBHan7eiekf40I0txZdXZtFIA4b1yq4UpUIzQJ5Afs=;
 b=dMuZHBYuzqTHJ07gNCdioRpbHPOS3POUamcDsgJWH5xFyt/uP6r3TT/qLLkYAaLUMTiMtJEBX1XnDKJrIpLn/khD0NAxO2HiQwT7xTa/+LnhCCUJAFxc/T+zk6u/tmwwwHxx0y+o8GueuZpQYHgLhGV5WeftDDp0rAA/loe8B8+g8ESlyN+iouPgkCZMgRfS50qdnIJEOvHi7+zer3Dh+UX3xJE07/+nQITufQ7wAD9yewFmMYb/1Jm6n6GvFM+55R+b1XXHbVkNEQSNIjXaV8/L9BrP6RMXXZ1c8Vl8PgaOZg3u6Q82Z0Bno2G6cg86IvBPcy8VlSQiVBQDf3ouUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeBHan7eiekf40I0txZdXZtFIA4b1yq4UpUIzQJ5Afs=;
 b=K535qsph2DJ8ZdSN72vnuJtJoFvu3iSG8aNUVRMiBd+BBLOQ4g3WqjBjkUlR9paEDJzZRb6WKzk4r60/Us/eI64nsIsyeHHTHoXa7lPQRJdEBIrEWdxZueOcJSdV0NxMVoYRrX+6tEmtq6UibD/8sKLP8vw+0hORZsoLKdXwPig=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB6125.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:44:13 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:44:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] PCI: endpoint: pci-epf-vntb: Use a local epf pointer in interrupt setup
Date: Thu, 15 Oct 2026 10:44:01 +0900
Message-ID: <20261015014402.2976188-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015014402.2976188-1-den@valinux.co.jp>
References: <20261015014402.2976188-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: e440e14f-5059-4c9d-5027-08df2a5dce9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|6133799003|10067099003|22082099003|18002099003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MoHIRudHf1p88AHrvUCT0PrAYTXgcg6P67y6RA7wdaNe341DFSWQ3BOypSvoBGoOI7tZlBe+rTZVoZEvSmjCH2qrUPKMgSUJFkxTknO+zsOcQpnVGhbIBHV0sNerP79yS+hlCptk0+97bXDbkAjezoEpTYiqckrq/H/T60QPRUjkOAXH9Qwxt2h7n+8eWcuYuPd/MgOlQFdedm6Gjrrj+S8YUkpDXoD1b+8rM1HGhg6IW8Fzw2dAEf9cEDzVj8yfqachPrqtQwWBKW9w+7LTpzGWPXfVP4HQsu4RJPeOpN5N7C8YRvbnRKMRbyiooUGgOR4UG3xtvtDEUPEAqsBbV5cLjlXreiHglp16XpzHBAWnfY3B+/4enOvqXpT2t1oES4G5063lRQdTkKMUTCdrFBLMG7EYzdLC2CreCUG3HTGwbRQxbCrnb2QXZhmDOR+YAQasnd13ClFGlFdYl0tYb38k1CfbwSbifG/XTxHY6BEgRYQlou2GaP70nA3beZokEtiIfzpA7jdFAPrz5OXoqtaAe+eyfVg67uUuR7x70v/hlkWIVC1QvCTlGy/4HJ1wzKAz69vZb5dylb47zfcger4ncAEcPS5S52zf6woRqGnTweMn+rcQzwcXS2DbH8qb9Lp1pjm3HwyBOaPDYWuXQX21O9TvLgFIq58Aau2OxMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(6133799003)(10067099003)(22082099003)(18002099003)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dX8v+tbvSZmmJngY2ZON7bENVSMXVR/nje5CKOvrm29WVUEeLtjMlD08KAee?=
 =?us-ascii?Q?SDuDMM2Pet59vgvzwKiyIKmc0bNg0FKS88T3cbq+Kb3GyvWMR5lJhL6+ldWV?=
 =?us-ascii?Q?ealNK6hmfQSjiw9UaSdcPWtVE+9Cb50knzDmGhP0Ij9MCWUFeNXkQS/Rmnwv?=
 =?us-ascii?Q?eeyTy95yp0WweujoKu0iL8IVoN6e9nydXNVxT02Bmfdrga9Oj5kcgPUAWlVo?=
 =?us-ascii?Q?bJ6GUNW0tuCtt6FahRoL2xxA2h6H9wPAB91A+MATtcLYiiiJnk/KMQMZAvv/?=
 =?us-ascii?Q?ulXLPqiEzM87s8Z5zBn/Lkc4UrwK9wfF/EUvBEugabxQpOtm2O5QNq22agAp?=
 =?us-ascii?Q?49FAwL51FBYSxbcwjrg0nJOGXpTJHDa798mapzRX/ojTyI3/k5pE0Hp25buM?=
 =?us-ascii?Q?vYP28Zk2hxdxAb7TmJfDWQxxHhAlcXMLZsqNn+43g7FT2xuB2MZpx0gprZ3Q?=
 =?us-ascii?Q?7ZZqw5apsUbofWH87gVfddDY32ahsvZOeMrr+CLr2v5Jo0pFN/kmFeuB0CuQ?=
 =?us-ascii?Q?75zO5lVoexZL/VGANkMG9MZZ1vIN0yeewC9jwGGreB2VmVV48+/u240O5rw4?=
 =?us-ascii?Q?4H/NAO5/HzKmQoMU3renPpi9H70gitr9+hpy1sxILPmfK0LdcQ6FxSIPVYPQ?=
 =?us-ascii?Q?FghPtSUUMuMXxtsOzxwRTvJ00ynPDbMpJg0W7c5reI4diBO8TZScVYR3ICMt?=
 =?us-ascii?Q?HBcp4RJWvYLV3hbk2pL1xG0AJjYKhjZjS+ommepTLw3PG4LPqdJxgOJfG/Bu?=
 =?us-ascii?Q?CTUWuIRyT/lPfclr8fszi5P7w1XQrsO6/zx9VJG9l88Vk64hpkZb06kr7vvM?=
 =?us-ascii?Q?VOsdVY1htGoO3EW12Q/J2uNHTpGihrlcIMR/twFoYaoGzQN8SGIfoF8s4cmI?=
 =?us-ascii?Q?i6P1D1n2cFwRug2iWXCM0gMtHWP8mbkJiLHmiV6ZXEiL/i9jbMKx0/IH+OC2?=
 =?us-ascii?Q?Nf8WQD7d3/DAZ+3M2gv2ZLUR7MFwc4twtsS/o8MlsPv2xngPTV9URMzS6e8/?=
 =?us-ascii?Q?1r3C5Y/k5nFXkPsyzJswUYQR6g/Y1+GImAgCK7i8GHrqx1Iwj6ost0+/nIzm?=
 =?us-ascii?Q?U01g+PR2aoxTA2Okl9mbFjVuY8KVbcHV9xLsBUzaAIFF8Qd/r+UojEuMCqwJ?=
 =?us-ascii?Q?zWY29TFOS0tM/sZOq0q1eCDQayrN/w7sYrbl2EBby4Gfy6IQgX/U4NT8I03i?=
 =?us-ascii?Q?MDK51Yc4tQq36jh1jN6sKv0fH92m13X/cOcpHhsd4mNEHXKhacQ7yUVj36AJ?=
 =?us-ascii?Q?7ZNxt7FYpo4q7kdNeZOb4zLwqnFhDZ4Oy075c1UQ4sL3UuDePDVvubG0cQkW?=
 =?us-ascii?Q?OGzd3IOWPvm8ojgX4mvrwkEhAe2HRHcHJNIEdAzzkfkut8YQ2km/CRc/YPfJ?=
 =?us-ascii?Q?86sLLpopHOxoJONkD5ZGoqPlMJ3UoCal/mtocCUgQV/6nZqFLHH391eSwcWQ?=
 =?us-ascii?Q?cDwjEMvYEpA6U3gOZ9XB2Ua4RYAFlwyGn8VJ18Sk71RCud4cf1b8nqGVaeYx?=
 =?us-ascii?Q?gz7e/FfmrEeKvLwJ0UktG6q637LSv9Vwwwlh3oTYK3E5pgWdIwbl3R2Jk7yH?=
 =?us-ascii?Q?tvHZNRuhqEdVQZH9tKXsplVz6qqWlkbdhDfm94B8xjNB2qpunGh7NyQwojP3?=
 =?us-ascii?Q?00v7xRUSvxCUjMb0u1i0KmjIPmxrFiegvtGiIHp+m21HL1e0qHfkZDnpDQFN?=
 =?us-ascii?Q?TW2hPpq3H8NrMWkwfBh0qAnwuId/27cgFi1PqVwKLMjHep8su9kjIyyn23Lt?=
 =?us-ascii?Q?5SvHMJlkx4T+ni3YmGBnOmd0mc8Qsmu2v9H+TavmYvhcX5eRnQSE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e440e14f-5059-4c9d-5027-08df2a5dce9b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:44:09.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGGH1I3GMXr58gbcyL6riDhPBh7kAtippNPY7k46AcmSG8F0ARmsV5qJJPYPplWV8knA9Zn3xankvZ/g7yJc9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB6125

Use a local epf pointer in epf_ntb_configure_interrupt() to shorten the
repeated ntb->epf accesses.

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - New patch. (Frank)

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index a11f9260ee86..d74402ea10bf 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -545,12 +545,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
+	struct pci_epf *epf = ntb->epf;
 	struct device *dev;
 	int ret;
 
-	dev = &ntb->epf->dev;
+	dev = &epf->dev;
 
-	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no,
+					    epf->vfunc_no);
 
 	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
 		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
@@ -564,10 +566,7 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	}
 
 	if (epc_features->msi_capable) {
-		ret = pci_epc_set_msi(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      16);
+		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);
 		if (ret) {
 			dev_err(dev, "MSI configuration failed\n");
 			return ret;
-- 
2.54.0

