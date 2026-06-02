Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5E3806DA
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419013; cv=none; b=VfdxYKqnzMauiAutVoEyeKkekYzK3WxhregUxuzYb9wmT+laeADImAtQEagZfxexaPBLguP8O3hyPrJ44Q0qaQal+EiEPOgYEU6NUZMNFHEhLRspNjYFUVsxIagMSYiycJK2AwLvzUKTBRapO7BtDAiPHt39ms58xrp0cANGd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419013; c=relaxed/simple;
	bh=xJpWp35UujKn6aZ1uwABuJdgM/gDwYMqTXRsfQGf2rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9gk6xSkGEzL3Yh4VAGD989ua6Z7K190pizCLTFKDSm3egwvneKNeTn92A97/ZJtPrQIZ6Q5l9XAZQRVSs3HZ3amcVYz1g1Gngp2t+W2jxbJkHUIepaiPLXIil8uJQkbWXDIbPzp5Wjyr688HYdySGekFV20tXdDMydz9Cj+iek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=V2+ukKat; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="V2+ukKat"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652FSCWW2304210
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2026 09:50:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Yehd4DhbieHxqdnPFx+C2OZiJ4/oV9ani65AADLGU2M=; b=V2+ukKatNizu
	elNZjAgnTJky/aEUl851SsfasBCLobh+ZDQjIOfSlk7ulp81uEr2qiqIi8rDoBnt
	PFCu9cCWfZiv5iVBCkHFwxzJYWXdPOCqvYZEJm6yxIEADifa8DEp9d6Zhh4Sc9l4
	qNOdk8XUXOh/y6W4+mbWPkGWXzneORHc7Ej68i7Xa1Ada9Z0rzjxMRJSNbzTsVGK
	GlH2FNXqkyjDSnbYFMKxFS1wKy5Imi6pQ/UkKMaq+ZL92H2ZwiHfIHKuvijOOzKp
	A3yaXbnjvyXNruLNrhzDR73+Rzb+NbwSVBoPUexboFCeDpBM2JfqeTLcC4BHbnmF
	q3CwwTF7eQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej1uhrkh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 09:50:10 -0700 (PDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304f23c55b2so4189987eec.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 09:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419010; x=1781023810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yehd4DhbieHxqdnPFx+C2OZiJ4/oV9ani65AADLGU2M=;
        b=Gr6l4rSOfIxZ1s/sqMBEaR8weqweg5XYA6kJl3cUY/rf0d7Wjsm7p+li4RBq/+hrHu
         50XvpgFdIDfdtS9XNMGQgThKpy4DIKssgyw5t87zsevc6snljcKDQx46pKqYZHu7SJ0i
         Z6qNRVk5wivuJl7joxTLWqKmxrbqE2ayHwHisDqti+ouA9zz2MQH9jCd4WA/YVfKLq36
         59VdfQLvFOHLx/YDgCPe5wr4kDo9RPIFGIWq2jqaDTvAJi1uiemQhePHmg6iRpvfRh8r
         v9I6vRw7dMjrsvIk66V6+hwkIRUjR+KpXXFSj088UvRF1UL3oZFgEkV7K0v8+0PzZu03
         7UGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XXuqPjANH0yjDpkcEzfy2b39p3sAYbH5cu+TSrLckZKFQxV5s2/Vdc8jrZyS35dbJFn5uE5pp+hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUXmNF/XZ9JHQ9QtKKKPCAc0qPlaYXxYkQI7XdFPzyQWW/St/
	lknR2+a5Mzb2jk7DMZUf658bMCTd3AGebEgaiuU7md8LCoLuA6e0Lt5EFL7cIZkyikhL0VO3Rcg
	d31UYlGr5yxw/YuNkuHkGKviOWtwoc9n6bXpJYH9fvHp17QGSWTHm8iMwPivw
X-Gm-Gg: Acq92OH1tNZJs2hBfsArHRGbYFybSdpJ8aXjKn1Jlt/7EMm007Edog9f2KoOP2WZUrH
	WgeNxVofPRopYAIOL1eNDjLBxB4HLTLWYo+VJM+D99xkF/Vmjp0QS1jBOAz6UPbGO/oPe9+9tQ8
	h9d8K1ah4kzAV985/f2wdbGwq39sg1rTlkBjGl3oMCAHHUzayADAyklJN8foDQGBGOo610QCjJF
	9A040ADNl/6ky7Ndlx5/K1HtveNdS1hy0HVphv/6NEOnF9B9Tk8cHA+MvCMPjBpCa/dUzS3QzM8
	x7JblpOcJuxG7xDBgvbWi6L4MaoF7+4FQw+QkCePvawUVmSuQbKhVPL9XHCmVi8hfZzZdjExH/3
	Z+DfrrXZ68kDkPSogVvcULaxIKTBuCPPXCHh76hg1
X-Received: by 2002:a05:7301:60b:b0:304:d32e:65e7 with SMTP id 5a478bee46e88-304fa2fc9e6mr8158008eec.0.1780419010001;
        Tue, 02 Jun 2026 09:50:10 -0700 (PDT)
X-Received: by 2002:a05:7301:60b:b0:304:d32e:65e7 with SMTP id 5a478bee46e88-304fa2fc9e6mr8157955eec.0.1780419009260;
        Tue, 02 Jun 2026 09:50:09 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd8e1sm16956690eec.21.2026.06.02.09.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 09:50:08 -0700 (PDT)
Message-ID: <8854824e-06c2-43b3-86c2-8c2c28f9ad63@meta.com>
Date: Tue, 2 Jun 2026 17:50:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
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
 <20260527102319.100128-10-mattev@meta.com>
 <20260528171432.771a1a30@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260528171432.771a1a30@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XTHt-DUriQsKgVLDu1Ys95UtPmpeQHn7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2MyBTYWx0ZWRfX32KFSNxX1MYi
 yYdIKUVyLvHH/bXetmeUwAKiHu3sYtrB6Th3dWEq0mI45WdF2Z/frqsCiwsvQYktp83M3t3wCIu
 +ff6CHkrJzuawwV0+Sf9w6u+zSWC9b6i6k5zUdNI+BYTKTbAWo4gvsGJs+u9+5S8d0c6R8XjDU/
 4pF4OItdKe4G/HtXHuZRfF6sdiuxShgoQD5OR3yVWhZxLmV6TohXG5Cu7FeMFZnnRfVZ2WEAPWz
 ve4qbDEZILZp+9ul6FPQXvNXetznU1I3xeaGdsqqDfbZ4bw1eBlIu8uoQfwKatF5duzI0RixO/W
 CDkcnNo60SZGt0clmXq1WC7ZDWnRjeh1Z5Qep05g8U5Ba2uT2TwF959mbFgpo0iGZs8cRCOKoKF
 DtzqDUDcDCnGNNmnicYvmCabIvreYrPWVPAdGLM/wMz9b8mkQPrOj+Pv+hlM7lkfV9VOMMXJaHB
 srshw8JBRpVcnIvVscw==
X-Proofpoint-ORIG-GUID: XTHt-DUriQsKgVLDu1Ys95UtPmpeQHn7
X-Authority-Analysis: v=2.4 cv=UshT8ewB c=1 sm=1 tr=0 ts=6a1f09c2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8
 a=xAQEHcCOs6QKEQvX3i8A:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01

Hi Alex,

On 29/05/2026 00:14, Alex Williamson wrote:
> 
> On Wed, 27 May 2026 03:23:12 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> A new VFIO feature, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR, is added to
>> set (and get) CPU-facing memory type attributes for a DMABUF exported
>> from vfio-pci.  These are used for subsequent mmap()s of the buffer.
>>
>> There are two attributes supported:
>>   - The default, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_UC
>>   - VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC, which results in WC
>>     PTEs for the DMABUF's BAR region.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c   |  2 +
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 70 +++++++++++++++++++++++++++++-
>>   drivers/vfio/pci/vfio_pci_priv.h   | 12 +++++
>>   include/uapi/linux/vfio.h          | 27 ++++++++++++
>>   4 files changed, 110 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 5184b3cac160..e256a925e7ce 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1590,6 +1590,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>   		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>>   	case VFIO_DEVICE_FEATURE_DMA_BUF:
>>   		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR:
>> +		return vfio_pci_core_feature_dma_buf_memattr(vdev, flags, arg, argsz);
>>   	default:
>>   		return -ENOTTY;
>>   	}
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 3fa14760898f..db8b95ddbe18 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -42,7 +42,10 @@ static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *
>>   	 * contained within the DMABUF size before calling this.
>>   	 */
>>   
>> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +	if (READ_ONCE(priv->memattr) == VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC)
>> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>> +	else
>> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>   	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>>   
>>   	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
>> @@ -464,6 +467,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   	priv->vdev = vdev;
>>   	priv->nr_ranges = get_dma_buf.nr_ranges;
>>   	priv->size = length;
>> +	priv->memattr = VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC;
>>   	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
>>   					     get_dma_buf.region_index,
>>   					     priv->phys_vec, dma_ranges,
>> @@ -731,4 +735,68 @@ int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev, int dmabuf_fd)
>>   
>>   	return ret;
>>   }
>> +
>> +int vfio_pci_core_feature_dma_buf_memattr(
>> +	struct vfio_pci_core_device *vdev, u32 flags,
>> +	struct vfio_device_feature_dma_buf_memattr __user *arg,
>> +	size_t argsz)
>> +{
>> +	struct vfio_device_feature_dma_buf_memattr db_attr;
>> +	struct vfio_pci_dma_buf *priv;
>> +	struct dma_buf *dmabuf;
>> +	int ret;
>> +
>> +	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz,
>> +				 VFIO_DEVICE_FEATURE_GET |
>> +				 VFIO_DEVICE_FEATURE_SET,
>> +				 sizeof(db_attr));
> 
> I don't see why this needs to support GET.  Are we solving a userspace
> problem that doesn't exist?

Possibly, I'm a bit twitchy about unobservable/write-only internal state 
so added GET out of habit.  However, no worries, removed it and this 
function is now much lighter.

>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	if (copy_from_user(&db_attr, arg, sizeof(db_attr)))
>> +		return -EFAULT;
>> +
>> +	dmabuf = dma_buf_get(db_attr.dmabuf_fd);
>> +	if (IS_ERR(dmabuf))
>> +		return PTR_ERR(dmabuf);
>> +
>> +	/* Verify DMABUF: see comments in vfio_pci_dma_buf_revoke() */
>> +	priv = dmabuf->priv;
>> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops || priv->vdev != vdev) {
>> +		ret = -ENODEV;
>> +		goto out_put_buf;
>> +	}
>> +
>> +	ret = 0;
>> +	scoped_guard(rwsem_write, &vdev->memory_lock) {
> 
> Why?  This doesn't serialize against mmap.  Just use a WRITE_ONCE() to
> match the READ_ONCE() on mmap?

Ooops, good point.  Fixed.

>> +		uint32_t old_attr = priv->memattr;
>> +
>> +		if (flags & VFIO_DEVICE_FEATURE_SET) {
>> +			switch(db_attr.memattr) {
>> +			case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC:
>> +			case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC:
>> +				priv->memattr = db_attr.memattr;
>> +				break;
>> +
>> +			default:
>> +				ret = -ENOTSUPP;
> 
> -EINVAL

I'd like to push back on this one; ENOTSUPP distinguishes trying to use 
a wild attribute value from all manner of other screwups such as
trying to GET (with it no longer supported), passing an fd that isn't a 
DMABUF, etc.

I'm not wed to the value ENOTSUPP, just something distinctive versus the 
other errors userspace might see, and that value seems appropriate.

>> +			}
>> +		}
>> +		db_attr.memattr = old_attr;
>> +	}
>> +
>> +	if (!ret && (flags & VFIO_DEVICE_FEATURE_GET)) {
>> +		if (copy_to_user(arg, &db_attr, sizeof(db_attr)))
>> +			ret = -EFAULT;
>> +	}
>> +
>> + out_put_buf:
>> +	dma_buf_put(dmabuf);
>> +
>> +	return ret;
>> +
>> +}
>>   #endif /* CONFIG_VFIO_PCI_DMABUF */
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index a1e0f4fcb1dc..8067be45beb0 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -41,6 +41,7 @@ struct vfio_pci_dma_buf {
>>   	struct kref kref;
>>   	struct completion comp;
>>   	unsigned long vma_pgoff_adjust;
>> +	u32 memattr;
>>   	enum vfio_pci_dma_buf_status status;
>>   };
>>   
>> @@ -154,6 +155,10 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>>   int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   				  struct vfio_device_feature_dma_buf __user *arg,
>>   				  size_t argsz);
>> +int vfio_pci_core_feature_dma_buf_memattr(
>> +	struct vfio_pci_core_device *vdev, u32 flags,
>> +	struct vfio_device_feature_dma_buf_memattr __user *arg,
>> +	size_t argsz);
>>   int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev, int dmabuf_fd);
>>   #else
>>   static inline int
>> @@ -163,6 +168,13 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   {
>>   	return -ENOTTY;
>>   }
>> +static inline int vfio_pci_core_feature_dma_buf_memattr(
>> +	struct vfio_pci_core_device *vdev, u32 flags,
>> +	struct vfio_device_feature_dma_buf_memattr __user *arg,
>> +	size_t argsz)
>> +{
>> +	return -ENODEV;
> 
> -ENOTTY

Gotcha, fixed.  Yes, that's quite conspicuous versus the chunk above, 
unsure where I got that from.


Thank you,


Matt


> 
> Thanks,
> Alex
> 
>> +}
>>   static inline int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev,
>>   					  int dmabuf_fd)
>>   {
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 02366e9f8e16..9b0b68f8a1ef 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1564,6 +1564,33 @@ struct vfio_device_feature_dma_buf {
>>    */
>>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>   
>> +/**
>> + * Given a dma_buf fd previously created by
>> + * VFIO_DEVICE_FEATURE_DMA_BUF, GET or SET the memory attribute that
>> + * will be used by future mmap()s of that fd.  SETting a new attribute
>> + * does not affect existing VMAs.
>> + *
>> + * The default, if no previous SET has been performed, is NC.
>> + *
>> + * Return: 0 on success, -1 and errno is set on failure:
>> + *
>> + *  ENOTSUPP: The given memattr is not supported.
>> + *  EBADF, EINVAL: dmabuf_fd is not a DMABUF fd.
>> + *  ENODEV: The dmabuf_fd does not match this VFIO device.
>> + */
>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR 13
>> +
>> +/* Valid memory attributes for the memattr field */
>> +enum vfio_device_dma_buf_memattr {
>> +	VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC = 0, /* pgprot_noncached */
>> +	VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC = 1, /* pgprot_writecombine */
>> +};
>> +
>> +struct vfio_device_feature_dma_buf_memattr {
>> +	__s32	dmabuf_fd;
>> +	__u32	memattr;
>> +};
>> +
>>   /* -------- API for Type1 VFIO IOMMU -------- */
>>   
>>   /**
> 

