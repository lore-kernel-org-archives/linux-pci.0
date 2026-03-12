Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012056.outbound.protection.outlook.com [52.103.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4A28D8DA;
	Thu, 12 Mar 2026 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306422; cv=fail; b=E5D3Ae1HSP2NgOFXnT8ZrqViSZ1PgQ5LqiZzBU+Vn4HWsjH/LwWijnJUXhZ3SkYhdwA56fx26j8Lc0b9eGuE94OzjpsesNgwB/4Jec3WfJneJK57DRZgbTF46lQAxJ1lu3UH9Wf7HybBTGH7uytxzD/4trqbNW6QwD5V31R1NGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306422; c=relaxed/simple;
	bh=Snw/5dDmVtmjgjCqZYVbCWtLDN1vROeWQix5IHwG44A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=erapxOcAVTUgPJWZa4oycHkKjmcDGbBcHBr5E5vnrcskBznmgc/w21rZb8NZr+DbpsrdHe1Pyd9u/kiCx8Xesk3/STXmO7FmYmimQ895ttYQ937Nm5/kopHb8pA8+TotaX2FoXnR2kxoi+TpT7s9AIRYkPjWeSHTonIUkcZqZI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PNYABcdM; arc=fail smtp.client-ip=52.103.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PNYABcdM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au5kRC7CD7TJ8ECRXn0+y1mKFvPw6ybduB9kDS/NGsXrBjTtyEweVVAqVsd5DmV0L77aM4CGaZEbTuwODdgxfL+2tcI7oYPUfXFBsE7NQCx6xrLNMwaZgqPhClDrhfjq73nBCeHvBEziRvX+5r4Y4g/2WtZzAQ4P8T+qovjR6uYex26HlAtGwqzRfTDH1MDquqS7SgkZfwQ3RAat/HnQ+AVP0gavC55CVrzwxmMWsoBa/XXXqWltaCwy1/s+jZwac8Iag81td3+UM0SsPLMj9huRn/MOsnPu2u2Xp+nbDYP2MnXSzQoqSVlwfLepemSCWC80uQya6OlpDHpapV3w1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaNo1hpFMEV2z4FfnTowlHDgV6dAJ/NfBRqYQoqejmU=;
 b=El4Exx7eX1+JjgnuZinRVQNQcxrJwAdo8TT3cqyl1HvGMrdD9U1Mk08q9F3cpTa2Hq+vRP0YQzcoCB8LzSqW+nyHb64U380yDeeZhux9We9vWlm51893CYmBeNSfCp664yY4SqxInz/v6h5nbkxZsAAVL9LUy9UfQxudUahj1gLLip/osLrmnFCFLUDxBFHRPaRi3MEPHqr7zxhiWD3hPPRAs448NSX99mkZX5CEDmmusGVX21ig+4k/JTg6tiqHe0ECQlvB/vUFYgQ9RyBzovxfhZ4IX0QSnnpEjCdKsWUHhrfB56p8ynYVHQnGGZ+jXuy7Muc6GGfqNJhYuHhRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaNo1hpFMEV2z4FfnTowlHDgV6dAJ/NfBRqYQoqejmU=;
 b=PNYABcdMRXHfLoxA/ow/jy01Eh13l29HSglQurXY7s8+gj3TcKnZ7IyvVSK2wn4sD+GhpbFKiLyhRgoscqwvnXSOsKZbPcRsexTK4FLmUS6Jj2rfXiekQBR326wSgrq5bMtR2lM38N5wGCc3E+zcm1QW8yt2Hd7SjotNDo2qF2KiuP8EAULcwk0sg89PrJQbrnrO5SH5zG+WOnObNQSBXs5SWRif5pgqigbNrElPh5G1ZlGh52lvtf3j5sy2TYPWFDP4dO9odglSiDwoLs/bRoTh4Y99LecOin5d7nc8jQbJlE51URiVzzTKdAKV1Cqk02LYN+ndZZxerpxt4SJ/IQ==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by KL1PR01MB4704.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:06:51 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:06:52 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v6 1/6] PCI: Validate ACS enable flags against device-specific ACS capabilities
Date: Thu, 12 Mar 2026 17:06:32 +0800
Message-ID:
 <SEZPR01MB43991B1D3735DAFEB73DA37DDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::15) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20260312090637.71548-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|KL1PR01MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a06006-7b8f-49c7-b655-08de8016b2df
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|5072599009|12121999013|51005399006|15080799012|19110799012|23021999003|8060799015|461199028|41001999006|37102599003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4AsrgPl4H9VYIOMj3sRaW7FQx3vG/SvR+A7yJPMyO2zCZqtfq0p6B0wrq/C6?=
 =?us-ascii?Q?YjcSZJ3sBa4PsSC7tT+P7M3ADAmWEDBJbMqE3VO60BnKJVHV1fAEF36NFcLh?=
 =?us-ascii?Q?7V+UVS7JibctD77T72ihuIF/9iw1zhEJ4Ozscd0Z6LKoq1Jtd75sZ85KN/oB?=
 =?us-ascii?Q?K2ZI6lhMkEmQzVjtG6GGw8NT+UdZnwoF2Db5wtE/jjOPzLuAQhjls6DzAtUt?=
 =?us-ascii?Q?ft2n5XUUribDBgR2FGlRShjMQBEP6+fZu6nFf/ZDB65d47MnT6ibDp4aPHeN?=
 =?us-ascii?Q?emtpm0xISf9Zo9zlAAz4Em6h8dpMSdb2nKdw/0zewIQmA8LXm8uUPV4Fmesm?=
 =?us-ascii?Q?hLw5Dh1i72ckcGpjEb6bfsTRbdrmAADw7Exa6ahyADu38BdsvOrhlxdwJAQ6?=
 =?us-ascii?Q?YA7uPQ7KZ6g1qFE/bKy4RxMGqZv6SKfq7LJhs28ELaPfhkelNkmhyf3Gd/U1?=
 =?us-ascii?Q?y4uxNShaozJ/ELoS22BT52LEubvydvW0uYVomttYcjMpMHOu0VPAn/N3Hfoe?=
 =?us-ascii?Q?5XOTvQOAOjigRETXocS3LdunK0HdAZ2Oz83CbIoux3pd2RwZOnq60fBtjToZ?=
 =?us-ascii?Q?6qEOyn9A9bA8gxpBKWXWVt2kSuxaQNBkMfrzYCe4F3XLm8pxjfVuPqOw1ysW?=
 =?us-ascii?Q?ARYkNFMlGLy4rSZp6zGs6cDvLwfz0k84QtgbbZiFboq657Uh0uIDkqhQkhNc?=
 =?us-ascii?Q?QiJPGZY3cXWtTlhKuWlsQgi7IlNq/e/vyOJI8D6weeXHlUjv2I5EV2JzRO4J?=
 =?us-ascii?Q?n0/4RqPDRAaUCQSd1BT4lh0JzeuOmhZGyKHcH7veqbaM9hO+FXqzn3nSBGOC?=
 =?us-ascii?Q?+P79xVV7pOeCMpXyYnoh8NbEYAGjH2Jm+XYFfa327Jqe2ZvTWrjZ0d3Rs9kt?=
 =?us-ascii?Q?+d4L67MryJg8Qz5GDCPa3VZKbZmeH+Ze8JkpPTpKqsR0DwSHtLvmFYLrjst8?=
 =?us-ascii?Q?99hau6YfcXy1y3Sz8fWkH01Hff29zJSzxh0MWj5BcbaNFUUTBf0EJjOMGygC?=
 =?us-ascii?Q?cmMD6PW5jZFSOaAlHp+c2V+lfWpCpdVLC4vwN3Lf5m6WOzjEGJWG33KNDZdn?=
 =?us-ascii?Q?BovdCTtA?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I/6zk2svQHUx+MAqflUXfJatM9TPWeI1L75iIIWPkyijyWwtDm+TWGMuJPUg?=
 =?us-ascii?Q?TQBCa5/yBw9MgQsKCFHFHdEN9f3NirgBRIiVM+D37I3RyDq7goh5amRod4X5?=
 =?us-ascii?Q?hLLbNW+HNRfE0I6JKTIg9t+aIdoujQdjp2RSPtLdb38ScdnlfUQqKVmj0AyP?=
 =?us-ascii?Q?EXTzzb/ZfdGk7icLKN22TqXr1kbkm+VK7JvzcpZX5VQqYVJd8+XDgSQr7WOf?=
 =?us-ascii?Q?cGmvxRdBJFG5E+kkNmhpdrC0WyAOjWF9wE0M1ILwlqwF8tleH87gSHgl7y15?=
 =?us-ascii?Q?Vr137SpP6fmhEZpTNF8iHR8lYr1+JWmLQ7Uj+Vx9Jo9Ec8uUCBoCiaxFHYA9?=
 =?us-ascii?Q?6rIRK16nMh+3VyYiUQ8jEpFjMQuWDgY8DjsryTLlo0jLxcDdCkVqhwxj3l27?=
 =?us-ascii?Q?15SFI88vdlzrvMUQvDSKlSUVHhd+xUjbM5FGnyrZDYXFb3nqhjzsvkQGy5pv?=
 =?us-ascii?Q?X4UpOEq7Ez13SWEC4i2I2c6+dpjmHKQXOZqBW8/5NgLMIloDPryq/DW+8AKf?=
 =?us-ascii?Q?Lc4oYcvV63lAp/NOJTdUXgEJzCF73r6e/kvknUxWdvR/17DEDD3tMi8F5yV3?=
 =?us-ascii?Q?UHrx0mthMsUv1lFKjqaOi3VrkD4+pxcAaJthS6GKlNzl6XsDD6KcSgq1mlNt?=
 =?us-ascii?Q?EINgawXKElrB/I9iBV9Gc1gxGTogFT+1YCuso33bewIMenAtIZ0QNfcR3qH5?=
 =?us-ascii?Q?ZA5CBvQPjavbHztQJVjvpJZCjV8KQU7/Kw2D49hGBsd7aEh93+tWWQMhjSMf?=
 =?us-ascii?Q?YSjJkOyS+xEjNPaFIqCpWbnh/C2V07zpwZuNx/0KYw+8I8rhvZ2bSaTxQhLo?=
 =?us-ascii?Q?lnJCLv1BHQBFX1IE2/uSREaz2bjnQ2FfFUC8yUlH5Qs/Rq75tBlMr8Hwd8ox?=
 =?us-ascii?Q?WfOyrnhUTdfuwGljczlARtr4DhCxoBXScYqBvPNp04GwSGYQyse9uiHjY30H?=
 =?us-ascii?Q?K/TJx7Ww5U2V6pikE3J1NOVVjq5jQ+t21UUMBv2TRPH/ENNMg6sejqggO67t?=
 =?us-ascii?Q?GVldpMIcDN3Fo8pmYwZIzDQ+7ibfl0TA02LoEKKelpx47ALGNX2TIs0Wp49a?=
 =?us-ascii?Q?6J5sjoTup81vBWWR3g8h+uIXyrg7gQjrRGOnl0FZYU+4mR6HUE7l9hsc6k6j?=
 =?us-ascii?Q?270pQxugSjqXW7wieveBa4ZGsZIa/7yE1/f54CCqz3W3lbcjSX6dUazt9mVV?=
 =?us-ascii?Q?tkD28VJdoN+/FvucdPKst52noZbeqW+4mR08/C+OuIG23mrCgtVv36Bwp/sT?=
 =?us-ascii?Q?4RLlbQx8l/TUmRQoSJhL32rEM6Rph78pO+JSWJKce97GWrGcu29A7Cu0e6SD?=
 =?us-ascii?Q?+kQj9Dwahet/PMkLt/w4d8RaHcaz7blY5vtAolIel/X/+1wTlbrtKEvRm1Zl?=
 =?us-ascii?Q?FWTQIwTxofPZxwuwrBrvAOS/0XS6?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a06006-7b8f-49c7-b655-08de8016b2df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:06:51.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4704

The ACS flag validation used the kernel's full set of ACS control bits,
which allowed users to request ACS features that the device does not
support. These unsupported bits would be silently ignored by hardware.
Validate the requested enable flags against dev->acs_capabilities so
that only device-supported ACS bits are accepted. Accordingly, move the
check after the device is matched, since the enable bits apply only to
the matched device.

Also change the validation to apply only to bits being enabled, since
attempting to disable unsupported features does not cause functional
issues.

Finally, improve the error message to report which invalid bits were
requested.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 115e5c11bab3..9b626e67d988 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -941,12 +941,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
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
 			pr_info_once("PCI: Can't parse ACS command line parameter\n");
@@ -969,6 +963,12 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
+	if (flags & ~dev->acs_capabilities) {
+		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
+			(u16)(flags & ~dev->acs_capabilities));
+		return;
+	}
+
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
 	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-- 
2.51.0

