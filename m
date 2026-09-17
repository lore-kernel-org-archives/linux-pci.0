Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837A382299;
	Thu, 17 Sep 2026 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631735; cv=fail; b=gbMFkLNwhiTcXIFFMGLo/9+Z59Zaq8nBsFgxAAJRWgln94GnO54GCRYRZKGZ0UjuRM0oY2AD1eJ2yQsZ5oBx3hAeMsA38Uq6CtGBpVL0QivTV3HVySQ5TMQAwaaZV6xAdRg1QgrCwDh8CsY6eBCokSPjHmEcDq9KNxCnhlBOUug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631735; c=relaxed/simple;
	bh=uBpItks/rszluHHyO3l95SjIZklv+liV3ykqwGpzmxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HgCprpgntWFbpOimCAG++wIOwDrIgEiGsG1RazekSTgWOmSuTSzrAVubKxsC75ju1xJahIVoe2BsREHnONb1eHR+jOwmxVdzOHlzNXbI43mUAyQXxYvkzhv4d6UoW/iolfeshkWXGvBdtFGBQPnpLF0XGorFWnNT5aXg+bygM9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NjTsE1jl; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NjTsE1jl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTCby543GCV0N9G8+DpsbHlA36OcWNIDmMWrlIY8c7ykpUP9KcyuQTMIyRhryWvNiGxaOgze/yrpqGVQb1L8LK96QNvD+XJ1nvY/UyjMBvyTprBkwi+MBH8EtgNgWMzwkAs1kudAKdZxv/8LMmPx4U0YitAIUIjNdFTub5R64wT9ZKPxfaMB0v5FI0Vn2qfrevOyakKBE1cwGW+ntusY2jYPQC69kROSE/qaKJkw9EmA0X11qHxMLoHlnc6azLIZqOVXw+W2eZD1rllOWQ8kGqeXhyWqzBAo8cQpOjPnPRW+9VdxBHzzZVPDgmFd8t8sAS8igD9/N2bcObmOkIfeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXFrG6Q5Z6eblSuUJ/x0C8YaIhUtegeM+m6hGGOyX08=;
 b=qRqERUxo5YHgry91q45/6BIa7dze8WTs06/H5rcNFkWUsvkJErJlGiokEjRjof/9D5jdkVgMJoY/k78kWmXfASDOjd1I1MIZYEVSNMjMWaPXGME0hoO/O902ITb16DOkHWKsdrboRdvuv9swpNYl5jkuJfo7sDbaoCRgpTTJcprprTZlzfg98sJhDltF4yi0XYiYdp9b0HX1zUtE/tUGUPRiCCWO/zFI0gcSFlh6654UNXrraZMUtxO9dKLJacGnGfUjey0MxR2wbug74jDBEPeH73dDvrPrcbaRNzhMEvNTYQFkYym3QmqB3Hxvg8Fn1gGcKVUn0WK0zwDmOmROdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXFrG6Q5Z6eblSuUJ/x0C8YaIhUtegeM+m6hGGOyX08=;
 b=NjTsE1jlVKBYS9ee8QoB44mApyMd96IuhOu0qDCK5bNqiXg9PSg003xUJgo6bVOOFroyXPFe1OeDvN0LhtCF+f+szY6lPKx+nDBJ5NfKKnZwXwK2l0DZMm/uuwC3MCc/5Ml8m+ixD3cgpylIpR2p8JQYLbxeOuKfuPX5qvCbGJmBPWylybwKygz83hj6ou82dzunKHY3sYF4ocj1TA2SQlwabLM9H2/UlXP+0EkfFJMW0KH6t9Ifslr6jUb0ufGgVmgPxWzv8sC7BkCufrlgBe0lmD1Yp++kS7KrKIwZAYKayVBxLWi1wnF6tKicZvKCgWdZBPE7yt5xordvxNmxGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 07:55:28 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 07:55:28 +0000
Date: Thu, 17 Sep 2026 15:55:22 +0800
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
Subject: Re: [PATCH v5 24/27] vfio/cxl: Export the HDM memory region as a
 dma-buf
Message-ID: <aquaxVHh2O8SUCvj@MWDK4CY14F>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-25-mhonap@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916183540.3813685-25-mhonap@nvidia.com>
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd4afeb-e83d-436d-6232-08df149109b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4v6FWJqKUfIXTZt2twDqFgfZQ2I4dHakCf5kEEaSCftsKoGO7UUBlaKSsYrO0R3FZEqu/vkWgCU6TNsAniQChn8nvhSB75Xy1CTHSuBxZgwdawBuGgqLMag+lUgkYOTIo7sW7g1c5ZIM08C/y3U+WTcOYhkwBEF5j/sQ2+yVi+qMWtvIMW/xGLP4BCiLlTbPawhSYxeAxiUn3bKRUIotV18WiWjXojaRY3BEMtR7tUAbk1alPBIuxshIZLp4JQRuQTumcwTJUopY20frG0dYb+dw+8Hz5qYoR+LzjPTqM4Umn9z5+7RwDX5DGcZnNaXXhBT20XA8nbjDLkmRnZ1HKI5OpYTiG9CYJ1lYvfY9GOuiea0gRze0LmiWKCfzj5GGgtb/0p4784IfduV2PGR37gbIbVvFBo7i3gO4L6amZ7ghGFfMG1Q9Wx8daz9pD7ihPLKgaagoMsHjesrlFltBL/uaHv4nZvH3j0bcn5i0dUXsebAnxOepmm4KZUyhDjXBRMKN9nlM/jVTNsNj3acY1ZWJeBVqOrUFIJxglGSKVc0w6Afx3PugQRgWJHTGb6n2Aypkl451fmnBugj5VMLtC7fxEPXMFepoKjtPq2Uqfpj4ik0ezv/7E136ylHoceq/fe+rOjG1SJ8yB40osOxQkB3SGVJw9XWTzWyIRXb9sT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4liXUnrLR6gFmyllKYtpqB6kYexjA+CZsXmbp7uW93tug3dnnaCwKEFUsc4i?=
 =?us-ascii?Q?+HTItIPmqyyWWeMW3jj7CjFmvn2zpjeEkls9w7d/Y/Jqu+ngMDw4Oc4BQJOs?=
 =?us-ascii?Q?m3HpClmm6Q8rGD7Ey5FcY6oJdPc8APInu/nkLvBQ3q27t5yjSWvQ7N0JxCR+?=
 =?us-ascii?Q?p2e9NoaIjOr8ksFv0pkZ8bIUb2iBIr/JVhpXoWswTTfwMx3CqW5VdLqBJw8/?=
 =?us-ascii?Q?XhpFzP6PMg4Ia9SrzwK6IC6XpgZVaJbcADsxmmgo/XEPTtupyxnHWwjkRtqy?=
 =?us-ascii?Q?/DE8FX5vnMC8eHS8a2wP4kyweB/r09/AZPz/xDKStWKaAfpU8pbd42CdKn3S?=
 =?us-ascii?Q?XkgyVpM7uHABw8EAOjPqStwVjrMBmlxep5Jxe2bHrnDjz75PQ1g+YFmPJyUv?=
 =?us-ascii?Q?N54bUhRvKZ7J3WZOfKv5HD/3717xsKAlG+XNPHZs+tJJ9UU4rgnlahH+oXC9?=
 =?us-ascii?Q?G6P0xnBePOnTNc/6TKqmhFuQIZ7O9P2LqnyQBzpy/ZszJ+fqtlUlO1H2DWxm?=
 =?us-ascii?Q?cOCdBWHBmsJu/WwT5B+pfpQjqKQJrzb2jIHAmw7kBpAfgr16Cpd5fhR9Exkm?=
 =?us-ascii?Q?DUnNGvlhoc4c4EcSF7aD1w1xjdEUZcbAzlKJtbiUcj+cFLXFhzOQEdTpfVcC?=
 =?us-ascii?Q?3j8yt6IX8vzk0UjZnveabVQruvI+JKtwbqWgHM8j494f6Dd5tFOFOSl2goGD?=
 =?us-ascii?Q?hS9y3goVT6llqxT3+IzrxKmeD1IJOshD2ppNuAJk8vSZwyI2cwbnJh1ZMQP9?=
 =?us-ascii?Q?IKpbN8MjT92CMVt6n2e//kPYD1V9qu0YuO6HOf7gtL/94c/Ld4w6MN7wmwcv?=
 =?us-ascii?Q?MxZb9wkw843QUpCa6lnN9/DGInWig5HnJNJjZGaAAQL5f4F9aDHCZQUZak7Y?=
 =?us-ascii?Q?l8mPmVMgNPsk/otVvc/1Mvc1Qj8jDVPuv3E/xYcDZCLvVamTQuXnEZ3mVp+f?=
 =?us-ascii?Q?nxJ0Co9nU/Ri7zd2fD1HXG61+h6S7oBb8eJW4n2iWsdZ9VNUdOzB7nkQO8TV?=
 =?us-ascii?Q?40zLY9mgfY7JV3E3gEn53F2fgIAp7bMkIZDjpdX8oijsphdRiBIE9jyQXwXd?=
 =?us-ascii?Q?Z+qBQ2VPJ9M09EPoBaNxLAcnL7M4tJLcxrIgZ1nh6pDKou96wgZRFXkKYSX+?=
 =?us-ascii?Q?dnPhIM+SN1LEcJQvEvwpBuCsVZMD2awo0NvesDzOQZ9ItfS92hzY9GjmoRf7?=
 =?us-ascii?Q?Lev6kqO4jVd+IhHBTFl0Umy9Y445O526aoBTRru78sCuhwZ8N56ddkL20VSq?=
 =?us-ascii?Q?VBgCTpEUbovf2yPE/Sik0RVF/PuIHoK/6HPTsF90FxYiyvasc/aTSij2hasp?=
 =?us-ascii?Q?7059nYUuU76vhQq/g/lnQhS9MGE/IEXGgeM5uIV3BlZJjGJ71xOL1XumcccN?=
 =?us-ascii?Q?FlcdveKEIlXYmwdi2+d4Rk/Y3bwa01luCVGoAloiTqcK/RxJaIXlq7Ob6maQ?=
 =?us-ascii?Q?NPdi8dAk+5T40qcxLhSy+bcXc50f3HLeR7gi3JUBuJyTVgW3edlxKgx3zSp3?=
 =?us-ascii?Q?X85Hn3p4r6qGmEto2XAhFUijYcWa+d+vzaiCzSx0IO90eIwAob+oztivR0cA?=
 =?us-ascii?Q?1R7lnIIw0GITw8cEhT3/u9CPjeTW3H24UHZpp6X2RVW/nPgHdkCyYxtBxNgm?=
 =?us-ascii?Q?Bd5fQc3AOzsZKYCREYa1GV6pL09GBoMEOuTDTsCH0JQ2W6h1DSoKDqLYfBZj?=
 =?us-ascii?Q?aq48U9GwJGfq+tcaeyDHVYOqtatSK4ebWdbLK04m5brZ/biH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd4afeb-e83d-436d-6232-08df149109b9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:55:27.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFE1+r8rwxGWcPnG9Am8YXYsDVqfSBsk4LSzSInEGhN7F1UmeIfEse4khQ/b4SsGQCh7xuBWFcqPfcAsYQCqpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878

On Thu, Sep 17, 2026 at 12:05:37AM +0800, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> A Type-2 accelerator issues ATS-translated DMA to addresses inside its
> own HDM window, so that coherent host range must be present in the
> guest's IOAS (the iommufd IOAS backing the nested SMMU stage-2). iommufd
> maps a struct-page-less range only by fd, via IOMMU_IOAS_MAP_FILE over a
> dma-buf; a userspace-VA IOMMU_IOAS_MAP of the HDM mmap is rejected
> because the VMA is VM_IO | VM_PFNMAP. Without a dma-buf the range could
> only be mapped through an out-of-tree PFNMAP work-around.
> 
> vfio-pci already exports BAR memory as a P2P dma-buf, but the exporter
> is BAR-only: vfio_pci_core_feature_dma_buf() rejects any region index at
> or above the ROM index, and vfio_pci_core_get_dmabuf_phys() resolves the
> physical range from a PCI BAR. The HDM memory region is a dynamic
> device-specific region, not a BAR.
> 
> Let a device-specific region reach the device's get_dmabuf_phys(): a
> region index at or above VFIO_PCI_NUM_REGIONS skips the BAR-resource
> check and is validated by the driver instead, bounded to the regions
> that exist. Install a CXL-aware get_dmabuf_phys() in the vfio-cxl
> provider that returns cxl->hpa_range for the HDM memory region and
> delegates real BARs to the core, keeping the BAR path unchanged and the
> core free of CXL knowledge.
> 
> The HDM window is coherent host memory with no p2pdma provider of its
> own, so borrow BAR 0's, matching nvgrace-gpu's handling of its non-BAR
> device memory. The iommufd importer does not consume the provider; the
> scatterlist map path (real peer DMA) is left to a follow-up once
> upstream grows a negotiated interconnect for coherent CXL memory.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 60 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_dmabuf.c   | 27 +++++++++++--
>  2 files changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 5fe8e35c63c4..55fa1f86850d 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -11,6 +11,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pci-p2pdma.h>
>  #include <linux/range.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -27,6 +28,7 @@
>   * @hdm_regs: mapped HDM decoder registers, read live by the decoder region
>   * @hdm_len: length of the HDM decoder register block
>   * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
> + * @mem_region_index: vfio region index of the mmap-able HDM memory region
>   */
>  struct vfio_cxl_state {
>  	struct cxl_dev_state cxlds;
> @@ -36,6 +38,7 @@ struct vfio_cxl_state {
>  	void __iomem *hdm_regs;
>  	u32 hdm_len;
>  	bool hdm_valid;
> +	unsigned int mem_region_index;
>  };
>  
>  static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
> @@ -289,6 +292,50 @@ static void vfio_cxl_release_hpa(void *data)
>  	release_mem_region(cxl->hpa_range.start, range_len(&cxl->hpa_range));
>  }
>  
> +/*
> + * Resolve the physical range that backs a dma-buf export. The core exporter
> + * only knows BARs; teach it the HDM memory region so a guest IOAS can map the
> + * coherent window by fd (IOMMU_IOAS_MAP_FILE) instead of the removed PFNMAP
> + * work-around. Real BARs stay on the byte-identical core path.
> + */
> +static int vfio_cxl_get_dmabuf_phys(struct vfio_pci_core_device *vdev,
> +				    struct p2pdma_provider **provider,
> +				    unsigned int region_index,
> +				    struct phys_vec *phys_vec,
> +				    struct vfio_region_dma_range *dma_ranges,
> +				    size_t nr_ranges)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +
> +	/* Real BARs go through the core P2P exporter unchanged. */
> +	if (region_index < VFIO_PCI_NUM_REGIONS)
> +		return vfio_pci_core_get_dmabuf_phys(vdev, provider,
> +						     region_index, phys_vec,
> +						     dma_ranges, nr_ranges);
> +
> +	/* Of the device regions, only the HDM memory window is exportable. */
> +	if (region_index != cxl->mem_region_index)
> +		return -EINVAL;
> +
> +	/*
> +	 * The HDM window is coherent host memory, not BAR MMIO, so it has no
> +	 * p2pdma provider of its own. Borrow BAR 0's: the P2P properties match
> +	 * and the iommufd importer does not consume the provider. The sgt map
> +	 * path (real peer DMA) is not supported for the HDM window.
> +	 */
> +	*provider = pcim_p2pdma_provider(vdev->pdev, 0);

I think of a weird scenario which might make peer DMA work, not sure if that's possible.

userspace can give this dma-buf fd to an NIC driver or so to do RDMA ? use HDM memory as
network buffer ?

If that's the case and direct P2P addressing is selected, it applies BAR 0's bus offset to
HDM physical address.

Maybe explicitly reject peer-DMA mapping would be safer ?

Best regards,
Richard Cheng.


> +	if (!*provider)
> +		return -EINVAL;
> +
> +	return vfio_pci_core_fill_phys_vec(phys_vec, dma_ranges, nr_ranges,
> +					  cxl->hpa_range.start,
> +					  range_len(&cxl->hpa_range));
> +}
> +
> +static const struct vfio_pci_device_ops vfio_cxl_pci_dev_ops = {
> +	.get_dmabuf_phys = vfio_cxl_get_dmabuf_phys,
> +};
> +
>  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> @@ -483,6 +530,19 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  	if (ret)
>  		return ret;
>  
> +	/* Record where the HDM memory region landed for the dma-buf export. */
> +	cxl->mem_region_index = VFIO_PCI_NUM_REGIONS + vdev->num_regions - 1;
> +
> +	/*
> +	 * Override the device ops so a dma-buf export of the HDM memory region
> +	 * resolves to the coherent host range. This is done at open, not init:
> +	 * vfio_pci_probe() resets pci_ops after vfio_alloc_device() returns, so
> +	 * an override installed during init would be clobbered. Only a CXL device
> +	 * reaches this hook (cxl_ops is set on init success), so a fallback to
> +	 * plain vfio-pci keeps the core ops.
> +	 */
> +	vdev->pci_ops = &vfio_cxl_pci_dev_ops;
> +
>  	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
>  				  &vfio_cxl_comp_regops, cxl->hdm_len,
>  				  VFIO_REGION_INFO_FLAG_READ |
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index c16f460c01d6..436c616d5b66 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -178,6 +178,15 @@ int vfio_pci_core_get_dmabuf_phys(struct vfio_pci_core_device *vdev,
>  {
>  	struct pci_dev *pdev = vdev->pdev;
>  
> +	/*
> +	 * This resolver only handles PCI BARs. A device-specific region index
> +	 * (>= PCI_STD_NUM_BARS) would index pdev->resource[] out of bounds via
> +	 * pcim_p2pdma_provider(), so reject it; a driver that exports such a
> +	 * region installs its own get_dmabuf_phys.
> +	 */
> +	if (region_index >= PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +
>  	*provider = pcim_p2pdma_provider(pdev, region_index);
>  	if (!*provider)
>  		return -EINVAL;
> @@ -227,6 +236,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  	struct vfio_pci_dma_buf *priv;
>  	size_t length;
> +	u32 index;
>  	int ret;
>  
>  	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
> @@ -243,13 +253,22 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
>  		return -EINVAL;
>  
> +	index = get_dma_buf.region_index;
> +
>  	/*
> -	 * For PCI the region_index is the BAR number like everything
> -	 * else.  Check that PCI resources have been claimed for it.
> +	 * A fixed region index is the BAR number; only a BAR can be exported
> +	 * and its PCI resource must be claimed. A device-specific region (index
> +	 * >= VFIO_PCI_NUM_REGIONS) has no BAR resource and is validated by the
> +	 * device's get_dmabuf_phys instead, but the index must name a region
> +	 * that exists.
>  	 */
> -	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
> -	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
> +	if (index < VFIO_PCI_NUM_REGIONS) {
> +		if (index >= VFIO_PCI_ROM_REGION_INDEX ||
> +		    IS_ERR(vfio_pci_core_get_iomap(vdev, index)))
> +			return -ENODEV;
> +	} else if (index - VFIO_PCI_NUM_REGIONS >= vdev->num_regions) {
>  		return -ENODEV;
> +	}
>  
>  	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
>  				       sizeof(*dma_ranges));
> -- 
> 2.25.1
> 
> 
