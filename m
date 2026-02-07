Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012051.outbound.protection.outlook.com [52.103.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616AC37E31B;
	Mon,  9 Feb 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649390; cv=fail; b=BDniFcQLd1SYtovgsUrLNgxai87tSDT4Vus8IIuOqmtj3hUyFwCMXtQ2R9wPVb0guH0suxTGhnENnCASmv2YbEzq3pbhMEfPIrx39qvpkpXaDq8XzI+5HlqS2Ria77vyy5uCU2yd3WTwYAWmIjIrGVAFeYmTgEZDuuO0w73BiSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649390; c=relaxed/simple;
	bh=ZQDbgr7o70785llCfp76soVo2I2tLNfZTI9K5tjiGmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bvKXpdAqYxOZ7fPoBJvqHDPvWpB0GgsLmpmKQAWs/M8puyfSrGKtgIIYKdSPr6q+Ti9BIwJsNED6q5SgcvXwneni1ixrCI1uHgHOajmbaEfFAsv+bp4ihEHuvjeBmP7AsAeuQAxyI2QIvfTsrmFidP18sUdRcidIv+5BSGFS0fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=fQ6smgBR; arc=fail smtp.client-ip=52.103.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="fQ6smgBR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6MYWPSLZJUudYkROKVi6eKoLZ/xDYl6w4sEiVCScYF9qjDWp2mYo5HM9JByWP+Dkscs2x+P+QfBZPfpnyazVDm8GlskRxfP+H8nEEQesayR24eEgGH8F3799/FSj+BBGi/XZRETfyFqub9oxk9/Ha1e9C/eHGCYZCYsqTB65Rj9mhs3U3/s7Ccq+k0EdUPNvIPUWkLC2QPSspfAzATnrDG+xpQ0hiBI3fkZQbTiOSi9qeR3dfhtFr4po90DbpnznqTVhdxbcjNtO/fPVlJcHnb530NVsGu6l9aD/NH01fkR2HPDWqxJdKuXJqf8nw3Kag34mcsI+gtEt1T7uOuBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t7VfJe0CJNSe4wyMOqniReGvnTJ6sa4Y/pJPBUKIE4=;
 b=UxL1HL4VtXYU1mgxlTBh0cAuafh74so9ud50RTxpWs6xFIOFy8ivljdRHnrOFmYo361DW4W3DG6qyqvkhc+x+z+OOPC3sd2kznAo1YT+HbLIk3rYQr47+gRfw1U6GmRpTBQH8plAMeqMARLplrkL2E1aM4VU3cwPGgnDcULjqQA6ChwGCGaWtgjuS1gd3YZr+B6VTxRjBZFR2x/HRAjLBrWrJYklpjVLXIlfAhnUdv1xZSJdXuKpM3GksHdHm8ie+RBCpGZFszhGM6w4EAQGU+r8fOP64IcrbTre1DY8m37b3yu19w0s34h9cArA47+BLQnA1gydN9nvSM1AxvrG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t7VfJe0CJNSe4wyMOqniReGvnTJ6sa4Y/pJPBUKIE4=;
 b=fQ6smgBRFMbVwJb+W6GzIQuVNrdPjlQ/jrEVkngjwBd7wWLnCAqVuRrCtj/bWc3Klc2bltvl0bjwrrfVV5L/kiR0mlsvjR3lGtlMjJbft/908nc7NOSYd5zSSG3jxHBmjpWjgC0/pbNsuwc9sp9Qenp1H1Y6qrXYYL4JkpTPy6fBJqj0peVTT3uUqUTP6lPcZKspaxCEJ/n1DYgorC6ANTQrKUqlJtS4+S5sKuGwZO7AQ/z97n86CH1DNbNci4xkVR7OQKc73Wz6tqnTCBGqMQoiBp/W9Gn1NJMy8wd0YHDwnXwW+3TTAYVrSuUHtdT+/GXNMW5+p3ZaY0b9nCrgZg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4945.apcprd01.prod.exchangelabs.com
 (2603:1096:101:9c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 15:03:06 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 15:03:06 +0000
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
Subject: [PATCH v4 2/2] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Sat,  7 Feb 2026 19:30:59 +0800
Message-ID:
 <SI2PR01MB43931402377765D5DEA04ED3DC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:405:3::27) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260207113059.335295-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f404d7f-9e1e-4e82-d504-08de67ec54a3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799012|15080799012|23021999003|41001999006|8060799015|37102599003|5072599009|12121999013|51005399006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9tf3BCoHVbIcEl1IQW2Jax5lQ8/qVxy4G1gu1NONtZF7Uh7JxkkrLTxHCYml?=
 =?us-ascii?Q?3CJsrf2Hby90RVoOPvf4hYOaNCy7MrEL+XAnJUXqV32ewFeBVQ/P6hoUXHvT?=
 =?us-ascii?Q?Gt0zq3SSGYpmLucDOjuBhXjkICCELnmWyi8H+5Z9zT+QYJ/uR3xVpJj5mfIR?=
 =?us-ascii?Q?lb7Md0IOnfIDR5dH/TiRZ9wLQOjXir4Ro3jjqtyKC5XcgqZTeh4WMoN8er61?=
 =?us-ascii?Q?xUOYa3bW+9OcOt1qacGxlhRpcsOcfzmnote/Rnp55vlF5JjwJyDfiYODNx6d?=
 =?us-ascii?Q?B5mtgH4SIN1RWnLaxjLxDbnlcd9gvkmXDANByMDsIcm3RL/wBPUETRTl6aFx?=
 =?us-ascii?Q?x/xOtOycVbQr3lrsX4eVWgR13CYgjlaNxQlS/uzqTGVsp2t9MoKT0zV1roHL?=
 =?us-ascii?Q?wdlxoYSCq9jpH4zfqYP95ZNPF1rvTb4Sv1jpbMqTlEBcEkm1dv8iGdDvT3fz?=
 =?us-ascii?Q?oSPd/p64SZqg+bgyPaBPe17gev7qzOLYTOJBhRdHYyrz/Gqsodd7U7BDA/Yg?=
 =?us-ascii?Q?Tni0lb3+PG0VCZZsz1+EO/Ev86aavFkAYqZ/vsFI+4xnNakHzCB18gGWBixD?=
 =?us-ascii?Q?cH6Rpyx+NXHdWFJLk8eum64NYjd388T0OENQ4iZxoZLY3fvfSH8ph5p9wXHy?=
 =?us-ascii?Q?e7J4W4fUxTb7DDKEERHWb16VzHBahzlIyuLje9T5KbFkRl2pfh5u6LZDtDH0?=
 =?us-ascii?Q?VyDcT6W+lZTifvGfldpN39b8La/ETf/5QYx9rrStjtJY+o4jWZ/nO7oTb3cG?=
 =?us-ascii?Q?816qWKb4Nf1KARdmU0MD9XO2mxbcZN0hZT8IDeesdFJAl5a/CWfCC4MbhQit?=
 =?us-ascii?Q?nHPaD1uA4OkcKtd7Ph1cNkBYzczJ4F+7fcCkYWO0cBArlan2viL1wDPq4vFn?=
 =?us-ascii?Q?sqf2rqOTjRdvzDrvJjDVpp0iZHMrRpopMUGlTD0UYf0/wWoYGncc0FmWW2Ls?=
 =?us-ascii?Q?U65bo1h4CNhREnDueH3ozX6M5oo+bXSUDMf+eie9k4lnetkhKT3Z5gEDOqSq?=
 =?us-ascii?Q?Tg19Cntw8m1a89uDn6GwAWSyKuXGuatpuiLeBwyjCTHqEbEzU6v+iTseTeiN?=
 =?us-ascii?Q?h3seaglFPxE2SteRiupVoHs0sqyy5rblCAjZF05LA2kINjmJKqMDoyYEQa63?=
 =?us-ascii?Q?nO2lkxLzRcAKXjtsAZvCDKwcxBpJQ6kFQEtorFnXuwEYmrXFKJVxCg7u6wkV?=
 =?us-ascii?Q?rmcpzSlB7JMy9XPpmgfjL+n5ZLP4FdaiMKYf+29Zg/VZ62pquP0OwZZg48uG?=
 =?us-ascii?Q?xfhtUN/b20WdUlMydudPkovyHS/HZzR0tkW7QbOpGYDy0itCaPNmKh6kOGOa?=
 =?us-ascii?Q?tXw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qnb3dZpsdk7C0MyoB5nEvuI/J+D9ql+I1jFnRYoSqi69qblMg+a3fCcERSRO?=
 =?us-ascii?Q?NvgSDR2bG4VZVh5tOqVqFwshrROWL9qlm1mnvhQXcH0rym4qvS6OjpdGJ5Ma?=
 =?us-ascii?Q?6/QLHnwAU1RupZQoCWkeK59GlfoejAw3U0RMTM6qNDLBQlDDGHllNqdlHi5d?=
 =?us-ascii?Q?GBh5i8hvM/RhSTyXHyF82kLm+5VNpkSnSpbZetbyk7TTMFiE+MPGcpYh1wJi?=
 =?us-ascii?Q?PW6bk4Wy2HPt75wreUOalTgG5TZ5/c1tIfeKOx8FmoO5qUAsexNl/T1Hz2gc?=
 =?us-ascii?Q?/TdfsdQ2AqczZ5xcAUkjsMIFbiINNEQ6TxMtoPy8Zsdejt16g/ScTXqhUCDr?=
 =?us-ascii?Q?AcYlFvVmokkZhBXzfz3S6LU7zJKQLsBwfmKt1Zdr6utCwj0DtDO7JrCD91mc?=
 =?us-ascii?Q?U59uEZhe8T72OlIkUdciVZFLUEPT59F/7l0IMCPvjSqRUpX1GWsMT0o3D0qy?=
 =?us-ascii?Q?mvaegfv44GTAmNKQmpgSlUoucJ2iqDVeSgChq+o1SOJk73qd8aXj8z7LeTEV?=
 =?us-ascii?Q?S8hWZUAQ5JKTwcSKVQhvYpAkFYsi/nnHle5umYwgeYpaXAXUj7zZSoA8IVkb?=
 =?us-ascii?Q?NUu5XqZz4UV7JD4jArYkC8vy3LSus2lsm/0xbUWtH01A2g/RmAzScYrdm4/1?=
 =?us-ascii?Q?Y+kiJ1Dk0kutL/bCrPhTjAA23f1cmjIgJgX6EsrU1Su/R5XFF2rTTFQKVACQ?=
 =?us-ascii?Q?Eg32xxISjPC/pcdJ8laGtx9L6FdleA6vsws6mv54Kt6ncKtUVcJG4xl0waRS?=
 =?us-ascii?Q?s/dfkSYGoIdaVN2s0F961TIxBUrX/SfYHrPZkZixzVqbul0QvxF55L06XwEI?=
 =?us-ascii?Q?j0fJqSNzdA2z3t/sn9wsza3viBpOQaiVzmEiu49VTlF5TTG2JW2wkxXduUnC?=
 =?us-ascii?Q?x5S3iqqDwxUpodtRW+4NRm1S8wHE62EPxqNEuHTwILOzEP0XrswXyWUB5IyL?=
 =?us-ascii?Q?nZCf8vtC4wbuFIe0WKn/BPUz6s/EgMkRQofwWpSEEqXifR/mvKuGfksCVhUk?=
 =?us-ascii?Q?hx/qWZcMblUirvuEwcZ6e03fqGsOsYzMVqeA60puDTRRL5dNiU68u+uAhxwP?=
 =?us-ascii?Q?tULeQi4xEZkKs5xp2e998qDw0BFpjAeIN/jDe8QiGkSht9qOtFQoLQVcBUR9?=
 =?us-ascii?Q?Mczp+xoriZUdg8lKRnIV8wr+uroPEfbSwR8liU9a4tzlG3cYS0kMsTSX169w?=
 =?us-ascii?Q?y/x19NqU33x7LNCiTBiBQhJgOLXZjtAKomfm0ojZVTz5IBxIbPOShM7eSOZl?=
 =?us-ascii?Q?f/SPFbFjjtYkxU8oaz1lBTiNC3o8bTv4KzyXiVzuVyCS3DKd0yxoCrmaGgKK?=
 =?us-ascii?Q?u9ygZLpMEi+CtDWLEkYOFf876aJ9W5SK75h/bKLEFJToWtDNtrHgsVPfW2lP?=
 =?us-ascii?Q?RVAIxmHXq4Ejz/NpMAu9Ree4Lwwv?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f404d7f-9e1e-4e82-d504-08de67ec54a3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:03:06.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4945

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
---
 drivers/pci/pci.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1714e29ce099..53e79948b4ea 100644
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
+	bool is_dsp = pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM;
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
+	 * protect.
+	 */
+	if (is_dsp && pci_dev_has_memory_bars(usp_pdev) &&
+	    (ctrl & mask) != PCI_ACS_UMAC_RB &&
+	    (ctrl & mask) != PCI_ACS_UMAC_RR)
+		return false;
+
+	/* PCI_ACS_URRC is applicable to Downstream Ports only.  */
+	if (is_dsp && !(ctrl & PCI_ACS_URRC))
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

