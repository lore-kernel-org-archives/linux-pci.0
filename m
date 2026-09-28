Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020082.outbound.protection.outlook.com [52.101.228.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BB284880;
	Mon, 28 Sep 2026 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569225; cv=fail; b=pj6d7i4+Take1lAhRyMnddciDThnDQLwKM59vFmlso6NJLfwSdTJKIW9EHNfEQvjUC94nXGYTN8RsScBRou5ohHNT2s8ymGSLN1HyyqJGQWxt6XCzRgIQXvVDctoXwtj2F7E/4RYT+XaIu8W2dmLKg37f0VBw+Js9zkbdhe8CwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569225; c=relaxed/simple;
	bh=wGqDVrNS3FegRY6IL3dZl/fj2hQAX8MhYJToyzMh/Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ffGQ16DzCDf4jytNzq3DHIX0JxhDZ87+OMAIMn5DxdkIXe1VYAeUIcgD0eR3z0oML0/h+2G2lafqL0O4i+K0BQMg3GP34wJclQ1LL0meVu+xc+SQ11hDJwm8x86tZDFa8OIwnRnqHyZ6yUcTRyZtCNExJmFNSJfQmuZ7sMRyGus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IuomAFnH; arc=fail smtp.client-ip=52.101.228.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IuomAFnH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOnJk43PPsMfXR72/9ZbWfCpiMucTmWXzmGfOwTnP+W3xGGZDtKS3ZgPjNTG1tJKkW2xL2ZeBhixZpES4y+vFIpHy5hS5RNLkdBjR1W7ovRRSXvh4Qp5AD0o1uHdNQoloP7qh5yVAA6HdLbBbWhb5flPY5VUlZ+1YUDPXhLmB9bRkp2ehTF3MiUXVuwU0uNJj/90i2/ungXvBQvuLvhBWo7CuGzP56U4bmSKlUB7vb8/C29waighWgrmM3Qbf+ZsZaXW2NHE6atRS73ZbzMU8IHxrARpNOTfUFv0UXd31ng9zRfQcmRfRYBvLMjbz6K5aCKfUDkLCzhSA4O7tSgD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrzlRPMz+uCESXYwpWUxEXl+79D02PVmDXCb+F5DT3k=;
 b=w0J1Ahy/7JT/Sjdl5nAyyc25EmgmeZLYurG52NEhbEJmwOREpRwqtHxt2ths69OARul96ZeoNRUAespSFe2oxS0jNwkG/G2W0SVA0unotbNMaWIrZdgOxWZb1V/zD4nRNQsGP4depS7UCv7cDxUxdMQVJWoEf268ed59k9tE3VlDxfCYndlaHa82MRms/Z861oESybAw0+wiDoSvAqyW3cDdYRwDUoK5o76WCtf4bGlpGqWIrh4PRt3de/rDk2e7QrYtiyR37wUN5Ta7Ik55AEqzm6PaQVW1Y4tyhdHFJLbjU6/JZUQLoaiWQqrwJhQ2xdzTCm/LikErTFdi6CDFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrzlRPMz+uCESXYwpWUxEXl+79D02PVmDXCb+F5DT3k=;
 b=IuomAFnH9gU3AnMi/BfsQWsuMm7k9tBzkfAEh5eIEwrQ2M6FRQHOTX2HaQ4hXt1myYlKH3bMMjchNSw/sazW3cuQK4M9co6If1KCpRoWhHrlZ8pPR5hlmdKYyv86i5Bpgp6csWNAA6QoEARYnnOhOz+xjxFEBhstGX2EDlegWxY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSZP286MB2330.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:20:19 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:20:19 +0000
Date: Mon, 28 Sep 2026 13:20:18 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] PCI: rcar-gen4: Drop the APP-based link_up check
Message-ID: <4fgnblug6mknuy4zq2lqeuni3dmu2f6c4mpb2qfvvyt5bpnovm@b6gundxnhr7d>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-3-den@valinux.co.jp>
 <c2807afc-3e69-4744-8588-20f60839a603@mailbox.org>
 <4peziifkgyfpglfl4jtyvcxqht2yo4r4bswmkweicpxdf45ejc@jxbqgurozlft>
 <badcd2d5-7d61-426a-86d6-000043a6aa93@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <badcd2d5-7d61-426a-86d6-000043a6aa93@mailbox.org>
X-ClientProxiedBy: TY4P286CA0097.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSZP286MB2330:EE_
X-MS-Office365-Filtering-Correlation-Id: c68348c7-c560-427c-3526-08df1d17ce64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|10070799003|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qpq2ZYkSzMGIBDjhu6vsBoIZ2IGn8nB7tFAK98sorPqhdyOHTYEakVO65aVgWQBpteuFiB6i/D/8NU59/emnDiYzHL6pDvQ5n2VhpCexSwf767LUtGogrBt51vwzr1tYbIh9ODsN/ceoD5eVkVTklBOXArQRmOyHmePVivMotSpXeY2kFRpnhxJk+h+5vQRTUYN+8cTx3YgtJ+1j6oVN86Tc7gnYSb3vEZQgDK9YntqugUXM/ap84C2J9ZZwiWyTtBppg8bXfomNdMgzoJCl+Pw/sQWRilapJrLiRyOPio/6qCQH8lWJIggn/hkL3TqgxMTuM45h7Ew+OGIPGi38JqBAkIsRiPg2Wx0mnKASK7aTBb/ufiIlWB6BO2lZI1K640bFYeTmRT2pal7oQBmJHmKIrmiRqNfBfjzIcxueagxrFT/RwieTzZIAmOMDPaFQiq++rJFH4NUZ7FXAnHKOep+tFc1DV4nuVVhZUSgSFnvQF1FMfsV57gvFIj9J1Bt0a4QHUa58BWto7lVVLxL+42AF8BNUcAShSrbcroLEY2JBQJsICYgPS/FRoHUyX1boEeRwq4gfp40yR3x4hs18b22jjZSScixc7SI73pi3UO48lnS5oL8sraGfkQjm48+M62c0aTh34dGD6raOu2r6dLnb29Feuq3bTDKSAceWyC0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(10070799003)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jeFwz9tktls4soy32BY/kmICx2PkP4bJ9CRWiXr+31HVtrC/CI5xBbrnDTeH?=
 =?us-ascii?Q?WCH0mO7B9AIyUNHUGurAM7+mNVVSXGWDgiZze54bxF6xCzQRA1menuL9pOfi?=
 =?us-ascii?Q?SCTeTRU7P4+vxhM+k8q5cs7qwZe6nJ3UHofWwhtaT6Z67SLiQUnIjf6bl/vU?=
 =?us-ascii?Q?WrV1CLioih8u1egN1UpRPNPYNtXnT9c+zqMNIcsLKz6X+U+wmbe0Ec6GWOeE?=
 =?us-ascii?Q?9MNhImXNPirdml/4TVmj/SUTJq11CNIPxDiu3ThWwf0WuDkk054ZBSQYkhx9?=
 =?us-ascii?Q?V0GPWVogGuRQZcLQpMmf5cwTtlmW9lTMJpEfWGnBaoZUMl68C+ooZAGEe83Y?=
 =?us-ascii?Q?UNEhwwPO0CHhf5f1U2L05Ceasd1PI5bjg05mr9CWUCwfJcpXAkfWShFEb2Rn?=
 =?us-ascii?Q?jnxDj8n+jNTxPkvFV9N8k45JDl2f4Xnr+0NOPiGypGraP37gofPmqGKjEL8n?=
 =?us-ascii?Q?HFALe8/fA+bCUApqThhii6GSTc8ONT6TgWUzWX2HWATDsCW+vN8TI2WQnL9x?=
 =?us-ascii?Q?Oa49D39I1/kzpzzHjJcvGMBD9gFYgZMATwNzitYgw1GJGfpntMHYCb/Mstri?=
 =?us-ascii?Q?+171MrsJBda0riCBGFfS36SkCXJJSRfdnR59Jxl/p91wMr+BobQTu+cWw//a?=
 =?us-ascii?Q?wn34nQp5iIKluLwU9eHPpaklt2dKVnhnzqt7XCeWHaPoEMZBFhbbfLoK+6GQ?=
 =?us-ascii?Q?8wMuK/J5SxQa3HNZxdqAcdzx14qhP4w00HG3I4jqHS+hxe+zgBckzk9GRl38?=
 =?us-ascii?Q?SP8fcDnI5lxWZpzD6Bg3QokgPiRHJC0NzM8wNhNfkvoLytckYHF8gNAHPg9U?=
 =?us-ascii?Q?gaDRXBLDTnxk41ZIY+481Ejf9LmOKKILwqWICm7l9TV7B7TwPre8BvHC8g9z?=
 =?us-ascii?Q?YJX0FavGIxqZY1xtOUDDJOwqTITxjr/8b3jvZ0V5Rt8rH2Rjt7UePANg0YO3?=
 =?us-ascii?Q?ijsmj2eVqhFQ6BcQg5xpDd4+Dj4PVEAED768eM+sj0RQkQIRiDufmJHkkTmg?=
 =?us-ascii?Q?8YO+BYfmWDzUlJ4iF4dACXFQm/W8hD34eckpSWIm/hX7cEUK1Qju7oWZhMz2?=
 =?us-ascii?Q?bQX9/ZHqQ7/aNk0UN3gImi+bCkzEISMsmhLfvFSay1BDaA0tQVTrgTTHwDxA?=
 =?us-ascii?Q?KlbTTB6hz2nJ2/FEx7cEj4xqxWW28mAs2buyKY04n3WXEdmBP3RKRuFFJafR?=
 =?us-ascii?Q?K6jjCvRwiYnkP0AXJ1B2AeE2zrLW3cRKYPRmAaFXnBU/Xa9tomd40CRruk16?=
 =?us-ascii?Q?1RGu82oiFJrPPV2BAyGyHUthnzK0wbyw/TcjYt3PXqPrsfEgj3edhklFMGEL?=
 =?us-ascii?Q?Lw3fK1An99mlDh1O2YN6Kn1fprdtOFx4zqQzhgr8oGgX54H/NlApY83+Z7YA?=
 =?us-ascii?Q?LZDr9k3H5BM137VZpFpsZz+JRLBUcRYHzblh4sl9TOAxIQHlEUhp2xntCoh0?=
 =?us-ascii?Q?rPgREMr9MLoGyiuMMZM8B0TaJS6qcXpngo/TEZ1qe5avKvXvdHxLrRS1t1k6?=
 =?us-ascii?Q?VrKpbTeS3zXSecMAiwhjQ7TJC5/trAfr3KBuiU9Bi8QI1b1REOOiHzoWy1Tj?=
 =?us-ascii?Q?bKDo2z5wspvH213hOF9GtDW7mcg1xVy+dQHpNS1aoaWBV8yf6MTdqoDj84Xx?=
 =?us-ascii?Q?Od7QIudr0W120FRmsCzp0neKdNrsBw9TC/QGZCVpqCOg1JMs/8Z7as7g5Pgv?=
 =?us-ascii?Q?1z74clGtbwnNrgVKDwRb/+1fyokR8VN+TeqEXl7ozeczImf//Nl1Yb5U/h0q?=
 =?us-ascii?Q?02Gb0YOPiy//wOIuqql0YtNUlyVIJfvLmtP60O4urVrEZD6j977U?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c68348c7-c560-427c-3526-08df1d17ce64
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:20:19.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7jwdAlIE+PXGKeX+gx3Xg9brC0M5IdSFPgQ3zGHMNVKd4ZIevDFykcmRWuSs1x4XE8FbV0M1ILY30jiItbRcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2330

On Sun, Sep 27, 2026 at 09:59:50PM +0200, Marek Vasut wrote:
> On 9/23/26 4:56 PM, Koichiro Den wrote:
> 
> Hello Den-san,
> 
> > > > @@ -298,7 +285,6 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> > > >    static const struct dw_pcie_ops dw_pcie_ops = {
> > > >    	.start_link = rcar_gen4_pcie_start_link,
> > > >    	.stop_link = rcar_gen4_pcie_stop_link,
> > > > -	.link_up = rcar_gen4_pcie_link_up,
> > > >    };
> > > >    static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
> > > 
> > > Can we include some form of the draft patch below, so the S4 Reference
> > > Manual rev.1.40 , page 1564 , Figure 104.5 Initial Setting of PCIEC ,
> > > bottommost diamond in the figure (smlh_link_up and rdlh_link_up = 1 test),
> > > would still be fulfilled, and the initialization code in the driver would
> > > not diverge from the initialization sequence listed in the reference manual
> > > ? What do you think ?
> > 
> > If always relying on the PORT_DEBUG1 check instead of the SMLH/RDLH check does
> > not introduce any regressions, I'd personally prefer to keep patch 2 as-is
> > because it keeps the code simpler. We could just add a comment noting that this
> > link-up check diverges from Figure 104.5.
> 
> I think the SMLH/RDLH does behave slightly differently, because those
> SMLH/RDLH bits are set and latched in, and they have to be explicitly
> cleared. The DEBUG1 bits report the current state of the link, which might
> (?) be susceptible to bouncing (link going out and down in a short window,
> but ultimately being up) ? I am not entirely sure whether that might pose a
> problem or not.

Hm, I have no idea whether the DEBUG1 bits are succesptible to bouncing.

> 
> > That said, I agree that in general we should follow the R-Car reference manual
> > where possible, and your draft makes sense for that purpose. If we go that way,
> > I have one question: would we need a polling loop with a timeout
> > (PCIE_LINK_WAIT_MAX_RETRIES * PCIE_LINK_WAIT_SLEEP_MS) in
> > rcar_gen4_pcie_start_link(), similar to dw_pcie_wait_for_link()?
> 
> This is a good point, and I think we probably shouldn't do it this way,
> because we can reuse the DWC core code for that purpose.
> 
> How about extending the .link_up callback, and check both the SMLH/RDLH bits
> there (to fulfill the datasheet compliance, dw_pcie_start_link() is always
> followed by dw_pcie_wait_for_link() which calls the .link_up() callback) and
> the DEBUG1 bits (to make sure we check the current state of the link) ?
> 
> That should cover all our concerns (datasheet compliance, DEBUG1 current
> state of link check, polling), shouldn't it ?

If you mean AND-ing the SMLH/RDLH check with the DEBUG1 check, that sounds
reasonable. We could clear the APP latches in .start_link(), before enabling
LTSSM, and leave them latched across .link_up() calls.
Thanks for the suggestion!

> 
> > P.S. I'll rebase v2 onto the latest pci/controller/dwc-rcar-gen4.
> 
> Thank you, and I apologize for the inconvenience.

No worries at all. I just hadn't caught up with your X5H series.
I've now rebased v2 onto next-20260925, since the series also needs
b43aa6a6ebe8 ("arm64: dts: renesas: r8a779f0: Add GICv3 ITS and update PCIe nodes"),
as noted in the cover letter.

Best regards,
Koichiro Den

> 
> -- 
> Best regards,
> Marek Vasut
