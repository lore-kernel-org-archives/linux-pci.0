Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913236C0BD
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418404; cv=none; b=iKcLrHKEo8jRYy9PqiAiiwsYeW7Pocx7DGM8s5hPQeP0NhJIh/0WckdVWUh8okSgodUD6okHzKDQAxYAEdxrH9EgzqH0sIGzxwbpN1Jyf9Y2wJWK1vnebLaxNpz54EzZM+bFe/i9ovLmYPsBitlz+MufCdzUKOlZzaVHpSrvcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418404; c=relaxed/simple;
	bh=woTNv57IMQwTYrlreMeY3hXWvRabJQ4iemjU3w5kLjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdVAUsoK32WQUjNMP31oGgwtsbjYnttVBBBmNNM8mIeYpA7IHhqHOAVndPKQEKk9SF/lHKWLErNvaoStYr5FDUg/XumE643c+I7AQnqtpHv+QfMDFg6+mWI4/k1O6kuoO8Afn7Tr6DFY258FXlrBHC7uZBincdlEtEPzLTPirhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HOg7qB1Z; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HOg7qB1Z"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652DHigK1817961
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2026 09:40:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=aQM+IzQj3ZxDY3ggA3owlA7d3KkShBiCJ4vlXvqOyDo=; b=HOg7qB1ZuQW4
	6lBSat61mKhK+MnCr8cVctmCY8FdH0jD5Vqo1SZjiJT1PXSaE6jJQVDirlh/htm/
	9o6dj/yg6WQlQu1Ag3gFjinhmPlncdZ+iDtruJCHvVEKqdsfNMXoAkXSrKPtLDTA
	3xX8W/GYXP0Aq5Gq6Ync/girYSkqCalmedMCwx9NdEVzNdCIolWzgFPcYbZtVZgO
	Jn4AyjLkjiJuARnKpqqzKSPyRW9JD8y2/mqfCdNwg8CHUTH8ACHXhAFYvzpVOmgy
	952MRLNOgD4wNbb/nZkLL1ZWSrP4TZejD+XKBEBOdJHJiP/7oON+DmOd/cec5Y2L
	4bhL4BgFWQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ehyx2se61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 09:40:01 -0700 (PDT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1353bfdbf99so8985895c88.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418400; x=1781023200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQM+IzQj3ZxDY3ggA3owlA7d3KkShBiCJ4vlXvqOyDo=;
        b=BcmOXHFM7UPaS+ZdeIvvhKEXwRmhzU0GrlSXfunf9xPhS4n2nBEQXu7tUSEA6WrAb7
         0s+FRymXI4G+fsZz+nb+2Wi6i7a49LTetQ/XzSN2T5l8i2YywrGCCvrPOqsem65sdv9M
         ZAu9/cfCBmI2zw+jtKTwla9aZUfU97YIvGOkVfiW+SrjsDdk/2r2KE+ejA569fIfy8Q9
         QQTctY3pAHioubYqp8W/u5ISlGXAEDxVTanroSYAgwuwP4tVIV4VRY1/3XXNDZIZNA6A
         1M4c6Ux2oxa6W0k6djfYu2dmfKRP/AOvKk2F1MQod/5wJK4vqJqNVJajrE7qwpsSGE2Q
         7dCA==
X-Forwarded-Encrypted: i=1; AFNElJ/le3jCR/3m0Sc2n+3R6mqLtM/Nmxy7BVQhQVSGLzHU0tyLplb23KbeRomN5OSH3dGZi/49H2UJEOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzftimgpWysyWMZ0hrLYrxNS1c8oTWehftAOwTRXzFJZ11jy6Kl
	kzi7uLhibWYQqOy54cpWlcEWrubxGnhsbbMhFeqUzHDGv83lgmSs7EFF2d/QPpQPbjHkwm0NZib
	8dfb/tVXRRnbb4bMjj6QR6OJyssZkqe2vw/WChokxvBzPpDo86+U375L7ngyK
X-Gm-Gg: Acq92OEMwSbuEdC2S/UL3duh4RcMWFl0PGd2lLUcseKivGKJWR0EePdiVz8a3OgHVLP
	PGUGhuQykIgXChbfl3VufMy0uHu/YgtV3UVDveYx+Fgm6Dy3ydDAgIG2mv92vzndv3L9CJFihFi
	HTiaTrV5m+Ya9851HqRleI8nSi6hl9Z8BAa3Wb0ZeJ15lZ1/GZT5W/dHICQDdIjA3Sn6loM39yz
	8dXyxu/lS+Yxyx7PYW9j3AQ6SI94zEzFQeiti8v/Nca59f+wqkf1VfZXAGqToziY84Ms5HBS6Da
	FMxerve00yTS1hA4axG4oeMUc95yYvwoEVckDuGXRiSXgJWaKFjlVKWCKEQzknlPhk53qEMuVwE
	Jim0jCUO9FtJVwtvbKXALBUtcmLWWrESsBRg+YvlE
X-Received: by 2002:a05:693c:2c0e:b0:304:e450:67e0 with SMTP id 5a478bee46e88-304fa4c81d5mr8098515eec.10.1780418400078;
        Tue, 02 Jun 2026 09:40:00 -0700 (PDT)
X-Received: by 2002:a05:693c:2c0e:b0:304:e450:67e0 with SMTP id 5a478bee46e88-304fa4c81d5mr8098467eec.10.1780418399427;
        Tue, 02 Jun 2026 09:39:59 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c10c1sm11553860eec.1.2026.06.02.09.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 09:39:59 -0700 (PDT)
Message-ID: <dfa4d88b-9182-499c-b2ba-dbde0fc32745@meta.com>
Date: Tue, 2 Jun 2026 17:39:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple
 <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-4-mattev@meta.com>
 <20260527165922.60a79fee@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260527165922.60a79fee@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2MSBTYWx0ZWRfXxTYUCwY2HthC
 Dgx8lDx96qTjlnrQn+H7lbwAsNUhO6UXXd5JLkIPOeDR4UFXjkw8Ew2BcuIjIYv56dIKKCYWU3m
 jcDrGGN6TjQBL+XBDzlUnk3sFUij9AdONnututY0NmvK230SdqmWjaR1Yx621l0hjEAL43M/njj
 GigVcCT2vn9DCeRxV2RRQZr4peV0Sq8yYbS3fISaPe8NicGRSFRkD0y7Z2m8QMNsgQHgXXGVj4a
 PYsRiOcvAoXGR+U2Z+rLAWyUBmxO8MjJ/dLXuqqPt9YFMfMmwdVFtv2pvEgFFCUG7aHoBkjWIPd
 etH/2o9pZL5O8QBs8TGXbxlC2NVh20aielYYOcJsjfZsiv7gUvnKXhTfWlMRiCwzsbbthAloR/t
 d3PgI1je9qufTzwQXDJvLXdLLYJVmsvWqSTWalPr8abi6oGiAgYfAS8SnfubCLi9uWSo9ZGdyI6
 TMKD5zWua0rUQpIaXZA==
X-Proofpoint-GUID: ZsWgfHSystVZC36b5ZkTjLSjTQTmvxrY
X-Proofpoint-ORIG-GUID: ZsWgfHSystVZC36b5ZkTjLSjTQTmvxrY
X-Authority-Analysis: v=2.4 cv=EJA2FVZC c=1 sm=1 tr=0 ts=6a1f0761 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=Dv35txUGz5gI0hTa:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VabnemYjAAAA:8 a=73EwkdylJAySbZmAXzAA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01

Hi Alex,

On 27/05/2026 23:59, Alex Williamson wrote:
> 
> On Wed, 27 May 2026 03:23:06 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
>> DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
>> commit by VFIO's ordinary mmap() path.
>>
>> This function transfers ownership of the VFIO device fd to the
>> DMABUF, which fput()s when it's released.
>>
>> Refactor the existing vfio_pci_core_feature_dma_buf() to split out
>> export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
>> this new VFIO_BAR mmap().
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 140 ++++++++++++++++++++++-------
>>   drivers/vfio/pci/vfio_pci_priv.h   |   5 ++
>>   2 files changed, 115 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 0d132c4ca95f..782408c08a5e 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -82,6 +82,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>>   		up_write(&priv->vdev->memory_lock);
>>   		vfio_device_put_registration(&priv->vdev->vdev);
>>   	}
>> +	if (priv->vfile)
>> +		fput(priv->vfile);
>>   	kfree(priv->phys_vec);
>>   	kfree(priv);
>>   }
>> @@ -222,6 +224,45 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
>>   	return -EFAULT;
>>   }
>>   
>> +/*
>> + * Create a DMABUF corresponding to priv, add it to vdev->dmabufs list
>> + * for tracking (meaning cleanup or revocation will zap it), and take
>> + * a vfio_device registration.
>> + */
>> +static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
>> +				  struct vfio_pci_dma_buf *priv, uint32_t flags)
> 
> s/uint32_t/u32/?

Fixed.

>> +{
>> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>> +
>> +	if (!vfio_device_try_get_registration(&vdev->vdev))
>> +		return -ENODEV;
>> +
>> +	exp_info.ops = &vfio_pci_dmabuf_ops;
>> +	exp_info.size = priv->size;
>> +	exp_info.flags = flags;
>> +	exp_info.priv = priv;
>> +
>> +	priv->dmabuf = dma_buf_export(&exp_info);
>> +	if (IS_ERR(priv->dmabuf)) {
>> +		vfio_device_put_registration(&vdev->vdev);
>> +		return PTR_ERR(priv->dmabuf);
>> +	}
>> +
>> +	kref_init(&priv->kref);
>> +	init_completion(&priv->comp);
>> +
>> +	/* dma_buf_put() now frees priv */
>> +	INIT_LIST_HEAD(&priv->dmabufs_elm);
>> +	down_write(&vdev->memory_lock);
>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>> +	priv->revoked = !__vfio_pci_memory_enabled(vdev);
>> +	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>> +	dma_resv_unlock(priv->dmabuf->resv);
>> +	up_write(&vdev->memory_lock);
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>>    * It allows the two co-operating drivers to exchange the physical address of
>> @@ -340,7 +381,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   {
>>   	struct vfio_device_feature_dma_buf get_dma_buf = {};
>>   	struct vfio_region_dma_range *dma_ranges;
>> -	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>   	struct vfio_pci_dma_buf *priv;
>>   	size_t length;
>>   	int ret;
>> @@ -400,34 +440,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   	kfree(dma_ranges);
>>   	dma_ranges = NULL;
>>   
>> -	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>> -		ret = -ENODEV;
>> +	ret = vfio_pci_dmabuf_export(vdev, priv, get_dma_buf.open_flags);
>> +	if (ret)
>>   		goto err_free_phys;
>> -	}
>> -
>> -	exp_info.ops = &vfio_pci_dmabuf_ops;
>> -	exp_info.size = priv->size;
>> -	exp_info.flags = get_dma_buf.open_flags;
>> -	exp_info.priv = priv;
>> -
>> -	priv->dmabuf = dma_buf_export(&exp_info);
>> -	if (IS_ERR(priv->dmabuf)) {
>> -		ret = PTR_ERR(priv->dmabuf);
>> -		goto err_dev_put;
>> -	}
>> -
>> -	kref_init(&priv->kref);
>> -	init_completion(&priv->comp);
>> -
>> -	/* dma_buf_put() now frees priv */
>> -	INIT_LIST_HEAD(&priv->dmabufs_elm);
>> -	down_write(&vdev->memory_lock);
>> -	dma_resv_lock(priv->dmabuf->resv, NULL);
>> -	priv->revoked = !__vfio_pci_memory_enabled(vdev);
>> -	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>> -	dma_resv_unlock(priv->dmabuf->resv);
>> -	up_write(&vdev->memory_lock);
>> -
>>   	/*
>>   	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
>>   	 * will be released.
>> @@ -438,8 +453,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   
>>   	return ret;
>>   
>> -err_dev_put:
>> -	vfio_device_put_registration(&vdev->vdev);
>>   err_free_phys:
>>   	kfree(priv->phys_vec);
>>   err_free_priv:
>> @@ -449,6 +462,73 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   	return ret;
>>   }
>>   
>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>> +				   struct vm_area_struct *vma,
>> +				   u64 phys_start, u64 req_len,
>> +				   unsigned int res_index)
>> +{
>> +	struct vfio_pci_dma_buf *priv;
>> +	const unsigned int nr_ranges = 1;
> 
> Why, versus priv->nr_ranges = 1; below?  Thanks,

Hm, a vestige from a simpler time when it was a different shape and 
unnecessary now, fixed as per suggestion.


Thanks,


Matt

> Alex
> 
>> +	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
>> +	int ret;
>> +
>> +	priv = kzalloc_obj(*priv);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->phys_vec = kzalloc_obj(*priv->phys_vec);
>> +	if (!priv->phys_vec) {
>> +		ret = -ENOMEM;
>> +		goto err_free_priv;
>> +	}
>> +
>> +	/*
>> +	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
>> +	 * start of the VMA corresponds to byte 0 of the DMABUF and
>> +	 * byte (vma_pgoff << PAGE_SHIFT) of the BAR.
>> +	 *
>> +	 * vfio_pci_dma_buf_find_pfn() reverses this offset using
>> +	 * vma_pgoff_adjust, so that ultimately a fault's offset from
>> +	 * the start of the _VMA_ has a consistent usage whether the
>> +	 * VMA originates from an mmap() of the VFIO device here or a
>> +	 * direct DMABUF mmap().
>> +	 */
>> +	priv->vdev = vdev;
>> +	priv->size = req_len;
>> +	priv->nr_ranges = nr_ranges;
>> +	priv->vma_pgoff_adjust = vma_pgoff;
>> +	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
>> +	if (!priv->provider) {
>> +		ret = -EINVAL;
>> +		goto err_free_phys;
>> +	}
>> +
>> +	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
>> +	priv->phys_vec[0].len = priv->size;
>> +
>> +	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
>> +	if (ret)
>> +		goto err_free_phys;
>> +
>> +	/*
>> +	 * The VMA gets the DMABUF file so that other users can locate
>> +	 * the DMABUF via a VA.  Ownership of the original VFIO device
>> +	 * file being mmap()ed transfers to priv, and is put when the
>> +	 * DMABUF is released.
>> +	 */
>> +	priv->vfile = vma->vm_file;
>> +	vma->vm_file = priv->dmabuf->file;
>> +	vma->vm_private_data = priv;
>> +
>> +	return 0;
>> +
>> +err_free_phys:
>> +	kfree(priv->phys_vec);
>> +err_free_priv:
>> +	kfree(priv);
>> +	return ret;
>> +}
>> +
>>   void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>>   {
>>   	struct vfio_pci_dma_buf *priv;
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index c8f6f959056a..06dc0fd3e230 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -30,6 +30,7 @@ struct vfio_pci_dma_buf {
>>   	size_t size;
>>   	struct phys_vec *phys_vec;
>>   	struct p2pdma_provider *provider;
>> +	struct file *vfile;
>>   	u32 nr_ranges;
>>   	struct kref kref;
>>   	struct completion comp;
>> @@ -133,6 +134,10 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
>>   			      unsigned long address,
>>   			      unsigned int order,
>>   			      unsigned long *out_pfn);
>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>> +				   struct vm_area_struct *vma,
>> +				   u64 phys_start, u64 req_len,
>> +				   unsigned int res_index);
>>   
>>   #ifdef CONFIG_VFIO_PCI_DMABUF
>>   int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> 

