Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020124.outbound.protection.outlook.com [52.101.229.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB42D46B2;
	Fri, 30 Jan 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793405; cv=fail; b=kjWgzArLtXoPRnI0NXhxKxdZ6y8UiTJla9iSa6awaIXysz0D02Q2IkGKs5YTQi+cvCSj8JmK3LvCfe1iHhjnw+Fq8dU7/D89zQBRtllYMPKRpP8onwn8WeNFi9xZdctqM02xZJDcIcstxn9oDgOVF8bE4oaWkGE54DYXf7J3tjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793405; c=relaxed/simple;
	bh=IxG/GXoMI+iNiqDpEABfU2K48s53uw5ZccFPmXW0ito=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TbAOpwA3sH7Q7zzz8VSdHRDoF3CJJ2GaDpaeDBMwOKwwPMmKGPbHhDCxs1DUHfvGpvnbTFu8ju8uUfSSgwZiBqIPCIn9cQAMNQkwtVwLHDhY8F1KQHTWQnEcIMAjkny1zPgow4lCbEhwfC85M8vf4NtFiDkNfC5bzPzC3aEhu7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gVigvSy2; arc=fail smtp.client-ip=52.101.229.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gVigvSy2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iITGJfHfIw3L6A8YRAKFox8STyi7Eh7TdYW2jwabwPSTAstU5GllOFAVCcY2e7sycePT3+avqvePg8LfiUug7IcjW/19TyoI4nyASly8i0017j4L8rFBy13umLIpXD6R3NY8KMEA9mrJl514OOSuqZN/QzVxS88ckP3uBusAj3tPiptDETlxG6na946EkLxy5/H8qow92iytY4+DIkyvkRVS6EA5v8FP4z4pptBdsfpAyinJ7knpidomlWK1siCWJmJmXK2IFXJLQ5bX+nER/xIvXvG9fwiAR7jIxNkwlZPA/F5xue5xdUhL9bTvieo4aYslpg5crr1RBkjJbkSu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CyX3VPJP7PSZvSA9K3ZKXUhr+1uje5d03m1LuadjVc=;
 b=aOya+Uno5H9p+EVITgDrgASEsLE8o9cX+FyygWW4DqqG545Z/ViJgONQ19vcSdoWyX2u5KsRuUvniBD+sfxaEPyZWoWym7RZpWs7ff+esXbwGEdg6n9tAlidDm95+DNl4WNMAePEMUjRrNO0G4709FVeRgk0Df2D/KjNASsJsoajTNqTebCQHP8wmVaUKLkMl92M6IFht3oZXcCjUQ/7f32mpWtSNnSWkA7eL63X643YSydSnswpT5Ws9aQTWgME68OuHyJmKmgdM1ocx8XkwrtfdiJKjEdXZ0h25YGgICrO94nUs1Bbccp21FMCOE9dMRHxPtVodmj+E375OaGSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CyX3VPJP7PSZvSA9K3ZKXUhr+1uje5d03m1LuadjVc=;
 b=gVigvSy2/pPnIKL4pdYJ0mgiMh3ZDRQZRSIo0jr3xbpnQRpux/LlDMiK5g7wxZI5b+04tYADFaLeOVSJYE1aMeZrTzFhCc75ObLcU8lPuttjBGlgsZ9+lJXHkfL56YJbCcEs23zElatWdo5RwDtWhWdpSreWyU8RofAFqQA5AJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 17:16:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 17:16:39 +0000
Date: Sat, 31 Jan 2026 02:16:37 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, Zhiqiang.Hou@nxp.com, 
	gustavo.pimentel@synopsys.com, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	danishanwar@ti.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com>
 <aXtrW7viGZfMNZur@ryzen>
 <s5hd43mnktvnuikuai25fhzchkt4y5w3ejabqhr43ihvwuefb3@wvatfe5k4loe>
 <aXyAfilrBOe1cEEk@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXyAfilrBOe1cEEk@ryzen>
X-ClientProxiedBy: TYCP301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ddc528-311e-49c4-8ded-08de60235475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J2ihNvb4W4g5RyD4MHjyl28p+QSTYLotnsllXnl+hwDdGCwvx8g7NxpzTzdn?=
 =?us-ascii?Q?jv5XH6CfNPLHdNN9/jUHC0gGvTCxeZapSnhhK4VqIZnIg779vSMBkIXRdQFQ?=
 =?us-ascii?Q?iS2CJvk8KRyvROBd0W705SDyrAoxJBWvRq558pZdKGMBlxcZfIIPJYQsRPhl?=
 =?us-ascii?Q?tr0dLOq5k3EDfS7Z9yj50YX4ca85ZMSbun+uY3a+Pn2P+pkf0aCuyzyo7732?=
 =?us-ascii?Q?oisFKmbx8icisEvCHGeyqSZwQVwyScE1jDMZVna1CfcbeMbzMCcWUspCHIsZ?=
 =?us-ascii?Q?cHkt3pneQbDO8nLTSonKi1Pbh5joGWfLhXyLs90dBeIPt9WW/LvnBjM3Ltck?=
 =?us-ascii?Q?iPS5+NFoJ31qGsjArUCYCmTM4xaesZViEGBTEF8XdY/F/emIwgktjPHYC2ZU?=
 =?us-ascii?Q?FfEKTATsBHJYsfdq0amK6sB2eIafku3+NctaeRDy6dD31mSKml8eT8STY51N?=
 =?us-ascii?Q?H/oc3mmkjuEW00NsE4h0jffDGLh9C5klUrJBeifgGQLEogXxs8qBs3/AogZ3?=
 =?us-ascii?Q?j0lgKTu1d5ZCW0NbgLZINwD396H/x8FuIwXTRVDFI89aTJxpRMZc03YIyt4d?=
 =?us-ascii?Q?dC3pOoMOCqT9mKsI220s7G8ktnXpU1X8Az8UAkMViziRtCqnzn4DBzUkacV+?=
 =?us-ascii?Q?5IMBxW4HKdhf6sRe4QroFKMJnT7PAGxVlWpcv/QNc+cMFfJMBHeEuG2PpmeI?=
 =?us-ascii?Q?NqmHAN2rSS6BATXEJv772l2iQTNJI7ixs8RER6QI5puCEImLiHcdHdwlMwA7?=
 =?us-ascii?Q?4iWkuJ5nhD9Z7z0//AyzzreN7j2vODdcIAQ7kbXHJYNvP8+2wVjQt2qY/Ial?=
 =?us-ascii?Q?wak21LqatP5vRTx6VsK4I5VyDSmUeKim0U7D15+MnTWFhhR+5c+oiJ6RE+wN?=
 =?us-ascii?Q?BphaBJdzulNlGJxAwOmpAvRHSQhXrWczSk7udLk6ljD/ipftJQKjQaYcRpOf?=
 =?us-ascii?Q?tEqmZWV0ToCom3AazoP9KcOEyJxmh1RfDyJ/g8Xwpgr4afn12QlYPHoa2emJ?=
 =?us-ascii?Q?Ss3lS4o2NwjuVkKidB/VfEzmDdAly9Zi/vK/jCBx3Jje8OqEWQRPmICm0S3q?=
 =?us-ascii?Q?yvBxPoHXiTUZJ1zterIzCcJKcULPwzdK30lWw22h+J+8BatcOR9B2sHmzTzb?=
 =?us-ascii?Q?KTq7cR2t2ZkFiYah2YIUnDhwQtsbrCWrStdXR8Bd+ymh9YWlhN2Y42uc471D?=
 =?us-ascii?Q?3gaYm2lpt1dRt8pGzBkS+/GWcd22Vl15QyspbN2R7ZzFP4Z6nh6rzQYBy7pI?=
 =?us-ascii?Q?gR+F+rkB99ItpApD8IRntOQsEHl92vYvEpq136l880nW72GNcfb5znZB/+qU?=
 =?us-ascii?Q?2zrZWjN5IHWlpiomRrKE0INDsiKgd7xBgiAnzWohTXcPO5BBTsJ/1yRQUr3r?=
 =?us-ascii?Q?LlaDYFJP+5odin/I2MCKRhgzBeH7vROk6EqVwSpqVZA4yjT9sqD+XzxnQ3eW?=
 =?us-ascii?Q?+RxGuK4I8V4cHJhIYevSBi/fESTZNpyk9Oa9D/RKNpMohpra1wEUXLEorr9D?=
 =?us-ascii?Q?OgkZHuGGFKmjMtUBVMfkQ3WVYE5nvRRoI4V5R+ZBgJb7zl15zBPxeYD1Yu4Y?=
 =?us-ascii?Q?MEw1zFxtof7cpoqIqFFFrrLUhFzhYw14DzHJGsDR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?grV8eENMXtWwEql8Qldql63mIAj5SIeku04AnWf3mvTdeqwzOGmmMLnUl2nK?=
 =?us-ascii?Q?YHTo4SohO2aihKam8IE21KtHRdfXLTPqdiXmzCtvy7cXR29CkOsjL4XI12eQ?=
 =?us-ascii?Q?Bvfhc6faV5PUGcZFtwjDP0uH4q0h/+eV2+2GI7GPpMBm6HZ6uXMQ8gXj+XFv?=
 =?us-ascii?Q?a+ds/etNqlN/bL8m670UeYdUeol5VSJ5kUyXg909L/06NzwmuE+pDlr9C3uZ?=
 =?us-ascii?Q?nQuc/8AXvi2grBLE4EXVjlLUXFR4BnwAZXpqfMZmamIj5movT+GIct7+pMuJ?=
 =?us-ascii?Q?Fh0AFTKNHk+adTLjqluRTEekliar5Ie6KJa7QfcfLczi67Q8tkT1dREvmuwC?=
 =?us-ascii?Q?uQBgh1rer5NguM7YyIVPvW2E95nBgpV8/q/H+HErYn1tfuOkfDeMTwjTMQ+E?=
 =?us-ascii?Q?4EF4CQrN42mywZSKIXdNQV3ojlIW1+AGKfQITgGOOdyRxKy4jEo6Tpi+zKuo?=
 =?us-ascii?Q?NkSMDY48IJBxbx7Fx2a8Oe1CAAnslmMzyEg2GDHvT8/u4vR6Ct9kuEnlD6Qs?=
 =?us-ascii?Q?pwuCuvytosJ8s3XRZXQ1hzs5jDodw95cutO/lzgOBugjck/lYJIsDxC9gwd5?=
 =?us-ascii?Q?sfJZagf4vY4KuCBJF+t0uemrXR+EV5bNMNoruT4hFF20Fo6AFvknUmbXlJNm?=
 =?us-ascii?Q?A+UC8dHaUGpjEfME3LJV8o3WoV/XwjFjlEIkI7e8XM2F7PnNzLKcR9jjFyRk?=
 =?us-ascii?Q?8CnQLs/XvufKyX5enC+L73KjmW2KGE28PCkIgTIYpNgiqPpuyLem5OG6dcfd?=
 =?us-ascii?Q?y3lmxxfzL19yjEe2anYXMOl/8kllUZ7OQNEnTdn1JAyRcTYgkW5HM1+WC1sr?=
 =?us-ascii?Q?bUzGwrHyRdKYkQgxNRzSpod/Bolav8NL/g6pOA9X8coFsLFoneVCq2pZSMOC?=
 =?us-ascii?Q?ijv0tni4as651JSTnBQGdhglUvb6GC5u7lOH9vip7AJUNqQMDu9HZ3fHnBaZ?=
 =?us-ascii?Q?QLvdm2OxSH0p6MruAXr7yr+vw9429Fmy0acwIIiJL/VYm+39tSE/RAZm+kGR?=
 =?us-ascii?Q?swS2jFNsSQXcfa1DZ7DgBeB/KLo93zCSAdB1vK3nEQJguab3+r/jJDkPQ7aN?=
 =?us-ascii?Q?0VOXs+VjQiWu1gYf+sJvRSbXND3P/YNHFHMAOn7RbDdyRgyMzLTqxr4rsLTN?=
 =?us-ascii?Q?OwCZPTF0iWEqL9tdFyRVineLi6DxgHpD98H7ly2/Abpf3Alzj+O7UvHZcTSG?=
 =?us-ascii?Q?BD1HCI+5ie8zvw1khHh/9iZ2zCuR0dC2e8IJgY+TB6EJIDLOPHumjUkmEwut?=
 =?us-ascii?Q?QBDmfFw4H73oZxlwD4AJ3f3zTeNaTtZlvJghU9VQyK0SizLbPuUMP0+ZDuJF?=
 =?us-ascii?Q?HBvpteEEGpvRuTe4L4g476+tJvpVotuH0PA+7SVSEGQ9tv4iCcNZSYqCRvj9?=
 =?us-ascii?Q?3Lz6gfSo4HTUXTAJS8F25fwxfVTdm8QuodFSG7OoHP7p87jhpb5lsdfGe/7g?=
 =?us-ascii?Q?A3gC1VjxDeFCKTpBPvQxYLGyPNGHDgvjGj2fX3eaidaU6hLptm1MBPvlXe7K?=
 =?us-ascii?Q?ytBKPgeNj+NeVUx5b9SjjdVKDm0JAXt4hDfbinvt7T2tM9SiN9DHboEIntKc?=
 =?us-ascii?Q?0JpBmatz93/jnWYgZuchmpUm7v2k7QPGmIZZxeRjWP5MIbibeF5iCKttv8pH?=
 =?us-ascii?Q?tdY3cSr6M2sSJFyr5CqSvRVa0ZpTlC1sdhgcEJL0wETs620xprK326y+A2ix?=
 =?us-ascii?Q?csRXjiAZbRH1hOxQ20TSk9g77k9oR+UQwVWI2ASAWNDOMNIzAndlzWF4my+f?=
 =?us-ascii?Q?lbEF2EcNcIYfz8XGgqVygPz3J8vfbn6pP/K8tMMfvUWZBgSrsxyK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ddc528-311e-49c4-8ded-08de60235475
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:16:39.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnDpa6uS0MLbTnAh/Mhr/wb/qxWM4qxt8egPfxBJBAXQU3DhZX4Ydw0be2w+/w4obL0Xe1Nr4pqYof4gBTFh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7374

On Fri, Jan 30, 2026 at 10:57:18AM +0100, Niklas Cassel wrote:
> On Fri, Jan 30, 2026 at 11:21:32AM +0900, Koichiro Den wrote:
> > > 
> > > Koichiro (he is on To:),
> > > 
> > > don't you think that it would be clearer if we had a:
> > > 		return;
> > > 
> > > here...
> > > 
> > > I mean, a BAR can either have a BAR match mode mapping or a subrange mapping,
> > > but not both... So continuing executing code beyond this point seems pointless,
> > > possibly even confusing.
> > 
> > Thanks for pinging. I agree it would be clearer. Since it's orthogonal to
> > this series, would it be better if I sent a one-line patch?
> 
> Thank you Koichiro, I think a one liner patch for this would be nice.
> 
> You can also write in the changelog (after the ----) that Mani can squash
> your one liner patch into the existing submap commit if he wants.

While looking at this, I spotted a subtle corner case that the missing
'return' has been masking.

Consider the following re-programming sequence for a BAR:

  1) The initial set_bar() programs the BAR in BAR Match Mode
  2) The second set_bar() switches the BAR to Address Match Mode
     - Ad part of this, set_bar() calls dw_pcie_ep_clear_ib_maps() before
       re-programming.
  3) The third set_bar() switches back to BAR Match Mode.

In step (3), the current behavior depends on how the caller handles the
struct pci_epf_bar passed to set_bar()

  a) If the caller passes a freshly prepared epf_bar with .num_submap = 0,
     dw_pcie_ep_clear_ib_maps() is called as expected.

  b) If the caller updates the same epf_bar in place (i.e. reused the
     object that passed in step (2)) and simply updates .num_submap back to
     0, dw_pcie_ep_clear_ib_maps() is NOT called because the condition in
     [1] evaluates to false. The recently merged (my) pci-epf-test code
     follows this patter, see [2].

The point is that ep_func->epf_bar[bar] only stores a pointer, and the
actual object is owned by the API caller. Since struct pci_epf embeds the
BAR descriptors, updating an epf_bar in place (pattern (b)) seems quite
natural and, in my view, should be supported. Requiring callers to always
pass a new epf_bar (pattern (a)) feels contrary to the current
API/data-structure design.

Given that, I think the cleares fix is:

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index dd48e60b513c..a20cff98b797 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -165,6 +165,9 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci
                dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
                clear_bit(atu_index, ep->ib_window_map);
                ep_func->bar_to_atu[bar] = 0;
+
+               WARN_ON(ep_func->ib_atu_indexes[bar]);
+               return;
        }
 
        /* Tear down all Address Match Mode mappings, if any. */
@@ -528,8 +531,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
                 * When dynamically changing a BAR, tear down any existing
                 * mappings before re-programming.
                 */
-               if (ep_func->epf_bar[bar]->num_submap || epf_bar->num_submap)
-                       dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
+               dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 
                /*
                 * When dynamically changing a BAR, skip writing the BAR reg, as

---8<---

One downside is that this introduces a behavioral change in a specific
failure case that already existed prior to this series.

Concretely, this only affects the traditional reprogramming path where a
BAR configured in BAR Match Mode is updated again to BAR Match Mode. If
such an update fails (for example, because the new epf_bar->phys_addr is
not aligned to region_align), the behavior changes as follows:

  - Before this change: the previously programmed BAR Match Mode mapping
    remains in place.
  - After this change: the existing mapping is torn down first, so no mapping
    remains after the failure.

I don't think this change is a major issue, since the caller will still
observe the failure and should handle the error accordingly in either case.
That said, I'd appreciate feedback if retaining the old BAR Match Mode
mapping on such failure scenario is considered important for the existing
update path.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/dwc/pcie-designware-ep.c?h=controller/dwc&id=0e2b9294512c140576c340b7ccd24230a593f30b#n531
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/endpoint/functions/pci-epf-test.c?h=controller/dwc&id=0e2b9294512c140576c340b7ccd24230a593f30b#n950

Kind regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
