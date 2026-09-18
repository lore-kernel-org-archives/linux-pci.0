Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020136.outbound.protection.outlook.com [52.101.229.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C041C2E0;
	Fri, 18 Sep 2026 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701658; cv=fail; b=iA2hc3j9spV1obKUp+YJnQs/bFC0m84drk+dprdp4gcLGuwOb7GTzD+MXUniBIqnKaEP9/RdQex8m9jbS/p8//0nHn3jeM8Zh5HdM1vO4+2fDkhl+2fhftNNPzPhoY7456dYWJJwG7ib10M/M1WiAf1iy1m7OR25gV9+pHqKfSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701658; c=relaxed/simple;
	bh=VEnBDjHKve81G9hZp70KDtnkHVZ+6I0V2MOIhAN6Ono=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2vhEyKFtaOnYY5ACPo83OwYGLPwBYicsGdNyyuV4AWo8P1ul896e5O7lNhKky4sqgX8J0zlJTppSFLx3MKOmdeMFZrro0ZVI/YWUw14xnUP2OReXxeuJ7YshzY+yt8fMEXcOY+bc+XeJIn+OUwWfLIzJ/kwgZLzRs343fC231M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CMlpStow; arc=fail smtp.client-ip=52.101.229.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CMlpStow"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FexWWOcjdQsd7g/B6Mu8Uk2LNr2aS7dfIvNYZFW/MZ/JaFrFHrBCKkCM4L/vBpZj2g9eN92JnPX71SqFOGKr5lSkFHcTpo/RoGBoF6852+AbTawN0s1xfjjTUIQLJc52ElwmC+cXRXVgj3DFQt404LvxtcWgO/ooyH6fRaUHUjWxwi7/a7V8ZKoSwlnlGg+NiUT+vjdcLf/83LG42elsKGGD6Yf1ctrp7ndoWLA/OQ72gnEw71jR6ErU+9CPgxOeX25T+jLuKVeVJ6x035ms9Hs8/eENRv+aoL+i+UOiUDoKlVeiU7mhWsBu3tWl0x2CBJBRM84rnCD4IzEbth7c6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LawNhOLWrBYXhuV6Y+YAZyoiHEy8gpbIq0jKorU+t64=;
 b=nGErxN9Yxk+rldwtXvksIfJWWoXdDKQUlqisM8HQM1+iJwbz5anhhiubTWOYW/5kGCWhxN6WawtesJxz1JyBRiCSw9//d+LWj3tYoe/hjgkYOpHHZkHSFb07YJRLNZIR5r3VSj/hYlZVHZg0UHsJ7+fUgttfoRlxiPZn2nxaBLGwPjWNJCCI930Ycgl1fyGaFGiIkVAlGyjlvcx+wVx/Yv141XYWkERw/jy3vCjt8cOUHXL+ZhiwccN2UkWtpffeDeRkAww3wmpdpdta3/wvyBDT0742r6GFX+6iMhzxz2wiVzrFFhIkeUwcqyknkI9dZtkqjWgMBKp39l4SuA4kAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LawNhOLWrBYXhuV6Y+YAZyoiHEy8gpbIq0jKorU+t64=;
 b=CMlpStowBOOSTmjuAzir47+17FupVhqrFDq/iM9pzG0X82X9I8TbpJhR+e2F7yyzE1pC9qmzBUYG9OnAG7Tr/tg98zjC8AHKPS2+2bMDzt00Yq12orcpTvY2ILa4MwssBftStJoVXNtaGjdZBQPa69EpJOszjfJnconi/JC3+J0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:50 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:50 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] PCI: dwc: Let glue drivers hide the Root Port MSI capabilities
Date: Fri, 18 Sep 2026 12:20:35 +0900
Message-ID: <20260918032038.2216471-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: d5aeed9d-b1c7-43aa-9c47-08df1533d6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|6133799003|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	E1Ps4RKdRSJbEJhwjO+DFrHruafgES3uxgwoSx1C9KOURLo9p42YrjpNBCJ74Lt/D77f7IpOOHnPDDVxh6SDPhlCxym3OIoe53Wb7VwkVVxEoziT9ZmBM8NgAyuPAT6VrF496UeFy9KoImS6rPFgBv6MeciCVQOaUWl9P8Ex02hSYvfC6QFP/Dtj7Dh5vOXoS6YGXNH0ZiuuK3gXF+fuQgO7jSO0huXrt2Rqb85bRZscvd7EjLqGt9I3Wx2PnS9yrf2mmifvgkXBZkICt6MEmeC3cddx4qxm+BEQ428Va7NbzG+kBqnf5dEl3DfHvX/iVz7seFj+8pt4y0t6aolQvpZ3KYamtjajs9Fjkm7cJ0Tngr5mf/+725ia8vdB22YLyD8LYRtzoBwDm+2GVBU7fty5qHqp0XYQGsI8C/SmBpV4aeLPhRwfiPHw5zf8vQk9j6d8d+RlVno3ueODofB/Nt+nU6vHRECMRIEw3Fba69rHR2NiTHn2mqahm1+6jxMHK+g12hwFLUaGMbSYH6WZMaRb1no6CGgKlBnFXcrY/ru/RKgewC71CnRdJ+3UGU20tv+P3j75T9Um5Lj1nBhK54YtVRMRohfTiqzAtVvWuEZ2Xy/h4cGmU9+Vy3qwygRkqo9TMEbqF1h3rCtRAu2Xkr0l6mc/49f0GadDDw6OTadC5u3SuHBd1N/8opB3PqUpTkqUhk19ylsS7YfJRGwUEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?waQ3VYFpAR52zQ5DeKV1owsK4AR2mTvuE/wDSoqXLO4cIkAZKW21+8NrPAwQ?=
 =?us-ascii?Q?iE2XzbG+cODEOzMorXzip3Dxe6IZQzjD0Fqm5UhyqKi9NCUH2mHkco27bQQS?=
 =?us-ascii?Q?SPE0/EiBl8jCtgct/asuIaJ7okEsHa/GvsvnRjLFR+srC6WwYhM+EeEFnz5T?=
 =?us-ascii?Q?eEDD26DvxZEp4YgD845UmEIDZZRcpEdNnSz3jAbAOXzQ7S3xK0xXTy9lfupG?=
 =?us-ascii?Q?CQeo/EL5zFUJU5BsmiRbHQeUafur59sXswInFd0oWm7pz8PsdegpuOb9Tsz0?=
 =?us-ascii?Q?4AQzAB103CdRM44anARB3QSAUaX/61zh4wFEScROBFJRqpJ4IvRjGjufhGTP?=
 =?us-ascii?Q?3gBP/7X94yk92F75HtLPl6k7pv60EWyGHiDj8GJVlstCJ2tD4vybea2B7p/v?=
 =?us-ascii?Q?Js7IXjCwu9zajMiL+h17nITfcTJIlQvnzmYDUOSnrtgYLK3Mmcc3HK1iUUo2?=
 =?us-ascii?Q?DCRCzgMlxh2G4yuzc/KvXfPPOeixbcJKDaJuq17sIhs2pbRXGAhWnGmL9h1j?=
 =?us-ascii?Q?Q2ZVlRRbZ8XvHteamPQpVuuQwkV7VMwOAYmtf6TpjvhrH8CYgfs++cpjKuHl?=
 =?us-ascii?Q?Hc860VpGBUV3/WpEe86OlMUQUUOObo8sc3CSJc7PLf1YnpXRi384SC/rvGrn?=
 =?us-ascii?Q?RQdqdNT0cVpxjVJCtI1sUZmt3zDTqMsq/eTJh2iAzRACs59YGtUN6OMsclmx?=
 =?us-ascii?Q?qsvH0/8I4SdUY479JBcMFFNG1ITicgJR/2F7wv4B/AvObd1akyJm5YMk9vxg?=
 =?us-ascii?Q?OndP5ptk50z5n/P4xJBXcfWfdQ22J1ECrah/IGf2F9aETtiLEAuth0JY+NU4?=
 =?us-ascii?Q?ktsKZBN9p1SonopbjPFoYcqerfqjr9QEvfaZyT4oifMrQmf46wxP3SHmWe5G?=
 =?us-ascii?Q?ILdNYLAZxspOvjhzsXUorLF5U3MXBQKLrUqZmyxFaFQIWaWKCvYfrC29fPbW?=
 =?us-ascii?Q?OghSu9Q8OPuhF/Ov2DB+b+BO2hvuADudUWCmoz1jaMLyqG2dOqEkPN7D/4y1?=
 =?us-ascii?Q?7PschWZiAnjtQYmroGsWXbkB/GRRsjc5katMy0jolbNG/kMXB6Z3z6Sxd0ZZ?=
 =?us-ascii?Q?rxXBEiG8Nso2rk6YdiHU7382eCcXwOHw9njO4q5rs+Yu5+ay2fWSNau2Y+ie?=
 =?us-ascii?Q?fa/MoFeboNsYaD116JBB6VXzNTd+2unFJNoLQfrUG7gfxJjuPA/wqbCJAOMf?=
 =?us-ascii?Q?t36EZ2Nc+ahIj21xFxdMiJBowCOMKWtBk636cx1BEEjaf/tqOY7HFq89Ej1k?=
 =?us-ascii?Q?fjz/jqiKRqLjhLCRE1F/oQmXE+5odswfO97FwskEMaCI7ToL8LNzSPAAYoXe?=
 =?us-ascii?Q?rcQvp+11euKM42s4dtCRh2ddeltnkCSAkuZ+6P/eIBFouEUdOhE6WvLEocgY?=
 =?us-ascii?Q?wNax3Zu9dYHee8dNzfFJ01HL9t+LYLPMGc8eoTZVTp3hys+YC8PVpg7SdpSa?=
 =?us-ascii?Q?c6gTB+tlQTZh8T6HGen/6/FpWNtKjblarjBashBgF7y0DSFqTubCBs556LvN?=
 =?us-ascii?Q?0cd7TAcCjw4XLMB+OwtVe2A+WMd2N4lGsmqyIWD1GZsnOtjwEavRJplqJLTA?=
 =?us-ascii?Q?2X6MpBqbHbrhuYWtuEjdnW0ixztYNDm4Ud3C+ec69UhEDLkFIO5gchH0BLAn?=
 =?us-ascii?Q?1K8xtpw0wnRgWZhuc0/uaDI3tiWFMTy80/hYSvuSPYbY/IB4XG21rvS9yRmZ?=
 =?us-ascii?Q?as0Ek7DtI79k6XmqNJ8TbFMkXIpU/zY4/6RCo+bkinT5jyL5XB2dZT0Ikx1Q?=
 =?us-ascii?Q?kmYNLHU4gUMRvEHN16MvXB0DfCgFOnppIKLAhWPm8/TM2xursjAD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aeed9d-b1c7-43aa-9c47-08df1533d6f9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:50.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbuJC77zeNxGCi/hUMX/9yFtLJ4Obi/xBCf9oDXhMLlcVAV4fzZZttY4lQX50L/pqg1v0e3YqCdb85VyBzmJ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
if iMSI-RX is used as MSI controller") hides the Root Port MSI/MSI-X
capabilities when iMSI-RX is the MSI controller, as it cannot receive
the Root Port's own MSIs.

Some platforms cannot deliver them with an external MSI controller
either. The DesignWare core signals Root Port interrupts (AER, PME,
bandwidth, hotplug) as sideband signals on its SII interface and only
turns them into MSI writes with the optional SII2MSI feature. Otherwise
it is up to the vendor wrapper. R-Car Gen4 (DWC 5.20a) appears to lack
SII2MSI, and its APP block merely latches the signals into status
registers wired to platform IRQs, so an MSI targeted at the GIC ITS is
never sent.

Add a no_rp_msi flag so glue drivers can request the same INTx fallback
regardless of the MSI controller in use. It is the counterpart of
'keep_rp_msi_en' from commit 3a4e8302e72f ("PCI: imx6: Keep Root Port
MSI capability with iMSI-RX to work around hardware bug"), which keeps
precedence: that one is needed for endpoint MSIs to work at all, whereas
hiding the capability only moves the Root Port services to INTx. The
removal stays in dw_pcie_setup_rc(), which also runs after a Root Port
reset.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ad013dd0a166..dab6f7c52c12 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1176,9 +1176,11 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	 * The iMSI-RX module does not support receiving MSI or MSI-X generated
 	 * by the Root Port. If iMSI-RX is used as the MSI controller, remove
 	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
-	 * to fall back to INTx instead.
+	 * to fall back to INTx instead. Glue drivers set no_rp_msi when the
+	 * platform never delivers the Root Port's own MSIs, whatever the MSI
+	 * controller in use.
 	 */
-	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
+	if ((pp->use_imsi_rx || pp->no_rp_msi) && !pp->keep_rp_msi_en) {
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 947b16086979..b9c7482223a2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -451,6 +451,7 @@ struct dw_pcie_host_ops {
 struct dw_pcie_rp {
 	bool			use_imsi_rx:1;
 	bool			keep_rp_msi_en:1;
+	bool			no_rp_msi:1;
 	bool			cfg0_io_shared:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
-- 
2.51.0

