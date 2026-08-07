Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022081.outbound.protection.outlook.com [40.107.40.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15038330C;
	Fri,  7 Aug 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111358; cv=fail; b=Xol4cn3cvCPgGLa5/F+D7ZRTDYUXE1YONfPSba6qJIss+7mHgWLMOo+co1yXTlv8+hfs+J7Pp2CEfnKRw4cYW5X4DXN50czulF6ZdNJD+bij9It5EeTONrY8yHet/3GnZPkHgkXknoEhwYQVvhbp/dZQjLaqA9aWpbS3J/q6WrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111358; c=relaxed/simple;
	bh=/9lJTWsK9E1fj1C4rEuOxC6w4R95q7bsGrO1LmwzUaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=noMq0poPA6baB30Fz8uDc+z17Kq53DXJLho+aQ/6KfMBEXwIm3eVevit2c9uDq3YT+wRzHbfQqdQr/bKb/LeIYaKlMROqVLxgqaMOwjaHtOPrpZTAcV4N03wkMzbKpBXyOQAQWuQuY/4Aqn8h8npv9Pc4uLbXw83lKVdyJRnkLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.40.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxDM83pYzozs7Qv2jsNgMRmS+8ujrf9Oe53+jPe0ksKVAZTvEaZthQH4erXb6aliEWMchf2B8xxFUe6kcsD7p1e0MaFtHrVLql8FXYGTBJcwqLa9osnryoxct9BAr1mt6AbvZejiwcwP19qt96QL58hjRVQKse6J3H0OTJZJOHiHc8iK3Ynvq/x9+wm1KXVNPiLU9OKxMHiMBqs0IjwZvlDwmGyebwyWnUek9BlGZQUsxFSx8d5UYgzqKRtc8UwOBz0eoeXtpueJA0IOaIzoWa1gaxUVETzgNDSmS1u61W8SvVuf+N6p35apuEOkVSyo9/UnUH7HmWnwe56lAGfgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uKXMm4gMZJ7Fg9SfblYoDLko0hN2oZTh76pWd2HrNU=;
 b=jJ3P4ipJQScsr+LDuxrk+pYepL1VS2XefOZZQ7ld8AiKnEBZQakph4hUJjU7vkhYMpeu6N3biCXBNPPv9y9OaqQs3L3NZfIfN/pA3Kgte1dJi8pftsnaTAxJkNofpEbNNlSBpFDberFZsj2SFInH6WurNUwiH87umjFtynbEy7+VNGuUYG0d0Fb3RJx+T1aZ8XP95ikxDYR80K0qvcXkNbE9ZVWJjJHzGiGgjHgwtwBHfoSAQ1V2XN+dOvoNCzUomfUlpk2fs3+bLoacJNt2WoTs5zOq9HZ5kD1H1PfWygxmWC9g3xJvzGAG+vC+Y7s0XF5jUhKbVVssTpZejfhrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:25c::10)
 by SY7P282MB6080.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:02:27 +0000
Received: from SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f1b5:3901:d12c:e9ae]) by SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f1b5:3901:d12c:e9ae%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:02:19 +0000
Date: Fri, 7 Aug 2026 14:02:02 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when
 needed for i.MX8MQ
Message-ID: <anXlWlUkEyAUm4_h@08766b221b45>
References: <cover.1785669457.git.rudi@heitbaum.com>
 <563f057f26b1147a79392509b35dcb7f18113ba9.1785669457.git.rudi@heitbaum.com>
 <20260802114928.4CEEB1F000E9@smtp.kernel.org>
 <anT0S51eVwBKPdnM@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anT0S51eVwBKPdnM@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: ME3PR01CA0077.ausprd01.prod.outlook.com
 (2603:10c6:220:1c1::12) To SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:25c::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8P282MB4907:EE_|SY7P282MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: a97170a7-87fe-4428-e2b9-08def48c7ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|4143699003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HMYQjrP4QdmNPz/MrsNroYVl1mwI9AgPq2f7BUB20BvULTytNJPIpfVBuMTHM8OCk3CPAaBQafCnwKoTwoZUoyP5yjwuH+vPsBzF2Xq8j7sPWvU5sQaYcW1Jd96gJBgFToQ4sbAGkM91qKTs2AaGlLZRbJl1Z9NJZaGuZgKBM/9hAkfgHhIp1fwjTSR9HgVnvdhXW2H8sHzr1BbJwcJI6E8xWd6r+D0snFcuotkYZFYydAWRMeGCPLmOTiGgKnDCOAWHaxlKTkjtzp9F7MhS6pVcZwdYcwLOrhAUWFCiq7bv4AQyjn6ykD83x2aw5VqikGIe17G9v80PLCI9maAqf8My8aRkmnLX7IbZ4v7IPbTPsoyvin8otb0gByh2YSALxq59i1+/yl6DAsq09/4s6ffeZr9x8Tq0oA5mtmhO45D5bPDsjr6qQaTZPxJX1s9PEemecfxQlQ77X/r2lizbQyShEils28BA0gqf4IGcg4sxMI+h7pL+Kc/kLLYzf+8zlvdoiyJVjORCZMq6CtgCwCQE9eqlprKPjy2koD/0/hhce/JwuBbUIrjbhVBWIVP52pU+FDbmV16FAc5sYg8EMFo/yKavQCtK1xHMLn5Jr7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?0NKXLeaatffJZwO3RDCtBIEL02xOy77Te8GbI7CHS0PpgCe+AuiDBplV7w?=
 =?iso-8859-1?Q?hQOSf1MleUuABjC6IfOlkQceTSQx4hPcsTcNEBOhERj+tonyc9BY0Kv1Q9?=
 =?iso-8859-1?Q?lo6LvXiCLLDmReuXX1G2pxSnxfXXpT7GYxpWGTn0yU8eaHqe/0iW2AZRjw?=
 =?iso-8859-1?Q?mBIdKwHbLD7fZQkYdYKuzwGpZLhMAYEMGeb8hZ9dvpgisF90WwUVKAVgJF?=
 =?iso-8859-1?Q?TBrl18R7aqZXcwVIWBPCjksLEpKt4NTOSKgYJVjyQjsfo4kLnuse/P47yP?=
 =?iso-8859-1?Q?8PinJLyFIrfK1HWKCroZrfXhuvNJ5RpnF4SELUaxwEouHGZWfu9SbS7u/H?=
 =?iso-8859-1?Q?ObX5TWnxjF/ia1eOn8w5U270fQ9dQoN5FoXFSjO6v73wDClZ3FPQJlah/u?=
 =?iso-8859-1?Q?Ok2kAvJr7orA4cqdoDT6gGRf96+BSiCITeJdyBJZ/VCihYEnHtk8osm3p2?=
 =?iso-8859-1?Q?Mz3WVS7kiR0CrHtM9eHMF/D8/6YMmZs1ic4pCzeQFffiLB6y3JOmuy+3h7?=
 =?iso-8859-1?Q?T/3HaMgSx8/0J6AEEiLn00pLbgXjLbDDjHJcConRJUUxz2wzuPt7ySiNAY?=
 =?iso-8859-1?Q?07pk3ySfVPE6j1YhGQ3v1HK3sgzhrjK/qJ9CadV+nfmkSGS6toay7L5Lxc?=
 =?iso-8859-1?Q?aRdW1FClGQSLTiZA0aDE0mbryFqqAMM/IcolG0DxP8TytGPbG0nnQq03KF?=
 =?iso-8859-1?Q?BeJ3e37ZNvW9km5ptOpCbwpznoyuQFsSbPTxpXbJcehxsuLmfiFibcy8wS?=
 =?iso-8859-1?Q?pYgWlMpxOxKmZq1kGijo+9+zmgaaWB3f9Dec+CQiY7eypiZ24TO3FNvxyQ?=
 =?iso-8859-1?Q?eWMpXu6XuS7iN9AUX3B79y3YU/pwqYEfOEDIaCvp4zwaR99/XmcXF+jRBc?=
 =?iso-8859-1?Q?rZqrVvpw2oTS/CNynOy6sWaxGK3X91dZ8Japi5QNMOGew9YAbfv41k/olA?=
 =?iso-8859-1?Q?ysh0DzRTtz2R+sVO/zIuPQTVVzPLm8P0sx4nQwYKVTeZf6pt/5URQkMFW0?=
 =?iso-8859-1?Q?tY/DCG58NWNRrRYL8NoVxkt7XXGEY96AOoubE5X0Q0QArDObEYVmrveIHC?=
 =?iso-8859-1?Q?KdwUBhWOd5XHv5TpW+oY8kw+zvGPlRp9Jfrm+GMUoefdntK36LtniDOMRR?=
 =?iso-8859-1?Q?YMvkVCgXFUkBdl45BzX5KwnX+7K0WGa4tcbZBV7YlsIXcpf9+uWEHZwwjZ?=
 =?iso-8859-1?Q?mFa2iIz+21CMl/zZJopLtYYzN4RmLYJGL5JgeVlt3b6TrojGGs6z1W4jnU?=
 =?iso-8859-1?Q?Na0BbLuy8yqZ1SOAtWGJi1o7/CuY3x9/j55xs/yBRjAlLYscGAaP2JR78r?=
 =?iso-8859-1?Q?dMYFip9zR0MRg7HWCEr2wTILoQGKRkQ1Z6Fla71v3EXw1XD3E5gWULZvEw?=
 =?iso-8859-1?Q?tG7q3+9qGtPfT9x1CwtLzcUMHYoPp1HVVGqYA34qxnD9rxBVk6+rxj23fr?=
 =?iso-8859-1?Q?uwk48JtbY1SD9HefsEbrkUWXJX4o5XtY2kdkd6sd4Kdoej9iB6BnhNV5V3?=
 =?iso-8859-1?Q?p2owcfH19mxZr0PJmkcKScDVHy3u/vT59O1SspxAstMRhtThKLfSFBZzRy?=
 =?iso-8859-1?Q?TWdxqFqjYL6+pl4y3KBjDsQeGNKDq6ofObFE/hy756JtvpgXmr42EcQGZ9?=
 =?iso-8859-1?Q?jxd4AHPOS9W4/HzJkdKGMamITsAxJnixzNYcFe/YtJDtf4w/fetDboGWiK?=
 =?iso-8859-1?Q?d7p/7qs+3GRqTuDgKk+erhVeP/lGoXiHa/T3oo8QMoBawVWzeLTlPhytdh?=
 =?iso-8859-1?Q?/o21GwKP/r1uJw6yDguXa06agDdqAnvLxPnzFyorNwX8W3?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97170a7-87fe-4428-e2b9-08def48c7ee1
X-MS-Exchange-CrossTenant-AuthSource: SY8P282MB4907.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:02:19.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3aZeFlrzj/JvoDuFPBHuh8Mix7C93kRFF4NNKEnPh9HjUGkafG/n9DS53xrGgpKJ3PVGC2P92Nq2mYExxZmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB6080

On Thu, Aug 06, 2026 at 04:53:31PM -0400, Frank Li wrote:
> On Sun, Aug 02, 2026 at 11:49:27AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] The patch breaks backward compatibility with existing i.MX8MQ device trees by changing the default reference clock source, causing PCIe initialization to fail.
> > --
> >
> > --- Patch [2]: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when needed for i.MX8MQ ---
> > commit 6f37370c304d3692e11e97087dc50e68e2389b9e
> > Author: Rudi Heitbaum <rudi@heitbaum.com>
> >
> > PCI: imx6: Use the external clock as REF_CLK when needed for i.MX8MQ
> >
> > This commit updates the i.MX8MQ PCIe PHY initialization to conditionally
> > select the external oscillator as the reference clock based on the
> > enable_ext_refclk flag. It falls back to the internal PLL if an "extref"
> > clock is not supplied.
> >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 98e1db751132a..9e3b64fecb451 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -445,11 +445,16 @@ static int pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
> > >
> > >  static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
> > >  {
> > > -	/* TODO: This code assumes external oscillator is being used */
> > > +	bool ext = imx_pcie->enable_ext_refclk;
> > > +
> > > +	/*
> > > +	 * Select the off-chip oscillator as REF_CLK when an "extref" clock is
> > > +	 * supplied, otherwise fall back to the internal PLL.
> > > +	 */
> > >  	regmap_update_bits(imx_pcie->iomuxc_gpr,
> > >  			   imx_pcie_grp_offset(imx_pcie),
> > >  			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
> > > -			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
> > > +			   ext ? IMX8MQ_GPR_PCIE_REF_USE_PAD : 0);
> >
> > [Severity: High]
> > Will this change break backward compatibility with existing i.MX8MQ device
> > trees?
> 
> This is problem.  enable_ext_refclk is good direction to align imx95. but
> need find way to avoid break backward compatibility.
> 
> Frank

Thanks for looking into this.

The difficulty is that on i.MX8MQ the absence of "extref" is ambiguous. It
means "existing devicetree, reference on the pad", and I was also using it
to mean "this board drives REF_CLK from the internal PLL".

Align with i.MX95, how would you prefer the internal-PLL case to be 
described?

The only consumer is a follow-up, "arm64: dts: imx8mq-phanbell: Enable
pcie0 and pcie1" from the "arm64: dts: imx8mq-phanbell: Google Coral Dev
Board enablement" series - so I am happy to create a 2/3 whichever way you
suggest.

Rudi

> > Looking at imx8mq_pcie_init_phy() in drivers/pci/controller/dwc/pci-imx6.c,
> > if a legacy device tree does not provide a clock named "extref",
> > imx_pcie->enable_ext_refclk evaluates to false.
> >
> > This causes the driver to clear IMX8MQ_GPR_PCIE_REF_USE_PAD and fall back to
> > the internal PLL. On boards that previously relied on the unconditional
> > external oscillator selection, this regression will cause PCIe initialization
> > to fail.
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/cover.1785669457.git.rudi@heitbaum.com?part=2
