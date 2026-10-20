Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465869;
	b=vqtA22R9DIFDZ5JTXrQ+fcrSaNU3qNcchaAD7hLKAzkaLxbntZ9N7VFcY3xLTVYARTws
	 ty8zspybUCcelNgQ4AwUuOKkx+aZCBCPT1BkLF5rvbwH2BC2eV7ijb52ppCSsnXi64MRm
	 JhQC7IZ9MOaGqJdxNnDEmMSP48YiD1n2qE85DuyHN2XFRoqXhKqjILzMaCPBxc1pBxSeV
	 0G4pyaHpYV8kMlthp24bEjC5aj+crrCFt4jKmWcb3GZ63QHDVPAR/fsCjhlaareix9nv/
	 CmK6JNS1IHlRhjINjJtxiexl8qJW6s1gxZLl9DagTIPTiPKrRNS8+4ApSb8nFkxpxUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465869;
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
	bh=ndTKSt3WvPrgO7GTUf43y10rju7XSmbZXdVw4Ewt39s=;
	b=2b+BgZlO1VOSaaEDbgYiP2QzVvO/B18EIwwulmSAM/ozf07INvC/lguIrQBvdSOSDKNk
	 xzq7N9Nag2mXs+QrsH2BEwpCVOsI6+49FQXr1Lgn9wm86nfggGQ50ZO4rDcTG7Ate7N6J
	 yJy3/OzAnzR8vvdpBP3W7Yal5gUPSb5RJiIaGI37v/Zif6cMdwBhB9HSaJ0v+wEneIUkK
	 f0ztgslavYrzjkuvNuXCL0/upi/cFVyy2lrdWqmC38s/pxBQ1QXz1wJ6ASesi0dtWi51l
	 PLnpyiOY3CuxqNRotPxQkz1Qi2Yf/1SYONYOifXpRGQ6L8eBWOW/dkVA1ZBGnE4SL+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=mIiyaMrg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1360A263B;
	Tue, 20 Oct 2026 03:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26F1360A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=mIiyaMrg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B51MWRsgJ/ofQGeFKFhGR2uNKDpSdm59lvPNSLLj7vOhLPwCx2L+l2x9PRAfkQsPsH1OcEtHzTOCzeW+frfLeqKwQDU//LzCsim5z7ayQzDMglkQYm//IVSIVJOklDmd9W68MNl1ZWV3hl6Dyu3rUMJgsMHKfl5NsinZu+ZiiqFfCT8lEWNJLTZo89f9Rdc0avt6FOvAvlJkB+mxqHZ3wzbQXAbB1kSfq9SmWwCThzP1/sYKaKT2tYEOty+dz7zmqInQDkf6xbJm3YUUaGWKZ3t6ke2vEaGb6s2Pu1UDcrluMo5alvOU63mZjdH/7KZtbX9n07bAdnwp+yzjJEQCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndTKSt3WvPrgO7GTUf43y10rju7XSmbZXdVw4Ewt39s=;
 b=FAIwN+I9w6bMIu2bG7Wo3YbuiIny5gJ4xdQ4mfv5VPOcXoVUb2Ecb7i/skmHSVj8jwZrXkiEo/6niawFHui08Mzii+X2QktUCnyPZ97xrSJ1oIgSWvUiVNfqgKgqIcUGESUKbjigmbnaTC76T34Zv1tDEQui9Cpnvq8r6giVxSBEoPDoU5P968nrMuzWQQ9R3HBeW1E1PSBp2kjB3gVzbIdi+/gRLFNAg2fQo+3iKZGeU3FpSOwdCRw/2tgxSZBcLfjiti46SA163PvGFzdjR0MJ5CrPYykAkQcMEw5aZU5tOPdc/E9Kmq9H8doBOhiILq2RoQKElDReNH2EEoQMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndTKSt3WvPrgO7GTUf43y10rju7XSmbZXdVw4Ewt39s=;
 b=mIiyaMrgCkP8UpFFj4Wb4CZDmIY9HpOeciFqSq+vkWPMGNjqrH3FK4jSlo+EG7JvO7yJme4YlgXIXd8zaHHwbgNBoGmhPk+yFlauJS/lSVJZPIcFIXF9pQeHLGr7LOh5ApEKKAyR8mxTZ6juLiYxeR4WvWW6AKMGPMn4XTElZHI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:06 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:06 +0000
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
Subject: [PATCH v5 09/17] PCI: rcar-gen4: Add Root Port reset support
Date: Tue, 20 Oct 2026 12:10:41 +0900
Message-ID: <20261020031049.969895-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 8a9aa9f5-2e6d-459d-23e7-08df2e57c81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|6133799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uZKYxVoWBFlEYFRn2rOPQGKQZKCbhP0fBH33HGn35g1vdVia/WUecfLTiJoPzdqte+XE+yM2R6Y05dI6bHKcRgbZTPlRqXERm1mjR+szwvbn9vRLd3bDKZ+64vbA8jH+WSKFDf8b1cNmhGH3Fso3jONLf23Tod3GxPDigiK3kpMp3jqLfeAuZatcdUgRaGVKM3VCPm5iWnjR4PQl1JNo75eihp7e8/9vMSuHHrdcrud9W9fICF2tdlF22fpGhFzcJQ2zZh9vdMDo2HIwY88D1UhAsCAhY0IWHDkpTnXiUnMtF3ks25yd3q29yQ7igCMV52bLhxAo7h2e93VqUydATXJKKmcjMsMDAjVn+lCP0LHq24qv19g6bnJiIQtmVU8PgjEcVCAZTPJuMUTh5PHlv0BHfwzNsKD9Qeg+DGKr4EwKrXYngGOHvb3uPu/E1q0IJ5x2O7uLLBN5Z0wiXLuP4MsKUzyChDVAzbTFma0VDUuo1x0wSMSLm34PwYyeBvuTdtw6lne/nlx19eO+JZaHAj3b3SZy2/YeLYLaDcKxAFCOq+s+u3yywLQced0LDm/Q8Ua2SKa7yX64Kai63v2G+FRu1EIJ9e3WIrgIdMZPTqAG04rw7LwNjuZ0lTrmbby8qzHp5+Cd0x5eGWYT2ftDI9AIL1QK6rYrd0jBMe2/a6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hI0nklfAz5JA/4vx04VGu3ZZkAXWQMLcNQXlHTBvhwMr7vJLXJNopcN0+CPk?=
 =?us-ascii?Q?vTB860bS1rFO2WGo2X5Jjt6LMSuXQnjh1ekyVfW5IENmntnzV6l79YKisbDn?=
 =?us-ascii?Q?Ulx3kKGQM0AXOtZdT0xob/O92ncPLI7d7gdSDmOr0n6vL2F9wAdRNI7Da8cA?=
 =?us-ascii?Q?jF/iaz+dhPLjTkxrwBZ//e1r/J796e75RTML+1zWAqC/iJrepNYQo9qjkdRA?=
 =?us-ascii?Q?CHY5EFsXUwAb5S2d+BzJHAnSaA1TO02HE6M6NzL1YNzKy3HQy4WgcZynVhjZ?=
 =?us-ascii?Q?QdSowKisS6VbKdwLM+aXgbCaihZbk9mwStgKk2Eb0B4sVzBZVzeQ/B8Yal1y?=
 =?us-ascii?Q?ZKUkC8n/BwstqLmMv6aPjNswnYtDwRFpC6D1qWncp2v/b3lksT8wz6dgHD5o?=
 =?us-ascii?Q?u6Kfg+T0QuhsmQpBpOs3iQ9vNmoRJenT3SN3sXhUGygS00LBIWS4KYxsAE1/?=
 =?us-ascii?Q?pZ4kl17bi0CDBC1zv6tpAbgDF5D0wqtrVPLrNCStcleqe6nI0tWAKxakhtWC?=
 =?us-ascii?Q?L132I8sAeAsilPSxDfZNxVXYZKZpwnc7Mrn+1bgsESlMi/PaZDKHZyui9/u7?=
 =?us-ascii?Q?EdaCZ/4MB5jtKcFDOwzP1lSAlOkYpxe5aB1uRffEZQQZSJ3QkVFrSjRHHJsh?=
 =?us-ascii?Q?fLCtDGGaC/7VUalHu2/lJLXyXm8SsKpa/DCTh8TXBxP8uog3MJgv3LOby697?=
 =?us-ascii?Q?uBju7eTrCHX4VM7ms7gejVJ8wEPFf1YV7C8skgGKGPhkfHBiKcD9DpweE9CG?=
 =?us-ascii?Q?F8AQj11Fv6zCCtdYFUIoFmcLOOoy8dOzywFgqIhXHt7JpDclct6F8i5ViqHn?=
 =?us-ascii?Q?o0Zj8hj/q4QDW2JAjdvT9ousqvHIiQZx0K/DfmBnyetAxnhJcnjhFdLcqa4S?=
 =?us-ascii?Q?2ZIcnMtup3zzxa/3jrbwD+zdEKMz8kGqAsD1x7rGDF1HpJBfuL8bCBBZMaXx?=
 =?us-ascii?Q?Ds3adlaHVfWlGXWSgtMcIDSvjnnOgEJgBCG7aHwk5WmblO7929bxwGie9FCA?=
 =?us-ascii?Q?xvGEhlZrGlD4wHckAlrUIO3waldouZ+LtvZ3hqS3uFjZJqODPG/zesyy1GRf?=
 =?us-ascii?Q?ADyhmAph7C6fC3AZGGCNEA0s/9sUUqZ8l2Qd63ZqPjyo2b93tFialrS1zD7+?=
 =?us-ascii?Q?EPnz1iBRT9+ktdRll78CLQan/OjSOFBBsUK77JkdO2FU4gXRdV69KTGOo/Bn?=
 =?us-ascii?Q?Po/pLUIxAnSfmG2Ob/9002fjQDlco55m24U+2BRROW3gEirCW8XViVUr/dBQ?=
 =?us-ascii?Q?IjbHq/n/Yi85+5+UKipWkwBN6CBxKHMFXGqkj7TuoQ5JIs0wgz1u6XTLbMZy?=
 =?us-ascii?Q?TlpOXl/+AXpVCq/mYJp+ZGTqrerU05nKSnR/qXUmXfWLpJqhXg1PE88N22lq?=
 =?us-ascii?Q?v3vtmBJE9EiDUwopI1RgugcD8V/tA269MSxiQoccC9ctVrH2er+ifKBl2a7G?=
 =?us-ascii?Q?l4gRIRSFIrDjGndhPfoHNF4GKyU5QlzMHXVcAcHLyf71OUOzsvzZY7m/vrBo?=
 =?us-ascii?Q?EiF6TPyM81iUW7jMB/dXdnSZf09MYNQme64Tn8MTEy8Q4zL+KCKeJGPxGpcA?=
 =?us-ascii?Q?W/TCJsMaO+e8fWY2IxCx08IVxjgVlgRGJc0cHur26tQ+FRShNbPi6MuVC91H?=
 =?us-ascii?Q?LU+5IZ2vb8aiIXLppn+u73AbhNEDFQKAbpk130p3Q17zLegQuaNjooV/TUH5?=
 =?us-ascii?Q?5Zorhq5mZD8Ib7huRNB0a+mpFyVViREOMEo3tshT4mpnjjBJwfI795iQm48l?=
 =?us-ascii?Q?pIAXU464FfykmPMy5T5RiXsfZzo8zn/21xVxUnqCG1UdmI0BhLl6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9aa9f5-2e6d-459d-23e7-08df2e57c81c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:06.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgzTSidD1OJwBvMSgpTkAiKzkcu/OBkOp8Wb2FI07OiX5gDEEDnZiNNKIBj5fWGTCKYFTGRlFs8Fhz0XDVruEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

Implement the host bridge reset_root_port() callback so PCI error
recovery can reset and reinitialize the R-Car controller. This also
provides the reset operation for the link-down handling added later.

Reinitialize without going through .deinit() and .init(), which would
release and re-acquire the clocks and the R-Car Gen5 SoC PHY: split the
SoC-specific register setup that the power reset wipes out into a
.configure callback and repeat only that, then restore the Root Port
registers and restart link training.

Rather than tracking which APP interrupt enables survive the power
reset, derive them from software state through a single helper. A flag
keeps the sources masked from the start of a reset until one succeeds,
so a failed reinitialization does not re-enable them against an
uninitialized controller.

Reject a reset while the controller is suspended, as a failed resume may
have left it powered down.

Track whether the R-Car Gen5 SoC PHY power-on has been requested so a
reset retry, or teardown after a failed reset, does not call
phy_power_off() twice. Continue to ignore the PHY power operation return
values.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Use scoped_guard() in the MSI setup error path. (Marek)
    https://lore.kernel.org/r/0fece6ed-e91a-4d35-99ab-ce3f4fd789a9@mailbox.org/

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 146 ++++++++++++++++++--
 1 file changed, 136 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index cbd22e6bb44b..420392ace349 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -99,6 +99,8 @@ struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_drvdata {
 	int (*init)(struct rcar_gen4_pcie *rcar);
 	void (*deinit)(struct rcar_gen4_pcie *rcar);
+	/* SoC-specific register setup, repeated after a power reset */
+	void (*configure)(struct rcar_gen4_pcie *rcar);
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
 	int (*speed_control)(struct rcar_gen4_pcie *rcar);
 	enum dw_pcie_device_mode mode;
@@ -109,9 +111,17 @@ struct rcar_gen4_pcie {
 	void __iomem *base;
 	void __iomem *phy_base;
 	struct phy *phy;
+	bool phy_powered;
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/*
+	 * The controller needs reinitializing; the APP interrupt sources
+	 * stay masked until a reset succeeds.
+	 */
+	bool reinit_pending;
+	/* Protects APP interrupt enable registers and their software state. */
+	raw_spinlock_t app_lock;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
@@ -322,6 +332,21 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
+/* Reset and restore registers while clocks and PHY remain initialized. */
+static int rcar_gen4_pcie_common_reinit(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
+
+	ret = rcar_gen4_pcie_reset(rcar);
+	if (ret)
+		return ret;
+
+	if (rcar->drvdata->configure)
+		rcar->drvdata->configure(rcar);
+
+	return 0;
+}
+
 static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -513,6 +538,26 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 	return 0;
 }
 
+static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
+{
+	u32 val;
+
+	lockdep_assert_held(&rcar->app_lock);
+
+	val = readl(rcar->base + PCIEINTSTS0EN);
+	val &= ~MSI_CTRL_INT;
+	if (!rcar->reinit_pending && pci_msi_enabled())
+		val |= MSI_CTRL_INT;
+	writel(val, rcar->base + PCIEINTSTS0EN);
+}
+
+static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
+{
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
 static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
@@ -543,12 +588,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	}
 
 	/* Configure MSI interrupt signal */
-	val = readl(rcar->base + PCIEINTSTS0EN);
-	if (pci_msi_enabled())
-		val |= MSI_CTRL_INT;
-	else
-		val &= ~MSI_CTRL_INT;
-	writel(val, rcar->base + PCIEINTSTS0EN);
+	rcar_gen4_pcie_app_irq_sync(rcar);
 
 	return 0;
 
@@ -563,9 +603,11 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	writel(0, rcar->base + AXIINTCCONT);
 
 	/* Deconfigure MSI interrupt signal */
-	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~MSI_CTRL_INT;
-	writel(val, rcar->base + PCIEINTSTS0EN);
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		val = readl(rcar->base + PCIEINTSTS0EN);
+		val &= ~MSI_CTRL_INT;
+		writel(val, rcar->base + PCIEINTSTS0EN);
+	}
 
 	return ret;
 }
@@ -661,14 +703,87 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->reinit_pending = true;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
+				       bool recovered)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->reinit_pending = !recovered;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+/*
+ * R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller have
+ * a single Root Port per instance, so the 'pci_dev' is ignored and the whole
+ * controller is reset. The PCI core serializes the callers through its
+ * device locks.
+ */
+static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
+					  struct pci_dev *pdev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
+	struct dw_pcie *dw = &rcar->dw;
+	struct dw_pcie_rp *pp = &dw->pp;
+	struct device *dev = dw->dev;
+	int ret;
+
+	/* A failed resume may have left the controller powered down. */
+	if (dw->suspended)
+		return -EBUSY;
+
+	rcar_gen4_pcie_quiesce_irqs(rcar);
+
+	dw_pcie_stop_link(dw);
+
+	rcar_gen4_pcie_host_perst_assert(pp, true);
+
+	ret = rcar_gen4_pcie_common_reinit(rcar);
+	if (ret)
+		goto out;
+
+	ret = rcar_gen4_pcie_host_setup(pp);
+	if (ret)
+		goto out;
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto out;
+
+	ret = dw_pcie_start_link(dw);
+	if (ret)
+		goto out;
+
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(dw);
+	dev_dbg(dev, "Root Port reset completed\n");
+
+out:
+	rcar_gen4_pcie_resume_irqs(rcar, !ret);
+	if (ret)
+		dev_err(dev, "Root Port reset failed (%d); interrupts stay masked until a reset succeeds\n",
+			ret);
+
+	return ret;
+}
+
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	if (pp->bridge)
+	if (pp->bridge) {
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
+	}
 
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 
@@ -708,6 +823,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
 		return -ENODEV;
 
+	raw_spin_lock_init(&rcar->app_lock);
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
 	pp->use_atu_msg = true;
@@ -944,11 +1061,17 @@ static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	}
 	writel(val, rcar->base + PCIERSTCTRL1);
 
+	/* A reset retry may find the PHY already powered off. */
+	if (enable == rcar->phy_powered)
+		return 0;
+
 	if (enable)
 		phy_power_on(rcar->phy);
 	else
 		phy_power_off(rcar->phy);
 
+	rcar->phy_powered = enable;
+
 	return 0;
 }
 
@@ -1141,6 +1264,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.configure = rcar_gen4_v4h_v4m_pcie_configure,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
@@ -1149,6 +1273,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.configure = rcar_gen4_v4h_v4m_pcie_configure,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
@@ -1157,6 +1282,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
 	.init = rcar_gen5_pcie_init,
 	.deinit = rcar_gen5_pcie_deinit,
+	.configure = rcar_gen5_pcie_configure,
 	.ltssm_control = rcar_gen5_pcie_ltssm_control,
 	.speed_control = rcar_gen5_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
-- 
2.54.0

