Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020090.outbound.protection.outlook.com [52.101.228.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F83A7F78;
	Tue, 17 Mar 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760680; cv=fail; b=U9W2TWI6TJdd3JRPtm6+UaFM6+OpxwhtBbpYUBaokSAY72P44jx9cVluhe0kacZmpYnHUYqcUv0bJlBQ+dZyQpjESuwaZ2OlJmsR6304NUdblkkXy39ycH8ahigCUqz9CEPIhP2oXp5wMqlevvHdcm8Kt3Cu3TtGkDjryb8lDjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760680; c=relaxed/simple;
	bh=lI3cYw3B02VpZZp12jz0zS9V2OIDSfEl27TbZb53QJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=shCFdVVUv2nICv8/b6I7FsNwUcA1u/Dgb9C/YxDJEg/FrwjyHxQyzGq5p4hXks9GUU/0KJ756bFPkwI38dAkDQBzamux+Vo7yylAPdkQRwBQ7pqeedzifzyiZ/RXCroKmV1h5CPr2hRi6XkF0+sA2O0MGQSgA7wsRbLqjWf+lu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WbTnktNF; arc=fail smtp.client-ip=52.101.228.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WbTnktNF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKu73OzoikqyeoquD1HiQ8gZo72qhd6jJ5GvmkBr74ePBvhwJLx1TRql/REz0mVPUFdbQX09ow+JAX4PYF3REylRCHnJTV1ZfZbv9F3GcZndYkHPafwV1n5r1krAxmdO4c59SahTnDXESEGwmorl3gLy0KLQK9jA6kM7xXs7uMuoBiGaY3ZIktvZd48Qnx96jYS36EzxXW/kH/8wqo1CkJI/ipvXwxNXDVGfRB/0kjjtfV0eXaR06viKN5zPxrcB+4JjF2wF/87ZyaZBWZ2ZvhkUxsEQy/D6hywhiEz4dgzNzfSHF1SrVCaP4HG53W/Zs9f+nDenopqeYDTCYo+7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfZxMYEYkBOJBPloQd1spHn6UYcSSJfnMiGSBPeJy7E=;
 b=MeZbbczSJXD/H72C4T7Wv+Lpedcl9+8xJISa8gao249NTDdT9aI0lPTqzCkmjSqWuURKMIQKvfDDGGUaopmk/dpK9RhnKVUMuYudyNZCAzKynz9f6oVlJme/YJOWF33pDbn4B0BJ/+iVWixXfU8H8S2TdVlvahQ2RABmvQ0eDcFvVDDHwC74TrfD+E6a/WF6qo8WOl+UQB/dP/joe+Utm+cbqCXTxtNwVW3LOU84o+Ot9f25jr7ucw7sH9fB+/HZ/SXO6yG1DlKmUUhz+JEOD/6oMoyjgisVnhbPvtWT/RgbGoGI2iyqILpXO9WALe6q95ZaDvj5/tbCBg3/LySPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfZxMYEYkBOJBPloQd1spHn6UYcSSJfnMiGSBPeJy7E=;
 b=WbTnktNF0ZIcpIf7VTW9SjNnnTwYCREgvnU5CVL0ZjmnqxBA0UZ2JT/YzVtc4o24NeTff72a3qITi6GcQYJPuHCUc4/O0DWCCs11l3La/F+eNLErcrV19mV/zPNfRbpI7C8m5bHyXYyx6UI0/1jwTW+Ihg1AvKjk7qe5AFpSl8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYTP286MB3628.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 15:17:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 15:17:56 +0000
Date: Wed, 18 Mar 2026 00:17:55 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <cxejulmvcuttcdmmtqfq2lr4lur6h7oq5dbrttoh2lp56o7wqr@x6cu22zzmcvc>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
 <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
X-ClientProxiedBy: TYCP286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYTP286MB3628:EE_
X-MS-Office365-Filtering-Correlation-Id: c25ed171-185a-45e1-ad1b-08de84385dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3g68B6QuyxrtWwEIW+xrSdfztPJZct7e9sXCD6FjVl/zCpfysbqAEBy0gfRYlGMn26PrV+iCQKn+0e3kws50AG3PJxgtrPnG+37ipx6KyoDlxmbgdutP8EU4yR/iphUMiPrqr19v1zf18nKOjeTKiXdIL1IJMARVYt0V18ziqB2RtGUgUSMYB42khwYe32hGSahsTT8HX+WkX8fte2fAwAUYmnlho7pAChyHC+CD00mR9f8nACNs7rAFMvEl+6sa+v3GDgMWgFLJyeuObaEXB10ePthxFPdX3ZTxdcUW6BlrRdDyvefroI43HZPZajPv6I88UXpP3yTyarbTwSMt1eyRFL/Or+BGR4idImFdFGIQKMf+0oHaw2baqQc0TG5awo5wClJxQvYwpNWsiWieFxrBhQHSxzfwTxr+eair+z/jXPneKA2mS2J7j3malQJbSxcDENNhtMhtPYgo2o5ZXSOpNJY9y2+lE4Vq6KowyhkskhM+DQh17vOczfPb1Ax0O6mQQPgwyyHB9YS33Zavd+67UAj54/wJgKyGR/CYQfq2vNFA/XhF/SirUnf7mgXElBIUGTmmS4GCmXEgW+UlXvjUZbeKiSjXR7TvPP6MrBMHp5xe3iawdH1/bKY06dx0xwgHn12CI/pnLTWexrm+ExwRQG2tn2d7rGzYTFo9mADkQLV8aFSeyb5FocdMoI+kpSH6d7j5/weVficMuOqzwvsszxVarixk2UzHjwY6KUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VvrfqizDXbNpqfAtLQCm/7ZbrxT+cBTsw0aELdKxlW/p65cK6mmW5d9avUC6?=
 =?us-ascii?Q?bw+Y2H0hrLD3ximl2o0i0txib1cdc6N7vKFCt4+lhwyWj8z01qCjeHR8b1Ec?=
 =?us-ascii?Q?PCPyaZZQiWSimF3hPV2YGc8Hf3VqcU1EF3P7IBu9R+yqx/ccpEzGNA5g7Suc?=
 =?us-ascii?Q?3kfdUqncWMeFAEZIMLs25wrVLXK4TYQYiLyXUjBjFeX6WRPiEgwBsRs8V4E/?=
 =?us-ascii?Q?i+ZJC5x7LrBYi/gYiOocPWA2TW8T3cvl+1dOYC8cCLdeDSnzpOI07G2yE3Sh?=
 =?us-ascii?Q?H9TqWh3FlN0lGTVYC2kG2wvAv/0vqfydpRWXra08FerF5ToeCPlKmViSrzhb?=
 =?us-ascii?Q?RUG6j+onBvUQgeN8sKXN91HWfLF4E+zTNOSLOK7GDPj+puwrnrBZMVO4dfzz?=
 =?us-ascii?Q?WFnMlkEIZnDpriwilvqTbRNel1MpeAW9MqN6QA2/rFEOl516GGlDLWfHkUjM?=
 =?us-ascii?Q?VCJwQEYlioFFQD2Ph/k/bOSbJ6BxyYpFOxbc7AoILPfBNIV+BPpISdK34xDV?=
 =?us-ascii?Q?94xtuis6C8s5tF+lSh36+DzGmoNqOuNnPsFXm0FoIdFKxzgv/gxPVrvAXfHO?=
 =?us-ascii?Q?g+jJgtcPUHJ+yrn6gIE1CI0tTBlrBuWvnDpGsZa4SAT2B8aUvdyTh4CN2mHi?=
 =?us-ascii?Q?l59w0r2dPaVvyhmnITDIgq+YdaNcB4lV1Beuzn7rC+18CRG1vPOEaYkifzow?=
 =?us-ascii?Q?mUGB5YkPnCZp3pcWMxUZHRCYYJ1n8f4jWkfIN8nESfnpzD9f1gdryUGXV77Q?=
 =?us-ascii?Q?drMwOrixVDyiNrvo+INEmFKI+/tin905usG9RX4qxbE+EjVjDnDQ2S6Z3Ria?=
 =?us-ascii?Q?pc8Ih8KiUpu0/W/1YpLDQjQhx7grO+aaRFWH4eWKLY13vq7CUHCEZ1GLVDcK?=
 =?us-ascii?Q?m6+nc/WIGnLDAQWYWgCjXr/kEbCTywTWxiusLbcnj1eK1QlKYpQAXc24W0RP?=
 =?us-ascii?Q?/w2EqR3sq86tEZo1IE8csKg4eIkt97D9pQsJ71rNz+RwZ9OtSBk1Y16vjdDe?=
 =?us-ascii?Q?IYGMRKvrKjuj+vuEAmcD7SjqMaN8GgtpXi/bVQciW0/eI5B4murNgC/G0YZW?=
 =?us-ascii?Q?DYGRgvBo+al9/IrrTwNfCTwo+UNLVAGIuVY/tVFfgsX3q87+pX8aJPt0PFYt?=
 =?us-ascii?Q?0555tnmGZlcdNt9eOuDGXRsermpF2gdbC8noKlTJAwaNu6Ja/f3V04LmpJ0L?=
 =?us-ascii?Q?BQIgkNp4aLbiqWsDqiSq0kAcB1t0f1m4c2SfDuIpbnWnszzixUQk5lt+svJL?=
 =?us-ascii?Q?p1q3N0Umce9Fjd6+q5qYHHhq55ZYgN2KYrbELXt3wiUAJ17AeZ2rQclezxLH?=
 =?us-ascii?Q?bDn661i6GRvQaYlNvyb0E4xCl/eDIGEdC9KwqE5mYzw7WjaVW0s1ZVBDWhr6?=
 =?us-ascii?Q?RkJieQPfmQHG6ZJ04Llyk1IZKnBmYGLmVzOoz541zqlazeZkC2Ys09HQDTnz?=
 =?us-ascii?Q?txdv+LAk6GPLktz/Tbtoo61AIlEkvZBwXjnDHCb3a8iRSR7V8JMxyaHY9oi1?=
 =?us-ascii?Q?0Md+Z6mWyF8D5OWffa/spBs52jnXORsdb68cSX5pNArcU/kNdPWNBUZ5wMwX?=
 =?us-ascii?Q?rDLrmnszrAgIaQPUjjKVjsE5HkzgE1yVpdViJzRFtOyC6M6Wwj/tyKgI8T/2?=
 =?us-ascii?Q?P/fDdf3doYBLek8vscMTqEGvHFBgu6t42dy+3u6ofHafnwIJGj9gv73sx4tI?=
 =?us-ascii?Q?dGLf5+056LMTBtGqDl076h+oKJJGybFDzhgxLjTPGLJY1S40GNEpMUz+H8vG?=
 =?us-ascii?Q?u3kHR4ZXdu82Oi9H0uFpn0BwlUFnbg7BXZhjG0pJ0T7h/NYQMW+e?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c25ed171-185a-45e1-ad1b-08de84385dda
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:17:56.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53jOdcV8VAMSpsZT4MZ4LEMgoinCm0vwq1TbqcWuEOdYvewx66zoZ4DbMNRqbK889f5CmtDeiXwwkST7dk830w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3628

On Tue, Mar 17, 2026 at 10:55:31AM +0100, Christian Bruel wrote:
> 
> 
> On 3/17/26 10:24, Niklas Cassel wrote:
> > On Tue, Mar 17, 2026 at 10:13:52AM +0100, Christian Bruel wrote:
> > > 
> > > Tested-by: Christian Bruel <christian.bruel@foss.st.com>
> > > 
> > > with the DISABLE BAR dependency
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=33642e9e36dc084e4fc9245a266c9843bc8303b9
> > > 
> > > I will need to update the pci_epc_features after the merge.
> > 
> > I don't think you should update pci_epc_features just to be able to test
> > the inbound submapping feature.
> > 
> > As I said before, I think a better option would to ensure that the test is
> > skipped instead of returning failure, for SoCs with too few inbound iATUs.
> 
> So we will need to add a SKIP ENOSPC case in TEST_F(pci_ep_bar,
> BAR_SUBRANGE_TEST)
> 
> Note this will be equivalent to set .subrange_mapping to false in the
> pci_epc_features. But I agree, it only pertains to the epf test driver, not
> all epf drivers. Touching pci_epc_features is not a good idea
> 
> > 
> > A real EPF driver (not the test driver), that wants to run on STM32, and
> > wants to use inbound submapping feature, can simply ensure that it does not
> > enable all BARs (the test driver obviously enables all BARs, since it wants
> > to test all BARs). That way, that EPF driver will be able to use multiple
> > iATUs for a single BAR (as required by this new feature).
> > 
> > This works because all BARs are disabled by default. An EPF driver has to
> > enable the BARs it wants to use. (E.g. nvmet-pci-epf only enables BAR0.)
> > 
> > 
> > > 
> > > A more general question: I don't understand why only the STM32 is impacted.
> > > It seems that all targets, even those with 6 IB iATU entries, should ensure
> > > that one BAR is disabled to handle subranges.
> > 
> > I can't speak for every SoC, but looking at dmesg:
> > rockchip-dw-pcie a40000000.pcie-ep: iATU: unroll T, 16 ob, 16 ib, align 64K, limit 8G
> > 
> > rk3588 has 16 inbound windows.
> > 
> > Probably most SoCs have more than 6 ib windows?
> 
> Yes, probably, thank you

Just for reference, on R-Car S4 Spider (r8a779f0), the number of IB iATU regions
is 16:
pcie-rcar-gen4 e65d0000.pcie-ep: iATU: unroll T, 16 ob, 16 ib, align 4K, limit 4G

I'm not sure how many IB iATU regions are typical for DWC-based platforms,
within the valid CX_ATU_NUM_INBOUND_REGIONS [0, 256] range.

Best regards,
Koichiro

> 
> Cheers
> 
> Christian
> 
> > 
> > 
> > Kind regards,
> > Niklas
> 
