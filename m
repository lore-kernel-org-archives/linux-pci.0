Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013078.outbound.protection.outlook.com [52.103.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBB55C327;
	Tue, 22 Sep 2026 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089419; cv=fail; b=BdoDY13AsYREdSt0QqxkygUgf5BjnyzbV+nToJ4nir0ErEhsN7poDeHZ5T33Ti6By5RVdVit+/X1DoA9icAkPNihaHnrIKX7pmF2OBW38sDtw+t2DRN87ifp2R5yfconqBnAE3GLJ/WT/q1jMyL9hAwxM6XeIp0Al1oHSh0zsdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089419; c=relaxed/simple;
	bh=1d2XAwiT3D97ELKfl8emDyMpeRvx8DilFPhVICz+pKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUg5PIqduRqlQdHuzeeUa+0I8dlQZv46wRIMaUPXmy2qfjGx96ypgGqNljhGBGbrJbf0uUo7IHRHtCmjvLy8b5jcOniEmR0R/GJNOXUenIN6uLulzofEafGUnM3mrwt56R17VCqGo4W8gZX6qzqjg1z37l3XSPuE133KL9fQapw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=FypAavMr; arc=fail smtp.client-ip=52.103.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FypAavMr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6hppRtYTwYXfcz0W1db8bP3ijoqg7XwHygJ20iL/ggBaZMnJkXujW5H0A7X2ds7IHbLuZCwYDqb3cSseRohKlTOE4yZ0rjrCAXPRe1EJshKYapoAB2ilbBx8zC3flehIrSCtFLv68BTf1zaDTPs3raf6gWG9EqcFCk77NG+bVBsVQeTfYxdv1dAF5yxFtyr+BP+LpOSLmIJibvgtaEUsp1YMKMHA6e6ApJVfzt/pf/+XLC5UgRgKOQdd1x8pgDYn+gOggf+YgqUCREuMzkQ8LjcjrYiO3ZPEB+xJOp8zcIoNmJcCVwN8xZuEBKyUIx+xSH8YX4SWi8hFxesYrMsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEmDUUhpFbB2Jh+Gjq7Fnj25UoRVQbZ64yGRvp1LYyQ=;
 b=FQVx60bLS9Z2rw7hlJ6Ces6kdUOnlhMYODwVqJqWlMhiFmJX7zXKRy11vXbMNc08MZZjJA3SdfNYK24SQnU7eQZHi93YMIjXvk3ITh2aQmhIxKWRyuy/JmRb3ot/Xrjmd99w+xE9TCF5t6AswvzV8ZP4qh/p8YEPvfl3rI2H/CISSQ1A1aXzye4AAvE1cjBFN2tzyxYSrlK5xK8avCHh7DbZs14avOqF2ojGvR0Z5jYHTNfSOG8qT03jikrFYKET611P0dV1XjpB3Z5DMdr5R3AUvB47N4Oj0/IEDoZV9buyUBNxQWJ1YZixVnrZugeG+8G2f9Vzq1H1C6rGZln3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEmDUUhpFbB2Jh+Gjq7Fnj25UoRVQbZ64yGRvp1LYyQ=;
 b=FypAavMr9vfgdWwH5vhf50lefxOPv7bMs1tPFUsSwI2q3PKEgbgjN44V9qT2Mi9Hq5Vb2Phlu88vgu/MhOEi12cB0HXL30M3zId/+nb7/3qrg/mzyqX+vY37Te+VJAQosV9Lhb27c3DDgKVw5fcTL9zarDIX5IKH4sjuPkpNfH+Ck1J+dKDPeY8JijLK/AZfKRxZgs08f9uffmUIPCPp5/9t5sNid9nduwixC504sMu9IPAn8Mt6FP7breP480nGa7kdhk51DD52SK1Nsne3Ezd3NVKYRW5zxVWBCOgakH1cKk9IMEjKDpufcrhPtgg7w9moYqXioNbi9fXTCnRYUg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5711.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:03:30 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:03:30 +0000
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
Subject: [PATCH v10 3/6] PCI: Consolidate delimiter handling into pci_dev_str_match()
Date: Tue, 22 Sep 2026 23:02:55 +0800
Message-ID:
 <SI2PR01MB4393A855D592C1F484DEF778DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::18) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260922150258.3087572-4-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 652fcd89-b3ee-42e7-bd03-08df18baa97a
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7KzveHkiJGDrWA+n9f+GIBGCYiq58tArSQty5RwfvxJDc+hg9PdS755u7puAacHxAhLyK1+0aPU6hFNLtwk3Qwzqo1gwgzaoJbZfGfrofiL5OBCh72qX9XCfbdz4JGZxhWdYehdCx9wWa4kX9HJ4PCPeLyGSyWTZHAKTZf1b5VX9pwU3deblKn5rXmtG1dt3H1kri3oOZ2FJoG9OrlxukuZKXft6Rig2iaxGRquBRQjJLBHul9+8MoUz8Qwg424B3iYrSC1QCOjf1caYaNt/AaBlMMeLFdOlArNqY688ZyEWU/lDvAzA9CHyoIvzzwo6Q7j9zMs+yBCYs7jUgS7XavwPBQtIRxHXpH2UtGrLOmo7UsyMHUNn/dZZGx6aVC03rNdImNQAwMdWELbFirdxxV1MQ7251DossAOWzXkmOKObGV3ToVb1p6Vl6Y6EnZekkr5Nj2kY0SAIQJHkaK17TzxJ4nQF8WdYUMdKT6eXNVuhg9ROyVm1MoaI08+pZU44WgevThTXM8UwtyZrTKqRGqtyIpcGi7zxCvUxOZlA6QYmk4CHSPUG1v1ZuGT67N/qC6OCiBTI5KiLkUAIVM4y+v5lkv9gN9gD79pUlxsw2dUoz2Qst9ICyq2MCeOk0BkcLaUuqd1VFNDrO02IdwXDXwk89iofInJvlUvfd5TC6toLx1SrvpFCUS6YToDPuSx+4zksvKXdfqkeld3/irQ4zhWYOcaC+ap8+6/0uYaEUY1U=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|19110799012|8060799015|5072599009|41001999006|51005399006|7042599007|37011999003|15080799012|25010399006|23021999003|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQcjYDCCgbJ65ca+braLIsEpcLvc/NtgEEtpiKUmecrLcdlxvcDLaKcaZzs3?=
 =?us-ascii?Q?tVPQWKlqCiVwGWwei00QaZcbPbeASPk0axEiJJ/Qa88FQeALXcLoTzasy8+k?=
 =?us-ascii?Q?oPjecaI9LgnrYhE6QnCbXbXDPMHDb1IYMt7vEgadbJIQDBkiBdEVxY9x4Y+s?=
 =?us-ascii?Q?cqcM4FU81kPrcIf9S879nKh6B6BtaqEQXMGCjV7bqTggAyy+uzRANaJoqSLT?=
 =?us-ascii?Q?9Z7s4fizLP5nyJVBX/yLIk0nlltP+px5zzmY1OlewqCOk2lNUxYr1+SOyUHO?=
 =?us-ascii?Q?s1eMzSY3d6GpJXnWU30FAW3sQq7zPIHIMG79EkJH2T7SeA6R80OTivSNNwiO?=
 =?us-ascii?Q?fv9O5DE53ZlNSuKsSIcYWQXBfT9wLt4XhhwujGOm/dL6cqjXGfBpuxysYRnP?=
 =?us-ascii?Q?ZZYjjrrq2CkGCMV4oDnvH6qcaSzmYJrw0F4Uoklwmk458uth1hSZSRBla9qb?=
 =?us-ascii?Q?N+VTjsMYPzbpCPdKVsLA8UbDoLDYWZYHVQaCk96uAe4iFxvmRiBKsUdivrJL?=
 =?us-ascii?Q?VUVmf5Jl2HHEUl5QiOxtvnk4CshsXlJZMuSE80pW7XuxMgZstUHzn0G0dmmg?=
 =?us-ascii?Q?RRXqBTQePdipo9840KN74UM5jc4fGhj6JF7gbd4bagASAnACFBcwfEugbdIt?=
 =?us-ascii?Q?xYzwOfWEne6KSsivhPTITGNzzs8RrHSOCdJYvOVpL9YXJYF0FeqBL8JUccND?=
 =?us-ascii?Q?fFkJma6e/jKp2CWQe64NLtFE/6LgM86bJjplOBM3tk8Y2y0AhhK1TfP20hmI?=
 =?us-ascii?Q?v0MecQKUPPoRSdVymS6op5lQZ8DXBLpIVw1HkYJlJRqWkrYN6TMYMHPGhmNH?=
 =?us-ascii?Q?A26ZdtnEdsqu0pjON87Nzfo2W7vu7LwHVWzThOx8AxVBXlcd3bj6xuzurcdm?=
 =?us-ascii?Q?8Swqi+IheTNp+Vf4oP3RPM6CHRA76Ch+MGkh3TKpF0Z+jNLm9RceHAYSWthY?=
 =?us-ascii?Q?5R8fxMnhGEuGywuPewJXtF7U3omWqRh41HO3o1HOjTR1s8lNKln13ZueYReO?=
 =?us-ascii?Q?E7ukkf1A3lIMEJkwuHpmuGNPq3M0KXQRxJJB+MnbaqbAxpuxHVO3eYJvIIcH?=
 =?us-ascii?Q?Tvd2nWmo?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JMxEYoSV5inBFxkfoWyhPFrPGTF0pYKucEVKwY9mRhAiixUiurm5cncohdkX?=
 =?us-ascii?Q?BCLUAJKiRw/Twe7uHTqp0XnGwn+P9uwI6e5ZSIbip1R/clFrcc+3bSztd1/9?=
 =?us-ascii?Q?StqL+d1GIUqrnD86XJLDDS3uzkJRXjLYqjJW/9IDFfEeJAmJTbFN8pzKlQNq?=
 =?us-ascii?Q?ClREF9/K1PXSGMvEL9MeT3VLGzBvkh+ZZz42HlP+4oYwVZIwKr1vywTRzrPD?=
 =?us-ascii?Q?vcTp/rqwyu0kUMArbtMlCboh/EzRtIaDA5rsrM4l7I+zRg3XjcGz6xWe9qxa?=
 =?us-ascii?Q?LfvlDCttP789Bh1qQQl8/fjunLdImFeH9dLrQPLiQ5eCE9HiBtwcuyuxJebR?=
 =?us-ascii?Q?HyaqEw4LYOy/Sshjli1efnt3rC0YYfBuavWdjglx/76bmw8+R6BToVSSLnMh?=
 =?us-ascii?Q?jJ5nIdO48hu4iWmNRpWYmL+/giD7DyaIJVWkqFlWlaXccf1KSVLwYQLY9x6w?=
 =?us-ascii?Q?RzpcM+36VG9c9bf3zCQNkVJ+OSReNMlzioIDZOgNRPaxVJqaG3R+A6xqjb1x?=
 =?us-ascii?Q?z8ylqe6ggXcTxfz5a6pkuIQQLZUJppWoP9DrQsf27HgFj5eopcFoQZZdPpKa?=
 =?us-ascii?Q?v9oV+Gc+SnXRUztPaFKEW4sJMFeptTDdo1LobIQ5TxAplp0JX9yjiWhL74ys?=
 =?us-ascii?Q?gHWW7/xyRCvDyY12gkPF4qf//sdSIgrtGkUMKRbkgADHIunSCq8+KpmQQyja?=
 =?us-ascii?Q?uak6UX4gy4ze4Oh0ImRscM6e/HS2Ye2gKj3PGA6G15yX0p4xBXsa8DNpIPur?=
 =?us-ascii?Q?b5hqN3TV9/LS5TWzP1y0u5hv8SXu3tohovG3VwruRxgBqBxzvjCOCadsT2/V?=
 =?us-ascii?Q?H0ock1HgLF+rweHP2vjhDRZKPEeTqLWPVrhxgZIY+spfSLTCxiqS3m1qFUN3?=
 =?us-ascii?Q?VY6XmVz8EqF1z0I3GNDR9uWkw0yKDG+F9WJGhmNahhX+qQPPaVPoStztT/vz?=
 =?us-ascii?Q?KiUpaqkOP6CpNyEDr5DVrnd+mWLfAv6Az7/HPw/4rwBhXeGzJvGrcK/6UsLq?=
 =?us-ascii?Q?oubOi8Azq6E2RC4qs0pm3Qd3JDnRhzkWQwpa+vVshsFMGdV0sMfVkIpUGpxf?=
 =?us-ascii?Q?+PXkIcBqVzaNAps0NpPW8vJD3I+wnGkPb4m+YVEQjL6Hvar4WZHWfk7UzXwB?=
 =?us-ascii?Q?GTnGLBkaaDGA76mm6LucSaJdCq3R+QVeSJxu6wNBorN11BY8mkJzTv1pr9Og?=
 =?us-ascii?Q?so1OybHytMc7z8Xrk4bPovavadOe/LMAdu63x34LxdPboQTm/1ShmUvgXv0D?=
 =?us-ascii?Q?kzhj3uQozJLrXpr5L3cHOQHpqNSe1uYch3SVtr82q4M1Ec4LmkSjRSE4bnhp?=
 =?us-ascii?Q?TlgFCCCS6xHGmPLVzUkQEnWbmD85tCsSXvI5ZSCqOs2Zb6+6uNlA24XvGpGw?=
 =?us-ascii?Q?ZJzZkRE9djnHh6DpRicOZjWQDuQ5?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 652fcd89-b3ee-42e7-bd03-08df18baa97a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:03:30.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5711

Callers of pci_dev_str_match() manually checked for the ';' or ','
delimiter and advanced the parameter pointer past it. Move this common
logic into pci_dev_str_match() so callers no longer need to duplicate it.

As a side effect, pci_dev_str_match() now checks that a
pci:<vendor>:<device>[:<subvendor>:<subdevice>] token is immediately
followed by ';', ',' or the end of the string, and returns -EINVAL
otherwise. Previously, trailing characters after such a token (e.g.,
"pci=config_acs=110x@pci:10de:1234zz") were silently ignored: a
matching token was accepted as a match, and a non-matching one quietly
ended parsing of the rest of the parameter. Callers now report a parse
error in both cases.

The [<domain>:]<bus>:<device>.<func> form is unaffected, since
pci_dev_str_match_path() already rejects trailing characters.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 15a074e95504..3e2e34b24019 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -340,7 +340,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * pci_dev_str_match - test if a string matches a device
  * @dev: the PCI device to test
  * @p: string to match the device against
- * @endptr: pointer to the string after the match
+ * @endptr: pointer to the string after the match, with the delimiter skipped
  *
  * Test if a string (typically from a kernel parameter) matches a specified
  * PCI device. The string may be of one of the following formats:
@@ -389,13 +389,13 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 
 		p += count;
 
-		if ((!vendor || vendor == dev->vendor) &&
-		    (!device || device == dev->device) &&
-		    (!subsystem_vendor ||
-			    subsystem_vendor == dev->subsystem_vendor) &&
-		    (!subsystem_device ||
-			    subsystem_device == dev->subsystem_device))
-			goto found;
+		/* ret = 0 if no matching string found */
+		ret = (!vendor || vendor == dev->vendor) &&
+		      (!device || device == dev->device) &&
+		      (!subsystem_vendor ||
+		       subsystem_vendor == dev->subsystem_vendor) &&
+		      (!subsystem_device ||
+		       subsystem_device == dev->subsystem_device);
 	} else {
 		/*
 		 * PCI Bus, Device, Function IDs are specified
@@ -404,16 +404,17 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		ret = pci_dev_str_match_path(dev, p, &p);
 		if (ret < 0)
 			return ret;
-		else if (ret)
-			goto found;
 	}
 
-	*endptr = p;
-	return 0;
+	/*
+	 * Whether we matched (ret == 1) or didn't (ret == 0),
+	 * ensure the token ends with a valid boundary.
+	 */
+	if (*p != '\0' && *p != ';' && *p != ',')
+		return -EINVAL;
 
-found:
-	*endptr = p;
-	return 1;
+	*endptr = *p == '\0' ? p : p + 1;
+	return ret;
 }
 
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
@@ -968,12 +969,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
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
@@ -6492,12 +6487,6 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 			       p);
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

