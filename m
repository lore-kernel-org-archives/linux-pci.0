Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465866;
	b=YZK8i9GD4noDvnk573+SRUERACXtPgymFJhuSvTRbhBzuj7ZXBFjczn0NAf3LAOMUbDu
	 Bzik1hZpfaLLe2FwuLxbJoDbesD3HHaiWtFdWKrtmglphK78w4xiA3tHrGaw94qBdrW9/
	 Zp+i8MvqZ101iLbmcwbC6ZM9fXCpw3ziwVYMP0F3py9u+JQbolpc0xithwHL8CiEPDWCk
	 cp2EsRKF6bMaRY+dhRzgVaIotu6IRtDbflrMuYtiBY/Er8Oc9Vjdz2GFLzuzAHPl/B+bX
	 Bn+StLyGYxEd1dBmLWbj1GUBQna6Z6p8etHLh8FJpW4Qr8cCczl9pPrH4xzG7V+7CHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465866;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=J6vLFm8qGajAcgR56NM2QcDJLLqMYuNCPDeHv7HlR9I=;
	b=A/+39ml3vS4o6h+APCii4p07/+ELE2hC1XakpB6fIJHCQCzJzoazQKh89JBTvRSn04AJ
	 A0lMLXHPf7vLSnGNsDS9paqswBlGaUUo8ACAvWClVvrr+Ztsj5EFQ9MsVaRiv985dPAWu
	 uMzFA8t7GHYo17kpOFoJkpIoyKqLEk8yYDWX7pWC5ptDx+2jQXmms4jxl9mHwUhtqDzlN
	 QmE7q2J8I+Kkbr9+IqmTSQGFAxBIoPGF7d6y+txRL55/EQZrgdo6iHOdDjahdUogVW0gg
	 Ek3uBxf3OCAuTkqWthu49OZQpAXDCoNgYYX9FiERcGOeGGDipk/Dxu6y0waEZdOODPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Pm2HUB9Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B0606AF64;
	Tue, 20 Oct 2026 03:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9B0606AF64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Pm2HUB9Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCaKgem/RV11KjLdemFdAG5qYxRfg/vnkQ/idiuXU7CEOFEmXO03y49AFN+eIh3qn5b/O+MaKq8rJrUqS6HyWPbgyfe0M1zJI078NNl2mFZI2C1d7i+RZnX19x9GX0bD0IGdAK04x44GSLBLpMKAfyTLi36zGlSyF9Tc9P6Suh8fKvlYEt62xUhEuiBvoBsKBL29whrGD9Gw1037K159fNhZ7Icz2LdJ+v86O5U6nYPo1Zxh2Q44j2F1MtFwdd+LuAqkA5CvNfFmOgmpn5R6rCbG3+D4U6rnX3gCMOuyrP+/S5rIaLN5T7iOjHKltxHlO6H+TfU8Rfu5rrA2PFDhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6vLFm8qGajAcgR56NM2QcDJLLqMYuNCPDeHv7HlR9I=;
 b=L3QJibMpabewhkpc1QJ2I4g4F0wc00o++B1wFzDPdyywwezNGAMiWpms8jKO9O0AZSit20X0/CnYUZnrYRPqA1uoiBUFNr9VjGGW1iQEbmVSXMD0+sPrXwO3nFsn8nAngN9gYbDv6r9jXQfN8o0xccaGgh9IE1jWDO2LnxrbfVP/F5r/Nq5BoQE+9nfk47LpGgKL8BA5Sfz1u+dSoPOigAC1tsVqkoh4Mw6AOGAtAUHU01MqvOF0T+F4yK1i49/O1HqsslluIN/3676vRpl3atyIsNa4LYk3+IFEjoz6ReBfr8ec+PD4PShAlTS0VoSrjpk1tynibMhN0dX2F3vpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6vLFm8qGajAcgR56NM2QcDJLLqMYuNCPDeHv7HlR9I=;
 b=Pm2HUB9YF6MfDgU0PkQ5ZfzBJxprn8vN/ouf4yxWCCwQrGRJwDnYeqSovbTYoZOiZbO0+6JYHK88ct2DLLFHTGvxmxYU1n2ALbvEUGeXBPVrwbXMPMRQcKQAVD2mklledKPbSgcpUtT4YrnJJ2H3zwGo6cKGPdBalP2cebMfvRU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:02 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v5 05/17] PCI: dwc: Export dw_handle_msi_irq()
Date: Tue, 20 Oct 2026 12:10:37 +0900
Message-ID: <20261020031049.969895-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0321.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 472dd6c3-3b4b-404f-788c-08df2e57c5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jiai2YTOyu4z9o6LObVIZv15Q2iPF63oRKUW0wZ6Tlydnw0BdcXgyXuOfkiQNdqtH0oj/0S6ZeUne0jFwQhjU8kkxUAheA0u3yW4w4Eb74hCQKWv85UYuvGHil9ORShAyv79qtPZSgpFJrTrP6TcGJBZDw1uSlG/9xAF4kTyFv+rSTUa5OaXdf2u1QXiWXh/jRNrqQIkn6cYven6zOYBvEbJsCuKC1dGmzHJeOC3V0GzTOH1FiHGpOfxWBT5E2hetPn+a9u/ttLB9BKRnOAsSlvLptu7mJ6Lu9hVFW1VE0ZUwoUHe45HEjIoOa4hzcQaMDhROA6jemb/x77ko9uXnetP2/VldU/qOmCvkdqB/4c6NP82j6NRUYvKwls/vu1v6mKmVXXHRh4T6gxTwWYsNCnnrZKIXn/ByGPMeXoQEs8Rfv8UkT5HwcewZOtfB37/mC74nJHB7e1h5tts1/hUowChWRV2tYiixndNY97hgBoBct6wJwQ8OnL9go7IvkvL4SFxzwUcZ9upmGarcLlZI/M36qlyno67cxR8pQ8hxeP+dClZj2koZKiZwPbGOidJqeKvpdjm/2Ey6dW51HP7S3fGWo+N4uVc6jnNMhnarwK9Mi7d6RAnudQ0DxXcrnycPmoaeh09fzhPv8OENMw6NsttGRyWmM1B3mDYTDMb+2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XuJJmrpY1qfqnPmFXIHE3GwUhWQM6LwPYC9bMBjIlriXnxRFbZonf8DJgdDO?=
 =?us-ascii?Q?AHhFl49lmrurn+CdeqybBJl52LvubrYLYcbkIIT7nJXADVcbpVRpzIpeoPdk?=
 =?us-ascii?Q?UmVESHRPyPGwzeEjJpubmipLQWfMd2LhQUUcLw4N4VHnrKYnpvm6XIWA2wqS?=
 =?us-ascii?Q?gprfjcSUFjLwmVGVKG0GhEVpkSo1lBjaWtwBwFmfHMu/uMwW3ncQcxmgMt+M?=
 =?us-ascii?Q?nyFwXmj8XB91TBEHw0lS3qVHgB6xWRkl0PsoGPcInSRyJSjJmAyxeA0mtHOW?=
 =?us-ascii?Q?VIQbE0ES205EEUKCWFZPRFH4lX2jAIKPQjysibMtviV1+CWGsCiBe5maB5qE?=
 =?us-ascii?Q?wdJnIwwAx4QHcGTbCisZf2x0QGMu71Cd6BUmyN2WUMJ6XB2VZA7EJvwvnawR?=
 =?us-ascii?Q?Qn5PZdPSU9qRanogbt80GTI8tXLTvjGi5kxQerVALR0uEF7iNPtpa2BDsuVs?=
 =?us-ascii?Q?6bs6Yi2Yt19BxxvZiGoRRKj8Xumca3C6jhK3TeYjzJapYLrSeY3Gra3gHVN8?=
 =?us-ascii?Q?NFbqmFm3AIglicy6HbenooqwxIfjg1mHVqRzxVtjOt7omryMgRSV8ihUcwpM?=
 =?us-ascii?Q?z/GxjCSOee1e+ZIgXIlM8vabF3MjwJSFP8jz1rPYtIeZb5CQsAU+YwhWWOmw?=
 =?us-ascii?Q?t2VufO/90lX+/fsIst0WszfBsbQHpsQ7mtsnHmDTL10vpNyRCYGJoAlBmTYE?=
 =?us-ascii?Q?XANVtD0j2Drls9itqeG4p8q8lt5bKUJvu612txnwGDAQFESJVGGOC4O1askA?=
 =?us-ascii?Q?20RDoCyrTRliE53nInSPw95qctg5vYQhav5ZnAhw29krIuWw/mX1LegE/ljT?=
 =?us-ascii?Q?19Bv+vTsR4B6YE/MVf+efmSpo/GeBiNcMhGhIduoU7ZuawXFzVHKSTqCfZ9d?=
 =?us-ascii?Q?1LhVUKOZv6AlGcorJtI3VRnYI8DaaVuBWWL6V7DsqGGgug2Spb4VuZtaMS/8?=
 =?us-ascii?Q?88bVKc5H1EhWCuclp6D8xj4m+OhH+2YaFTPiHyuc6brPujjOs17WJ9RsBYlI?=
 =?us-ascii?Q?oUvm5poD6gk/CAvuaNrvpA7qfTQEd4ccmvB5nx0HVODTOhEsHV7Ci85JnyTV?=
 =?us-ascii?Q?dP44eRI44nnoKWm2/KFdRmdo1E5aO/A2n+gi0S+ym3A88hhCcJa9+riH5FRC?=
 =?us-ascii?Q?YUwcOF5/1pPXt1/cxK0Kfr5YPEhEPSx13k0RxO2uSdfy/9cSNkiepQtlbQF/?=
 =?us-ascii?Q?rPDT1eHtMwYNRWN1jO8CJm1b0LVMTX18mKXRJ1LeaeKCROJJGg+7iuKR/YuE?=
 =?us-ascii?Q?yvgW1yMvIiCRkyK4FmtHHquBR5CEFH3aOYcrp9w/KaONYM0uRKUd61CZPzNO?=
 =?us-ascii?Q?bkS8rB6HzB4aK7UMJLWQrzmMtRnHjshbjfYgTR4OSslm5GM4V1re0CII5uOR?=
 =?us-ascii?Q?/xOxBk0asnbGC2PkxkGnsfoH9ZW61cGyHEijosOyyPIqrvQrZ/eaYu5RII9S?=
 =?us-ascii?Q?1PLX+gNjSnxVdk+oxhlktRd+jjsWCZQ97i8vjEBRFBJoR5rCAbRtafi0t2ke?=
 =?us-ascii?Q?YZdxOmDlDebbPDb9JPBaB8X7IyI/0mr/Pj5t/jvzJPK5Himn+Fgzk2cEM8JF?=
 =?us-ascii?Q?i25doZZSJran09Q0c5nxyWOwm/3cfYF87Wpcrxudh7sbAv/7sOsPJvwnBlXS?=
 =?us-ascii?Q?jdgAt3F2/rc2Q/l4jmJGKrmX/N1kzyD8TnQanyMlQ+alQvbFh2h9bgx0MOvu?=
 =?us-ascii?Q?pcGNsi6JePLDPp6Yekpi7Uz04gz9Z+StYXz5dMuTVMNjEYXNhi7LigsPV0Is?=
 =?us-ascii?Q?9NdGgbt3OBFzzw/tCvqKFIK7poduQ6SnRlJQMNmsDPxrpZCpw37/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 472dd6c3-3b4b-404f-788c-08df2e57c5d9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:02.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFf2rDA3lgAiPbG9lLdV33qjvreLXBPlS+SZ0hYXnTWnqnrRe2jTPtJrGHX7ca6NtzoDDVGVMJ6cS/rxVycCtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

Not every platform brings the iMSI-RX interrupt out as a dedicated
line. On spear13xx and keembay it is a status bit in the SoC wrapper's
interrupt register that the glue driver has to check and clear, and on
dra7xx it shares the line with other sources the glue driver has to
demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
not install its chained handler, and service the MSIs from a handler of
their own. spear13xx and keembay call dw_handle_msi_irq() for that.
Both are built-in, so the function was never exported. dra7xx can be a
module and has an MSI loop of its own.

Export the function so that modular glue drivers can use it as well.
The pcie-rcar-gen4 driver, where both situations apply, is the first user.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Shawn Lin <Shawn.lin@rock-chips.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Add Shawn's Reviewed-by tag. No code changes.

v4: https://lore.kernel.org/r/20261015033103.3076869-6-den@valinux.co.jp/

 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 77aa79ef0ccf..63b38532d069 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -85,6 +85,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
 	}
 }
+EXPORT_SYMBOL_GPL(dw_handle_msi_irq);
 
 /* Chained MSI interrupt service routine */
 static void dw_chained_msi_isr(struct irq_desc *desc)
-- 
2.54.0

