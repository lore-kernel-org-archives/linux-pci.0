Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013072.outbound.protection.outlook.com [52.103.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443703AC0C6;
	Thu, 12 Mar 2026 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306427; cv=fail; b=oJosIVjzSk14YiTtgTfq8NJO0bnrsaa3d+KsXTr96XdaR3AooCGmput7BwzMHWZm1XLAg+i4W5sGTZzEveu9bs7+Kada/ZvuCuq3zwFkYdOMRKgr1keTLODUZBXbkh3IJQg/43sdM+jvHUzC7me82rVTy3hP74RaZZx/A0wYFtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306427; c=relaxed/simple;
	bh=1r2V2L/EtVZgD1buHoIgKU/kDPoh4fB16fZvK0nth5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKk4pbmUHwGKv45Dk20SRlQH5Vo+SjajDKW+vYXojtznblp5gjBo6QYgbnZLpXQfIVuijNyZXs0fFN63z5gg/hdlE/Q9hjKFlO0seDRyVWYYxrcoXxzWWovnBCxfo9fj1H+knX9X0vIzE0qM3SGt71OqNEUWAoaRZigqIPCNo3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=SRiYh/U7; arc=fail smtp.client-ip=52.103.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="SRiYh/U7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/q0zXGf4PI9Xz0RNlMYuABZ2q0+5yR97RPRY11J/0oMSXyID2/2/Xv6RN60RdSaU7evF/ill+cUekO7jHa44VCmbvZdkLmS0t30dZRq/t6iKrzcJwPPtSXKcecr6ew/mU+MEQnhOAb80nXAR+m7SW9H1QSFQMkCsop76e4GV16xE6uver3SLWT+VbvLmbXzDUNdJbRNXansHYtLIca20OcI0JNo4TgZt3I+tre/pOQOJyQUyeo5Gqpw7fwrc9VDSZmRiKiT/bNUeVq94V86vypRzJila3aeCXj+ZYZV3ywbjg0UbTV7VriArm+CgeSnX4c3vURRaQrqZ7dMID+LmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTF6NuUmCh9BlcsT5bWzHTOpDkJw3P5atCHSwvX3PT8=;
 b=KpwDXXKDMpaGvUHdAAG+6baEfDbK8xd+a104Ahpzj47uS+9xOr9iBFOcYk0hSWfgeHUagMw4AhdYDsMx6FfM8V2W1SFpCH865jqP6+yVrUoQkvPnemXBC+NaLbb4F7zGXGCxMf5tZ9gJWdC6eilZChSjpA7l+1DS1PWEGVEj7cb8R9prc57mW3enBEiWD9rvRbKKEGPSIpPDMcp8DRuvYF33aHqBl3Q122PG/NdbzzoZnDcKXMrMhchKWOfHGbf5EYgvwk5fH7H8a9qHY5VXoFG9hPfFpsdJpNd+3Cr7jMJ/l6VPk3wghTIIsRvqpzu1yvHPARrnqfaOgYekGE7zqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTF6NuUmCh9BlcsT5bWzHTOpDkJw3P5atCHSwvX3PT8=;
 b=SRiYh/U7AbJwTiewRcXhE+K8ghArO38s2nsNZ3sdcSaGc8p07VCsk6/3vOudapuO/DfaHPC3YZ8bXOCrDkkxeJstO9KeZ66qSln5aUdUnMajSxEipD12qqcBek84U0nRZJBq50lLnu62hEOO2CpRsN9jVakAJtdyAW/UOHzECcmFE/KMrivtVbI+B4Of5KhN16ubLyp2Tz9ReUf55NiJfqb0crRTXCQB3iXarO6wG1yb7afEUlhW0pBW4X8RfhtNLxeM6YQcfALj/7mabjhNUSgxcHWsybqRNBrvq8VHmgt1eiAisRLfbM0nfh/WZ+AG0ND5E5MafcuSU3RG+g9M9Q==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by KL1PR01MB4704.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:06:57 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:06:58 +0000
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
Subject: [PATCH v6 3/6] PCI: Consolidate delimiter handling into pci_dev_str_match()
Date: Thu, 12 Mar 2026 17:06:34 +0800
Message-ID:
 <SEZPR01MB4399FA7D597B0A619C6F9A7EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::15) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20260312090637.71548-4-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|KL1PR01MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: d360e551-90f8-4e3b-7371-08de8016b65f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|5072599009|51005399006|15080799012|19110799012|23021999003|8060799015|461199028|41001999006|37102599003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kTWgP/QYd3Km9iv/IPEvaH9Lp82IkhLAkszno4bG2L03+E+ZJnMBu1G+RNfL?=
 =?us-ascii?Q?xwbsATcqbyvoXJ1ij8BTgibg2+c6hB1ZteOHLh2P0A/om64jBTTOA1t7PBwQ?=
 =?us-ascii?Q?g9lZtapXfBoJeH81jZC8teYU+0LuO8tM2k1opqmXd/uYmJ55RaneQ/BlkC/w?=
 =?us-ascii?Q?u3POMcRmR5nliNHfViSbGYVMJ3hDCwLDxn7xagVGWz0QfJch65tqHk2wMU07?=
 =?us-ascii?Q?Mu66k9G2L8snnECXYygP06YNgAFt8VK6Z80lx56qScf4Ignh1KHzyQ05zeKX?=
 =?us-ascii?Q?cniKut4ij1ylaVOtCpW8RT2EPq2hn61JGGgLLkObG8Y1Rz+GQ+j6QYY78goA?=
 =?us-ascii?Q?YdnmpDh6ZH7DCD+PBEF2r9dni5QUSH9w9ikimI0ccZR8flkAhKHhe1E7xhHZ?=
 =?us-ascii?Q?ms/5RirFiv9dKtiSMat/ZyGqjOQSjEmJsjb58VivYA0VDQvgJcS9enFyYlAp?=
 =?us-ascii?Q?0Z1p8eo0nE144niAMPj/k70S2sZTjgvNtgmXwlEz42tyCqjwhDeF/1LaLKml?=
 =?us-ascii?Q?hhugMoje0RsKqZM9EKu7TpUpj1vrXm9UxzK/anVtF/jjVxU0VmLAEfp9C8ae?=
 =?us-ascii?Q?EkgF8dFnqPVugsv99zQVB1w0GOdoPHHHSpWSop3cwJiX6JjoZKc+ff1ef7bH?=
 =?us-ascii?Q?3nC4pfBfZt8JaS2sKGHeTQNFuwvWc0c8H5lU9SSH6D2M91vwKajclMHI9LDg?=
 =?us-ascii?Q?fRadhS6JtF6TpueVnrbd3lKvnw/8FY+gqJPHmNOmezCPfVUoWE3W+PFY1Guh?=
 =?us-ascii?Q?CHW2+LctDWh/8wiI8YCXAIBWysqH6StQb0wDUrLVf/NZNyBq2WYEVH79Apa+?=
 =?us-ascii?Q?OTVyZkmbJG6rlzhXTGawjLGnmKkLd/Fs6YZGzsL+pyccpTaAMvxST74bijso?=
 =?us-ascii?Q?8N1XkUtKjlvx/l1ERAaJ7GnqCKq5V/AywdIR+Znl/u9QmMzPlGnYaqJyTraj?=
 =?us-ascii?Q?ijJsO0dUGv5fkZoKdeLJYcBFkgFeTSIccBV31ia57qj7SdHMQo6m0gVaGQ+w?=
 =?us-ascii?Q?8d9JZb6DGro45eM0O3eJI86bgA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0SGk1qvksbaNYChjBwokllygaYboXxbajpztR+I6KoSSbmMpBPy6E7fLdtbd?=
 =?us-ascii?Q?Z674nFTdXBzrHTXgSx/JM2tUgi2n4Zk7Oo3jNMY+Xd2ohVQMh5E0HaidhHxy?=
 =?us-ascii?Q?Tgaw6UbW2OwM8EuYqGirzVeAOdUjVYUKia/fV299mfCTx31QQETTUlQgax0N?=
 =?us-ascii?Q?Fk+L4+Yrkg4YRihr5dI+Loa/HcpFc9Xd9xFH063wFm/AU0C0Sj/+U/Wo89vb?=
 =?us-ascii?Q?/1dfymRDG6kp+Et7gP7uweUZ3qwG+zGbG55r3Twz3Rlq9c0pwc1tGU5xNQJR?=
 =?us-ascii?Q?bc90EVBR52tqDrPCBM6n7c3mEla0u7r5WRqWgHUZXbfl9caBTCGNC5jsBvfT?=
 =?us-ascii?Q?JyHKGpVk+kF633uwkkSuJx3Vf2ClIZuZfefVI/pADs1hqWBwACxlT3JED4NL?=
 =?us-ascii?Q?5FvT9d+5D5E6DxU71VJTUqH+bqW3TP44zWOCMRsDN/rVdloIBbBUu4WPQ3ts?=
 =?us-ascii?Q?oZzJquUJbprgP1+OS+h6CeUbCYjZo/xUrxWAk5InWUw16AkwVJTIVoMHPElP?=
 =?us-ascii?Q?ggGmI9HXyAAC8vpG8I8mkO3X636QzOXRpAeo+DwNnd/4WD4BH2H1mmPjno2M?=
 =?us-ascii?Q?Dr1ULcHXhr31LUJAD8zE6nEKjfMhMA/7G9MuvSQZGGrDTuPqdGfa1ILi59jR?=
 =?us-ascii?Q?rD0xFMZpuYahoe7DtOug/HPuYGXNNWiCdabjoWjDZCMJLrQn0m576kDd6cfH?=
 =?us-ascii?Q?WYNOqu59RI/zV6zzTwvdwOYfyePKrpq1ZPBSG9eWNwiPCxCEFjQ0H2EREi8p?=
 =?us-ascii?Q?EKCTxLXkVcL5DscL33+54wTYLD9N27Gyu8xqx32pnkxD3o5lk4xXg8UL+anX?=
 =?us-ascii?Q?IJKXC1ZA7C/e6VsQ8AcBaEkbbH6n5OWhNh96POAjzBsya38wtijd0G1Y+u+q?=
 =?us-ascii?Q?R8YXDN46oUOgz+yO00IjnEtGu7cQ5XBI98ilrNmzJZmWhk1OTwriofA2fz0i?=
 =?us-ascii?Q?r6/obM/XZBAJ3gmNoIzRzOoyHEmvAMnJKkgucnwbvxYmVWgbMM5D0v9ioiM7?=
 =?us-ascii?Q?pV7cObSeexAE0RPcdS8f5mGnxyMoDN+ii/KFDc2ui1CxUp4f1jbm4cNGnkdJ?=
 =?us-ascii?Q?sZZTFKu0FsVyP7/W9pP0w7V1KJM25nLwcsyiUCPO2uyIPNQysmaFjAYBNGjg?=
 =?us-ascii?Q?RexCOmdEj0w5Z3eVEFCt5+4usJDdkc3I57Q+/qNksRkK2Mp0O0IX2N+wBlRF?=
 =?us-ascii?Q?pIjXEknX6dVe8uiRCZ6XxmscTOAJYZa1ejST36PdGsevvIFy35wKJjF17CWZ?=
 =?us-ascii?Q?PX8UwetrYO1g9ANuo0yI+tcAAClfvwNgvVax9nhJ72XRjO5+9c6a+FgcTSE+?=
 =?us-ascii?Q?exZxeU4ZdJ8W3tK2lsjOokzT8oMELPUUlD2OC5kCeomtIp4E/4sWI1sZAo7b?=
 =?us-ascii?Q?QPcSn4grHezfEr2gg8JuH+ueN5zx?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d360e551-90f8-4e3b-7371-08de8016b65f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:06:57.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4704

Callers of pci_dev_str_match() manually checked for the ';' or ','
delimiter and advanced the parameter pointer past it. Move this common
logic into pci_dev_str_match() so callers no longer need to duplicate it.

When no delimiter is found (end of parameter list or malformed entry),
pci_dev_str_match() now returns -ENODEV to indicate that no further entries
can be parsed, preserving the previous caller behavior of stopping parsing.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9b626e67d988..4d0fb70c4bed 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -344,7 +344,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * pci_dev_str_match - test if a string matches a device
  * @dev: the PCI device to test
  * @p: string to match the device against
- * @endptr: pointer to the string after the match
+ * @endptr: pointer to the string after the match, with the delimiter skipped
  *
  * Test if a string (typically from a kernel parameter) matches a specified
  * PCI device. The string may be of one of the following formats:
@@ -384,8 +384,10 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 			     &subsystem_vendor, &subsystem_device, &count);
 		if (ret != 4) {
 			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
-			if (ret != 2)
-				return -EINVAL;
+			if (ret != 2) {
+				ret = -EINVAL;
+				goto not_found;
+			}
 
 			subsystem_vendor = 0;
 			subsystem_device = 0;
@@ -400,6 +402,9 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		    (!subsystem_device ||
 			    subsystem_device == dev->subsystem_device))
 			goto found;
+
+		/* No matching string found */
+		ret = 0;
 	} else {
 		/*
 		 * PCI Bus, Device, Function IDs are specified
@@ -407,16 +412,28 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		 */
 		ret = pci_dev_str_match_path(dev, p, &p);
 		if (ret < 0)
-			return ret;
+			goto not_found;
 		else if (ret)
 			goto found;
 	}
 
-	*endptr = p;
-	return 0;
+not_found:
+	if (ret < 0)
+		pr_err("PCI: Can't parse parameter: %s\n", p);
+
+	if (*p != ';' && *p != ',') {
+		/*
+		 * End of param or invalid format. Return -ENODEV so the caller
+		 * stops parsing.
+		 */
+		return -ENODEV;
+	}
+
+	*endptr = p + 1;
+	return ret;
 
 found:
-	*endptr = p;
+	*endptr = *p == '\0' ? p : p + 1;
 	return 1;
 }
 
@@ -943,18 +960,11 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret < 0) {
-			pr_info_once("PCI: Can't parse ACS command line parameter\n");
 			break;
 		} else if (ret == 1) {
 			/* Found a match */
 			break;
 		}
-
-		if (*p != ';' && *p != ',') {
-			/* End of param or invalid format */
-			break;
-		}
-		p++;
 	}
 
 	if (ret != 1)
@@ -6392,16 +6402,8 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 			align = 1ULL << align_order;
 			break;
 		} else if (ret < 0) {
-			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
-			       p);
 			break;
 		}
-
-		if (*p != ';' && *p != ',') {
-			/* End of param or invalid format */
-			break;
-		}
-		p++;
 	}
 out:
 	spin_unlock(&resource_alignment_lock);
-- 
2.51.0

