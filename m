Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021101.outbound.protection.outlook.com [52.101.125.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B19DF6C;
	Mon,  5 Oct 2026 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791174169; cv=fail; b=uCdYOZICvAGnUC5wfHzQ6JE794l9dM8rzcpGETl4VlQzUFMaeLMXD3m6cBcird/8xhFQY7aMT97MK+WcAssVTcVENqAK73g22+Bj1N/xSA2YWRr+6vhvctbmrhZst755m7LxOTg1UbxCBYGNxZcBV4qMNioQJR5kuNtmRdh/908=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791174169; c=relaxed/simple;
	bh=vxJzpiz6x8h33SR2Sw25hXIzSSJ8FJKbLhUaVxfOkBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbzB46QO9LUZaxS5Lno+x695ogfSRHMVEwMwEQYO1qHKmDtwBBZvHqk4DJRxuuMa0FDyDIMISO6kkhOZvOVyKr62njxvYl1t3CXasHNajuQzF4Zse0j16zOfn/ENLl224p2MRgxbAcfPu9A1BMfDSswT6vVLJfOWOclpeOpvosI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=keJUcwWS reason="signature verification failed"; arc=fail smtp.client-ip=52.101.125.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="keJUcwWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0VMfvr6QKbr7ZfGTUJlnOKvkATZX3oIVvIIidrd3PYFtHsjCm8NXoAhTr/jTpjcbknpdRqaBHys3TGB5otD4NGdP9yl98VaHtY71Tv9xYlZAyFLr+zsqSg+CThGG+p0A6o/KT3wCqv+VEwh0XBWdBLvzB8sIo3HaK9vhASukvA4iX0rkpAmGOljmKOwdH6SN84XltMdFlEm0DvirQc1eWe1B9AJO2cE+wk5S2Uyr1baRIMuM9UJi5fXggRWIePkmKImKCDLfOvhGl+1xEoAldmHyQQN3ZlvsIRf/tl2955QyvgX4E+PyQLz8kR9054UiZJZwOcgOG33DN2Z+P7f5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNrDvzMKcSEOn4uukTezqfn//YbNtCrh5wRxp3iLLc4=;
 b=rmF/Yn/Js0P4bV4hEfJR7OZyIljLOINpHfWgGTuuIrP5ob1gUI8uxE5yO2zqhekQPz8PWxPIMMrxsyGvsRMdintTqZP8QXxswrh1BgD2VXLuDoOdI8H7BtcGCq88axQIaGfSyDCBVg1i8ivYjzJxXCRE4W1lVhXAkLYlGMsBfpdfno09xwvAsLDbtv9X5V7piwJrbQ2rpPxMwQdWkn5MaxMMl+RdPXFPTAupabvEm2IRagAOOljnB+HfCz5cEKDgweU9Hlp2dGAfumSafSePQVMh4DoR7NSuLC+/fbNdgW1dagdYMJAYMLORiRXNdeKbUjLYK3h1mv2YFSlTUMoJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNrDvzMKcSEOn4uukTezqfn//YbNtCrh5wRxp3iLLc4=;
 b=keJUcwWSbY742+MfPHlTIjnflOs21MA9H5gXQfBai86f4WaSpJDgEWccMemkWtI0FEy3Hit9aoieHvPtrTAVfZN1wtZDb2qFAJ1Lq3gxdkzm6tXP7KogFR3z85qwN2Wg9T0v+jsJWpnbci4YHJD8zhS9bfK1i5KqXv7mQVg3Gio=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB6341.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 04:22:42 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 04:22:42 +0000
Date: Mon, 5 Oct 2026 13:22:41 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] PCI: rcar-gen4: Check live link status in
 link_up()
Message-ID: <abcodlpsh2k2cood5czno5fqb32uxdrrzy7lwougxhil7zlqbj@b7a7v3kouwxn>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-3-den@valinux.co.jp>
 <d675e0ba-10f3-4503-bc2e-61977f4a5875@mailbox.org>
 <c038dbd9-7675-43a9-834c-915b6795dd50@mailbox.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c038dbd9-7675-43a9-834c-915b6795dd50@mailbox.org>
X-ClientProxiedBy: TY4P301CA0106.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: a28ca222-4ce9-4c01-0bc7-08df22984c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|23010399003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ohbvl1B0w9YCxuR3mjx9wVAoJ4iWwC/wMZmRXPhDhCVo3eo//inITywjVlD5r3yh8yYNzu9Pcvt3s1xji4iaMcENuSvgq6/c0cZZB+HmZBrXuEE7+UFGGTx9/0r3W6Jq8CZ4Ig1PB9aD/Anx9aGGMQkyjbzZjFOsbiHNy84A7avQ+FH7brb/aAtP8sg9zXdeuRnZ1CPz55LsRGG0gy2eOCDG10uS3/W1KBfyJmbDWBvdyRmBSS5s+kJ+VWloZHrjxxMjuvkOPV9qPFdh6YMJs5Dj+gppHN3QhUaBz8bFThjhQP9U3cAmx0TbfQsCle/DOTuz0ieEVfqN7bqC8qy28v+H1+m9qZ5CmKbSRR/DVwQN4ijzYtqY+bWuyVmNLzheOevFtirxZPC+Mbp0LUB3a+HzCGO8IvVZ3lNB+MyRC+AC0I3o/pLDBooAY1QWcmHSDN79Ef7o6IIhZa9IhDtchbbiN6a5N98ghgKwr6yikBTsAkuPdyviMdmIICxWWpi4gGd1Utaldrnw/uJj3HEZRSO9fE5roC8k5W2066T7ursED15aJIg/RD4WxbCRekJm16SDkom7dU1m/XM1zqD6Hd7N6GfU1/CHdIUEzEu2QvmfArRe7u5DC3iTUlEJkCCKKA89JV54HzJzMlQZ61cRSZIk/9Tmx2l+ZPjhDVVMqvQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?rSJ5m4bm0QGuw0p/hSeK2Dn7dom4+L+QvpFRqFui8QyGlKltfhjWcXcZKL?=
 =?iso-8859-1?Q?UIB5i0u8Kywfts40vHLeew7U5xp53ZoZ9qVxY4/LLPFsDOqC8LAW1DGQxk?=
 =?iso-8859-1?Q?XhPkDkSuxWBGSHIZwncJSKeEIXBycuWdeNcMPwJicJK3IBHlrs6Ta7BD9w?=
 =?iso-8859-1?Q?pdPWiq3JlYbTF5Z4556MW+ALmlX4lGZCEBHhaa/xhe2oGGvArGcCuilUFy?=
 =?iso-8859-1?Q?0v3vqjfIRE8ts1fw0BQOFNz+TkQcqyFhczF+PGQoTEo9fa9c3ea2XT2H2N?=
 =?iso-8859-1?Q?w0YUdkcHeYLwcqNj7bMaO1C76Pm3l4oLnxSU4NHcpRp3BsWC8935SRutCL?=
 =?iso-8859-1?Q?MxUPjKXI1PxX/6eP02+U80z2Z+WIGnIqXSrvFdwftyg5Bgfe4WprXiqxsW?=
 =?iso-8859-1?Q?dJYGfj/57p1RM2u9aR4TZ8jTAq2GoF9yM+lqosyWtLryv2xWEh0pSPE3mi?=
 =?iso-8859-1?Q?P1xlJaikpqnzPVtMotal2ovqKGLwcVy5JA6UsIzqHRIBxcHAF3c2yUnzOg?=
 =?iso-8859-1?Q?de5+eUn/ICIiMdZwdctfqrqDpPztnUK7R7rtapzqLvxVybJR9bWl6fXvzB?=
 =?iso-8859-1?Q?RL5rNnJm+jiKaCuLTQZa1n1afb3oiw9z6AyEVsmFniuwD5W+PTaJn4uatZ?=
 =?iso-8859-1?Q?l2N0757MbPjXtLyuLjU1Z4g0oxnYh5nw1mydRigGeSzmav1bjQjv9d5qq7?=
 =?iso-8859-1?Q?Cls+0qCnkP8MWAmCoYJQkF4A1FXxxQuJOIgzyhsVevMRQccG0okmpG6sLh?=
 =?iso-8859-1?Q?hXdkox3VjexQDFPANbmwMz90t/J/oSa0MDACoYySOUtMDfzV1ELdUy2dVj?=
 =?iso-8859-1?Q?ydcb02tCYHNnH//aDxPbJnYkIbKaga44hoxQeT6HPjsHcmWlnN6Jjb590x?=
 =?iso-8859-1?Q?hL+3aYsGMbH6v8NYW0E68n0O9ntzwMioKybDrF4+vzdoRojcsQVHZkCASG?=
 =?iso-8859-1?Q?04u6JU+etHkM/OpdnUeZwh/Udhc7F3g5P51BhpC2AXFO27gJUUVOGoRfMV?=
 =?iso-8859-1?Q?jORvLxpDPNHxgjFR1D1U3gT8+IOTrJ1UoHZ3EPHmKqxqSAcUsf5O3g+1Vh?=
 =?iso-8859-1?Q?QK0ElqkTYJ4C9v+aReIVqVoJ1IRm8/k8UKrxcFsoFu4UIlQs4OyuzL6kQF?=
 =?iso-8859-1?Q?aJbwffPDWFwSO28x1J05gXozcMN7Q+HfaDLyLkJcwc4IQ9f1/+EcKXUuRU?=
 =?iso-8859-1?Q?L+0XLpatxNOc5+2gFYfZqai/SS12CVHWEXcvB0o+3c70kwVYWsbu5x6b14?=
 =?iso-8859-1?Q?h9Hv+r8Elg+KUbCbdI+NRtuYxikJMvtb1J4Lyv4In3GD32aJDFJuOnQfBO?=
 =?iso-8859-1?Q?8P/R9IczV5AuaDOiD8Pp3aoHVRfVxsbL0sMOguGSZ/cibJGr7+jgd/H+pB?=
 =?iso-8859-1?Q?F/fLhllVLogTKcjxflYnaBkm9aAQr2eLNnAwb5C78I00cd7sCTlWmRjxyp?=
 =?iso-8859-1?Q?eyXJ3/oacojaeW/VyZo79eaO4yH/GyH5RMmZbf3qQyG5sJvPfXa4yC1CtO?=
 =?iso-8859-1?Q?6MwVZNWqpW5K6h8QyxzfeQM4kiaStubPsJivFYRCZuvVXYX7o8VHn1hZjs?=
 =?iso-8859-1?Q?kYEjCCiZ++uWeaDpgpfE9RqxVo7loe2P+K+FAXBumk4Vzni9ssr6/QLCmV?=
 =?iso-8859-1?Q?IHcabNz2BgCGJieQRekJ9OpSg0wRSQJ0+sjzFwlE3wUQqH5sjDysFv77nO?=
 =?iso-8859-1?Q?QZPTZD5oZ3lZ+COPIXS+ijHkOKRRpSDufwxpFESqS6FscqU12jNQZgX/MS?=
 =?iso-8859-1?Q?Up6ljuahUYhkzb5NC/OIqlxs9fUZD1047hCQPHNrNXdWrTSbwpjDmJJ7/S?=
 =?iso-8859-1?Q?H1P8QQd8XjRbbeBeMFzv1VcniGfDhcatsYbSn6kxYxDDqpBE6kCl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a28ca222-4ce9-4c01-0bc7-08df22984c7a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 04:22:42.5833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsSm7kExADsZtldhDbIsa8n5O1kQvsgT2y+J/4ekMN0yzwKqg5mkK3H3YU4W2g8CK/sQtNixKfyTztBMlEEciA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6341

On Sat, Oct 03, 2026 at 08:51:58PM +0200, Marek Vasut wrote:
> On 10/3/26 8:29 PM, Marek Vasut wrote:
> > On 9/28/26 6:52 PM, Koichiro Den wrote:
> > > rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
> > > RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
> > > link state. On an R-Car S4, after taking down the endpoint, a link-down
> > > interrupt saw PCIEINTSTS0 = 0x20a000c5 with both bits still set. Even
> > > after resetting the controller with the LTSSM back in Polling, they read
> > > 0xa000c5, still set.
> > > 
> > > As a result, dw_pcie_link_up() keeps reporting the link as up after it
> > > has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
> > > which is supposed to stop config accesses to downstream devices while
> > > the link is down, so such accesses go out on the dead link and stall the
> > > host. It also makes the callback useless for the link-down recovery
> > > added later, which has to wait for the link to actually come back after
> > > resetting the controller.
> > > 
> > > Keep the APP link-up event check from Figure 104.5 of the R-Car S4
> > > reference manual, but also require PORT_DEBUG1 to report the link up and
> > > not in training. The callback then rejects a downed link even if the APP
> > > link-up events remain latched.
> > > 
> > > Clear the APP latches before enabling LTSSM to discard events from a
> > > previous start, and only read them in .link_up(). RC startup uses
> > > dw_pcie_wait_for_link() to poll the combined condition.
> > > 
> > > Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller
> > > support for host mode")
> > > Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > 

Hi Marek,

> > I apologize for the late reply.
> > 
> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H

Thanks for the review and for testing on V4H.

> > 
> > Since next 20261002 now contains commit
> > 
> > f29719b5064c ("PCI: dwc: Align register macros with Synopsys
> > documentation")
> > 
> > This will need the following slight adjustment:
> > 
> > "s@PCIE_PORT_DEBUG@PORT_LINK_DEBUG@g"
> > 
> > "
> > -       val = dw_pcie_readl_dbi(dw, PCIE_PORT_DEBUG1);
> > -       return (val & PCIE_PORT_DEBUG1_LINK_UP) &&
> > -              !(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING);
> > +       val = dw_pcie_readl_dbi(dw, PORT_LINK_DEBUG1);
> > +       return (val & PORT_LINK_DEBUG1_LINK_UP) &&
> > +              !(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING);
> > "

Thanks for the heads-up. v3 will be rebased onto the latest -next and use the
new names.

> 
> A small nitpick, would the following change make sense to reduce duplication
> a bit ?

Yes. In v3 I'm planning to add it as a separate patch right before this one,
with your Suggested-by.

Best regards,
Koichiro

> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> b/drivers/pci/controller/dwc/pcie-designware.c
> index c726aa71c830c..52bdb1fcc2db2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -817,17 +817,23 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
> 
> -bool dw_pcie_link_up(struct dw_pcie *pci)
> +bool dw_pcie_link_up_debug_check(struct dw_pcie *pci)
>  {
>         u32 val;
> 
> -       if (pci->ops && pci->ops->link_up)
> -               return pci->ops->link_up(pci);
> -
>         val = dw_pcie_readl_dbi(pci, PORT_LINK_DEBUG1);
>         return ((val & PORT_LINK_DEBUG1_LINK_UP) &&
>                 (!(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING)));
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_link_up_debug_check);
> +
> +bool dw_pcie_link_up(struct dw_pcie *pci)
> +{
> +       if (pci->ops && pci->ops->link_up)
> +               return pci->ops->link_up(pci);
> +
> +       return dw_pcie_link_up_debug_check(pci);
> +}
>  EXPORT_SYMBOL_GPL(dw_pcie_link_up);
> 
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 4199324882800..2ce61709b58c2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -618,6 +618,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32
> val);
>  u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
>  void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32
> val);
> +bool dw_pcie_link_up_debug_check(struct dw_pcie *pci);
>  bool dw_pcie_link_up(struct dw_pcie *pci);
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index dbc0115885afc..b2ed1a329c418 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -127,9 +127,7 @@ static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
>                 return false;
> 
>         /* The APP link-up events remain latched after the link goes down.
> */
> -       val = dw_pcie_readl_dbi(dw, PORT_LINK_DEBUG1);
> -       return (val & PORT_LINK_DEBUG1_LINK_UP) &&
> -              !(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING);
> +       return dw_pcie_link_up_debug_check(dw);
>  }
> 
>  /*
