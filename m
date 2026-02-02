Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E802D2493;
	Mon,  2 Feb 2026 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044657; cv=fail; b=DBvPTJ7HUq6WuWFX40ytqBl58XXyVuE9zxdvfEzVbgFIvaLorqfyXEdbSXkb6VeNAdEo4FglHnhEAFVMMojX8ArIB5fv4fSlZRt+dd0YEpHrxym4YnYXwdjveezxA3L1fw7OdeMeqDWZx2dItGLOGuSG8ELYWIHCVixB95lKs34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044657; c=relaxed/simple;
	bh=pWkOvKz/7uHLHj4beIbkt2mctMPUUxc4vWIOxfAYjqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KvYmCCxhyjH8jxRGEAxzU4XaMml8vvOFWtZruMxReEtrb5jPs9VkOZhRR0YUhlACefTA7qLiMSj0pZWqa+2szi7ZfP32uHw0kVrO7NR62UlrS7M1n6fL+fLALVvzBpB7FvvQtUtDwMKdMsxS+58WYn6q6rdyK5ITMkrrarcePws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mZJxp2gp; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mZJxp2gp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK7hl5or1ryN2l+g70Bu71ipVa3KYVnpQIaokMW+nGCVuY5ql8tH5vK7mUPAabZm0pyowsgxj66sbkrvhr+XsTs+UZrMZ9aYwrpnPm0lDz0DaI7CYEOTmrVMtPsl3Y/tA6UA+uGMljMycvTnlXv6kE1vxz6os4DqmI0q0eizGhSckn2kpP9XSpxGvMoHfrJBgRM5rJhL26NwvMOf+MQKYbdNridBcTL+m5PTzIx1SYgKk0TwSmnb8+fM2kddQosCtU3dEfEthUEuptujsu99p99BDkbljvx/WgiMGclkZ6qMtV+rFT2ioHRygUTlnBflxWk5d6ElBBUSU+W4l15vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVbu91/h9cqsX0AOCA8csaVz+fS2HcgU3A+nTWd1w4g=;
 b=t+q7LHWKgijKcdwh2M3Lz4KK4TxL7Q7vDbwRpuzQkZB7bucsTtRhzI/LeLzCuMIqRY6G4QrExEAS73VMxG2Gk+7RRJvA+c4nWYv3Q9dAvjUUR4gJ5N4f/vmq1Ad8Jtn8HXOzOJnU0mGu7NPNZ92VJrcWBFig+PrSBXsy1xWwfHwTwFf/Zuc1AZOpHlFF+cBjHecRF3TmKh96mShtULKrC2Llsu4GtFZCN5lefiz5CmR4tVQZxi1BT683RJn0FLh/V43ETJilt9UiD2umbJueHo8jqyNpchP63veNpOgc5wUQQf75V5HevKN+JwKyGKyy3jMfFelVFQZkHFXne9XZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVbu91/h9cqsX0AOCA8csaVz+fS2HcgU3A+nTWd1w4g=;
 b=mZJxp2gphs1cH7cIjfHfid8nmKqG22bIIMfxZrL48HQQRKfkOvFylMlPn7LoGa9KgOXSbC1G+fYsnBwKivKESg+SWg7vg8ef4bGAlJSBeDZIn07dqYYA9ANzutSKT0yNaU1z3BwfpB4U0KGbFrCAHEIGrxusDH1hrOSSCy9cYNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7748.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:04:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:04:12 +0000
Date: Tue, 3 Feb 2026 00:04:11 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	robh@kernel.org, Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: Document pci_epc_set_bar() caller
 ownership and lifetime rules
Message-ID: <xzred2tylww7hbwrpov77h337r4x7mtjgdslgvwfgnooqjv6nx@cyo6mfj3v4hv>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-4-den@valinux.co.jp>
 <aX4y3txKcYmb-kE3@fedora>
 <4erlj426nvmilwfdq5e63ojiqecomcpj35nvmiyw2p5mvifwlt@yspmfxrzmxei>
 <aX_HfpBoQX4j7mag@ryzen>
 <sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p>
 <aYBt8OSLKC6F3nZG@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYBt8OSLKC6F3nZG@ryzen>
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0474e4-c98c-4334-5be2-08de626c532f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7GEBPg9Xt+Txuf2A3f83UNDwFF4WaaKIdoAJS5WouxcC2DJiDNQeXh6V1rHq?=
 =?us-ascii?Q?F1d1cOIYaDke/FQKipzWcKsZJhglpMbXAOnSYy5yZ2faFR5J8s9GDgaZmKeI?=
 =?us-ascii?Q?8KUbc9ldXxESdY9DFf4/nmVZI0bRuux6VqKGRctVP4IK/jrnd1RGGrIu/QC/?=
 =?us-ascii?Q?XqRVR4GfrzF5kv2HJEAW9nC1Q6bl3Q4bb/gxA/tzagiXNwV4iyDICR+nUxDR?=
 =?us-ascii?Q?lzuU+h/nffgiIxGBALtfJ35RlqHm1s8ASvVH3qZqHFePDYgDxf97vT2+8Ih8?=
 =?us-ascii?Q?7gOi71QCOhpw5iG/7Z+EXuXq/9c+wWFvdjJWaUwyBBZjc2DzoiJlC92TQhBc?=
 =?us-ascii?Q?kMshvk0eaxs1quhDl4M5UYXEd23jd/R3ekXmbjJ0WXNLQmK9OMYWdDsxuKN4?=
 =?us-ascii?Q?0L0BzHAdo+Pw1T0ZXbUXvZQiLFnff+StYjcvetpyLPBXH8fPwBscOKNY/lzD?=
 =?us-ascii?Q?sD6iEx6MBCZkLVJ2/7LEQzmQDHaEVOZGwJ86H6yrDo+9vytymu57dDMFqdIO?=
 =?us-ascii?Q?exlnbZwFecRMWMDs2Z01FvzQWY6tbTA5TxGaLz0UoUnMfKAVmhsNtQJ5qWHe?=
 =?us-ascii?Q?dsQ+2Ofpcsu+Vr3SNfmfAvIQHtMP8MKm24Zh4A5t3uN2flIsccgPt6CQCsOi?=
 =?us-ascii?Q?2VqBGKO9CIlKYDicLOsW+Jvl2CMzunskh28HmtmP6ZPMWby65fPmyYinH7np?=
 =?us-ascii?Q?lyzxqDWYYSNobTBOed3gNn9xVDJvmruS2nZe/L2/OUWwmdQGWqjCEcPgO6+5?=
 =?us-ascii?Q?ui9w7WvMHpK2iRYpXB3OlPOekoBewpnpcKiBd4YtMzUrG745BSQySIEVpZzs?=
 =?us-ascii?Q?y/Rp5g3flNGL/3uWHpMISQPi1CQ76dlkhC/bvJ4gfyZYwoxmxladg80TRLKH?=
 =?us-ascii?Q?TNot2mlTIxes6v0Ic95is3HECj3ev6frZEw6OxJE734IYUN2Qs528JSuD5ZR?=
 =?us-ascii?Q?uMFY2Spess21DuMkrFqepnll4ZnwaZOZeLDR2zlH2K6SbyckITDzNKxtjMv4?=
 =?us-ascii?Q?Oj1kd9o++y+e7qCDxiB+nSoWvsNz+/Q1A5N+YMdq9XDm6owW/AbyhHDxA3IP?=
 =?us-ascii?Q?i24XbEAfKFe/c2rRNezjEVa29GHdaxP0AKpk922Jtwkfxz+iVYGMPck1Etae?=
 =?us-ascii?Q?6UMOJKB9HGoQINoy/oRpgVAORiRIMj7GGV8Po2ILVhrB4BDCCGQjuZymE1no?=
 =?us-ascii?Q?AKHAot6ewg1lG8v7Yg4P7UoZlS/IYS5+2HPiHShFQ0QYm06m/DDYy8w/FbND?=
 =?us-ascii?Q?3qhRPePcIECbjCUt0P6TqEgxEWqEU8n5oa3O7nU0NF44boCJbo0zq31edW38?=
 =?us-ascii?Q?KubFSYXiiAGEdpeO6tEO3ds9rPingWqIYAM6AEGLyLQDcQpmAY2loegYdCKN?=
 =?us-ascii?Q?AMYmBdtrybId3U9QdAIKeGa6GRVB4ZpVI0FV+n6JqLm3v7OiaWS8tmWbygr+?=
 =?us-ascii?Q?2yCQm8ujSY3AeZTfq8GS8G2KTTEHIcnjfIhA5N1Ch6RIUdq0LayENvv49HFb?=
 =?us-ascii?Q?iZGmwpFTmSWGNF2Rp5hI6/0VkzPzUQFWZxmFOH/t3jXf+rpZyigrVacDtEuy?=
 =?us-ascii?Q?Ws5Xz364RJk4/BbvgOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jrKG4rWj01uD2sZzisocT2eyxiigG7pTELAJmD5vSYE6NteEgLuwc0BI1ev?=
 =?us-ascii?Q?ADZxA8tLZoInBJRipsx2kXsHrvEPhw8Fb9wXxtNfj3uSVzRa1vG+4Akd8aYP?=
 =?us-ascii?Q?svN9d29hEmfPiCBIRdZrNYDZDhoF2UHFYccMxA+GysRdwxtNOLAAakcrBeaq?=
 =?us-ascii?Q?82g9qL2djY1InYOiDnQw9NP36fdHPw9n7cdTtVlfRLG1Y1iX5LQ+Bh7v9i2G?=
 =?us-ascii?Q?ROMrpCIbn+Zs66dlVYWhDLwQpoSIdAXhx8ffBVnTcbdcsRVral0Q+LkaqGSd?=
 =?us-ascii?Q?i+26crU3iZEWSHCC33AArxXgj6Rd7ucT9WC+grH2OaTG713ihP625WkkzfRX?=
 =?us-ascii?Q?aquzpI9uEEy6VwbA2ymlHUkXgW9kY/LOmVhyqiz7jUJyEaMfzB5TS8jBES+V?=
 =?us-ascii?Q?x66bI0Z1Dhe+vCGP+haisWNDK5DEGDeg0kNzojMRtJFa0czKv9VTN11yrjG5?=
 =?us-ascii?Q?eMlhsgV6hJkrB+njb5clwxiigi3/rJKyVan4Xo9O8QyKXOuS/fO+UkYaZT28?=
 =?us-ascii?Q?4HQCOeXkyIKaBHGLsyQgv0o4iTM16xBHouVUGeDfroRdSJ9gVTi4JVcO9k9r?=
 =?us-ascii?Q?Glr/WJTBrhuSzWrpZOdRO9Og5HCa6pRneAnGMXPDMaVW8InrFv1Z8qtxMT5Q?=
 =?us-ascii?Q?Ay26SL986YfhYz5yJ+a9xpY6VxP6kfCMmwzyD23iFB+KXx6uVxXgKHhzzYq8?=
 =?us-ascii?Q?TRfTWgd65FALDnh7PBJAo/95b8OzgGsoUCv7fesvxGJtJNewGfdDiN2py6PC?=
 =?us-ascii?Q?KtuzswhZx8p2CbaNULdRroHQPGj6Tpnrwx/JXe1mTnhFc6nwpTjMgM+s+03Y?=
 =?us-ascii?Q?QTsq9v5MIZzoAVKtX4mP0oNjgWlJESv1yHeTBm27c+TFF2XOIQjzLju+XeOa?=
 =?us-ascii?Q?1XozTVt7SaUyErA+kSohet+2fa4qdMR9kJIbl2YI3LSDP6KyX4EqJj4hZAY2?=
 =?us-ascii?Q?xUjgTEhwgnu9rRBf3tKcayGTkrMrLMEAj8Ho5jZLC2L39TKJ7XAOAw5z3XVu?=
 =?us-ascii?Q?tApdL7CmCqCcMzp0h5QSu9C2QXuWVZ6OoT6O90PaM0/urtX8XEaaQyuxjQe/?=
 =?us-ascii?Q?3uu3rzvL+tbmwdkFhMgznkHtTzLalNpfesfLuUZ0dmfISjlw3GBc5Wb8pXdy?=
 =?us-ascii?Q?qvD7ENOZqEQVynrQdvnPPa+FGArPAazbMx1F8lqWOtP7z9y/Q8s3mDNcrRp7?=
 =?us-ascii?Q?P4gc/MAoNF92igiDRMeWA7dewSXaeL2odYtNbuyYJDPzVZTQ1JO9z7JLz3Or?=
 =?us-ascii?Q?aTXcmpV84r2qucWF0VlBKD7YipoGpVAXt4WbTxIv4LRp3k/x3sybo7UlGHcj?=
 =?us-ascii?Q?ASdt1+ZYMvICkGcUMM5MdEd9Kods95bVFFrXBHThROeMGEKxH8LvCFkplW7y?=
 =?us-ascii?Q?lKkkqm3IgZ1aTdSLHAVsgGzBOvWgEeWdjfYDy7vWmuRpBcKN6wkdv9Gtz6Ub?=
 =?us-ascii?Q?1/mdr33cn3f5fUODrkB9mOOWFjYnm/rP1AZ3JiYQofCpCb6WNqVmg1YCG5gc?=
 =?us-ascii?Q?enQ1k1kO9d5fPSPcqFZxNAYGC030rtjMqYqI1zFNAOUVV6qYpqEXsHi171ow?=
 =?us-ascii?Q?O0fCBLEa4FvcMv/rNZtePD54Uo3VfGvRGdKZm4aOVB0diD5rpgvPX+Ri18E/?=
 =?us-ascii?Q?MdJEFQO4WHLepOiXBzAQ/yE0/LFdoh8OHompCWqOT1/AsPeRWveMiMnWGIMQ?=
 =?us-ascii?Q?+XiurfDIMzhay+M3DvC6tZ110mKTNQtwhOBoB8ioTk1oldzuFWCQufEO38U9?=
 =?us-ascii?Q?I4ThP9xPIVneXqjLho0ypS3M53qOJ4W32DZJ0zpBgxjnuA1HEA5Y?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0474e4-c98c-4334-5be2-08de626c532f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:04:12.5433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sklfcmjrjXU54PliuAU+5sRO4rhbW7Rb407htpWdUGIUMTl4o9xQP3cRbphldFwTv+IEzOKDhkhBGgm1ZcZjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7748

On Mon, Feb 02, 2026 at 10:27:12AM +0100, Niklas Cassel wrote:
> On Mon, Feb 02, 2026 at 02:59:35PM +0900, Koichiro Den wrote:
> > > 
> > > Considering that struct pci_epf_bar lives in struct pci_epf, I think my
> > > previous idea of doing a kmemdup, seems wrong...
> > > 
> > 
> > I don't think it's inherently wrong. I think it really comes down to what
> > contract we want pci_epc_set_bar() to imply.
> > 
> > When I saw your earlier comment:
> > https://lore.kernel.org/all/aX019VTWjMlPX8qp@fedora/
> > I hastily assumed you were implicitly suggesting that there are some
> > outliers (such as epf-vntb), which led me to think we should document a
> > single "legit" way to use the API. In hindsight, I read too much into it,
> > there doesn't seem to be a clearly established contract today.
> > 
> > One subtlety if we decide to treat in-place updates as supported: the
> > existing dynamic update compatibility check in dwc [3] becomes officially
> > best-effort, because ep->epf_bar[bar] and the passed-in epf_bar may point
> > to the same object (so comparing against the previous state is not
> > reliable). In other words, changing barno/size/flags via in-place updates
> > would be caller misuse, but the driver cannot always detect it.
> 
> Yes, I agree, but I think that is fine.
> 
> If the caller does a fundamental change to an existing struct pci_epf_bar,
> between two set_bar() calls... they have no one to blame but themselves.
> 
> At least the check will be able to detect when the second set_bar() call
> is supplied a new struct which does not have the same size / flags as the
> struct pci_epf_bar that is currently in use.
> 
> The same currently applies to clear_bar():
> If you do a stupid in place update of the struct pci_epf_bar after calling
> set_bar(), e.g. modifying epf_bar->barno, clear_bar() will absolutely do
> "bad things".
> 
> Perhaps we should update the comment in dw_pcie_ep_set_bar():
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..451ba8add157 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -518,6 +518,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>                 /*
>                  * We can only dynamically change a BAR if the new BAR size and
>                  * BAR flags do not differ from the existing configuration.
> +                *
> +                * Note: this safety check only works when the caller uses a new
> +                * struct pci_epf_bar in the second set_bar() call. If the same
> +                * struct pci_epf_bar was supplied (i.e. being updated in place)
> +                * then it is impossible to detect invalid changes to the BAR.
>                  */
>                 if (ep_func->epf_bar[bar]->barno != bar ||
>                     ep_func->epf_bar[bar]->size != size ||
> 
> 
> To make it clear that this safety check is not always possible.
> 
> 
> > > I'm sorry for making you waste time. I did miss that even though pci-epf-vntb
> > > does not do in place updates of doorbell BAR, it does so for the other BARs.
> > 
> > No worries at all, and thanks for digging through the history with me.
> > At this point, I think there are still two reasonable options (to
> > summarize):
> > 
> > X). Treat the existing in-tree callers (including in-place update) as valid
> >     usage (i.e. apply [4]).
> > 
> >     [4] https://lore.kernel.org/linux-pci/q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf/
> > 
> >     In this case, the downside noted in [4] remains: if a BAR reprogramming
> >     attempt fails (especially for the long-standing epf-vntb's BAR Match ->
> >     BAR Match transition case), the previously programmed inbound mapping
> >     will already have been torn down. This behavior change is inherent in
> >     making the teardown unconditional. I think this is acceptable because
> >     if the caller is passing incompatible/invalid parameters, things are
> >     already going off the rails anyway, and the call site that receives the
> >     error should never actively use the BAR for any real transactions.
> > 
> >     Separately, if we treat in-place updates as supported, some of the
> >     existing compatibility checks (e.g. barno/size/flags) become inherently
> >     best-effort, because the previous state may no longer be observable by
> >     the driver. Addressing that would require additional follow-up work
> >     (e.g. with doing a kmemdup and holding the snapshot), but this is a
> >     pre-existing issue, so there is no need to rush fixing this.
> > 
> > Y). Define a stricter API usage contract, document it, and then adjust all
> >     the caller sides later (i.e. apply this v2 series).
> > 
> >     The downside here is that struct pci_epf embeds the struct pci_epf_bar
> >     array, so tightening the contract and fixing existing users would
> >     likely be awkward.
> > 
> > Personally, I'm inclined towards (X) at the moment, mainly because there
> > doesn't seem to be a firm, shared understanding of the API contract today.
> > Later, we can do follow-up work for the existing behaviour, which is
> > already present on mainline.
> > 
> > If you still agree with (X), I'll send v2 with splitting [4] into two-patch
> > series, with an explanation above the unconditional
> > dw_pcie_ep_clear_ib_maps().
> 
> I did not change my mind a second time :)
> 
> So I still think X is the way to go.

I have just sent v2:
https://lore.kernel.org/linux-pci/20260202145407.503348-1-den@valinux.co.jp/
Thanks for the review.

Kind regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
