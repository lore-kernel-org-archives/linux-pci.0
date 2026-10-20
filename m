Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792488287;
	b=AyM/6orKlnnV27Wcb6lafz/5IPHqUUMyG8gmzC5qLCzYF/FW5KPCN1yG1RIx/eEw3d28
	 Qpr44bRd8wuG2f/O61MPji2WF8FnoFQz9cMuxdaaR4xk/rBVKoPyc0QdDpB3VcNhviee0
	 k2kias/pZctA8dbKYHLsF07oZOCZ5vUiSfy6VqFCDCgwFSvKjZAUyRNrPHmdRlvZOJBtY
	 YB7G7UEWxk9o7CD2GSZ9vO++F/gpa2jJo6N3GwTgA7AGgfyWmOPGBN7llklRcUL4sZhti
	 apB06pKJFfD+UBUjYc9zIAc7oHbo9Q9QSrUDB/VlLNpvIeWWYgjC5JCDaLvYi+MCv7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488287;
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
	bh=YUGnmtl2US9QKdCvJZjjr0nj2/UDyZmzSwW10sDIl+c=;
	b=I/RuD4A3ddKB8WzEbSxWj6Yi8rU6zQ4HBkLlXFyBEztb2WaGUHOFbg+mu1xiset0Q9eY
	 3tgGjK+uVnAaapGbaNDzW9AB+Sg5ZxRGWJoVPfW3Bfbm/i3LiiNPcvaV1HiKBwLxxLQT0
	 dQwT4XcXxpGp57kdiq774litCa935eky+iVVNTcWzC6yRHWNXazdtsAZvrX1obYWUG/an
	 SsgBUpnNPoXT5EK4cLKd3UondzBHRoeHZDrm7Xxbz+z6xhyV1DatWwTyiYY86DUApjLJQ
	 eEtpGGedPOR2J46OD4VfD+pM0QMFYskfRXxUp9pQ+nEHpyvVbTeG7Bgi6lVstjDpcUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BNjo1QcZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.26
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3A606A320;
	Tue, 20 Oct 2026 09:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E3A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BNjo1QcZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiYT+em4279AwdgKpNI9KlzFbTmNEVCwRKjFEdBuA8RA1SsarIbsBINsnGEWthuSs5ee1heEkXvwfJsSF4nPyEMXSsblxvVqWOrsG4V0krch6oXgwxKi8KcNr62fMpbe6388AdxtYNqUUOVuTvsKjE22zJyagBZGPrHHW/HQYMdR/iVrdkjPQ15RsRe0e5/BnjATBbChSePbbbgRpr+kKHonF+useWjquKMS9tBRMlgBhkorJ69M9z6gdlPyZjXE4Xjr4ImtnMcVXB1AG5GBElajl6/ZQ4/FDus82zxcPJtHqmllY5I/DH9xbXBjfepq2v7W+OVptx03NDPpEulgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUGnmtl2US9QKdCvJZjjr0nj2/UDyZmzSwW10sDIl+c=;
 b=AC6vQq6SjNfTJmCdCQ6lrZKI8UA/THWbl+8jULa1mJ+vovj1c49Rn4O6GY4oDl3waM9gTqSEKIIVdrXCZ3VbI5zB5+NBeiCLxMPZFr04mj+6prvkFl+ANj84jnS11leC4sP0WMjkbxYQG2dgzGGwSqdF9pbgI0FdDsqtZroZrGkQQNpX4AZDBEDDrrO9Grf1tL85S88aMVl+5ACnQO5l0FRGwFkd11kX9a6Joj3dGfRhLN3qpOrbp1b2jQcHnLcRZuPhmOZyYEkgPFtWC9VVVWf+rr1xueMpJaQCasOA/02t/QAzdM3Vw+c1VStvKb4SdYbg4lTS3ioiFroM6mV14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUGnmtl2US9QKdCvJZjjr0nj2/UDyZmzSwW10sDIl+c=;
 b=BNjo1QcZKB+A8EB0CUvjTp/mdrA7r+VQ1GA+V0cQgCDWXi6Y5ixkUq6EuQirFPXcli58XSzhY5Mupbv3u2YccfiPWfjuRut6+uqKjBhban+cmLMqjKWvokojlUdcDRwSPPsibQ0q7C2P33w5TyrKhOsep8fP3hWAuH/FeFx9jQsSS5MVKx9z5uT88jWXfmtzFggAWdsHH21pETEU4Oe1obf/l2NoWLd+24R3YRfOyvA/7t3+5jsHFzC+oT8pv6ar+Yi/f91muGeLBl6RevCPgxwlzKiE4A2LJLU+6dZd1TQ8Fk6h200klNASVEa/kqQnwPTzgnOFb8LmsA2djrK0yg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 09:24:42 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:24:42 +0000
Date: Tue, 20 Oct 2026 17:24:36 +0800
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
Message-ID: <atcy66qjDFKvWk-N@MWDK4CY14F>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-3-ankita@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005070252.84810-3-ankita@nvidia.com>
X-ClientProxiedBy: TP0P295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::16) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 069d1f26-ca81-4da7-cb79-08df2e8bf8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ixpWImL6s0MozJNZya0TAzoe5rxwSdBmWxjad5hSSOy3dEHDQvWwkP1EI+p/l1/e8QKbQ4B1pcFlIIeaKVyRQ1ftNT/FeNdCHvXDIETZ/keN0plUBXlKx4bEdMEzqEYVcqG7FKCyGw/nlThTlxlUuLG8+GX3KlYILKn1tiVmaAyvu3Jr4QGvdGiXg3xGZKL6IxvkQNDk2j66adR+Ww5FSrg/pEQgn6yXrz5j1bx4bChD58gsoMKeYbD2UexLMGk+t+UEaDHvbIVhdrmdqDJoSgjmbCgV/NpfQFxcQATg8PY5FsYhXuvP9odedsO3+XoP7Vzmlee+jcndTHNda4zUt8tKLcflt10kHaaAqxfyS/nVG+WDxNYiQsG2iJK14XoXpN766WDS8ivC6A/D3uz9MCcHi+HZG6xBbk5M/DJbm2rvP6rzqtaqOyKQ5B8Ngzzdrl1+7+1AP43lnt1uPsDx3K6lhOW8MWGSxJsbC4sJ1NWPgL11YBy+LUfbBpuYSXV1B+zZSXvQTIe1mbz1YlyfVFjoLsjP9dmncAvIRFRhJSmnyGXIWlF8OIvjqxGwpBUELpR4gxBEjawoLrs8hA+sVfhuQZxJvXeqCWpm7TUaByjUEW6BvTNxkr/5biGM20MeA4GXyC9/qzqgDPYRNwICaMvjZmjYyatfB/ucbJsbfCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I7PSZLYzpRxQ1bJJmkUV1E0N56SNMUUMX4B4eaB8tjDy5WLoCicqltJBweR7?=
 =?us-ascii?Q?yg4Z3tAXL7MbFfsbTw1qh1VK5S+oDNM5siCRhR2dsJzyeaqW8dT9gZgu43tj?=
 =?us-ascii?Q?V5gofjwCUy1/JiwI7CbeiXYManNod3ELcANKOgidx3htG3EzPrnViGgdRt8Z?=
 =?us-ascii?Q?NHsAm78Hd4HAOfFGIa2tR8AKAbpYiklnpkaYp44kJxZoLb0xke8Zc/ZKtKSe?=
 =?us-ascii?Q?W9SwNo0bSm/+exA0ZcVgcg5HcQ/pTedVXEhLQuFy0kOO9F+40YdkG5HgPreW?=
 =?us-ascii?Q?O8OAoxZDjXRm1bCSOnTH/ycXLspb5f2rtjOh7dxLseZ1CStNcylJSifaRQV0?=
 =?us-ascii?Q?2amcPacHv0o12JXDPFbKE4I8SUMvxL00NTUjBI0M7In7WSPATM4MuW5bVYJ1?=
 =?us-ascii?Q?I5UD7IxrjERVMXYA60liVnVGqv0V3NiHjGIkleGUs2ooxCBHnNcd6hu1PX/I?=
 =?us-ascii?Q?VKIOr+8YoQLi7IgCy5BWlidf2L7sdughoKljFuHYviczk3Kf3KfcBUxj9tNt?=
 =?us-ascii?Q?+JzYOOIWyGdqZlO0JGEn7BXF8pnBWXIivpGU5+37We0oaG+lCys4KC39SWhr?=
 =?us-ascii?Q?o4pOhmRscv1pvlEtiHAQUas2aQGkeXaExBKYxcqRoYnh6jKcFdEqSmF374mo?=
 =?us-ascii?Q?dN+1HQbvLkFy0oxTHk/7MBK6dQv/OUw33td8+aqMNt4aDXPY/FIghkl9CdKj?=
 =?us-ascii?Q?IkqzxVUL8zpKzDdUc4qQaz3Ah9qavFkh47Me7B14sADfuUbdSVU8JfTYtl64?=
 =?us-ascii?Q?+j0nTw3qccWmRxW19zQi5eTJq5FYP5OxZUYwfql4tFzL1TIwjT0vGkPa6dxF?=
 =?us-ascii?Q?/3jQNitE7fdZx2/ZdqgrjUMWQhxbf9ZcwcN+DSRHdx8WBnhvDhJ9jlkrLfqL?=
 =?us-ascii?Q?+M+LCi+bBQYXh5cljgpDGK/wqVDIbHoZ0vVN+CQFRMhMlskWMyvVFU8SofRJ?=
 =?us-ascii?Q?eaeLvDdO+HX2D83QlhrG5ep2xnuRU2yzvukk80HsYscxidzh132j2xCGmAsU?=
 =?us-ascii?Q?7L9wZb94f9LkJLEx+0Sb3BL5g+xLF+b2vPEbfgXuZasR8obdQCDL4wgKq88N?=
 =?us-ascii?Q?0J0d6rQeuBiMxWhND5WiDMy9VEjm++RiB8XS4FIjjWiECKTH2EvM2MJZ8SG6?=
 =?us-ascii?Q?Z6dQu+SmvYYPHlnfnidlEKamij/4BQwR6SrztPDU09AgLlPRZUcyYgmoyZNy?=
 =?us-ascii?Q?JrG1P2xceUvJn2zBE/8LAyml2CZsRkaId2H5aZrPha1eRZf1SUIwLrxZ/wTM?=
 =?us-ascii?Q?3xYyGTcTy/MRxTnUVviU7zS6SASOEBk0JIYQxTDRGfk2s4VkYIl1yfhk4BhC?=
 =?us-ascii?Q?RWp4TIX6oD6VODV03NtYJM52RjoguwENEyUwYkwadBUj8wFZVzketnWCkrRs?=
 =?us-ascii?Q?xJw4A29YzfJgmFZaj1DDrzhBfMs74AlsHm9RO+LKREy7PL327yALXHa3+zW3?=
 =?us-ascii?Q?2PPqLD7CsYDCl1eyrvBvdjzj5xZb3GX45jfpblGgvUUhZxbgSY2t2+UKOwmu?=
 =?us-ascii?Q?UYQW7rUnRCMiJ8f4QIXTQsAMhGtnjNQ4DsKs3/e7yU11fcHX+JCeqwV6jcs6?=
 =?us-ascii?Q?7HxHfPfbAyCzD4pvcbjF6xRVZOOYyALX+kiLT5uKn4emybW1nhALfesrHbkE?=
 =?us-ascii?Q?hpmqgES5KX2LLib5CAhr6ffKK5y0PQz2dKwv6O2OfpR0ppu69en3QUOgOt7n?=
 =?us-ascii?Q?wjbYOGv2XQDMLBfCk53RuyS/M/qdoWbYcCbB5CLKl7U7Ojo/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069d1f26-ca81-4da7-cb79-08df2e8bf8bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:24:42.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpodIfpGha319udaz9g+GdZAKy6vfP27v6f6fpQNYrx4leMXu3DLd0FyC4g4MDmYrN54T8TUShLVYXTZvIHwCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

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

Hi Ankit,

In cover letter you said decoder mappings are fixed and locked, don't we need
to check CXL_DECODER_F_LOCK here ?
An unlocked decoder can change later, leaving coh_resource[] stale.

Best regards,
Richard Cheng.






> +		*res = DEFINE_RES_NAMED_DESC(config->hpa_range.start,
> +					     range_len(&config->hpa_range),
> +					     "CXL coherent memory",
> +					     IORESOURCE_MEM, IORES_DESC_NONE);
> +
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
