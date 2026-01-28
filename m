Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD29302741;
	Wed, 28 Jan 2026 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615815; cv=fail; b=RNfL8h+5MURzbAJpkLjiHSYZWYdC9mUCmVe3iVIk9Rz+Hg2z8JnsvVXea1Cx4Kh9gjI3mMQxrLwyANi40SZMdvyCHoiR3itBV2pkHg6OY7Mvkkn7oFuktGayxa71gbtq3DJwOR46ESCFwxVsifkmerazYN+iYCdkabFDB+cuzJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615815; c=relaxed/simple;
	bh=n8eNqzsQtfU6J0C9w2Vfw8Tpz3WJQvorrYxoKkMHtVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ndv/AyOqaB4+QtbXQYWfHNgp/6zlOLVE3Z16735kWvDN8jDhVf/9rYhaMrSjxfyJnQEaU3kxARGPhK7vmQ1aRac9Lh6AfsPbZucwbIv1Zte7wrXCA0Bo8W80hZHMHp5hg9j62X9eWd0oUCqLSwRrtVAlpFITXJmUWyaOknWbKTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YdKONp7/; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YdKONp7/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEOh1z/yMsDXf1D3DPyQ/qhAj7z4lJF1KpIs6hNoElQoPtA7404ptsSha10llcz8KcYh65JG0AcFiKxYV5O0aJV6jRbC1Dqmjr+3CsjP5BLTZSQgaVz1tZVjFWAgHBLEHcnWAKWPsHwlSS+vBFwsLmv3bCQkijAGkcwElb3Um3RPOSxiR8ykMyJJt/mdFpp18m6cSD+A3wPO9NdVnYfmuEgad9DM9TzM4eaRtRskF9Yluuft+bO+VotDs/kjlefJYIXhlgwnM0t8CskiFuyRQMKJOcQq/MuTnwk3YrM0lHiJKTEgshNe7Nmnr+xqvaj7FSBu7jES9+qORpJ+KEvmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luiJlEy81Oz48LYDpExN+qxVkKskXn0TutkSONl5aqw=;
 b=X6KeFU+fHwzZtvAtLpHgnzH7L0+p5F0t9Gmn6C17r8vAGVzVnrnfEJWSBSXdmGH29tU7uTYiDzB66HxOwarDfZKIEO6IMlCjnaKLwyjuWlOANRPr88u+XXXBtosWhEEC6rWCSZ44FSma9e/03gCf9b1mR75iMYJ1u6LdDDcoOYerlL/5Ho35AJhcuE5qNid/l3eRn23ng2EEzBEFSaqAVFYMbPZfUQbRnikROTAcEFKTyAlbyG22Qw6mIw8/GxWJXfh0JoZ/IOWApjOOy+GeS9hXlhr2C4HJyV09uWsSPd5DCjQ0Kh5BclfBOh07YE/Kgxo0W22d+JkWPO5jb+xWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luiJlEy81Oz48LYDpExN+qxVkKskXn0TutkSONl5aqw=;
 b=YdKONp7/+cP8eqzJ5B4onD+lcRiqQY1LBU29ssMHovJvQ5zQPaSmtOTzq0pQXlQwz9nDN/4rE2FoN0PayP6lFHe+JV6X8hD7hTruF/oRZkkFcTYBj//cmI7QvsRNcm3hH7BJHp+cTdedVavGCM89kmVueKhi2k4xjaTCualdvawzehDnpZbXcAnO0Fu63LPVmbca0I17L8DVEKt52Ub7cmly4BPy+T4/2neB4MkHRZNEUUxfq1+wdg9uuaeFuhl45xPSQJSwudsAOjOE60lRukqaxyhhJynP/HAi4h0i6lJKuuXcgJzorCQ0Fvduz8buWPhhfftaxXaUvZhEJd2lJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 15:56:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 15:56:47 +0000
Date: Wed, 28 Jan 2026 11:56:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aliceryhl@google.com, bhelgaas@google.com, kwilczynski@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de,
	helgaas@kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, acourbot@nvidia.com, joelagnelf@nvidia.com,
	jhubbard@nvidia.com, zhiwang@kernel.org,
	daniel.almeida@collabora.com
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctlg
Message-ID: <20260128155646.GB1134360@nvidia.com>
References: <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128000410.GT1134360@nvidia.com>
 <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
 <20260128132029.GX1134360@nvidia.com>
 <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
 <20260128145906.GZ1134360@nvidia.com>
 <DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
X-ClientProxiedBy: BLAPR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:208:329::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3a8e8d-3de4-45ed-18b3-08de5e85d744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tpksb4jXF5ev42zub74XRKu6Tz3l+p1/YPRyplHF7MKMiQ/4zR9ckH4HOGbV?=
 =?us-ascii?Q?v1x+aHhHicS+8eihW+iISjZXf95wSKcWUpGClCZfuwio8IBxhkngB8iWhw30?=
 =?us-ascii?Q?MVFLjtd6sJT3CMaiF4X/XVpR7kSnHHiwduA9XScujGGSAKXe8oc9JvAqs+WC?=
 =?us-ascii?Q?4vvh5u2pY1pSLVLwBp5tPqLEGlLh2D5Xy+glUNJi2Oz53F7XxUydYeXLEsPC?=
 =?us-ascii?Q?AeOP/2A7xdcgQIbpI2vMs23TrwNZ8PGK8fcEePciY5fK6tkZwU2Fdz+LTMTT?=
 =?us-ascii?Q?HvBcQAZ8yQq6orrkEHMF+uJIMYHeiheFZBrgN/basLKaPsgakt2YTBsyf2pu?=
 =?us-ascii?Q?2XZosGCJAGypOpQOTNlVJNX2iZVqBb8oqWVk+ntrkSZN4vlYOuy/ECvRIv//?=
 =?us-ascii?Q?9natyC0BJjibdv4g4PoATSVQzUmOhGQY0sGaFDQfqDXh5RZxRGiLrgRhEdMl?=
 =?us-ascii?Q?w3x09toJ2KAH7lGBISAxV5USoEtJzEPumtH0LzGwA69CEmfNvpjIcxNfPn59?=
 =?us-ascii?Q?WbmxxLPy7LKjtvViTVZQsOTdE6Fm+F2zpBAKqfVKgYpzei3mwbF7aPshG6c4?=
 =?us-ascii?Q?WeoUHMhubJ3dCAj6D1nnyGv8P5DqguCPPve/oK+CpoNEtAjd7Y9w/UO94MIU?=
 =?us-ascii?Q?Z76HpaMMN8twq1Lc0xds+pdRYEPzWbtxMkNOCaQuU29qRZHjIMumOtuyXmfT?=
 =?us-ascii?Q?EvdkUk802HlWTd0lqP6V3nsHGF0pIBXBE9XaSwvfj2hCGxhJpCDHe4JsSLXL?=
 =?us-ascii?Q?g0hBhm97UAXdKp96XIJUNI0w9PYhAYOhC5rZpKvTKWMKlhk435Z/BWLUrE0U?=
 =?us-ascii?Q?OKrBqGlIUimtVOqysy221to/DiFGpLs93srG3YHJvVP0SdZ6cOhsrupFyAzF?=
 =?us-ascii?Q?XWb1qCpW2vu9H1GnWdZDBRswzTytGmjOA+JQEUUQXx3qLh/5ZGgbWMtjfTj/?=
 =?us-ascii?Q?muM6yW6lBHop/BsSRfzIH3LkXty/QcFgHrosompxAalJ5vZV9noHlTl4VmFG?=
 =?us-ascii?Q?KLQlaD4cYu/eQ1ugPAvT2yWtExqwKRWdj2wx+ZfqhTn3BnKB5D/G7PnjLMf8?=
 =?us-ascii?Q?2cRDab4en0GZCyrAOdGMvGghGDwM24ult5/rNE6Ic8SvN60uEO89VUbUP0R/?=
 =?us-ascii?Q?eT2ZJ0fg5YsmW0N3qzhlm1Ir+ApVNOmtQYO9R6lHConEZI5B+Zi/9VrCGpiv?=
 =?us-ascii?Q?RMIvZ05Q5gvxvTwVgzRBYWcn+drvE9Ru3N8k5AnBDr0p3NN2tjev5QrRd3CT?=
 =?us-ascii?Q?/+IBOQvy0QOpXm0OxinF8Wg9/EFo6P8CgIo/2HPVPafoegYzEiF/86jFlvyI?=
 =?us-ascii?Q?WFAVbVnYMEppVHNf+WidA6gP5trlMazsCSyPQQ49i3QSb6rmKHyTARNz39nJ?=
 =?us-ascii?Q?Tww5zxcrM9MK1UUPOyKRm54zhz/0ojB0JTOVYPT/+MBksz6aKixn0vUR9bUF?=
 =?us-ascii?Q?2MqvpCtiT/2g3YN877eBNk5svcd9UKEEzaOZtEWWQcbLXlHxxmtOlpDJykK8?=
 =?us-ascii?Q?PTm4Db39olGlv7YelCR9YAMSz3tGNEPET5Dytlcl5/8t3jBeYuHITdAaQIyp?=
 =?us-ascii?Q?/+Vr4qUzlpBMZyVKdf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Ihf+tuZNuM74dit8NNr0GNSVxqqqxj4XTt+K8jUbuNueyX7vkN80/8svbEl?=
 =?us-ascii?Q?iqLANKtwkTeIxaSXOebcRiufW5QHfXLP5nB0sVudopejwdAwpVvOjQSGfLb9?=
 =?us-ascii?Q?jLV/rqDpa5Kt423beG5sPl0A/P/JExvbEygkdaVySntb8MDMi3a1LTRmNfaq?=
 =?us-ascii?Q?MqEcBbUU0m/3/pQuJtJWDqfwz9VSNs1iSa+bAQ8ENfGsEzxWMzi1qYY+KWH3?=
 =?us-ascii?Q?5HLEapMpIQucVEbsp4+VI7cSs1mdQUvrcwTJ9pbbXDntmAR2kdYmIPaHkvz6?=
 =?us-ascii?Q?xYXdPHjie0XSGGuJAulrM7+TB2F1SHuOam2kH7zEwA5DjPqPUTUVcUcaHc4P?=
 =?us-ascii?Q?c8NG5NSwFa0oKg18hNeqYU8H55SLiBioHO9NSzfhOVHR2CMa4xj+BVdaSPIA?=
 =?us-ascii?Q?8ldFg6IvoSugh6FHOjq3YWn5xfcqI+v6AgpwxGwlte4O6HOma3jDW2HOZz+o?=
 =?us-ascii?Q?COkEQpbB1H602YDXcIXoWu+zI7+CCee8rFbleeHlTdoVH47vDdbj7TJ75Nt3?=
 =?us-ascii?Q?rIgyhWybBlx0MxXLfTl/dnPZbY4kAy7VycuVMSJtdYFtQT848w+OSoGdkb/a?=
 =?us-ascii?Q?glQc+4pfaWV2U54feRqbpbqQVpn21K1fiIs/wJWWh0dvLhPnc7J1HTnP+z0A?=
 =?us-ascii?Q?mNew5Hj/e1Ka1gkvv7BLjqieUMi009MA35sC7KxyscLaykGBprNQ/74xqRq5?=
 =?us-ascii?Q?uMKH2DUik+gdn70VAJuPZ3cDyJnokgmNlea+dXO6goe86SjO0iyxlqzEpU/U?=
 =?us-ascii?Q?JmA84xz7PcwKreZETMrw68D9y6bdED6Hi7cOHthmo4sGHnVv2wVpc9DNxjOL?=
 =?us-ascii?Q?WSxUCxFVYC5fGKPX+FA9MnOr5N6mfYic9uMC0nw3vnextJ7xgVY3plYtDFXt?=
 =?us-ascii?Q?D7ublHCyCj312IsiW167JDUL2Ap/w+64PzEJTdmCDDWf+2B+mZEfuI/sOyRz?=
 =?us-ascii?Q?Mq1S2E5oJm3uwdHPIY9VMoC043Sf03Y9r9eOETrBoBoJ4r2EupdQTQ9aiX8r?=
 =?us-ascii?Q?mysy3em9Nc3Mapw7d1qML1RVpqr2RSlXIKD6C2KuvH2mOuyvOpbEOiB4ZpCF?=
 =?us-ascii?Q?q9XM8RBowJOG07ZRgC/QfoxK9PBpi7xiMajrcFkdIgQ/gi/0CFOvG51e34Yr?=
 =?us-ascii?Q?9TeVCw0aeiOJ6zbUUAzx0kK2bxtJg3NhrhieOOtW5Xfv5/HndtJwLdyAT1B1?=
 =?us-ascii?Q?eKApBQkK+XQou7uYPIz2JrFi0T8LRM/USu3HkaRztIB5PNwz/V2WGucKpeep?=
 =?us-ascii?Q?aIRB1fGupFsAMUbSHIHEsbqmoTAHLvJWnCLYbPaqAaadTOFd2q0nd9v3BAIM?=
 =?us-ascii?Q?KQ7Z3tgnjwk0Piqaa77KOOJR7sqhe1dWzpFRawgPrdR6njrTOPzmBDTxz1g6?=
 =?us-ascii?Q?Y0l/2/+fTXOH9nHq6ocg8z3jh0e5jROmvTPrTnif1VVnoywN0ChwwKOEABtP?=
 =?us-ascii?Q?FlqL+lJPFufLj92LnAgGb31cl+j++b4xieeY5S+EVDTp3h7bXqzJkcLyKmMz?=
 =?us-ascii?Q?nJGggMPvKcq67h4tMrZ8+wdGNhV3AEjFpl9nBr6dN4ggIQhksWeOgZbpw6VP?=
 =?us-ascii?Q?aVrP/EVW718fNzlCuYhdbc6OkOVjtJcetO7SNY7hDs5voQ+x85CDlxxWAxf/?=
 =?us-ascii?Q?vooMM7cH4jfLgPziHIYxX8STvGqbJwBFsY26C5utibUtW740Panz+jvQeHST?=
 =?us-ascii?Q?aThm7jG0bhwuPXbOfTS+KilkyKRK3SoPWOX2KY6KAUoR6+R8iOHELcM772En?=
 =?us-ascii?Q?PqoMzqAUoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3a8e8d-3de4-45ed-18b3-08de5e85d744
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:56:46.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za7qRS784xm5xK6zLry2QQawEjaMPohk8FoTngA0mExOiMqApmU6NxRrGunbUd9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

On Wed, Jan 28, 2026 at 04:49:07PM +0100, Danilo Krummrich wrote:

> 	        // Initialize the `data` initializer within the memory pointed
> 	        // to by `raw_data`.
> 	        unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {

> So, essentially the driver passes an initializer of its private data and we
> "write" this initializer into the extra memory allocated with
> _fwctl_alloc_device().

This all seems like the right way to do it!

My only remark it that it still doesn't give an opportunity to call a
function between init and register.

__pinned_init() is taking the T type without access to the initialized
fwctl_device

So if I add some function drivers need to call between init and register:

 fwctl_XYZ(fwctl, ..)

It is not possible? 

Or would you some container_of in rust within pinned_init()?

Or is it needed to add the typestate?

Jason
