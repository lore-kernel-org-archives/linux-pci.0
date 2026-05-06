Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012060.outbound.protection.outlook.com [52.103.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7148C415;
	Wed,  6 May 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076656; cv=fail; b=opiPzCohKc12x8haI22M5l9sU5ojWP8mKSuFV67oGetO/Stu2pgtcdoHhIBCtRzxPsGRS+ZYspUxFUW7ZlRcHF8Vk1vrYbSwgB1TGdX8unJ2r9nnYIJAenUVNP9IyhmxHvvbD3+w9nvJEoLph3EsJlt8X69+LdxaQ2FQyyUZLA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076656; c=relaxed/simple;
	bh=kNcpmS6Lw49KE3E5gYGUXpPJaf5zeAHlYJvktC3kAUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rMe0EzS54EoDBrAE3QDpIKSd/tPjsbfZlf7qTBljj9XFdY0GdKA7EjOHfzDj8i+Yc0SNIl4U3YhVeffM1v1vCoLAvOIwDWU1LKour4GbRqdH+M1VyZX1BBDznUCIm++fwAv7A5O+6MSWKAwj6PvYr56L/xTUS3T6U5cJlI0NRBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=s/EZWMBM; arc=fail smtp.client-ip=52.103.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="s/EZWMBM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kx2Fju7219hx/Ci9GSQB+pnezEvYJOcPqRwnrnEjekOkfc9GS43nyoNnKAw3q6WUXTEkcf/lp0slzR2VWq3AIzY9YgWBhPdGkkwvFsvl1DIQxYi7EX6kJVycx7fPvR6ct9UZVBVXgXPibczawlPU/KKD7SygbIxMyQGGjVV48dwQodpO3V0QU5yEyqXOX38J5b0VHZTldNOSiEwcb/UxCp4KxlP+HpRcc3k7GSRDirAHA+ny7aQKfamEUTHhz8SRfLo73ZiGZESvfEwJfVsQnuiW44QeGCmWsc7HQPEik5c0FumIcQAURNWGjC993Bqvq4V1OTMfP88jSWVpCX8p3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URsE6zfity1LiCCP4qtGcpHfYvkq2ifzxfmokEukEgo=;
 b=VD7foieGCdIJb+sPrbuVZHawyOj/OI6LDCHID648D0lSdEbj+HmUJZ0GAPZXa7+FY08a/S4+v/imJCPmuYY9/2ZN9ZfcyuOyupuo+VqW6XZ8UUGsUT36W7u1E2ejpe4utrSIy6geoCrQfmPqhTwgEAASmpjKvzKcZmbQT1XP7u/nN3XJGs7aSddalOImDlKPJrqD5LLuYud0zV/Bbpprd4XAxv0m/f38fq3yiInKjKIv11idVdr2letkDOTJYcfyrYzGuIHCU22Z8LR8irx2+WI9+GiKAKRIwkGQ2A8DS90DG7Vv500EIex90uOi33uh5ioea7lqbAWA9NKHixpgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URsE6zfity1LiCCP4qtGcpHfYvkq2ifzxfmokEukEgo=;
 b=s/EZWMBMUUYXKMs7xEfjZ93msvEPOmphMBWlu6Cg4M+w8MA0UkwTj4F737Cp8vTfFu4JewaowyRr62jQHtcqKXVlAIJKVoxShMpyQ2bXEPPLluRdAQFRJXjvVdItMNOTql6Gd3bmN6tzcjMWYR1h1T12HY9NCjAgNUFKvQEVDAWx3TYWe0AylVfQBsG9PWLL5OxVJ2n+ONRA5DW/jT9qVKkRN2gY+zAQHlcZ/r3gDkPEs4ReteMqOvbm2NdDGhpatnFWbPDsxDb6VhkD+8nEWc5xE8pR3hremtS0EaDTJDaJgsF7MTNN6BhTX2eCI7SWd3Legbz9tXFzmjueYUBdpg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4454.apcprd01.prod.exchangelabs.com
 (2603:1096:101:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 14:10:51 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:10:51 +0000
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
Subject: [PATCH v7 1/6] PCI: Validate ACS enable flags against device-specific ACS capabilities
Date: Wed,  6 May 2026 22:10:29 +0800
Message-ID:
 <SI2PR01MB43931FC883781B95114B94E1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260506141034.1738541-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 07411396-ae8d-473c-520c-08deab794716
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|23021999003|5072599009|19110799012|7042599007|15080799012|51005399006|12121999013|461199028|45011099003|37011999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V/59DEZTS9VljSp5v1UbDVBsNPMvSPWnHINUXzrYbU7VqEZAVNUIFc36W+Na?=
 =?us-ascii?Q?WIBW41IgovdJB6C88NbRlES9a+dCgtSYZjfADeziZMeFqathkcDjPm/xY5kz?=
 =?us-ascii?Q?VLXV6YNY9zj5wfOvuR83pNeeAB1garryHcSPuLGEfxVc1uOmRe/6wVxBCtwx?=
 =?us-ascii?Q?6RX9NWUhpRZyYV0oXShjHaoKgMqR4KZr9ox3XTlgluHG3qIYaEMT1kiZFZ6a?=
 =?us-ascii?Q?G7iynduAv+m8KaeNbc8OzG7T/MWb0Z9FG07zrlFvgh5ndyeKgGr0db310eHU?=
 =?us-ascii?Q?g2FMfTt5T7Wfa94RQaAz9O9JzxJ4/3UtEd5ELUmqPgzuXtrHEQmeNjGCSKRn?=
 =?us-ascii?Q?2k6JjK7wh2uk3NDGsxLdmEeIqPdfQhsLWPsc2YZ1cHS3Y5toSFXA9Gs8K3Ih?=
 =?us-ascii?Q?AMMpGzN2F5aGRUFDIAgqpyjnC6+KVJYVE6DggqnxpslirvyMx+GuoUFxCTbg?=
 =?us-ascii?Q?PisLmsfQjy9hpSpUvY9B9GlnG6BwbEXc6vduwvWEjS0fYs2+4OXrRfURwBdl?=
 =?us-ascii?Q?kulzBICBDcaO88NSE/zMbK/TbcAYMTWQwhGKFx+sASsO6z7cgWt0VEy9GrGA?=
 =?us-ascii?Q?zTr0mszqpztQI0nCPuxUp+Mo0ZfIFWXCxvSUULFsRHRqmkiwLDEAbwP4MEyR?=
 =?us-ascii?Q?T6siGRNg3esixUUEmx18ScxtQO2/Q79zKr6/b4HQgq0aaRD7sg93QGhAgY7B?=
 =?us-ascii?Q?z/DEg/x2CuyLMNAnUxu9nO0Fb5DqOhgZ1ui0QReWjpOOodcji9e+TiWXzc6g?=
 =?us-ascii?Q?vT7ukTb72PK3h2nYBdkoiYStpBUGWe4vvX81NT5SA9jyGrGQyJqZPqilMVB1?=
 =?us-ascii?Q?6mITplHeTPOQrT7zLgWB8PEhgABgEJAi1WYXLDFyCvHFeTqudLGQOcKWTH7F?=
 =?us-ascii?Q?FbrBfPBEDp27RtIKcmfd/aMIdqjZy/K+2SfwhbDYXMHF38Dqm6TCtVis97Ta?=
 =?us-ascii?Q?rpmTNiXQ1590EN/lJoDeLlPtDB29z6iv6V3JDtPZDfUN2rkYKkncQ4ksq5D1?=
 =?us-ascii?Q?K6UgjQTOaU5Q205WTCJoVP8DxBGFniFkvC5kvAsnn0b/0+sqA3PY9Ujnx7G6?=
 =?us-ascii?Q?+XgXC8jxpaoEjNsGeecVWmTo//iqdw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0B6Xe+XjYW0ke22E5OMioJHphUGSEtpTVHMPrsvEAT0P0m2l5FO1+CykXFs/?=
 =?us-ascii?Q?5Cte5IzNF47pnflZu2pgfV7ZME2kY/hkSVE2MRVBPEGL+1+K9uKCdor+zz3X?=
 =?us-ascii?Q?KOlmbhCt5DOs+DIehiOIEfY0DfcHfQDrPSOFME0isfnL6OazF1U1e0uQ2LtZ?=
 =?us-ascii?Q?TqZgSK4YKPB6tiIP85FYGwmJMNOABT+rXO5EZw5C1mwklbKNHzVLBgUSq86q?=
 =?us-ascii?Q?2Q3J06TAsI2/wRrVo4W5VnYH6bJxoB+/faRw1HEul4lZFHVfvwLUcPIl545R?=
 =?us-ascii?Q?D+kYXIw8ze0+w6Yq1POLvHzdPheBcqx4N+tUHpoOnapwEko7ePATtR6a5uNM?=
 =?us-ascii?Q?wPWwOx+uokzYQiqXMoxAURiR7f80jHF8yrdDcQ3/ZuodiRatZmPgsaDWxp45?=
 =?us-ascii?Q?BT3scU7EDUhBri/3Bl0u4j5hifoY53AwUne8bSOnF5BdIsMUgOf05a0Gg4VZ?=
 =?us-ascii?Q?dFXY/m8ARgjybx6HW49I+JpxvAFlpL6wuhI3BHy5oQKDPucjqxaJZ+IeVX5S?=
 =?us-ascii?Q?e/C48t7eDq3wHg7uPysru5+FkG7OleyPN81QCzsIvN64tgHHeV/vSZjMyTRq?=
 =?us-ascii?Q?tpJVgawh6mRTukYV7jTsr8thCyoxFSCAOWj7yGYxQvCoXCUIl2PSdh0G5tiW?=
 =?us-ascii?Q?kxEDDQwS5wY1OEjYbkiW5G83p58+OygLHZac6T2DcXNDIHJ0hCMQsacmxxwS?=
 =?us-ascii?Q?xp0GSUaCflvlCAZUcWKR9RzgbuBeuMxS6kbYRdhmqyFw5GNd7JjKRO+e0wIb?=
 =?us-ascii?Q?aemFQQGxAspXQk/mbjMJzhm2A2HccMua6kXN0lgT+wc1nrnN+RX2wQYwMowy?=
 =?us-ascii?Q?Y1aD5NxEtOPoBzygD934Nr4bx4noaogVooQ3trmlezDnlLj3JyqIeVxOcBfT?=
 =?us-ascii?Q?8zMyTO20TMUosgXfCA/AQZ0wZ6ygWfyRrr7ZQpDG/CfMNHQOIzfg/1sLC0HQ?=
 =?us-ascii?Q?fF4vl8Ti9mVQ1kIByB9B7q5Wrxjj6QVWJSfF+uggy74jh/L843DWWSjeJyg8?=
 =?us-ascii?Q?tKSq70gn+bGd6KwpJyEhE3oHksmtuPKPIgtII5iAnHprmkDM30N3pnIL79xG?=
 =?us-ascii?Q?6k5tdpp7CAPHhdxRZSRe6dyr9mhY7ishOZjJEJcMnu2GBviDWR/Kxlij7b+d?=
 =?us-ascii?Q?DIlJ9wjOOxX1ptZAaiKmcBWayQXaE5cvs2qq1sh43WkB1S2n7cG2capKrR1M?=
 =?us-ascii?Q?ksSvNbZ2tYkvN/5R3EyoXFU1DPE+hBOV+wUBNF4+8lImEbJFa3fZwAwpHxh+?=
 =?us-ascii?Q?5+PqqVpHihDGcPkvrQcqncliD9maZtszFaoIU5kWrohnZJF2tjgrDwfs/Qtj?=
 =?us-ascii?Q?uRoEWjbv4qj1dv87XGiCM6zcrpqBNTX+q4MrOp3NiMTz511jp5O4nvl9Zwd6?=
 =?us-ascii?Q?efTlgQSsYonq7hcLTp9Z55QZczuZ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 07411396-ae8d-473c-520c-08deab794716
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:10:51.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4454

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 783e71962cc6..e017200694d8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -931,12 +931,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
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
@@ -959,6 +953,12 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
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

