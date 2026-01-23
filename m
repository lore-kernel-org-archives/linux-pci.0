Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013073.outbound.protection.outlook.com [52.103.43.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BB31A570;
	Fri, 23 Jan 2026 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769133072; cv=fail; b=dHvjwPMXSGUU0GqaWD96uObJBcTvLNnHinWoGb0Mk/NRXnqoZ3tZ+7NeA1XD/jcJqH9rkRxt+HPhnKJjHssBHx5rRyWbas9ADDTA4UTMeqVZNLDBdnVEbgXkpOKcx0+Moasc/2QaV1+Y/P8MHROLTqPCIOEIR71c2HRurDgqc44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769133072; c=relaxed/simple;
	bh=2bQ8Y8atSTfjx9kr8opeoYwMt1QnSbmz4YKUr4oY3dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkY6WarjzzAjd2jX23V7OEdRl/siIgkkjC2Wpb8k1IiIozEkro057Shl3uQmPE8iMWeCgJdiAE5xKOASaGWNwNPTq40gxWt3dxqZGyhDqagPSxWUvu1zXJe+ziPjUP3jezTOHyvfgog04RuWHKUOfpY8o4i/Ltyi5rYpp7JYRKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=KH+LHvbH; arc=fail smtp.client-ip=52.103.43.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="KH+LHvbH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj0eAVlfE/9xTzXg664FLpI2yaSekRy/PSNRBHMdOkUdm80wpghJXBD8EQ5v98VW0Fi8587NvxtYAZ4hOCa47Ci3eEPVaZAoJ1ivkZec463OOPoE12/2/re3xBSsF+3vF894IYdY/WGLgDSsjfgKHoilzdFfdwCcf70NslQ8xUr/NH2qvpesIhmTu7DXwQkIIOxJozu5aEt+qZUd+p6fqtQAQj7678/zzD++dNrmtis2Mi3lC38LEkMtIe6QWoKYxscI39bz4eONsp0tSSanQmvQDCgjF2b42npNdOkVOy3KbaBq26TyyzXInZSJc0ZESVVLat27iAIYrBkfuK1bww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDhgI8w9uLo7FLEPxBdLXQ4dCXT8Om7tMZ4CD1KV3Mw=;
 b=Lmjjv2pXNl9g2Zu65inVBJHxLMRCYOro/cIEXEad/g7VY4rrBOF8445OitmT8ok4fj6XKnkQS+gUDQ/zSgeev41pO7zy+t9CApU6QaJHusLd1ahPKjHmvUgURK+xYZuON4YhC5dLTmszqFyokq7sdloMMWxUcxbiGM6wo6Y4+mZY020qdt/6TxWZ1rOZ07Ro1S0sQ/OIiphHKWWFisSVRZM8vvo2TRrsND39xW8GlqCgmtTnJmqAOuylJ6Vip+iyXMqO9/bNEX0JHahdkz5vX1NJOflvbLZR4auEi+q6nSr9J9ol/QdSQ+snE/Q2SKGYE5onmuv3VudXJo5ZBDod+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDhgI8w9uLo7FLEPxBdLXQ4dCXT8Om7tMZ4CD1KV3Mw=;
 b=KH+LHvbHD98D9Yu5hxGJwIbuVExCm3ZR3cXDJuY8mY3DPxOocLJWEiT1vVrbaVue+whac4waAIACiAHXatpfms/rPOJJveus79BHtIP+A0YCi86K0JWXiIE2OAxkxIgOTJmyX4P5imTgcli6ARyuOjQ7v6HlYiyGcxV4nQ8cwf8/aRc6KhJU+aCE+up1r1nlAOkZrI/JLwbT1tJUz3U10WxJb/lkG8hOP2ClVjpFY0I5fpO+NbM8KmHVbZoOKIm3dhafGkL+ILAVFWdS4BXVgTz0Zs6ogeJxJP6DsUeNa4s1dOppmJIFqPeZ6ftEESJZoswk6o+wEweH+A1yr4xLeA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by KL1PR01MB5198.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 01:49:59 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 01:49:59 +0000
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
Subject: [PATCH v2 2/2] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Fri, 23 Jan 2026 09:49:43 +0800
Message-ID:
 <SI2PR01MB4393ADC9C367C4A6F8032A02DC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260123014943.1311157-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|KL1PR01MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcc6995-c4e1-47f4-3710-08de5a21b75a
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6S8iGWZPkMuZxiie1xMlelLcRo0+hr/PtlX0BqzpJSQAeixAu4TOLyPJspJAcl/lnRkydOfuumjrusnT05Xz8FNw7wZJg80S0HJ/3tbTfHgoLyuJ2fmN1PWpTlzVOWMv04KeasmDK6/oPqO/PwikQwzXDnFWUNTMLzen/Fq9OFRWTAK/03DVDOap4nHn97d4IVCf59mf7sP8cT2doWFiTjNte9uEp5YDlxMKZ8IPMKpshnhFxBbgwo4IOuYrSsxRFYYyw0RioGyMbWBRoz/zYhGI3e9t5gqc5V6VR0JHPgwvQI/Zw4D07ShAuwQNLTMGVQ/G3mEqu+46InRVbtM1DvfhJiRBcLOTZDWL0bLw7+bkU1k+wMIFkXgtxxumTK2j/YONdAa1XAvF4To2NkplSXpZt8RjBKV7BvokUNw4p6Shd3Hi7X/p8OtaN8xo07y7rIn0ubpJ5mANDpeKPfxcM3Ckcd0h7Mu4fEwF1KEhYar6jgNbW8koNLTLVWXPpNaRX7h8qlPrXwJFdB1HXR+FUx9QHSsuP1kdoTSaYigJzipOXEbYqPxxyYagW0k2/fH+kTMxDA181UJkpUKi4l46709wWS2wBTKmrb//XH23reKS5Ncertz6tiwQmX2p5VSHAJwwXDxe+Ok+bp0J45Cu9HDQAzYPIWmok2JBH6zf4kxlDh/LrDlv+1kV1s6P1KZvUuwbdLFEQXteP1DbrsVfW68YO8QXBTf1FTzkyUkCPmi8I=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|37102599003|8060799015|12121999013|51005399006|461199028|15080799012|5072599009|23021999003|41001999006|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbhuY/+qXr8luzCpQKi/+ZAl+CToTC1sSVfCYbr5ScPz5VmVHeYnNl9rvjle?=
 =?us-ascii?Q?IzTDR0iXf7TqBuEcBcCBQkI35G/3eQDQ6HZZ6CJG8HCC8QuXoMoHTTVRc8x5?=
 =?us-ascii?Q?ijI6W6AwH0Wns1Wt1My8gouYgi/HD0Z+RJnKjlebs5UYodfPsHVYqKZEhYVq?=
 =?us-ascii?Q?MILY9xha5m1R0GZCLt/spyudhem97CQxZKJYLV3Jk/uXhjx0cKVWNisZNLg3?=
 =?us-ascii?Q?3QKDlX6A6R3bD67MeZ7i5sIcMNNYIPFjkCeIlxPi+E90VF6vIi8XPSfYKXrk?=
 =?us-ascii?Q?miZrqN2HID8ihO+rDRfMQRh2TS5exk42ekJWiIs/qfFU8ois0Pdgrk5tnYgb?=
 =?us-ascii?Q?Nnt+zhtuDAUhpoxobYQPJfclXu+KKJDokS9sk6dZxQ5wNMgh4fiwWTZspIhx?=
 =?us-ascii?Q?/H/sOchTv4X36JeUZmnv8OOIZ0x4RW15Wrt/jJ0YsNBFI7C+rjmBM6p3H2s0?=
 =?us-ascii?Q?owum6c+Vc+PFaNgNrnBpCBoXBby3UQorZVZTFgVQ9SJCesFIsbme8IHx0mMl?=
 =?us-ascii?Q?GATlNzshHy/MhcuzuWbtLhTmMrE+hdCtzu8WeFtNlKqLNkoBWWlL1ENBKOom?=
 =?us-ascii?Q?3DzIaF0bSQtd9ZURcxX5J21Ci9ncNiy4pd/SNtNVOV8CZ+lOt1KXRdTEIXFq?=
 =?us-ascii?Q?zaKTgbQZV8qnCVdfkk9WotFt77pLzpkH2J3b605NSXaerijHewsNCFMqP+ZF?=
 =?us-ascii?Q?ngHbVdTNItQzMsFZr8kFTQKaaRKBa6/qNwJM1zyvCY9j1Lq+/T+PHKonZMAS?=
 =?us-ascii?Q?d70zvcHLxDNmqKJZrLTU0nSkfYwjVQuTMEK72XY4jeDzBuXYbk7t3oZpbX10?=
 =?us-ascii?Q?Nw2TDsOnzY3jqwSFIR0p+wq6zi82SMWwZWYlqW32YayLv80X/g8Jhipctft9?=
 =?us-ascii?Q?TLCfAdbpej5GfdKf0dPzZ1Ajmv5mPY71V021bVrzWwTY42SlQKrOp94kO/nf?=
 =?us-ascii?Q?uTjH89b5SkoolGwtN4qppvVid+Me+5twOtGk2iFBbtjG/YlKOfhBrtFr+GNL?=
 =?us-ascii?Q?DDMzQEbEPL+3Gk0OxoLNFcyZqs7TQJg5/a+kJD6XE2tne7l5gszK1FAi8pb2?=
 =?us-ascii?Q?SdmmnXOC1PcrS87bEWF6jmAiF7J299YlaqpM8Ad683+4kMRrx5OHJXR/udPM?=
 =?us-ascii?Q?g0u6CJtS5sMoc7fR0K4PC9ZPciwzOZdVNxpxjhJyaK14m0EmZaCdlGxc8Mvk?=
 =?us-ascii?Q?BDRpSaqUJT6DEgR78YNJe+29usAOGg3t7G0vTZAYYsfm13BwJ+ybtcvxp9hH?=
 =?us-ascii?Q?SsAHaIcInImd6M6n4aGIGtGGRQi1tHGBAxeB8ugUJwFqVGIF77biMZFK+YL+?=
 =?us-ascii?Q?x7M=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0FiLpC+lsHYJJfWkiVb7euLaLaE0wYgG6x/44tCG2Mhm1homRZEU1YYyEccX?=
 =?us-ascii?Q?0LgJO4V6xEXZ9kF7dYQCQZWxcGdkES+f60zSmQi1KKsPMBPY4knuifzaC4iy?=
 =?us-ascii?Q?veYdWAvyKqc8lT1I68O7XdCpN2OZFAS/X2HdVy6cDNJxFlThM6jGNgKavQ0F?=
 =?us-ascii?Q?1LbP4TCsB0V5tIxFTFyA029lp0SyJX36BdP99bfO7lfYJLTSG0aiS7VCi1Yb?=
 =?us-ascii?Q?cZvys47S3HnI/gx4MuMaoCV1qoi0152Tte4iNmCCzDnpknYPzQjRUoTZuynB?=
 =?us-ascii?Q?rA9KXMqKIch9yUotY+gv6CuBRLPOAf3UTDuNNQDRnNBQYFF7VnJ8iuFFo3Jx?=
 =?us-ascii?Q?yEtXCf3HM6K8nekTGjXjjctAbi93rwee/gkgxcpgGW4bMPeZgU6m/O1HkIXF?=
 =?us-ascii?Q?Fci0VlFtiB4f4kgUHXiNyPIyY1PRljXcolU3IyiCK2ptOGMUcZaWHPQ0lHYb?=
 =?us-ascii?Q?yVex/roZVvuZ4fOgZe9DyKieABS9d0YWx6v2movJEEVqosiHWFvzaUJ9ABG+?=
 =?us-ascii?Q?LN5Hp14Ed03tUbpR8pgTx6Azz/OU5bI2R69wlEaJEYOiPCcHgHZnkOwW+KcA?=
 =?us-ascii?Q?NK0qDtEcjBm2hQaoYDzD6IfIMsew95OAOOd9TqSJLaiPnzZZgdFDmQ7KImj1?=
 =?us-ascii?Q?JqvwZRHfV1bS5Ax1FsAgDfZ4JpfoCSr3XClGN93rXvtcU1DSCAGVan93il1C?=
 =?us-ascii?Q?mxGSIZhzJv4rNuXQlngCNdBqBpT55Vwz91/5bxIlRvwwJUawbDjgEWiG0AuC?=
 =?us-ascii?Q?RNUHnq+O93dMUR0Uxuq/HplwK4seyMmT0ZT+k96lVlWPwWotblZDLW/TGg+E?=
 =?us-ascii?Q?LR7OYXYidG5Zs5oCtyJzA8KgARas+mlwqzUBEktGPFWDcD5/uC8F832TboSb?=
 =?us-ascii?Q?Un1zloKkSQ32V9wxghdItQp2+YaDRY9KV0W+Myxc/d4Gg1dJYC4fRpJzjVRj?=
 =?us-ascii?Q?dSht3CgJwudrH2AHauwPHSsDNQ5dvXYy/glz3aj4JEuEallJ+iseacWlhT0W?=
 =?us-ascii?Q?9ptk+fXsHrpY32Fb+H+8OcHI1cn9skyheF068i/ZXAJOWe1pVIvfzUbNkYgF?=
 =?us-ascii?Q?3ZBk+l77zJv3fM/vkku8H63CDLOyYQBX8xDo3cSnO26mTSYdIljDfielcobx?=
 =?us-ascii?Q?nRaROo5TPtWHmrS9biVyR1Mr5Jcg3DYeCSOEgcsLSQfL5Mo2KT+nZSDcaFAZ?=
 =?us-ascii?Q?gdn2ZmewKT9/pvuLFUHnakN74yB7aIcI8YfVi70onsfdLuakFZT2t42uLIgm?=
 =?us-ascii?Q?+2g3mospOCVvrpB5972ocE9CdE17HzEvtLusYsY9il0gS7QRkdWsfN/c4juK?=
 =?us-ascii?Q?nEWvshXth/O8bcPHFv54EXs7/g2tCGwo1AAihrfsRjH69OTmkWh8NUp1ftZ/?=
 =?us-ascii?Q?0V8Lve6/Dsw8TziW4lnRWQ5j4Gp0?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcc6995-c4e1-47f4-3710-08de5a21b75a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:49:59.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5198

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
support, pci_acs_enabled() skips checking for the capability and logs a
warning to indicate that isolation may be incomplete.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c4cf835ec8ba..ff974ced90aa 100644
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
+	 * According to PCIe spec 6.2, the DSP Memory Target Access is
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
@@ -3545,6 +3595,21 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	acs_flags &= (cap | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	if (acs_flags & PCI_ACS_ECAP) {
+		if (!(cap & PCI_ACS_ECAP))
+			pci_warn(pdev, "device doesn't support ACS_ECAP\n");
+		else if (!pci_acs_ecap_enabled(pdev, ctrl))
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
 
@@ -3603,6 +3668,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	case PCI_EXP_TYPE_DOWNSTREAM:
 	case PCI_EXP_TYPE_ROOT_PORT:
+		/* PCI_ACS_ECAP applies to Root and Downstream ports only */
+		acs_flags |= PCI_ACS_ECAP;
 		return pci_acs_flags_enabled(pdev, acs_flags);
 	/*
 	 * PCIe 3.0, 6.12.1.2 specifies ACS capabilities that should be
-- 
2.51.0

