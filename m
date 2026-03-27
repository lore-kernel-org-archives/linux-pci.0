Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4A3815F9
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612168; cv=fail; b=PIbJhLzIod0fkDSHQw8iNIUReTY2XlD/8QNWjpt+O8bNJzfyrZZOjmXMqjwhkOOZXEbshWBiRAQxIqPbKef4Wht1TyeQM9RwF8A/x1hwWSNPw588nekJ0B5jJagxzhYaz4/q985fQpxD2W3CnDUmw1CfDHsbA++jLkP0OgksJiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612168; c=relaxed/simple;
	bh=DQfvGhIdT+4lHayEDollJAXXAIoHzd6V/Sih6dKbkLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jaXRgKQFzbHmbo2RdUYXQUo09YXxm5dhNBAfEt4l+hi6c/tQZy83tJDWxJ1uZiA2Ns62EBgNW/EhSkqvXWGHB011TQ7k6VKkNFxnGQWOLUVfD6copr9T3aI88EnjAaL3ebGXWbD6QDfwq6GVj+MJSTENw4PHNy2Gyr5qSOVkZvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJTyQ2dq; arc=fail smtp.client-ip=52.101.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJTyQ2dq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9CJSEdqwRVNSsgc7obe79ZIv9jbLZ8HxP/BDxxr2aO9NdAtR6RPvuB+qU3Z8ME/2sKzjd8WwEmy+t0Zi3w9dopA4KqzCj47vJP5YNEKe8GDL+f39UJffPK6QHvNYWP+JG7ffj0dEU37pTWNWXS5r78Y7ieTTpBGhvoorK6ZcFZ/5QB1K6DaPgT6fgA8i2p3pR7RhM3lEGuCB049+NCkChdE8o5rrcUQaTGSrsYvVsNxPP0jMvYYW/Q/tlo6rz5zCjMvVd1r8kryUIOzG4jpi9TPkBuXH/xLSCEigrkdCflQjd1wcogkEuzI1D0fObsHX6C2hHmW3BbeYvrAaLDEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvR7KIvoIuKWZm/04H0d9BB9HYm5brF0ad3qZPBHxds=;
 b=aYVLidaczf9Jplytb8xaYr+Dd+gyuJSZ30GtL9wdITiMesmEp+3Y8wsKPuBIw+lOsn5yAFa15wJmatog7KEzNxc9KzMm30Im+5brdTNd002G+ljWlyKrJEH3wDEiiSJ7nBlPvKIge3FU2GHTZ/Cq30EWpd8C8o3VoIiKbu8YmBwdBOUIkEXgo720dteWWYfHtMzJvMUIw5CwD6OWwhyXCwvaeET7Uyr5R7QTOYTtQwvkStWTaSGRGJr36+m1OdjEPaZ8Zt/jU+/o5ZjcgsK8xqBI488tNtSFsK4LpJleG3azs/ehjUxmEIKNVh2epB58yoBruwB56rtJQAxlqNpwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvR7KIvoIuKWZm/04H0d9BB9HYm5brF0ad3qZPBHxds=;
 b=lJTyQ2dqrhY2q6D+0ib017WTVfoEg8qn82K7H9oHFQQKUlyzqf7WNxeZELuFt5iyQWO6hXzxAvoQDU4mZZQcvnrxOfxKKG71L8V7GojaG4XvWB41Lv9JOpRr3t0ZxYt/3l1sWrbNk/EW3qnqjURm0otEeaVjuBAmy40xYkGROL2JF5AZ6MV0KO/Nd/YE7WXPiG8IDrffz6VxrlKGBIRL/xh1P2JkAjO4klGy09p11pCxEcMgrrspPvZBgcqfLND9HeVK03y3lRnatSiFv4YifhBNG2LPy3TvoNVPNgh+DBrH5H1JBELftfeWXFL/n9mQCONDK5n5qtcHIpumXiG27Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 11:49:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 11:49:23 +0000
Date: Fri, 27 Mar 2026 08:49:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <20260327114921.GL67624@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
 <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: 384df2a6-5df1-4cc1-0386-08de8bf6e390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X3Dt5V/7PzG1XytzL4y5CYAMtZgpqDE1WjTXRtg46bfT2v93EYMFIyrrnXR9nExNbOt7HGLJM2nIVpWdtjl+77Y33dYSOWmbedOXxYh5V3GFSr/3X4hr7uJmx3VyvB3G3AUFwleCYK8MF8DGYlWF6XXLHzzhpPJVc/TUo/VYrV6FZNmJRUjpeIAJlXv7L+Bm+cOzAvBz1E/+bVA6BPg4AO3bOY8f19orqhgfK1F2chP5I+SWougDQQCaGaJAfgG2YI95IFpnu9A5la+3rsoNaZ0Bc5e62ET+OfpxOQXpzSY1ySNTTg3Dzrg8B/yI8p2rVdExO5EIM9FQFryoi2tjC3EEhbaeJ0+qQl1heT6P4EOHZ1sCcbRZB/dXVFB1AGtYj2qLRh7Y7diaz+OaW6gYp/Z+PfAJmoJN7QKvrbTyDV4aopb2P/Ms2pjMklkzkHhlhZLovx+jDYdEq/zqATj6bpSLvdNVnde9bG/A/nrXgFzghLZMLGomLBnaX8wGk7rGpD/VPVL8fvOLfxUefg2OxnJRPvtG5G0rN0hWLOs5SQ6a4UQVpED4XU0lTBmvLlqx18lbKAuCZCNVbRM6gcI/DIGtEVCX6gWGoePhCvdDp2yyGt5uhD7CLh6QHO2zidXFfGv7jRy/t7tJTYLOXcnh3t+8bkViaDBzpe6LIb4y9RQgtXMNrnnU6iX2tqyHXYXZ6ya3c46+Wa6OrUI0PxQFYMKV8jXk+MchYl/sfwMInBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJoFt06++8lqrAWxDImfec7LJALPUC7ZnQnuO+dtR/QAuIEWQiGhR6xNg1nY?=
 =?us-ascii?Q?7CVEG4EqvwljnE5f1J/juB/TL2ox+wFDHPmlOwR2Cj7P9kvPBcFxdqs/msN4?=
 =?us-ascii?Q?SLyxxiaUbrAjhnBfYJPvBZHvDfcneEbnbg9qswezZXMvBa9EkCqJgCQ57ufY?=
 =?us-ascii?Q?LPgMe2EYBJ3SdqNh8zKxOvhUAx11QhqhDPNchjHJ/TNRTbgVFaSiOerXLAG/?=
 =?us-ascii?Q?cnvlbxf7aHVm5ZQAu+BzpBypOdLt5Hnf6BppkxxM19g7q6AgMpsuzzA6qsUA?=
 =?us-ascii?Q?H4xzECBqsDiMRdIio6wjkjjJzK/EFNFFhE2lcQv3fmeJmZX8qxPfZObSJA5H?=
 =?us-ascii?Q?8PLynOtu25PABKo3UN4mzPKEE9o4hMNk0kaR2tsINrQ9WHAVbWDLw8W/WHoQ?=
 =?us-ascii?Q?4oOm6cnyECiMTjGY7gRUQIGh9euAMP1yS3mPvqNwDVMmzHP1sSkCsNvWTqQb?=
 =?us-ascii?Q?XyFCcdKsZNF/tc3xb6OFr7h1JD3/o0hKQ//78w1+vllQl71LB1IxNn4V1wJ9?=
 =?us-ascii?Q?yQK51yg/bnacK/izGNgXaMX1ABZir4c0TSf+jL7uIyssVhu7xjbHZCrrIMZY?=
 =?us-ascii?Q?5m9ywNTu18+I1m3LuKK7Ned32RyoOTF1+S9Yu2VNNA5DKu0nmIKI1Pjlh0sd?=
 =?us-ascii?Q?qKhmX/DJFXhmClh4aLbut2xxAbzUySMYjRu5JeNaucXfsP08JvnDFFRHsleB?=
 =?us-ascii?Q?nmUPDnOrbXx2xd2C1rWVjodngYt1EBsqbzUTmTwuSEddZnnTQVljehsJ7KpN?=
 =?us-ascii?Q?Bp8jjHs8TWbT5xwedW/NTbFCbmOUO6AtwcWx8ISgJn9LBvtbOsSGbCeqAuEe?=
 =?us-ascii?Q?s3W8HhDTIAeBzceW4uHtQtcNa/OCL8RD5O/63ZUbd+J62PCP0FmW7K7m8BNc?=
 =?us-ascii?Q?nKux0OUhEqU9NyZi4vKNVPhUqX/tUCjXG2TTVYvbYL8STJTxs9w8Sq6nLAha?=
 =?us-ascii?Q?6AzbJOlU2Co/sXi6chgyj9ApBF3kM6hQ4+3jj21nwSQjFHPbEx29tTthI/Y0?=
 =?us-ascii?Q?ZbDbhl4iztOIw9qjy7dnGAZiVvY6dJZu4y6XVAu4NfF/gzrh5RfhOwLzo/ne?=
 =?us-ascii?Q?qw9mKXipoV2adqyPaxYfUCL2UJbgibeJopFCsMknqf/x6QwaZeAMD4y8VmaT?=
 =?us-ascii?Q?TnmtU8QPocFcSRVvPBj9DxGtGf/DktYDSgpC2vo7m/1rrP1SDzJvpVH//2NT?=
 =?us-ascii?Q?yLak58d2IHtXtQ4y8VJnDbpwJZFHFsZDj/VhmE276OYxcw1efYjVjXjkHSFQ?=
 =?us-ascii?Q?ZaAwMLgZmD481h75/4DWEwyLpTxQUGCpXrKzGORERFQX+TyNEW9iX1CHv0ix?=
 =?us-ascii?Q?G5FKK5+UJ55CN4NHbWUO6q2Cgp8uzMZYPX5jYRFizXa74+l38kboaKr1v2NO?=
 =?us-ascii?Q?6Rxn7CCtsqOb5fYNd/ydDGKMdc0fgm4SpN8H1B2toxeACTQ67C7qBnx/zQp+?=
 =?us-ascii?Q?vjc+p6+noIBuzrAbvZTRBCUGzhww0xfkH53tqDuQXlzRJE1SmpGTHyAzpfMI?=
 =?us-ascii?Q?T0YU+V+6+Rd9VGYtf0hBaNy5W1xxHsnrfpOdqdpxeAPlKgTfk8ldPh2ovlih?=
 =?us-ascii?Q?4bCye7RN5BYA81wTU+lxGK2MxUhSfK6u6uVP4qj+JcVxFVRJ+VErOf4nmNPI?=
 =?us-ascii?Q?fOar9Qyzy7agXSNwRSi1+NgFhzSNSXVjech3exrUgVfA+5Xl4CL3WZsI7Z7U?=
 =?us-ascii?Q?mBFel2hNcIF/vBO6ZvBt+HCYpWhmDWhKADKEmnPzIFwwh68K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384df2a6-5df1-4cc1-0386-08de8bf6e390
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 11:49:23.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHbojizaPx/XEjSE86sssjNhuTrHqARB5JUpB8JoW8AkbY/gQZ1JC51DQAsIMFyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150

On Fri, Mar 27, 2026 at 10:38:15AM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 24/3/26 05:20, Jason Gunthorpe wrote:
> > On Mon, Mar 16, 2026 at 04:19:30PM +1100, Alexey Kardashevskiy wrote:
> > 
> > > and btw this only works if the entity generating the MMIO reporting
> > > offset (==TSM) knows about BARs sizes, which is not the case for AMD
> > > - the FW has no access to the config space (so the HV needs to feed
> > > this to the FW? may be). Thanks,
> > 
> > Then your platform just shouldn't use the mmio offset feature. Set it
> > to 0 always.
> 
> pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:
> 
> "Each MMIO Range of the TDI is reported with the MMIO reporting offset added."
> 
> My english struggles here - can the above be interpreted as "Each reported MMIO Range ..."?
> 
> as if it is each (except msix), then I know where msix is and can
> amend the report inside the VM if msix is not locked. Thanks,

To do this you must be convert between the offset'd and phys_addr_t
versions otherwise you have no idea where the translated ones fall
within the BAR, so you can't figure out if msix is covered or not.

Jason
