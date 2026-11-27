Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749147;
	b=5nqmM0FdR46s7e4sa/D8ELpOL9SW7Fuz1nepGoy/nuNIzV+ev211z18USQ44JX+btc+/
	 c6EIad9zJN2pnAjMp806rKf5j9Vy42XwbgcxXLa7Gzv34Qm0sH+aHFseAzevt9P6jk9yW
	 nb4iXGMJP8tYykJLspvr8n6rhzbfD+h1quNSbA4KZ7MtwH+M4hFRY6rq8o1hdWPiuvRIb
	 Gp3cvgEvTONEyaKB7z+UNDWRoxWSC49EkTzVX5i+WLinbVuZrh0zmSWWX4AE5U7vSvJcn
	 ecpq25p9GpoJ6nnkthbvHU4dNnYu80rWr9FzCHuB7zQfDT9kFsgm+nAoatN1ahiNy/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749147;
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
	bh=leH+0GwJiMBNKdkwpucvi+Qn0Sd0LrprCfsKkreY8do=;
	b=JvmGTHD19YHyAS7CEdULOy/S9k+uDS0wNHjvoXqNS9bg1mZw0n/sQ1iB7BF79jOJ8BcL
	 uaJgfljz0cqeo+N8FSeyhjJ+PM7ViCWxY7LRASQq7A+GGB1eeS4pJe70T8s/7fcDCvF4o
	 lll3U5Jl9q2EK36/i8cwj+0QC2GDrCf+9IA6Y8hZ59LQeZ+9zG1x7/OWP0s1uR0ApdRvY
	 x8P/HAHMurEutRfU+tK1PjqJ6fgrst7IKHL8gG1WGTQWh+fUJssTsXCA47aupKVG9B+dn
	 ZhrdZSNpRqk1ceW+MP65tple2LiavaUTKH2lGhnpQqkI1JZyfqWt3KB65ioe95gm7sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=as2os8nu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC760A3817;
	Fri, 27 Nov 2026 03:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAFC760A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=as2os8nu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyLtetZ0hcQ7yuzDhKAf1Zo6sBi3X4HmaCB90/MkZPU43cdN/GKT4A810MeVlGU7OLyC5aiePo1RyEZGRlJ5/UwJwGCnA/Z7TWgGHCHbnOB6BronTdc6yvZACjxjppr44SwIeLeKWnxVuRY6CJNWCdyPpD6155pGPBK9p/p8FKGM4ckxzmml7CMkc0ir3JByDLPoFCyfAogiKn5HEUb6UTszogqSRb7T1aUydHXrf8Y1b/nlaVyVEdAv7gq4QnHzazIMB/YA8nQrVBaDinAk1Y/NaXi3y6gD2ErTsawfvdhq21khK5LMXt/2Ssl6DpfhtQgPp4l+K2o4zweYKByQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leH+0GwJiMBNKdkwpucvi+Qn0Sd0LrprCfsKkreY8do=;
 b=Vcq0+aYDZF+LB0AliGfT/PiLJIzFcsJHov5kKftycSHIJTWoMqfWoT3u0v1MWEVD+ROZ6uolB/83hr6Cxt6ufebqb32MWLPiTf+Hgu2OxKYW7uOZIeC6GOsZbHZgYmfhkeIy3zMa+t2ief0+GjJ1D+v+F9K0sPeOHRUzoYDaMLo0nB+CBKfFwpVf8lJpPn7aLk9U/g2auJx2VbHa4AnPmirXmaW065W2U8O5Ndwbxi/IMF3Tk6Z6GtvdJLwbtgitJntNaqYjPJ2p5OXfYcvqOvvtEALkncE7enUevmPF+1bgjQk+oYrvyMqSyhgJztJMkKF+I8GUOemlADmTdL21HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leH+0GwJiMBNKdkwpucvi+Qn0Sd0LrprCfsKkreY8do=;
 b=as2os8nuoGfGtsAiPKRyO/nvNvJ3YwtYZB7pXDP4PEI4Z4WWegrCXtyq1tJMao+Zp2vUzrf41sLGePHse9HwfGPmgVoKDvCeoczJDISsw+xDMZREcLkwz0A75FnHjmJ+HnWZ0xnqP0TDvx0DxgFI226tsmm1xlL4LV3LZQWfowg=
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
Subject: [PATCH v6 13/17] PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
Date: Fri, 27 Nov 2026 12:11:41 +0900
Message-ID: <20261127031145.2521228-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 66125b2e-db98-4448-8a69-08df4c34403d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|5023799004|6133799003|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	I3R1z68pln1SYVSiVjoLNY3s2CYJmXHfOy/0m0fFomXEaFzq2o2Z3O6CSqRdn0WyMb5P1Kt6G4lE61ZOfQo2pHw5Pfocl7qvj5dOK6t9MI4arSWE4h5eSIDIksGrA6pVlIX1KCqtuevKcGXmMBSXzdesoYeUQEA1qPWUJQ/lb3ScGO09TjTa/HzJCK7q1Qo0YIrz5MaJhc9ed67oluY2CU7LH1OZ5fyJObglbgslUJ1plad4eqZmk4dvIet3WYbMT7oTNfoBfRR4etJBqa2NihLLE3Zv1pPywKdSWkyNOuLO8jwx9EfIB04TzqkC2U5dfPWABbJguPTrP7rJcdWvZbF2wWLE7/aynLd5qGN1356DJD/n8RgaV6jz1d1NXDglyliE+l79dxxEStJyYFK+9VlTvz6Glme974UGXMUXyILkY4o5Sh7Yxir7snyU7hvU1NcVtIQw5yh/TVCRHjxpDZh+dljnfIySsH4Dakr49vc4Jz6CEuiruv5U8g9BMpwhRUhjJtCiLWcDWudngg5MeRoOuReKTLyecorBUFC/+EGEkWetZcdGkexeRrOllJ3TOygAgR6Y8RTXqqM4M81APeMRVB0v+UCrNrwN/OY2RK/AV/LqPO09lOY6aVkZ40X5MMFtLzUQHItVJR1oLz7tFwRdwcRGUCoy1j3P+ux9cBZJ9SH29UZbEiSoQUwwth9cUHIgUeGpLDa78A15DpZfaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(5023799004)(6133799003)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TV767BehuuzlX/+6gbvi/pAII69oRPZzkNTxc5qHdvsGq1Ne06F1+chm/tMt?=
 =?us-ascii?Q?w6BYNlUq5fBq5mvG4F5uy+kTiXYbMSoPNwlTg+iFNTky5m+OjNuVsdnOWojJ?=
 =?us-ascii?Q?TV0lYSx8P6AhxUc1mP4q1m0Y7saIROCtoAI7iFU7Av3z6y9WviidYG1SC0pI?=
 =?us-ascii?Q?knZVVossgViE4xG0Ek2DqoEb5SA9uKecggGFxDMhgckK+Nt28Qw7XdRgYJ3x?=
 =?us-ascii?Q?tsrP+Vm38QZFhLRphJSZQiJssnEdetzcQSo/WwLCJuwVY8Z8Pig0wie9Lpyb?=
 =?us-ascii?Q?Og6U8JaVXbciPHHEeLfJsa+pFozik1/Gj6VZlWrLlD8F7Pa89GVezSmEGjs9?=
 =?us-ascii?Q?M9u6t7XaiAVpubMAZKG/JyVwZZfTY54UK5AuFjxv18RiKxKYVFtL0Ip2SsPM?=
 =?us-ascii?Q?3ljiK1+mrit3zQWPkAVjIFfbKPe++rwpBA3blkepM4xf8LeVQtFocWbwfsNK?=
 =?us-ascii?Q?lfUtafv0vf13OYomhhsP66hDovmmow+lzgYaSp4ECSnvc+9V943tsoiWXkW0?=
 =?us-ascii?Q?/7kNiIgXrZbR3JpVxRzIQeyTLBX7ObjuKGMdP2bB31hOREyFnUdG96xVipeV?=
 =?us-ascii?Q?0xP+Aj2gyX5Tvu/LbIHHHPo3+L5L2hoimEoLpSdDdGM4NcLDqn7OQqedMh0Q?=
 =?us-ascii?Q?MSTqXLicARTA99FPJVW+BTMr5nLinDPtFmWfvArIfULIvqS+NOSILJiipEgw?=
 =?us-ascii?Q?dcXKnN3S20NLLug2Qp+pxAtXUpp95DEoef/sbR5bTU/94v1aExH/bYKl8twJ?=
 =?us-ascii?Q?nlMYm+O5N6SdB1fsswku+Ww97bFBAHVvD31Mzv5b1gQgQpj386VkAICTmn7i?=
 =?us-ascii?Q?Br2pBCRpI6vlihDze9cGxpZUxmv7va7PAH7uVjnwIyNvpnKG28Jxn9lHmQ9O?=
 =?us-ascii?Q?SrUs7WO1ndMCPARnJFwiAwgyDJKr33bjCfIEAZXaxTCtloLjQFhAmEP+30pd?=
 =?us-ascii?Q?WMGYGeksU9kFyyeP9opkL3dbe9w/hVl45N7zbnKXOKp39euH9A/vrp01R/Pi?=
 =?us-ascii?Q?eHjfSD3LDuTola3nTDXFO4oSgzePQVwlcaYfJS6tmIuv55fY6S6Fhc68XB7/?=
 =?us-ascii?Q?Dib3ngQOuG8uXm5+0BOrymkoQ/dXRPOQ/8ZZjIf0vUBD9ryEytL4N7+Imrrh?=
 =?us-ascii?Q?bddwxyb+rty5br/NP1HTBEBfkwmq0ygiIm4nJ/O07OFMAVwnyZjsIYoUMdEd?=
 =?us-ascii?Q?Of1wL2uMf8NBuZ5SYUxdw+x4t0dm00UFmTs08RRxkW8yOfjKmMVEEhNWmKhp?=
 =?us-ascii?Q?FedQVFF7dyRjMRSwfipAhTDKHYWMBb3ffHYqMEX5RNvRC3LHtok+V9L+tWQS?=
 =?us-ascii?Q?e9BJklx4IcZMiJMW8tXmj1Em5LHdombvHeXaLbuf45gOuUzXVn1uXacpqJNA?=
 =?us-ascii?Q?E/cIzxc3a3e5XhP7QBYDJgikptRdoTKfAsHMPSj9m6uye6EnSkagHNmmDaOB?=
 =?us-ascii?Q?iGYM8b2qXTOpq++C2Nj8u7OKqtwx8lFERsO0whCLx9b6bSCy+04tIVmATvZF?=
 =?us-ascii?Q?xQy9abqXon3FWQZIjM0Ru6OEywaa+zK6/tM31zpQqLRkaGT2uNBW04eSJ9CV?=
 =?us-ascii?Q?YSRJPN1+5zsfghs3qIngjaxc7tZR5/FCe4Hzowtl9rAD73anoYX1HOoD3Z40?=
 =?us-ascii?Q?EPUC5kzseimA5lUMOKZgujmo1fdnCVPmG6XEHrrjdXJ6hPBMRLjrgeuo+APx?=
 =?us-ascii?Q?Q8axux8qzKWL2fAlwjowwE4uHNVastR+o+aBE6XX+LhvrDBNtE4tb+iPxpGa?=
 =?us-ascii?Q?4XDIeZQAMETYmm0eXwCLmYaly7BwdWis9WZBYRdqt+zHWhrK6yN+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 66125b2e-db98-4448-8a69-08df4c34403d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:21.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUVyjkuxdzWdoRz0rn0twcBBQcd+A/r/MbhNj/U1pCk7ZjW8CAacuwkJ9e1Mkp5D1qw5vQem+x9OFiPmh7Hzbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

On R-Car Gen4 SoCs, the APP block exposes the Root Port interrupt
signals in PCIEINTSTS0 and routes them to platform IRQs: AER to
intreq_pcim_lperr, and PME and bandwidth notifications to
intreq_pcim_sub. On an R-Car S4 with GIC ITS, a link retrain set
LnkSta.LBMS and latched PCIEINTSTS0[23] (cfg_bw_mgt_msi), but the Root
Port's MSI never fired while endpoint MSIs worked fine. With iMSI-RX the
Root Port MSI capabilities are already hidden, but its INTx maps to
intreq_pcim_sub. Note that even before this driver took over the IRQ
with rcar_gen4_pcie_msi_irq_handler, the port service was unable to
request it, as the DWC core used that IRQ for its chained MSI handler.
In either case, iMSI-RX or an external MSI controller, Root Port
interrupts are not delivered to the port services.

Hide the Root Port MSI/MSI-X capabilities so the port services use
INTx regardless of the MSI controller. Do this in the R-Car host setup,
which also runs on reset and resume. Use a virtual IRQ to deliver
notifications from separate platform IRQs to the standard handlers.
Route AER from the optional "aer" interrupt. DTs without it remain
supported, but Root Port AER stays unavailable.

The APP block may still receive MSI-form notifications because hiding
the Root Port's MSI capabilities does not clear MSICAP0.MSIE. Handle
these alongside the INTx-form level signals. Clear the MSI-form latch
before the AER handler clears Root Error Status, so a late APP clear
does not erase a new notification.

Check for reset requests before dispatch: on S4, DBI accesses from
the port services can hang the host immediately after link down.

The next patch also feeds PME and bandwidth notifications from "msi"
into this IRQ, so both parents may dispatch concurrently.
handle_level_irq() calls irq_ack() before checking whether it can run
the handlers. Keep the APP latches set while the IRQ is in progress or
disabled, so the level parents can retry through the reset checks.
This avoids losing notifications without a raw lock around port
services that take regular spinlocks.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 213 +++++++++++++++++++-
 1 file changed, 210 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 76f520b6e86e..51702e604793 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -14,10 +14,12 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -59,6 +61,11 @@
 #define SMLH_LINK_UP		BIT(7)
 #define RDLH_LINK_UP		BIT(6)
 
+/* Root Port notifications routed to intreq_pcim_lperr ("aer") */
+#define AER_RC_ERR_MSI		BIT(29)
+#define AER_RC_ERR_INT		BIT(27)
+#define RP_AER_MASK		(AER_RC_ERR_MSI | AER_RC_ERR_INT)
+
 /* PCIe DMA Interrupt Status Enable */
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
@@ -68,6 +75,7 @@
 
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
+#define RP_LATCHED_MASK		AER_RC_ERR_MSI
 
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
@@ -133,6 +141,12 @@ struct rcar_gen4_pcie {
 	struct work_struct link_down_work;
 	/* Allow Root Port event handling after enumeration and until teardown. */
 	bool rp_events_armed;
+	/* Virtual Root Port INTx shared by the port services */
+	struct irq_domain *rp_irq_domain;
+	unsigned int rp_irq;
+	bool rp_irq_enabled;
+	/* intreq_pcim_lperr ("aer"): Root Port AER notifications, optional */
+	int aer_irq;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -565,7 +579,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~MSI_CTRL_INT;
+	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
 	/*
 	 * Note that rcar->rp_events_armed is not checked here because device
 	 * removal may still need iMSI-RX interrupts after Root Port events have
@@ -573,6 +587,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	 */
 	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
+	if (rp_events && rcar->rp_irq_enabled && rcar->aer_irq > 0)
+		val |= RP_AER_MASK;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 
 	val = readl(rcar->base + PCIERSTSTSEN);
@@ -675,6 +691,15 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
 	return rcar->reinit_pending;
 }
 
+static void rcar_gen4_pcie_rp_irq_dispatch(struct rcar_gen4_pcie *rcar)
+{
+	/* Recheck reset requests after the parent's status read. */
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return;
+
+	generic_handle_domain_irq(rcar->rp_irq_domain, 0);
+}
+
 static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
 {
 	struct rcar_gen4_pcie *rcar =
@@ -769,6 +794,162 @@ static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
 	cancel_work_sync(&rcar->link_down_work);
 }
 
+static void rcar_gen4_pcie_rp_irq_mask(struct irq_data *d)
+{
+	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+	rcar->rp_irq_enabled = false;
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
+static void rcar_gen4_pcie_rp_irq_unmask(struct irq_data *d)
+{
+	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+	rcar->rp_irq_enabled = true;
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
+static void rcar_gen4_pcie_rp_irq_ack(struct irq_data *d)
+{
+	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
+
+	/*
+	 * handle_level_irq() may skip the handlers after calling irq_ack().
+	 * Keep notifications latched if the IRQ is disabled or in progress,
+	 * so they raise a parent IRQ again after unmasking. The descriptor
+	 * lock serializes this check with IRQD_IRQ_INPROGRESS.
+	 */
+	if (irqd_irq_disabled(d) || irqd_irq_inprogress(d))
+		return;
+
+	/* Clear APP latches before the service clears Root Error Status. */
+	writel(RP_LATCHED_MASK, rcar->base + PCIEINTSTS0CLR);
+}
+
+static const struct irq_chip rcar_gen4_pcie_rp_irq_chip = {
+	.name = "rcar-gen4-rp",
+	.irq_mask = rcar_gen4_pcie_rp_irq_mask,
+	.irq_unmask = rcar_gen4_pcie_rp_irq_unmask,
+	.irq_ack = rcar_gen4_pcie_rp_irq_ack,
+};
+
+static int rcar_gen4_pcie_rp_irq_map(struct irq_domain *domain,
+				     unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &rcar_gen4_pcie_rp_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops rcar_gen4_pcie_rp_irq_domain_ops = {
+	.map = rcar_gen4_pcie_rp_irq_map,
+};
+
+static irqreturn_t rcar_gen4_pcie_aer_irq_handler(int irq, void *data)
+{
+	struct rcar_gen4_pcie *rcar = data;
+	u32 status;
+
+	/* The line also fires on link down; reset requests come first. */
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return IRQ_HANDLED;
+
+	status = readl(rcar->base + PCIEINTSTS0) &
+		 readl(rcar->base + PCIEINTSTS0EN);
+	if (!(status & RP_AER_MASK))
+		return IRQ_NONE;
+
+	rcar_gen4_pcie_rp_irq_dispatch(rcar);
+
+	return IRQ_HANDLED;
+}
+
+static int rcar_gen4_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
+
+	/* Downstream devices use standard OF INTx mapping */
+	if (!pci_is_root_bus(dev->bus))
+		return of_irq_parse_and_map_pci(dev, slot, pin);
+
+	/* Root Port uses the virtual IRQ (always INTA) */
+	return rcar->rp_irq;
+}
+
+static int rcar_gen4_pcie_rp_irq_init(struct rcar_gen4_pcie *rcar)
+{
+	struct device *dev = rcar->dw.dev;
+	struct fwnode_handle *fwnode;
+	int irq, ret;
+
+	irq = platform_get_irq_byname_optional(rcar->pdev, "aer");
+	if (irq == -ENXIO)
+		irq = 0;	/* old DT: Root Port AER stays unavailable */
+	else if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get AER IRQ\n");
+
+	fwnode = irq_domain_alloc_named_fwnode(dev_name(dev));
+	if (!fwnode)
+		return -ENOMEM;
+
+	rcar->rp_irq_domain = irq_domain_create_linear(fwnode, 1,
+						       &rcar_gen4_pcie_rp_irq_domain_ops,
+						       rcar);
+	if (!rcar->rp_irq_domain) {
+		ret = -ENOMEM;
+		goto err_free_fwnode;
+	}
+
+	rcar->rp_irq = irq_create_mapping(rcar->rp_irq_domain, 0);
+	if (!rcar->rp_irq) {
+		ret = -ENOMEM;
+		goto err_remove_domain;
+	}
+
+	if (irq) {
+		/*
+		 * Dispatch the child IRQ in hard IRQ context, including on
+		 * PREEMPT_RT. Enable it together with the "msi" parent IRQ.
+		 */
+		ret = devm_request_irq(dev, irq, rcar_gen4_pcie_aer_irq_handler,
+				       IRQF_NO_THREAD | IRQF_NO_AUTOEN,
+				       "rcar-gen4-pcie-aer", rcar);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to request AER IRQ\n");
+			goto err_dispose_mapping;
+		}
+		rcar->aer_irq = irq;
+	}
+
+	return 0;
+
+err_dispose_mapping:
+	irq_dispose_mapping(rcar->rp_irq);
+err_remove_domain:
+	irq_domain_remove(rcar->rp_irq_domain);
+err_free_fwnode:
+	irq_domain_free_fwnode(fwnode);
+
+	return ret;
+}
+
+static void rcar_gen4_pcie_rp_irq_deinit(struct rcar_gen4_pcie *rcar)
+{
+	struct fwnode_handle *fwnode = rcar->rp_irq_domain->fwnode;
+
+	irq_dispose_mapping(rcar->rp_irq);
+	irq_domain_remove(rcar->rp_irq_domain);
+	irq_domain_free_fwnode(fwnode);
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -854,6 +1035,13 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	/*
+	 * Root Port MSIs are not delivered. Hide the MSI/MSI-X capabilities
+	 * so port services use the virtual INTx IRQ.
+	 */
+	dw_pcie_remove_capability(dw, PCI_CAP_ID_MSI);
+	dw_pcie_remove_capability(dw, PCI_CAP_ID_MSIX);
+
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 	rcar_gen4_pcie_host_perst_assert(pp, false);
 
@@ -869,6 +1057,8 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 
 	/* The MSI status lives in DBI; keep the handler away during the reset. */
 	disable_irq(rcar->msi_irq);
+	if (rcar->aer_irq > 0)
+		disable_irq(rcar->aer_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -879,6 +1069,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
 
+	if (rcar->aer_irq > 0)
+		enable_irq(rcar->aer_irq);
 	enable_irq(rcar->msi_irq);
 }
 
@@ -945,6 +1137,8 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->bridge) {
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
 		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
+		/* Route Root Port INTx to the virtual IRQ. */
+		pp->bridge->map_irq = rcar_gen4_pcie_map_irq;
 	}
 
 	rcar_gen4_pcie_host_perst_assert(pp, true);
@@ -1003,10 +1197,14 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	raw_spin_lock_init(&rcar->app_lock);
 	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
 
-	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	ret = rcar_gen4_pcie_rp_irq_init(rcar);
 	if (ret)
 		return ret;
 
+	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	if (ret)
+		goto err_rp_irq_deinit;
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
 	pp->use_atu_msg = true;
@@ -1018,7 +1216,15 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	pp->msi_irq[0] = -ENODEV;
 	pp->ops = &rcar_gen4_pcie_host_ops;
 
-	return dw_pcie_host_init(pp);
+	ret = dw_pcie_host_init(pp);
+	if (ret)
+		goto err_rp_irq_deinit;
+
+	return 0;
+
+err_rp_irq_deinit:
+	rcar_gen4_pcie_rp_irq_deinit(rcar);
+	return ret;
 }
 
 static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
@@ -1026,6 +1232,7 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	/* Cancel recovery work before removing the PCI bus */
 	rcar_gen4_pcie_rp_events_disarm(rcar);
 	dw_pcie_host_deinit(&rcar->dw.pp);
+	rcar_gen4_pcie_rp_irq_deinit(rcar);
 }
 
 /* Endpoint mode */
-- 
2.54.0

