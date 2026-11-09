Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192118;
	b=ofC+mEhy3wyr5Cc7aE5/5iL4s+Kjz8MqqVFR9vTynp5mOz1KNF9J1+FyWxx3wg4MDkgF
	 SNBKR12Oxdcc/3PEMt1Hju70iq55j6MjKlUAVs1Bjz620x/Y9pcbthSb+Bm+8B9MBDV/2
	 0iNZjx4+ZBB1I/XUAEA8ZVewANp9BO0vccbQjEgRKWgnXwA/YrNg7wVS7pOqH5bNU+LOk
	 u4zIqa98QgaQ3PJORjuSUjh5zfTXJI12dFdGyOe2F7ENBARRcbvriI6ioI3WjzJ0ZisZ6
	 fc0VKKS1LTw4WBpiTrsggHj7Q4DvgjYXKX0iXaH3E7dXLox0ueBFOJNzL0HIdwsVxEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192118;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=ETgMNNJRQSi+iruJj8FgFwFLe+9yYGimIRCB4JW2TTA=;
	b=zcAoUwambD1L2GRir1pkFa+BZnwihNt266ZY5NbqnxfIHSa14/HY/n333a4gfTYpmL0O
	 0SvkGLxayfGK3fV/bVVu0yhw4RGpohfqn3RQr6QLViaQ2oVym9p2ykyFRpeFuYbQ0BTeO
	 xNDUrc2Nvd7/CW8PB/qJCs/iQTIWZTZ9976Vs3uHZp3/zAkVxsmVLmwBmlgKlU4cY/pki
	 tugUbNHU3gT4ioYPEe27eEMs1KKwaw1AcRqFA7T0K7wHofEjQykRewQbuGL5xMIcybdXS
	 p+zNhuotb8m+5PoL64mGlEruwE3NC9FfV3yHeNq/dm1qPNDv4b7BCCBgQUikS55D2yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=m06siARp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.137
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEC606A31C;
	Mon,  9 Nov 2026 02:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FEC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=m06siARp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2lHWzz1O3lzAIXO2Wph0UCb5z0w3Pi7IU28EFpGSUXlWNxgPBdhpUG5Xq/v+rnchautlU4Kew1aQAzAuRNh05OvzhS162qp/TAyVM5Po4upuphRVBcnq3dQhsedRxCVe0tzp9kGc7mB7J8ouGF7vHXLrHKIFdVFrRDuJ1WXc1A2EyVpSGEe9xYoktKoTns+Poz3GjuJ7jxer0usalru+bTGIM6cfeidS5EWCTUVxXrzChC9Op9r0D2bfLnK+afQzTJR39OZ6z4vElwtFychrVb+IXY8++sg8TNxMTn95zKww/XBgj/KxMITEsxsCBacLqmxjp4reX4Spuiy4YEb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETgMNNJRQSi+iruJj8FgFwFLe+9yYGimIRCB4JW2TTA=;
 b=DJMxPhVmTh4z5H7I4Tf7ankNuryNWuJYHPqN5lzJ2GzRI5QcmCAlQQeoaCoAOBmpcm1hs2og1RFCi22YYXLBL3Iez9qK0Ft2kxgc5pSnqGZunMzAaAWb3bIGG1NVi/saWtP092spJ62mBNd8XVlIEC1+utqYEtluimDxlcWseI5ttIA6iI9+yrBRZKm5mB4TbHE6NdI9Anmfl3OIiA7XPDPZ+q4nRxvyKfL/WlWgfVmir/AIC7ENLGD7w2vd/e1ohTPbWKqZrVjRbydViehK/6PIvuPsxb8r7iPcpQ+sNcp0fNEAsTG4qP0hGhJihne0S8Vf0oJtwCliiOreb8055g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETgMNNJRQSi+iruJj8FgFwFLe+9yYGimIRCB4JW2TTA=;
 b=m06siARpkdBzf0ldaNQHCL3Q7Q5M9Uim6MwhczrDD/N91xHl3rgEo8dg6oI76JFITMPe4tGg32avV4H5yYl2Do60sv8mIy6vZCn94EKHD3mdmzGSIxEzhZC9vnuVphU0bLNvT+RMYO7g6WWugp+eru88feWilqOvjkFHlj06zC4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB2196.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:155::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 02:41:53 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:41:53 +0000
Date: Mon, 9 Nov 2026 11:41:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Shawn Lin <Shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v5 13/17] PCI: rcar-gen4: Route Root Port AER to a
 virtual Root Port IRQ
Message-ID: <dwgbyrulxrbiygjquuyd6cke4i43um7oio4fefey4lfgngwuoe@lkkn7ulwi3vj>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-14-den@valinux.co.jp>
 <33e7f153-9dde-4bf7-8ab4-d128b256239a@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33e7f153-9dde-4bf7-8ab4-d128b256239a@mailbox.org>
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB2196:EE_
X-MS-Office365-Filtering-Correlation-Id: 23572360-64d9-456d-5e86-08df3e0b0374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|5023799004|4143699003|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026135527099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HeLE2dNk1zK2rHGB+DzOcs2PAVhAkOB9AuqAu1ndMU3Vx5F8fTU4qFJz48s10l0Lu73C9gVMYzjqhGsMc71W4fqLRtVpOspuw8SEkqMpUYHxZsKupT1q4Z5CInF2k2Km19GtlkXfhf+VcogkrL3bQj3hzO/rJWo0mDL+cOeAdVFeakft0v5Y6u1QiqueOBi2PI4Qg045Tor3md3dEYcVNDRQsZaUZefonssnV/454tyEFIk5wyMRk5EDIloqKVVPSItnyLqTYWtERFB+JpWXjZPvbfgSuVOnPPVVmLhhmSaQyJrRMEWnVZhlsBAVX6qTISsnROeHjPSLv3jpLCNv5GIvTVT2xxqbf/BCae66lkYH9M5QMeWfWewwzTRT/6bwjA9HIk9j/c5TlHNryeHOBi6Bed8MUhVSBtvEBD5l+yROqLiOUv30eZwAgPw76IEivuWRt5ryrY9YOvbyCnpgQZOyJ8F9Uu1GfknHsTindpjzwRGR6gzWxDzNmxV844ZJ2hq4RpDrFcRJiQcif+ZFEm+Wb+J62qnSRplf4fNh6ooLTP4LQa28UGgtUY0hx86BpXUy1JuUAIH9ehSclUKsagRgB4siCq8xvWhbE/mqbS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(5023799004)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026135527099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1EwmYkwTCZ6+WE3WCNMNTW/oE7WSosojFpRakNFoyXEg4tQjeRSvMIzoYcUe?=
 =?us-ascii?Q?5yMtOVyXS4qqfHjJ/ncIcGjImG3MocGnQ+rFcKjL58h9VksNtT3DYGcoTwyC?=
 =?us-ascii?Q?FkgaA7ftnvLq7VYqyTndLYQIbp9BcDm+gZVaVbhb20zoDMrjW3v+CvH66oLp?=
 =?us-ascii?Q?BRjVtZ+IYZWsoZibl6StRZKH56o+GOlAr/jCyDVpKOdPjSMT1p6IIadCkkH6?=
 =?us-ascii?Q?x0+J3BABDWRbOEnSkwwDhMM0JULnogtdk7PPW9TkUjUkhEcFnq4OoZdsSH5m?=
 =?us-ascii?Q?3kXlZBEg0Hjk2Cfdq3ENmwW52cRUNz88hWgnOQwnuY9Fe3V7UxlmR5+PRH+6?=
 =?us-ascii?Q?eAA+X2qEc1r3rXyOzr1Or5aNi5DocYmAnl+4WHCs51WUECDOQOqF9yrv1IoL?=
 =?us-ascii?Q?pK9HBpIpptP7c4NBq1w1054iH2F7Uo2P/XlY2Ev8ZTqeNkRuGgES4gmorD8d?=
 =?us-ascii?Q?eyu82GY69/0L7DZPdonvqFBK4V7vwQCnwMIu9fc2f/iALj7QjC9DpYxwX2eA?=
 =?us-ascii?Q?zRUq/lChd4rR716cRqeuYZLTONhWn6H7Tuu8nmUUwB9zI44murbFrJNMIGlh?=
 =?us-ascii?Q?zXndbRRBjaOddufHd2M+k9JDDFfoSZkpCKCQqbowcBhmsujcKC3PDGcLfodJ?=
 =?us-ascii?Q?07c6hjIE+NnMqdOQpkvzfopRSzX+hHGKfEKbyiV2r4qbXWcSiPI1EiUCpZf/?=
 =?us-ascii?Q?84xx8NJLCYYjZmVVjMUl9znwVTYAwWxQzBK7w+UpRY6LpkANr6k87ZxnEEDP?=
 =?us-ascii?Q?wUUgeWs8Lum9MUCwt/vgMJ+9qvVYx1qks/Mkn1JZedoot5lPcURH5TAVjNGH?=
 =?us-ascii?Q?Kt5c33MDuNwocw7kCMUaiG0VmkImuK2HY8XRwc9Nd3SQ8z7tDRTF9bLekGDv?=
 =?us-ascii?Q?xyI6Bc9W/6sTqsy6T2LyeQqoRAHH03fFmHj8PZDublxu6c4O4jXKHRhA98Oz?=
 =?us-ascii?Q?Dd5gduli1ebBIblLZrkPxhIOA6TvNvCK4Ts3qhbXsa+ckfI20Kak7UC/4LkO?=
 =?us-ascii?Q?U+iGE8PX0ZwVIYjFKKvt2NyJNli3tEbjNMnuLHK4sx1zxP2PPLeEw0Hm1u9R?=
 =?us-ascii?Q?NvNbendSwvoi31jdtYrXBy9TKS0KjAcs/jMaunoSi1XvlrPdfesiyUmkbQvn?=
 =?us-ascii?Q?XkRPCjP4RYyVH8Te6TTFUnkGDd/CFn5XQ/b5a78Bh3SLXqNbbhYsqbW5xbTu?=
 =?us-ascii?Q?T3I7bwFdgnbA41WTYFEDhmyGzw9AH6pfIXxsxOZyV39CVOA5tLRJJ/uol4NF?=
 =?us-ascii?Q?Jjgs9lFedjrL8L4sBRnk+VF6dWGdE8KsffFvzUFC3hlTbiYSk5UO7Wt0NkAj?=
 =?us-ascii?Q?/QM64Tkzn9kVd9IIFZHEO4sUzX9PjUyaqWJuAtuTabFHoEVtOC+E5vf/mFfR?=
 =?us-ascii?Q?4qSNJRCQ8k4CfZ5IDxe1h7M6j7Yq1UnuCB2L575lY4NByXk/fzdBPos7pb+s?=
 =?us-ascii?Q?ePxu4CPhT3GRuDWzaPJ1zkzQM97/D1L6MUP3OUVqgEGYulWI7fNfZDM3nldA?=
 =?us-ascii?Q?iYSeKqNzuw9Seh5GTYppFvjLCw+XdZbAsv32gfKydrkFB94cks54s/V0N+RL?=
 =?us-ascii?Q?n1NaOpGG2jP+wNqFBbIi8n+0UTLln3SKhjzrAfLOIcePONUSvCpaRDFmZHWz?=
 =?us-ascii?Q?nl8g2z1g/b1b2fistbh4iyCw2BJbEYPRKYRDyZ0Z1611fBy768DCZPAKfXrR?=
 =?us-ascii?Q?rxcH0OG5IDbMs3KfEQaq4khd5n7Vyv2Ll0zD6jOQ0QMPhmqnoaxNpH2Dcrrf?=
 =?us-ascii?Q?ORVLQM4YA/GS0mqnuFmLbQQm0iexeeOaRt+7tCJ11KbpSApEYic8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 23572360-64d9-456d-5e86-08df3e0b0374
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:41:53.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VOyJwnNXxGmKFfZNw52X98Fr4hoILtjhUJiUk3Ulmyfh0hg4wuKX/SPYGh49TDl4dYh17Net6kym7F3xAtJVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2196

On Wed, Oct 21, 2026 at 02:19:46AM +0200, Marek Vasut wrote:
> On 10/20/26 5:10 AM, Koichiro Den wrote:
> > On R-Car Gen4 SoCs, the APP block exposes the Root Port interrupt
> > signals in PCIEINTSTS0 and routes them to platform IRQs: AER to
> > intreq_pcim_lperr, and PME and bandwidth notifications to
> > intreq_pcim_sub. On an R-Car S4 with GIC ITS, a link retrain set
> > LnkSta.LBMS and latched PCIEINTSTS0[23] (cfg_bw_mgt_msi), but the Root
> > Port's MSI never fired while endpoint MSIs worked fine. With iMSI-RX the
> > Root Port MSI capabilities are already hidden, but its INTx maps to
> > intreq_pcim_sub. Note that even before this driver took over the IRQ
> > with rcar_gen4_pcie_msi_irq_handler, the port service was unable to
> > request it, as the DWC core used that IRQ for its chained MSI handler.
> > In either case, iMSI-RX or an external MSI controller, Root Port
> > interrupts are not delivered to the port services.
> > 
> > Hide the Root Port MSI/MSI-X capabilities so the port services use
> > INTx regardless of the MSI controller. Do this in the R-Car host setup,
> > which also runs on reset and resume. Use a virtual IRQ to deliver
> > notifications from separate platform IRQs to the standard handlers.
> > Route AER from the optional "aer" interrupt. DTs without it remain
> > supported, but Root Port AER stays unavailable.
> > 
> > The APP block may still receive MSI-form notifications because hiding
> > the Root Port's MSI capabilities does not clear MSICAP0.MSIE. Handle
> > these alongside the INTx-form level signals. Clear the MSI-form latch
> > before the AER handler clears Root Error Status, so a late APP clear
> > does not erase a new notification.
> > 
> > Check for reset requests before dispatch: on S4, DBI accesses from
> > the port services can hang the host immediately after link down.
> > 
> > The next patch also feeds PME and bandwidth notifications from "msi"
> > into this IRQ, so both parents may dispatch concurrently.
> > handle_level_irq() calls irq_ack() before checking whether it can run
> > the handlers. Keep the APP latches set while the IRQ is in progress or
> > disabled, so the level parents can retry through the reset checks.
> > This avoids losing notifications without a raw lock around port
> > services that take regular spinlocks.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v4:
> >    - Hide the Root Port MSI/MSI-X capabilities in host_setup() instead of
> >      adding a no_rp_msi flag to the DWC core. (Shawn)
> >      https://lore.kernel.org/r/bi3rvyqpdu4iq6pfyrqvx7eplyim6gmg2ijal67mpateobmtlq@gec7zewfm76r/
> >      I did not carry Marek's Reviewed-by tag over due to the change.
> 
> Bjorn/Manivannan, can you please have a look at this patch and the MSI
> handling, to be sure this is OK ?
> 
> (no further comments from me below this point)
> 
> Thank you !

Marek, thanks for the review.

Bjorn/Mani, just a gentle ping. Could one of you take a look? To summarize:

- v4 had 'no_rp_msi' flag to the DWC core. Shawn suggested keeping that in the
  glue driver instead, which I found reasonable:
  https://lore.kernel.org/r/20261015033103.3076869-14-den@valinux.co.jp/
- v5 hides them in rcar_gen4_pcie_host_setup(). (this patch)

If you'd rather I send v6 first, rebased on the pp->msi_irq_domain rename Shawn
and Geert pointed out, please let me know. Otherwise I'll wait for your comments
before respinning.

Best regards,
Koichiro Den

> 
> >   drivers/pci/controller/dwc/pcie-rcar-gen4.c | 213 +++++++++++++++++++-
> >   1 file changed, 210 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > index 50d4b74e63b0..b0440f2c5329 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -14,10 +14,12 @@
> >   #include <linux/io.h>
> >   #include <linux/iopoll.h>
> >   #include <linux/irqchip/arm-gic-v3.h>
> > +#include <linux/irqdomain.h>
> >   #include <linux/module.h>
> >   #include <linux/of.h>
> >   #include <linux/of_address.h>
> >   #include <linux/of_irq.h>
> > +#include <linux/of_pci.h>
> >   #include <linux/pci.h>
> >   #include <linux/phy/phy.h>
> >   #include <linux/platform_device.h>
> > @@ -59,6 +61,11 @@
> >   #define SMLH_LINK_UP		BIT(7)
> >   #define RDLH_LINK_UP		BIT(6)
> > +/* Root Port notifications routed to intreq_pcim_lperr ("aer") */
> > +#define AER_RC_ERR_MSI		BIT(29)
> > +#define AER_RC_ERR_INT		BIT(27)
> > +#define RP_AER_MASK		(AER_RC_ERR_MSI | AER_RC_ERR_INT)
> > +
> >   /* PCIe DMA Interrupt Status Enable */
> >   #define PCIEDMAINTSTSEN		0x0314
> >   #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > @@ -68,6 +75,7 @@
> >   /* PCIe Interrupt Status 0 Clear */
> >   #define PCIEINTSTS0CLR		0x0340
> > +#define RP_LATCHED_MASK		AER_RC_ERR_MSI
> >   /* Port Logic Registers 89 */
> >   #define PRTLGC89		0x0b70
> > @@ -133,6 +141,12 @@ struct rcar_gen4_pcie {
> >   	struct work_struct link_down_work;
> >   	/* Allow Root Port event handling after enumeration and until teardown. */
> >   	bool rp_events_armed;
> > +	/* Virtual Root Port INTx shared by the port services */
> > +	struct irq_domain *rp_irq_domain;
> > +	unsigned int rp_irq;
> > +	bool rp_irq_enabled;
> > +	/* intreq_pcim_lperr ("aer"): Root Port AER notifications, optional */
> > +	int aer_irq;
> >   	/*
> >   	 * The controller needs reinitializing; the APP interrupt sources
> >   	 * stay masked until a reset succeeds.
> > @@ -565,7 +579,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
> >   	lockdep_assert_held(&rcar->app_lock);
> >   	val = readl(rcar->base + PCIEINTSTS0EN);
> > -	val &= ~MSI_CTRL_INT;
> > +	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
> >   	/*
> >   	 * Note that rcar->rp_events_armed is not checked here because device
> >   	 * removal may still need iMSI-RX interrupts after Root Port events have
> > @@ -573,6 +587,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
> >   	 */
> >   	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
> >   		val |= MSI_CTRL_INT;
> > +	if (rp_events && rcar->rp_irq_enabled && rcar->aer_irq > 0)
> > +		val |= RP_AER_MASK;
> >   	writel(val, rcar->base + PCIEINTSTS0EN);
> >   	val = readl(rcar->base + PCIERSTSTSEN);
> > @@ -675,6 +691,15 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
> >   	return rcar->reinit_pending;
> >   }
> > +static void rcar_gen4_pcie_rp_irq_dispatch(struct rcar_gen4_pcie *rcar)
> > +{
> > +	/* Recheck reset requests after the parent's status read. */
> > +	if (rcar_gen4_pcie_handle_link_down(rcar))
> > +		return;
> > +
> > +	generic_handle_domain_irq(rcar->rp_irq_domain, 0);
> > +}
> > +
> >   static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
> >   {
> >   	struct rcar_gen4_pcie *rcar =
> > @@ -769,6 +794,162 @@ static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
> >   	cancel_work_sync(&rcar->link_down_work);
> >   }
> > +static void rcar_gen4_pcie_rp_irq_mask(struct irq_data *d)
> > +{
> > +	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
> > +
> > +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> > +	rcar->rp_irq_enabled = false;
> > +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
> > +}
> > +
> > +static void rcar_gen4_pcie_rp_irq_unmask(struct irq_data *d)
> > +{
> > +	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
> > +
> > +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> > +	rcar->rp_irq_enabled = true;
> > +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
> > +}
> > +
> > +static void rcar_gen4_pcie_rp_irq_ack(struct irq_data *d)
> > +{
> > +	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
> > +
> > +	/*
> > +	 * handle_level_irq() may skip the handlers after calling irq_ack().
> > +	 * Keep notifications latched if the IRQ is disabled or in progress,
> > +	 * so they raise a parent IRQ again after unmasking. The descriptor
> > +	 * lock serializes this check with IRQD_IRQ_INPROGRESS.
> > +	 */
> > +	if (irqd_irq_disabled(d) || irqd_irq_inprogress(d))
> > +		return;
> > +
> > +	/* Clear APP latches before the service clears Root Error Status. */
> > +	writel(RP_LATCHED_MASK, rcar->base + PCIEINTSTS0CLR);
> > +}
> > +
> > +static const struct irq_chip rcar_gen4_pcie_rp_irq_chip = {
> > +	.name = "rcar-gen4-rp",
> > +	.irq_mask = rcar_gen4_pcie_rp_irq_mask,
> > +	.irq_unmask = rcar_gen4_pcie_rp_irq_unmask,
> > +	.irq_ack = rcar_gen4_pcie_rp_irq_ack,
> > +};
> > +
> > +static int rcar_gen4_pcie_rp_irq_map(struct irq_domain *domain,
> > +				     unsigned int irq, irq_hw_number_t hwirq)
> > +{
> > +	irq_set_chip_and_handler(irq, &rcar_gen4_pcie_rp_irq_chip,
> > +				 handle_level_irq);
> > +	irq_set_chip_data(irq, domain->host_data);
> > +	irq_set_status_flags(irq, IRQ_LEVEL);
> > +	irq_set_noprobe(irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops rcar_gen4_pcie_rp_irq_domain_ops = {
> > +	.map = rcar_gen4_pcie_rp_irq_map,
> > +};
> > +
> > +static irqreturn_t rcar_gen4_pcie_aer_irq_handler(int irq, void *data)
> > +{
> > +	struct rcar_gen4_pcie *rcar = data;
> > +	u32 status;
> > +
> > +	/* The line also fires on link down; reset requests come first. */
> > +	if (rcar_gen4_pcie_handle_link_down(rcar))
> > +		return IRQ_HANDLED;
> > +
> > +	status = readl(rcar->base + PCIEINTSTS0) &
> > +		 readl(rcar->base + PCIEINTSTS0EN);
> > +	if (!(status & RP_AER_MASK))
> > +		return IRQ_NONE;
> > +
> > +	rcar_gen4_pcie_rp_irq_dispatch(rcar);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int rcar_gen4_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> > +{
> > +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> > +	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
> > +
> > +	/* Downstream devices use standard OF INTx mapping */
> > +	if (!pci_is_root_bus(dev->bus))
> > +		return of_irq_parse_and_map_pci(dev, slot, pin);
> > +
> > +	/* Root Port uses the virtual IRQ (always INTA) */
> > +	return rcar->rp_irq;
> > +}
> > +
> > +static int rcar_gen4_pcie_rp_irq_init(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct device *dev = rcar->dw.dev;
> > +	struct fwnode_handle *fwnode;
> > +	int irq, ret;
> > +
> > +	irq = platform_get_irq_byname_optional(rcar->pdev, "aer");
> > +	if (irq == -ENXIO)
> > +		irq = 0;	/* old DT: Root Port AER stays unavailable */
> > +	else if (irq < 0)
> > +		return dev_err_probe(dev, irq, "Failed to get AER IRQ\n");
> > +
> > +	fwnode = irq_domain_alloc_named_fwnode(dev_name(dev));
> > +	if (!fwnode)
> > +		return -ENOMEM;
> > +
> > +	rcar->rp_irq_domain = irq_domain_create_linear(fwnode, 1,
> > +						       &rcar_gen4_pcie_rp_irq_domain_ops,
> > +						       rcar);
> > +	if (!rcar->rp_irq_domain) {
> > +		ret = -ENOMEM;
> > +		goto err_free_fwnode;
> > +	}
> > +
> > +	rcar->rp_irq = irq_create_mapping(rcar->rp_irq_domain, 0);
> > +	if (!rcar->rp_irq) {
> > +		ret = -ENOMEM;
> > +		goto err_remove_domain;
> > +	}
> > +
> > +	if (irq) {
> > +		/*
> > +		 * Dispatch the child IRQ in hard IRQ context, including on
> > +		 * PREEMPT_RT. Enable it together with the "msi" parent IRQ.
> > +		 */
> > +		ret = devm_request_irq(dev, irq, rcar_gen4_pcie_aer_irq_handler,
> > +				       IRQF_NO_THREAD | IRQF_NO_AUTOEN,
> > +				       "rcar-gen4-pcie-aer", rcar);
> > +		if (ret) {
> > +			dev_err_probe(dev, ret, "Failed to request AER IRQ\n");
> > +			goto err_dispose_mapping;
> > +		}
> > +		rcar->aer_irq = irq;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_dispose_mapping:
> > +	irq_dispose_mapping(rcar->rp_irq);
> > +err_remove_domain:
> > +	irq_domain_remove(rcar->rp_irq_domain);
> > +err_free_fwnode:
> > +	irq_domain_free_fwnode(fwnode);
> > +
> > +	return ret;
> > +}
> > +
> > +static void rcar_gen4_pcie_rp_irq_deinit(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct fwnode_handle *fwnode = rcar->rp_irq_domain->fwnode;
> > +
> > +	irq_dispose_mapping(rcar->rp_irq);
> > +	irq_domain_remove(rcar->rp_irq_domain);
> > +	irq_domain_free_fwnode(fwnode);
> > +}
> > +
> >   static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
> >   					struct pci_dev *dev)
> >   {
> > @@ -854,6 +1035,13 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
> >   	if (ret)
> >   		return ret;
> > +	/*
> > +	 * Root Port MSIs are not delivered. Hide the MSI/MSI-X capabilities
> > +	 * so port services use the virtual INTx IRQ.
> > +	 */
> > +	dw_pcie_remove_capability(dw, PCI_CAP_ID_MSI);
> > +	dw_pcie_remove_capability(dw, PCI_CAP_ID_MSIX);
> > +
> >   	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
> >   	rcar_gen4_pcie_host_perst_assert(pp, false);
> > @@ -869,6 +1057,8 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
> >   	/* The MSI status lives in DBI; keep the handler away during the reset. */
> >   	disable_irq(rcar->msi_irq);
> > +	if (rcar->aer_irq > 0)
> > +		disable_irq(rcar->aer_irq);
> >   }
> >   static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
> > @@ -879,6 +1069,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
> >   		rcar_gen4_pcie_app_irq_sync_locked(rcar);
> >   	}
> > +	if (rcar->aer_irq > 0)
> > +		enable_irq(rcar->aer_irq);
> >   	enable_irq(rcar->msi_irq);
> >   }
> > @@ -945,6 +1137,8 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> >   	if (pp->bridge) {
> >   		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
> >   		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
> > +		/* Route Root Port INTx to the virtual IRQ. */
> > +		pp->bridge->map_irq = rcar_gen4_pcie_map_irq;
> >   	}
> >   	rcar_gen4_pcie_host_perst_assert(pp, true);
> > @@ -1003,10 +1197,14 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> >   	raw_spin_lock_init(&rcar->app_lock);
> >   	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
> > -	ret = rcar_gen4_pcie_msi_irq_init(rcar);
> > +	ret = rcar_gen4_pcie_rp_irq_init(rcar);
> >   	if (ret)
> >   		return ret;
> > +	ret = rcar_gen4_pcie_msi_irq_init(rcar);
> > +	if (ret)
> > +		goto err_rp_irq_deinit;
> > +
> >   	pp->num_vectors = MAX_MSI_IRQS;
> >   	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
> >   	pp->use_atu_msg = true;
> > @@ -1018,7 +1216,15 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> >   	pp->msi_irq[0] = -ENODEV;
> >   	pp->ops = &rcar_gen4_pcie_host_ops;
> > -	return dw_pcie_host_init(pp);
> > +	ret = dw_pcie_host_init(pp);
> > +	if (ret)
> > +		goto err_rp_irq_deinit;
> > +
> > +	return 0;
> > +
> > +err_rp_irq_deinit:
> > +	rcar_gen4_pcie_rp_irq_deinit(rcar);
> > +	return ret;
> >   }
> >   static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > @@ -1026,6 +1232,7 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> >   	/* Cancel recovery work before removing the PCI bus */
> >   	rcar_gen4_pcie_rp_events_disarm(rcar);
> >   	dw_pcie_host_deinit(&rcar->dw.pp);
> > +	rcar_gen4_pcie_rp_irq_deinit(rcar);
> >   }
> >   /* Endpoint mode */
> 
> 
> -- 
> Best regards,
> Marek Vasut
