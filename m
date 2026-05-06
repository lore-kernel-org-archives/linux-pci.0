Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013085.outbound.protection.outlook.com [52.103.43.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA248034B;
	Wed,  6 May 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076661; cv=fail; b=B6n98VYaRz1+pSLQDrC9ob+VXwCMQ9IAGrCd9lvIjzndce1aJfDa8slv95h0mpEMaYmscdarceMxUuQKJOYPU67Z96mMsBvL+eycEJYxt+dfNQGNf6wTXz1j51x5jiDHWIh0Dsn41DBu5e9YElb0I6vWECGLpJ6uE8r0XrOW4+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076661; c=relaxed/simple;
	bh=UWi715lrhws5cOzdZxlcL6rRky8HGF+2HcQJzavF8bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PIg9jeDy+1utJROYwbHrOFujnuA2H3D+5hTncYzaqUzjoOStTYQQPwbJKrtcxBcS6AOI/hUNxYlBsQnlKETV56SeNkqH1h2sEW+B3vyNSuCG2p8eqlZxjr16veOnQi4KweE+6fm+L+1cz2L7lb3l7JbY1mgptkzs1UVixSLthBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=FWdqtT/f; arc=fail smtp.client-ip=52.103.43.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FWdqtT/f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfOC30/dcZZuRx2QsxfN+jHSNjufGNqJ/03Kt8s7x/Uojo5AwqZkk/fOIO3uRJjmgKvGl8JhHO2CKJE3eObdLZEtcIKxw/DUclp8wn68eRTkn+9JRgbgLWVcGcQMi9sj2GxdEwwD58BRAs6y/eXeKSFYdcqeMwi1tFEHaYHpp1OakL59e2lDUxTrTp4H6Cndaf9288Sdjf3/OVW3spCIIvT6Z9RZDbTjxYhJ1v9A+/Sg0QbHVA5zX7DvpiN2wDN4U1kDRWHQouzez/vuid8nDDVOn+c5Cjy3/fmrhN+HGperq6zn2C5DTIoqDsOx1HJtH9S+VxQEvcxWEsv/04FFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94fjCrmLZyXaTPp0nZOy335MnaVtH5KDBNqNysRkcds=;
 b=vetwm7UAMTaHOkDLf5dXwbT/zRl485kBZTsaREFfDZ0uhGTpnenDe5eJTJ644PFsop9wq02JN5tZfEt4mq4e6Zi2bHGX8Uk0NC59WrB7gRh9WBLKIIDu+EMwdvd3m96g4jJVvAIBmt8FjB1FsuYGekfMp7eWUSFBwMStSyqlEZfA5wG7gJU1130qQcxOcyDXUemALFt5GF87pCIQ5JyH0aWm0tyF0N2nJNJ45pKX7QRUWDcP9vPoiGiYzCtfbdQF8623BPcu1Ru5WK8myyAAduXO5ilO/dzQ1NrE3XOpk38Y001ithHYLGpqf3r6UwZIZ/pEJq/5lJCcxgAQhK+WKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94fjCrmLZyXaTPp0nZOy335MnaVtH5KDBNqNysRkcds=;
 b=FWdqtT/fdgtQFeeH0AJC9XvjQPsOPjKnjghZx4hmWE5pecXDiDmMIRz3pwW0DTLoxvbhtEnNZb45KU2U09BAOj6Y6Ua24/VBKCh0hQQRJvm1vaMMblTLx2QN2Ub36DCZVKXzv9/aq3h07T7ffI3KU685z5d4+KST2tdfXQz0fGynFlwmm9+EWeMDPD6GRxgirYevVtZYXeBLTtAV5HRXMxq+HztMohvbChkzK3xmhFMFvUQKltsWVzDZXP1kiGfvL6WXMX3kGqLalZS8kNY+pc3UfWpCYMHesSo3bufOlcT8YRIymFK+t5yoEfqLCPpTf1yYjfRzK4kI/ewhi/VhdA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4454.apcprd01.prod.exchangelabs.com
 (2603:1096:101:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 14:10:56 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:10:56 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v7 3/6] PCI: Consolidate delimiter handling into pci_dev_str_match()
Date: Wed,  6 May 2026 22:10:31 +0800
Message-ID:
 <SI2PR01MB43933D93A8B638C86C84D405DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260506141034.1738541-4-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5c4066-268d-4569-739d-08deab794a07
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|23021999003|5072599009|19110799012|7042599007|15080799012|51005399006|461199028|45011099003|37011999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5EV+yDLXnKLp2JFweTizjNidwtIc0/rWT/v7Ff5ZH46g4PNYXzbO5BToJX6/?=
 =?us-ascii?Q?HQnsBdyZGKIFU2vPnyMqO/VavVgtFwHFRNaRbJMlrsEpn70wETrRWqXXw/U+?=
 =?us-ascii?Q?I9yToyy0vQnOCdCDqNckDXFvOiW7EGF4hkxJ2SYf4J3eRp21b+5n7y1M/vXW?=
 =?us-ascii?Q?/bmv9nbUM+/AOoTRyiJxZYSS+DXMFOmcFtKcsYpkZGWqUvClf6EJDnxCcJK8?=
 =?us-ascii?Q?E+TCJwR33Fw5Bqyw9TlnfM2EcSLkSsFSTLFB3rKyWPTQYHPhw7wRMSgqaAfS?=
 =?us-ascii?Q?yqTsAPTUi9vXMcE8UjRMiZjRrmi2E1jFlXlWELzxR16eHR1YARIqxJcJciUn?=
 =?us-ascii?Q?ieX4iGdq5SO4HG3MBm9Q8Dc2G1pwwB88c0qK0WdQ3yYjpg/dH8Vl7OMkdf+5?=
 =?us-ascii?Q?XKGunLNfcecysLjh9lweBu23rKjOFCroANC3zG05MjoD+/Kb1wyd05QdSjbu?=
 =?us-ascii?Q?PmIKN47eYha4kQ4fJXiwHcR5qmrSmC/bLRsRIVcillGDhKBv8B1RNaP+vafU?=
 =?us-ascii?Q?ao3q9mKKhDPeDEOc5Nt2zwDVdU8UY1hA0sx7izBDalEcbpZUa9GIp+UxGD9I?=
 =?us-ascii?Q?sqtX3gWF7gtovV+kVL+DykUH/uS5hTTkxUaGC03s8T1L1Gq8vM7HgA3Mi2eE?=
 =?us-ascii?Q?FzFXYhjTJAHS0BYeD09NKIADAeIriSqIXL/DgJqYRhfRrbFYlDrLCcwQSNOf?=
 =?us-ascii?Q?1/vLRWCkKpLeurcQ1qjkipcqsSyhZkK/3bFy7Vi7bjjTMu40Z90sOrAjb44y?=
 =?us-ascii?Q?2c6lpfJg59cOEnPRLhqHMSH2n3fStxXgi2Rs54XJjJr/6cXV/8rxXFFviJqn?=
 =?us-ascii?Q?fM0928YE3yeL/YyagDrgOENfZYMePX/dsR306CvC9Iy2GJg9sB2QR25RSZWz?=
 =?us-ascii?Q?3eiphGxGIw/LWjhbTqWWlixT05hGUCwvEscyaDe2FTZQO8vTKMT0I4j9937p?=
 =?us-ascii?Q?n6kvzCLAa6SLwmkA7N0FFRA4JDvBawXQzwwsbp21geTEkjazSMHOTSIyYAkz?=
 =?us-ascii?Q?ZT1SX8N1rir8DdFX6IXhLbPMMg7VSKRKpraKWM5uBkd/JouH057uANy0+L/x?=
 =?us-ascii?Q?vFQfDWl2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hgs1nLuZtznUfZswLR7vL20U/YdHTSSJA21BsE48/Fqm/P0nNlzMJnOU66wZ?=
 =?us-ascii?Q?wNZwAVDaYIYkE0m8NXnhejVC0DcKeA1M2lUzesedzA4bdqW12dbo7uRTgYoY?=
 =?us-ascii?Q?jJ/U8qaUAPC3NxZu2H9i5TYKh3SGlj1m/VyUZI5b4cmVWW3cQbltyi2zzxSH?=
 =?us-ascii?Q?otOX5aWvOphL49s6NpeRP+uRPlEntcCbb2/5c2WcggbtS0ErP7YzEY4RK6QB?=
 =?us-ascii?Q?Q3qUpNNW8fZ7k/UJry3CsCXkHVa90Rt4hvjXND7qolpLzUPrqu6mWhu1VBIJ?=
 =?us-ascii?Q?wJv5JpM1g9X4kGBJZ0eCMig5ReVnto/jFIulxC5xRAoOehrEDrUIlA/WB+G9?=
 =?us-ascii?Q?i/cVpgjn9E2dtjbICs4BFssoHsLE6aisi3Hc4njCqmNln0oq0Meh1JVftaSS?=
 =?us-ascii?Q?4vKKaTA7LXluCrPNsGqIPMx4bZLeAsM4Fwl4AVdV0tsbQ24ozpJx3slzotR/?=
 =?us-ascii?Q?koXs1gUQ8WvRz/1FtV+jqaALTMk4U7AbsiAzdItVhmZzriEB4jcUXRT8tO01?=
 =?us-ascii?Q?0Vb/iYUYM1iG3NBkejnSfh+/ZSAoULgl9+6+Tm8uJJEcMie3M7qbto5N/KVK?=
 =?us-ascii?Q?qvNdQ8nVaFb/mZuG/JX3CsmnWDz63e/MSWDIoIaSQlrRTVDaLoZJazr64Iow?=
 =?us-ascii?Q?HPsV/1JUmgyadGRLjQhrWwnORKK6sBFKjhQya/cjkUWlq68YceteDrBDFiDP?=
 =?us-ascii?Q?LbjPeQMdsr9ToXoAOOd/Qn0ierbIXudb5xo96PaWORrRuJby34HhGqvMEOuL?=
 =?us-ascii?Q?VRtJKhNdsof4FWC3eiPkzQfxLc9lHHIwfX9pFVU54pZE4lKHW+pru6gsG1/Z?=
 =?us-ascii?Q?OK2XZ856LcbS67NX9LbFRcQsrBF1+uUnCZnuGV+rcgPeomsO2TbTSP3erVVf?=
 =?us-ascii?Q?omJ1I2EorfxQhTJb6x7P1L/iLypdyz/0dCs/kMUgTY5R+dVbFi5r14Q7/BPI?=
 =?us-ascii?Q?msMtF5SaT4uAyb+gNAHEcB6C1XycqRWPtZl7H54CpTK3nW/UXVHpqWMCGBNe?=
 =?us-ascii?Q?QK5MnAIGdKXhcIT9xRs3hfT5zRcLaIeJCzABJYAebKYzeRbpSp/KtxYx17L5?=
 =?us-ascii?Q?z0Yxq1lpOabYZSTT6OphtEeMhlb2HWLtFALL3rqmu2zobbYl/DRe7CWR20GO?=
 =?us-ascii?Q?Z1G9MdJCxGdwpzIePCVasBuEMtwip8gnAHUIOTHYeFLuN+ZRqkJ13BR86oAG?=
 =?us-ascii?Q?FJYM+EJBRW8ht2F7b9w+umZGB2cccfVHPBiiMQEzc1CwPnwtdgEqY1stdZjO?=
 =?us-ascii?Q?8QWLDsraYntmb2uT6j9GxQjXne49jiHLPwiaReAuSIYznSoXZr5NNQhBhALm?=
 =?us-ascii?Q?SGmE0N+4nRTqBXo/hPi8vOwF4b6bTYR6JA3lBfV6+l3fBzd6BWuLju6urva9?=
 =?us-ascii?Q?ZJLUAfOdjb9Tx+sxe6YEzM0nq/8P?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5c4066-268d-4569-739d-08deab794a07
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:10:55.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4454

Callers of pci_dev_str_match() manually checked for the ';' or ','
delimiter and advanced the parameter pointer past it. Move this common
logic into pci_dev_str_match() so callers no longer need to duplicate it.

When no delimiter is found (end of parameter list or malformed entry),
pci_dev_str_match() now returns -ENODEV to indicate that no further entries
can be parsed, preserving the previous caller behavior of stopping parsing.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e017200694d8..ebd1e81264d2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -334,7 +334,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * pci_dev_str_match - test if a string matches a device
  * @dev: the PCI device to test
  * @p: string to match the device against
- * @endptr: pointer to the string after the match
+ * @endptr: pointer to the string after the match, with the delimiter skipped
  *
  * Test if a string (typically from a kernel parameter) matches a specified
  * PCI device. The string may be of one of the following formats:
@@ -374,8 +374,10 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
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
@@ -390,6 +392,9 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		    (!subsystem_device ||
 			    subsystem_device == dev->subsystem_device))
 			goto found;
+
+		/* No matching string found */
+		ret = 0;
 	} else {
 		/*
 		 * PCI Bus, Device, Function IDs are specified
@@ -397,16 +402,28 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
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
 
@@ -933,18 +950,11 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret < 0) {
-			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
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
@@ -6387,16 +6397,8 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
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

