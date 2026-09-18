Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020136.outbound.protection.outlook.com [52.101.229.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3C3E121A;
	Fri, 18 Sep 2026 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701654; cv=fail; b=D3TzI4zmGFqV3aFpooU+AQN3YDQ5GuuUTU49t+0dV0vo9t3PEK1kMxAO/ODOzh/XfTfSKgHWZLxMVSPK2+opHSaDr/+DnDMbyi0m3GyYmUjWk0qDvNO85V7Tt6XFwIxvrSx6bxsejjd58PAVtwwrJAx574UdU5RYaPL6HsUv4iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701654; c=relaxed/simple;
	bh=FXdMX4zhZnHQU4ZvtwfYZkcLa61JDP4jCrqodAAG24A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LfJWZ2jnfjJR9MG8LmZWbvJ2FH3hmoH2Du922Okb3GUlSfi3jcni9sLLElKl72D/vncn/5kDEyeQAaIBKPq/tzH2HdBGQI18lNixWh/ShgUBqAV/r3P+/t/74lDKcfOWnmCHIs3GGBsrrtBBMshVguEpD2zHaOM8J4Ju5S2KXok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TLmZt/rX; arc=fail smtp.client-ip=52.101.229.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TLmZt/rX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFaAIaDyWLYDWxm993ik+s+0kATVc3YCKDJ56Z09J7wyyOUEqyZlRrgngtsPCBouzMRYcbjf5Eimg8mQrd4mg5dhLCqwexznBWs619O5BjGZJaXuo8wezvaWDgnmmYpo3Leow/6dkZ6XtDfQleYm8Iad8lOLwim10fLmnEuoOTlkR/YDxX5cZvPseuaW4QvVxXuOEYgVESqG3mVHeV9Dvqox/ZqbhlXE0FpUlKPAZrF8Qh8r28iPb6bLSVdWVC48X6vt+6J4tqgmN7pWgCvEdmnk/Q+QZLr7fqwBmCbCRw44lDQc61KcACWab7wj5NcgvpZG9GIvxKBTTnBxpDUrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5VFo9vBxLq1guhy0jcff1faYU2m23p47A+Xz68U1tk=;
 b=NnfCB9/UKa0iteFisTidnqjSoY7r+7TXsCzj/HCQasQOIx8vfkfga1Po1QR/XWZjAdCMWK49R7mgYH720mtE5obLxW0FEszXgf8T27emDA0VOwQ/vVSDDz76/3sNWcP8CQdSgIvQ0dZHhwegPaHrdpTNCOzMHZY/s98ac5ZRtoKCAp5ojfbEP5SdEYiXLg+Q51WEffGND/nKvHa3+fnd5VszzEYe8/UBYcvIGxxCYNtAGWt4G0rN+kAJBcXeqJFDfoeybBlF9ipP8y/0hogu1d7bxTqeT2p9+U7SZ34vApcHsZM1ivBknVIUfQrXToLch48xOK14ngCBo9IVCFo4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5VFo9vBxLq1guhy0jcff1faYU2m23p47A+Xz68U1tk=;
 b=TLmZt/rXEpL08a4vHoZyO51FIjeLWNvcIuAWWENKda6R6kbTzKl/0DVaH5uFEY1oJnpmFV7TzB5lmDwQyEL0w2IbWvhzNAY3HA+eS+ufU2fPc4dMY7dOWuRfRbIHKsdYxOTCJ//aJWaUkNrnTka9bGL8W7xBkqjhkdch0w1VPfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:47 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:47 +0000
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
Subject: [PATCH 04/11] PCI: dwc: Add a host op to run before iMSI-RX status is read
Date: Fri, 18 Sep 2026 12:20:31 +0900
Message-ID: <20260918032038.2216471-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0189.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e72081f-69e2-43e4-0e3f-08df1533d4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|6133799003|5023799004|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	cb1hTa7nuVA28y7lLghJmu8IzuImy6TlESnoazOQiVAiTBTpbzSXWWUVCy22Mog9qOYnlaCodo6RC8IT08r55pLkfkMsamXYdl3fTmUprxsDHR/gw2Rl+19RG0I1RVKwbfT0YlHwsbUbHkRCCkrDz4+TaWHkXv1AQVJQIw/qw2iS/7UHQH3UIhe5+xWhpAjsXc2laoDOPZbJCJ/gYK4YCgoJFm2AwP+HXmxJirGvNukCUatqJaJ4jBiU4FVFzed10Jik+VDQBjkjNG+jbmpTXokp0ZOF6ieDXptlJn84S6VgdJgaKDT5SbXheEWR/w3zlhKOsiSNqj2byYQ+k8oEe87IFK9SB28e0noW2/rWknhskZHACzUAGbRZUcT4WQe8IDQVDNr1ix0qsCDak6ZcXLzZV1LGYDNSfZw+qWfoevRqNyNBUN8gGluw/3pGLtikfDLdfrOeYtAvSthPZexUxxcox92OlJ2ZQOyGQxVa7cC25ROyh7XD9O31Wb6hJ7LPoc2Cz38Pepa47RqLEME80TYsuG7VKdEXLaRZuwpGPuLC7aeS7oxEjkGHBw1ZrjRS6VlRMaMG38BmE17JHieH83wXJ9dWFvkapjNnoZYUkjhxnehB3m5IyIE/nFhiuUdLSDnPG52JZzWFhs0rMJpUMiahLE4pgaqktG+Ei81X/IzjG2kJoyJRQeK9W8QdSigv/7d+H3gOnGyScHwWzics1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(5023799004)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LSmV2TsD/A2kzXa1QjG+BYvBoJiDz3EfC9mBqh/V8c1cYFktgQJieLrS9vLi?=
 =?us-ascii?Q?vLBaScvO8aZh+jTnsrdcpH9Z14IllcL26X3/+kkXQFVJ0giyouyTSLwR7zjN?=
 =?us-ascii?Q?la88Q7WQZro83kTb+R73ZBNplRnpbpKdtexKOtQ1RDeOaIdgUxy/vrIO5pjt?=
 =?us-ascii?Q?mpdo7L9yOiUyHVbSuGlZIn5qIjNkzFEGizv4Emx5Nf9lk8DXYkRlHfmq/5Vn?=
 =?us-ascii?Q?x4RAmpYTLecejDBtJUC+ffHr7iqvKDY/p1r5ZJ0cNUqBzdd997Nz2kv7ybva?=
 =?us-ascii?Q?OHCVf4NAGO0LVe8XOae5WJ+Jqz2ZDHglfPijxlKL0rkt0oL5jzEGgvvr0daS?=
 =?us-ascii?Q?SEtcdSflL1AoNigoCEzs4ZlGZ+PnPItDxkBepnGI6gsZCGDIa9DkY4Xn3s0b?=
 =?us-ascii?Q?U+7+siKebvaaBuedQ4kfhw1DtX4pk/yi9zy7LHMmjo8YHMh+5xlV0klR6lNt?=
 =?us-ascii?Q?8eWHDIXkexiBUs5G/zpLcujPP7PWVrfLI9QIDMsqY+Zuxn0n9MdQ6PMMcf3i?=
 =?us-ascii?Q?9EHfYsVerdnhrDkjgxdsTvg+oxlwoDeVUkzxrxX2zLn4Gx1J6R++BaX/1mKH?=
 =?us-ascii?Q?HZKIxKBYBa8ISGN1A1kfdvHAMaVknqQbxvK0xL71J44rj0nGqc+buwi9BdYU?=
 =?us-ascii?Q?6jD6lb9OMs+UyxBgm1J3q/IbqmvyappLcJiMm7IWkndeAQ0hrg4R+vwLNjRy?=
 =?us-ascii?Q?4csJA+eWh6S0olDWzpN9Ox2NrgszwV1nejNom/O4oPEL72dyb/oyhGJGx2XU?=
 =?us-ascii?Q?poQsGr3Shlc0kUv7EwvZFgKHfA8etZXv5WdpIeuEFPHA8ouIcEkFW824VlC1?=
 =?us-ascii?Q?Sf4655+UdvPaM+J95lLam7mw103CnRJDzTilGVK7e0ZDmqr2LzJ1ow/kOImJ?=
 =?us-ascii?Q?OUk6XDiq3ygBfPh1rppaKMPJoQSNFXtvgfYPspJ8KRQQfiX50ctS7EbEllul?=
 =?us-ascii?Q?WS/LP7JpmPtQ1BZNjLlt5M6x4XB+SLIsxJRqGIZQiMCFaCWEcnZajbGgU9YH?=
 =?us-ascii?Q?DDCZji0Qd+Qn2zjyuYsgCKv0vCEnrds3q6macEkJkc29C/L3TZu5sf3r8L2B?=
 =?us-ascii?Q?VqZdIpa7EOpUHr+0794TfzIDTCRtCg1P5h8Woz7Z3JNYVbHz4rJM4jGjAB/R?=
 =?us-ascii?Q?ytWGyvtuSpuSh9x27Pbgsacd6AfHyzUOi0TsXLYuu3y/Su5l9+9yH/BbhxwZ?=
 =?us-ascii?Q?k/gtl/DrWp51LJSt/mcQcBRrW3GVLZCbvJHkd6pZ+F1rEENcjtIliXK+xPVL?=
 =?us-ascii?Q?unxTzXgztog0fE3ZhtAdkzXbUfesccGvEyjS/+D4OB7oLwOy3eITFdcHLfF3?=
 =?us-ascii?Q?dmIQ6iEgCUgcTq/JGlnK4+489T7LLuYmcsZXnWONbmBBPaEOHeyAEl+CYz5Y?=
 =?us-ascii?Q?IJ4Hxz06iJtc8wkZWKO5LuPXzy5CA3W1EQP6TugzrKpryNtGcAlXEGNIEkEr?=
 =?us-ascii?Q?ezOb/wvR/9RJTI1mZHIZdqByjeUQBLLdRFx+Eu2yDr4WnVKHuWW13tQzhMFt?=
 =?us-ascii?Q?8YfuIBkOsL1HJPq8sJ7OHElLI8GGl56ZG5VbTp7FsI5zr16nBwuWXlV6q0//?=
 =?us-ascii?Q?/f0uo48VF9ai/kGlOXy4MIWYzp1hHTB5b3vms2vepDUzOsxxNpeo6E4Gsmq8?=
 =?us-ascii?Q?bSfeYDVp+ew6CsazSstrgDtGk17BuAwRni4jpNkboegGsq6ecMuVYyuG0eSm?=
 =?us-ascii?Q?pkKxXY6NFRUjSKIReyfPkXn6orzcSgfO832tuE3STsOs2gJl/tQW/wqaW2+X?=
 =?us-ascii?Q?8/eFC0zg6/uvTDU+DtpBK54VWJbhYF/BRTtopzIurboOoalZ9Gao?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e72081f-69e2-43e4-0e3f-08df1533d4fe
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:47.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAnCASxudzW59mP1NRRGjr8iq83aKYvEeIx9iz79VO/GSgj+hQC+hct/aJlzwPYuZbOL6xeRp5Tot1EU//XdcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

Some SoCs multiplex the integrated MSI receiver interrupt and other
notifications on the same interrupt line. On R-Car Gen4, the
intreq_pcim_sub interrupt carries both iMSI-RX MSI status and
controller reset-request notifications.

The generic chained handler reads the MSI status from DBI as soon as the
interrupt fires. That is a problem when the same line also signals a
link down: on R-Car Gen4, DBI accesses issued right after an unexpected
link down stall the host for a while, and the controller then has to be
reset before DBI can be used again. The glue driver needs to look at its
own status first and keep the generic handler away from DBI until the
controller has been recovered.

Add a host callback invoked from the chained handler before the MSI
status is read. Returning true skips MSI handling for that invocation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 drivers/pci/controller/dwc/pcie-designware.h      | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f5a38e6fd8d7..ad013dd0a166 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -95,7 +95,8 @@ static void dw_chained_msi_isr(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	pp = irq_desc_get_handler_data(desc);
-	dw_handle_msi_irq(pp);
+	if (!pp->ops->pre_msi_irq || !pp->ops->pre_msi_irq(pp))
+		dw_handle_msi_irq(pp);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a53ac27cd244..947b16086979 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -438,6 +438,13 @@ struct dw_pcie_host_ops {
 	void (*deinit)(struct dw_pcie_rp *pp);
 	void (*post_init)(struct dw_pcie_rp *pp);
 	int (*msi_init)(struct dw_pcie_rp *pp);
+	/*
+	 * Called from the chained iMSI-RX interrupt handler before the MSI
+	 * status is read from DBI. Return true to skip MSI handling for this
+	 * invocation, e.g. when the glue driver has detected a link down
+	 * after which DBI must not be accessed.
+	 */
+	bool (*pre_msi_irq)(struct dw_pcie_rp *pp);
 	void (*pme_turn_off)(struct dw_pcie_rp *pp);
 };
 
-- 
2.51.0

