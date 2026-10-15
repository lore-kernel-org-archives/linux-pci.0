Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8A3D9529;
	Thu, 15 Oct 2026 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035088; cv=fail; b=FBPe/+lqQWGEJ51OnkBW6k6aYQxmCgjnfXwAm8Bu0iXZllIQej+aoU4KbtbmTzbeJwN6miK32ZuykWbypJ3Fz1v8SZ5FCXzcGN3zMsDF7lZyy3B2ei/bbJvBZZzOQC+RmfN0p+V3Y+54lwk5jnuq8rvcg+qTwtFKxMBg8SmeuC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035088; c=relaxed/simple;
	bh=+n2biY6D+zV5ut6UMbfFffRDzeTeZuwYy/1oATnUbwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kgf1+Snez1MhEHsqwcqkLnTYEur9xUQ5aclNu/V1TzXX9VLO6735+Fa82Nsn8ecVeQTFGV0ORQ7V0GS3HxAa+wsw+Qs0t46+s82rzDtDqGFEN77JYLrTPBQPVrFLGZdmAWptVRwz9VwrZ1pvheWvtd3o8bu7rCo9euBFjBLpiCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KI8ow3kx; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KI8ow3kx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ok7L+UdHX6RvU2lviceYJ9AKE5WU1q4UZ0R8LjUen33L2qlKhDEaJuiER6rL2Uw7eXbLlDR4B/Xv3J+qBDNjHUvN4Gw6e0t1lnbVaSnUp92QgOKgfsxzLntTKNVf6mZdwUGZECZzwRgGqNypz68HYojB8YhXjzfRKczILvuLY3UIhROrbtgPoG0VqVBryVASZZyLvSiamaRqLzOw8UNuqoassGM4eReTRjvyPC5MP5HAnn0y9/5kuwegAPMnKO75l5rQdW8e6uq4xlv+AzvM4LQGfRFZfuPfilem/WWcEQebLoKCUy2Z/gb14V9eep3u0MwNMYAkgzk6Iu55V66AAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPKJ7vd1BgsM1YcwOsUT1rJr+iiYVnTI+fBF3r1kZyU=;
 b=mNIh6dRVv3FUsNmIcVrbROYHTIJWGDBdHwjxST9z8G5e2tCDVutkK5HPh6ewJ/LTBob4Of1obOV+XQ/vYZOYFpEDKUsKSjtP/a3hz0TgrfXmRDP36c9DcvaqZ89RyQKvIVKw5Hx/Ajq8bafrRBy90eX6N3iT7hpBTlc881AZWfAQslFZgJ64a+5ENbUHTGWxEkYSk4Wnr4Jn9qMJy2vSdFLSP4ndOuyl+UDfcdSW1kLJUpkOCzZixy7Oyey3p08L6v/qOOXUtLKu39/1X8cZomKGxiTB65vDf4MOYMowhlFJNTpYGFyQ2THxO+BEjMPDG/67AZYjXU/WMD+nJ0eSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPKJ7vd1BgsM1YcwOsUT1rJr+iiYVnTI+fBF3r1kZyU=;
 b=KI8ow3kx6A/on9OoUNo1jQdnFepK+gTMqj0SgmpRT8Xjge2IAiMov2I3LHAIv94sMLDnikXH9DWnygmyIxZdlUoZxNy8G6ld/JnjbU7+3AKK4OCz71aoGcz3ea0elm0oZZUgbz1BENlTwpa5wtTvLRDdR0i+rIBAfJUvFScOPOU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:14 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:14 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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
Subject: [PATCH v4 05/18] PCI: dwc: Export dw_handle_msi_irq()
Date: Thu, 15 Oct 2026 12:30:50 +0900
Message-ID: <20261015033103.3076869-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0170.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: ded8bc30-3063-48b7-3aad-08df2a6cc3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NiNGxquYNp1O467fRlPj89J/s9hnBIRb8uj/y3beLAoMEkjz86yCTGjv3/kUbpKbVWN+lv2Lcb2e6CyaF+8Gt9A/Zc7aymjARYACz49k4ukFKvrzlTDb0L+L+qHK64pAOMvpr2hHGrkxPQ0Z0SJwv4b5RR23lQOVo/eDyh0RHi8/0mdowMEfi4UENtepXzSKBtkwJgLMxFiOs8Gtb4AHR7v5TZ7oVYPvfv0P1BzO/8SUWeX/yJ98M/eFRTm5hjYiE8fIXt2LnqqGsXGZPhbLdCWY8bv8cA6MbvM2bMeg0nMixMbQkVCFkXQ5y3gKUU8+0C+3CZcGmq7ytChFazJIv6g43mYfj2bMFzBQVGz2T+bQ49BAz/qvpnTI+ZIs+0zEXvdjrynB1wCTmJTJjpyJ2/0Ka2tW0qnBvPL5HeWxiMG2u+py/Aq1br33AMcywg7AKo9FO4R6T2f2CLHTY+vlzqmcuYgc9YdHwg4UiUadD7dWDcFvmUMy6okEiqYR73RyK5iKNLEScvFBck4enr01iq//DsqcNaYtSTzXMu9z6hbNjhzAC1JjzhyV1B4Ki7faxva2Xbos6Ct+eMAV8jrO9yVZD0zB/GudUcqiGZhn4BYdkvm29QfCNZWS5ZjrOdBy+PEnsn6f8T4kKfZFGgfmCB4XajGJUY+eI59gws+iCyjcgFksm9Im60GXKff7/2IwueBDS0vApM3a++nvNe5WYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nn0P27z0NtcP0esApxQFL5RhSSOrw2wB+0D00JEmxK13MhUek9jKpvphWqrA?=
 =?us-ascii?Q?EhqsB4PCH1iN9NFhgD5Fa1yPl3To46J+bpZoMZT6r/b2jyZqTb1mD9eAGCtx?=
 =?us-ascii?Q?oZUKkzOiaqyRMYw7JHgIU/zimmUfcwsTkuNdoBoVO9vnCCv0zx8BdaS7cQ/d?=
 =?us-ascii?Q?YadzxxtuHKUDyiIvQDrPFAJhpbNmxjoGYmcJblRT3q2nGDRg88E8oCzVQeBf?=
 =?us-ascii?Q?f+S3fuOzO1D4kuiYj2A4qxWTYYnmdOlllZVEx43tweZkC0SlhZ6IL8kcuNe3?=
 =?us-ascii?Q?sKptb9XZzDbi/8dpk60JrNPYStRJrsYHkuOZNO4G054WIpSyCBt4R90klfmR?=
 =?us-ascii?Q?PmC8d7byh/F+6YwXk8KG/l2OTiSPjvcsoUuyv2frVGqeXyOInWygSvig25Di?=
 =?us-ascii?Q?xizVtog4EaVakqF32tWPfNr7nM2ah5eFijpvM0jXgzjP9Kzn9FvgUkcw8JfN?=
 =?us-ascii?Q?KXKesCJ0qwfuc/hRKOt6Z3odHRKz3rW+30mfEek3XUfTSlvT22xhywRLFuXX?=
 =?us-ascii?Q?MswoWfidQR+rIVZ9g68FG84OEZ6032WFA72OSlFKp06SvbPGoKNIcZ27A6av?=
 =?us-ascii?Q?0Jhkrl9UUll4XXQnFG108YrkCO7R/4xsimYbXj1GgzaGDd/fknWz60afZ075?=
 =?us-ascii?Q?+Gk6OnT2nziw58r+lWZ2NixaGKYczCpbS0XL6yLHNXkbVmeiw3E2bRra47eh?=
 =?us-ascii?Q?oaDgxT0X8Z3Nyd9nhtVg5K65EmimmG214wdPhW2xX0fCZHnxb5I4elAk/I+T?=
 =?us-ascii?Q?/RlE0MFCuJZXusjAwlkYpfOhuWlfBfpRU16/nxvrBxtayqoAX2ZaH1/eDHjb?=
 =?us-ascii?Q?XyJtJgNFQKsAc3tKyvfJCUKsEChi7VZyV0I+E+i+5Jy5shJfkgNMejcnFgKM?=
 =?us-ascii?Q?7K/mHZNddJgxnGU+SPs/x0qq2YCLLuGT8z30Zw8Wk1l7ET2vsGR1fysSj1Ik?=
 =?us-ascii?Q?azsTwf3VozV8Yl3cpZOYeChxJSJzm+Tf30NEzJjIyEx6PADzQdRv4/XXTQ+X?=
 =?us-ascii?Q?8P+s6G5XGCpdzR+UNJHPFBO+CU4yhGHx5ElpfH8VhRgEosvHIfvXJPmMeU5X?=
 =?us-ascii?Q?ln5a1vq9aPJIv8flKPeFcz6W7MWfGQziw4r6YRHS/QiOkO27wkH6Ww11e383?=
 =?us-ascii?Q?HqkhDyz6MUBCMcon6TpoclJSeTlM+ms1CY3SHVQpWEhemj8OkSRC08bD8m+B?=
 =?us-ascii?Q?/mqRv+QMRvULztI9GFBHmNGit/CDW36hftonLrNnMGflz6g3gM+tij2io182?=
 =?us-ascii?Q?x+KIHELmh1gK0U7UBEQcrINsP0+KGE0WVQxWOk6jf/fzn+83SmyXQh+GTJr6?=
 =?us-ascii?Q?41Rm8JFZJ6Mw/Uh54Vy12iiCpBvo/G9kPVON3OGFuQHpdrOnStvPEEqAJxcG?=
 =?us-ascii?Q?faSBdyh7AARvBcFpGA4lJXQeDLP/YYWfCwjKU2CjaETc0L6QkBjCclxn1prr?=
 =?us-ascii?Q?TAexOw2tvtqiRTNDrYiXXKzBJVuXTAv6DKrCgakYMstkyemlpeIh21Cc1MTE?=
 =?us-ascii?Q?eN/jBQNfuS8HnRd0kTV9kghQXkYTX9Qo4LIppvCvgqv/+2P061eSA2hG3qX0?=
 =?us-ascii?Q?mnCaHakfemCc1E7ZFQJTslnqCFkQ5PvNDmTvUuJGhw+Yu8J3HD6LioLBHrVz?=
 =?us-ascii?Q?FE8V4ff01QvXBWd7SeJyN/+T0J/mqbeofHb/85OMbMODTY0EIrnhPjByog7M?=
 =?us-ascii?Q?Y2bNcLYzIRcTa3eBKX5Uf2GDSbVR7VpNB5B9r5lHjo/PtDYGxnNk2M7IXLKF?=
 =?us-ascii?Q?+ZIQfdDWthCfFhMdHZc1TB+KIw/M5w8/Op1kGyirH6xqV5Wfo/Ot?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ded8bc30-3063-48b7-3aad-08df2a6cc3c4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:13.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CE1oQVO2a4q8onXWKdMOXut+sbiku8HAge+VBL9em4py1fI7rRVen6F1TrpXQDosLOXZsetkDThYod61i6IVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

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
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

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

