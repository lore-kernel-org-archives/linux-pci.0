Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012054.outbound.protection.outlook.com [52.103.43.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDB36403F;
	Mon,  2 Feb 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034854; cv=fail; b=sAQj+vAmLUMTARZvSQVKQCB/4p95TapAfYBRZJvv9wHeHeubVsykuDC/mmcMlR38mfP3eXcuPSX2c0aZHgZi4KreGlOmGPVGI5f6Cn22LaVyvfzy/Fb68vXRpJzmEr9Q930mkqNnpM7VUIX2Tdp1n3sSXycuYjCXLa6YQBEb/Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034854; c=relaxed/simple;
	bh=3eazuuI5NGtLIztal0DugyrSx49AYsgBw+jtmvsQSBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+klyg48XKgQ9IKCpee4J3YWiCY7XxXJ4f1I0wAHhD/ly1FfWYw75xernkKmx+P21FRY/8YX8zT6kKNdK9jGLN9zdypdXAvsO6jaCQ4KpF3NkbDEfzmKELyb/5iae90mk+/mf4snjopAFItt0/NlD2FuQtIZoeQBsLsTrzcMXEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Giz+rBVf; arc=fail smtp.client-ip=52.103.43.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Giz+rBVf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEwYF+idX+Zr8ganftonzYnLJFBV23cNsO18nxepnYxw+jJg02tQu/E+bK3ukPsNLTmBL0DkndIuOb0JF90X6aQl/MRQYiuNg1onlOfKEWIOSzdo2nE+zLNTUFWFTMFwrPZRN85DoFM8tfo0O/6VvgB6eoVYnyWOxiFLtm2NSiRYoo6s7X1vDjsxBuxrfs5SdGTYF8D6BtTEYGYOKBpJgF/Z5inVOpXRHaGEpAywDSUCIXxF1C5prOCBNm4lpVoIyln9R/lyB47OjDWx2CSJYM1pcRSn2/H6O8NLJhOZG7dwHYQJEnornhm6G/G8bZ7i2sEMhv8soyWiEBXIFC9pQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJHakUBIRyY95CZnHPkpm6d8Zf5an3j/FogP6yJjBwY=;
 b=LaAxWWjjK5OXLpATOtATJirM/8gfS0iZZ8LRiwvdyYU8dL4QLyuz2r2PaeqFcD1svWy+mGQOAVYg/O4DarBP1ZqiJTJbZh/rySWMDqFDO6gpVacIxMRHN+qSm0Tyo5LYl/YZmDlRXQcptpfDCtKXj94frBaqRBSYUUp4llbv4PNf46rgBN9+Sph/++sisns2efxkdEqXMCqG1h9gNmQi3+/CFv/6n3C0SXr48EKqvyInZMAH6BX5RL4F0KtGdYMoogu9v6ho/4zp2LNUA/dIp1FwZBgp5Pu6a3134L8RDyxfmG1rw61mAIJg8xACLs8A87YRzfPS+CO2b3mP9eqWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJHakUBIRyY95CZnHPkpm6d8Zf5an3j/FogP6yJjBwY=;
 b=Giz+rBVf1CWtb0tadBoX1PqslfbC3GJ/oCVmNfd+NZRmqvEQ6SPkKYbqbTy2NpvxDh4Y97EZLh+pP2WcktgKXJ8E0lxWslTYeEfNYneh5YbfrJpAUls+cM80RgX9xQpsTB1Bebsiieou43/UQrPM6kgiLA0xJJUlODX4QPQovjCADJYiydUbL8mBk4oc2mY4gS1Vm9CVeixilXCBEOqPEQTQ+X01we6Y88RO6Qq6a7Spw3M0p9heWBrJBoPToN74frEegcnyI24MCJqFg7OWUTz+TAmzS3FVqMaHOBqb0sShMksLUZAajr+0+xDP28rJglzZnT2RCIhGsiVnN9oCmQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB7965.apcprd01.prod.exchangelabs.com
 (2603:1096:101:300::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 12:20:49 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 12:20:48 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v3 2/2] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Mon,  2 Feb 2026 19:33:35 +0800
Message-ID:
 <SI2PR01MB4393537C4A9D8081FDC6B8EDDC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260202113335.3096675-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a52307e-8c74-4512-c25b-08de62557f6b
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6S8iGWZPkMuZxiie1xMlelLcRo0+hr/PtlX0BqzpJSQAeixAu4TOLyPJspJAcl/lnRkydOfuumjrusnT05Xz8FNw7wZJg80S0HJ/3tbTfHgoIzrNS3TiSgwVgDAweA7tZOIpYk7Wfghdm3KTqeVT3tCa8qLODzgFaQTERMilRqVaB2soZ6xNAMHbHbEOXmiHMEZvN3PIrvhJUU/sAE1VTI/Kee4UHn8uCzjbogJuuHE4v+635T+L+fR62trMN31WV0afnYR5pgv1QvkgvgoIIR5BhSstjA6/KdzDiahG47EKH1sdcTSdQm+OYPchZ+nvClQYFyJW0bZ6lbxfBVb1GEYAjR3q8WHVy5/oyfkTWHtVkt9Y2dKDCQ5EwnNHagNZyqSURA72nVNOSPzbOlLLyYZvXNlHzF283iv6FN/72KVQiix+2hC5W757J9opUJXoCoaIKcqI6OMoRWirpcnm8uphRYqp5/Fd5HF6AqGCmuGeRByQaIqW+A4k2oqbgRtSBxRBb6zjpUpZJGlQpUsCUUez6510xYE3LIEdBrhl15WkERETUNpNvEfMCYQ8RyPIjA6u/tcPKBXMRBQlWyMWRWydTMOgUcCJy+S0eHcsEfZ2/RLPdBuy3ZY5rdERv2eY9oXIVruAARdSG1l/vmgZH105Ke+dLhEavJlfJxARve6uzqE29Mey67WQrIY+iL0SIjmyYe3gn6nBaPLNwxlFPZcGIana7uYyMDNkBSxCoDcx4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|41001999006|461199028|5072599009|37102599003|12121999013|19110799012|51005399006|23021999003|8060799015|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZXR9tF8xaNMbfQ0wJsLN+mOwnOgt8k194r0+QcTvlNIDX+8mCM8sXXEV8+fD?=
 =?us-ascii?Q?9B79idn1QE0aS3iR9n9mbkQrHNbznBvBAQleUBy5fDoCJGvfRk35ol6iALB/?=
 =?us-ascii?Q?r8So3bSaXBaQfUfx75NwWW0c4oSMW5+7hW7U5iPYGf73VsdXvk+Phu7M/uen?=
 =?us-ascii?Q?4dReC6T3p4JONBSaqwLHD1kra+VuE/0G34crLbbFASr28rUrMqj82UyuMZg8?=
 =?us-ascii?Q?UN53C23nyg/lguIVgm7KTB6fNEb/rVvtwT1cpYvT4E+iyKAIR1AHJ4w0L0Fw?=
 =?us-ascii?Q?Y+U8T5lgcw+QHOfHDtPalkrsIZxyqxY909STmqrJ0t3fKDBQyXyuUODXOUnE?=
 =?us-ascii?Q?8+xvpSZC+XH8/oSJMpMaTciC4/D988+C7FTUEUkb3Veq+bicjIfDHo7vZvZc?=
 =?us-ascii?Q?P6dc2icCUFDwO7KTHJOx+P8QbEGssIGLO9KSJeaMZtov/jog80iU0h78aa6V?=
 =?us-ascii?Q?r8l/7kgCNZ6+B7t5TBlYGRyKx4HmvuTeDANdaEpnSjUJMhrawgo6qzZzYNDZ?=
 =?us-ascii?Q?YfCy8j1lMpxtlpDI8pHiwRpXS1iDOCDuENTFUOVeHYvzK8ut5TyCZvImlA6K?=
 =?us-ascii?Q?9QUC+MykZtNlRLf6tvSPBZyyTsB+KSVSlqEicbQTJMn7+YyaXQE9EEMdDBTN?=
 =?us-ascii?Q?hKLWOH+b/TZWYDDafK9bfvwDmsb7M/mVzw5vrdgU0Sl4xBA7qFwW+vH5u3lU?=
 =?us-ascii?Q?4bBZ1T6EQmWAqu19sKRygKy/ZWQFevdT6yafKX8X3ma4kPjGSUphxT5hoUiA?=
 =?us-ascii?Q?1Kt8SJOZlVlmi+0wQiztpZOwAEi7YLhu57u0QvFMeKnRAfEPC2c5GZ+Z22JF?=
 =?us-ascii?Q?AL3UjCjswpy68zpxMhWsARa2Hjz/5DqxfDk6oEXXYl7ExZZC6gcdXvaTMb3f?=
 =?us-ascii?Q?h8C+6btZRSXi68z2eIyZd1z9CuufHT+3LT1Zs7kHvylxdAS3mWnuHakr6L5J?=
 =?us-ascii?Q?xm3Y3qZBJHzRY0B3NctTHFKnV92AjYvPku7NkViVCxLtgVqyCe2lNDpikyg4?=
 =?us-ascii?Q?55MBSHaUHe5QLAOHN29uL4ojQj1MV0yR2dVEzoxpzrB1b7H5xX1mRMkq9ZhT?=
 =?us-ascii?Q?EpcbWguANKKbt4dQ2DrbnDhERqRvuqAIFVPaqOokNUwOh6Y5sVfqCOj9c4Hj?=
 =?us-ascii?Q?ZSbbm82CpQBo9xbzra50xxlux+aSdOcCfaDN3n9hwF7aTe5FhkAAkgs8rTMx?=
 =?us-ascii?Q?d6Y32f5akq07xXhnI/VdZC9JwS4fxJ2sg4taWCtD16RPjWKUYA3i+vEqMGgj?=
 =?us-ascii?Q?dADyrgWS0cVPAiCeJwzpNc15PGSQvKcAuwvWJJnNSNo9plzVMsEIKUBAbsQn?=
 =?us-ascii?Q?BkY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YYHbfd0HYsqhQXGTjpc3LTrddN0V0xEXOotP1UUFZPvF8iJ9W2MIplawnqNN?=
 =?us-ascii?Q?Z+TMztzajapSZK77FO32/Nef1JC6lpvO7Dm9yC984lMk+klod7QRTf24Fset?=
 =?us-ascii?Q?1DoJ683QFDrwOVt2UFTlgWZZouXFbDKDnjqRVQYPmB/HpGC20VfCtMirTZVd?=
 =?us-ascii?Q?J2CaLPCPOdQGSPDJgl16OWjgWDh/l7WY8NiStZtPoEEC4N0K1BjPYVAB9GuU?=
 =?us-ascii?Q?u5Vfkl2mp76n9xmEnhBHm/lFiFpFp548Zu2yCk2ivekExRrnX/KUu86rELN7?=
 =?us-ascii?Q?bb1PDXZPLaQoyBTfhwQuM4OfHaLDwBH7Cb3v9wCMljYRRw+NiQksJHm8CmoE?=
 =?us-ascii?Q?+ZHZ0hummS5p4K4nu2R0EB8Gk+cNzFuBkuqj+dHbFpoBBr4JDI4kqfjp9/iq?=
 =?us-ascii?Q?eUKH7OCstMSuLQnQ4PKIVOcAHFKoS+R36JjF7r1U30qmoPcSiF/Xc7MkVtxm?=
 =?us-ascii?Q?r6BqGcC4KttiTNeaFAYPWTmdoY75FSWXEoORgVizEBgMIo3MT3GsO8sFszM7?=
 =?us-ascii?Q?4oeirLBWL68Yo0c7hob0BsGr0vpjX5f53+5YC7KtPVbiI4IzAkQvpDOEpzSx?=
 =?us-ascii?Q?CV4d0RW3VVhSCUbJojzz7mVde+ivPFJFrnIru+Ru2XG6Gg+x/mHxcmMhx4Go?=
 =?us-ascii?Q?wiySbTNedGDUddj8KSOxMYvd32TAtritbhn2zkxK2eXhWTNPMtL2pjpSMHhp?=
 =?us-ascii?Q?JvQbBHYksre2FUfdUoRv8Y4TenDFdAT6+m+X2qTNjtP2k4WTNm3zzZYNpMLo?=
 =?us-ascii?Q?M9ML8+8WoYw4TXCIJbIPRHdlb1CEnh7xCbrUUJ5sXVVHO1bSdvchJdAa3ct+?=
 =?us-ascii?Q?SF0AmqcbDhheVGnwJbB746Bu9MGKgZBLdchAVJHZEOUHE2SuaQ9TzUQxPRsy?=
 =?us-ascii?Q?h3kKrE7NHLa+S3hJsUCKVzh5+9VCk/4IUc4Qe5XL5VcKb3vTrxfTX5gnlzMj?=
 =?us-ascii?Q?ursbUobs5GvzPe4XaMwIH99WDscNw/DTXawAU5HgJUZS79WxDm1dGFRYUpoz?=
 =?us-ascii?Q?JhZZ1NkfFvbXLk9o5UK8fI6Qs4/huXRJyWD0qeMU8Ki0XBN+GALUiAo2bgo0?=
 =?us-ascii?Q?PLGk6kAlpDjzNZBBcpUyNdYPlPV4UGJNgb5TIQHR86p8uXVOxZoFxghEqsin?=
 =?us-ascii?Q?Fg/oRLI5YO+kCgreTsVBZz0/sspLQ3eZkH6tLtWRUls9z6D8MHO4+mpRO6yA?=
 =?us-ascii?Q?/EInUO2sLyf7yh/Q7iaPcq7qOsKfa0xbsV4dBZK3PPoGM9oPNA8HNLRnN8nW?=
 =?us-ascii?Q?u45Sh8EGvxb0kcjozCuYsJrD3I3rbpB5mikKgGo+coy3T+0E9g0H0++GuuzO?=
 =?us-ascii?Q?+peMEQJXY/2QVGj+P7ik+hdjeGNrpgCoEEuDUOU87ay8e5RzZIW0xbdqt/Ws?=
 =?us-ascii?Q?5jqwImsCvq1zsQC+pWaQplelCm6/?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a52307e-8c74-4512-c25b-08de62557f6b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 12:20:48.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB7965

The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
isolation. On devices that support the PCI_ACS_ECAP capability, the
controls are required to be enabled properly:
- ACS I/O Request Blocking needs to be enabled to avoid unintended
  upstream I/O requests.
- ACS DSP and USP Memory Target Access Control needs to be set with
  Request Redirect or Request Blocking to ensure the Downstream and
  and Upstream Port memory resource ranges are not accessed by upstream
  memory requests.
- ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
  areas that lies within a Switch's Upstream Port memory apertures but not
  within any Downstream Port memory apertures get redirected.

To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
support, pci_acs_enabled() skips checking for the capability.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 08d45907d73e..6922a5ea5e46 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3527,6 +3527,56 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
+static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
+			return true;
+	}
+
+	return false;
+}
+
+static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
+{
+	struct pci_dev *usp_pdev = pci_upstream_bridge(pdev);
+	u16 mask = PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR;
+
+	/*
+	 * For ACS DSP/USP Memory Target Access Control, either Request
+	 * Redirect or Request Blocking must be enabled to enforce isolation.
+	 * According to PCIe spec 7.0, the DSP Memory Target Access is
+	 * applicable to both Root Ports and Switch Upstream Ports that have
+	 * applicable Memory BAR space to protect. So if the device does not
+	 * have a Memory BAR, it skips the check.
+	 */
+	if (pci_dev_has_memory_bars(pdev) &&
+	    (ctrl & mask) != PCI_ACS_DMAC_RB &&
+	    (ctrl & mask) != PCI_ACS_DMAC_RR)
+		return false;
+
+	mask = PCI_ACS_UMAC_RB | PCI_ACS_UMAC_RR;
+	/*
+	 * The USP Memory Target Access is only applicable to downstream ports
+	 * that have applicable Memory BAR space in the Switch Upstream Port to
+	 * protect. Root Ports, which have usp_pdev set to NULL, will skip the
+	 * check.
+	 */
+	if (usp_pdev && pci_dev_has_memory_bars(usp_pdev) &&
+	    (ctrl & mask) != PCI_ACS_UMAC_RB &&
+	    (ctrl & mask) != PCI_ACS_UMAC_RR)
+		return false;
+
+	/* PCI_ACS_URRC is applicable to Downstream Ports only.  */
+	if (usp_pdev && !(ctrl & PCI_ACS_URRC))
+		return false;
+
+	/* PCI_ACS_IB is applicable to both Root and Downstream Ports. */
+	return !!(ctrl & PCI_ACS_IB);
+}
+
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
@@ -3545,6 +3595,19 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	acs_flags &= (cap | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	if (acs_flags & PCI_ACS_ECAP) {
+		if ((cap & PCI_ACS_ECAP) && !pci_acs_ecap_enabled(pdev, ctrl))
+			return false;
+
+		/*
+		 * The check for the required controls in PCI_ACS_ECAP has
+		 * passed. Clear the ECAP flag and continue to check the
+		 * basic ACS controls.
+		 */
+		acs_flags &= ~PCI_ACS_ECAP;
+	}
+
 	return (ctrl & acs_flags) == acs_flags;
 }
 
@@ -3603,6 +3666,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	case PCI_EXP_TYPE_DOWNSTREAM:
 	case PCI_EXP_TYPE_ROOT_PORT:
+		/* PCI_ACS_ECAP applies to Root and Downstream Ports only */
+		acs_flags |= PCI_ACS_ECAP;
 		return pci_acs_flags_enabled(pdev, acs_flags);
 	/*
 	 * PCIe 3.0, 6.12.1.2 specifies ACS capabilities that should be
-- 
2.51.0

