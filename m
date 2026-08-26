Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CABF418365;
	Wed, 26 Aug 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746917; cv=fail; b=pgENEViJjhRWvBS72+pobSl5kC5e7tVptzRdyrS1ltzsI5AXY4kpv+oy47vccw9O6GPzACCZvc4HihjUl56Mu3E862pvqHRJs5CroWQwEhAjmwawJQaNgFVGsHSNDn1sladvxCjP4N1RROfvOYYV3k+K1LaRyLzIX+BqfZN6sTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746917; c=relaxed/simple;
	bh=n2JWec3egLLJtTJaPijPIlat/jxBcC4aya9sZMSRR20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hHg6UxV/wk6x5nB/hbGZKE5fi2h0rQDJIqm+FF7soikcAdKdNR6k7KTdAOhjGsGG7eSHT9FYFk/Ol/apJ14jQ8FY6uYP3yKTwFEEV5VluXIKjD3/6QkDA8TS83BC0p/rA5id6HGQJHosmlouLlAtlT6oD1wt5vF7v+7PMarsdg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IBOIPX4H; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IBOIPX4H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVPk/I1/IQXXDdfVopfG6U0LgcFEAseHovGrB8lZ9uL/E7mfMbjMQyLLh1jr/sOboJ8dS3cX7roEDyDEj1jNo8/RJ3oY+h0/6jGx2JIJTGg0XR7HjNzXcdwiKf8qGsE9b45ZMbmXuerzlJP1Urn9S3yQ9d9XAgb3J4FxoMYjWWMbgsuM0Jml3+0glZnYG6hMH96LRi+LBIjn3crbEgUqhNcraPAKnv8nS+v/mqImYsHmLuLQcWilzrjJ/HXhEOm2BBBOPgBYBQfyw67xRr0pq9zhRq+eFRNS6Pobr1LuKK7ihEF7G5vk/IrgeisStS7uBML4u9yRvjkQMJDV+fIVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De9mrM5E2EKGHTciMw4BZrignUnnwfdIwbK/TJOcd3w=;
 b=k2aeu7C4crXa+3jkatqs7YBIcQhuiinBJFn6PtHrR/AhSjhk0rBp+DyWec5mt5Z4zB/FMEZGmTYZh3D8CdWopWoejt7N/LctrfB71mMxflKG5r9zls1hBWA17ruAbyz0BQxGcXYsI2nLJa+Jm2k72Ja3TzIi6gr+/LFvJF/T0Pyv3O74us7Cu4SsX5qOkiTf04Cyq2JS9SUj762U4jBtDfzPK1e4k7SLeWHTqEU5K5yC5B+cNzflW67ipET/EKQ263acL1zYeYs3HvBCp1kn6jybDDyaM9vPWUQ4SFrx5QY5Ty1b2YNzx649TpdqxHAZPhvNt78wkJyZGZXGzLywTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De9mrM5E2EKGHTciMw4BZrignUnnwfdIwbK/TJOcd3w=;
 b=IBOIPX4HTmU8RZqCYuV3kOLMfNM4xggjSzuz12AmsZ8FaRK4NvRXCQAdsxhpb60IFMo7Ft78Pnvt5VDsAyOnUxYTu/E9G2cwJb9cCruSKKgBbZZfAoGV9uY7/+3fQCnkpyUurzlDlD9xLDSqEL4M22Ohh9qEHlPqcPPHk7XklTefR3XgnCQDoxTl7AcfF4KXDEtbXw88eof1A9D6X7LrUzAI11Lc7WxgLrKTusYAyAmtUcTuQURTf4LPf5uP6XW23GhaFcszuFVxYkpuZZBJ+qaFTyR+rZH6dod6SlL0Mv1P+iK+r4EEVU2gTQ7QKj3Jc2JIED9Qo76fd41IPqfqlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 26 Aug
 2026 12:21:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 12:21:49 +0000
Date: Wed, 26 Aug 2026 09:21:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <20260826122147.GA3666382@nvidia.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com>
 <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com>
 <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com>
 <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b85eb1f-b461-4f9c-a5cc-08df036c9aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|11063799006|6133799003|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Skk/uxWWxddgRFxPsH1MQ7/cF16e+mfjS2C87oWver6/cSbeWbE9r+4whbPH/XjDVsamU+LOZhXfeIICyWD9+Jeb7W2F5fDcb7rEFIr0iP3QsYh5aLMtPsoE8GNeipsjG0gvuOH6dHgY7cIpJgV75X9wAZJdsPiE7+o9uXFMvpSCQ8M2gwHTG5HEMJ0WdiPxM1peMhQWKHLUm3aXeYdRY/+xPeF+6WjvEnEw7BulB1B22WRAL/vUATY6lsibPgW5aRI0i8DZ8dnx6r5NyrAPtJe9ZBnad9KE94gs7w6q5dl6k69jW+Iuq2ZyfdgUPaZ0dKmmXEJwY/qMuOYMwfQz8Nej+tJTLlTU0795SF/mDvlVmNki/LCxdVYBn2bRIOlNvqc7t5WKLSFeJ0gA72VW67C1nNZepLqxeoVGs9bCbxQIa9IDFm24fV+VPyg3G5eRp7v6DBf+UlD78eFDxjIFCwSKLxBw0nlAGV0+JtoZUZcC+lIJZhk/pQDyyOl9SinV7Czo+6vFXBS6IygC3OKCuPnJLwkQ53LwwKUEduKvjZshHvYxCeUXufo+ET95XGzvtJMzUJY+EBxYNbe/QrRCCrgKXKG/NZu8naya4CTHvQ7FMg8avy6j4Uq2imkGdj5GGas5T/lI91dLVhekda14gDmFM/ajFJ29GQoKyLNR2CA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(6133799003)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sXlWT3qSrs1vA4/mK6c5xOGtkOI8jRFBFWX47NRxLDQfobjruMj22cKFDldt?=
 =?us-ascii?Q?XDWRBPnUqzssxFBUf0cCwmHUzwjVnpdf3L/UQzIh/tnq5EicTPzwId5cWj/T?=
 =?us-ascii?Q?Rgk42SFyHgIdkEjDh9JqSyfOgt3snL53WOIqyYKsZJfnB7yfxbyA1f/rk5XR?=
 =?us-ascii?Q?2aQfuCTMwHllz1HA0cFJe7+3Pbm7Wsn2XA2YS1bnTy5kkNFie5lEk/QNLINh?=
 =?us-ascii?Q?4wGGM7jfy7H+yhMC7aPXfnsPjcYTaSiYlM1TCTsiWIC/B9Ve7YQKAlsaD7Nd?=
 =?us-ascii?Q?BNjy3IiruldsGghkp9AZNMWW+lMd2ZaBrp+CYyx6Kt+TtoEeffjpXbNaBn1n?=
 =?us-ascii?Q?WQjgwerOLjLwrkLH2GY+bBxUeqWkDF5a1ooiTJBzOvKwsHaAEf+hRtm2MDD/?=
 =?us-ascii?Q?uqJa6oPZS/hD5zA+Bw+1mcp610CMUeE/M668JL0yLxgzE9zbPKc1dRIzZN++?=
 =?us-ascii?Q?e3XpwS1gPqQ8jZOfIPulYcXYNs2U3XURO/o++8LdKfYq4EhNOhfz6pAsdfvU?=
 =?us-ascii?Q?iO/zMxJM8Xha3VJ1sqkKxp8uWnwiKJWBjH99ZNfnfL4TeW6cSdd0KwZovXpF?=
 =?us-ascii?Q?OKo/ubygajO2I3bDYcZ8KU54jkW6Im3aCb63yNEWIOKlD9cSHFH/E0SAlGX1?=
 =?us-ascii?Q?vi9LRZF/swVeNBlGNY+piDnwLd3fK/P4kTvRI0IP+QPUfduyWXLrrQLsBpJK?=
 =?us-ascii?Q?/ZtVabsRuXMLwMoP1wM0J/sBBGuZn8sR4U6mGuRkRISYDcYAtnBdi0h4knhe?=
 =?us-ascii?Q?3trMJNyf3FhbHH1pg1u0fq7z91Ii6j9Me2TfUSnLJHJv59baPEZdyIm192Yf?=
 =?us-ascii?Q?6Gn5SZENXANHZe1zrvyMMZOoS42TJDNFeMIydKU+zTPmj9uEh6z6EStovshs?=
 =?us-ascii?Q?jAWw4Sjp6rK7vtXVAyK001Q6jrxeGj9o2DzlnAyhk3ZrUFWeGc3s8jVkFfkS?=
 =?us-ascii?Q?E4SfFt87sVCAjj8fXka8I8+eWsOMNzK6baq7SLejMVg+d2BSbgDOQ/oew2M/?=
 =?us-ascii?Q?RRrJBMHMWj9Y6cdlY7trpRyf8VQoWagyLzfWcONZvt2gomkvJdjqEbq/9s74?=
 =?us-ascii?Q?YDaIo1oo5nNAwXUfVA/jOplNYxZhYSIYJ0t8f0vskfbGYgpn++Bzrh8NMxUb?=
 =?us-ascii?Q?J5HoAvoLzV8esyVrqUL1d+rapYHVUfc0SCIDkijZNkOaZs+kwO2E7KkJ5OPx?=
 =?us-ascii?Q?zm706QOvH5wtLEYfvELockS2GoLyIUCKeiJTvd5Oaykhc9NoN44bGEYFivk1?=
 =?us-ascii?Q?gWWgzy0Iw3g1mMiE/NdKBi93nleEEZONOBQsL0Q635BaFJpYekE5uQ5A6Ntw?=
 =?us-ascii?Q?L8Ggb6rMG0vfBcj4+9MpC8Qv2TSyfvT90TA4MwSGYYwGY1vqRYwhHR0mTho1?=
 =?us-ascii?Q?S/Wr6Qy2oEe+UnDXiwBxUH0YwtY8rOENplFZjPtpABOwTIT2Lm8NYpElZyJb?=
 =?us-ascii?Q?n/XgQltD4zAevjqlOevpmaWE6D8sfLdbud0ykwEc0xw8qFVbDQU5bqKe0GO+?=
 =?us-ascii?Q?fOQYaCsJhqg/rZbA/6K3fyjjgEu3SKKPr2RVz9Olcqv90d5gYhUgXR84J6By?=
 =?us-ascii?Q?u869EUXjFXnrKEzLtyTdqweGbgxFsYgpNZXe6QYHdmU7a9YrqfdGQkM5R9jw?=
 =?us-ascii?Q?OL6l4re9UNloPfY952XuC7uuH5pZHU7RfWTrpTGpLsJ8/wKf1+mm4NJEXhRB?=
 =?us-ascii?Q?cB5gt6rHItTDMeq4ZEiwFFQMFAd5sGHfZUfYfi5Cp+Qflksn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b85eb1f-b461-4f9c-a5cc-08df036c9aa8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 12:21:49.7756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJt81q8tebxH63IvZhYFTLHEx0IR/QwPvBRjhPLNVRXZWCwx3isSp+ftsRkjEEKr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753

On Wed, Aug 26, 2026 at 04:58:15PM +0530, Vasant Hegde wrote:
> Pranjal,
> 
> 
> On 8/26/2026 12:38 AM, Pranjal Shrivastava wrote:
> > On Tue, Aug 25, 2026 at 02:53:15PM -0300, Jason Gunthorpe wrote:
> >> On Tue, Aug 25, 2026 at 05:29:59PM +0000, Pranjal Shrivastava wrote:
> >>
> >>> I agree, but I wonder why the existing code used memset here 
> >>> (in ignore_device):
> >>>
> >>> memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> >>>
> >>> I was thinking it might've been done for probe failures in a kdump
> >>> kernel (normal kexec would've called shutdown for clearing all DTEs).
> >>> (I see this was added long time back and existed when PCI segments were
> >>> added [1]).
> >>
> >> For kdump you'd want to keep the original translation running in this
> >> case.
> 
> If probe is failed then we can't do much. Why keep original translation running?

It might cause the kdump to fail if you abruptly change the DTE. The
kdump semantics are to leave the DTE unchanged until a defered attach
event. An error flow should not defeat that.

It was already running when probe fails, it can keep going.

The memset doesn't even work since it doesn't flush the DTE cache, it
isn't going to actually change any active transfer with a cache hit
DTE anyhow.

> > Even I'm not sure why we had this memset here, I'll just dig into
> > the history once if there's anything. Otherwise, I'll simply drop this.
> > 
> > Vasant, please let us know if there was a different context to it?
> 
> Looking into git history, it looks like, during boot init_device_table_dma()
> sets dte.v bit for all devices. So probe fails then clear everything in DTE.

That isn't how a secure'd iommu driver should boot..

In a secure boot flow (eg DRTM or something with untrusted PCI) the FW
will leave the iommu setup to block dma when booting the OS. The OS
should then ensure that it never permits an identity mapping as it
boots up the iommu.

Having the driver boot up with all DTEs programmed to identity (eg
0'd) and then try to fix them to blocking after the iommu probes
devices is security backwards.

Look at how ARM sequences it, the stream table (aka DTEs) are fully
configured before programming to HW. First it loads force blocking
then it does a pass to switch those with IOMMU_RESV_DIRECT to identity
(see arm_smmu_rmr_install_bypass_ste), then it tells the HW to
hitlessly switch from the FW configuration to the table. Ensuring no
device that shouldn't has even a moment of identity access.

Since these secure boots have become very trendy now, I saw AMD PR
about their version, this should probably be fixed! :)

Jason
