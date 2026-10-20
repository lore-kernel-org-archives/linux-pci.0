Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465862;
	b=1KzsNWfxwj+1ZgruocDOdn6JuPQ1PX9CbNRD/+9L+O6bXZUauTkSIVavGvZ71AfZ9+Ji
	 gS5SIn3rRUCH9mpN2HZ45uTCROwG+h/GkManqJKO+jRcfv4iA9p+wEbARXFmUmwYPQ7tj
	 7QYszlnJBEGLguGOmwxeSeccsxI+AwrytdmrE+txTKefobxZ8EcRaDCHIhzfGt60QUyNf
	 KVa2/Tl8L8xlsDJzuUjY69V11b7zyMhEgtT1CikS9TEhydJw25bqW3vitz1pMTHyZPM1t
	 cqKeye0nrRoR2xiLiPOrO7tPw1ZJKjI1WnyrqygbPnYLoIkEnZdCQVlZdAKn58FFHVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465862;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=r9Mwu06pbMEZNkg8nZvpeCRzkM9iXcaFS6Sv7DgxTrE=;
	b=P69cdry7wZ0m7sgQDTmuekvicUcmp65mECbFgMmAuOzaOyUTtyICDCd7ZW4ef3GQ76QQ
	 WKInjRKAF+ks9aBsRDXyv6V9TPZeE5Dr/IkrEr6CzW9UJMYUVPY03cgInrHXHumiC6MLo
	 7kXly5EHtPtPRPOodbhKncXAu4bhGNWI5+RR3uy9uxDYKnHLjeJJ3ID4CKpel9/Zc190a
	 w4F7h4qNZv7S9Up+zArUcNWPLid5MZlocgUsIrLLEG6W833//L1GeSibQwvCtsjP/YHM3
	 pV9SRa8NrSuqOZ24puahljXIDfmBBG4iOCO+TFSczZJjwmwUg5PFQgPo/KLHAwcoBkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=lbVd4w8Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA59606A31C;
	Tue, 20 Oct 2026 03:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA59606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=lbVd4w8Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWSU5vj3/2O8EnJd+YJIyLe7ZKBZtDJzLoPiNefwV60707Ewd7oHP+g5Y6eYQtyfds1uK6LBtuxY6dXr0DIb7/WcL068LChDtqeVFOEi52p0Zb+e/m1Jcq7MxBeK8yEawyE9HiEFTdRrMxUJsdwzLL7kW0UNh1jAZjjP+A3EmUe+GcUNUu75dfxk6IXWdHbC/v070oE5oiPU2+h3PYMLYevznoqOUqi4bHC8VtJ6ANLiu1endlpSGjMysAHJd+NSIlyb5YZKS4HhZ5KuPQYh4uB0m+ZutkD10rb2DKjswpYu7fGVA3RV//vUFuhqdxwFp5CwBUOEinCv9ezjYJnKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9Mwu06pbMEZNkg8nZvpeCRzkM9iXcaFS6Sv7DgxTrE=;
 b=IRLQueoDEL4anuLp2EtVO985zfTz2owet/ge5HjH9pGr0hKdd2MMRmtJarkwc26V+Pt6fu8twR7peOFAOIu8oS9mhpEQic5jrOqlq9au605Ihd6C3O5yzePABjwHwsNVy4Pxe9am002INo0ODFRcs4pvnhulOI2Dkvf369Y0zFO++q9BkFpHOf7gSgErmXPBQ4ao7TpijJcSFjb+RLvwwN6jrPGa4R8fLiMB8vj+zYP1+ola23uqLGLrmr9xOClFDJKvdB2BzoH0g0lRRFYO3mr4n0EbENuu4Q53VWhkawblau3QpkdiYbPNVAtTR+SfafIazYJEdZTi9bGGn2cUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Mwu06pbMEZNkg8nZvpeCRzkM9iXcaFS6Sv7DgxTrE=;
 b=lbVd4w8ZO8c5eQ20wAnzPPPFubumPM63unT9xu3FCisW4sAzN/GqV+WuxYzUfPEO2E1aVj9Ay8nPTLcMEsRaRNusmE1QIl1r9Oq3gF8i26yv6WQyu1vrKlqXigs6rxO3b2YJvXqZ4QoZizD3cVIUTTcgoKr3AxUUjdeWTF3s4yY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:10:58 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:10:58 +0000
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
Subject: [PATCH v5 00/17] PCI: rcar-gen4: Recover from link down and route Root Port interrupts
Date: Tue, 20 Oct 2026 12:10:32 +0900
Message-ID: <20261020031049.969895-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 0cc8c1cd-b39a-493a-269b-08df2e57c320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|6133799003|18002099003|5023799004|921020|260925022911599003|10067099003|261009223027099003|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nROFO/ytpC1WUr6SGnblW3TYVuG7CjJ16ushcktQD5gVaI4u6iSELLb1tnPLQ5PIWxF+doZTuEiZafz/GiUi0tSgmsyUUv1Zp2uPjd2mZ5mZl+r96/memecbPR/EzAqFCyd0Jsgx3/sPcnGoc9pqK9FizyWw5/ymwjdiQs9OAd+4ZPFxc3BH1leAUVvBGi8umgPPQhZVXj4IQjllAa3IMNshJtn1sdwkelhW6Jd9B6PX6JFmCx2tUFYmpYD+2U9vUYjM1UKWg4aItC9o8BlaogMdKzXQLDDoRqT80vvjyeWi9R6WjtqTT0grE9/2CaT+mqL8aXu1PwtPJyfkTLDVX0k47Zy5VqIcOm0NUYS5apfh4VyEYzP2NEpb7Qvlaw8k3S1oh8CQYd1LIFGTlT1Y2xm3SBYqACwhnFpa9t7ZeRfhlmYTCoiz+Uh28irjQU3lwk0AqA3G5XIVx9RJTtZHLDddpSnNyVL3zr2JAPxSbArLRsJOT5OZ/unzcoMkrBwAiwWRT0PobVHdlmqCNs6MJgQqYsGoTef3KmLyyCxd/2vqPvI2IcY8GBk/pE++LS0Tc++JiX44jJ8EoPgL2IFpAwSqhzAla2X/veKYmB4IzdnpSAD3gTp17GfrUhySmUsgleyhSuipdcFlu3IdzMe7iAU1EqwW63wuMYvFFMWf5Xk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(6133799003)(18002099003)(5023799004)(921020)(260925022911599003)(10067099003)(261009223027099003)(260925021911599003)(260925021311599003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GPVDzTirfpwQh5w70n7dQ60c54sUx978a2N21KphogcZWMse2IHKUKgMVLiX?=
 =?us-ascii?Q?6YyQaSbsxLIR/4BkdyztaTVTXtMaRJ28e5sRSSHDQmWJgECbv5sUrMebQf+Q?=
 =?us-ascii?Q?mnNldHdWIHXthOfqIZx+d/UgfAwwn9NlU3AvPFfA8eQ0WifL+sRpAvwqJqpu?=
 =?us-ascii?Q?QG6U70VXC8Ga4G8v1Y88JC8K+v9ggPur3DXM7Ej95fsXRvSmwCZU8kohfL0c?=
 =?us-ascii?Q?j1rGwLCFFAJLAxxHTg/g2iqACgDUXc7fhGqJz/AMBhNEA4kMukK87XjR2v9F?=
 =?us-ascii?Q?ksjREvJ/PPgAbi0VGF5zq07co7lKsFvRUFpuv5HOSiKFwDrLBhDYQZCFMFm4?=
 =?us-ascii?Q?xgQavO8enSSxt/N+fjwiUpMr+iQsLL0AKov5MO8/I9EfPpd26h3pBXukH5Xc?=
 =?us-ascii?Q?DGJy8ZB9QqNbjhaWZE81Iw5DgJCY94wC9q2HECzrWyx1B5VLm+h7vjNlsqb9?=
 =?us-ascii?Q?CjNO4Aokt1rIHUaEoNZUvnHH+8Y/Aa8Ztc1TwnQ6YtedW+lwDAhkoEjH8mqb?=
 =?us-ascii?Q?K8xPdxLKcc3MDyDsnZgG0CN1CYD5gOBeYSNZn1tG+YmvwGKMes6A8iCZcaDy?=
 =?us-ascii?Q?/2F5/p6D0dKDVrtqNJy3seU4vUb9yAmHgzMjxDiTQmOsvZVmUjEsO3Y/D/1t?=
 =?us-ascii?Q?LMjCsGLXOFG3UU9YIE+wZcqFmA5IixlTxWvloNVPQtyGO/xv6+UmEpZ419rL?=
 =?us-ascii?Q?P3EGiXgHnlYbPQNQN3otqO2gsf42ByeffniMBNnwfQWfTg/9jfxLqNcG9mT+?=
 =?us-ascii?Q?ParBz9TFFnHaeJ2fPruHOwoLOJtZeve65f3+uoxXUpAxtIVHVQ/QEnYqBnYQ?=
 =?us-ascii?Q?b8JF86PTjNjUWge0c/58Nvgvukqt/1/tO6Pb6CKOYMcW84kFN+iJnm3B7nd9?=
 =?us-ascii?Q?C03TuRZvnWnIokEN1nIoBGY36DCSLreQtMA7oEBCwEjzQ2B1OfjHeGE8h5nw?=
 =?us-ascii?Q?DybHcSb5YCwYxE9nHEJaeTIA1JACDf+BNzn9WWsQHGz28jiMP07nR6cgrbCM?=
 =?us-ascii?Q?WkAlTykwr7sgle8cYQxARHG4ZttP4h5geFAIrnfVl2/67JklxzOD5VDHgvhR?=
 =?us-ascii?Q?rI5jya9rtDXQNveBzqZN8DnaX+2+RENuJyvxzbwTeKW+UDFD6Fa1olGV0gCB?=
 =?us-ascii?Q?7vRx9vNZqPU5W1Ce19NxAFJxA6sSyBXgZp2yWqru9a0ywQEE2AVF3Qn/E5qz?=
 =?us-ascii?Q?sKNVLDvVw4o9fJ7TSHpvGVmJdlyuNooYle5AYuz8wvMfULMP6iTTjPSWJclo?=
 =?us-ascii?Q?Bv5usjz0WD4EpJOuaKtVgg3El8h8m1O5Qaw+gCs42dodPdqYjx4WR1bcqLFJ?=
 =?us-ascii?Q?2kpPQ7i2ek+A2ytYc7MicXMwZJokxtcq76nQFwbjHEkWOKtoAnO3Kzvs89C2?=
 =?us-ascii?Q?nC6XK9KhQJKc8Q4jaTjKz98pJHOVnudQZPtGTev3KW+mXRwt/cfa48lW2uYE?=
 =?us-ascii?Q?tPk3a5dj41RG6JM3HgF0fpxJ7Dx5b27hoZrGDE/XkDe5J8S+wbTSiGuN7Tay?=
 =?us-ascii?Q?ayyW5rUphP2F+emhL/R8qUhGIDJ05k2ZJvpeyijtGtDtrxqxjC9QZLtL02Dt?=
 =?us-ascii?Q?y99iVwrH2AFEX+9bbD1pZ0Q//lRqBYv+X+JCprEzkkmrqGyK3gDOv+DhZt31?=
 =?us-ascii?Q?d1IfJ/Sr0Tf6Rg1T29qZP4rciBsaRqOCfkSCnW4jVXJKmUS1sRvRVm5XSWpI?=
 =?us-ascii?Q?f+qQX+sNdYP+NNLIqbHoXu+hic45SKRX2onup4eQwVDdO8/StiWEUMCk0kgK?=
 =?us-ascii?Q?ovK9mu9MIsKVy7DQ/TkHwhfBrWV9S/sOUiEqTJbmrtaVDrkT3pOY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc8c1cd-b39a-493a-269b-08df2e57c320
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:10:58.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQohaHlIasj1Fe6FQAtBxGg1rRXxTZqVwhwja3t+P8nyH5sIlQqs+maymfhCM45pDbC2Yjujn6bmFspHxqSv/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

Hi,

This series improves error handling in the pcie-rcar-gen4 driver, which
supports PCIe controllers in R-Car Gen4 SoCs and the PCIe4 controller
in R-Car Gen5 SoCs. It fixes unexpected link-down handling so the host
doesn't hang, and wires up missing Root Port interrupts (AER, PME,
bandwidth notifications) so port services actually work. I tested on
an R-Car S4 Spider (r8a779f0); Marek tested the link state fix and the
Root Port AER and bandwidth paths on an R-Car V4H Sparrow Hawk.

A few hardware quirks made this tricky:

1. PCIEINTSTS0 link-up bits don't track the actual link state. The
   driver never noticed when the link dropped and kept trying config
   accesses on the dead link. Patch 3 combines the APP link-up event
   check from Figure 104.5 with the PORT_LINK_DEBUG1 live link check,
   which patch 2 factors out of the DWC core. Startup clears the APP
   latches before enabling LTSSM, and the DWC core polls the combined
   condition on the RC side.

2. On S4, a DBI access immediately after an unexpected link down can
   hang the host. Commit 0056d29f8c1b ("PCI: rcar-gen4: Assure reset
   occurs before DBI access") describes an SError on V4H after reset
   deassertion, but whether the S4 hang shares the same underlying cause
   has not been verified.

   Adding a delay before the DBI access avoided the hang in my tests,
   but that alone would not provide link-down recovery. Also, the reset
   request shares intreq_pcim_sub with iMSI-RX, while AER arrives on
   another IRQ. Delaying AER dispatch alone would therefore leave the
   MSI handler exposed, and both paths would still need coordination
   with the controller reset.

   The driver handles the reset request itself and schedules
   pci_host_handle_link_down(), as the rockchip and qcom drivers do.
   This also provides recovery with older DTs that have no "aer"
   interrupt, without relying on AER to initiate it. The reset callback
   shares the reset sequence used at probe, including the reset-status
   readback and delay added by 0056d29f8c1b.

   This covers the interrupt paths that fire on link down. Port service
   threads or work already queued or running at that point are not
   stopped.

3. Root Port interrupts only trigger APP status bits on platform IRQs.
   The controller appears to lack SII2MSI, so Root Port MSIs never reach
   the GIC ITS. The Root Port's INTx is routed to intreq_pcim_sub as
   well, which the driver holds, so port services can't request it
   either. This series works around it by hiding Root Port MSI caps
   across the board and emulating INTx using a virtual IRQ domain, fed
   by the "aer" IRQ and intreq_pcim_sub.

Patch 1 is only loosely related: it adds Renesas to the RAS DES VSEC
list so the DWC debugfs error injection works on R-Car. I used it to
test the Root Port AER path (see below) and included it here for that
reason. Happy to send it separately if preferred.

Note: backward compatibility with older DTs is kept. Without the "aer"
      interrupt, only Root Port AER remains unavailable. See the testing
      section below.


Dependencies
------------

- [PATCH 0/2] PCI: dwc: Clean up DWC PCIe register macros
  https://lore.kernel.org/r/20260911162537.469018-1-18255117159@163.com/
  (*already landed in controller/dwc and pci/next)

- [PATCH v5] PCI: rcar-gen4: Add missing PM ops
  https://lore.kernel.org/r/20261004011851.866833-1-marek.vasut+renesas@mailbox.org/
  (*already landed in controller/dwc-rcar-gen4 and pci/next)

- [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ with AER IRQ on R-Car Gen5
  https://lore.kernel.org/r/20261003215710.792518-1-marek.vasut+renesas@mailbox.org/
  (*under review)

Applies cleanly to -next (e.g. next-20261014) with the latter two
prerequisite patches applied first.


Proposed merge plan
-------------------

With v5, this series seems to have almost converged, so I'd like to ask
how maintainers would prefer to merge it. Any advice would be greatly
appreciated. Here's what I have in mind:

To Mani:

  I'd expect patches 1-14 to go through the PCI tree.
  One option would be a two-stage approach like:

  1. Take patches 1/2/5/10 through controller/dwc ("PCI: dwc:" patches).
  2. Once those patches are available in controller/dwc-rcar-gen4,
     take the remaining patches 3/4/6-9/11-14 there
     (the R-Car driver and binding patches).

To Geert:

  Once patch 4 is available in renesas-devel, I'd like to ask you to
  take patches 15-17 together.


Re-tested with v5
-----------------

Setup: R-Car S4 Spider (RC) linked to another S4 Spider running the
       pci-epf-test endpoint. pci_endpoint_test is bound on the RC side.

  1. Link down / recovery. On the EP side, toggle the endpoint controller
     off and on. The short pause keeps the endpoint away long enough for
     the RC to notice, but brings it back within the reset window so
     recovery can succeed. Adopted the test approach from [1]. Make sure
     that the unused function 0000:01:00.1 was removed on the RC before
     testing.

     # cd /sys/kernel/config/pci_ep
     # echo 0 > controllers/e65d0000.pcie-ep/start
     # sleep 0.1
     # echo 1 > controllers/e65d0000.pcie-ep/start

     Expected on the RC dmesg:
       pcieport 0000:00:00.0: Recovering Root Port due to Link Down
       pcieport 0000:00:00.0: Root Port has been reset
       pcieport 0000:00:00.0: AER: device recovery successful

     and the "msi" (intreq_pcim_sub) interrupt count going up in
     /proc/interrupts. Without this series nothing shows up here: the
     link comes back on its own once the endpoint returns, but the RC
     never notices the outage and the endpoint is left unconfigured
     (see 4). Config accesses issued while the link is down hang the
     host.

     [1] https://lore.kernel.org/r/abFMa6DCGGLUHddA@fedora/

  2. Bandwidth notification. On the RC, retrain the link:

     # setpci -s 00:00.0 CAP_EXP+0x10.w=0x0c23

     Expected:
     - the virtual Root Port IRQ (rcar-gen4-rp in /proc/interrupts,
       shared by PCIe PME, aerdrv and PCIe bwctrl) fires once
     - bwctrl clears LnkSta.LBMS
       (setpci -s 00:00.0 CAP_EXP+0x12.w reads 0x2024 again).

     Before the series LnkSta read 0xe024 afterwards, LBMS and LABS
     stuck.

     This test does not generate a PME. The PME service shares the
     virtual IRQ, but its path was not exercised separately.

  3. Root Port AER. On the RC, inject an LCRC error with the DWC debugfs
     (patch 1) and issue one config read so a TLP actually goes out:

     # cd /sys/kernel/debug/dwc_pcie_e65d0000.pcie/rasdes_err_inj
     # echo 1 > rx_lcrc            # error detected by the Root Port
     # setpci -s 01:00.0 VENDOR_ID.w
     # echo 1 > tx_lcrc            # error detected by the endpoint,
     # setpci -s 01:00.0 VENDOR_ID.w    # reported back with ERR_COR

     Expected on the RC dmesg, respectively:
      pcieport 0000:00:00.0: PCIe Bus Error: severity=Correctable
      pcieport 0000:00:00.0:   [ 6] BadTLP | Receiver | Data Link Layer

      pcieport 0000:00:00.0: AER: Correctable Error message received from 0000:01:00.0
      pci-endpoint-test 0000:01:00.0: PCIe Bus Error: severity=Correctable
      pci-endpoint-test 0000:01:00.0:   [ 6] BadTLP | Receiver | Data Link Layer

     plus the virtual Root Port IRQ count and aer_rootport_total_err_cor
     going up by one each time. The link stays up throughout, the DLL
     retry recovers the TLP. Before the series nothing is reported.

  4. Regression check. Run pci_endpoint_test after step 1. PASS/FAIL/SKIP
     counts match a run without step 1.

Configurations:

  a. Without this series**
  b. GIC ITS, DT with the new "aer" interrupt (this series)
  c. GIC ITS, DT without "aer" (b43aa6a6ebe8 ("arm64: dts: renesas:
     r8a779f0: Add GICv3 ITS and update PCIe nodes") or later)
  d. iMSI-RX, DT without msi-parent, msi-map or "aer"

Result:
             recovery   bwctrl       RP AER    pcitest
  ---------------------------------------------------------
  a.           none         no         no      all FAIL
  b.            ok          ok         ok      no change
  c.            ok          ok         n/a*    no change
  d.            ok          ok         n/a*    no change

  *  Root Port AER needs the "aer" interrupt; without it the behaviour is
     unchanged from before the series.
  ** Only patch 1 applied on top of the base, so the same debugfs error
     injection could be used for the comparison. pci_endpoint_test fails
     across the board there because nothing restores the endpoint after
     the toggle.

Best regards,
Koichiro
---
Changes in v5:
  - Drop no_rp_msi patch; handle it in R-Car host setup instead. (Shawn)
  - Use scoped_guard() in the MSI setup error path. (Marek)
  - Collect R-b tags from Marek, Shawn and Rob. Thanks for reviewing!

Changes in v4:
  - Rebase onto next-20261014 with Marek's Gen5 AER binding fix.
    Only patch 4 needed changes.

Changes in v3:
  - Rebase onto next-20261002 with Marek's PM ops v5 applied first.
  - Keep parent IRQs registered across suspend/resume to fix the
    unbalanced enable Geert reported. Request them in probe with
    IRQF_NO_AUTOEN and enable/disable them in .init()/.deinit().
  - Use a freezable workqueue for recovery and reject suspend while
    reinitialization is pending. Re-arm Root Port events only after
    resume has set up the link.
  - Factor out the PORT_LINK_DEBUG1 check (patch 2) and reuse it in
    patch 3. (Marek)
  - Replace .reinit() with .configure, folding v2 patch 8 into patch 9.
    Drop the reset mutex and rely on PCI core serialization. (Marek)
  - Free the MSI domain after host .deinit(), so the driver can stop
    its parent IRQ first (patch 10). This closes the known gap in v2.
  - Reset the controller if recovery finds no Root Port, so a successful
    reset can restore interrupt delivery.
  - Drop the raw lock around virtual IRQ dispatch. Preserve MSI-form
    latches in irq_ack() while the IRQ is in progress or disabled,
    avoiding lost notifications without nesting port service locks.
  - Add patch 7's Fixes tag, clarify SoC generations, separate guard()
    from goto-based cleanup, and simplify IRQ return statements.
    (Marek, Sashiko)
  - Add the V4H and V4M DTS patches 17 and 18. (Marek)
  - Collect Reviewed-by (Marek, Krzysztof) and Tested-by (Marek) tags.
    Drop Marek's Reviewed-by from the reworked patches 12 and 14.

Changes in v2:
  - Rebased onto next-20260925, including Marek's R-Car X5H support.
  - Keep .link_up() and require both the APP link-up events and the
    PORT_DEBUG1 live link check. Clear the APP latches before enabling
    LTSSM and reuse the DWC core's polling on the RC side. (Marek)
  - Let the R-Car driver own intreq_pcim_sub in all configurations (new
    patch 10) and check the reset request from its own handler instead
    of hooking into the DWC chained handler. Replace the pre_msi_irq host
    op from v1 with an export of dw_handle_msi_irq() (patch 4). (Marek)
  - Keep the reset_control_status() check before asserting the power
    reset. (Marek)
  - Separate controller reinitialization from .init()/.deinit() and split
    out preparatory changes.
  - Use bool flags instead of a state bitmask. (Marek)
  - Keep Root Port AER notifications masked until .post_init, after
    enumeration. In v1, they could be enabled during port-service probing.
  - Keep APP interrupt sources masked if the Root Port reset callback
    fails, regardless of the reset trigger.
  - Hold a reference on the Root Port in the link-down recovery work.
  - Clear only the MSI-form Root Port latches through PCIEINTSTS0CLR;
    the INTx bits are reserved there.
  - Serialize dispatches to the virtual Root Port IRQ from its two
    parent interrupts.
  - Collected Marek's Reviewed-by on patches 1, 3 and 15.

v4: https://lore.kernel.org/r/20261015033103.3076869-1-den@valinux.co.jp/
v3: https://lore.kernel.org/r/20261006084638.3821710-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260928165230.3397664-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260918032038.2216471-1-den@valinux.co.jp/


Koichiro Den (17):
  PCI: dwc: Add Renesas to the RAS DES VSEC list
  PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
  PCI: rcar-gen4: Check live link status in link_up()
  dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt for R-Car
    Gen4 SoCs
  PCI: dwc: Export dw_handle_msi_irq()
  PCI: rcar-gen4: Move deinitialization helpers before SoC
    initialization
  PCI: rcar-gen4: Assert resets when Gen5 SoC PHY initialization fails
  PCI: rcar-gen4: Separate hardware setup from resource acquisition
  PCI: rcar-gen4: Add Root Port reset support
  PCI: dwc: Free the MSI domain after the host .deinit() callback
  PCI: rcar-gen4: Take over the iMSI-RX interrupt
  PCI: rcar-gen4: Recover the Root Port on link down
  PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
  PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
  arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
  arm64: dts: renesas: r8a779g0: Describe the PCIe AER interrupts
  arm64: dts: renesas: r8a779h0: Describe the PCIe AER interrupt

 .../bindings/pci/rcar-gen4-pci-host.yaml      |  13 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     |  10 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |  10 +-
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi     |   5 +-
 .../pci/controller/dwc/pcie-designware-host.c |  32 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  15 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 725 ++++++++++++++++--
 include/linux/pcie-dwc.h                      |   2 +
 9 files changed, 721 insertions(+), 92 deletions(-)


base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
prerequisite-patch-id: 5b4c9da1333342baa90cf6a86dc879e8382d3f65
prerequisite-patch-id: 258bbb5c2aaf676b727308d4e97d52f9c313eec0
-- 
2.54.0

