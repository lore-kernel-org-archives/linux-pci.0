Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6200EEA8;
	Thu, 17 Sep 2026 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630138; cv=fail; b=AO/Rlj2jt59YLMng+qd/S0JKfF5hbUdeRYsE2y4i1Z69CpnBSnlp7M5URR6nUrMKPhMTl88qdlVpJbzlP6B9llgVpGAs4OoEjcIPYHXyZUgUEpPCO/6BaeqMR3C7ul6u0gbzItDGWTWtv5W0dlofWse4TrQf0gSKtRQkV7AvYZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630138; c=relaxed/simple;
	bh=9TeK3PKZEFkxWypfPJTHzKbdoIPfn0BDgfDOhnty9r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZkVo7bTqr/eJa8ISlYVUon8o5b9N/3oa6pDBFWhz8hHvK0oSxJQwOHA9ZO31PJiuV8qXVGD0B12Rk5SDyMtu5OG9JzddRu79glcRqF+ubtkhytRTt9Z4ecxTeworMge/XKevtclb1YAMfnXrw+ZIeljRQJHDbOIAod+w7u7f6a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JLltC5+k; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JLltC5+k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH8kbg6I68xEOdXoZ99CYxedoDV3X/VydcwENIJPSp+ATFFFMWTQmJNvk9S9KaLJzDAXpvEIh40zCk2IPLwXkjysmcNd/wib0kkaDdiE2gzILUeX/3kUirm5jwwRIPhHqJC0igvuHiUAJBQZgw2ItZENzvHH0DVuKoe0f8mbalrNX8vq4ACGo0yhIRxo4fwh+g2JFxh8QR6Uc9xwfKZS/eoaMvgvWrMW9etOvyMNgEWYaZJJC05U6p6NFNxIw45tiljJC0UZpKn+3omzAFjoNW1WYt92KvfMEXxqu1RJ/R+pW9tqvbw8cbgNKznJsgH90TGGKdMlMtS7/6QQEShNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZtHcMUPMW/lnq7y5EyCfMaprNKtY1+LB6lfulV0fm8=;
 b=nNyJMaEsteyF7ccraGMVDBz7GaInkLe08WjS5b9zUxN+XMwAXi/Nf5Uie06VnzebNil3qZKCNYHWMOxm416nHGmO8HeRhCRcHjDYAzyTMn1foe0z89BxBv0FZ4B50T6UfKU3b7fMx+jpDVOQz+nU2OI3FrWnkU6LKS5woj9BlnvfB2wGlSW61/w9E3ejBViYDsu1jKzhsX+k4jERmuYvWlDp1B/fxCub8lm8+o9tNvC8K7iJE+Rk6DWNsI0kHjh2pGo0pu4fYR8bjbZXm+bYtGBiSoR7658cta8U7TJ3zMpof2DnLmqyeU87CkyhayqeZhM+SI8pMm4UXa0x9IY7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZtHcMUPMW/lnq7y5EyCfMaprNKtY1+LB6lfulV0fm8=;
 b=JLltC5+k465UFVmVbzDAvTwXwxAaK6nwCT7facbt0yiz8j3aiM7UgAcQVXDQwy1HnUwFiwsnwA/UDMeOQJmUQpF6dhp1kI98g5Utn0UoOh79PbwGxbOyHs0nAFj+TeO1GqcGT3Fx/uOKsJoHdXQRQncDAdKbp7rvtLV6I9OI4EoluJW0qxdwFM6nlX8Owe7/DNxKs/Y2qsPEqOfF4GXZeSqNOXM+t7STAKfr5nQnxIpcVD4/zSlxCP8bL/4EytzFO/H6+C3tfZwNAYX/ETrL2Xz/z05xTQqOxRfekpmzOumxeYI7u7M5qABrOZ7ZUvOWYT63e9+viLYYEuK12TE6YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 07:28:51 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 07:28:50 +0000
Date: Thu, 17 Sep 2026 15:28:44 +0800
From: Richard Cheng <icheng@nvidia.com>
To: mhonap@nvidia.com
Cc: alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com, jic23@kernel.org, 
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, dave@stgolabs.net, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, yishaih@nvidia.com, skolothumtho@nvidia.com, 
	kevin.tian@intel.com, bhelgaas@google.com, dmatlack@google.com, kees@kernel.org, 
	gustavoars@kernel.org, cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, 
	zhiw@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 21/27] vfio/cxl: Exclude the HDM decoder registers
 from direct BAR access
Message-ID: <aquVEF7pLCpQxYwa@MWDK4CY14F>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-22-mhonap@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916183540.3813685-22-mhonap@nvidia.com>
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e34200-8f56-4d18-0d51-08df148d5180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AqlmVtm10IIQsSx699Gs81AX1Uk+O2ueTh5qI/MzyQM+kU99K0Hl7+0jkYhuXH2m/BezGa/A21zNT9tmvc1GhKfx3kpvodLka7ssA/V12owJmluxzGTO54aeW7HQuqgqKUSgBzMRiIaS0PDUAgcymDFCCJy3DOxMWGdNyupD/3erzLs8eOFxuzzJhypnDvOF920AQblzYZqitem7S5wUrPVMXa9QPGiXgILv6CjiWoMyLBM2LiPXbc7UAKH6+7qnL3ju/NgCxee1qE0MOIJJIBYKcNUehaspMRndk94U8E194pVcuIB6irNnStJByI4tLyNUqQeQWZPNSa++WZRza6sGQbOB9/zCnWvNgLmJu/Z5iGwZpMSoUKE/7ThnYpKXW05UFvekBTq4Nxz7Na7ODtfMetBQNe7UAul2MjWFw1skwDQvJbDncYwRF9AC64IFxXWr13xc/hM5uA/MILpW9XeMqbQNd9WIUJ8LWX1eoBCH5N3diQ1vbCflimRNbSSsnl3hBxAtnbY9yMtIK6L3GAwKNA27CWdEotUu4tWgqc1ivrY1TAaoTG0BzIneq2b/7UsdfVdmrrQlRY380zuirt5kQnIy//srke3I+g/MsizmhIrj1WbIDGtEaENO+/Qt5IZ9qoGQrgFIxyc37QdtMam3vmDTwRLMNUP9mnOz4xM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qYsX1wRTr00oeBIun8CVYKOvKlWKHh4HOBDPY+if//JvTVh7/9+DY2pG1+an?=
 =?us-ascii?Q?0LsQBTAOdfk+R9tswgdmQsEPlcmawSQ+AmrOp52PQbC9fR7FoYvhxug6TyPU?=
 =?us-ascii?Q?qD7dUXcMV7yrkrtkY7q40jsrxYBAdyoaLhqw4RQG6Xsb2I4z40F9KrV7zMvd?=
 =?us-ascii?Q?axLKTysN6SD4/nLNyd4kVae9K6JN4q8jUfejMrHBa0MfzSJ3Dtf7q0BmqmVa?=
 =?us-ascii?Q?SUjb5QSfzXq7GQvDTGhAMzJxSf5XqlZE9dXTg4fQjnERn7pUXIkg6ezltIBL?=
 =?us-ascii?Q?LmpuPuRYelSEHdhlaP74ww1+Avev2RtTW7UoQCBGtnpZwKArtWS6YZKGxa8L?=
 =?us-ascii?Q?7XuQ88DcNqPSsYyqUdB2GwcdF1rdttKBYiOf2VNZ4LZqnRb597B2e0YyfKfE?=
 =?us-ascii?Q?UcxU3JZ4bR0PxZGUwbVVw1qoCoK59zzDUPyYFy8x6i85d42CIrIXUaaK6wgS?=
 =?us-ascii?Q?iiI3wb/QgmXCj8DznjrfmEdkA3cA0QGUdLeHsf7e43/BRWlolSvOt+KkyXCr?=
 =?us-ascii?Q?ITs6gq2MC1gUq7JtfMJ1Q7Phr9SxTUynX/4p+hTV5nPh6cxXgUI3xUc7pf50?=
 =?us-ascii?Q?yIz1DW/whNXdRRwdJRSMm4gLUSKBswAwhSFZPTN2IVDcJby4RhBbkKVCJc5s?=
 =?us-ascii?Q?u+mJdq3ELbTxK9z0tAiHqkAL18rU6AHFdw0HvIWHai3ZK3OmctlDhWPdd3t+?=
 =?us-ascii?Q?3zoamUQKB78NGSTerEZdFHuVTom9KaIt79snYwZsQGENGUu5ksy4njKwJMER?=
 =?us-ascii?Q?ypnzDopfmtEHP8WeB970AhwamZNk+aYsrTGEwsrsCU1//yCFt2bf3TNkC9WD?=
 =?us-ascii?Q?H+OoN9IxUtZ5UxsJtmDTSCEXlqO+jtBaXNHHJpoe42MhRj+cDmS3WzvUaxUx?=
 =?us-ascii?Q?4/XZBqUp+MsJPynbMQc4Fu/BKd9ioPRXZFV/shQ0MfMxi3WZfS+Dai0ymaoP?=
 =?us-ascii?Q?93ZWTp3ymMZIi/1Dglr/h3JUi+q/rSN94MrXWUek9Iemhe5aY+Y+fj8YZg1a?=
 =?us-ascii?Q?o3LPtPdjICs1s0tarrDRvhMeYwUMGsJs8hLefdJMumkQkRY+ktz/uhBQYx0Y?=
 =?us-ascii?Q?AH0mkUa2IHtVUtpt0rAMtesbCPyde9AF0d4EKorFA1wQ9Pkf46tKHl3Kp2wE?=
 =?us-ascii?Q?ZBGd++m0Uj13AsCPRIZ3ihBQX31g2Fl2wRsR/xDmHwfKSMjNNLavq2fN5Yo/?=
 =?us-ascii?Q?LiiE/+WTp1ZW79ZbmtZhkAkV+kYTLbpP5rK8OXYZlCueZiT4Axwf7/e9uvPx?=
 =?us-ascii?Q?nlrq6jVE8aMtAdLuXp0vSvGj6ocgeQ736Z3OEyPzGwrwlwxyXVy70QUnicMz?=
 =?us-ascii?Q?XS+BcAvL6Fq2nGMeWRcvb9eAdxHLRUcWqA/op/1c7VwyK5CjOPi0yjWlicuV?=
 =?us-ascii?Q?ifzDvzKMydZ3mMAjIiW0tiG//2/dlktCHg49UMF4HLlM/9+BHKryC/t2ybSN?=
 =?us-ascii?Q?Zi1Lb16dm4EIhsUO31Ojag3O8+YgckNSMMAt32OD9Dhl8gusFaOS5vHD+e9d?=
 =?us-ascii?Q?WbfpxHWibpAT7BnitMD3z/GraiAgdfBaIFMOJBrFERgLuW+o2cTRfraG0wFp?=
 =?us-ascii?Q?+tI2woxpCoEEGQSuJviS1dOfBOfdEJ6tOWwrwjnwruUq0h64mbuJj4V+TuXf?=
 =?us-ascii?Q?UoyVwaFNeNmf/KgHvU9JiyhiAyqY4c7fc/dUWxmQvO1LLdlzpytj7EZOe0NM?=
 =?us-ascii?Q?Gy+LLzwuuoZrrObwQEywKtdJlBtHSqeytlJ35XTqNVfJxcpp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e34200-8f56-4d18-0d51-08df148d5180
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:28:50.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGZss3jtUMRDTqHIgfYJnH36HupDWhdvE1wRXwFw/Kd9H8/DJ7avzeVkX5pIeR59hWr6N6W6EW/1u99ENfTL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

On Thu, Sep 17, 2026 at 12:05:34AM +0800, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> The HDM decoder register block lives in the component BAR that vfio-pci
> owns. The guest reads the decoder only through the trapped, read-only
> decoder region; it must not reach the physical registers through the BAR
> directly, and a host read of the range through a kernel mapping could
> abort as a fatal host SError.
> 
> Add the block to the generic excluded-range list with
> VFIO_PCI_EXCLUDE_MMAP | VFIO_PCI_EXCLUDE_READ | VFIO_PCI_EXCLUDE_WRITE
> similar to the MSI-X exclusion.
>

Hi Manish,

I think we need to block eventfd write and BAR DMA as well ?

Have some comments below.

 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index da04776356e4..37e8a3b54cfb 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -435,8 +435,25 @@ static int vfio_cxl_add_region(struct vfio_pci_core_device *vdev, u32 subtype,
>  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct vfio_cxl_state *cxl = vdev->cxl;
> +	struct pci_dev *pdev = vdev->pdev;
>  	int ret;
>  
> +	/*
> +	 * Keep the HDM decoder block out of the guest's direct BAR access: the
> +	 * guest reaches it only through the trapped decoder region, and a host
> +	 * read of the range through a kernel mapping could abort as an SError.
> +	 * Exclude it from mmap, fill reads with -1 and drop writes. The list is
> +	 * cleared on close, so re-add it per open.
> +	 */
> +	ret = vfio_pci_core_add_excluded_range(vdev, pdev->hdm->hdm_bar,
> +					       pdev->hdm->hdm_offset,
> +					       cxl->hdm_len,
> +					       VFIO_PCI_EXCLUDE_MMAP |
> +					       VFIO_PCI_EXCLUDE_READ |
> +					       VFIO_PCI_EXCLUDE_WRITE);

This adds the HDM reg to the exclusion list, but the eventfd and BAR DMA path doesn't
check that.

Maybe we need to block those 2 path as well ?

Best regards,
Richard Cheng.


> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * vfio_pci_core_disable() frees all dynamic regions on close, so register
>  	 * them here per open rather than at bind. A failed first open never
> -- 
> 2.25.1
> 
> 
