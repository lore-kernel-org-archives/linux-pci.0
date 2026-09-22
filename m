Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013072.outbound.protection.outlook.com [52.103.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71562F260C;
	Tue, 22 Sep 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089410; cv=fail; b=jWGoNlyVbF5mQrfunRv7iP+AX1LccfoJ+N666nzwi3q/DmYGMMIH5EzkNkn4mJLZ5XeoajBTG9jI4nHuLPFQESNN8E6TVQRK5w8ul2CDcxKa6dDakh/H1s2p6gSSR7nYQoVJMEsGxUUp3SpPVKSanMfsf2OnHBksAX2wKs1rzfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089410; c=relaxed/simple;
	bh=dBul0I7CYx3aulKhV6mBIXlWmp8Zwu5liL3nYReOiBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=niTUIa93EFkcb4btuIz7v6HJQgyWN/oBxhn6tQ4y1p7w3bt0FaOqZmEA5Fefo6Gjl/ue4GlXAyxqiR89nBQ5bcA52LEy4p+ceCUCGWx4nI4W19s69EbnT1PIMk3q/SaAWWgU023LoBJqsIa+83aNjamfmkAyPhk2aURe+mRfFbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=EN1owVj7; arc=fail smtp.client-ip=52.103.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="EN1owVj7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FT2CvQAWOuAWIDbDgN732SVILsgbBSI0gBAHs83xGn7JIvIlHExmkQFW7wqMVUV3GNlvCfMgMHBoEwzGlC6IXvG2TUlAdvOCmx2rpoNFvdxd8255NISEHZAhgoxoEPv9IQ9CWxVBLxckIzcp63PfJvW6tYZgZadwyWWp/71Xy2azzkwkD2GxDSQl1cDBJ6bRDGp3uRMxwLc9E32EUPPACTnyg0VtZ1S8xA4ViyM1Q2dj7uV9fkDewsN7Degu2y0+ev0rsEsAaOuDW6qh3Q+4idaSeh8MhdNaTzn0cg3d2XINGfHEuUJMSuCMYXA/HuQQI5Pad5SMXFlPZljsso2cBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2fkXYtNflapesJlDO/fMhPg7r/IC2zgPHAlvEPVLWQ=;
 b=GuPYTE0ebdEi9nYknKKTkHi9cCbhRV3sYv96JW4SP6CTuqwxCHQZNKDYXX8Y5FWiPugjpQfRfIYyzmYK7VkPGpwxXBXFyssVHyqdSR3sjBW3EVXAhClKevUdUwik6UJ21a7x9yUUr+/nd5fEqUQJmWozqaje1LP5IskWDUfcPMNnIPQ69/gqvYvSfnvWMUros9tvqVSq6S6Z8Sb586PGEWKPbDjawZu4rZTHRNnvGZCU8KMf3eqDPf/e8503t0HRbrCI9SRltLHdCIoRg/iAJYmEF7LvkCdNWbiRyZQIyQSQWzaKYCgHy4gvwmbE7zvWNIGfuefR8GJ+yPQbt2ydaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2fkXYtNflapesJlDO/fMhPg7r/IC2zgPHAlvEPVLWQ=;
 b=EN1owVj7OsJl4msXdfbY4T8u9H4x2OyKDt6YHUnpbPXQeAPF0IAMx7tf4uBsXT1rlaNfH6jrcDjqLlDlQmj9yep7vsK9CvMPY7JUxFYOKWnN/msm8e4gDYJdsfOVoaazJuXWHRAf1hZX2s7lV/CK7dnEtkst2DSJI/xxtUv1PUpTTEKl5Sw09oLfdhnMQKJR6WQUUSs/8gwEOdFpIPvYaliizwBva1lLoTdYnwDE3ltbv97ItLhtIM7XjvAIbUhLrgQcrVfOhYrSP3bLrbgyH4UxnHyrw05+Fw6tZnNxRGviVR8m7mvcB5qcC1TWmvhQJYGF4NLHhNk9G8VdRzuB0Q==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5711.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:03:20 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:03:20 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	ben@cressey.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v10 1/6] PCI: Validate ACS control bits against device-specific ACS capabilities
Date: Tue, 22 Sep 2026 23:02:53 +0800
Message-ID:
 <SI2PR01MB4393EB421B5947A5A25F4272DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::18) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260922150258.3087572-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cffa4de-c8c7-4b3a-637d-08df18baa39e
X-MS-Exchange-SLBlob-MailProps:
	EgT5Wr3QDKyfJ5ctroE+AnoJKQNH7uyZ5k25ePaatxwni8uYQZEl6OXeoz4NNI3fKchlFetGjJRSG7LG7ut0esVxmT29GayrCShp6BYzWRqrm442rhRKt82uZ1hb8XagKKt8gsh+p9YXfWSqTkiU5hyfK0jriv7+amMos2PNA2CtAhC2UD836YxEj9H2PgTdPeKO4se2q2cLiwULouvGoU7h1wG+WCyK61QJCFpPQyTrCAYvl/bycXTSqIpHDr1lIVmffiL3i8ZP1MugsaIgs85lzleLThQ8vROb75gPpZIo8lvWNINXij3yiCTClPyumsvScmaJVFctv1pTeI4ACJAkSnEJ3MLuc7tsqBMVypB092An9/FR0aQRoDbcPNJJCrfe6HOhl5BWvISvmj6x6zS5Tn4bmlGpdjt9g/EIa82l/urvhCjNFbfE1kE7FiDCJOBX0QYpd3gWXbe8mhZbyNnXBg7u8yLX5Yi4MCAuvWzpQLWYpB5QqOlEpA9OXjt8e2HYeeb7OiRKZwP5oYt/9JMv3MFB/vWzzUXZN5rr7SCe0U6ZKbjNV0I1wjnAivfsUGbtpqRr/pa5ldC8Zkgama1VY8YBTxGOQA/2bV64fvaMty+H5uQujF2zFsYoeUqdTHVXn2gGMP+bsDZCsZIuwnUOq70Bf1dQjk9EO185zIDmxVCplN5IAQGZlRA/V68cMxjJlYAkvGEVSzppwG6xVHWnPngiebqqr8xBW00Gudg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|19110799012|8060799015|5072599009|41001999006|51005399006|7042599007|12121999013|37011999003|15080799012|25010399006|23021999003|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ouh2WNTj4QBaohUfAAjwnWihy1wAONzl6ZNtnb4iJKxyhf+CvaS3+a7aMc5e?=
 =?us-ascii?Q?RY6W8/j+zIFYhiDMESivXlyC6trPN2Q8J4lxltHfxp/J9IvYRiqtRSu2/7qB?=
 =?us-ascii?Q?Nxoa0ZdzLhD7jUJMbkQzKNW27tTXHXWfVCxCXeJwdbgbVVGRf9xH4gMvm9K6?=
 =?us-ascii?Q?F2tL1taOEF0HPORilzZVScbfUzelw8vPapzw5BSOccmFvi/xNX/egIeOFMNb?=
 =?us-ascii?Q?bgCVbNzTUe/coihDrrzTGdrLYT7hInqXov+2bjIumXn2KdWH/qPuO2RWIutl?=
 =?us-ascii?Q?UmvUjCrD6DdJ3R2RJHJnkUSq6Z1GyktSD789GAXj32Y5ZWeZWx1pGSpuOcQX?=
 =?us-ascii?Q?EE93DQVbbea5rFAw3EKQ1znFkDMruIf18GXC4OQnR2TZFBpxcbMHJaxdMJ17?=
 =?us-ascii?Q?qULSiw4EsIVKWSG6GljcaTVgi++0A/M8PzQShBetsMWkQqXU8cT+8+42HKjq?=
 =?us-ascii?Q?Btu4UYQ7acbuCfpEH8trlsjd85BAhSxHU5N0vfFjEkOCCkToZA6AAyovdpbx?=
 =?us-ascii?Q?np30MxOxjBLO9X3K4R2vQYA8dXQrTGmDRmm6xcrnKaSRAgUQTlyYsJW0thag?=
 =?us-ascii?Q?ynj3H9iKq6QSENyKeLMRCHX2xSLLYTmJ/Yont6EMh+S1XGBgQ3zQlrz5Tz7+?=
 =?us-ascii?Q?pN2/bk8gVxPJE4HVXi9LFIG8nt+oqDCAIycrdhHcecdcxmJ/8phN7NHZQtWZ?=
 =?us-ascii?Q?2NrtNE6AEeYa4u+0agR1PMWIS8+yyOkdGx9GDPILd/UTDz3t1Vto5QrD4LuF?=
 =?us-ascii?Q?k757Pke3oMKtziRWpYZxeSR7WHKDGUWiPYlYBasKTMImRlgjQ0MoJqrLaffO?=
 =?us-ascii?Q?H6VY8IrM5sofQkcarvotUCTLXasFM2DgkhO1y9EfYeNkZj4eg9M0HEvld3xH?=
 =?us-ascii?Q?7FFvMs++vleFAtaQopDhlQwHU/Kx0eWefrdVaB8WNtmKQR0P9qSeicjlh5V0?=
 =?us-ascii?Q?so+f0caNQH2aKuVAimZDz9D7bKQSzSRINuxICrSPmAlY+EbSoAk8nnyxsUQt?=
 =?us-ascii?Q?EM2aZEFXU4MfekS/hcZhZAESBV3exWQV5dd8ilI9NBtxGTU39G37xuR17J+V?=
 =?us-ascii?Q?OOCbCMAnG5qVvjEoJs/0f+3gJLXWJg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y2GlWTNFer99CWjmeb5vvSnHWjsT8m4G0knhwomzoPmDyihCUNgfrUaVr7US?=
 =?us-ascii?Q?6QbCvYwFSHS6Mrk/FTqusnlYSc3eCaarWIQhLeSNEbAbq+6qT7VYQbwBUNhL?=
 =?us-ascii?Q?nDcfMV7k0FJShtpjCfbdPrfDFaWtPTXz8Yb2NJsHvLrc1aW9fzdWBuSSadn2?=
 =?us-ascii?Q?cfFSdM3DZK/FIhTmo1ZWJNr63NvZueC/kZgXfBbsyj22VC24gcO5TyhApS1e?=
 =?us-ascii?Q?g4tXm42n3H+6yMr55nTp7+wOnGGyurel8cNoVlOGP31UzQzNVkcjbE0Z+0YF?=
 =?us-ascii?Q?vriVzxk7AGUhbmDSTQJkaYEw74UNueC8mMktEbtwNk3YD5F9XQV5LjFfRHC9?=
 =?us-ascii?Q?0Va2OutLf4r/5LKoggbm8F4QSLc674Af5AhzPsZ+ZVW15RnsMcFdYPExFS/H?=
 =?us-ascii?Q?7S2ubmeOVG9ME0+UYpvXF2YLKYleKPq3llc05DDnb4aDA6bjvhMlO9Lt8rlw?=
 =?us-ascii?Q?hfrliCIhgxTFk+kn7TxMY90FLC/PYSa0fZ19jeqlqOVoyULKHxDLP3S0ABMZ?=
 =?us-ascii?Q?YoECKBj8NdEOFFHouzsC9rCZsCcUMOmLFE4eAtt95iEk4GQ9NXgymnoG7Pap?=
 =?us-ascii?Q?Vr41iUfdy+OxyFSmgWi+8d9cPle6HNPXDTU9n3n625U5fQ7UwxYfI4DJbOhy?=
 =?us-ascii?Q?1aCDc/4kjCgmIsbOyyghXHXtpJyPgm8unEUO1taVkZoyzivD0tfmJQxlBAdD?=
 =?us-ascii?Q?3YuFg9nBgeaRfnO8R/6Dlp7/6BDpXxTc7gXgROFpGon1/3lIdBDUyz4RnyJ/?=
 =?us-ascii?Q?PPfxBNCrXf55TcK6d+0tYN6DV9gspiuMB6y1XafRFV1/q7D+qF5tOHaeMLWE?=
 =?us-ascii?Q?qKYLMwK5esy2lM2MMaFtXNBFoXwtP6+NRDM+BT8BZPCh1JD2VqnmerdPIenO?=
 =?us-ascii?Q?fuDRP4pjg4sfnZSqFWXiA6mhJXogs0UWSPLqFtCLvXGrFt1MKlodB0l1Uz+1?=
 =?us-ascii?Q?Lgy3uFbvIaBROogKmA9F5w2OI6zHKJ3c8AP4Z+J7LhhnLCE6BHqZcvpyr19i?=
 =?us-ascii?Q?eavNj1OuAsxLIDarmzKYF79E8I853bYadrgYRr+tpNfNgciWsVSuMNGRJ5Zk?=
 =?us-ascii?Q?87cbs1ML/4f28NS8lRV5+MkQ6ku+GuhFT64rV68BgdDNOO8HWciuD5bOVl+x?=
 =?us-ascii?Q?ZOLqxVil0i4L8ffJfEoLldd9idthEksAzsdrkWOps2e/E3t5ZQXScCUspQJs?=
 =?us-ascii?Q?RXcq6/FVfB6XH9ER08x6+0K/fV029DmBtDv2MurFxFGvS4Np3Lf/uZ0FHOsL?=
 =?us-ascii?Q?cBZFbkicoVy+LewGxfD/V/r7CNQ9+MISLNZtMlQ1Mb43bMIi/oHqYUtTY9yO?=
 =?us-ascii?Q?YEkkbgxjDEN6OwfB3auphlpjon83BtkRlWBo0Q5Pfp4YU6Ylo9i45bkgZKko?=
 =?us-ascii?Q?c4HcYngKluzkTz5cHV14O8qsV84f?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cffa4de-c8c7-4b3a-637d-08df18baa39e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:03:20.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5711

The ACS control validation used the kernel's full set of ACS control bits,
which allowed users to request ACS features that the device does not
support. Because hardware silently ignores these unsupported bits, users
have no indication that their config_acs= request was partially
ineffective.

Validate the requested ACS control bits against dev->acs_capabilities so
that only device-supported ACS controls are accepted. Mask the capability
with PCI_ACS_BASIC_CTRL_MASK to select only the currently defined ACS
control bits (0-6). Higher bits in the capability structure (e.g. the
egress control vector size in bits 8-15) do not correspond to control bits
in the ACS control register. Warn about any unsupported bits that are
ignored.

__pci_config_acs() is also called from disable_acs_redir_param(), which
passes a hardcoded acs_mask (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC) that
does not need validation. Gate the new check on !acs_mask so it only
fires for the config_acs_param path, which always invokes
__pci_config_acs() with acs_mask == 0 and builds the actual mask from
user input.

Also move the check after the device is matched, since the ctrl bits apply
only to the matched device.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..15a074e95504 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -37,6 +37,10 @@
 #include <linux/suspend.h>
 #include "pci.h"
 
+#define PCI_ACS_BASIC_CTRL_MASK \
+	(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | \
+	 PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)
+
 DEFINE_MUTEX(pci_slot_mutex);
 
 const char *pci_power_names[] = {
@@ -910,6 +914,7 @@ struct pci_acs {
 static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 			     const char *p, const u16 acs_mask, const u16 acs_flags)
 {
+	u16 valid_ctrl = dev->acs_capabilities & PCI_ACS_BASIC_CTRL_MASK;
 	u16 flags = acs_flags;
 	u16 mask = acs_mask;
 	char *delimit;
@@ -955,12 +960,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 			}
 		}
 
-		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
-			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
-			pci_err(dev, "Invalid ACS flags specified\n");
-			return;
-		}
-
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret < 0) {
 			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
@@ -983,6 +982,13 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
+	if (!acs_mask && (mask & ~valid_ctrl)) {
+		pci_warn(dev, "Ignoring unsupported ACS bits: %#06x\n",
+			 mask & ~valid_ctrl);
+		mask &= valid_ctrl;
+		flags &= valid_ctrl;
+	}
+
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
 	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-- 
2.51.0

