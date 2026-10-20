Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792489056;
	b=NcsodscKZ98ypWj8PLg7xiPmPmTumW/z3Ycm8JiAeEK+nclfLCHElj6racLCI5DeJxPQ
	 TWZqxeOfoJNbz33hzMOAGdbUBfS8SgJoLdnWi0Guph0O+mkvHPkYqJw/rzwABRbKFsdhX
	 NM36kBQCc/S93EdWdw+OWxJ+etPDxit5G/CEcKFmipi+TUwYZdeRKnbfIDE2VDTHESezI
	 WEiKejak8KRiQ8k1lENItUAWEZe39XOahIYmSHxTBX0F4ZDvMeL28OuLWE+Ab5afHP2lf
	 NyN/SbZw5Iwua5Ju1rxXLRYK1T6htr27dLI7RJ5gaHYmpkowyXDZl+fIqkQPveBSfQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489056;
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
	bh=KHH6guoH/sTpgcw3O6s1B2A9kS4LAqaTTfGkVDSKeic=;
	b=QqutvR9FAJ2D/27MZZCDUa9qZbMW0PJr4R/vtjcwYQAP2Lb0KT+1+5DPoTEDqasDL4hJ
	 DukUK1K96ugrXDNhhqecM8uanYK8OvEf8tAHPfuxPGrXriZtawcBhrk/dSSdUCSjmaMqM
	 8kKYemUyoR5nxgV/7uw0LeQU6WdfvOQAyh30C2oKaYBw5VnAsRAc/QJ/WZVAU8vBoA6dj
	 MHN0cz3kzEc0uBbRPE/KFjpPb/UO/b4t871Vu9t1/EyLyutT6zmRcGdmTaPchTvYlX6d7
	 q61dHdJNrmwzgjJvcWPqgezQAcntQ2VAYK5fTul5dOoj6bpjtKmH5xFUD0fwjA1slOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LbpaDw9F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.4
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05061606A319;
	Tue, 20 Oct 2026 09:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05061606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LbpaDw9F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDoTDc6gnx6mVA4SaE0QF4kmXLHoXIvS1eApwXW4V03X/CDebKnr71BZ3gnd8ZJZcVkYQ+B5PYEzR4A1St9X2WWH97e86Cpggj3N+QW05L4iU2R4sJZ1d9nK6fXAXqmQNW0QK32iaq3sKeyhPM0EYrCQFJipsH5qeCcVONbgjrQBXSAaAlSInZo+Mk8hWlnO9anMpaFbDdRgtWrPCQgi2Z8CpyFlJh4TIaga2n9yQlmGd3gUfU0lSdFKiu1OK+zDQTyYj6d3ltQx+kdLrv6kClYKc+PnRH1wTlV9PJuGg2Jq8bpRHB9MRsETMjIoKfDz5AWc2ckahNmNor14rJ3whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHH6guoH/sTpgcw3O6s1B2A9kS4LAqaTTfGkVDSKeic=;
 b=LiN9rbw7Z2iMCrQ8r1IZ274+RQuWSjmf5nU+5myyyIiLUN172zbhMcn0kAtHPyUM+LVw5RttFr2iXpTHMnKp8srynMG5KlxHn5KHj60h3bgBeRTFj87C2UxdmigmbIOfIw/YPLsqjh4oynrBg3qTIMRwLZ+0sfQPdK1Tq56n6TrWRSX8iAmvYcInAieN2X2mGSHsZockhD/F+P5hTsH0GXSRQnOGJ4tbjkLV0cJMrLH7iZv5C8nrq8PrjBFZcyASgyPTPChhMti8Od+tWFsd6b/OCcWOz0Ojr8z2YIKZ5afCI+RlWl0o4pRmJG7Xx/md8IygxXF0dY6+9Z4c/4tWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHH6guoH/sTpgcw3O6s1B2A9kS4LAqaTTfGkVDSKeic=;
 b=LbpaDw9FcRmxCfWU+FDbYMjWzywesJOKlp+xQneWpixTra2/r1bX2PXxfrDO1m0Dp0N75UyeyEoa7UBLJ8NJwDU7It38rC6PPTNPns2guZXclYFQZd0N+VFA3Wd7qrAsQ7SCA1CVSsxHp+cJ9c7jydcylzrsFnNC6AWH1C3IA6R1q5yWRy+3Srx6tjK2q7wtJej7MDK6Sk7wxC9x0U1UvoEygllYze/+Ofxz5a0NVp8uoSZzgjce+xqouWXEjYS0sFWAa2PaOgvnwvGvXyJTTrcR8byd74GISNjLfGyk/re4+PYst861MKnuEYcV0AB76Z+mlAFsZwcrlj/r2GYysg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:37:32 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:37:31 +0000
Date: Tue, 20 Oct 2026 17:37:25 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, jgg@nvidia.com, 
	aneesh.kumar@kernel.org, aik@amd.com, yilun.xu@linux.intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, bhelgaas@google.com, smadhavan@nvidia.com, 
	ilpo.jarvinen@linux.intel.com, Smita.KoralahalliChannabasappa@amd.com, 
	andriy.shevchenko@linux.intel.com, linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
Message-ID: <atc14MnbGUcviAhr@MWDK4CY14F>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-3-ankita@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005070252.84810-3-ankita@nvidia.com>
X-ClientProxiedBy: JH0PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: 009045b4-7962-4a88-f6df-08df2e8dc35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rtgl/sPojWm2sOrKcvSPddA74Q4FHnifrugZywixtifxiCxOWwgqZpJcGD0hJt8pDXbSpZ15BJpdO4k4aSrd6ZnMTNDeI6MACmFVHnnmn5+NY1H2e2x8Ky8atfMxmehDDUIP0pkylpZeqCgk9KV/U9/FWV7JzBEqnfmN/s9mtEQeD1UwHQr248kIGR2dQQ1+y16FjJxC8fSnTalL8y+rWxFZ1UtiLEuEfsJTxckars8hE0I+3e3o2VSjlE9Vivt6/gW/2Dg00pLRQ0bbUXOO11f4WvNJ/aZ7k6x6xvo85msOAsqoXEktfk7lnxMed0S/cCi78+Lz0wsTItah5QL7Ab7NR448/pxgtKg43aXo5SRrl+n2ARQ7b1i56UTrtzfyl5jHc8OgpMm050gT42OwAqoNLmlrUighs7/kxruYU9iITej0VIgNBvhVF87iObPKHZKtiHoJOpc2TyRLm65+G0aenUWJ0Jr9kbvkPFm9Vom7DVklgFFWGTv+3dbffkVtl5F9KZC2ci13Dbr+aArU/j9vBUld7oWgZShDmq/BjsoXlncfM5fMfNKldMDMF7R2Cs8w26HpRpINsDhnGhfyxJ0vIFxu0jHeXT/8N+tz4QkvHvEl8Nylh7E05lyLCZBMPmcMxG3f0BYPoCBLHmcGkPsnHzFywHRNjeo8LPJFMv8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHEhQKMkKIDpV0hWvg5OSIRYxPEjgTtOmrGTkr5FrM5FnHc7DZwVLJJoD/7X?=
 =?us-ascii?Q?+yHlQqzEwXr9jRLskmq5cDI0KxLhcgkVPFc3orJReWQPHI5bTG1afiDepvBE?=
 =?us-ascii?Q?eljnpdc+jamm4kOLyQj68Q2JO580e848WMP9iKFWk5q5biuy4zEWPOXNYlSU?=
 =?us-ascii?Q?/597YXRv3eTud1jJTsRoHvMNDJEzZxs5WiuaqY5YWMFW9odGA7/NWwpqJju/?=
 =?us-ascii?Q?VUoxI9Pp8xYwA65QtcHDIpVFvUKtlM09DWhrqFAcUVfuGtZcyITfEzu2rGLq?=
 =?us-ascii?Q?9c7Ixx4glMszegxiUpW3XT79nYjuMV0ItSe/SpVgii5ZL4jwPg17Eu2g/80+?=
 =?us-ascii?Q?4DBaGYqy0bxewjJhgJFwTCk1Rm7qSU8ztg02vtQleYiNylmPsoH+FphVUJOP?=
 =?us-ascii?Q?UodCUoxwvV4zgEzvr8f3FI7MeXpdZPnzBatfDqpEYMOO7dgH6LbHoi4trv9Z?=
 =?us-ascii?Q?JKyPKW5cG+ynF6E9O0Z1lAq2+VmskFVVqAs1a7Nu1XhRH9zgD9fIQfWrFBI4?=
 =?us-ascii?Q?cRiobpP74sDnRT6dIRa2FsyY1NMnuGPxLyMYJ0dWCMFmHvcy8bf4p4Uzc6oC?=
 =?us-ascii?Q?e03wdqYDxmmGibsNWugoc67hwjxj7nA8cVe7bOzRkXETd5ZAZMHHm3OB4FR3?=
 =?us-ascii?Q?zRcJ03w2I7l6OL2J7b8MN+L/TRaQJr/yrf2UogvYfnkuGLYoOagNqGu4cp+/?=
 =?us-ascii?Q?PfQTI75gm2tZx0NgWznIzrldpseEfcqVq3wdzgg/Ol9G/iZrPxBM7ZtlxbEN?=
 =?us-ascii?Q?gVtKLiLrpw5d173Eind5W9OMb3D7bkUKGIJYk6XDWOsg6RiSQl3L7EIFXnZF?=
 =?us-ascii?Q?3Z7PBpUCuxw0iA0QakQKekHWMN98MPueexkuVw40uoCOLXu03SpEDi5nZkss?=
 =?us-ascii?Q?P7mq35s/iIwJn1KsGP6o0GvhXeSbyuGh3rxR0w3SRGtXDY8uiwvCdKgR9nNE?=
 =?us-ascii?Q?p/9AxGCJupLPbuvCvc2xFaDeCKHgiXziGpAxYUzpYUH8PZ+eLH70zpv000Bf?=
 =?us-ascii?Q?EdeKKSZ6GVsOoMEE5YhqDDYeaTOBT9lLQZHsp7tXEJgPUP4o5WbJ8EIaUkvb?=
 =?us-ascii?Q?4jb0RAOvanMNZ6kY5b6V90RJ35S6gKqeCepi/KiBufLY3C3SKsFgAnG9ejzN?=
 =?us-ascii?Q?Kmo9R26Eoz8h/av8fMoFi+3DtGKA72LPXjEbmHSOaHKJQj2KNTGnLCMaFknQ?=
 =?us-ascii?Q?lQFE4pq23Ayn5ghxPeywCZQ+dJL1X3z+sZ6M3g6KRj6Fgu40WMbu2Nu8WfGw?=
 =?us-ascii?Q?queu0q4e+lGj44zLjfd+rHahXebsfpUR3DFxDTxt8y10rZS7urgdysVicXMM?=
 =?us-ascii?Q?Z7DcHUqWzJ/mu7aXDWHG4ON0fICkyaeVVtE4YjVhMbch0flOsw35O2/S9Tii?=
 =?us-ascii?Q?Cf21RP9bVHLtLgXYxN3pfxsreg5p424xx6DhXAmHhJGmqfvWsRWlsBzwybIp?=
 =?us-ascii?Q?OwMaiEKfcaq8kxwgyHGWob7xxa2UVLVVsnCJast2F4ZoNbtrRyi9TmgqXDz5?=
 =?us-ascii?Q?WUjXM+0Gc2qKZmWSO1/O8vXFf6+FFaGpHUjHmh11vNjfx72Pjgg1H6H6CxSH?=
 =?us-ascii?Q?B8pnFK20T58xyCbug0TK1ta/lkTu3EANl+61rIjloXObiSNmXh9WQAkYblIK?=
 =?us-ascii?Q?ri3koM7a45x/J3Oo/w/uY5MDPuWz1aTWPaeKWOUM90C+9vdisDYFIgxoixBe?=
 =?us-ascii?Q?2aLzIcsBVzxlJ7RvJFID4a+XpXbvq8rGOPJoubpfOwU7PNje?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009045b4-7962-4a88-f6df-08df2e8dc35c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:37:31.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RJF/d+D/oRucCQduTAVx/woG2l80kY5y/BSezm21RaSrtd/zn9F4k2bD+RQyXK6oM9mWhoKwzsHQfMvYrZzCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

On Mon, Oct 05, 2026 at 09:02:50AM +0800, Ankit Agrawal wrote:
> On systems with precommitted HDM decoders, the firmware programs
> the decoders before any software runs. This range also stays constant
> over the runs.
> 
> Snapshot precommitted CXL HDM decoder ranges into a new
> pdev->coh_resource[] array, so later code has a known-good source for
> a device coherent (CXL) windows without re-scanning decoder
> registers.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> Assisted-by: Claude:sonnet-5
> ---
>  drivers/cxl/core/resource.c | 52 ++++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h         | 14 ++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 3422139ae3ab..4d2082c8e321 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -404,6 +404,46 @@ static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
>  	return ERR_PTR(pcibios_err_to_errno(rc));
>  }
>  
> +/*
> + * Snapshot committed decoders into pdev->coh_resource[] which is called
> + * once per pdev before any driver can bind, so a populated entry is
> + * always firmware-committed and not driver-committed.
> + *
> + * Insert each entry into iomem_resource for /proc/iomem visibility and
> + * conflict detection.
> + */
> +static void cxl_populate_coh_resource(struct pci_dev *pdev,
> +				      struct cxl_hdm_info *info)
> +{
> +	int count = min(info->decoder_count, PCI_CXL_MAX_COHERENT_RANGES);
> +
> +	for (int i = 0; i < count; i++) {
> +		struct cxl_decoder_config *config = &info->settings[i].config;
> +		struct resource *res = &pdev->coh_resource[i];
> +		struct resource *conflict;
> +
> +		if (!(config->flags & CXL_DECODER_F_ENABLE))
> +			continue;
> +
> +		*res = DEFINE_RES_NAMED_DESC(config->hpa_range.start,
> +					     range_len(&config->hpa_range),
> +					     "CXL coherent memory",
> +					     IORESOURCE_MEM, IORES_DESC_NONE);
> +

Hello Ankit,

If we encounter zero-sized HDM decoder here, the resource's end address wraps
to 0xffffffffffffffff.

I think we need to skip zero-size decoder here or explicitly make its resource
empty.

Best regards,
Richard Cheng.


> +		conflict = insert_resource_conflict(&iomem_resource, res);
> +		if (conflict) {
> +			pci_warn(pdev,
> +				 "CXL coherent range: decoder%d %pR conflicts with %s %pR, leaving unpopulated\n",
> +				 i, res, conflict->name, conflict);
> +			memset(res, 0, sizeof(*res));
> +			continue;
> +		}
> +
> +		pci_info(pdev, "CXL coherent range: decoder%d precommitted, populated %pR\n",
> +			 i, res);
> +	}
> +}
> +
>  static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>  {
>  	struct cxl_register_map map = { };
> @@ -442,8 +482,10 @@ static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>  	struct cxl_hdm_info *info __free(kfree) = read_info;
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	/* Another initializer may have published while we read MMIO. */
> -	if (!pdev->hdm)
> +	if (!pdev->hdm) {
> +		cxl_populate_coh_resource(pdev, info);
>  		pdev->hdm = no_free_ptr(info);
> +	}
>  
>  	return 0;
>  }
> @@ -466,6 +508,14 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>  	info = pdev->hdm;
>  	/* Unpublish before freeing so subsequent readers cannot use stale state. */
>  	pdev->hdm = NULL;
> +
> +	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
> +		struct resource *res = &pdev->coh_resource[i];
> +
> +		if (res->parent)
> +			remove_resource(res);
> +	}
> +
>  	kfree(info);
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b00f5f38f77d..ce724d067fd2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -148,6 +148,13 @@ enum {
>  	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
>  };
>  
> +/*
> + * Max CXL HDM decoders tracked per endpoint in pci_dev->coh_resource[].
> + * CXL 3.1 spec section 8.2.4.20.1 - CXL HDM Decoder Capability Register,
> + * mention a max of 10 decoders for a CXL device.
> + */
> +#define PCI_CXL_MAX_COHERENT_RANGES 10
> +
>  /**
>   * enum pci_interrupt_pin - PCI INTx interrupt values
>   * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
> @@ -572,6 +579,13 @@ struct pci_dev {
>  #endif
>  #ifdef CONFIG_CXL_RESET
>  	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
> +	/*
> +	 * Precommitted CXL HDM decoder coherent ranges, snapshotted before
> +	 * any driver binds. One entry per decoder index. Only written by
> +	 * pci_cxl_hdm_cache_init()/_release(), outside any bound driver's
> +	 * read window.
> +	 */
> +	struct resource coh_resource[PCI_CXL_MAX_COHERENT_RANGES];
>  #endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
> -- 
> 2.43.0
> 
