Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795711919;
	b=eZ6xMIEgfrzAin1vAJpMSt66ZGwLIm3lSXj1VJkEO6coWBLubPatKoNlfho06PVHqkZH
	 LaWmkK13VJpp8iom5FPuTNpWNIYTCpyeLy4HF1zffHTyFKGAMJMN52XXmgDIyGg4qUpZp
	 clQ4inPbKuvs3G+8S0ixeDc2XteZcJ1XiCFPSQUTaBoLcx9Sm2i5qRWmD/MsL8Zyi0BIE
	 8GrrQNEw0NnMzw+U8L2ydG7Rb4FYu60mexTsHMnbm/Hm0B5f9QH8xNQFOsAh3z6LMv+IL
	 TZzXGvq3e3ogxcRMkUPWb6P84ZxVaWuAul6fA8ZSD5wzIIrZn9Txry+oWSuzYaok4Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711919;
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
	bh=GrQ7CcCxbHBOb1kmfS64tuCJXEF7/0dFGu+SdJ/GHFk=;
	b=bId67XG6PlCgYwL6LccBiUVaf2P05xCZDUVogUvMCnvu2CPM+0qaH8V+HY8Ky8/5F0ml
	 BfuLcItM23YaTw58wpmRwVbFJzzbS7MJOImm7frT+ihVOHgtI/yflCRLXWK8090Z0UrgS
	 z6XxutjnU3LJNm/TLSrUDjIQu7VuAM+rxanFmCuBw2Uyt6O2Esr3QYcSMx/1H8LA1snfP
	 qxwAQViJYgKiApbUwiA7basmDaJ5V922oi9CCDiSQpUbIvdlurxL4TieFrOi8uRJyCBXB
	 SxH5MHtwkChwE9tYJEvqk7dJG9/hNj2xen0SmD+hIrD8OfjLF2Rg5Vkz9Z48q0BQ59Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=p1e3QahJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.78
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021078.outbound.protection.outlook.com [52.101.125.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6C606A31E;
	Thu, 26 Nov 2026 16:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=p1e3QahJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc7s8VwnMHSJZ8JA3xUJkcGR/sklme8BD5sklawJYQteR8K7iapXeZbKkEgSeAObv6GBVps1VrzMsTA5v+R8L37tVKYo/KSb/ysiusgBKx5hm1oFfuN9TQ09RLhxPAEpsL4loZtjx1BB/NLtEzUTyz+v5eSG3nSKNH6ucCjTpwkRtxHS6TnP/0dLuKw9By8VdtwdhWoY182Java3Z6JHBwElUz+n5QBuBWRHS4qtshSteNxFuWmk1BEOgur7x2EtPt9C/QK+jrT+hjPlTx5BecxzJk9abPAvUjXFRngy2Ja9ttNsugJrMJ/qv9xalaaW2pBJGAGuuwlpwjIltwHFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrQ7CcCxbHBOb1kmfS64tuCJXEF7/0dFGu+SdJ/GHFk=;
 b=j8ILMqhCyEoUXtMcBIQbhHCrujN1CifdxZrWSUmK1QPEWvsvWjxrNzN/eZPta4QuP+IqI33ul/DhNUUnhVizv9UiZPCzvVsEqCMuBnw1BpxQU4jQQ73WhDAWMQAGFhuAbrduycnVCC2jDauB/dmKhaENWWK54DpULBXQaeyi0wjZ7S3/8LyYjtX7j1NRvriurwGRs9RXPkc1IC7NOW6BYCECOWDFzmcFyPWOqwqzpZUXjSlE7aGu3FddY1nXQTTXvQAUoIq6Ddg1foBInORjoNS4AXzUNUqIDPdKR0pmJIyz663H07p+/kCvH66ayDTGCEWxhbrQQKSJgKY95z60mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrQ7CcCxbHBOb1kmfS64tuCJXEF7/0dFGu+SdJ/GHFk=;
 b=p1e3QahJYikThVY80vrPThH8b6SBxDPFlPkNd+JaYr0rNzjpqtKXMwl0eJ55Gk6iyZHZ+AWnIcrh27Germ3U0CPSo8k8geAFPX0TC73ra+M2txNA69C2ruSFJi1nWjWblCBsb19GWiwPhHlEW1ucCcTI62t9JLTz6Gu8ZVXg0nI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4125.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 16:51:54 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:51:54 +0000
Date: Fri, 27 Nov 2026 01:51:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <Shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v5 17/17] arm64: dts: renesas: r8a779h0: Describe the
 PCIe AER interrupt
Message-ID: <awhiSQ_A0V4K5fBW@z790sl>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-18-den@valinux.co.jp>
 <CAMuHMdWk9pZdJ+eh0dNHrZSMVDe84_rsvmrD=pC1Fjy9wEyp1Q@mail.gmail.com>
 <awhXFPlyc3vnmjtC@z790sl>
 <0c3d98cb-6641-47a5-9f15-0cf315979069@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c3d98cb-6641-47a5-9f15-0cf315979069@app.fastmail.com>
X-ClientProxiedBy: TY4P286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 89abb153-b39d-417e-3aae-08df4bdd936d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|4143699003|22082099003|261009223027099003|18002099003|56012099006|10067099003|261022105027099003|261026140227099003|261021121427099003|261021135927099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	s6GCfux5LkPNCq2bKDjVLX5iJQ5Igbi/52SG2SQdohphWdLFsGiEeTvKCDBCM6F6pdSTJHP8Fw1EoXRua/51XwXd+JmSgZOmyBFhrMkTIxKAw2y3gPZpiup/ESUP2HarIiLKrEbqZ5VgpqqQ29RZkJF/C47WIN5vQKMJF9Umvv+b+5D6wdv/pa50x7H1aw//DnjGlC7yOdw+osN2Xsk4BzEj1baOxgXgaCnolBJnEzvxmf05h/Mkym/0k10ojKjQvFD6HI1BQKrDtydXnxp7Ozi4T28Y6MgKmLjU2RmsoZfdSqhynwUH/d/+whGgPpRn9r90Kxufha/QjFoe8nG2HUIZVx0JRdgwQx4CpmnseRkqkCAPgpYN+rQ5s9QhxZ1U4FzXdQ8+FuQtt1SKVtqEyhqQ/pVLTJFJaNl/Is0W/YwH3GOZmu3DmTpcyf/MIJK4sZDAfzdv8fesM3jsXSflGcYFzZtglAq5IaBZwFELTpqJDcRoXyCEG25ELnq7J8gu216YwPw7nsdel4WmTpCd5W03FBrIOfzTeR989pDqyM547loCiiY7CG3iUT30Vjvpn/wME1LX3Q0ChwpBZCpuxgE+HoHFJpckygduS0nVBvn4D73OIGBs1sdPmtrBHwql
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(4143699003)(22082099003)(261009223027099003)(18002099003)(56012099006)(10067099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021135927099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9e0a60UAmnH5rGm+v1a/Qd6/3ZC8zW/ctvo7MOF+Yl5PA+DaSN5NS1RtzUQx?=
 =?us-ascii?Q?3+E5lORt7FJ4E+H4wyQgYTZQs5ZJOzfnHnfbbUU1OvkSKs0fFSX4k5aYbjGF?=
 =?us-ascii?Q?eJcfzBICiiu5mvjHm4yKQzW9UBLarQ2LZdBLizHUgtNZFA39PNVqgpHSXGdm?=
 =?us-ascii?Q?VaulOOq2UwFNhSXOKcDT5Cj+eiqQrOO4FOfjwhOrjwERrdaySS7Owq4aGPwD?=
 =?us-ascii?Q?tQjKVzRuxoxLS2vDSI/rUs9d70uwOWiaMi3NFIzi6iPQwdG47O3qWa7zXs2M?=
 =?us-ascii?Q?AqC7e5ujxAP9QOVTj9DZhin8umOSrUQCdFoYWKG93yK+O5DqAzwyK4AfoE0r?=
 =?us-ascii?Q?kTGTJq2wnPxlUILnw86hlTuZD36hzw6VJ9uQwjrUjff2W/1JcEKRFo4+v7Nw?=
 =?us-ascii?Q?zg5+HicpIxN4nxUvAXGj59DXE3h5gAsiZq9EnW0L6KkIgw3EN4O/O/8l6Prm?=
 =?us-ascii?Q?4RIVWIDrhkcyHiWvCD+2phbfTY+DSNBsJES0PXVFrXVXbpr1b4eKEtig/Tjd?=
 =?us-ascii?Q?i63DqU4xnLtHAm3wpsoR+ul5Ylw9HCPhYHw95crvsjc5UpI8ngqLvlvSo1Tk?=
 =?us-ascii?Q?oqOCLbylqtg2ZHVXTEbCAvwrFBNgssS/FxiWUMjJGSU1RYQgHd40l6vYok0h?=
 =?us-ascii?Q?l2u+XT8m/QLMUvxmGM3yWBNMVXc3MlN43aDLkvfGs6xal8FvSBxexMez1seM?=
 =?us-ascii?Q?2FXwTbfxTe89+Hiu+69Gzjhjks65Et4fZzI8mCt5kfQ1MBTBSxEx5G2atRBx?=
 =?us-ascii?Q?3aTsCf3IJVKl/cOlHa9N79I6z0hcFs7Wv+aJ5agn8zI7aw35Ew1cDnShMlOF?=
 =?us-ascii?Q?wG2vPmgmMhWUR9NkD9cY2XG9WdrnATdG1/tiR3Bg9XDASTfU+3fDduCCM3nP?=
 =?us-ascii?Q?4Th+geKpeIhiG4qVPpsQh92FhTqTFve9ycKjvcdiUE6EZ8I0iypYbpPYdbzv?=
 =?us-ascii?Q?UtfHy6CYgNMi8QqxWU2G01/ujZr1lUeAdOxuvEwK8xv4Sqyu7RPXZVdU7oW3?=
 =?us-ascii?Q?TbJobPfoY43igtA+vtIy9dfj8GsVYa5RtRclmJUhMnV2YtCJjj7VCicMUzkj?=
 =?us-ascii?Q?CU1Xi/CmD5vZ4QLYqOjRgfRgNosf5w8O/h3JXTp2p35LIztbfV3tOxZIWLB6?=
 =?us-ascii?Q?h/5SMn+stq9vp4gXpVxmBkLyiT4qs6ebV4ZjKT6Xy+LnNhDgq0ljZGRKhMea?=
 =?us-ascii?Q?HVxksOzh6W/BGLWneNzwUkxuc8x8RoF58YR8IHAM1+hS/Z15L1btSZM9ZmY8?=
 =?us-ascii?Q?8jvb5PNrkdEwZ+rsnal69YUm7ojGAoCL8eDnJF0J9MRBEnrrigPuokdK7Sdw?=
 =?us-ascii?Q?ToaMT33KtynO5F/HY2vqf0t7BOGEua2GEyvKtGK+5dcZMjtOlcQZqef+B1DB?=
 =?us-ascii?Q?Jhtfk9jr8apePzCaF3gKSqZkd8vcSFejLJqjLrbWGw09vu2Umb5LJ+zxjeZh?=
 =?us-ascii?Q?UPvn8Rt9Kf34bzD9/55aRPMxkxFaYP9XpYj/j7P2+v/c435HTETCjKyROoZR?=
 =?us-ascii?Q?3x105FqSLIuVtPByIyjlyBAZSVGFkJ9qzXxSQEufKgOIqN0wgHfTpMBtu2bi?=
 =?us-ascii?Q?ZtfCFyC7eeCeOBuHOqVO3akJwrj7fgIRsMSBdGmBA8/u+4ZXMhkvWXM8+EVa?=
 =?us-ascii?Q?hdbmARvyfyuOyaV7oglY2ClXr93ZWvv+f1IJvn5/q5jIFQ7QRX8xRDhnwqc9?=
 =?us-ascii?Q?p5BDEF7wUb1pjkS2BBPNHjIMjJKWW5r8rmVgOL++Mf81vUZyR3bWyn1crW14?=
 =?us-ascii?Q?c/mDJqrzAgYrjeHdoifx46NHUdLqTkM79uTyh7orPfhbZrqXYFiJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 89abb153-b39d-417e-3aae-08df4bdd936d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:51:54.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNmUqhLyxlIK9UZWwNrwX98gOuKvX2y2dNifE929qeA3zTYTQKDvQ9x09l9aVcV+4cKbgF1TdYiijVh5Z6ZVRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4125

On Thu, Nov 26, 2026 at 05:37:08PM +0100, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> On Thu, Nov 26, 2026, at 17:24, Koichiro Den wrote:
> > On Thu, Nov 26, 2026 at 02:10:32PM +0100, Geert Uytterhoeven wrote:
> >> On Tue, 20 Oct 2026 at 05:11, Koichiro Den <den@valinux.co.jp> wrote:
> >> > The PCIe controller reports Root Port AER notifications through SPI 454,
> >> > separately from the integrated MSI receiver interrupt. Describe this
> >> > interrupt with the "aer" name so the controller driver can use it for
> >> > Root Port error reporting.
> >> >
> >> > Append the new interrupt to preserve the existing interrupt indices.
> >> >
> >> > Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >> 
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> i.e. will queue in renesas-devel for v7.5.
> >
> > Thanks, Geert. TBH I'm worried that the rest of the series might possibly not
> > get picked up, in which case dtbs_check will keep warning indefinitely.
> >
> > Mani, mind if I ask whether the series still in your review queue (it looks so
> > on patchwork [1]), or whether there's no hope of it landing for some reason?
> >
> > [1] https://patchwork.kernel.org/project/linux-pci/list/?series=1189393
> 
> Oops, I incorrectly assumed your DT bindings patch had been applied,
> as my grep for "aer" matched Marek's addition of "aer" for R-Car Gen5
> in commit 2fcb7513361b4493 ("dt-bindings: PCI: rcar-gen4-pci-host:
> Replace sft_ce IRQ with AER IRQ on R-Car Gen5")...

Ah, that explains it :) Thanks!

Koichiro

> 
> Gr{oetje,eeting}s,
> 
>                                                 Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
