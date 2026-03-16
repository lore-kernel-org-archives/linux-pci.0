Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021117.outbound.protection.outlook.com [52.101.125.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826052D77EA;
	Mon, 16 Mar 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672079; cv=fail; b=VB2lG9LJtfI/z533zeaNgtiq0vpak+2KARSo8Sc4FJom0gPkoBiVeJ7g+igQlLijoC4axgiQzeV4anhuE9P00MpYIiZ0dRL14gZkGKlhRHHcDouZF/LQqDKRdpnvy37TvfSzjrJlvOe1R7GBSw4NF86E4J9oTQ84tMsUvFRi5Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672079; c=relaxed/simple;
	bh=YYJ+SUo+lfTTUKcjloL2YHyqaHWRcDwR9jS5y1Q/UzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qbvEw+ID9coqkpjG8fBlDjqOAjfaLdEU9OafVrmGA2rzJnSu6z07iBAHM1/zNHxbBt8p0nycxaNvyFREFZJQivF4wJJ+BkzliAhCvvRc/dGb3HXAshXkf/eNoPg/uJgAPEliFdeZqeKq9XMuSTQMwc/9RUuvnkHIJcCsVlDkqoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qZ81Dr+8; arc=fail smtp.client-ip=52.101.125.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qZ81Dr+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpc8cyRq03UFo4tDfA+UgdK3NP0RvKUBIjPOUFOHrVxYP0VvjXep2lRNX+rClNKeGBCo7Wyp+QVnOZ57UJM/oRzWdfNyjrdA56rPLHwznNBvyhOqP/ODC4Rr50j6roD2ULAB8Il7Sb/IanmabAKXwRusv9FHNeXZ19vJiuAWgzoLx4nOOevTsSelIr9Q7GakJOPlZ00vTm9ymZ/9bEDoFMZTrW7qYDwLXaGVVsDmqcYpV2kiYrJj5MkLD5OSOekUjJuuuJNCjgjtHyRALbP7lcCLk4GDdR7h2Q1s8qpHyVmDNS0RSvCIAkfYTcZTKPERDbvdFkdCzphpF5QUF6tyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL4e8vgfQ66XMT9QDUP1/6L9kc67UB0J0dwCPV0mK0g=;
 b=BX2YnkOiK7VXgo1QegokZKG3b0h9pP1cmD8SzgXPi8U/zFff+wiLaa9SXAeiB2cpZhtcR/g8KZERUp6dIq2nOgXzXlViBscvOgj+EjnlFJfXYHP6OWY5+BCtfiBXNf9O3lHvxBrzjUjghV18I//wWfE3LW1YHbBOprs05P2meHPRa99X/426MEXkrOz9DqTSVYxbYj2z0P5oyfAP7MESBa0IDBBMOd//ntdUen61jViDh5bUpy9l8/ZhKhOmENIBvJmrfvyfNuy+bLpPSL3ajewA+FYUyiTiRKUhPIX2TX1HkTGeasqkA4edibb5eAABbxqU8R+8XdfrzFNMZs3kRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL4e8vgfQ66XMT9QDUP1/6L9kc67UB0J0dwCPV0mK0g=;
 b=qZ81Dr+8GSBvKryMKZ92PAlmrYHP4j6OzYg66iQetHzjQMqq91sF7xv1ft6b3ZFLMJhtMX3Pu/hF2Q4pgHnEZ7HQqE8jxg3ZV7KhFeXVAF/9gJA02Q8j+9Fbz+eWXx7ISH/ga1nUeitk8fP5LrPMOQSWN3ge1NpZ0M13Ot2WQPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2101.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 14:41:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 14:41:15 +0000
Date: Mon, 16 Mar 2026 23:41:14 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>, 
	Christian Bruel <christian.bruel@foss.st.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <g7ozd2jsscb47v3qjgvnx5fzjmpwnhx43p3hh7gl3qq7snrxqi@3qo6yegqari7>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <6rpfgqvrswp6zxhb4zdzkqvqzwk4ipp7zyt2wqyj2zj4w2bsri@szdiqpdpmt2b>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6rpfgqvrswp6zxhb4zdzkqvqzwk4ipp7zyt2wqyj2zj4w2bsri@szdiqpdpmt2b>
X-ClientProxiedBy: TYCPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2101:EE_
X-MS-Office365-Filtering-Correlation-Id: 9787abff-d447-4055-6fa8-08de836a13b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ef4B+gSkYXOqR3LBcmFspU+ybDSKJpLwsTLNCwxqNUpS91EyaHOx+Ih0qjV0H/lQmXfSgPKe5+IfP70cZ5lnG3zG9oMzC3nsxTSet9JdKMmDcsxy6V58LIQ1LTrBEd1Jk7TZDWHE7hTXaJuslrbMzh803lZt7qIrBRmLo+0wmNwljbPFBX81JqWXVMOAOh33hHZcqeoET+cpC7YEO2kD39Ww/Elc+RfbpVkUq9bLW3YqV1K1ZHXxCXSszDhQhFEtOUQlCQi19khJya3PgY7p+nBb/M6pq41HfxCSSDgfVxMiDNetEGQarPsAFLHKdVu1XQNRaJkaA64NzloDI2KLDTVGhY5IWtvM74vO3yRRCGFN14waIRvL6f63mXrcft7E67i2hpm4z3FjhnPw+SLkwCAQMVgu/FD0piAHU++JQjG64sHqq9O9wzWLicHY0IOb+5KVB5huVQpD84cp8bI3VnEYfsrJU4lckY+KmGKwILNoGqO3n3C7h2vqK1BLek42iHSBPuGQ/MlopVAU4Y+g/XdlK0WjW0kSe5PuExyFdoLt9Qx9p/bsSXzCkGOfVIV5ZzWfvlWaQsY7fv5S74M41Ie/+wikXRl2Zc5bHHJ1ZZVChb7Oyas0NTCv3weydPjtetCxjSsPSxy4Ys1K7iZks3vLpPd1C5ViPyPvgYs/39RoE79G3HK3t0sWGn9IzOud1eSsyF+XD2uhT2Alo4klz0msHAEAzjcqVao2XnTA4dfZmlw/tKImyXY766THVA4MkbZZHHA91eUPtd3omHmEBHZaGRp8AXbU3HMGt7xnCS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sUS7w80ROp2nHNjhvzzxj0+AdoQZJbNzZMebGtQRDr+ELsIaMywF30tB8fug?=
 =?us-ascii?Q?AQ0wcAcsioQdGOefWuNUYGUYUBvk73YavVZPdmXT6Km3A2LPLavtYQ4zlExu?=
 =?us-ascii?Q?gQqrBgOaeepBFx7oNMvWiZ0riQQ0HNausJesTyU4sd1m7rdjwpwbhkMCIjLp?=
 =?us-ascii?Q?ocO0yEPoatj93bYm8te579fuU/9h586tUBuYh2BaesFwg65L/008KDJWhuqB?=
 =?us-ascii?Q?ZhjfgkH3UoGgNQriSvhSxeXEza7dwxP7r4BMMeTd9Kv4W2VvZ2dQpDNZam5s?=
 =?us-ascii?Q?psDZthnZaeoCzQK7yZzD0saemzQXRIcVAsFIolYJO+rKSYavU2LQ57ROm9rx?=
 =?us-ascii?Q?HNhd7vNUHR7bwHgJ5aFbNUpm9HcNwNqtTyXkHNjc6VpVJFHG7jhy9QpNErB3?=
 =?us-ascii?Q?+5J0ZzrBfUGegMaitj3qjTPr4DQGmT6Ex0I7ZlWSwPERz1Y31tKGdtl7bAKo?=
 =?us-ascii?Q?ILqOpNi7+ivfQMr4p0JUbkwoNbBsi9qovvt1sTknkNP1H+BZWeLj/gxbgGMl?=
 =?us-ascii?Q?O2/SD970Wbi3VDYbX3wY2lRNaJKNVwY/VNvtRBzTX/QEZ73gXqXFl+ppaUo6?=
 =?us-ascii?Q?g0TjgCffRMyPvPZWdM34SmhTZbKqWb0iely0iloWITAe1Hmik22fYmk7WH3U?=
 =?us-ascii?Q?UUOT41VMsZ4o2z9mR6kbP2gqTv+3ICt1BC1mN2v9uesdqnrMEeWtSM+BsP2B?=
 =?us-ascii?Q?RxwyPUyDGCi03xq8ZdwxnE5A4AA3RyRYkYi0LKZVRXFyYBJevO0TgFIPsGNf?=
 =?us-ascii?Q?aBYhFMua2QuRRSW4uGKYoOabFyg2JkpHZpGq3l9gJrWwNl2Ex41wog/g3+8w?=
 =?us-ascii?Q?Vn/cTddhsBZ4/gRZS+i+WyIkdcXqKFZBaGcaeC/TKdjwVcbVTGO/TwYuGRs1?=
 =?us-ascii?Q?A0C9ddvvAJDVn7H3e0bsQWXZv0G6KtNyakQsi6P8zHZjs/d1wIYyLJ7VKCd7?=
 =?us-ascii?Q?97uBpahzL377m5W3YkYdGCLTQ00AnyomVQdLxN6Vs+LY+E+Gd7l03ZcH1sL+?=
 =?us-ascii?Q?4KX50iA2nfBHfa1ESzrcKXPpopIoiU5y0EBq80NLci8EG4oU5XmWfLUxT+gm?=
 =?us-ascii?Q?6b9eTShKSREILa5eBMqhLIhAHkkUhqK6cliXpe4dPVL6m6VItRbskCM3AKZ2?=
 =?us-ascii?Q?YC82yxIsNHaCp9i8vzKakv2/vWdvf4j1yf4g+uSggd9Qt4G+wYs5lk5G4XkG?=
 =?us-ascii?Q?lVwlFOWDxLn87ktAkQZfDFbo3kf72j3wdo6wHGYc9N1E9AKUL+nIA3N8WtZz?=
 =?us-ascii?Q?8sLITk4CIAXYmLAwRmXCJ1VIgnxQv7eRcbXi4D8bB6TWEuTnhlxtJI55vD0k?=
 =?us-ascii?Q?Yb/PWPwF8FDVXzDEzqM1udRKOxMTixxeKgS9PQcY458ecKdodYOA8CbJyM17?=
 =?us-ascii?Q?42YQUkwTcZHE/ZQ0PQtic4XD2yDtLonn+jZN3Ho1GxZl8jhkg8jDV9cMRJbf?=
 =?us-ascii?Q?EQTJyMKszwI+v/dI98vw4KSgenVEMHbxapXpj+JMWrKEGfBI+j9dT3Qq61/+?=
 =?us-ascii?Q?NQacI6pAAqt0OE8Gdgbt1NHPisiNZZVAT8ee1ilwW39KLzrLKczKGsqAKT4g?=
 =?us-ascii?Q?wxCyZqch/zE0+e9LIR1mXTtBtblxtFe7YpiEZnPOFOB08ikicF+egt/D/po9?=
 =?us-ascii?Q?yYZU8WmV98l77EgIXnYhKjpRqd30wdoE+kJVFHxbittECalJYja1TU0BSaBD?=
 =?us-ascii?Q?aOdmzONkxEIu0VlPa/Z5AMRWg7lxIDBj9xzTo7qmxacmdvI9VfdaGYITo0sB?=
 =?us-ascii?Q?tTqpmL4rI0UaLfgF+SQydQdzdkBVP2+Qc60jA3gK1e/u0OnJ/i+1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9787abff-d447-4055-6fa8-08de836a13b4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:41:15.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxc6t+UpxnpICz3lfpHrBfn24NVbyjilCKHcSOCXrYSsifibu4LWcbz96AxxCYAYsjVLfqZk5LYZXdtJ35m9Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2101

On Mon, Mar 16, 2026 at 11:36:07PM +0900, Koichiro Den wrote:
> On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
> > When the BAR subrange mapping test on DWC-based platforms fails due to
> > insufficient free inbound iATU regions,
> > pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
> > not restore the original BAR mapping. This causes subsequent test runs
> > to become confusing, since the failure may leave room for the next
> > subrange mapping test to pass.
> > 
> > Fix this by restoring the original BAR mapping when preparation of the
> > subrange mapping fails, so that no side effect remains regardless of the
> > test success or failure.
> > 
> > Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
> > Reported-by: Christian Bruel <christian.bruel@foss.st.com>
> > Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 14e61ebe1f11..f44c36f5cac5 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
> >  	bar->submap = submap;
> >  	bar->num_submap = nsub;
> >  
> >  	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> >  	if (ret) {
> >  		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
> >  		bar->submap = old_submap;
> >  		bar->num_submap = old_nsub;
> > +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > +		if (ret)
> > +			dev_warn(&epf->dev,
> > +				 "failed to restore the original BAR mapping: %d\n",
> > +				 ret);
> 
> Ugh, sorry, let me send v2. I accidentally overwrote 'ret'.

Never mind, my mistake. The code is fine as is. Sorry for the noise.

Koichiro

> 
> Koichiro
> 
> > +
> >  		kfree(submap);
> >  		goto err;
> >  	}
> >  	kfree(old_submap);
> >  
> >  	/*
> >  	 * Fill deterministic signatures into the physical regions that
> >  	 * each BAR subrange maps to. RC verifies these to ensure the
> > -- 
> > 2.51.0
> > 
> > 
