Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB03192D8A;
	Wed, 14 Oct 2026 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004559; cv=none; b=mAOEqD0wDiPSSgGaVDYJP3KKNzBRxQBs5FndvRS0OyFeQEtXnj1oOx3GooMxmFuNIBeEhur23HOjCBOZTeX+zFEj0TS2Is8SEtMGnUoBNczresaawWw/3E9U6JZH3SrGk7dl+UaO0hRsuG89hIxhgLJ54edcp3A+cMZ16IrmdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004559; c=relaxed/simple;
	bh=8jSphzUJpNVp1momRb+tJn+p9MyDHLR+YV2cD1vViFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tC+YlD1wc/gc9TShzmO+ocs4NEysKMVdMWHoGOOXo1U3uC7/doeeO6QOfKcbuuA8E2Yd5G0uKuZV7K+7R1NwRwOgHrKUOvhzbha4HvQXe+2h2LHEnlblmkjzIRtoh+rNgKrZpX6z1CZ8sLpAyzmKL0vc1Dgbt0lBUyfy/XSIxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=nFznBiE3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="nFznBiE3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1792004554;
	bh=IEhWX3oJhdOctCVYJ+rZtv9G5PSA/1wlFynVycJFo+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nFznBiE3DFW9BFZfhppi+MB0WzWW8GAfglywzm/+/kv3m5Vr3+uy9OQNOCKZw85b3
	 1u9Ig4F6Sw0HPsebXlpwp1pYexHi7qIFPlOf+IBNNdA4DtU87xrvHf0ZAzebAP4nGW
	 HLuSRAPlJqR2ze+QmwVcc06Zy3Ep/xP/vl2O6kI6bo0fY+zAAheq5Y35iCxcWSw3EU
	 vx5bVxEHfaNSr0XP1DA3tL731GBeSHUe667CyK90lCKwsvmbTrY9hz6OLdUi9+PlQa
	 5gVWEDoWK8lH3a6+yS/ARQydgaybQGvMB0mZtPW/r0yJ41tbrOzp1/3OhCrWigjWk6
	 4cB2gJ/DKDyKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4j4gYt4cKyz4wCx;
	Thu, 15 Oct 2026 06:02:26 +1100 (AEDT)
Message-ID: <c07e1a42-a001-4ea7-980c-6cea2cc13fa6@ozlabs.org>
Date: Wed, 14 Oct 2026 20:02:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] vfio/pci: Revoke a DMABUF on request from
 userspace
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-10-matt@ozlabs.org>
 <20261013171343.2363e9e1@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20261013171343.2363e9e1@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

On 14/10/2026 00:13, Alex Williamson wrote:
> On Tue,  6 Oct 2026 20:36:37 +0100
> Matt Evans <matt@ozlabs.org> wrote:
>> +#ifdef CONFIG_VFIO_PCI_DMABUF
>> +int vfio_pci_core_feature_dma_buf_revoke(
>> +	struct vfio_pci_core_device *vdev, u32 flags,
>> +	struct vfio_device_feature_dma_buf_revoke __user *arg,
>> +	size_t argsz)
>> +{
>> +	struct vfio_device_feature_dma_buf_revoke db_revoke;
>> +	struct vfio_pci_dma_buf *priv;
>> +	struct dma_buf *dmabuf;
>> +	int ret;
>> +
>> +	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz,
>> +				 VFIO_DEVICE_FEATURE_SET,
>> +				 sizeof(db_revoke));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	if (copy_from_user(&db_revoke, arg, sizeof(db_revoke)))
>> +		return -EFAULT;
>> +
>> +	dmabuf = dma_buf_get(db_revoke.dmabuf_fd);
>> +	if (IS_ERR(dmabuf))
>> +		return PTR_ERR(dmabuf);
>> +
>> +	priv = dmabuf->priv;
>> +	/*
>> +	 * Sanity-check the DMABUF is really a vfio_pci_dma_buf _and_
>> +	 * relates to the VFIO device it was provided with.
>> +	 *
>> +	 * If the DMABUF relates to this vdev then priv->vdev is
>> +	 * stable because this open fd prevents cleanup.
>> +	 *
>> +	 * If it relates to a different vdev, reading priv->vdev might
>> +	 * race with a concurrent cleanup on that device.  But if so,
>> +	 * it points to a non-matching vdev or NULL and is unusable
>> +	 * either way.
>> +	 */
>> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops ||
>> +	    READ_ONCE(priv->vdev) != vdev) {
>> +		ret = -ENODEV;
>> +		goto out_put_buf;
>> +	}
>> +
>> +	/*
>> +	 * memory_lock(R) is taken to stop vfio_pci_dev_set_hot_reset()
>> +	 * from getting it and then blocking all devices in the dev_set behind
>> +	 * this revoke's drain.
>> +	 */
>> +	down_read(&vdev->memory_lock);
>> +	down_write(&vdev->dmabuf_lock);
>> +	if (priv->status == VFIO_PCI_DMABUF_DEAD) {
>> +		ret = -EBADFD;
> 
> Kind of ugly to special case the condition in the caller that's already
> tested in the function.  Why not return an errno for this purpose?
> Thanks,

Sure, especially since that comparison's already there.

(Rather than generating -EBADFD in the function (that error doesn't make 
a lot of sense outside of this ioctl), it can return $anything and get 
converted here.)

Thanks,


Matt

> 
> Alex
> 
>> +	} else {
>> +		vfio_pci_dma_buf_set_status(priv, VFIO_PCI_DMABUF_DEAD);
>> +		ret = 0;
>> +	}
>> +	up_write(&vdev->dmabuf_lock);
>> +	up_read(&vdev->memory_lock);
>> +
>> +out_put_buf:
>> +	dma_buf_put(dmabuf);
>> +
>> +	return ret;
>> +}
>> +#endif /* CONFIG_VFIO_PCI_DMABUF */
> 

