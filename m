Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012061.outbound.protection.outlook.com [52.103.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCA391849;
	Thu,  3 Sep 2026 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407229; cv=fail; b=PrqrHhoY/hR9VOQnj0GkvdqdB+MPTrkTAzvfIBh1pTv6Lf0uDgOJTIDQEZQ8mYICaWuBd4WkXDHkPgpMdZtXkpDt7pQmk5pX/Cc9+EVLdisM6ywvm83aZZc4AaGfaU0JReGBk6r0hyc9U8yl5WCdTGlMxAaNzemUjhp80lxdh4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407229; c=relaxed/simple;
	bh=z4l9PiU8l/fGrOfxnAoF0MHQI53d7heccoQYZlHPuy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ThLZnBs14RItXHNG9g+BI8I1w7LFBrCqcf5SzmpSZUeWqq5Uyudj9fbJ1xhffCI27ZjGWIIlDLfJbkoPQZkEPdE3n7P5Yg6j4few/1QHhWF0GY02gi92TXLATE7Je03fmPItk9BfyQTU3jiXfh4gug4/AnTYYgOp6FMRHYN583Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=VfHK0jmp; arc=fail smtp.client-ip=52.103.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="VfHK0jmp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdVRCObDzF3fdL4qZDj4Ofesswyq8a2rkY/vmg74SnHacFIuF0F47mr3lLb9iHleKZ8EBr2znak4Cj5RtkwRZu8drRRZiWztKfLAMGNc2TLhr+mfG89VJRr1q7kUsIgaV4nibJqOK2+oLfxD8WcgDRlKsGQ9Xec0BJtASIc34I/XvkskLsVWUrasMwkpXoQYLjRpz3HnxWF/Gck+bgUeed2QQmnYDUYooaz4FWAsDH+kWOYLz1GAtl2E8uAIP+JfoLWIuY3Fs4loKZhVx+H0aNj6QV5yTkrNOhKrByN6U2PxSw3HLicV040huoN+C+TqsM+d6MhL30FRQuFRW65pSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvbSl6oQHz1dzPOo8tg2jh1DAN22fGuUPEJCGOh9IBQ=;
 b=oT+GExJXTiOMykZfFlb/d9AcgtJVriAzER/eI0cutvSgyVjFBRbJIwQRiRw5Wihoma2OEDTijQe+luAHf/cfxRE2fqBNpSyuLggqg5otSXM4oZ8GsF1YOekyhyP3DegbHucwlrna27zSM6uDafpO9NE2Hznfc6x5Pr2DpfK6Ke/54P5yTEnlC12TIk2DmH6oClwFkt16O6OkS0QIMNB/zhzbSNq+hUQhDZ/jpWI98Hpkj0Q81t0TPwVWHlA/VsYj5W9WUSbJXA7DdljJwhP8erf/3hViyqpFKlIXfjobEhh8L1Akz6FjDerf3KJYXQ8JNEBITswit7NNjtPwmjEFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvbSl6oQHz1dzPOo8tg2jh1DAN22fGuUPEJCGOh9IBQ=;
 b=VfHK0jmpox+hOiLlWOXK1t3kRjHvyyOymm60idVflTHg8IXSGOY5tbTKHmoeLnt+q1opwJhfTbTskXTckJGoW8iyQR46MXM2in302HIIppqSiW/Izs3HMAfau2Q4ISV/sRg8CCmw3bkSC6ckfeOKtqJW8orcovNvxad6/fMOe+nD/ABldQS/PoPmUNeXAxTXkHF4XO4DnXw12IsmURke9uuQhQAXFKV4Mi77pPuyNtBtkb5nPKUQXdWOMm2GDlfLLM+66NfFnTTMujpK+4rwypc4rEA+JFNl0pRMMVI0BSwofCMERqmJQvxXbEeixZFip677h5m2daohHD3f3969hg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4278.apcprd01.prod.exchangelabs.com
 (2603:1096:101:41::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 03:46:59 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:46:59 +0000
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
Subject: [PATCH v9 6/6] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Thu,  3 Sep 2026 11:46:18 +0800
Message-ID:
 <SI2PR01MB439314CABFD64FC0586F2FF8DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0092.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::7)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260903034618.1100387-7-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3745ea5c-835e-441b-0e6b-08df096e01d0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|37011999003|23021999003|15080799012|16051099003|45011099003|41001999006|51005399006|25010399006|19110799012|8060799015|5072599009|2607281247196008|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFQA+2ys9DTUdUQuHvd06zJY4Kyq++dEzbUsODY5Oo05/lZ/hel54llNyBCW?=
 =?us-ascii?Q?I5Al0Ia86vG1xca/tAFYXNbMyTmGDmtXWyDhFRVPWFRdiHFLFp9qndbZLS3l?=
 =?us-ascii?Q?pM4EWDNB1+oYcVfOt1lhJ8jt4zVLi+DQqnwGPVv7D/wVj7aE7DeF9WfzkfSA?=
 =?us-ascii?Q?amSpAUmjiTrn3bKtQJD07lrU/cWKSAWLxIBUgvFjwSf6huN0fUBruKDgE1W1?=
 =?us-ascii?Q?kS/LyqW+Ug0l5yKtTTVgLRIVuabPMG4yI7NvS30RAiENd3QhRr1BZlMFQg47?=
 =?us-ascii?Q?B1V+/igLcV6pl0/r89zFrIdPTTXg/AF9ummNjE1n712g5pg+0ACCSTNUd9xv?=
 =?us-ascii?Q?dfDsaXVTj5vCE+B7yj9DnvUmqrKPA1r0P1/vfAv7BPXI8lubbwFHNfOQ3c4C?=
 =?us-ascii?Q?LMc4CVFEcLwyzJTewgH21jkO66BeaF4codAit1ICJbf0hcv8FJQh5LBSXO4e?=
 =?us-ascii?Q?7k8nM11cdY2awfBeMIRI3TCRZXiHnF+qSHqJM8z7nRIjm7Tpmd5IStW0/skH?=
 =?us-ascii?Q?UfC45fQAOgH4CY/nBGKBoQxZBsOOd/54DC+ajPXwO6W3AuCDwyepBy7/H9Bn?=
 =?us-ascii?Q?wFKGjzc/uQ6yrh5VVplU+oEINKDn5ywhpVcZkVG1sZaP3cKhoDtoc1b/CW/8?=
 =?us-ascii?Q?ClmuCkW/KHY0JFStBxs+YHWH5fddO1c2SXJ6Zw5hsD/acdemISXo9erczThR?=
 =?us-ascii?Q?S2r2sO3hvAkLSzRRCW3fT5c/3h2JYPb+dkHYUh0b0kkHYftWGF/Q6drn2xpP?=
 =?us-ascii?Q?BFrIQ2aT8B8qxXVXZqatp5ka60EUcVMpVy9tAloP8HqyMkMM+e8Jc/YUeWO/?=
 =?us-ascii?Q?56kZrEMwYpvS9KdjtiMFFeddl6suqLJXb43OD7iAyP4hNt8nlJjonjEESDqA?=
 =?us-ascii?Q?F2PyM/KnqTp6pUdNyS7/19QlaTRzNOkNul+eAdYOuOMlsJkKw7Ed7+cEgipE?=
 =?us-ascii?Q?2miK0zQ1i/Ob6TwwmGgg01ERFLzIqkHheA1xdKhPBEnnvfDY0yx8HxMjrLl3?=
 =?us-ascii?Q?k3+N9gTofaHg7F/hSSG4oDsB033o0PzlQwx4h8yxqm/6t3YiMCH93997JjQ3?=
 =?us-ascii?Q?rZxUjzD6WB3Jc6/PBvddZVuPdcoy7w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdZYmx8j4n/QtfncWGCHowW2wniHTRrKrEznx1qA8CQo8Clj+zjxkIDtI2Aa?=
 =?us-ascii?Q?GU4c0xJ71pcqx9Ds6fkRqTK+VB9efALa76BVRwwyi0ZEP6R2PHwZPT0AVUVW?=
 =?us-ascii?Q?AStS8EnclWbSOo7PDs1z80rf3upDr1Vz68bNt6JQEgBhJ3UMlcOsSvR6FUVL?=
 =?us-ascii?Q?YHERkM410moPG2brmuiys9mqFKYy0J0vY5kojHN+Muia7BPpn2a30ksuhqnB?=
 =?us-ascii?Q?qWqYCDgkMQz4s28Mi5nfXaMOmnVfVlW+GOVQAhyRQ5yx7nBXQ0LV1IHwKBb2?=
 =?us-ascii?Q?HYN60tfRVD/cukXvuXERxiNWBV5/5y8N5Y33Hnwz7kLIZqsnfjqWklBY7Qlq?=
 =?us-ascii?Q?y6g4Sp8W3BprHUfsWLPiScCMInbQzvsJTBDqp24XESbwdJMLWk3RP1ajuYSl?=
 =?us-ascii?Q?gxLVMSOWaBmYoHCcccDvhizAttpJ12QSTH1dfYNoU/6YzUwkfOU0KJnxp4Eh?=
 =?us-ascii?Q?ASRenHOIiijKMpnyNbQANzDdzTvK0TdaQuGTE03N7sl/KPv+pyoVRptXhSmj?=
 =?us-ascii?Q?mn+wDw7JWsuaRC9p1/Y6GMVRVi3e1hGlI4jTtfHjMgirT091nzGL9cOrKyCP?=
 =?us-ascii?Q?t6fm6pk00IJO7RXjVqbp2RbTjkY8JqcW8NrZr6xb2SKTv9xSnp5nqQOe7SmH?=
 =?us-ascii?Q?ldjgreLKN46CCwGvaR9ZSkJ7Mh4eMhjg+yxggdRJ2A1EsmYNnyY/c8RgKEse?=
 =?us-ascii?Q?mXob2Xnsh/GmLHfGJ0A7elEoHcs3HgCNkrF2Ve5w7e6xMb6g7nt3PMq+/2Qp?=
 =?us-ascii?Q?77nT4B92cOyzFO/qxXYTVg6v2czAU6POluPbOHuW4jQ35VoQtTIWd8iqi1U1?=
 =?us-ascii?Q?DrOxPsZKJPJcfsOsdXc5Z3Xupe9Y7OmZGNAJ9xVvqBa7Bi8Aa9wFeyhd+QVI?=
 =?us-ascii?Q?j8OlB0WBsyE+mKfDhPoyRnmn3VpqtewR3Mw3T9JyrNlshgKtGRRLcozB4Gx/?=
 =?us-ascii?Q?EgY+Y19xER/Ll43dPfJyi6x+2iphpNGV/Mdfxxy5G4XPNDcabgqG/BiZiVbq?=
 =?us-ascii?Q?0Reix5STDs8h0S0U5a0ATnC8ubw5YAf0SryuEoRv1/k7tc6gZEN6WHdsUhvg?=
 =?us-ascii?Q?YFMZnK9SgxeJgUQf+IMA406yUwkH70zbXDn+RGGvkhET4bh26gYBnb+Qqua+?=
 =?us-ascii?Q?7iRLd6xa84gJPKTP8Qr2Pnm/yts5RLvvMQUduRfgmDkc2hokg+9qnAf161rz?=
 =?us-ascii?Q?5ZzNt2uDlmKTTUX6W+8F9kuxKdB1rxGKD/Rw+tqxQWEEUqHt2v0alZZdFB/a?=
 =?us-ascii?Q?MAHpMGn0hQLkZl4Ww+fdei9M8OjoVnPPYhZhpOlPMooAtuc6wCU19vuOiyEd?=
 =?us-ascii?Q?HxNG5x7uMz/QM9XatlgfT06Jsb3v122SMM4KrO7PbtRnrbKKz5ofYMcf7LEM?=
 =?us-ascii?Q?r/DFxtGVQbp3ATjqY2KIgTEAA6i3?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3745ea5c-835e-441b-0e6b-08df096e01d0
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:46:59.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4278

The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
isolation. On devices that support the PCI_ACS_ECAP capability, the
controls are required to be enabled properly:
- ACS I/O Request Blocking needs to be enabled to avoid unintended
  upstream I/O requests.
- ACS DSP and USP Memory Target Access Control needs to be set with
  Request Redirect or Request Blocking to ensure the Downstream and
  Upstream Port memory resource ranges are not accessed by upstream
  memory requests.
- ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
  areas that lies within a Switch's Upstream Port memory apertures but not
  within any Downstream Port memory apertures get redirected.

To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
support, pci_acs_enabled() skips checking for the capability.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 50a3b61f9898..b951195d5adc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3648,6 +3648,57 @@ void pci_configure_ari(struct pci_dev *dev)
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
+	struct pci_dev *upstream_pdev;
+
+	/*
+	 * For ACS DSP/USP Memory Target Access Control, either Request
+	 * Redirect or Request Blocking must be enabled to enforce isolation.
+	 * According to PCIe spec 7.0, the DSP Memory Target Access is
+	 * applicable to both Root Ports and Switch Downstream Ports that have
+	 * applicable Memory BAR space to protect. So if the device does not
+	 * have a Memory BAR, it skips the check.
+	 */
+	if (pci_dev_has_memory_bars(pdev) &&
+	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
+	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
+		return false;
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
+		upstream_pdev = pci_upstream_bridge(pdev);
+
+		/*
+		 * The USP Memory Target Access is only applicable to
+		 * downstream ports that have applicable Memory BAR space in
+		 * the Switch Upstream Port to protect.
+		 */
+		if (upstream_pdev && pci_dev_has_memory_bars(upstream_pdev) &&
+		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
+		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
+			return false;
+
+		/* PCI_ACS_URRC is applicable to Downstream Ports only. */
+		if (!(ctrl & PCI_ACS_URRC))
+			return false;
+	}
+
+	/* PCI_ACS_IB is applicable to both Root and Downstream Ports. */
+	return !!(ctrl & PCI_ACS_IB);
+}
+
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
@@ -3665,6 +3716,18 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	if (acs_flags & PCI_ACS_ECAP) {
+		if (!pci_acs_ecap_enabled(pdev, ctrl))
+			return false;
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
 
@@ -3723,6 +3786,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
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

