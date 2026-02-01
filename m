Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021127.outbound.protection.outlook.com [40.107.74.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509403A1B5;
	Sun,  1 Feb 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769960759; cv=fail; b=VHxTXt//rsXBKfEXHVjPesMIlpHjRZTZRPEwBu+LTp95/QskKEdcAGLqcEFzGyLbvdfKmxj1gGqJj6nKxexLPKhlgxEqCuyhXTvpynfDT1cdFIkgS31VsZkoP75KVMCGSNnSQQbYLk2IF+DGIVD16vO5yb77zpalx4QTiDnUCxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769960759; c=relaxed/simple;
	bh=9hH4/OgK3MR+rm1pDN9bozx8Fr79aokZU4FsjGDtbzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nzFH67tbUQ8JtweNLTtFgdBQeOBf7fEZxi5/glphhdCl1z2yyfLYyMpAjx8WWXMpEQBJmdtHJzFKe1O2EWOFl1/4CeGBIk7WCTVILGWkaUZJAk+4HCUH07wSH5cVxth7fs+sdl0T+xhqjmjlh63R0ZlDHCeEucKfR9ri3MtbCwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Jyk0jCi1; arc=fail smtp.client-ip=40.107.74.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Jyk0jCi1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdEz6okS+NREi6KkYmNbrbeYwZwnva7TaaJzIs1EIBNgBAq8BbHyHSGF64HJM1RdzAEPgid/Mk9LlDrji0jIbW5aP00nT7QgQe/2uNvbJqthGaeoVC/cyUbACjjqksoWMPq19iaTlLiprWpOCjyZvqPSk9/cFrKMWu+EYjfmhi1P5gCw21xLsUeKtFDjX8b/MvmLWe4zcN+6WX+3NG0qkCyvFA4IkrXGI5BOaseQSP1wNr5RMIlDSZTeKacCjgevNmR2vGLvxX/x3FbL1A48PNP2lFZLTI7wMUGZWVRNstehFuYNoMLZ7FoQ4sUwUEr/Nffm0DnniGgEHZh/UMA1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB4ZJJk6NRnLrl1CYvTbyqfv1RKnsUCtsNv1it7z90M=;
 b=MbjhdlKJJAbMx2IUtY0N68ytKqtikI8dfbXxj2V/f8y/DL7PAzITj5D2KbO0zkPeah3XEM1g2dSBpm1+wi2MCKk2CGlnpmd6WDZD3c1DXXfsqYel6jSuCj3Tz9IrhJV3h3/cCcCfZ5J8psk3iY+H/c/KJR951JPn19qiyhnC08JVKYXh0/y3n/UARylJJCOuOnbw8KvngKVdkYwKOrolG4vWzk5mK4+Orx6hclvNECCjybEu8Mj7urb965PTGQYGc9oPQsG7BnDARB3yzXIdGaeNu38QmpN1tTyMLyZJRvVvo3snJNAfo2scLGg2xKfqJWXRLipMmeLC23/f5HdB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB4ZJJk6NRnLrl1CYvTbyqfv1RKnsUCtsNv1it7z90M=;
 b=Jyk0jCi1TGzSZJtXajaIJJSdkk2r0fiOoS5TBAKNxfcJy3A47NhBYaQTR5WYsDPyEMYx1NaVYIxVE76GKirBYoi3onx5M3MR46GxR34cPtuvPXwQG4u7ql1fbc5V/VFtJaW2GD9OGH+8Gyy7ZBls8SxHMN/2PZ3N9DkIv9lokZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7444.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:352::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 15:45:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9564.013; Sun, 1 Feb 2026
 15:45:54 +0000
Date: Mon, 2 Feb 2026 00:45:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	robh@kernel.org, Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: Document pci_epc_set_bar() caller
 ownership and lifetime rules
Message-ID: <4erlj426nvmilwfdq5e63ojiqecomcpj35nvmiyw2p5mvifwlt@yspmfxrzmxei>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-4-den@valinux.co.jp>
 <aX4y3txKcYmb-kE3@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX4y3txKcYmb-kE3@fedora>
X-ClientProxiedBy: TYCP286CA0280.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d63b305-a133-4fc8-0e26-08de61a8fbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6E0ffeEEqKpaGVDbZXvYnwF4DYb6zbNVLAMGAWmw/wNllKEQi7bVEwE9Qu7?=
 =?us-ascii?Q?7ETsihtwApfmi2tAM5qRpT2A/HpEWVyoKkIy5I8SyB37aFeV84NmV4NICLmD?=
 =?us-ascii?Q?qmbHrgFtgsSzxVA7GhkdnBbHw3xdY0jsxefC104hx+87Jxw/0TCmhGO4LKuc?=
 =?us-ascii?Q?X/UIAMBY+3+mnwHw85wDBypNBXQewf/tZVOQDmkZonlRO1hvjnkW/mIXZnxk?=
 =?us-ascii?Q?Ovh1OeTDT2zqSw9XluAJR6B80GKKmS5oP5daDcNFumttb7C/DZI7Y5DNzXU2?=
 =?us-ascii?Q?O2SlbiVf9Q/SfZ3SpjwIx7o96Eqzeck6jjD+LR51sHyaUZv6G4jz6rULE8Qe?=
 =?us-ascii?Q?rB4Tl++93yA3199Kyf6hk18aEOfSO15iLiapGEi05Mirk972D0CHVl2EGO4u?=
 =?us-ascii?Q?szxFxge3u+rv8xekkF0pG+JsKV3OAME0aoj6KFhgniOgifTI1i9B55extzYu?=
 =?us-ascii?Q?mGWu0ssaxNXA1tQ6itCJTdDH/0hTYdP8mS8ADal108NRe7Fx1Z6QaMDxfEk/?=
 =?us-ascii?Q?Eezhz/DP0SMkE8P846abGd9g1fxhhAv4Cb1n+H8+3dOEAmM5MSA2QwyLPXJj?=
 =?us-ascii?Q?97Jppg+nxGdCYQgi05b9dAbMYNQTtxl2LOZwJmbaYYWvdQjjTH3jnQu/Klvc?=
 =?us-ascii?Q?RO0/3xMvm15ByycB+7OiRHpgMO+YWcejekHvCcBwjC/vfueBmK+n9ig2aK+S?=
 =?us-ascii?Q?8bZLcpPVyRwMYmxySdq8F8YqKmFP6SNJWsEikI0zjqNVz0dE0tsOUSfCu1aY?=
 =?us-ascii?Q?zeIzw6mHs36DUQwH/gJ3TbZf3z+nU51lqs9+zwrM7+G3TreSbP7UgM5UXajI?=
 =?us-ascii?Q?xxCFxtPRxfdSSEf9KcL3IoRjS87hudTAdmzov54319YhWDel6B5rVLL1zcZy?=
 =?us-ascii?Q?dSiainNDgjE0OOMqssaHlWrsyefRdCTFdV+y5+wKB/kiJzpamP1cDh5KtXyz?=
 =?us-ascii?Q?PS/mWYbJgitPPPCKliyjJDlgLyISYWDcS6//+4Ll1rhYg47GdrXiePNhcmMW?=
 =?us-ascii?Q?E3NSA2PnIG+HHRFjmc7AICjbF/t5HsoT+g2kMNkz3Tt/NOhcC39h3YWJeHPO?=
 =?us-ascii?Q?215zQxYOiF5INVDjzIl1wZSYSMJ1CSCM6IBGA66PHnaTcJhXr2aYBPzd0w1s?=
 =?us-ascii?Q?lAN6sqtQCZ2xFLusf/oaGvskcn6MoF9EV2bje+jUAdMZyz3iqHCrPveGAK7y?=
 =?us-ascii?Q?oZVZatK8I6MhpeRfT/0NuuzUrz8kpkTEBtcNgdgWmd/AIlC4QtLSYzV4JAk7?=
 =?us-ascii?Q?kEXgMma65KEYrNCU5GQwYj+QL9nzUNiYAZrbrOfOtNnLhgJE1zq40Zo7MYrV?=
 =?us-ascii?Q?biLEdby/SIny2BgqJFcBBa+fDXBgqE81UsEV1kTQF4/v/aHVNLBNaT4MxY0o?=
 =?us-ascii?Q?vRKPrFXQHvUybpRSH2RrK1lm2jo3TRsjZZJe+t+Umor2JXxqEYnFE+dEqyNK?=
 =?us-ascii?Q?MF+n51dOyS88oo5O8fFJbg+AEkBvhmo/5hwh/Nk8qD1AffudTPyEIt7MzvXl?=
 =?us-ascii?Q?nofSGBz6pe8ie2OoZjlcSGns2P75VlQcReBZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OG88KcH5AvhSy2dXqN/fjhdWANScIQomhTnXJ/F9NYTEThAarGcno30WYWBs?=
 =?us-ascii?Q?OmY7WJEDjPh+uGnUaSB6SEfkD0474XhGFHqJMa5vC+SB6sQH+/Pyb7jQ/xKY?=
 =?us-ascii?Q?HPz8lODEKiluQ/TNI4mf3RnQoxvh46V0pZjYn9ZWV+EVZcqYV4iC6T+YtcZR?=
 =?us-ascii?Q?gOnRS2hxMq94YolcIwiML3IzmGzla+uBiRqRq9Zp9eVj96o0AqL9iq5iHygR?=
 =?us-ascii?Q?HLh0PcDZY8m5oYFxAJ3zJdUITQpBYa/138+c+U1N4IyEBphZ5vKoaAMUBMjJ?=
 =?us-ascii?Q?x88HuJ8D3WIMaoD3KxZACZVMxGSHpyWZkyehTLsqw0zEF/GfLPVW3VEOeasd?=
 =?us-ascii?Q?vGTKXYAVDDKa4Wi/QuPUrcHHUELa9MTUZPXCFCpFbCozBZ32ghzPNvpY8+DO?=
 =?us-ascii?Q?Trjid89DDQNdiXn/C3YfaauPw7geN2GFlA2u1pVZR1oClOGvb+sg38q9bzh1?=
 =?us-ascii?Q?1P9ru1aP+T8gqLfkG6Eih0CqEzo/dzPTu9tEfEjWWDumy5+qTAgkCGSGSMOB?=
 =?us-ascii?Q?i/JXEHvT37aL/jnW/wVuwpUlsR6jS1ZkXkysg9K/wiY67MpicKoJNjaVDKa7?=
 =?us-ascii?Q?IoQpIYQ0SnVUapO717KYZIPNsNcyzTV0CyW5ekufU+Q2pNFqKZfk6q5t9IdZ?=
 =?us-ascii?Q?G7wQpM5fOczVLhpgHXxSS+spItKI8rDH7w9ssRD/7Mm1Z0vvJftL5TXTsRjz?=
 =?us-ascii?Q?PUByGst/JJ6hIUA6xXSfcWhCKzeWsaNtps4ralzTwnOvj5cmRf71JzccqFoz?=
 =?us-ascii?Q?hGuLp37gNLUWptIvcEXBVOPcRJN9URg1gZBk+yEaPwx/0vocNwvBkomuW2Ab?=
 =?us-ascii?Q?28b8rWHH2W9Ox8gJXKj3TZnsNnBicH7wY3lqgmXleVcPvy6ZutbxMd8HVn6B?=
 =?us-ascii?Q?pciFwf2XDjqPKaJwM+nri3i7QrSxJ7utljK6B0WLNF+yPecgmhZINpL9h8Qu?=
 =?us-ascii?Q?RR6fra0SZLCsKh8JCwh1tAAlm3BihkXYsmSIxRYoxxodSkojXG0qJiW5vGu5?=
 =?us-ascii?Q?gGpWVzoixAFmNkKjFLCLBu80iE7ohfDHNI0BgbB/fge4+sNgX0qgXLwVUm+H?=
 =?us-ascii?Q?QM/WmEG6b3KXVelGP7P5BiVj25nqlp1XqnkRvwzMRh4TfWYxtN/a8PkVMcT7?=
 =?us-ascii?Q?/Q2w2HhtWtQi08UKdOCBL47nIHWKuRY5p6E5puoqaZEaIl1Uq8O6OlAxQtXr?=
 =?us-ascii?Q?z0TajsAEKVK7gkGilPbXZkNkVGnJ2lMas8F3O+nKH++CkA4VJGJvUZkVRqn/?=
 =?us-ascii?Q?YTMtfUO3mBTiUTf7dSAy5vWlrQrjlndNd7fkGuOnQb7IcyQZnkxshg0fljbF?=
 =?us-ascii?Q?qIpDUXmLgvrmTz6mcnRoip4SUL+3pkeefBHgwO3ySNYgX2zBeLFicMsNaTcJ?=
 =?us-ascii?Q?SADg8V5Hcf/UEReUeND/bhyhfKeR+uPe/nvHBNJEx80mv7M6MXstzyUQgPn0?=
 =?us-ascii?Q?qffb6pz+SiZeIbQODEjPox6zujfzYZtzx9lkO9NWudMoChRsmf8hvyTOKGxb?=
 =?us-ascii?Q?Gv90n9wT1KKwUuKrD4ZBLc6S0D8za5wATfwkbZq6Dg/wF6bUSi6x+94V0Lh4?=
 =?us-ascii?Q?g8vmXpIpym6xDpOPcMwENlJpX4XUU+WBB3yf9YVCh0k2z8ftmZ7rYKOp74sv?=
 =?us-ascii?Q?D4xxC+JhSJtulnXp5KfXNvba32e7q2SuzHPn7vdMo5QGRHgYOcPpSHHVuQ/7?=
 =?us-ascii?Q?7CTpNO0a0ZC4OEuMumIO8LwJGHKsPXrSTj/UnJSdtuuGcQV2t5wvgq9SXK0r?=
 =?us-ascii?Q?t0S5hZV8DUTudWRdStn9pbdeRTIvqGdgEx4Fb2zM163RrAZRc0Os?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d63b305-a133-4fc8-0e26-08de61a8fbe7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:45:54.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faky14gEGg95galsMopep2n4w1nh49qwyRiaDVtzx89ybfPUYasziMpaEOjUno4a78WgqZniRQLgI6yvG15L4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7444

On Sat, Jan 31, 2026 at 05:50:38PM +0100, Niklas Cassel wrote:
> On Sat, Jan 31, 2026 at 10:36:55PM +0900, Koichiro Den wrote:
> > pci_epc_set_bar() may be called multiple times for a BAR when an
> > endpoint controller supports dynamic_inbound_mapping and/or
> > subrange_mapping.
> > 
> > Some EPC drivers keep a reference to the struct pci_epf_bar passed to
> > pci_epc_set_bar(), but the documentation does not describe the ownership
> > and lifetime rules for that object (and its submap array).
> > 
> > Document that the EPF driver retains ownership of these objects, must
> > keep them valid, and must not modify them after a successful
> > pci_epc_set_bar(). When updating an active mapping, the EPF driver must
> > pass a new pci_epf_bar instance and only free the old one after the
> > update succeeds.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  Documentation/PCI/endpoint/pci-endpoint.rst | 22 +++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> > index 4697377adeae..b2f5ad147ed8 100644
> > --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> > +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> > @@ -119,6 +119,28 @@ by the PCI endpoint function driver.
> >     BAR register or BAR decode on the endpoint while the host still expects
> >     the assigned BAR address to remain valid.
> >  
> > +   The struct pci_epf_bar passed to pci_epc_set_bar() (and the optional
> > +   pci_epf_bar.submap array) is owned by the PCI endpoint function driver.
> > +   An EPC driver may keep a reference to these objects after
> > +   pci_epc_set_bar() returns. Therefore the EPF driver must ensure that:
> > +
> > +     * Ownership of the pci_epf_bar object passed to pci_epc_set_bar()
> > +       remains with the caller (the EPF driver). The caller is responsible
> > +       for ensuring it remains valid (and freeing it when dynamically
> > +       allocated).
> > +
> > +     * After pci_epc_set_bar() succeeds, the caller must not modify the
> > +       contents of the pci_epf_bar object (or its submap array) until a
> > +       later successful pci_epc_set_bar() for the same BAR replaces it, or
> > +       until pci_epc_clear_bar() succeeds. Otherwise, it could potentially
> > +       lead to use-after-free or undefined behavior.
> > +
> > +     * If the caller needs to update the mapping for a BAR and calls
> > +       pci_epc_set_bar() again, it should use a new pci_epf_bar instance
> > +       (and a new submap array, if used). If the call succeeds, the old
> 
> Why does it need a new submap array?
> 
> Since an EPC driver never frees the pci_epf_bar instance, nor never frees
> the submap array, an EPF driver could reuse the submap in two consecutive
> set_bar() if it so wanted, even though it would be a bit silly.

You're right, the phrase "(and a new submap array, if used)" was
overreaching. The .submap does not necessarily need to be a new
allocation.

> 
> I guess my point is that the important thing is that the pci_epf_bar and
> the submap is immutable / pointer to const from EPC's point of view.
> 
> Since the EPC will not change the pci_epf_bar, EPF driver could also
> theoretically call set_bar() twice with the exact same pci_epf_bar,
> even though that would be a bit silly.
> 
> 
> IMO, we could totally avoid all this text if we just changed;
> int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>                     struct pci_epf_bar *epf_bar);
> 
> to:
> int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>                     const struct pci_epf_bar * const epf_bar);
> 
> 
> i.e.  const pointer to something const, because set_bar() will not change
> the pointer, and what is being passed should not change.
> 
> 
> Note that I'm not asking you to do this change in all the drivers,
> I'm just saying that if the API was actually defined like this,
> we would not need to add any Documentation, because the code would
> speak for itself.

I agree that the const-ification would be useful to some extent. That makes
it explicit that the EPC must not modify the epf_bar.

However, I don't think it removes the need for the documentation, because
the added text is more about ownership, lifetime and about what the caller
must (and must not) do after set_bar() returns.

Even without the third bullet point ("If the caller needs to update ..."),
const-ifying the function parameter does not enforce the first and second
points either. The caller can still keep its own non-const reference and
mutate the same object after a successful pci_epc_set_bar().

For example, epf-vntb initializes BARs via pci_epc_set_bar() with phys_addr
= 0 [1], and later updates the same ntb->epf->bar[barno] fields in-place
and calls pci_epc_set_bar() again [2] via the .mw_set_trans callback:

  [1] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/endpoint/functions/pci-epf-vntb.c#L710
  [2] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/endpoint/functions/pci-epf-vntb.c#L1288

So, if [PATCH 3/3] is the contract we can agree on, then I think epf-vntb
would likely need an adjustment to follow that contract (i.e. avoid
mutating the descriptor that might still be referenced by the EPC, and
instead switch to a different instance when updating). In that sense, the
code alone seems not always to speak for itself at the moment, and having
the agreement documented would still be valuable for future EPF
implementations.

Kind regards,
Koichiro

> 
> 
> I think this patch is good, if we just rephrase it slightly.
> (An EPF driver can send in the same struct bar twice, it just can't
> modify the current struct bar while it is "in use".)
> We can probably write this in two paragraphs instead of three.
> 
> 
> Kind regards,
> Niklas
