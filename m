Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6513D539;
	Sat, 31 Jan 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866976; cv=fail; b=nOZnp1ZcvbcNtzxPT1mO63MvLDb+idf7o6rjoc0HHtWYAX7vuOTI97cugGyeu0k++LS0/ieafSfEb+FlA4gQ+s73pwfEUzF8o79C60L2MnsNfza4U091mN12WwNQrPv96ylXSyEz05ICJHrh7rExCo6oeAg1rY0B3BsSFzbpgVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866976; c=relaxed/simple;
	bh=XB5buSo7mg97dXoZCPrIVKAOEfLKC7ZaGkneY+CthW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JsEe/fo9awOjNmW+Q01KkmvJHMTDhuOmL2Rc0CYikCCp2o+MBzG0bS5K0oAA+hYQUr6UBuYM93oNmxSlAKBUPQCNvBA4AM1b07A8Xtme9kWhM77H/zUMPggv3THydptmk3WsgJl3gCdhZzOrl9Xcj0airMYFuWhnc7YAjE+7XTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=l9MVvYdO; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="l9MVvYdO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyXYxaNZ89afZJAAm/CmUqwoAL8zMFzs8oyAuTMVSdD/pEOa8niXsBrN0roZscImqyHYWEV3R+DL/AsA/gtDfQonakEgMVd+645/nB9b9uVdH5XdDQk8PFnNNPxE99twy71PpsX4GrLr0sp5drjVSdSt91kn7WDNFFC63OduOb0nFmpwzfoNs48k28kxDjT3T9Jq5t0ffp9jpNbdsfOGwPd1Noo+1pdJR4mtamN8Brd7Uw0cQeQxQ8p24VKTISXDcbvo9Dh8nPofhRWKYlzaxl8S236jCSaIzE3C7hGsbdmhu7lZBI0IS+C9RRpbab5JA3OzmpMjGgBXGWrzcLQTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4CX4VnApZ39RNRWt8SQayk5OGkct8gDBoRkXF2S3CY=;
 b=OxgYBl80NltS5MuqiEc3w/tLbO0YDnex+B/L8pQDzfx7hubv0JiMTC0r3jgOgD5djvVfoT1NJqIoOx7IYAepFMHuUrLdbdLJmNjUm4oH6LPP9yZ25ePqO5W0Sj7Sb4hQVuu4kLDmvyZWMIS63h0CxbRwkdLioIodj9ACZnWS4LOWkJaPPn1HkLc/4ciZzA9m+4tnYmDGcEXNMSf7LlDY5KLE57nONCbfVFNaQ9oWtK1dXeKTkU6nqwbnWha+RPzFVwowVdDUdCjDysDbL3PqlVsmMHPEmp+7ufKlgRyLOqu+9Whfist4Q1Cs58tD2LX2XkSvHBLy7V5yGM5GMNBIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4CX4VnApZ39RNRWt8SQayk5OGkct8gDBoRkXF2S3CY=;
 b=l9MVvYdO0h49Uqpx0RhIiDsIoJU+tguF6VXlzFy7Z2uBarqrpqOdX0vTzHiT7PPFi6yA1BgCfLtqFEkLqAP6AH35ysBjC8a4/QXTJBmf8+eL9zuX+v/D7tWlqHW+i0fsDll9xJzowZedtLHOqEmNSqhy66AG+mFf6Pc31Y0rzwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5092.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sat, 31 Jan
 2026 13:42:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Sat, 31 Jan 2026
 13:42:51 +0000
Date: Sat, 31 Jan 2026 22:42:50 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, Zhiqiang.Hou@nxp.com, 
	gustavo.pimentel@synopsys.com, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	danishanwar@ti.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <3mlbqk4rwll3m4jqcd5wyg525e2knizpczkkzx7de7a5wfqz7p@pjlrchkywnuw>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com>
 <aXtrW7viGZfMNZur@ryzen>
 <s5hd43mnktvnuikuai25fhzchkt4y5w3ejabqhr43ihvwuefb3@wvatfe5k4loe>
 <aXyAfilrBOe1cEEk@ryzen>
 <q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf>
 <aX019VTWjMlPX8qp@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX019VTWjMlPX8qp@fedora>
X-ClientProxiedBy: TYCP301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9b5ad4-81f0-4c48-99d8-08de60cea143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09gdzFa6chy+Jl+sA+SZEXrJhqH/pvW3xAanPpgX4ojgEhFkhiupw8gM4UB2?=
 =?us-ascii?Q?21+tu9UrUrPUJEGVcWusLXTZfJ8QzRpT/CXDdoik94bvh+4AdDMfS/zlzxl7?=
 =?us-ascii?Q?vVecCDHD1b41tMsYSaNU5NuBXhWWjdck+coWmd6ijpsXwMOAVlVem93O+cnd?=
 =?us-ascii?Q?mNBZWxI6YA+NXCtx9XAsHXLdzmwAQBQBoTsqtdUzq2CQ7VWGvx29i7sRS2wr?=
 =?us-ascii?Q?WeCT4027GpWx6u+uRuCBUK4Zcx3W+Ov/8Y+UCw6SLKFIUeiFn7hylPBJid5q?=
 =?us-ascii?Q?6GiXgklejy2dmYTQhitPqozwfwDUiV4I5m9q5JPKL/OLHAjtKULWW9+Ty0YV?=
 =?us-ascii?Q?jEv/kuwwLQhEmthN6GlAOtv+H0RIOcKRvZ/Wy0k5K1lt3asvcTDKfmH3ipnR?=
 =?us-ascii?Q?kka/koP86NbbWFGM5FJBUkamB1QEQsE0FvDmQP7shCmtd0OQ1gU6ZgPq9hUR?=
 =?us-ascii?Q?tU5EwyNa2B0Oy7eB2sNo3N42RCS9PwiBC/rORdWYNnUCbr0kwuP4nLuxWryS?=
 =?us-ascii?Q?BS/w1YMO0IYv27bChGjIFTTumRubQkOzAcYkVXs8nOB11MWdipSxP3GaRDW8?=
 =?us-ascii?Q?YGoH5Cj5+q/+s31jb+FZ5QGqxrTXxi/a3BrZcLbUR0gYPae0HkDM2ogZxZui?=
 =?us-ascii?Q?GIVm89hHwDuPNRdf2rmkxTtOxT4lNyuTuLoPw3Yg0AM8nzL0yOddslk6EeOO?=
 =?us-ascii?Q?MPT6bfb0eyvjlGLtR7gD9cur3xAegPruZkULZAmzRaUQujOmxrZaTC/hrvn8?=
 =?us-ascii?Q?hERw8VlLQAIFtql4oI/W4thUQxnnd0nmdHW5zjZbVOJbAhbKmFOATVH+kGKR?=
 =?us-ascii?Q?bA9j4geYJAsuBIphqCUQh4wBYVvSUKBP2D45xNqkVvoRMt4w+tjP3+g0Dj5U?=
 =?us-ascii?Q?1I4ZqlsacCLQOdYgkcLm/DOq6kY7AJUme9lXWO22Hc2GhE6WXFqNH5SrGzBs?=
 =?us-ascii?Q?3yvUzZpwCPd32c65o7Vw930dFBCtqUJjdW9EfB20uSbE5gamTYon45Ch9yD5?=
 =?us-ascii?Q?dMGWovST6XIkkzOUYYjLuUKGNv7g2GYaaDNQHMnznj44AXocssclfcq9A0JS?=
 =?us-ascii?Q?5lUWeAXRr+EQnq3jF3fNzvCABcqwo8y/xf3mjJTutx4/I3LBAfPX/GbPGyIf?=
 =?us-ascii?Q?hp6o4F5xrusTelg3TVu3Lw/b9hhSn+5MPDNzxV88czlrUiEy/T8nEik9TnJR?=
 =?us-ascii?Q?Id77vNlssiQQGPBJfz5cmdRfYiLDYgFHYOvSRXuTfIGl3IKmcCAM1cLRyd48?=
 =?us-ascii?Q?nftPpV460+KjT1UAG0jh8pka3v6L1UxZMy1bloURQ2GJXIw5nj4qRzORQA4S?=
 =?us-ascii?Q?htxYN70k7axADylPAZFmrm3tVI4ANg2KIpOjEUzqeqnD1EV7XOHVwnAv8Nuu?=
 =?us-ascii?Q?Zw8v7ri6koIsPTi2nsd6lpwHgxXcLMKuulcuGVZGhm23vTirmkyy1cWi6LzC?=
 =?us-ascii?Q?dZbgCeVJWTxKp4eYw94LnBZeSl0yVwExE2W/pCImYVOCYFvDAbqLoGa8EaQ8?=
 =?us-ascii?Q?QlquQQqybEXAJkWmlMEIqh3dUYBDfxhtV2IbyQIKGlbn1dRQdqIjZ7sjC7Wy?=
 =?us-ascii?Q?pX/Owh1bqVKtvHA1CJ9WatEnoJbOROArTQ4rOLy+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/1ptKW/b3AtQE2T6pzr/7FU3kvgMm4FX+ZbZSFot+24Cw+OzsRooBuvjSmSt?=
 =?us-ascii?Q?ERlv0JVNQnCECGzIeSZH600h5a0rgva9KIYak5p0LIu9ySfr6dgtflRXEWgR?=
 =?us-ascii?Q?J78dc8q4Ha75xpVBTzGaxzuSVRxYQVYCQ6fxWZmvXx/cMQKUvpQjO0VSFjg/?=
 =?us-ascii?Q?voZX66av13JBqKjdHkABnkGitb2LPqCEcu9cl9FYwyzDrUtzenIygT+YY23+?=
 =?us-ascii?Q?f+zvgO6vswuMN01IdHucNFb6cb+sxZiT9GMHQ6iXVtmflhe74EAPGExRNn3V?=
 =?us-ascii?Q?RtY6gA4oLUSAFjWrGRfxBWgdXS5qK/iguudqd/OUrhByFeiASSq8FhjUHxp8?=
 =?us-ascii?Q?z0dN9Y64EHCZn1UCS/qbBHQtqswHUyYlynRFYu0s/FYdU/YdfmpmEewdD3bL?=
 =?us-ascii?Q?54qakZFFZ8BY6pzgaSxMKMElpPQN8P7TYrZIzm6OSjRFEc90MwhOlP2GXOOn?=
 =?us-ascii?Q?SyXbpBZnlOT1SWEGXCbMSjjwq/y5vMg8IudTtCpAy2EM3UGSJoYOsDG2eg0D?=
 =?us-ascii?Q?QhJhrfErqnYZDAONuAOtpVusy+zeKIL6uvYsREvjDe3IEEtrVCIQRq33ZUB/?=
 =?us-ascii?Q?26Ivq0ZuBCCJ0jZHWKZAoyWwIaxqLeTI+Ur2OwCMG7R4kr1vaUZzdhPBSmKZ?=
 =?us-ascii?Q?ZujakrHQm+nkYLgD12Shb3124jFs7W3VZd8J+8e0IDsdarTAtHz4z7tnFdRG?=
 =?us-ascii?Q?HXgBtn7TSK8h6bxlXu0TRhvCy8eO/OAYFTptLdDLnxRw60kZ2OFGc77Y9u3g?=
 =?us-ascii?Q?te5NvUsDTK5wNl2nNI3yPUYwSyxk2TOna139eX2UjberC4N7odudzb8s5b6I?=
 =?us-ascii?Q?UsSG2JoWlUNZ9o2r/dL7g6l+x/clo1/9NHk5pyAIWY5la2zdZHgzUbjeNnXd?=
 =?us-ascii?Q?/7RSHQozUgZLunk+31Md0rKsEn88gJ/90DuQZilN0RLl3x5+9jPxLfTRe9jO?=
 =?us-ascii?Q?J+2q+on6RKHuBfp/AY7skwK22apuu/4sxAOM34IOofnLk6vYk3nqZIKs8yKg?=
 =?us-ascii?Q?1YULcgne2YFz/AFkmdBiKexvSCHEjqw8lsXQ4C3Sz8WMkU5z//NxfIWvrKGv?=
 =?us-ascii?Q?3OKLEqDMEfPY06HaSWTJpiwsS6JWU5d628/jNdoJ8HttBqCMvawwhNW4Nhd4?=
 =?us-ascii?Q?ooJCC6KYHisgmNZhgt5ML/iUmyeYrTrMmeMrNcIWpNXP78xqdPJr8XvFZ7qD?=
 =?us-ascii?Q?Jo82OfLCf/7nPOf9uZ73uiwLT5yUCSAxkFrK6Q1RX0s9iUnKHx+AR4U6owqc?=
 =?us-ascii?Q?I0lVVOZBQm5g93WuamD7Ufj9MeSw2+4KCu7dm2LLcyMF2sMFD7NLLj3Vduv8?=
 =?us-ascii?Q?PIqbGvOsxrJkQ+rVPAX2iWDWG9B3VfQaaW2EsabGpUnHsOdyG0f3Iw/U32X9?=
 =?us-ascii?Q?iwgCZzX8gP3iuGcTPYh3I6+pz1xzMzlC/gJRvXL9z4qmciPJlPjg7Mmuq7Ga?=
 =?us-ascii?Q?JgTJ7VcINVJj7sHqYI0b9qKPm71p0pOJsSF2tao3Iodroe4cco9z59w15Y4R?=
 =?us-ascii?Q?LrYAyzdU1jvKcUCOGWn3aYcMB8FUq5q/eydBhQrQK8s4vmlilyifV3IBf1yY?=
 =?us-ascii?Q?tjl6Xut7haNEh7g45aU7K/zQczudbQaorCFgI8X1OwxUuSVUKEYoMfwkq6wB?=
 =?us-ascii?Q?7AdkJksSHkbyu1MUq5H8LkhfiX6I8CoD2HkGpmUZKSCVPybUV4zYVEQHf0oS?=
 =?us-ascii?Q?xMWr6idgsN87tYq3shyrvdAofoXSCSPHq1LSKwfoLcYzABRjaXG+RYafDlmp?=
 =?us-ascii?Q?9WoWIRQTEpqJpi+wYaL5Y6VXMeDGwnKYRNMx0JvemMWVh+vIBKcb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9b5ad4-81f0-4c48-99d8-08de60cea143
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 13:42:51.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rs9MNoTRNtqzMgIesgjYS1hjI+lnV5CwWWemPLt5/VNQsQ+KCYcJBk4buNFt7Uq4eQGnmLTPgAByBtNzk+GvUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5092

On Fri, Jan 30, 2026 at 11:51:33PM +0100, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Sat, Jan 31, 2026 at 02:16:37AM +0900, Koichiro Den wrote:
> > While looking at this, I spotted a subtle corner case that the missing
> > 'return' has been masking.
> > 
> > Consider the following re-programming sequence for a BAR:
> > 
> >   1) The initial set_bar() programs the BAR in BAR Match Mode
> >   2) The second set_bar() switches the BAR to Address Match Mode
> >      - Ad part of this, set_bar() calls dw_pcie_ep_clear_ib_maps() before
> >        re-programming.
> >   3) The third set_bar() switches back to BAR Match Mode.
> > 
> > In step (3), the current behavior depends on how the caller handles the
> > struct pci_epf_bar passed to set_bar()
> > 
> >   a) If the caller passes a freshly prepared epf_bar with .num_submap = 0,
> >      dw_pcie_ep_clear_ib_maps() is called as expected.
> > 
> >   b) If the caller updates the same epf_bar in place (i.e. reused the
> >      object that passed in step (2)) and simply updates .num_submap back to
> >      0, dw_pcie_ep_clear_ib_maps() is NOT called because the condition in
> >      [1] evaluates to false. The recently merged (my) pci-epf-test code
> >      follows this patter, see [2].
> > 
> > The point is that ep_func->epf_bar[bar] only stores a pointer, and the
> > actual object is owned by the API caller. Since struct pci_epf embeds the
> > BAR descriptors, updating an epf_bar in place (pattern (b)) seems quite
> > natural and, in my view, should be supported.
> 
> (cut)
> 
> > Requiring callers to always pass a new epf_bar (pattern (a)) feels
> > contrary to the current API/data-structure design.
> 
> I disagree.
> 
> I previously suggested that you should look at pci_epf_test_enable_doorbell()
> and pci_epf_test_disable_doorbell().
> 
> If we look at the workflow in pci-epf-test for the doorbell test case:
> 
> 1)
> pci_epf_test_epc_init() calls pci_epf_test_set_bar() which calls
> pci_epc_set_bar(..., &epf->bar[bar]);
> 
> 2)
> pci_epf_test_enable_doorbell()
> uses a new struct pci_epf_bar (epf_test->db_bar)
> 
> copies the barno, size and flags for the BAR is will dynamically change:
> epf_test->db_bar.barno = bar;
> epf_test->db_bar.size = epf->bar[bar].size;
> epf_test->db_bar.flags = epf->bar[bar].flags;
> calls pci_epc_set_bar(..., &epf_test->db_bar);
> 
> 3)
> pci_epf_test_disable_doorbell() calls 
> pci_epc_set_bar(..., &epf->bar[bar]);
> with the original unmodified struct pci_epf_bar.
> 
> 
> Your new test case however, reuses epf->bar[bar] in step 1, 2, 3.
> 
> I think the solution is to change your test case so that you use same
> workflow as the doorbell test case. Just add a new struct pci_epf_bar
> to struct pci_epf_test where you store the temporary BAR.
> 
> 
> I'm not a big fan of your suggested code changes.
> 
> I think adding the early return in dw_pcie_ep_clear_ib_maps() and
> modifying your test case to use a new epf_bar are the only things
> that should be fixed as soon as possible.
> 

Thanks, that makes sense. I was a bit confused initially, so I'd like to
make the API rule explicit in the documentation to avoid further ambiguity.

I have just submitted a separate patch series:
https://lore.kernel.org/linux-pci/20260131133655.218018-1-den@valinux.co.jp
In this series, [PATCH 3/3] adds text describing the caller ownership and
lifetime rules for pci_epc_set_bar().

> 
> > One downside is that this introduces a behavioral change in a specific
> > failure case that already existed prior to this series.
> > 
> > Concretely, this only affects the traditional reprogramming path where a
> > BAR configured in BAR Match Mode is updated again to BAR Match Mode. If
> > such an update fails (for example, because the new epf_bar->phys_addr is
> > not aligned to region_align), the behavior changes as follows:
> > 
> >   - Before this change: the previously programmed BAR Match Mode mapping
> >     remains in place.
> >   - After this change: the existing mapping is torn down first, so no mapping
> >     remains after the failure.
> > 
> > I don't think this change is a major issue, since the caller will still
> > observe the failure and should handle the error accordingly in either case.
> > That said, I'd appreciate feedback if retaining the old BAR Match Mode
> > mapping on such failure scenario is considered important for the existing
> > update path.
> 
> You have found a potential problem with the API though, but like you said,
> this problem was there even before your changes, so this problem can take
> more time to be addressed.
> 
> Since the DWC EP driver only stores pointers to struct pci_epf_bar BARs
> in set_bar(), it is theoretically possible for the caller to modify this
> struct after calling set_bar(). This means that any future safety check
> against values in ep_func->epf_bar (e.g. [1]) is unreliable, as the caller
> could have modified the struct after calling set_bar().
> 
> [1] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L368-L370
> 
> I think the solution to this is to modify struct dw_pcie_ep_func:
> 
> @@ -472,7 +472,7 @@ struct dw_pcie_ep_func {
>         u8                      msi_cap;        /* MSI capability offset */
>         u8                      msix_cap;       /* MSI-X capability offset */
>         u8                      bar_to_atu[PCI_STD_NUM_BARS];
> -       struct pci_epf_bar      *epf_bar[PCI_STD_NUM_BARS];
> +       struct pci_epf_bar      epf_bar[PCI_STD_NUM_BARS];
>  
>         /* Only for Address Match Mode inbound iATU */
>         u32                     *ib_atu_indexes[PCI_STD_NUM_BARS];
> 
> 
> 
> And then modify set_bar() to something like:
> 
> @@ -588,7 +588,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>         if (ret)
>                 return ret;
>  
> -       ep_func->epf_bar[bar] = epf_bar;
> +       memcpy(&ep_func->epf_bar[bar], epf_bar, sizeof *epf_bar);
>  
>         return 0;
>  }
> 
> 
> But that would also mean that we need to modify the if (ep_func->epf_bar[bar])
> with something like if (ep_func->epf_bar_in_use[bar])
> 
> Or... I guess we could keep it as pointers, but use kmemdup() in set_bar()
> to get our own immutable copy, and then kfree() the pointer in clear_bar()
> (and in set_bar() before kmemduping the memory, if the DWC driver already
> has a local copy (i.e. dynamically changing the BAR without first calling
> clear_bar()))

That feels like the right direction. I'll take a closer look at that, but
if you decide to work on it first, please feel free to go ahead. I'd be
happy to help with testing.

Thank you very much for the careful review and discussion.

Kind regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
