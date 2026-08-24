Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89524369D51;
	Mon, 24 Aug 2026 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602549; cv=fail; b=f7duJEKuavDAAOvLKgPHgBh0GsvK/DLM8zM+JmMS0zNxHMyIUFwpb8bMI7mIphTve+u/GK/K6g6ybmZqLJH8N31xFZ13+w6trYYj3V7WkKf/SZV2kd4OxPhgPYd70C2XIybAz/lEnxcJsZitbfDL+LRF3soMc8zVI4X7E/oDVJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602549; c=relaxed/simple;
	bh=UIY6Ugxzsd+AF2KkUKRUZtz8CYgvhTzrHGi3rEijFiY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WMNW45m0fPY8My6ZaZRcy8IAa89W8HeA/60uQxp5CocXclAZkEh+z2A/gEJNIaa1TZVNA+GUZ02e0LGt9+tAtqTg6Sg6zS+5LLo1C5X423+/NjcvvcSHdJHESG4Zo3Fd3JT/H5GSYN0DWsSNKohlOElXlF1tJXUMo6QG+V0HUyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miXgIE9y; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miXgIE9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787602545; x=1819138545;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UIY6Ugxzsd+AF2KkUKRUZtz8CYgvhTzrHGi3rEijFiY=;
  b=miXgIE9y2CviVwZpfbRiyE6QyFbsEFMNXSdQLtgtklU99wNPCMHKnhRD
   Y3bMbTnIk8Af/TcN9wVvXJHs5ZGwmL/vxBerifFv/pcz8eKhdN3GKVOp6
   qYQ6ZJmoFa49aTFjolZ6/UpxpCR9i4Dl7ZmuNPKV8yAe7estze+WlRriG
   0SnQQgRf6ThMIJ2xTGynInhbjKrDrOKvgV5OOUojhYQ65dLS8kcB8j/Mu
   o3XvHTpMx23ASZ7cgl/iHlBPPRny77gBCJPgnDegkkUTK5s7lZV/qdyMh
   /MZ+NNj8R1f341WaYu3jX7xcsXJA8S8t4SqHKWKIg5vd6gJIBxpdfXq4K
   Q==;
X-CSE-ConnectionGUID: RNHex9WTQLC3oXzo00s8oQ==
X-CSE-MsgGUID: bgQAyjewRXONXbMgDNGL7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98400857"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98400857"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 13:15:44 -0700
X-CSE-ConnectionGUID: BiJBqMScQ7ewItmktr0nhg==
X-CSE-MsgGUID: ag0q1u4uT+ycAjADiylwrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="263364457"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 13:15:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 13:15:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 13:15:43 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 13:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwUGRp/yub2p4PBTYaOx/YtWM3XpDSqYxJK7d8UPN9oZu6+118VbrQquiz/EkFRhj7q3FsKM+IqshzW46ECj6a7XQNL5ZW+bWKlhGmaCJXDl3gd1yMS7ukwieKITmSX3TeD2VZT3NssghIgeVJ1R9PbdOJdad+1bR6cSEwniidyxBJ2tdMlRaErCGlRJuU1XDfR+tlJgvAN2VDE0lQozEzfGYkHIQL64yJyCTpqClnXwGXtkMlwjB33zwCFZO2/QZxVOGA8otlPEHultiXcfkx0QUBoktJpepGQ/TKvewVotHOL34+4+JbssnqI63mWmaX6C94GyRdTwD3U7zIwqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6qBeFVQlrLHDvUA0rzM4xklIwtqGl0I8pJBFeqDmbk=;
 b=ggX4HBMOYXfMocqYg8aH9PWretd2J0FpvrG1lyjVnGV/RlDxtcPPhdlmsQ4Fhf5zJ6/Fbhsm5thUgfp46Quue0Xrg2kfW8mJyBcJ1juzsEt7b4sBHfjvA6rHIN0W0bVMz460ldkUqTJKLzhWproPuD/lmDmhQGophhKsbaNZRwYMGRKa32j9+hqIQeMNPp2IwW6KSYgDcUpbSFlghvdVhwRsH2t/mbVTW7/3lIpb5h7iGfqxIW2SJvaOXCMZ1MJtrkMwBmLRDEwlgwMfBtt1iGsxDydNDAtxPRSW4IuebDcM+LeW/Pu0Xm7DmX6L44MmfX5NDjfVH9fRCi3LfE8OqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB4918.namprd11.prod.outlook.com (2603:10b6:510:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 20:15:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 20:15:38 +0000
Date: Mon, 24 Aug 2026 13:15:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, "Natu, Mahesh"
	<mahesh.natu@intel.com>
Subject: Re: [PATCH RFC 0/7] PCI/HMAT: Describe P2PDMA reachability and
 performance
Message-ID: <aoymZhOaSCG_Tsmj@aschofie-mobl2.lan>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 8126bbc5-c223-42c0-1267-08df021c76c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: ip1+Ts3wE5x+4Xx/Vkg6H1iTJEgqfcfe3GKnVLiSaenNR5Nytjd+pcNiZ2UVNH6k66OGqwGpuusOErQ6Z+d577u3nqoHVdRJKbUpfEbSD3Eh4BEsd35BQ89DCEKEYZKDngaFElW/owwKjVJ90X0oEYSfCKK5iZ88TnikRNcZWK8tk4pl0UeOrtuA2sjiMuprVfiuwQijjO6OeCfvUjlegeysYiY6+iEsJ6wZduD3sBrLQuGTyk03cwnXqrl7VYgNvYlO7uVE8X+SMo6W3hjcYVISBysPJBtwz73z33qqVUMk6E4W94fTwRadyXxiFNHLq8p+sh6fqz3PPCubGaKeQ0PcweXcKMTx7jPZDJEedjTW2JXbZEA2EfuXZnmTmoMi2k1ZyENj2xpQYpRg348Vd7F8LkgogouoFVfeOOare8xXy0CMs+U21xnURi7bGS2LEw4/MDuXhHmGhfycv5VYtMJzTdRBGFRBD6fdAaXxGaQi2ezUPm8KpyE92G1rCHy5ifI2LsBwX3du2I0T21tepj8BrqaJ9mNCjHFJz9mj7K/1kT6N59qBSY1WhTe0/YFuS9whM8YRjYObFAVjNz9PEJF9Sb/Y4WlsAuxekkEYH+IxnLIo7oow0hSXsLvkM7JIOxWC+TSp5tytpnq8u1iHtEz9RF2chru7Ke7yiSN49Is=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Qc4kFe0sgylvI1gIeOYya3XURHVQ+KSl2cvznTksulZwLh99d3GFSdN/x5h?=
 =?us-ascii?Q?j3eJfgfkwrRlcgAkUC2Jv0F9HkWWe+aYphiQjMBZ/E7h8hitPUsECpRUXfiY?=
 =?us-ascii?Q?LplYGvHp9CzIWhyhqaRxFLZMRVWw8A52S+jLGiL1e9vhsR3m0rlmj8ilTHHm?=
 =?us-ascii?Q?fbt1Ka71bqaYlO/EwqVAYBrKfVsf2eQ7Knei3WU1gS9QQ7ON2x7LbKhZpfne?=
 =?us-ascii?Q?nXS09YSaSFKugnQUKKBS+vXvpClG993a+7qBCd/PcVAd4/EfC56oC1cO/0NB?=
 =?us-ascii?Q?I059GshojaS/Dajd8Dp1PIZOFXjXK3LIyQ+qe5gGgEf1UUmls3okDpFTw2Av?=
 =?us-ascii?Q?Mi5O7FVyi+WUtx1Kd1lqrdJ4jDj8zmAN6oxZTFijYfboBXqwVQZQU7xGEFAG?=
 =?us-ascii?Q?TBnFVbGz7x5w7Kt6RsprLwC4O2dcN1Rb9Lu/IzuTi4o6kkBwWlgkBQqRAbv1?=
 =?us-ascii?Q?JBn8JgfCS1yU0MVAGaYrabDpUp7QDUH8Y1HSIPuDHfCrfKa5BR031vcG38Nu?=
 =?us-ascii?Q?n0XMRIgxnOQoTKktLESXdnkikGItlTBThlF3cyf/KeDrJTGGLwjbfB95EBTj?=
 =?us-ascii?Q?9HhfigWrCBqlzIrLos9yuW6AICOD+NUbXf+MUT19m41LOzIwuIicZpPJWf14?=
 =?us-ascii?Q?DSBLcFBQJTqd0oW8Jg8DRPawiRJZYglOFwVTbklqNzIP3Hx+bswFQaNcyZNP?=
 =?us-ascii?Q?tbeNIwYEb23jWcbvNEBG8ViWwes/DMszNoZwl8ObJVqKjbe6+Q6BAuQyaxAV?=
 =?us-ascii?Q?wWZFQLmdjuWUokVwlmunOEl9EoUI2TwemrWdhL6GMopi3Ta8FKha6kU+arZn?=
 =?us-ascii?Q?Dl0NwceuQV/YfCjhc+lImHX/d9xawqusEeqPRaWAHm87pEn9jnO0KTUwR2JO?=
 =?us-ascii?Q?bmc5rmH5Mzd43HuryKn4TwNtArPXkwdLdsgbd80uURToH7uXQ2R9X/We4unj?=
 =?us-ascii?Q?vQSCdhMjmC7xwL+oTxmYrGz4N8JMUUHMV72NeNj0Qy8fcd89eOUqO8yJevbA?=
 =?us-ascii?Q?K/MGbF1qcl2yqUhLPDa6oi63EWIdXm8a857FKYQ8z4hN6DcY+p1VuHvHXj8k?=
 =?us-ascii?Q?t1L4wdJ35zrbo5UaLJJPsLed961q/YcG4qAP22bJn1JcGXdb+WpTZS8OOw0r?=
 =?us-ascii?Q?01UREh4J4rqNmwQj0iGl58wtJSdDjyrxLVNxqcctxT9omzYxOEKqK9bYiTX1?=
 =?us-ascii?Q?q29y/xt4IgVZqfS7BGFbLyiWOCW7tqdpI+Sq+CVfuGJDCmbW4XSciQL6NfF+?=
 =?us-ascii?Q?zfAFP+5iQdXiTpVdzH6WOFYYViBIEvnce2MVXpRNUiLPgfEvEvEA1dJpsvtT?=
 =?us-ascii?Q?5qXE5X1d8pmIRLtd659tuaGCewUL8zdQioEPjNXOJIhZlbjqQv+gG4gJn7ap?=
 =?us-ascii?Q?DG7yvRVHSWeToBrhVbsswNj/jNKrObp2ixrCqqPt9NF+omWY4B9Y7P/LFplh?=
 =?us-ascii?Q?lddmuiUD9ZSIarM6ZNxWc6EQCWHFR08ckuF1Cg3213O2Ldyipkug8T1iTpT0?=
 =?us-ascii?Q?P7DCoMAc4dhrwAKYr39DLHi60/fNRi/IjtIocyJWRZVHQWOegJcF71W2/Dih?=
 =?us-ascii?Q?s+dpHedgUj3SSSFtPb9euwL3L2Ciu8yg+dA3YImNN9sR6xUBOp40/r4freD5?=
 =?us-ascii?Q?eFGIJ+xQ3NaBkN8d43dDJSkdPmr9VZJEt+9kR/608P53lYpTALf6Zz6EpnA1?=
 =?us-ascii?Q?f7biD3TeRjEG7U2XFrpNLxqylxY0LoXx3hB6MFAiHZSdH/+8rqljXokqsT/U?=
 =?us-ascii?Q?oiutjfOonfEofYr/2HP+wGwhVH8e5as=3D?=
X-Exchange-RoutingPolicyChecked: wVU9dHf/FlFDQK1IcpfshRP4sXNE3ESrAvxDXIqxm3dJWxIJFtjng7SwGVsabnRTa5Ty70hfH/NyIAnTXBs/5ecuMf3VLJLjJeY8HxvpQ6OMFo/BwoMlQ4dQDGqP+lkgcxevo6yWwyodJRrG0U9l0k2pN0fF9egm44SY/nvvLdqSehy9ZgWa4Z86vDbZGk6+byhzaNYF9uqmz5jZ0LYXU0/HGZe1TwjMWdbxfFYW0mgvOpaCQOZLwmR/YHB54PjomVcJYRJmHsughOk8y4Pq5VEi3D9Mw/v4u/pmd8Y2VXL9O3FdwkYU0pdO8HGapgFmtWvIarqqokV1lW4MJoiPjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8126bbc5-c223-42c0-1267-08df021c76c6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 20:15:38.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfdwU3n2+My1W+oLTB72j6uL93CdOIzVegDUp1xU7XtepYLqoerl85tKuG2hi1CboBIo+9JiJe4VJzTvQz1klGWAW5Y2JetsN1QUhtCKRLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4918
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 10:47:37PM +0300, Leon Romanovsky wrote:
> Linux derives P2PDMA reachability from visible PCI topology, ACS
> configuration, and a host-bridge whitelist. It cannot describe conditional
> or slower cross-host-bridge paths; passthrough can hide the physical peer
> relationships.
> 
> This RFC series implements the proposed ACPI HMAT Type 3 extension below.

Hi Leon,

Is there an ECN document for review alongside this?
I get that the table below is a snapshot of the expected change, but
would appreciate the long version to read.

Please add linux-cxl to CC list on future postings.

-- Alison


> Directional Generic Port matrices describe reachability, ordering, latency,
> and bandwidth. Linux uses ordered paths to authorize P2PDMA and their
> latency/bandwidth to rank providers. A VMM could translate these matrices
> into guest domains; that is outside this series.
> 
>   HMAT Type 3 structure
> 
>   Field               Offset       Bytes  Meaning
>   ---------------------------------------------------------------
>   Type:                    0           2  value 3
>   Length:                  4           4  entire structure
>   Flags:                   8           1  traffic classes
>   Data-type:               9           1  metric selector
>   Initiators:             12           4  Generic Port count (s)
>   Targets:                16           4  Generic Port count (t)
>   Base-unit:              24           8  ps or MB/s; non-zero
>   Initiator-PDs:          32         4*s  proximity-domain list
>   Target-PDs:         32+4*s         4*t  proximity-domain list
>   Matrix:         32+4*(s+t)       2*s*t  directional Entry[i][j]
>   Reserved: bytes 2-3, 10-11, and 20-23
> 
>   Flags: encoding
>     bit 0  non-UIO
>     bit 1  UIO
> 
>   Metrics: selector
>     0/1/2  access/read/write latency
>     3/4/5  access/read/write bandwidth
> 
>   Direction: Initiator PD[i] -- Entry[i][j] metric --> Target PD[j]
> 
> ----------------------------------------------------------------------
> Based on [PATCH v3 00/17] PCI/P2PDMA: Fix ACS egress control handling
> https://lore.kernel.org/all/20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com/
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Leon Romanovsky (7):
>       ACPICA: Define PCIe P2P latency and bandwidth information
>       ACPI: HMAT: Make PCIe P2P paths available to consumers
>       PCI/P2PDMA: Authorize HMAT-described cross-host-bridge P2P
>       PCI/P2PDMA: Prefer providers with better HMAT performance
>       ACPI: HMAT: Add KUnit tests for PCIe P2P matrix semantics
>       PCI/P2PDMA: Add KUnit tests for HMAT policy boundaries
>       PCI/P2PDMA: Add KUnit tests for HMAT provider ranking
> 
>  drivers/acpi/numa/Kconfig     |  13 ++
>  drivers/acpi/numa/Makefile    |   1 +
>  drivers/acpi/numa/hmat.c      | 245 +++++++++++++++++++++-
>  drivers/acpi/numa/hmat_test.c | 223 ++++++++++++++++++++
>  drivers/acpi/numa/hmat_test.h |  17 ++
>  drivers/pci/Kconfig           |  14 ++
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/p2pdma.c          | 300 ++++++++++++++++++++------
>  drivers/pci/p2pdma_test.c     | 477 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |  23 ++
>  include/acpi/actbl1.h         |  27 ++-
>  include/linux/acpi.h          |  26 +++
>  12 files changed, 1298 insertions(+), 69 deletions(-)
> ---
> base-commit: bc5261fca94dd94ab557cc0852ce465d9c3ab8b0
> change-id: 20260715-hmat-p2p-eb4971a9d731
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 
