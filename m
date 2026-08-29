Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021090.outbound.protection.outlook.com [52.101.125.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275C332615
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788012680; cv=fail; b=Bv14E9r3JFSpHKzp/2vI0JQekM8SkgYRpaiDusTbzgeTdlgPSNMDGH1dHbHqW7tm5qKoCuXf8wzksOBkTwTp8khWrbSB99hfnKlGcGLVnueZvaHFhqlZivOjbfB6i+1k6P1FkR3G0wZ0Jf9eScs8SBFsJTbS0Z2ZOdaoGFdTx5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788012680; c=relaxed/simple;
	bh=c5dm9CutOui1VpbuiPfg0pbX3Xh2DrEGEHEbzrUfovg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEBWnz0+A1BERGoKd07Y3MCIzX0Ym6yE136vA+yVFI+3jw4bZ53lvGcHalAMTxT8j305pJPoVPOWTqjRz9FWvChV6gPUgTgbCsqLzvsf8RqS7ZyDTlwPtCd5ZecUg3RIr6UgsUUUz/licyy4bo6VlSbM7iUPHREHcfompY95zWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gqI4Zg3H reason="signature verification failed"; arc=fail smtp.client-ip=52.101.125.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gqI4Zg3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thpH1bF3kgG6yS6avXw1BrMeCtY/lURsTavC5jCmywIs9hY94BNRcfWj2JZmIpxqKBR+Vmtv1EGaKfGDWhtGwVrV6aPoyoe9se4VmWgIcq+FKOTXfrKbt5pi0Jxc9cKENAqcHfx48xANMRf7U+a9Wwz/rRoR1OYMrl/xgRq5BsRvUj9X2IrEFD+D7o73V69L/auTsKroxBd5JmqSIb0wY5L9pkILRg2Iaq6GkknQm2WBr5+B20Srqjp7ncTbAiG54K3FC0OmiYUPcix3wFfIRVXUKucRt/NouSjMLCEDHsc3uDeW+Qs8ZgcxSH2bj3/KB4vLOhkgfsJFVbU4cy6QMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX0K+xCXGL7JtjyZqqNV66SR/FgI7mRpxlG5xE7/W2E=;
 b=O7qleCX2kccG3dvRzZla1FSWvd7raPiHWvAAlXMjfTzXptQkRxeJcVyeNZoyl2ZMvYcSQnLJ9ds/aw/H76P6z2MRGvciTT3w6hKAmZZDHDfJ1ovz31b/OVlTpAr79oxJRHEWdHUTibxQzn0wwGHvAeHu/CNd5PN6N5Y3DMKA6Y5o/fnYq0wju1knIpIGljtEK1DmPjGbLd/0WIFHjPHQL70ea/wNKaYAf3deLWr9dGWc9+DvdZc7ZHMHp3Wir0NKFGDFPrW5aNSK/pByNiSnUOBXy7aKJ4s3UdItISC98ZyZjM9Wd4R28/wR9Uhwm5eYchpGRQufPpAL42GzQAMs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX0K+xCXGL7JtjyZqqNV66SR/FgI7mRpxlG5xE7/W2E=;
 b=gqI4Zg3HpI9clVszc6VFh7JbERDRYGW6rVIPK45cqOpm11AwBWus2TKYtBLyBK+stW5xl3Yo8DPPoItsDohupjATbXiXIi+nBGj+tD5OIkACCdPyhjLwOJ7VA1sxirLGqBBFrN9BwwjKCbOL9U/C1WrfyaysKNaWdkif9S32kNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2889.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 14:11:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 14:11:15 +0000
Date: Sat, 29 Aug 2026 23:11:13 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: dw-rockchip: Support fixed MSI-X table and PBA
 on RK3588
Message-ID: <6qpbmznz2w6pgrjkrlpjiq2rwmxouwgmqwefp4bpe4gkdimigf@pk4sromhxms2>
References: <20260827182012.1984960-1-den@valinux.co.jp>
 <20260827182012.1984960-3-den@valinux.co.jp>
 <20260827184108.00F6F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827184108.00F6F1F000E9@smtp.kernel.org>
X-ClientProxiedBy: TY4PR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:405:372::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2889:EE_
X-MS-Office365-Filtering-Correlation-Id: c646e252-7654-4870-c708-08df05d7631e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|23010399003|22082099003|18002099003|56012099006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gybhXbPTWawCv5YY/ChnGs6stoDapEDgR8hKTV1FzEMVnbMGjjn9WbcdE3SK32s9VYWGiTSUXEk9LqrH0P4JxzNKLB6OVt+a5ho65qEzHril46KtPgiWIIilCM7yAYSsZ1U7xWPUzwAHyiV4GjPI+gcS1r4kZ/o3/3Hckq5sxpCVh9EStnk9JmmBqHbcqQv8O6HmzENkIZfBZzHxcNm1DzRUdghgh3MkJ/oNgug+lP7rtz0XexhbyqO2k3WJMC9rTNuiDpEiSygeJQb5XzSgTtuEoebwip5LuKAUuu/XnIZGvwAjiCt2qQo58wsa4A80IPx2TgSonZIKbqKXrr6ypk6ZzXXP9GRFMwGiWP1ja106DDc6oTIYeHz3EednZS7RRQjIajFubov43cpV7qKX8myfYZeukb9QFY0guA9NP2PKDudnMQSKGN3qcgTc++IpVcLmS7LP0OB4hq9QZeZ+mOVu2acPSUext3pAk+1seEPaiWmfSsOjZz4AkJFO//JG3hj6VviLDi7Hsrz8CBycRwvmDK/MOMa1iZUukc8nKvAPkBJ0wEcGPTrb5jGT8aWPpkmuOVtfc3zk1ukM5o0S0rpxy+f5F+JWrGjg7rhv1nA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Ur37oxA1F2drb9v3uOnPpRyZ6HPCMwRqHA2BNwjyoxRQ6Tscshre3DzibJ?=
 =?iso-8859-1?Q?pPlIOE8gswXreRlpn29F/x0dygpj5qPWV29ocVdAO/jPcYU0KK5Qx7IdAU?=
 =?iso-8859-1?Q?izL5mZPzu9TuWfeVMxWDHxWZVwTh5f0m8a16eRCj6AOxw9WQlEUwS69QZ7?=
 =?iso-8859-1?Q?og8ty0FQPAGtGuEfNnemL6XYd+PeCyzY3fb/gRaN8PcnG9BqPz3+LMi+dv?=
 =?iso-8859-1?Q?g8aOYqDSMs23VdbSmSQ5vrHJVbgrfK13yCNG/nZet+YNlYBhNUCppL0zzB?=
 =?iso-8859-1?Q?5OgDs4dkkcSKkQnC5ZwG1BsdB78KCKdcG+POVt1jB5bLHUKoPmqMp5XbEA?=
 =?iso-8859-1?Q?ro58tqv10D5p+9oaIBVgrhqi5g8VejchhXpIC/5x6N03GxEc1VGy0FbV8B?=
 =?iso-8859-1?Q?QSAhfXlgHIUfwDCnWKKz3R3+oDR2NPNxT9+srgJw8NiZTy8quZBCSSDWGp?=
 =?iso-8859-1?Q?9+8B5qfHnU5Gb+fRkny+m5S6WyhF4fdfxqyqRej0tUjEjmj8Gs56LMtiZl?=
 =?iso-8859-1?Q?xTrMYRuGDyjutmBTG6xtC9b2yir7jcvWjoT4T9KQ0xppYf8RKkwt9rzZY2?=
 =?iso-8859-1?Q?N2pN8jHGe6mwYk8d4h9gpnWJVQQgjYudqR2dOBbx5BPCxP+w7tYxGiG3Yp?=
 =?iso-8859-1?Q?m0q0L3agrYye66fYlKfOxGW29oQZ35I1JUrOlXoqY5FK3xBFANFdmjGrPQ?=
 =?iso-8859-1?Q?0mqDujZdi/AcWI6ymsvqsU+TTc5xGUABdjZTld3Seiz0j5LIWjeiqScStW?=
 =?iso-8859-1?Q?F39tgkrFNBWAA8ME9eEMofuZWKmu91bRsLSowR0bW2o1zi9+XSOg5Fz5B/?=
 =?iso-8859-1?Q?aICxetLFA2Ag/tYCEFp3KjojQyIADbzAW6og6dLW/DnX4soztFVeZaLevW?=
 =?iso-8859-1?Q?HwutmmGHfI2dT6rUW/y3S2gLIH5NUQWRqjTIXin4Aby9ZAh7EeuTVteBcX?=
 =?iso-8859-1?Q?APytFWnUJE9gm6a6hgt+2ETTW2OY9epajFWcU+21Y7/oP/++0t9u2il94P?=
 =?iso-8859-1?Q?F8DFEzmiq4l30Uj9hCNxrDil3BKNCBSO33m2ltyASfrfijIAU5pBqleEpV?=
 =?iso-8859-1?Q?1MLIxBcrVhdbPXxjoX2CnAVEJJ614PXESr4CmLvoW1ywh7N+U8PaRD8noX?=
 =?iso-8859-1?Q?Zzfh1poo5c244NrDwcSQA1pEPfKJE4L7MT884wiDowmJali4clh1k/ZYGp?=
 =?iso-8859-1?Q?ZEPTvyHHZPc/9IAWPOaFSMfGnJLuSg90J/qxPKWEMUDsFWEI9zyjLge/j9?=
 =?iso-8859-1?Q?xNGLDv+d+YjTLjgZ9hxY5sKKqXUB0BvObOk+5I7G7xNGWUJIUbEG0YXCBW?=
 =?iso-8859-1?Q?ZBBc8rRCXduuKfeJh5RRR9y7liARpGyqrAV1XP80IspFVkaCg8uW1OpqGB?=
 =?iso-8859-1?Q?fYeR+44zmw24NW/U5ZijeV77jCXbugpCdkfj+zQCpRNqN4dGRlOVsWpc7/?=
 =?iso-8859-1?Q?Kuc4Fl38owQwTZ7SqKz54SDSZ+VdPJpziedz/X79eYZ/ErLIEGcvyt6TcJ?=
 =?iso-8859-1?Q?PRD6tFiFYH94TqkYar26WGlLOwD3J7r3B68GJ7/0V+92MmZlSPeGek2HkE?=
 =?iso-8859-1?Q?UQRt61dDE7bYVbw8goEgRK1mEBkuI/DoxWQR2vx/sQpztZRnqA2P6d6wgE?=
 =?iso-8859-1?Q?jHh6jwBBzPooGYbtoOq0Mj4jwZ+QFUpMusrzH5p1Rz/M/oHpJRly8WBFe9?=
 =?iso-8859-1?Q?a8yx9I35OwD54RZkUHeFjoGeefcOUguvUJ3jjZvpwN19v1eyfLCBIsmUON?=
 =?iso-8859-1?Q?7ZNECYLEJlQUCT19d6A8VkYgk/pKFw61raNY84wpFiYcretL0NjjsC5UiG?=
 =?iso-8859-1?Q?SJ7urEAf9faew9cUkMgE24egVK9WWAZ9WwWpvaRDUHXiBJR0MevK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c646e252-7654-4870-c708-08df05d7631e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:11:14.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpxZpSBZTxVsTwq0exTroU7VvfbPoYkrl2bVS8DFM/UO/0U2TciXUqoldOHVuo21jq1/K7bGfuNgbUOEbgvQkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2889

On Thu, Aug 27, 2026 at 06:41:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unmapped epf_bar[bir] access in dw_pcie_ep_raise_msix_irq() causes kernel panic when msix_hw_owned is true
> --
> 
> commit d51d0db24756ed54917db6dbe19e86f2adfdc77f
> Author: Koichiro Den <den@valinux.co.jp>
> 
> PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
> 
> This commit adds support for fixed MSI-X tables and PBA on the RK3588
> controller by marking BAR4 as a reserved region. It introduces the
> msix_hw_owned flag to track when a hardware-owned layout is selected. The
> RK3588 then overrides the MSI-X raise behavior to use the controller
> doorbell when this flag is set.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 147b043589f02..bc2b63814dea1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> [ ... ]
> > @@ -764,6 +784,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	reg = ep_func->msix_cap + PCI_MSIX_PBA;
> >  	val = layout->pba_offset | layout->pba_bar;
> >  	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
> > +	ep_func->msix_hw_owned = dw_pcie_ep_msix_layout_is_hw_owned(ep, layout);
> 
> [Severity: Medium]
> Does introducing the msix_hw_owned state here create a potential NULL pointer
> dereference in the generic dw_pcie_ep_raise_msix_irq() handler?

I don't see any reachable path to this NULL dereference.

RK3588 and Tegra194 are currently the only DWC glue drivers that describe
PCI_EPC_BAR_RSVD_MSIX_(TBL|PBA)_RAM in BAR_RESERVED BARs. epf_func->epf_bar[] is
NULL for those BARs, but:

- RK3588 routes hardware-owned layout through
  dw_pcie_ep_raise_msix_irq_doorbell(), as added by this series.
- Tegra uses its controller-specific MSI-X path and does not call
  dw_pcie_ep_raise_msix_irq().

No other in-tree DWC glue driver that calls dw_pcie_ep_raise_msix_irq()
currently advertises a hardware-owned MSI-X layout.

> 
> When msix_hw_owned is true, the MSI-X table is backed by a hardware-reserved
> BAR, meaning the EPF driver does not map epf_bar[bir].
> 
> While the RK3588 controller correctly intercepts this state to avoid calling
> the generic dw_pcie_ep_raise_msix_irq(), the generic function itself (which
> is exported and serves as the default MSI-X handler for DesignWare) is not
> updated.
> 
> If any other DW controller adds a hardware-owned layout and falls back to
> this default handler, it will unconditionally dereference the NULL
> ep_func->epf_bar[bir]:
> 
> drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_raise_msix_irq() {
> 	...
> 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
> 
> 	msix_tbl = ep_func->epf_bar[bir]->addr + tbl_offset;
> 	...
> }
> 
> Should dw_pcie_ep_raise_msix_irq() be updated to check msix_hw_owned and
> return an error, or otherwise avoid accessing the unmapped array?

Still, I agree that the helper should reject this case. It is not an automatic
fallback in the DWC core. Each glue driver chooses the MSI-X path in its
.raise_irq() callback. A two-line check here can catch a bad choice in a future
.raise_irq() implementation and return an error instead of crashing.

I'll add it in v2.

Best regards,
Koichiro

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260827182012.1984960-1-den@valinux.co.jp?part=2
