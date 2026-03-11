Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952E3D9031;
	Wed, 11 Mar 2026 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231172; cv=fail; b=q1hBB11yqBwI5QcmP25hEw1+RfTJsykjjsxQB9OrSRjx4r0cCYyF0lvR7LN9VpDrYGXu9xH36EN+zWQ0e4ftGjo+NuNjtVR/ivcy9osUgJLD/0SoEivoxo8FmH0WDrhoHn1JS8kBUkLm+oKpE2QsF26Za3f3gGLlTTTZNg/3iQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231172; c=relaxed/simple;
	bh=uA51hBfn/OTxh1qsd73ltxI8FP1ubLqOaPbcdcthAtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s6a2hS27hNMT3eUqfAncMB1oCdEo6KWgQwDH2MjrvATw+fEay50AZs2raiGc8GnuNucLeO9CoouxhffhiEUo9tP1zfmfg34GPUEDqcEvfZVKwcegai1e6gMJjKB+96EKrM0j+Xvkfry62otuauzB57qsJhOp9gzI2tfLrtJSDos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LsG+t0WV; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LsG+t0WV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATcxFyTvfM7Qt7+dmuvhb7+3xXMu0C76Dgbi4dPrBpHfvm4jQkzgnC0G9tEaMzDvjV98uiDdfFQmFPGOp0omEu/v82TsNlUboSvNrPOxxZ4IvaUcdudp1ZQnJbz5oS28tkv+/Ga3VFhkrPswPNWCRpawRpDJ7t7GReGao5OnyUilF9hCiGGJJdgET7wpO9PSZOICdyHrZ60XFpe1NEeoUNmm3L3oeO/UFuJ3H7gB1zjLSVkYtrP7t5N65jFsqUqwOZk2eNTi7H/3XvyM1WuXxkGMJcR8PONxmh6efZKJu7fPIqURU4VmuERDTpgH2FmGa+POEP46HMPloUgXBgF4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2gDYoJf6s/q/V5U46sslQ0SsM/qpGFJIiYvfT+c6vI=;
 b=qceJxYFiWxOMHYAV21LT6PNFhKM43i/i7O9Cc3IStdPEFpdrzK5QLFDwmcv/Y74C736QE7A2cU9M/F97jIrOD0IyXJlqkOdG8VJUTv8ZYvyhhPGucocvomDTUJcPcpU5nW10z6qiJJqO0pbYMjpfmNTk+ymtaspE43ez1V+/tMAs+FU4HRjHC2Obr4ZBNWfay7D9F4AyZKbIHJnK23otfCeB+IIrJmQJoxd10Eg+n75OrNFjGMjhcy4e6FsG2uGY/6bwOnsqesuqoS206q2fBzGSI1GqtaFiW1A80vKTUO8Br8FeZ/AR5CRP5byjW4WsjRevVpm1R8cNjBgyyFrbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2gDYoJf6s/q/V5U46sslQ0SsM/qpGFJIiYvfT+c6vI=;
 b=LsG+t0WVqqL3L5Ng5omWKunFfhfm/9SjzH9HdRCzEnb1IVjqMown/1UbDhSnUQj08fpLr57FpWQ3ExlhGkaULqB9xAQ83nKQtqnXDzHS7nNIcoCGf3iR4ZyqpYsDGxwjB+5RCSsNMScvm3Jz1aR/GBW25HpenJZ8vpOYtq6BfJ+OfWB0L6V977rkIglRMJlthNYZaS0XogV3/8GBmJNd2GsmDn+9VyCQJqI9AB2uS+8PZvqGkTscVfwqOXyLRfsiWKRAXvYyrQuOvPqXEinzNBqQcAPeK15TlyahfYqsSOV/p9Dh4aTd7FxUJFkXKvIelIlEa02ZnnlpDlQ5bKqzfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:12:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 11 Mar 2026
 12:12:47 +0000
Date: Wed, 11 Mar 2026 09:12:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	praan@google.com, kees@kernel.org, smostafa@google.com,
	Alexander.Grest@microsoft.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260311121245.GA1448102@nvidia.com>
References: <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
 <aasv1HYOKuuJyi1k@google.com>
 <20260306200321.GN1651202@nvidia.com>
 <aas0dLwKmZyL_iOL@google.com>
 <20260306202652.GP1651202@nvidia.com>
 <abB1VJ5Op24dMIog@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abB1VJ5Op24dMIog@google.com>
X-ClientProxiedBy: BL1PR13CA0347.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: a2261e5e-c3f1-4f83-e019-08de7f6781c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8BSGz26ska4CFkAQJAQskIYuzpFVZgzRTMttGChzMweD+jtrSnxTrPaxcPXeE8fbROh5eojEJjJ1LZ0Kqb0ru+io5jc4kSkFc1d+AqPZztxEofoqWe5E0P/TBUvUSmZVDDgm4fnc3lm+rtV/YdQPUSaFmDTP90aCaegn1ADRuL8uH3fwS0qg6J8tXCN83uwNQnFvXIQcLy6NMhYggQnhSDuhu1ZtotJOPAqmeuy9PC8ECMSqZKVgtEq1mqoe9tp+rkN6B+eKgP8z4hcPygytKJhwNOEhgNr9X0T2EUXGrPpOurp1r/NWOn3p26OgRsLRCwzoCZYPzAwSw0/KbvadPe40Y52hc7w6T4c3c1eSGh1RbVSMEa6t41G1mhJX9+Uw0jrsdLzVrmBiVfhQP9vsINB2zBhSm3J1rw5bd9+3uqVPCx/V20xAlLn45BMkoa021Y6gizYTp+UfcnbJSVfRnBiBVFbua/6f6nIYDlEK5NTzCOKyoRcEntY2NBputLL7ehu1rHDdfn6AzeaN6KO7dEww3jF3e11jMILL85iooGCgMvcuP9sYhuhPYvZv8nmnW4GXWewFAw/66oecVFzLYF/PIySPy+twiWPk5lHcXE8syR1oQAI1s8bhfV8D+m9WiQxbjNEi8cpkQxw33vpBCdKEDvteaQwjFev8yi2PB4iHBBhGAqYWSmfEwY8L9Urm+gCUHipVJj39TDYCxbuVAwRkaC6FYAuKZlL/tzRI3/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8QKkJy2QYCy5FS4pzMJwSkf86qasYlD1YbuwP/0tChW0XB9p455STNlD8ML?=
 =?us-ascii?Q?nchRgmdRsfMt2PQVlIxWwCXTlovao0jZzIXYjQn/D/wxLR+skk1KiCXTvM1O?=
 =?us-ascii?Q?W/ScbN4HUHAwgS0nu01k2cCnl7uGwPTy5CXcJbHiCWs8OaBjYD8+uGqdCwMA?=
 =?us-ascii?Q?Vvvvvo/2O/ZZXK8js4aHunKE8wx7PfDFX9j1xkQDnl0KvZsOQ/oTdqfkJ6dX?=
 =?us-ascii?Q?ctOc71WZNxVYVhDVFWzViRbnGFUL62rhCSjviyX53YIs7zIkww+qaGzddfgl?=
 =?us-ascii?Q?7a4BU3G/szrrYRz3Ji6IQMReBvt5iCYR6jeQKq9O4HFhnnfsXWgWlueW2XH/?=
 =?us-ascii?Q?ML+VTzQkdvCtj1cFgHphRi4SX6V0MMgt/fCtOHQHmQ8ADZVD50TrHrm5gArN?=
 =?us-ascii?Q?GwN5RSYotnM6vLvH04pHY1YQssV6bf6Fm4hgeenWICij7/sYgbuQmMdXY7oq?=
 =?us-ascii?Q?gjzwTJRqrQPZYAXc/vkQAFx23MwC5d1QjcXgh2j7DUEuQ7zG7ya8U5HGfcqM?=
 =?us-ascii?Q?5BfGDpwiM7GK8y2/LWoZLO2Hvi26DR9bkH6wD9gvizKG+icrN5U4QGTLSPii?=
 =?us-ascii?Q?wHoqcAJbOuD8RO1F1ewMtkpsDZa1f6AZ/2XEaIG/uehGqNxIhnAre4wpMKqz?=
 =?us-ascii?Q?sRKspyxTGnm5p6IaVFTS2ZIjA/mI31bAb78XqVv7izRdqiROQ2q8duvi2k1e?=
 =?us-ascii?Q?Dt0sZ0C3awfwGZYgxR7Di1Se4u/4Sz4FZ4umEtsLG8t7Vvy8pAohEU1qCCjo?=
 =?us-ascii?Q?0J0lPq91I3+4TP3duF0z+zcPsrR4LkICZQhZaCXXrxMOtylLxEkAkrISK15O?=
 =?us-ascii?Q?YzWqFtT03BMLFv5DTkWruu581wEr9hIrm5PrYY8rbvJHhV8Z9Wtprxan4XcL?=
 =?us-ascii?Q?iP2lpBRuZTqOOlvEUvMrgtvU/vMeDx8JhYyNbxXIJKI/EmyP537NMLU6F5DK?=
 =?us-ascii?Q?+60wGz1koKx8TQaOHAZedT1sSdO5AgDYX3OpQS9XalCgFBYTQLoWk4NalBKs?=
 =?us-ascii?Q?GSLvwdSImpWQ6OdKRPbYUmgE/6dNLxZS3zJkgIDQ3BZJVdOuCzXRNxDrHhKo?=
 =?us-ascii?Q?uj5sapoNQj8fGR95wBTztrSDT7/gD5JePZB/uwCD+k0odbQe+SFAXiguY2nE?=
 =?us-ascii?Q?eu3HlcjH7dHzB7k/6IHTVWgNzoJGJNiAz4w5TV9SIQi8x2Wn8483AY5AjBRE?=
 =?us-ascii?Q?cQDXj5Wv+6Thm66Z/vDJF5hUa1sWi7mU1ZgrfBkpKLUMyFWZMWayujOWLl6g?=
 =?us-ascii?Q?NTxccSLbtenB7G7ijKj1zIMwE3m58vd5AesvRcUse7f1Kzxv/fXnqEuV5Sa3?=
 =?us-ascii?Q?0Lujnk37u6NqSEN1ZdcC2zpNlEi8kcx/WLfkPRbqIfdmunmpFMsl2smHXdk1?=
 =?us-ascii?Q?craaz5rEUFcHnXF42asVPzOePaZLc8tiuHqdMzLhu2g3zLVoI/D6S2zBNGjv?=
 =?us-ascii?Q?pLcCqcnMt+3ufnTdGjCBgkbJ/stO07yVLotHYlZaarHKb2y4mAorPYudwJ8A?=
 =?us-ascii?Q?K6aJD4Xrs0V600CQSNTOzqKf41ySlPGsujfffN7ZjWkzPwl51X9/ltjR0g45?=
 =?us-ascii?Q?xoSj6b3N7RtWNHO+F2n+cae1g7OzEn+YgMthr+WKMh9o9vc1XhpzxImAw4Y7?=
 =?us-ascii?Q?vQChkmu9M1pP3PZ72qDBcJYSiz5Kr1E+TnDZZkqa0ElYJdnKV4rCCpmkloO2?=
 =?us-ascii?Q?6oFSX4XiJ9hZPNxICfe3bnRZDz7fjNhLAOj+SVaziyvD7iPXhvvmNx+d4O60?=
 =?us-ascii?Q?i99EPQe4+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2261e5e-c3f1-4f83-e019-08de7f6781c3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:12:47.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaXCOkBkQvZstrRCcGx0ce55ONYEZA/gb4qEJgAlKVlpSMRh66dXdeznVDUYcg0V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

On Tue, Mar 10, 2026 at 08:00:45PM +0000, Samiullah Khawaja wrote:
> On Fri, Mar 06, 2026 at 04:26:52PM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2026 at 08:22:08PM +0000, Samiullah Khawaja wrote:
> > 
> > > But do you think doing the timeout logic without fencing would be good
> > > enough?
> > 
> > It is what ARM and AMD do, so I wouldn't object to it.
> 
> I think without any back pressure to the caller, a device will be able
> to fill the invalidation queue with device IOTLB invalidations that get
> stuck until the HW timeout occurs.

Yes, all drivers have this problem currently.

Jason
