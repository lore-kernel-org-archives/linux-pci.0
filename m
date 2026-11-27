Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749148;
	b=U71uB7cjWenk9HmVlFMo4LB+pHBNyYp4wEE5b+koB+cxnqRDzjyDBvI3mp6b9s3QVlXp
	 d9/PcmNuQW7neJwDtvcZal2h2tCFX9BqqDNipeSK8HHAbPESoq3ajJXXLm7rILfKuuBmF
	 3QIC3RXgIP0bRNFwRbnF3dj3beGbCkQDuye76SHLhxHSKfUimTX+7dSkRXfairZn6LyrY
	 6xXUokcL1wxeCRCuUGLCb3ctKju50x/xm8z5Mvb2XC7pXpa961O3yQbcPAksaoINdIy6V
	 xVBA0FqBUvWpOt3aKTDa49m/Zw5XINRfhTLTnYf3sQKDATEVD4dzQIXAMvHBRwPrVoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749148;
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
	bh=EiwLirU7SFbB9M+232oshIpCqts/tFuZULmWDH2e0lA=;
	b=bRimcsJyUFBbOCpbfYNavVdn0UdPaHhgCubzlVxff+t6+B/lWBnlt5BCIorQopkZSTbH
	 kE517WYtI0JeG0JnZQn22rlhqX+Uwi7VVWZlK7icfd3gUsZ2CwvT4Cl5G+WExHDfNASoT
	 D9224muA5GnJSXF7xwrcAKeuZcpscImNficvnZb9434gzPW3FeKCFeCI12CkdUK3n5zc6
	 NlxggNsVCFDJr+nvJnTcMfw++LGtooyz2amy50sD+sepC/n6h2DwKsvZp1Nw4v/+CbqZs
	 yVXgixnqQIBhwgGmZBZ19xRCfvwsoPcrRk1irYvwPHA4TnFIuC7TQmYf11F3H/tltBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=PerVAi0Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA960A381D;
	Fri, 27 Nov 2026 03:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BCA960A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=PerVAi0Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7c2m+Up7MoxeYIyMR+X2jLLmJqzX2jyaiV06nN+U4Q6fJbGE4A/gfHvs6MOBW2Dk10QgFyVtYoK1STmLA5jPoTjKOZdauf0GaiqV0odyauMcAbkb9IjNWg9IeFDNGcxQjbrPYtQ6/ueCB7ILAvhKq16I86Zrqbj8nwKCftsWUWyQ+UQhSg+KNrt/s71PuUZq9lw8SigN1xqn+LL2j1su7JhsAUSlei2xuCs2fUfN78wHM++RKuQoz+++wq3tui24aEvqxXMIC73iP8/l2olb2D+b7QoAhbYA5hmCcD8xkvHhHLrvsal1kcG/Coedmr0+/YxNucZvlteZ4YdHHxPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiwLirU7SFbB9M+232oshIpCqts/tFuZULmWDH2e0lA=;
 b=PwYgUVj+RuNThrvrhvbHwDiUIRgklKW99DjHu9mgR304BQxpjDVWNcstf7CRFa1wJ03M0xwNtI6uZ3A7JcVMMB7YENXQCKoIWQY57PD5zZbGcSUAwY4t9Dtv3Y+haoJp6U9/Q2YziXvfoni7QyHh9lsMnBO2TMJUbN/LebXwUvPzBDznqWbohERX0i3YXLeGTVS+nQaTYBYz3MMmmkgY32VbLWb1HAlpcfcSkhGBAWm2o+KidSLbLoO2kBwds8zWMKVXq8QA2FtmtJyLkg6PfumeRpZd6LTPeKiEGWmIEUi3dQK/D+ECgKbbKN3+BPiikopMFxbJmDyplVuHDGSOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiwLirU7SFbB9M+232oshIpCqts/tFuZULmWDH2e0lA=;
 b=PerVAi0QsITU1VEnWeVXPgBe+nykYYP3XJkExMgFHjckZzEpLNF1Mz2pkHagiq7lKU+x6XrxNi72+UXlum+V4szsm3iLfasmjb+IC4uD93hl/XazVQSbPltcNItV7+62aLlinkfdRH+JmAsGsOjLRoh1kUtgXda+gZt7OfwfdzQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:24 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/17] PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
Date: Fri, 27 Nov 2026 12:11:42 +0900
Message-ID: <20261127031145.2521228-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0349.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6800b192-831a-4b76-9ca7-08df4c3440eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	w5iEX6jMfNSOG5ScIyPsrYQNcadOzB0Wkoyouz16Vacd+MyOxsbTVRQmXFek2aZKrGfdTf8Yp28nrwgzexqrtJf+RO9i30rLK/G0+gbgJrU6q0S/UD39HuVK6nzEQs9JBzD/IeUxFKQZdgeB+UainUwwKGlbKdHgHncItKxMYvqogLFBCus67Ye/jrHznLeDqoq3d/wtm/+gyrIOFCMHrKPopnVwZvAv1852pL4O/ovnZOhXeiQKi5QmsSO/sNXk8QdxICcgYnUsTDZS/VCW85UeA91C8mJA0/FRg+g3384QyXkYxUfXcReg82DfERJgmZP267FzaVKav3y3bqXeyHW9uMDZKba4wjQ/u0l+3DcGVh9z+GqO/BP0YDhAUCrud9J/gqh49UJMJ3Umrr7YDx0uYjRyiC0HVCfEyRTkhdxuX+toVbX1wYoFXVlfPKQ0A4oRm8Vguq0IqHqn0rEJ+GvPXfJlTXT/t/jVe0uFDfifaL7RRaTpxxlX3M6svpNSFYzg0DMgZCjkXXvBJI0v+RLRnM6njf0yXY8s0Nhk6r+ckgfiNS6iFZxdqDihV+jV8QbV/MOHsJWWE30jzSaAjk46eiPH7g0Lp6QdIEHNHSgL/zCNBUQAXZ38cOyTt+OmEORVH0O/x258N/nirBU4udihy5SW8e1d6Nmgax1POjF5iaLOav7gofDlfMUObROxBkIqz1N8WceDpkzEkiZWNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kVaqhF+gtAnhj3JL7kU7ePtqcSxWbP1d+cmddcTE6w02XB3m44rVj0qFMs9w?=
 =?us-ascii?Q?UbRtRRfK2TxXpX8RDfJu+2NFaKryyjvtz5rbxbUNplV81uf165E0AHTLQ/KZ?=
 =?us-ascii?Q?Vjosac3q+4yckPvct0UNztDSbx0SEuOy7j713mPTVEaDF0h6MJbMW4MjfFOq?=
 =?us-ascii?Q?Feq1Hl0wB3S1OZCqOnHBMr0IEdfE7whp9ft5zI4xOJp9SPSUjR1Rs2FoLyGy?=
 =?us-ascii?Q?Q/dknFm3MFuB+oDFQbHLO2/jbgaXP9qoJDI4sZUzgiTQOUGetxw3IB7sQ7Oq?=
 =?us-ascii?Q?NZfZHe3jGgebMW88eKrWMZ9IrCtIrZg+Jt04hFi6rUtga5nzI51lk8r8jbBb?=
 =?us-ascii?Q?aTf4uW8OUuRhqRqfZFDHsjyVg/Ac5M/bEglf2ykwlcsFs4510BrHKFPVxaLB?=
 =?us-ascii?Q?62s1GKd+gAfmiyRQTfm+PPlnvgpvJKLfyiIOlwX1px3nnQPK5trx2ILsWR4r?=
 =?us-ascii?Q?zFVLm3x1lN9CaXcgtY+bbOianm008SPv8bwQzgC9u7SIm8r9UKKPXP9kWhqe?=
 =?us-ascii?Q?FGE6r4/I8/iy5S9rvQVtEm07YDYbIhf5fS1F7ERCqozT2L4bQdjW5HOyN1dm?=
 =?us-ascii?Q?Ip8Bb1hSKCIKAGk0mJpK3oly/cnAkvN30kSHQP+dSFBOY07sST3kRvO2rxHE?=
 =?us-ascii?Q?TcIzQVsTD7fzSNaloxYtGgJBM44P2sn/Jux04vIOv2ZMmdido671DN+JVN5h?=
 =?us-ascii?Q?0+2X07Yh/ka+oljDcvsJtVaj/3j+rt3NwJdxzz3cuUQ1OVnTYFbzLZy35DAt?=
 =?us-ascii?Q?eA4syB3sgCcYRjD2eewWR5k7pbDkYpuUGGFsFbQ7xmqgsAGWtkHue8eRt6/k?=
 =?us-ascii?Q?iqtsg4VQD9W7jKKgdBGt0+2sDdVBLXDJGltr3WhzbaEQy+43vD3g0vHh8XlX?=
 =?us-ascii?Q?teZpotDUnc9UW3pcBJn+CbM40SKn4DQS+GNw9/mOGU851FFYrnb55pw8KbXv?=
 =?us-ascii?Q?ho4EqtejxAIKR+Rmv/rOD5O+WW+mxSrhgaR9hy+5NiWf/xpwTcTUhe0rrPtZ?=
 =?us-ascii?Q?X0r6TpgLT2bKbzoS1QnJiDCx3p1U9TgIzWpKALK9ynrcsDt2h/Qzsnp97Ua0?=
 =?us-ascii?Q?WAxx4zdt1NA90UcXrf02RHD9S8OESk802nA8pvH09itHEY6NBReNWa2e3LLk?=
 =?us-ascii?Q?WaM95gyWGoM18WAGNKFyG/0VjcAzh3W8BtbXVP4ulYFcXj8c80TV6m1WmAaw?=
 =?us-ascii?Q?zCh8jPbVpdiWlKe8wNB0Ls83w6GlSXR26OW+LXN+7WKwgGLQ+O/PGW7ewNb7?=
 =?us-ascii?Q?oGdV0/n2qAghEgg6RbiMqfmqMlWKDFIx/mrxRvLCqA69LGqRqymmYlQavft4?=
 =?us-ascii?Q?VOlTbKazVL/6ip/BZfQuxpSlF3kFe0ndd9oPjZotd/JlL3a1WgsCIHN+TW8E?=
 =?us-ascii?Q?zdHs/AzHWJRvJnX1eOvdRYoDSiQ8OHwzBsMMjhoq7TF4MFPK8UhhzJOAGcAe?=
 =?us-ascii?Q?HkvJD2yIvE0gzjcs1AL828hCb/XFIaYGm4NpSEEkOleRPoedckaRo+F0LN42?=
 =?us-ascii?Q?+O6UXM1l/xqyI1laQEWe9+RzPTjNrgu7zoutvpFVltBrbmC7FxrIlJmwOKGY?=
 =?us-ascii?Q?zKhbs/gltB0y7kiehrIuySLvNmyEtKVZLElLqTKZD1W9xu06gclVcRPmgmCT?=
 =?us-ascii?Q?BELEg+l1ZR2iyFfU5ZcSrNVOVlM+xEeqf6C8XkidOy6Z+FJdhonpx59d6IX2?=
 =?us-ascii?Q?73ui04p8cmynX1O5rIRoQpptAvgWJbvyDwnr/Zuwq6Qtm7Gn7OKtyIxi+cvN?=
 =?us-ascii?Q?xLlHVJKMwRiGvbxThHe7fgp6OOslvGkG+psqh/G0iL0/UjZ7mBE1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6800b192-831a-4b76-9ca7-08df4c3440eb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:22.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhnF4bSTEKgplRnn+bYXNZCnTtTikoSfHqS7ugpc2N65ZcGVTgRSNSfxwz8ZTmZ0l8YsSO+tipQocyj+edAGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

The Root Port's PME and link bandwidth notifications are reported in
PCIEINTSTS0 and routed to intreq_pcim_sub, the interrupt shared with the
integrated MSI receiver and the reset requests. Dispatch these
notifications to the virtual Root Port IRQ from the "msi" IRQ handler
after handling any pending iMSI-RX interrupts. This keeps Root Port
service handling out of the path between the reset-request check and
the iMSI-RX status reads. The existing dispatcher rechecks reset requests
before invoking the port services.

Enable the sources only while the Root Port IRQ is unmasked, and clear
the MSI-form latches in irq_ack together with the AER one. On an R-Car
S4 with the GIC ITS as MSI parent, a notification from a link retrain
now reaches the bandwidth controller service, which clears LnkSta.LBMS.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 51702e604793..548e7033d401 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -66,6 +66,16 @@
 #define AER_RC_ERR_INT		BIT(27)
 #define RP_AER_MASK		(AER_RC_ERR_MSI | AER_RC_ERR_INT)
 
+/* Root Port notifications routed to intreq_pcim_sub ("msi") */
+#define BW_MGT_MSI		BIT(23)
+#define BW_MGT_INT		BIT(22)
+#define LINK_AUTO_BW_MSI	BIT(21)
+#define LINK_AUTO_BW_INT	BIT(20)
+#define PME_MSI			BIT(12)
+#define PME_INT			BIT(10)
+#define RP_SUB_MASK		(BW_MGT_MSI | BW_MGT_INT | LINK_AUTO_BW_MSI | \
+				 LINK_AUTO_BW_INT | PME_MSI | PME_INT)
+
 /* PCIe DMA Interrupt Status Enable */
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
@@ -75,7 +85,8 @@
 
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
-#define RP_LATCHED_MASK		AER_RC_ERR_MSI
+#define RP_LATCHED_MASK		(AER_RC_ERR_MSI | BW_MGT_MSI | LINK_AUTO_BW_MSI | \
+				 PME_MSI)
 
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
@@ -136,7 +147,7 @@ struct rcar_gen4_pcie {
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
-	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
+	/* intreq_pcim_sub ("msi"): iMSI-RX, reset requests, Root Port PME/bandwidth */
 	int msi_irq;
 	struct work_struct link_down_work;
 	/* Allow Root Port event handling after enumeration and until teardown. */
@@ -579,7 +590,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
+	val &= ~(MSI_CTRL_INT | RP_AER_MASK | RP_SUB_MASK);
 	/*
 	 * Note that rcar->rp_events_armed is not checked here because device
 	 * removal may still need iMSI-RX interrupts after Root Port events have
@@ -589,6 +600,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 		val |= MSI_CTRL_INT;
 	if (rp_events && rcar->rp_irq_enabled && rcar->aer_irq > 0)
 		val |= RP_AER_MASK;
+	if (rp_events && rcar->rp_irq_enabled)
+		val |= RP_SUB_MASK;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 
 	val = readl(rcar->base + PCIERSTSTSEN);
@@ -736,12 +749,15 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
 
 	status = readl(rcar->base + PCIEINTSTS0) &
 		 readl(rcar->base + PCIEINTSTS0EN);
-	if (!(status & MSI_CTRL_INT))
-		return IRQ_NONE;
+	if (status & MSI_CTRL_INT)
+		dw_handle_msi_irq(&rcar->dw.pp);
+	if (status & RP_SUB_MASK)
+		rcar_gen4_pcie_rp_irq_dispatch(rcar);
 
-	dw_handle_msi_irq(&rcar->dw.pp);
+	if (status & (MSI_CTRL_INT | RP_SUB_MASK))
+		return IRQ_HANDLED;
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
-- 
2.54.0

