Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020141.outbound.protection.outlook.com [52.101.228.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32108368963;
	Fri, 27 Feb 2026 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173441; cv=fail; b=HW7DHGJvIzZZkaAyqhOmXkpbfsnQ7VbA9GpoeAub5WFHKYc96llIKRkm+1VvvRvmDhti6b4cdy8jo1SjyS7/FHJff/oAkB22LFP18yaJSHPWg/Xqnh+4ojeSr8PmPu/fnxCTaffBe1U2RNgoVTGtmPb/mFslhXmHHb4r2nqfdTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173441; c=relaxed/simple;
	bh=1kJx+kbDELry0XAFjZhqhNBaUhAXBqbw0WrHRCyk7SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TWUDmdMnbJog+z6KQCjxbC4ngZ6tffwoQu87ppxGR0SEG+ignFsnCgBwZZ5M4KbRWR2fH1BhXpAAcVarD2bQFVJRqFkxTn9qYHCyauP6TVhfZmNKEzg709d8+Wc/+PdW7HPteH+ogfRrPC9cHpw2q2ZwVxDthxRFFS6EfPP+2zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KBUz7c95; arc=fail smtp.client-ip=52.101.228.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KBUz7c95"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUUZLUrd/J6nwLbG44M9crsoD8Ak6o8q/ArdHYItaf5fG8FPnhu0s4ty0cgQQ6bE8ZuLG1/PX+4fdBH8m/GU/epmI3i/p4v9GFCQNYoZTu71ScUyUgUIiFCU4ApLG+/phxwQKAjWkjiUakL1OVTmQ58f00/VfnWOinKPBN7LU5zelgSc65TDtyKiLrwlhkYJhaF3x+ccShnLFbyjlV4ynrLG2JU6bWvfwDRflICNAbsgY1TNOBVQBrCaEuZY+MUUu/vLPngq4OswDd7XS0A7OW7IoPtNVK9gQXWFfqWCmWqDOQ2ooQtHQpXjAR11vt1UXj+lXky33OfsMljKEOJKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stlvdtJ/ggWY7Xy+lxnb+F+eWzASwxMqAJgN+NxAoZA=;
 b=RlI/tXrOvKMGejpGdRX2Hqhsj5Lo2gtx9jX+ekt/XFdlfHgsWoXpwN2brFjZldIGcjlgK7SZCayjbpHK6L9IvwfpU47nY5vLlvWx3bR4ujHLFjlxrpG13rqsgTSSIDRB0hJSu83jOuEXWJ4dHdcnKO8ZdS8sZKdW97KNz3dpOIUU6VhMwoOCzj94th4Sv7CrNM0fgwzS29heXszDd5V9un5zPFXVhlkO6vSNpmuOZHS15Aas3XnzbGRnloGezF7RhVHC5+B4w5S8fV/eA8HPMTguVgMfirHLVtH7yqMSbRIaU7YSKEboR4jPLifPwxyO2N7er8cXUpNNqkkKPdlkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stlvdtJ/ggWY7Xy+lxnb+F+eWzASwxMqAJgN+NxAoZA=;
 b=KBUz7c954juFoS15jGl7O3KmhutXdciDrIz3HwVq/zntuQeAi7PNdZ0xiAQcKN/XRHy93rp2jS4ZHVakoqtVPwqow+Kau++yLE0AQpXw/jvArtmzfCUWbETIGm/YpvbMUYtwMVqQtTSFuDfZLO+/lkYBqX3WJl5wjZl99fz8VUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5210.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 06:23:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 06:23:55 +0000
Date: Fri, 27 Feb 2026 15:23:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org, 
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] PCI: endpoint: pci-epf-vntb: Implement
 db_vector_count/mask for doorbells
Message-ID: <cizc5inlzty54m54zj2aenk3btdpof5a546jexyukzhfjzygew@3ujqgv5exkve>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-6-den@valinux.co.jp>
 <aZ9jSS_sWVGnZwb6@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9jSS_sWVGnZwb6@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYWPR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e38302-a745-4cfa-c1c2-08de75c8c86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	lD3Ld81ZAxJ4qBeTzSzdLOzFXLbTumYO1jzbExtEmzTYYqqcePJAD6QLO7MrDkA9YoQuBOKSmJRnJdRv5Mn27vUXPlDVekxLAM6cx63em0F8bdeotLWJ1WamPRKD5g2hqpfNSnYQHVtISiCKMeATz17LWpHN3r7CpLUa5AvT3fyeXAUd/rbCsaIsfw70idGpzVP/fHE2vDDb6tc5qQnC+tN3Y5PuoIXY1ZoGXEQhSCt7m3QLBctsk0VaHxsNcUz3i0Ih5vJNUwbS0LfA9sI5GNj/trYR8496GdJSNZqmdy/jI8etsKn4vD0+3Dj6/Fswm0nQeg5IQ2i64gOrtGdckNdxtYHm17Bvq/wN4Kjj5G4v0v+Oivh+WEMUop9qgGxsoKLKEcBZ35WzpcSrbk/W5V2cU6tEQkYXQ19pQYVZ658HHFiKt/Ta+Secn44i1dDRFjUjASjpKpFLmq623hR5HEHpL+Ry7E8q7xYIJZfsIptCXMtXmYFwqvrPC5ucROkRvSmlq+Sl1fwx5dxsW5627F/ELz6ry7buWmld8RvC/lSXpggLGT8Jj8vobDaVQK3wnDsddTMiomDRXnt7F/pF7101ZqcaFuKzDHgF+Ya3q20fu9dVkzihMz5AzkdsM9H2EJIw7RqlEzzT+N9AaKjvlwQ+06HSl/UN9p0y0MXVYuocCs5OarwoDzpaTU4sVogp4lTPIbYRIG6yvLLXZlgC1ww62cRLPCfNhxhS8iKWP/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRzuxiTpHGdFfdNmaFdw3qXLJ8LeJhNkcRGFvMcsNNdMiSa6NiPithfC7t6Z?=
 =?us-ascii?Q?eigRZ+iXj2fn7U2sZb/00Ojsi5qZmCk6kxqvFgF6N6zGURBdcR+rFA6bIXJH?=
 =?us-ascii?Q?u381rcxeVzHDCxngH/0gvEJG/5xoKuXsANF5nkQxNBP0NTogS6GeTU7vgqP6?=
 =?us-ascii?Q?y4/W5RiOU8AXRtgqpMW6rqe5ECnT3DIfdcBJyLOLCi5OGt8cg760f1+z86bo?=
 =?us-ascii?Q?Bf2XF2U8yBgxFcs1rCbUk5gRJPuE+bQxgZ7ZADr+YeIt096NmEK+XDpPdbZU?=
 =?us-ascii?Q?Fqip/py3vkKiTk+PmHgP6DCyaum2bEtSqu01fH0esdC94J/RPFzJfatcqfqz?=
 =?us-ascii?Q?Cmo2p7AfENp+NdOEdbr4AN52d0KxC5JWJichSy4bC1NY54XrjAbB4wIvPGVC?=
 =?us-ascii?Q?gIUYXTPXNAaeyL6P4B/xY9AfhksC+BKBFluOCy2FvXNnAIRKBwOnDovekwlW?=
 =?us-ascii?Q?Z9TNTfmWFcH9x5YerRXyBHe8fPYe2diykQkD4oT25WJYW0dvPnlUDi24CUym?=
 =?us-ascii?Q?qUg7xMcNGc8MSkD4al1uB+GXVu3kEgUKKuBbzuZISlMJERHNR+Z0YxEbbQQL?=
 =?us-ascii?Q?LJAWmdCUIUj83x0n6mMCSh/3nmThpyivoMSNij4g2raxF0jHFKfGLtv5a7nV?=
 =?us-ascii?Q?Io1zXGrXfOKXNRilr8Iqh8J0AaX4ActW4v90CaTEZRH1kllLNarkBd86HXyO?=
 =?us-ascii?Q?aTtUiFRz/ysGDoFc+SmmsQ62WmudT9qopiRiZRp/6LI9okbCZJt7qVm3CCGm?=
 =?us-ascii?Q?HTPBo2m5jkK0Z0KOtKuJ5417nLXXJDaK4eE4EQiaXGSDJhtrRBNVX7HsDJBm?=
 =?us-ascii?Q?Lw6JgFo6YBKKSiJJDX3OveT9uyqAix8vZkvO7hMB5ndEqzbYywdcZlStwCtj?=
 =?us-ascii?Q?/8eWFh2Smlt+/B/Jkhjzf7oAYIndhJWlq8F2gy5crqoMElrYv2Iu1NqH9Dfz?=
 =?us-ascii?Q?2ZjcU83N0rsfbsn6mZeaPzpx7ejgxYyMXLeErnJT/o8zf0jMz2eUAtlMsYXG?=
 =?us-ascii?Q?mbhReOuxShWlcBwFeEVX0AHEilV+d7nQPBKkc1sed9s8KnNyJxDFXQEqG0wW?=
 =?us-ascii?Q?mDQwLLzZrF2X9f+G1KnMWKJ26io7hOP4+oettEeoPr/AgRRgMFyFdpbLRlOI?=
 =?us-ascii?Q?9rQe0MCa7a2WuSTF/FrNXC1/7yTIOcBt2UUwYAC/U5+xu35LkZUlvLsEHxkE?=
 =?us-ascii?Q?8Kj82ilw0pZ2LBi0tfZGh3kKEA/qqXR+k8uftc+JIBzmZY0LS4PQMS9dKJhq?=
 =?us-ascii?Q?nXjospOUX16PSJi4EwkhtfmNS3sKSPf9TPqXGmAcuqGrSOwrTuIKPFEipHRk?=
 =?us-ascii?Q?G03NGYWD7t660WrlkmZQcgecMR5JbV/D0xd2jD7wGDF5Sjsf4FGDeQAz4gX9?=
 =?us-ascii?Q?W1PQvS/ZYZLLj5DnYc90Ci/up9nCvyf9iY1FcUoc7s5Zb9ojnHRnqrccpAjL?=
 =?us-ascii?Q?KBSyJymeHODIF2mKJXPQtNNUCw54Ouqxd7d1ugwF6/EK7YQZ4XXK8zAPcgiB?=
 =?us-ascii?Q?wq4rLSEM65UqOzBwXodnYr3Wx/Yq+5fGZE+8/anDiJ3Ac+XE6xjBN2lUd5b6?=
 =?us-ascii?Q?IOppZOKilTI6CDSUOt+3jl28ycHyuoxUgKuqbJAfZNJ1jQyjJ8mPLlFhTjaT?=
 =?us-ascii?Q?scyjEIgwMUeJJYKP2+jARPRR33h0ff3Jf6Cj34+hyBc9ccGtvtc9rGnBMzur?=
 =?us-ascii?Q?Cdo6VK1LzkrKnM3bwoNh9D63jAA11gBTNmY8ZRjxROP735ywmxyVd5btRi3K?=
 =?us-ascii?Q?Xgp3IzcDHjxQtw9ISM+aHHO13D6E5LWvw0+7gSerPRI1MUSvgUlc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e38302-a745-4cfa-c1c2-08de75c8c86e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 06:23:55.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6+rBMm4EusXDhI74lxbFk2EIUQlHAmKceKbn0pDFKr56W4ZUQHoBl8cmrmDD7Gkdz4MNs25+3HYSb/4CubjwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5210

On Wed, Feb 25, 2026 at 04:02:01PM -0500, Frank Li wrote:
> On Tue, Feb 24, 2026 at 10:34:54PM +0900, Koichiro Den wrote:
> > Implement .db_vector_count and .db_vector_mask so ntb core/clients can map
> > doorbell events to per-vector work and avoid the thundering-herd behavior.
> >
> > pci-epf-vntb reserves two slots in db_count: slot 0 for link events and
> > slot 1 which is historically unused. Therefore the number of doorbell
> > vectors is (db_count - 2).
> >
> > Report vectors as 0..N-1 and return BIT_ULL(db_vector) for the
> > corresponding doorbell bit. While at it, use vntb_epf_db_vector_mask()
> > to simplify vntb_epf_db_valid_mask().
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 36 +++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 2eb3db035644..b651c54d6bef 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1267,12 +1267,42 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
> >  	return ntb_ndev(ntb)->num_mws;
> >  }
> >
> > +static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
> > +{
> > +	struct epf_ntb *ndev = ntb_ndev(ntb);
> > +
> > +	/*
> > +	 * ndev->db_count is the total number of doorbell slots exposed to
> > +	 * the peer, including:
> > +	 *   - slot #0 reserved for link events
> > +	 *   - slot #1 historically unused (kept for protocol compatibility)
> > +	 *
> > +	 * Report only usable per-vector doorbell interrupts.
> > +	 */
> > +	if (ndev->db_count < 2)
> > +		return 0;
> > +
> > +	return ndev->db_count - 2;
> 
> return max(ndev->db_count - 2, 0);

db_count is u32, so it could underflow.
If a one-liner is preferred, something like:

   max_t(u32, ndev->db_count, 2U) - 2

would work. Personally, I think the original version is clearer.

Thanks,
Koichiro

> 
> Frank
> > +}
> > +
> >  static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
> >  {
> > -	if (ntb_ndev(ntb)->db_count < 2)
> > +	return BIT_ULL(vntb_epf_db_vector_count(ntb)) - 1;
> > +}
> > +
> > +static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> > +{
> > +	int nr_vec;
> > +
> > +	/*
> > +	 * Doorbell vectors are numbered [0 .. nr_vec - 1], where nr_vec
> > +	 * excludes the two reserved slots described above.
> > +	 */
> > +	nr_vec = vntb_epf_db_vector_count(ntb);
> > +	if (db_vector < 0 || db_vector >= nr_vec)
> >  		return 0;
> >
> > -	return BIT_ULL(ntb_ndev(ntb)->db_count - 2) - 1;
> > +	return BIT_ULL(db_vector);
> >  }
> >
> >  static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> > @@ -1512,6 +1542,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
> >  	.spad_count		= vntb_epf_spad_count,
> >  	.peer_mw_count		= vntb_epf_peer_mw_count,
> >  	.db_valid_mask		= vntb_epf_db_valid_mask,
> > +	.db_vector_count	= vntb_epf_db_vector_count,
> > +	.db_vector_mask		= vntb_epf_db_vector_mask,
> >  	.db_set_mask		= vntb_epf_db_set_mask,
> >  	.mw_set_trans		= vntb_epf_mw_set_trans,
> >  	.mw_clear_trans		= vntb_epf_mw_clear_trans,
> > --
> > 2.51.0
> >
