Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730054;
	b=b+esta7D9hGFWnD3pVlOpq5FHgesHeZMfJZ5+FGwulfPxBVivXLzT06jdPGHkD4Dv4sC
	 ho6/aAvommB0GRuijTdrpnUDxlyMnxN5NCBxS4QwcQXwdf9srs4bWgDZiiUF7bF5pEsrb
	 K+TUq621xNg6iYALka8GEWqQNNA2uc3OhlFlDq3z3bnLQqE6nZ09QNBR3WRLGbZMnup8I
	 SiGTobPMPybUmsAnRfPExbWEpt3+oYirqxxbzKLF/FSOprDpRHGzeIvNQ4B60rRNU8/Q/
	 6Li6ZV2REeHwjGgSsOvTVJWkpf0WJzOH57aWKl/6k6n9rKdUZQDDwW7v4xtuYzI6YEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730054;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7vLbQEYZblQAdXt9tEU4LIh/FBwiVbuaxSLdXSOlQkQ=;
	b=ikFON60YAS9eMnQjZtdDsK/m57QhIooZ/PmUaW1EuTUyNND4vUyZs4Mm5YAUkpthRXmg
	 fRfH67CR/n07vPm/5TNUxcG8E2mvo7RV7q59qCcXHFcP4mVTPwP3GOdQcFYaLV1gBHN+1
	 WfT+qjxJYt1ZT9xpRsjtLrbKHJBBWGI6i/OudeZoLXHupK4PN9PezDp+BVopdvqKlXOI2
	 uwyQUrKIJV3ZiiTxel8QtRmV5LUNqnYiQ923isMReGKdRvQMDt8pVYF8exAayKXVBXbjw
	 JWFZHk4DyqWSgZxdkEWDL4SWX3cNQKAKqv1ESxs5q6h1eQ61a4LAxVZQq6E0uRVs5SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BxvCqsBY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.11
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A640606A335;
	Tue,  3 Nov 2026 18:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A640606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BxvCqsBY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpqPtQWjzunFfnFcFu/bUHfUuyfkTUwRFlK7FtmBCl7uRQiAGa1gruYk2bYeiLytAJiuT7Eu0ln0Y2fWpH+imDokKgSEeBb2OdbvHEtEP/nF40rZvKyiT3dphaCGqv0qBprzvbmBAwU5Kh3dE5ha33Bw360en4D2iKEvyV26k1G9X/ouY61JyhVv1NdMekTzAt2bgl0HK2vAwxQYjKwNaYLxJpIuRJG8KiprH1KWDDXLg2exCSaf51pv2i5Yv4Bnxs/zK3WnauZML1gfPc6AXETQEJppZ1K4xR1hTamrtlwGwiDib4Hoa9dtJykCVFiJ9G6y0jR5FCGc4L4mWaKssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vLbQEYZblQAdXt9tEU4LIh/FBwiVbuaxSLdXSOlQkQ=;
 b=MBvVqzTdUWZ6XTJMG7zMrXctf0Ihk7VQkOQjE+UGgpA4AIYP6V+mwBrHZ/eyKOJ3xk3BxJiDhe0h94kO71ae0+KU626QqhSc20azGCCGkpz6SIx7/TrAZkMpko7TvIJSesYTtjaZCwyRMZegwUEEbrOe+gLk0atzTe85FlqMzsQr0qdx/wwpqkS9vvWdqPh5ZS6y3TMuVfgthEO3H+7y592hy3+XGzZo6gUPUsYPClGrJ7HJlgCZbpcjfAlA7zoOjnCnlWR77p47EHGWyocx3HJeJVe7EpH2tliax7BvXHh6p7d8NMQ64wQZUYT+XLy2cexk1RDOzg+vDUVas42TJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vLbQEYZblQAdXt9tEU4LIh/FBwiVbuaxSLdXSOlQkQ=;
 b=BxvCqsBY+qzcMzaXlA7lB67hi3E5eH1HoBaQ/bl4dy0Kh7iWqA7J9QRUAXAz20tOZ8woENM5d9y0Jl1bAvk8MtSq9KOGiwYMYt108U3xVwNXP0TET7nd/dN5dAKWf7TSMGQzXk2Xpd/1V6UNJYa1tcMisrB0PK9ErCZFMk0/Cx4fYmdZ40Nrs30Er3U2izbOdSeq4ziQ/gy/oM1TaipW2t8eNUdYy6TrQjyYQeWj4c3McIhgAIUMDAp7j19DPLE6CM/hg/xnK+JPxBZPsu2aA2dKbdQbYrYw1I068poZsPO6yhT1hElLLyyo316yj+FOm4DJHubAQf1fFq8p2NIW0A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LY0PR12MB494755.namprd12.prod.outlook.com
 (2603:10b6:404:231::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:20:51 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 18:20:51 +0000
Date: Tue, 3 Nov 2026 14:20:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Danny Gonzalez <digonzal@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Decotigny <decot@google.com>,
	Sheena Mohan <sheenamo@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2] PCI/ATS: Disable ATS when ACS TB is set upstream
Message-ID: <20261103182050.GQ274202@nvidia.com>
References: <20261028233651.960835-1-digonzal@google.com>
 <20261103181616.GA1080116@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103181616.GA1080116@bhelgaas>
X-ClientProxiedBy: MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::33) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LY0PR12MB494755:EE_
X-MS-Office365-Filtering-Correlation-Id: b1868ced-e451-4fc3-a678-08df39d730f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|4143699003|11063799006|261021121427099003|56012099006|261009223027099003|261102123227099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NRQcqjCJI3Eq/NAnf3rKFoueuM9iuLyWK2eHLIsFlFpi07NLfZSvA/7LtObLJxmxG+ef0crDCL9c3FjQXLDkv+Hs8ejNfHe98fQZ4yYgs/uNSG79WHAZyo4rEdBzKaQQgqS7ZdOg1JUttfk821wRqador9yHw5lhmwSbZliJRcXPhvllMfpGLCcSgV7QYJuLTimLjjzf1I7695Yeag/kZtbKh43VdgRvVDcglVihMbI51h0cXYAhfRciJy0lMNOcuqnCkgbyClaGsnWHQ+r/pBKTAmhB4xSf9YTVmi32bYCM5LMRU5hIIPGo9yDdVbM3RoGjh+CMXtE/rTXMopYpq6Sq6nl4snZblyWPd1iB4rqtXKq2K6G4U373adua+9tUjFNmrvmHBOab6J+QIWu1p3dRQLiFJLY4iPla6il7E6WGfGJXMIBNJ6eaEfrJtqWoVLiMA2emYzZspCAV7NaVri8QUJ/o9LTZ1ErI5xo1zKDQtQX+umJ39qeXYSHsgwTfeRZzATFG9NiZYB/exl7BZbWczUSjf5EM6aKqJmjWgoyym6NLF1wgHXwbeCv8zmjNs8o6paEohgfnKura32YI4I4kY4fdI+PQbYRZH4+glxucKo2ZTqyXpDBqZ/FBMpAxnDQdbWMFWNH8tmjqqnj0tcQBwkAa7BelIY0IQGOmH7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(4143699003)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JsLXw+HfzTenpFZ2OvtdIy3P1oUDrsctzKeW2FnMNxnMfU94nIY34pvthktU?=
 =?us-ascii?Q?Q0G+uOV5MNSpPqM30kuWqVzirbD3cqQY8F5jvwSrRDT+EF3VWaYjzVjr93i8?=
 =?us-ascii?Q?KyD7bJuvVlTlqkUJVaYV9EQdmg9wzOitlOwf1vGcNbc5gNdzT0jbE6Iq8fUt?=
 =?us-ascii?Q?2OfmDoohCkf58+1nwT6nVGlawOTEd7jZvyJaoemylLulamgBeVNNhcwBo9K0?=
 =?us-ascii?Q?xAaKf5hkBsSOV8U86r4yxQFzHS5b/fbxy6VEbWjuep5siabIAN9jBZPC8WRb?=
 =?us-ascii?Q?BcOweNI+eyopYcP3EWooivfFCGD5BVQwJS1uu1YoDXN7Q4zkhZicEbJapUj+?=
 =?us-ascii?Q?MV7GEWzHd5nUMumed1r42YrgNTM5Bijg22A1Iedjmywz5N6DH13EppKEiYkp?=
 =?us-ascii?Q?ziL2eNpXFUM5/6+B4X0rhY3YNGTxUX4cKDNZUAioJkS0n6lNOJ2KY4ijBIIw?=
 =?us-ascii?Q?xXcRKOHBWHYdqECKeHIawZ2XlCIzvMFulBn4tI/c50W7cL5QYfSDXwXsaF/F?=
 =?us-ascii?Q?vFNHPrUS8j4onN0MRSDox7nut/SxSAngzxORR941W4mruwbkdUr4TzJpJEoS?=
 =?us-ascii?Q?iGZruMWrlFlb5Cnb72y/djZ1yHx8xNwtuPTnLhnwZDtWgdgP85WA06PleN9B?=
 =?us-ascii?Q?Nr510jRDpxCEGjGN2cedZTnr3ABZhOKe8P1A0tDZby7LCofxsfMWxd83GRTc?=
 =?us-ascii?Q?2UhmGOB4UxNWiVxs8NqMLuvQU1f9E/KX0zEVal4iv1e7iiTxxOzYqmNo3M6f?=
 =?us-ascii?Q?He+Jy0XvWfz8DrJb5ZcQyJncZBJynwp+Gq8M1tEJE5UIAsVXRqGlGWo5qWFk?=
 =?us-ascii?Q?ADhlQN3kPZ+td2TshfVYNlNQB+3P/fAgqW6068S+yKKQK7utYqS0/bSIaqay?=
 =?us-ascii?Q?auPF+2zlCM4xqmAO005NycqGiPe0cdUHLSGymwMZWF5l2KFdKaEGQEThKNOt?=
 =?us-ascii?Q?E51sZiE9dWU0QYqHbSL7WmTViZ/3uR+dQo1KJyYXbvoUgVFVtUlLy/g/+3j/?=
 =?us-ascii?Q?mbXuQQcca79UapJnQotBxSQahhygLMXAeW56kStRuar82U2Yox1SKkUq3ODK?=
 =?us-ascii?Q?/zJFma/zfIou7FBOAPm8T97jKQD44oESqUmXbpiGuxA2LTbWgSO7sbdoI9Jm?=
 =?us-ascii?Q?JKvkOCycd3wFfOyPV18ES6GD/EfneUrOlzacc5XF/8dK9ufA59zPtBmF7b5O?=
 =?us-ascii?Q?RshjnOYlktZiW5lr/w7cZ2dWtsKoXCQuVN4R2LkvsAfGDBwITQp84iU8GsMK?=
 =?us-ascii?Q?QWLY5tPk6CQJdSN7DdG66bBqjfP8oDr9+abf5uIGIrjbS7hNl8pD4oZhdVZm?=
 =?us-ascii?Q?NRgaJUfKxztC12vntkZ1IJTYaLSwHpEZ+cF+oNghHgkwopn2W/H/tCmEgPuY?=
 =?us-ascii?Q?qOOJysODAe0Fel0q5/Ty/uq/F5nLYSHeVaAbVZBHWMq8x4Rz43bA+TvpYFtO?=
 =?us-ascii?Q?Tin5BolSRF+rYvL2uWjrV/6zeEt7E+/1RQ9rE1DBArV3jKnQU4D+s008iL6R?=
 =?us-ascii?Q?2xiIn4/UniRqOmM+OGGW4mgMNJH9rT2qkTIAfgxZdgoCzPA9AQS3JhhNiBe1?=
 =?us-ascii?Q?OA4lwOA/TzDZ72WzmHCxLAJt+uH2shfuBrqj4/DYpDPSkanjXe1+VwKqQTs3?=
 =?us-ascii?Q?5nzVFgZUJkiJNBr7jAQpOi+7YxghwexCn6uLrVLAH138Dy6QSEwcETTQlEJk?=
 =?us-ascii?Q?rlAxYdHWZJWi5Dh9wyyLWBHHIPRSHx5QBQJovkm9IxSd0rXC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1868ced-e451-4fc3-a678-08df39d730f3
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:20:51.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKdx518M1IcnWqmrD7UKjLYXb0sokx+QThkbceBKKEx9k+x3Na0GjMJLyOBgwi+5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB494755

On Tue, Nov 03, 2026 at 12:16:16PM -0600, Bjorn Helgaas wrote:
> [+cc other folks interested in ATS]
> 
> On Wed, Oct 28, 2026 at 11:36:51PM +0000, Danny Gonzalez wrote:
> > Enabling ATS allows an endpoint to cache translations and initiate DMA
> > requests with Translated addresses, which an upstream bridge with ACS
> > Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
> > Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
> > firmware, a kexec kernel, or "pci=config_acs=") without relaxing them,
> > PCI_ACS_TB may remain set on upstream bridges.
> > 
> > Add pci_ats_check_acs() and call it from pci_dma_configure() after
> > pci_enable_acs() to walk upstream bridges and clear dev->ats_cap if any
> > bridge has PCI_ACS_TB enabled, leaving the endpoint to use Untranslated
> > addresses.
> 
> > Tested by booting a machine with an endpoint advertising the ATS Capability
> > behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
> > system boots cleanly.
> > 
> > Signed-off-by: Danny Gonzalez <digonzal@google.com>
> > ---
> > 
> > v2 (based on sashiko review):
> >  - Move the upstream ACS TB check from pci_ats_supported() into
> >    pci_ats_check_acs() called after pci_enable_acs()
> >  - Use pci_acs_enabled() instead of reading PCI_ACS_CTRL directly
> > 
> >  drivers/pci/ats.c        | 20 ++++++++++++++++++++
> >  drivers/pci/pci-driver.c |  1 +
> >  drivers/pci/pci.h        |  2 ++
> >  3 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index 9cb23780093d..0395612f3987 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> > @@ -31,6 +31,26 @@ void pci_ats_init(struct pci_dev *dev)
> >  	dev->ats_cap = pos;
> >  }
> >  
> > +void pci_ats_check_acs(struct pci_dev *dev)
> > +{
> > +	struct pci_dev *bridge;
> > +
> > +	if (!dev->ats_cap || dev->is_virtfn || dev->ats_stu)
> > +		return;
> > +
> > +	/* Do not allow ATS if any upstream bridge blocks translation */
> > +	for (bridge = pci_upstream_bridge(dev); bridge;
> > +	     bridge = pci_upstream_bridge(bridge)) {
> > +		if ((bridge->acs_capabilities & PCI_ACS_TB) &&
> > +		    pci_acs_enabled(bridge, PCI_ACS_TB)) {
> > +			pci_warn_once(dev, "ATS disabled: upstream bridge %s has ACS Translation Blocking enabled\n",
> > +				 pci_name(bridge));
> > +			dev->ats_cap = 0;
> > +			return;

Isn't this pci_acs_path_enabled() ?

> This works by making pci_ats_supported() return "false".  Can we do
> this checking inside pci_ats_supported() instead?  Then we wouldn't
> need a new function, and I think it would be easier to understand the
> control flow that way.

Yeah, and I don't think this is great:

> > @@ -1713,6 +1713,7 @@ static int pci_dma_configure(struct device *dev)
> >  	 * quirks.
> >  	 */
> >  	pci_enable_acs(to_pci_dev(dev));
> > +	pci_ats_check_acs(to_pci_dev(dev));
> >  	pci_put_host_bridge_device(bridge);

We shouldn't have to leak these details outside the PCI core..

The idea seems sound at least.

Jason
