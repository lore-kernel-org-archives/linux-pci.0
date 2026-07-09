Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C340BCBD;
	Thu,  9 Jul 2026 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597770; cv=none; b=WmQmpi1y0WxeEwP9qdTKqgpwLL8gc5CHOBmYkzxrwu1aPsmF9FIgHk6i9Gidka5/a+cpLngRCAp8RINHSFcUTwNSBtbz0vXvrsopUf+OpiYAd0k5Z9ogT25I4mJrwenhDhiy7pSqW/YSL+8IodwmNPXnNlYK2SYE/hMKC9Twggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597770; c=relaxed/simple;
	bh=yI+s86ck9gIrkmpQP/ITYFZhLEAoEr5QDQ4n+QVWQYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aeBxWB6H+IaGyPJTYXX7nJ06HLNaU8k8RzIo6KGgVKGFxmRcS3aHnGCqh0WQbYp9AZMAAaFpRMVQfwB55GibjQE3IHGITlForMVpbI2xxz8bM8iEp/iFabRkDEzV0qnq+1uNLes0zgExTqLQ08k+wKJwunxYu8Vcrs1QMXCFQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FzR2E8+t; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FzR2E8+t"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qddeSyAmKX0P8jX/PXnjfd9jUQgVsJ0+BbLu+Q5ZHQg=;
	b=FzR2E8+t7ygN/Q1gLMv68TGhQASOouHVYLMSzzUDL31tv95ENC3P3tNfXjI0xou0Xxgz+e1qr
	3gUB6tAe3L4uquFWgq9SNfUjf8rePzewfyrh0ZYTOIJGkLbn8fCBYF76qDcZhl2bUZ4PIFWVRZI
	7zt3zhUVTLG6DsxlnzT08jo=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gwtLZ5V7lz1T4G5;
	Thu,  9 Jul 2026 19:40:22 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 0780E40538;
	Thu,  9 Jul 2026 19:49:25 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 19:49:24 +0800
Message-ID: <bb0e583e-501f-4356-b554-784482b35331@huawei.com>
Date: Thu, 9 Jul 2026 19:49:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 12/18] vfio/pci: Add dmabuf TPH metadata storage and
 fd query helper
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-13-fengchengwen@huawei.com>
 <20260708173117.3e399c4b@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173117.3e399c4b@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/9/2026 7:31 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:18 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add TPH metadata fields to struct vfio_pci_dma_buf to store PH,
>> basic/extended ST and their validity flags.
>>
>> Implement vfio_pci_dma_buf_get_pci_tph() to fetch TPH tag and PH from
>> dmabuf, distinguish basic and extended ST namespace.
>>
>> Add vfio_pci_dma_buf_get_tph_by_fd() to resolve TPH data via dmabuf fd,
>> validate dmabuf owner ops. Provide stub implementation if
>> CONFIG_VFIO_PCI_DMABUF is unset.
>>
>> Lay dmabuf foundation for the upcoming TPH_RESOLVE feature.
>>
>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_dmabuf.c | 49 +++++++++++++++++++++++++++++-
>>  drivers/vfio/pci/vfio_pci_priv.h   |  6 ++++
>>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> Please don't send competing patches, just indicate the series is based
> on Zhiping's series v#.  This makes all the naming changes that Zhiping
> declined yet you still included their sign-off.  Thanks,

Thanks for the feedback on overlapping dmabuf TPH patches with Zhiping’s series.
There are code conflicts between the two series on PCI TPH and VFIO dmabuf logic,
and I also have concerns that Sashiko may not properly parse and track cross-series
Depends-on tags for reliable automated review.

My current design idea is to retain this foundational metadata patch in my
series. This patch only implements basic storage and query helpers for TPH tags
on dma_buf objects, providing the underlying infrastructure. Zhiping can then
build the corresponding VFIO device feature ioctl layer on top of these commits
in his follow-up series. I will fully sync all his latest code revisions into
this patch to align implementation details and minimize future merge conflicts

Thanks

> 
> Alex
> 
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index c16f460c01d6..d9c5e434e586 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -19,7 +19,14 @@ struct vfio_pci_dma_buf {
>>  	u32 nr_ranges;
>>  	struct kref kref;
>>  	struct completion comp;
>> -	u8 revoked : 1;
>> +
>> +	/* Protected by dmabuf->resv. */
>> +	u8 revoked:1;
>> +	u8 tph_ph:2;
>> +	u8 tph_st_valid:1;
>> +	u8 tph_xst_valid:1;
>> +	u8 tph_st;
>> +	u16 tph_xst;
>>  };
>>  
>>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>> @@ -81,6 +88,26 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>>  	kref_put(&priv->kref, vfio_pci_dma_buf_done);
>>  }
>>  
>> +static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
>> +					u16 *tag, u8 *ph)
>> +{
>> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
>> +
>> +	dma_resv_assert_held(priv->dmabuf->resv);
>> +
>> +	if (extended) {
>> +		if (!priv->tph_xst_valid)
>> +			return -EOPNOTSUPP;
>> +		*tag = priv->tph_xst;
>> +	} else {
>> +		if (!priv->tph_st_valid)
>> +			return -EOPNOTSUPP;
>> +		*tag = priv->tph_st;
>> +	}
>> +	*ph = priv->tph_ph;
>> +	return 0;
>> +}
>> +
>>  static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>>  {
>>  	struct vfio_pci_dma_buf *priv = dmabuf->priv;
>> @@ -106,6 +133,26 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>>  	.release = vfio_pci_dma_buf_release,
>>  };
>>  
>> +int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *ph)
>> +{
>> +	struct dma_buf *dmabuf;
>> +	int ret = 0;
>> +
>> +	dmabuf = dma_buf_get(fd);
>> +	if (IS_ERR(dmabuf))
>> +		return PTR_ERR(dmabuf);
>> +
>> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
>> +out:
>> +	dma_buf_put(dmabuf);
>> +	return ret;
>> +}
>> +
>>  /*
>>   * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>>   * It allows the two co-operating drivers to exchange the physical address of
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index c997cc9bf330..d7bc52f488c6 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -122,12 +122,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>>  }
>>  
>>  #ifdef CONFIG_VFIO_PCI_DMABUF
>> +int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *ph);
>>  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>  				  struct vfio_device_feature_dma_buf __user *arg,
>>  				  size_t argsz);
>>  void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
>>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>>  #else
>> +static inline int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended,
>> +						 u16 *tag, u8 *ph)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>>  static inline int
>>  vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>  			      struct vfio_device_feature_dma_buf __user *arg,
> 

