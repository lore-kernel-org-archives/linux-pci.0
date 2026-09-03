Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012050.outbound.protection.outlook.com [52.103.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4356381E9D;
	Thu,  3 Sep 2026 03:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407215; cv=fail; b=MwVAvU9jBzbGZ1Ck6lei94DOc9PD+214kLy6wKa5VBJclH/D4SerBnFnVGEO9y0jIQFXYSHWHo9pKw8fTQnrUfc2rHf9gjjmrwJY1buDvWea3xZhS5TqDdN1GOaghNo8LVPKBH/sL5XAVxUH6wGLO3LsjF8tez6q82F91x+LX6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407215; c=relaxed/simple;
	bh=FvEUpCbmTDvOIlEgFyH1cfFr9w2WJlzUvIm4DydJ6E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRN5mdx//u6tLhcVMKXRXJgFAqX7DH6hg8Qq5c/YsMYnkJ7JvhIL0bxC4viWiHzKvgRJk1yjplsdnjxQvNTNCF9XETuUq/awbsarS6L228drEmabyg3mXB4b/Od4k3gq7US1M0ngSqDErfpo9LjWCFWpMN5IICWEU0jY7utAMR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=S4a7v968; arc=fail smtp.client-ip=52.103.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="S4a7v968"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCpQs/npjhdX9TuwWR2aFmvyhg/eSzsm/cq9tvfzZNgw0T2G18MFUQb5fCLs9tCMiy6QIyqU5G4SSfyarkuldOGSps/Xb2U0GypgVNCTULJjhPycNIx4WTAORJL6qSmHeRNewl8ZCR+O0XNPi8KQpx5v3QmnHqFqKytjz+XY/4KECWFDFqE1EUjeHBJFsAqsn+tKfjxxII3/1O6nXt7JbxbR94sSpwgFUUHK2nK4o/f7qL1HiriLnh/JRKYDWm6/HEtkvfu4no5IfQq/IEFciWJUtzjIlD8xY375prT7WxlW3oKldkLg4vt64qsVJs3RADW18lDLrobNHOaJ28RGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2BZtCaOezEGvubs9RJbnZCs/TAj7++TLtMimHIae88=;
 b=gnHasQgfPq1CtlXuHUs564YBVYDdqqHYMWJlI7ApzmAl7XDY9YZNQd93BQFL67qPmS3xq22S/lPh+3ez1jba+agWN6yIdw3vJcz9V1dJy+xEqmWTTlvEiKiUTNMfH8TSd+OOOCKgNc79XXIGNK2C/VCDYaonHuGb8gaZ133UZ5kj7OSxTKKyKU33d/nStKFjxALQc5NfN9Kou0HzZKFfyVsEwUCEy7kgA4ECXJxa7bnEZ+6JHYPchSiQ+ZWNDSeVLYmh4XAX+DdRVnYu1Yck0BBiTotTPncMOMBFCuPO5x1vowAfaa+/d9SSNXQCps1Jn+aDL68gJKBN+VBkLlvfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2BZtCaOezEGvubs9RJbnZCs/TAj7++TLtMimHIae88=;
 b=S4a7v968+lhr2RNzNMRwzVoKK4UvHSyB8WIEJyKWB7vXs1LArcoeg2dsyvUaO6Hdo6X8CR8cZOBT+qIf0QnjA2SbSHpjR+tmXFeMmjC6A5ePwx6n/yvPtuF6YFWEBYartJWIwCDfked0TL6NQoKqQh047D0saffSwMtvUgMUhNmlntT4W3rt11f8wRFKfajaJAN/fJpP8v2TnJiX21PEsb0DRy4LCkEuJkmRCpX+2/QXL97Y5VLl8yhsdA7Ea2u6UL8J0oc5z69g26Hnhq7Jvto1Hv3BEeXQNftUPRBP/o1us6K0b8U9UfWmoDNCNBGfuQTM50YfSqlq0Tz/VCU+0A==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4733.apcprd01.prod.exchangelabs.com
 (2603:1096:101:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:46:47 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:46:47 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v9 3/6] PCI: Consolidate delimiter handling into pci_dev_str_match()
Date: Thu,  3 Sep 2026 11:46:15 +0800
Message-ID:
 <SI2PR01MB439377D9DE029526BDF897BBDCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0092.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::7)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260903034618.1100387-4-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: b08c3a55-91d7-4ba7-6420-08df096dfa9c
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOKJoN5/65oG8pHy8XKfr/71GPfyb+PVrQjgdyvvmWv3hVV8PdNkCMqqUQd1Ivfhhuvve+WXMrYa67AXOJjA3SxJzE158E4VCh4bSvwmUc1c83dInZ8cAh6q17tBlE1gPaEFBpBErz4pKtKJs49cn+iiRdbA0G4NIBPdUZWgmIDuSSdNaJSUlQ8D4Q49imMAbHllPTDeA9cPuXTQ2zbHAFpU9gVbyPv3FVWWLmnFWyXhwZOgLWq3Td1Q47ZoDk0TCrKOF+0DMgned6QbHdPnQoCtsMtYeBB5RbYKZpwxWgXmtJFPmQqt2BO2YI64CJ1wVEe/qOLW5ipi/V6bdgYNvfy4bEGTgoPTT4jnPFkXmpAQXrH5vkQY5O63BXeMYy+xUwcgoH8dettCGwPMaSNNK5I0qaZ5np0BQ4a9Px6Ucp6up3J8TfIkQWWGi4vLhNKfv6Sq2KDlaktXBlVOlLFKNaC46zx6uq8iolm08ou96q+ziTbnVtPUsDcdVldAOaBMtf19fWpg1dNcgSdTGhYQEcdZaGxgPcWSHEnSnPQnZnNl42S2tEI6wMkWoJYfAlz8ClrQaGw3M5S7a0W29g5dVi8QRCiIxjQ2t+A+bd9mQ9Vc5QPcFf1GgP0D8o/hN3DXvlDab3Yp/N65Rhb5a8AXX+KfW4IXxnEfdra4RNG0wLoDbpKcVf1Dx2hTRRyrQvBwu934rx0ThfHm4lI5JBP/jrJQgHpYmZTs6Q+UPVGmXSn+w=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|5072599009|19110799012|25010399006|23021999003|8060799015|37011999003|45011099003|15080799012|51005399006|440099028|3412199025|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWhbVeVYK8vDPHiMhNUrhHyl+IeJHCEw9XwagycPfVC+5CjBG4WvDNWyTJw1?=
 =?us-ascii?Q?RGXcLQiRZON0MFIUE5iYmgOYSbO5z+Wt96tbm3p6D1BTPXLt4SdSqueDHFFi?=
 =?us-ascii?Q?gZOkostrkvJXg0dL2Y+InmhR+5VzaVpAOra7X5hW8uq6zYE1EUAHahC1vwqB?=
 =?us-ascii?Q?gIJI6Eon7/QdmgeePFrCMFP6fO2bvb/3w4PC81HW2kFFVeW+QsETbsnHWIdd?=
 =?us-ascii?Q?avduIc4Q/zg+QXj+iYM3VT5PKP3IZzBLEu1vciAm9wvhWrjSxSorP91t2AAj?=
 =?us-ascii?Q?HBjbcwYGMG0Nndypq3MGSbr8cKMV5ZajNjP/0ETqOXoGkjoInaRcmgW95apm?=
 =?us-ascii?Q?1Rtc0SHHFqmNcGWBb6SQ9m32fGlTdB9E0+8AIBb14IkcKR1OY1mhW6GgaFXE?=
 =?us-ascii?Q?c5Ok47BmzwkZBWsvPdAVsSliDZDo+tFmDW1tPj+lBb7I0ZJtb9Nv2gbVGgaj?=
 =?us-ascii?Q?Zz/v2qmy+W1oh0UZpf8+kYKCEd1IMMtzKNIsNGl8YH37WkEPPYolY9gK7cib?=
 =?us-ascii?Q?lSNZzvHuynOSj03sUsCsKbBXIZjBwtk8gqlZ6J7z153k6SDe9QIg33m9ZC6n?=
 =?us-ascii?Q?c2udP8kENVjniyQS3wzB54GD8Flr3FAprvGpln9a6sfwQAnlNI7bn4DmZBCy?=
 =?us-ascii?Q?niCnWsxsdbJzsg5uvkPpgPz6Iy3G1baX1lJ3J8xslCyRPlMHd1TvEV0h1hW2?=
 =?us-ascii?Q?PZWQHKOZRc75c9bzMRA0PxsU1tPXX0eQIRO0+LqicHDbz0EL+tHZqUAuKrsD?=
 =?us-ascii?Q?D0dHsBmaohcGq45VFyr+UFS1eu8mQzHe2XLxKrG7w/eOqtB2eP5OANb7BOHn?=
 =?us-ascii?Q?HImpMCP9/h7bqyJogPTjKSQ1cEwzL+baIcnbByMW1LIA8WaPLuwrHzsxeMsn?=
 =?us-ascii?Q?tEV3+C88MqGG6UEh8Jd/H2cQrcpdROPWNNlwY5MlWlU1Pqa6S+bYbWzoXwXS?=
 =?us-ascii?Q?pwOWTshU8k4FvMYlf6rF1IOz6cAtAOVAXJk2oGb7FqKkKRdy05ToEeM5kTIz?=
 =?us-ascii?Q?fT6gWQD/eIleKARekMWU+hnULA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mdqzdm+y6ZeOlJ9pKUb+IhuDyVtaKjCZZAr0C22O6lDfzdgCndqTIjGJj9ag?=
 =?us-ascii?Q?66ZLdCB+/T7+1YeGLbllLHWK1Au4SAENYuiBMFbpbKIjeuViCiypsgpy9seb?=
 =?us-ascii?Q?PMwGoNgrctLXs3TlnBjQRqplYsQmPEsDUDFVz6VXgR3A6+iwm0+YbxYD9hmH?=
 =?us-ascii?Q?d/pk4XkB5KBHAFh9Kk6IzH2BKoCD6O4H8xfC9LZ2PAwV5CEOVF3hdPP3klWw?=
 =?us-ascii?Q?d/UWajzFsguGYp3HZ2zbCfzqILMizcYW0xhYnrf84dH8o5oyZ6kMWLWMo895?=
 =?us-ascii?Q?QhGJDO2RcBrcyl9z4YgGU9/vsLOZH8djtUVhIKKHRcjObvFSRp/D83+0ebVV?=
 =?us-ascii?Q?b6gJFRLzVzCDsOcjOJvY1W4U7yXfDevnIUYasvd2RoCZkVxBhEBYzRANg8z0?=
 =?us-ascii?Q?ZSZJPJf9Akoh7srYhWbaYnx1ZGmyj/EdCmQmcZefPpG0tk/vkBN3FQp6QaXP?=
 =?us-ascii?Q?xhNPM72Y/4IwBbK4r8FtJuppHVFgXnBfr6b5TZsBPABYr8ikO/GWYsTIW7Dq?=
 =?us-ascii?Q?Bg2fiK+aUYa7OLLjJqahvu1JSZBC9DMFmI92RDJ0W9so5UkE5BNu55vPK1da?=
 =?us-ascii?Q?9+OS5ltddtSRH3xUo8mK8aV+Zt1ZeAUbZjpZmz128kYfK7Tuw/MRa99kZoqx?=
 =?us-ascii?Q?FJ3aOlruOmoIrDjJ4Kqq+/zd7ldSCx1mhia3TDaDaSJqamLyNxKXCHZ996Z8?=
 =?us-ascii?Q?5tpbpjsOLw7cwUTd9iK+RrEuxpfqGzFiTbXxvosQgjOLfHBh0HLy+FgfjMoV?=
 =?us-ascii?Q?vKkI4dchE/Q0VEixu+59ozR9wWuowyWaAGi+1AyHLc/JFsZ5FX772E98641L?=
 =?us-ascii?Q?6tvyzvzZIaQxd49lSS+y1fpQ3/9Mqou2vNXxt44mUsTjENDL3Y7KfoMLlc5+?=
 =?us-ascii?Q?DrP6zFUcurFjpEm1DZz99+jCOMdGECr3sYWW+gB6KSJBnPpLkyETyzQonmot?=
 =?us-ascii?Q?SDbc4ybzayKeu2HraWC/w40h6Z80v1Q9SqiEdB+LIlEh2z+3M80U1PFFdtNE?=
 =?us-ascii?Q?RfWjeV7Yc3ToTLqwQ3pZDA+VmDpV4bHc8rAS9vTmhF3LPtU87HcsnaFOnokv?=
 =?us-ascii?Q?OhKz8TsyB69M+cjx+x5fJ30w7NmmmB4w0f3qgJxQMbp9LBP1TbpXXL8Geaqw?=
 =?us-ascii?Q?oL59XjsYUUAM6cQi4uEStHY07wlykRJcBp2lJ1jWxjpJzLGSn8UGp5nz9Psm?=
 =?us-ascii?Q?SflF+VGW41iJW5d+X27p3lpGxML21ECJfaitLPrngDvrNrf0uy5SNZ99yZDD?=
 =?us-ascii?Q?NeGQMo2CMxPRFk21HFSSSPTCAGckldAtkyhfPnCmu6IARUkKs8fz5VRc3Dv3?=
 =?us-ascii?Q?a64iCWkcUMJ7iXMLB9kzMLRKw2gmBqYZKre3IECz6v+kNzZznF5L8hFK/kis?=
 =?us-ascii?Q?2L2LLUUPmzGLQwb28NDlPxNiwbCG?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b08c3a55-91d7-4ba7-6420-08df096dfa9c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:46:47.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4733

Callers of pci_dev_str_match() manually checked for the ';' or ','
delimiter and advanced the parameter pointer past it. Move this common
logic into pci_dev_str_match() so callers no longer need to duplicate it.

As a side effect of this consolidation, pci_dev_str_match() now enforces
stricter boundary checks on successful matches. Previously, if a user
provided a malformed parameter with garbage characters appended to a
valid BDF (e.g., "pci=config_acs=110x@0000:04:00.0foo"), the callers
would silently accept the prefix match and ignore the trailing garbage.
Now, pci_dev_str_match() strictly verifies that the matched token is
immediately followed by a valid delimiter (';', ',') or the null
terminator ('\0'), returning -EINVAL if it encounters invalid trailing
characters.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2af679111a9b..587c013f04db 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -336,7 +336,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * pci_dev_str_match - test if a string matches a device
  * @dev: the PCI device to test
  * @p: string to match the device against
- * @endptr: pointer to the string after the match
+ * @endptr: pointer to the string after the match, with the delimiter skipped
  *
  * Test if a string (typically from a kernel parameter) matches a specified
  * PCI device. The string may be of one of the following formats:
@@ -390,8 +390,13 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		    (!subsystem_vendor ||
 			    subsystem_vendor == dev->subsystem_vendor) &&
 		    (!subsystem_device ||
-			    subsystem_device == dev->subsystem_device))
-			goto found;
+			    subsystem_device == dev->subsystem_device)) {
+			ret = 1;
+			goto out;
+		}
+
+		/* No matching string found */
+		ret = 0;
 	} else {
 		/*
 		 * PCI Bus, Device, Function IDs are specified
@@ -401,15 +406,18 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		if (ret < 0)
 			return ret;
 		else if (ret)
-			goto found;
+			goto out;
 	}
+out:
+	/*
+	 * Whether we matched (ret == 1) or didn't (ret == 0),
+	 * ensure the token ends with a valid boundary.
+	 */
+	if (*p != '\0' && *p != ';' && *p != ',')
+		return -EINVAL;
 
-	*endptr = p;
-	return 0;
-
-found:
-	*endptr = p;
-	return 1;
+	*endptr = *p == '\0' ? p : p + 1;
+	return ret;
 }
 
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
@@ -964,12 +972,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
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
@@ -6488,12 +6490,6 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
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

