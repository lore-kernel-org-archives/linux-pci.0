Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5941ADFE4;
	Thu, 19 Feb 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771504886; cv=fail; b=LKruGrOwmyGKNFfnT20AyR/t8sl+O5NkFZRj2kEXG8zHqTQAQUcAg1/mDa13uX0lgRVSV7suzgiitVn7ia6+uk07A0KL8dO9Xl4P+pTSqD58adixQzhSHlH7tYRurseFIkNJzmVYVanupbVlKC1Yy1M7fCteq+Oi/7reS+p+YjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771504886; c=relaxed/simple;
	bh=U6fJ9bf4F9hNQLmTpEk9qTz8Bc6KZCXnrZCodlZLZTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kOSV66bTGkAINe474rq9Xv5W21s5he4uHge2Zlz9g0PQaOWsGGAbxlnRfhCtjD9/m5pGhYH0E/L4H/GUC/nvVGQj+CJJwEXHp/ysn6pSg0VbcpgRbGSAT27oY584szz1+zQDKfoQIR/LGy9PQGX0NUEwSbsoDWyp5l6CNrsPFbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F0nnl9NR; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F0nnl9NR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReZhQeiGYVfyVdL05/fxPfQ2VRgJXGsY0mwdQWZP6LBZlbJTg/pmz1XiisZRo5XCyN4rDU5JwfKJCxufx1f48H8nAuEm8EIDvwNQVg4VKyqXvER2416EHYFxiOK3yuvOKWLaO9Bipd1ztDEbK+PAxwBSSv9SAL5f37ienRDwyDxayh0oTUmUHf0qs+MLMtv0qgDxEb0RozYMb1Rb85qHw6TiE3BB5KVkFJezAD4hkV1JSpAaMfjUoPUrxCz7DLCTVTW+Lf14MSspLTZqxgjAwH/EEOOs3FnmoM5s4x7ZhwKw727OZrH1lnfnVdmwWikIikjJLX1IIOFlVUOSFeJhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qevcpaQu3kPG1ve98tfNnLASbHV5bRI0R0EdJtejr9E=;
 b=zG3RLXc12CyDFmq/MJqbgkfGam5Ul9+ujt/eKXIxUSEEsKc/7pvHvQpmicm1RBxGCMBk5qLYSyBOudsZkS0rRfEiSje72TrqoypF1ivDMic5RiRQOIGK5aP+shSOfCBjkahlk6zIRBKUia1eN//vo3z0FOkvj8oqjMoU+FbNDfLSlOau8poHXSa9sHGN28SruRdODhFZ5ri7bL5A4BaS6sXZffFpXyKKujGenvd+cNkg/x5BFt7VMU5c4tWuQaUktk3Z2MrjYfrMlHy8p+wW7YCXcXXU5fqPGLLUGADnPOqmBnADx77BIfICPXxg5ZyFF0rvtgG8+ZMKonGFPJ4uXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qevcpaQu3kPG1ve98tfNnLASbHV5bRI0R0EdJtejr9E=;
 b=F0nnl9NRMJnGOQqRkX0sN68oR9rD+/jXrCpp6SI3YXgEi5GmgwaKADGa5/cUm+OYmdZZAzfiHEu69L2Qe12kBXRb8JKRgJ8i86wNleyOTG4xGdrgbV8dEKV9NZnG6BB2GH7UTHMTBcY66C1b1WgwcudJGtk3tLqkxfJflg1NDttnx2Ze/PJBq/65nF1VtLDrOx6kpeluvIOe/Y1xHLud8BMdIW3zLUvnAKhWmUCnPzRqgOw+6x4N/qIZtE2vT3mY0VJqqMAmkum8FpyqBzdewH0R9Kb0xdZ8O2qlbN7feZnREnWOqa0eeMHhcAM39R3dhHpDcYhRCI0iTHxBREYEpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 12:41:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 12:41:21 +0000
Date: Thu, 19 Feb 2026 08:41:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	lukas@wunner.de, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260219124119.GD723117@nvidia.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
 <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
 <20260219005614.GC723117@nvidia.com>
 <69969a18ff0_1cc5100e2@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69969a18ff0_1cc5100e2@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: f00eafd7-7809-46af-06ee-08de6fb42f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tV3qYVdphEqrp+gHkEnpPHkZdM23OMTba2DFPewHc5LfeacsBRm85IUw9Mlk?=
 =?us-ascii?Q?MZ4yDKkPd6ODBMChqxsujcHN3Amhk2/je+cK0YppYptUWfBTGlSwlnYIIWHO?=
 =?us-ascii?Q?WNxfHHu+BvPMKTExj8S30dx0Dj6cGVU5z6ZPsIOBDTje9HQXw+2JXEfmBfYm?=
 =?us-ascii?Q?Ba0vL1x13xrxXuwj358vilricKa017P5HiFZ7B4b2aBWLmJuEpVdC2h8J4x5?=
 =?us-ascii?Q?wpUCN6DgMlYVGEb0m+n+Oci7CPkenzZUbklcSc4TGmQnIp7wqtzqYPTCaZfB?=
 =?us-ascii?Q?eX4ew9tEboYXMvYopX4Ht5YYIADn3QzQZ5hr62v5oBqtIeJ1ja7a/4bOQw6R?=
 =?us-ascii?Q?IiQxZJ6/Dd8mpbIljw8rrROzJVRjbX8ulc6ac63qY9XLtsOSOOXDwnpn4sF4?=
 =?us-ascii?Q?9swYqKnqJlGH6DhoaDrGiAuivW+TCJfdIfEFJC7NQSl/X/k9xFRQwSRkK+mO?=
 =?us-ascii?Q?5TYXGBzcjZ+FZQf9y7sJ87eQe4tiYMlur1pba9dGEO9fHdqA7s4bkDzoAKDB?=
 =?us-ascii?Q?oUU9KSeVEpeAM/Nd8E28dPzHz+j7genJmYob3LjJ7j6TlLb24RvEcxVelzGD?=
 =?us-ascii?Q?lL7Y6ss7ozRbcLPVqZxYojz01wfPNib0XsiPnH7b9aB1uEA9jlxBr6ABpXuU?=
 =?us-ascii?Q?PU7mb1fRH2Pf4hU7nd8LnEUOw8OnTUPZPK1iavYLyZLAczI1y1N1LCFRspfk?=
 =?us-ascii?Q?zbIX5tneItD1xWeOZ31/U3sVAAQibFpUNgLOF28534sOBuKHLMg52IF3Qyl3?=
 =?us-ascii?Q?7sWaIcrcJNqwcgqURrfcXWORI5XxhZitiq1WNyIZwdWFRMTiCuYWp7/nzYT4?=
 =?us-ascii?Q?RV+sAwkMR59X96qw0famJd6zvjE9xzwm4kGblgGv8ZydW488PpmStiFih7D9?=
 =?us-ascii?Q?nov3ry5zBY3Q6BplbVY3k8dGpldwyNNwBjNohhHnvqdbbmXL+XCBKCS/l6ia?=
 =?us-ascii?Q?blk8exXv3yYxDk3ONSb9m7U1jCWjRugt2QUAWizycdSKmdznWwWvkGN1kEle?=
 =?us-ascii?Q?CCdKy3PJ/IuZRMEFZWndsHQm/tZQhT8cdvEWPDUoxbAXZMtlkFcv7Y04ESM/?=
 =?us-ascii?Q?BRmio3Hsr0ZuWLhjjQMn+sHPEKRxQojlATEHXan6/pVepaQbqE9W13K2olwA?=
 =?us-ascii?Q?HhN7oqJ9YMslRPut6Fn5bu2CIaCWmr1H/s27AZO4ZSlMqh8QRfjyxqhf6IFZ?=
 =?us-ascii?Q?Swu1KpxcwYr00SKvno/C/sExpWTZTd+sn3tJ477YmsC41dTMDbWZAc85ktjp?=
 =?us-ascii?Q?vV+Wm26D+TVI1uajgtaZdh6NqHaVCQ0yBkzHu7fYBBQU74d4DC2vmwAy7iU3?=
 =?us-ascii?Q?PYtAtDxY1UZfKv9aD9uDn04Hvo293lJAIWypQ+50X8LEJR6BimHOuRKVC//L?=
 =?us-ascii?Q?HrbHO79iP281b6T/p8wLYBK1deL9G1xNJvgGYuT7pjZUeDKgBOFsTu/moJQl?=
 =?us-ascii?Q?ZWumDAu08+lJNAbDgj9ij70l5tHs6gOtg+R4D3Dg6NV3VDW03y/1UbSePTj6?=
 =?us-ascii?Q?DqInWJ9NNrQKcqCqo0dR9KuNwXCIrAKHH3IXOJopD8NoB3FvY+nMHJ3rQU6a?=
 =?us-ascii?Q?mp0GKJfEyuSjUVefgOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?07wvR/VkXKEXT4Mxz95izo4E2KPjcyBEJdDESOxRhZ2Yc2buvGw6fnlLodop?=
 =?us-ascii?Q?9NlxGCRuHX8G9LCWGjA9im0QR/oU1BWlOH1g86ycL8oVwmf0akeX+eZhoMwZ?=
 =?us-ascii?Q?eZrYv3ywNqGT+e8ZqsNQXPjJzs+L/BHepKDj5bw58cj7JP75jOcrQXm0sy6W?=
 =?us-ascii?Q?pH0AXxqmPSpjG34wHiJsA6PZlnG6Ts3yDwMJcZfMOn/8j+9/ALn0geBdX48u?=
 =?us-ascii?Q?qCPt9pXzwcpXB5Re9lKBFKUCPSMyqQuybvHVO3RMP/Ik0iRNK+sBn1p2je5X?=
 =?us-ascii?Q?4JLbZ8miwk8ni1oX63IcXdnoJubnvH2Um2CyuK9slZbPHOUCKHxhUzUDTyGF?=
 =?us-ascii?Q?cvawXFvclzoYChT7ccQqlPiN2EO+XFbN2yTM1krHevC9L9Z2YeCucfjtGbX/?=
 =?us-ascii?Q?THhzRKX3I38hwQ5LbiTZnEqukMgMdkaQnvIQ5SXC9LH+2DruniwwOXbiHPIR?=
 =?us-ascii?Q?B5y2UIOH9aUb9iZkwwCziKEsnmj9iFYs96aETXCSFJbA+pNyyxf9TZLmYIsR?=
 =?us-ascii?Q?lNhe15sNQmflsNdxySl0WfymF/SgsR9//Vd2xTSCQ2nLchMq/1X9mDdl5cZs?=
 =?us-ascii?Q?pZaSOKI8SGmyrIt3SzlUfaxB6yQDcy0JlWVNuqnixtPbkuCMAwgJYBh+WZFG?=
 =?us-ascii?Q?whWThYRydL8PJM3dUNf2MQFo5WxjTeK/0WW1D24hwA477rDRbg2vtu2ePJPP?=
 =?us-ascii?Q?MU3N+10urLV96XwZg3y3HoXi7SqEh/1yc1LzA3GVM9hH6Pj6zcOY2g8CEgwn?=
 =?us-ascii?Q?sGnskkIWHkXKPLN7r95ZgVdlD/ZC35W2f2xZcyp0ds0elEvB/5sbllQ1Et4J?=
 =?us-ascii?Q?jOlJcIA2lA1euAKG5fBB5ABkT+h5o8qqV+9dlqfXZ6aXWGRfBOYXymwY+2Os?=
 =?us-ascii?Q?jhAfPuVSkET355CVqu32p6IGJxkIU3XNy1ssLcbM5Io0YiLFKUgQjFpUPn2v?=
 =?us-ascii?Q?yUs9PKRec2IWllYoXUW5z8FFBAPnwzw3uVM3t2t4s3FtK3NUCx4avkKUVGps?=
 =?us-ascii?Q?XI5ZaWDWV+iCd1/fA7TagjCFccwS9TnjaIMHsxz02c9b89dC7UJ8VToBKAWQ?=
 =?us-ascii?Q?oXcyl6n/y/nlIY+u2G7U85n0bngt+Ng787qTazudN+JcBEcVXEKAAhF4dlME?=
 =?us-ascii?Q?DMoxovfn8A2C3BSbRbC744yKtLVWCYcMXPd6KBrGJSqGBvUSCVImmVnvR8FJ?=
 =?us-ascii?Q?3sV+v0KMngda/K1KAEM69Izejz9KbWYuaWfwK5DvqaMl7SRv1bQvrHaOlcCw?=
 =?us-ascii?Q?SlUdfHrDe1+Cas+puTHoq/OzDtk86ZdgtLoTvBAJAYVh7ecV598IJj+B1ZPU?=
 =?us-ascii?Q?vowaiJeKBleIqbRYcmL65TmgEms+GJ5m+jp13OZr7BGs00spBsvxM+qvk3IW?=
 =?us-ascii?Q?6Fn4y9FCLGkg7Ri+L2eA3FrAFOya3EDuzqf3zHnDcSlG833KmrwjseZ8SZS9?=
 =?us-ascii?Q?eWviMW0I9yanismuzDyxvd7DaRIHKQeckwePZEC0/bKrP0MGB0oqO/JvL3YT?=
 =?us-ascii?Q?75uNkLrGhCbMOvIHTACkue6NNokJ7ojPyVuyTVzFAJF88c886UJH1lToxcTA?=
 =?us-ascii?Q?EIaK0V49eIZ0lmUsGWlNCR63ZE9q5M7gulovdTXwhmy1mHYl/chHtB+sdNGF?=
 =?us-ascii?Q?I0hPYpVGFSWwUNV67vDEePkY3seABr9dQaUKAy/JXx19oZl3gQRunUQwe0Vh?=
 =?us-ascii?Q?UN6aoGRIVS4jWmtH/GrH6au+6VJN8UnwHFPO0e4Lnpqs6Upou9JqXAGntvKj?=
 =?us-ascii?Q?TtZkivaAiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00eafd7-7809-46af-06ee-08de6fb42f3f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 12:41:21.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BECbUUddZ1jUiFMbroIRzaAkfMOIJRdcrRjh2NJAoA/mJorzP1jNzC4w4423vLMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498

On Wed, Feb 18, 2026 at 09:05:28PM -0800, dan.j.williams@intel.com wrote:
> Jason Gunthorpe wrote:
> > On Wed, Feb 18, 2026 at 03:40:10PM -0800, dan.j.williams@intel.com wrote:
> > 
> > > So one proposal to get the x509 pre-work upstream is to extend the TSM
> > > core (drivers/pci/tsm.c) to export the certificates in sysfs, and update
> > > the existing "authenticated" attribute to reflect the result of cert
> > > chain validation.
> > 
> > Why do we want the validate the cert chain in the kernel? That sounds
> > like something the verifier should do?
> 
> This is more for the CMA case where Lukas was imagining automatic
> revalidation of device certificates coming out of resume before
> userspace is present. If someone wanted to use a TSM for device-auth +
> link encryption outside of TDISP and Confidential VMs, then it could use
> the same mechanism.

I think we should have one flow for this based on what we talked about
for TDSIP.

We are thinking about many interesting models, and some of them
include running an external verifier on this no-VM case well. Kernel
auto acceptance is not desirable for the same reasons it is not
desirable in a TVM.

If we do some automatic re-accept for RAS/resume it should be strongly
tied to some target pre-set by the userspace acceptance process - ie
"the device must present exactly this specific cert chain and nothing
else", and probably more too since we may want to exclude swapping out
device FW versions or similar.

Not sure how that fits into an sysfs file.

> > And not sure we should be dumping any certs in sysfs if the plan for
> > the other stuff is netlink, it should be consistent I think.
> 
> Lukas was only putting the dynamic / transactional pieces in netlink.
> Specifically device signature events (multicast) and device measurement
> collection with a nonce.
> 
> The static cert chain blobs can certainly also be in netlink... but no
> real driving need like there was for the other flows. I am also
> encouraged by Lukas's work to handle large blobs over netlink [1], but
> no real need to add that as a dependency to this simple mission of "just
> enough of a real user to land the crypto prep patches".

It could, but also it seems like it just makes it more complicated to
force the verifying agent to use a combination of netlink and sysfs.

Jason
