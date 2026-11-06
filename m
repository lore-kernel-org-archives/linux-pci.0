Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793987402;
	b=QPOMmNUoOjQO4QBKKd7MM4NcMUog5r8o86QIEfA8o4Ff3BoXZK6Or8Abc9ntO3bv5VHO
	 DkeY7f/YTcYzAQZ9WEzIAZxxYZD7LBrr1UKYp3vI7gZDp1zH5sMe02OexuIljnZN30ZO2
	 LOnkK/YtSfD6MiA9XiRYOXVqOhIhDXz1JWQ1OUSreWpMd/BnYFKinwakbXRHKuoYQGeeq
	 zPoHy2vKaYuep/8RmkfRu9LBqkhuRGVW5mUuqa9IThk9NO3/jOCLAOx+scaZ0o2JJkAhW
	 0ooM+GtLbh9cwYukEhdMaPfpSwfDXoKhxZAi6S/6eEnot/ZmDU3ggR9lP73enQ6FiJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987402;
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
	bh=wh6JBMtqpGmEQGuhuOMkb4tcByk16v+yqU4pTwppxTs=;
	b=dq4E/Nhkc2mPDi3q6Q/LBnusyh1Fko1hW45oOhsCid2EUR2inR/0VkimYunsR5Xaahdj
	 6TP+RrBioveXv38g0YzLcz78cRq0Kr/Ig/oCXU+fqnZ8BQ7FwYzUA8fxnVfwiXcFQciEF
	 hVhclSUjBFLM9ObrBWrrSb2Eo7t40ZwIMRpuOrBGrgtqfj2iAh9jPqn8u5pusepRRnGiu
	 0cjL/scZrCqX8Mos3U2w105HBIouX3jx6QS0/ux4B3BDcIQYIbYzZGqdqhI72Tc2qXBCo
	 59wCI5bjkdRQ6RglIOq9GtSO6iYISNjpg3Occ4jS9xZkDC6s89D/CBMAiRlX07fb9HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EgDHmcP2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.29
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC7606A326;
	Fri,  6 Nov 2026 17:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89EC7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EgDHmcP2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn2o1OFPkmylY8ZXVVEcEabl5IvkckJ/Yd46ZPWjvSb3cFlMxT77Vs9MAI8Jcy+kafV91vXt/7+e0AyxZPc80sUOqRnyBRvpFuUDgvdEg1I+HjiijhiMrKZjwFLVp0ICqi2BpmrTSxnpLImmRgCPRsDlL6y0jujQgsV7XCiB0qwpTHkHpRQfnSn99+YSG7yNhJStbZ6pWZbrjY1Sw9DcIUqMbAuX4eaub5QuZqYuuuBFTHj8UyJKkXivrI7E810U77o/SR/Py2hizSqCnDa1xntWPDz2Ei3GlBReP7qnWniwdDf+IwdXQndtuXyTJHyGxuQPHSIB6DWv8awfPIHCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh6JBMtqpGmEQGuhuOMkb4tcByk16v+yqU4pTwppxTs=;
 b=zJ5T5FKGgs1n3GoXDTyBV3CZEo7Y7QMwLhUijfiWGR0N/IjlgnHsH3IRi19/kDvweNFP9GvQE1OWYwPwRBHtMwEmKeKGcTzQ3IW88ZPysC2aK3q9jhulc5hy3i0aU0cysaSFrFA6isqKORsprQBLedzxVjZT8jyHH+tdAybR1MbnsTG7KMbDiAmXm01bGTK0OfSPZZEQHUlLB7RE+KZq4VcNE7EHrxhqHXiemfspmxYQr66r+81HjmW2r4RkqGd/7bD5mRjvj4OoDxkvH+5otWqT/susgzucvN/vy37RlwZAffF+CqXc8+AxDIXAAv6AxzIZjHUMBrN5cIU/875FiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh6JBMtqpGmEQGuhuOMkb4tcByk16v+yqU4pTwppxTs=;
 b=EgDHmcP2hoUeFQCMJG/QY+Hn81TEH86m620zLY4g7KChZCa2sarIE2W/zO36dsrvJBCp184/f28Azdal6bEh/7p9PLZizacocdsWynnZMt1ifUgrfXIQATusWpQ7Fg31RXGi7ktbCKKd/3QW39Ft+Ws2N/fXSV+iEzhAWU0RTyVYRc1wvsUxP0xq/4Pg3g0Z1WPC6SffmqfkmuT57uhaWYsW2MKcW2UT57YJ+G/Z/J8DsykjcIhNlL83/lSxp8jhKvovjHh3pOcEpUsqv3TOeqMhOSfj1eDPjq/mBsCdJmqo2wPtoBJEU+3/E3JkU6cVFH6Ib2MebPH4y7/cSwZXAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CY5PR12MB9056.namprd12.prod.outlook.com
 (2603:10b6:930:34::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 17:49:57 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 17:49:56 +0000
Date: Fri, 6 Nov 2026 13:49:54 -0400
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
Subject: Re: [PATCH] PCI/ATS: Disable ATS when ACS TB is set upstream
Message-ID: <20261106174954.GI770409@nvidia.com>
References: <20261020181053.2646782-1-digonzal@google.com>
 <20261105230412.GA1450377@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105230412.GA1450377@bhelgaas>
X-ClientProxiedBy: CH2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:610:58::18) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4c878a-07c4-43c1-a773-08df3c2e5e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xia5MAaDR48W6xIvQjdHLQWUj7UbZfsn2R7BdeQfXjmr8pzf3WTfqXUJMPp/k1IROO5CwlxyA9zuEme98Flr+gvk1AYqKRYuCDxBj0cQc32gMZGlKHKnZ/PyU2tVaCggM9hk4zCPVVc8XI4WcNi/W+fM11NkPVVviqseT+wGy15dN2H9+a7fwKmwBeTDOgbxqCfAtMpQ4AML61wMwxdUde4mXOX3paJ/TK0pg3JJo8tIbjeJoWn91LddtKPbE+CL3jCQ73rvVerTG3ThFbleDjof34qTahStQomvDX8G8J1LNCO4EXV8mq4h5qGO65FgnFl3q1NiQJEZsddAfNJFtswGoQgmJhryFrdiCb3luskVBV5a80nu0GQhFmsWkR2NeAIV8xDSxtQNDUD4Ycve4QmbfygjES39J+FzJGTzmOa3cKdNj6zyPikMZHdYv/Zmidrg1q+AkDbZlJy0JxfQn97OzRC+a8w2tVk2gPtjhFwoCE9xKkfvJDvocQNEpHrw4MKQdjp+uwOCEkirE1+W9uA2M9cDmLImUfyhd+eacZNtQT1Qw2XrrYBXTOnQ2vIMCugXdin86qwtx8ZXFnZEjuV+rbbtnq3X1glsWrzBOhsJI5gJEEG5PS0N6sV5TZ/2Nd4W4Xti9k//sPywxVFGoRqel12dm2m4x6cKOQWyT9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LLElxWhhsQIbLNWamCbYYMbjYOueSrHgs6Ag22pWpXnLt2rcywKQ+w4arCGb?=
 =?us-ascii?Q?Mwmw4JdP6DkyVO3q4mhj3In6n+mLfCtIzuD9ASFdIlEpi948WvRbVQzyNrV1?=
 =?us-ascii?Q?BWvbqK3RzIPogWdvWhvrcE+vfh25G8/HRkKKki39Y33Y2NQSEkxSNiS464ea?=
 =?us-ascii?Q?zhTS8b5Z6BAaeeydkN6Wt9SPbdVKxjHqjiJ1uA6d2Nhh37ya3xdZd8PnZ7p2?=
 =?us-ascii?Q?+cPQomvWt7+PC3u2+R3RcBQtmYQdrPwZ0qkl11KDAwNZ8M1Ked2ATNQ4ERnh?=
 =?us-ascii?Q?6ls4OKRATc+6Bs+H6tNuQPQHZ1PA7VZ7GHa+CKYzO7FhO2cNwdfcr/u/HhFS?=
 =?us-ascii?Q?9QjFBsdRnCr/zIxL7YfJNBBfMl5W4bri1xcFYArxBqbyMB3cUC8UEzLytPHY?=
 =?us-ascii?Q?vAAinne94mg7Xf16NYnXwmFUoriPJVQIO6gVTz50sHs15ST5atxAMq3sFTn+?=
 =?us-ascii?Q?VY+QKQR0xhhpPkA/0Zm/u6vQHVOcD7gn6gY83L3MtPpRbofTnx+eVgqtsZQK?=
 =?us-ascii?Q?PwE8FIH/IWfr1rZex3xbGuditNEjNHfqx5prgWDExgWn3Mvf8noU1w+O4CiO?=
 =?us-ascii?Q?gToaVb9D1BHo1iqKUaFzOD5aHOAJ5kB40gCDPFNxaku1AieBhroj2xb1uiWr?=
 =?us-ascii?Q?AsCceAn5LyKbcchq9JSf7GD4xoGQVNswXnAtpbGhOvHdlPUxA7e5ojLI5Qts?=
 =?us-ascii?Q?DoHxfrrxQOmr6p4CxKzX+qJZNmwrU2VrFQgIEu0/5FcqFLNx5fYfSREtqGn2?=
 =?us-ascii?Q?mT3Nns2DjTEv0wwKuPqG1buKG8p4YQCG14EomsxnVDNSDebbwox02Kvm8C9t?=
 =?us-ascii?Q?TSzqnyBhhoTDOXw/JN20KyGXAbY1YpJtWFxY9gEBlWu/8r3UjmkW822iNxPx?=
 =?us-ascii?Q?RhFlslY0f8NjZ4xkpDkZyBy+pjXC8EN2VCFcfmMqEJwiOLJsX0lv5a82rDz7?=
 =?us-ascii?Q?zT+ZntXhGbMGnOBb2Y3e8zrqcWvbAkflprPq1zzY45uNEHXfGst7NhrAycoV?=
 =?us-ascii?Q?qD6AEXn5EPXIE7yrnffkb4+/P673dxsmxkCj8eHTaGwQfWxD4iMJyFiMrze/?=
 =?us-ascii?Q?+Dykc9AVWdtNSqYT3DZm3HvXG/TSWpRXcpmTzkhoghBb9JZlR076Jj0mH/bM?=
 =?us-ascii?Q?kVVyNfo12z0p3zJqv06z3I0Mo4lXcRaoq/Zpg/rUl5FC3jPsQwZvBsAtUj1w?=
 =?us-ascii?Q?rHPQTzDO73hnsi56ix9Y9JNt1V0WGGuADyH4unclRJ6X9yVhWpZU7XmidLWx?=
 =?us-ascii?Q?J4jgnleU2yds8HWp8GGKuPuuILtTv4PWD/j6hajHYcSyd0wOCuvJU/8J6ZTB?=
 =?us-ascii?Q?yt8g1KBA6vORuiJqKew/bit7rzXm3kXq5zVeJMMz3AanmwI+eoDelWWE0p54?=
 =?us-ascii?Q?C3wKx7qKYshlnw9sOeoToYxD8TDZW2MAVbkne8Cm9Ab6KbH+qH7Be2zsQClt?=
 =?us-ascii?Q?Dm2WbmdPzjqQ3XbCeLRR5qcxX4bxsAAW04kEQqQlrd8jQJhwGXKFpwPwnmPp?=
 =?us-ascii?Q?T044fImewe7OYuKVCPzqjHzQ7mCAuTeh/zBfXx1pJ2BjSGBKXHYvUfstnAWt?=
 =?us-ascii?Q?htz2s2gz2fs9sZKAtz2yXbBSdyro3jl7AtoM5vvou5/u5yKMWh8Vt0ozP8c3?=
 =?us-ascii?Q?mj+/up9/283FQYr/5RJTKv/ljbq42w3exdWc3B2iUyw9mikat3OiPICtoiKh?=
 =?us-ascii?Q?rRfktyZqwulR1+fND7lx4ajEl7xog0cHfurG4xooV7/3UXbd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4c878a-07c4-43c1-a773-08df3c2e5e64
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:49:56.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBKgKLVUcoZuWMj5V1xz8ztVV/9o5kqRRbf2Ivpnrcur4slwhCF1Uj2IhE84MP8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

On Thu, Nov 05, 2026 at 05:04:12PM -0600, Bjorn Helgaas wrote:

> > +		return false;
> > +	}
> > +
> 
> Sashiko also noted problems if pci_ats_supported() returns different
> values in:

Yeah, I share this concern, if pci_ats_supported() becomes dynamic
that is not how alot of users assume it works. It will need fixing
first.

The general idea seems fine

Jason
