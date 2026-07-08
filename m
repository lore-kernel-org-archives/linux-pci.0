Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30F39D6F6;
	Wed,  8 Jul 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553636; cv=none; b=uWkD+ZuzmniUi6sMdlFeZWUbv57xXm667ujKxrpIsjHorlUb4BV4pFNameKqKu5QtsAADPXwf/yVvXYR0bfZJxV2KuVx0Di1viIssp7Ewt+EVkMralQLjRasdEHF0DCaq/L0oDQZ40m4hcL9QdScINgaPtZGPqX8TejwvcrbH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553636; c=relaxed/simple;
	bh=TeOZCT1CSjCD//Mde/eHby8hGSNRMwFbz5C8L1/Voso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBoQaIYeZZvCQi9utAVDwli6bV3d+12anovxEaS7dpWL2hwHCn9WeRuf/JN/53bgKyNc9UEccyH5zWJu9Nc+Msp/oaIiX4muRcF3Ld1YzCP2Gm+W1jWZM+tKEPnUxHIWoi+Kw0DRqWcoMx1aRn0LMuMH9tJ3dP9vehcnoWczoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=MpzDryqQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iASotOeZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="MpzDryqQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iASotOeZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AC23EC0093;
	Wed,  8 Jul 2026 19:33:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 19:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553634;
	 x=1783640034; bh=hPKXcFD12UQCcNoVTj4iaNDykpuJgUfDN+ak0KVK74M=; b=
	MpzDryqQzf2Dd8ZjsOiQzi4SfovLKUa7fZh6BZRWiKHSXw4mvGa8jzldSnnFu4K6
	a0llto2yxzIaelHlb7Dw+SQROqlUCDNDxoNaBiDYeP+V8hz1jJww3ZhK21HIAmex
	YSwuquXszMW8CZf1Cr/s23eFejYWGLdcGnNh/agQ3nBaZMjkDOTth7mg7nznV/jr
	r3k2KJ/BzXqsMKIAVwWBYk14NICmAIn8YEKA64GImb939w782Y+T5bFZH4OADQkx
	8o9ibcYxBuJIKZidXl9jUG6Mnf304L+aEv8MHWYVnuDfwqTJKBe1kbzO6KzmATmI
	/e9IwBhoazUsaoD+2BU6OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553634; x=
	1783640034; bh=hPKXcFD12UQCcNoVTj4iaNDykpuJgUfDN+ak0KVK74M=; b=i
	ASotOeZXA60TDAYn6BdbQ4281Slpy0oeH48mUxh/10P6qLoqPC7S+PGj2s68HS1W
	E+Yv9W+H8Tg2Y2PWYHUp02YbRskiDvWpn89bXTf1crqyTwGQ6+I1AEj+ZA2iIf6o
	Pr4lut4gozv4+g9+mUj5waztwCFW1XDWtZIJTj2zOS1T9ovL9V1Grok5Shnneklf
	tVdDAcz5dHn63idYHcCzkxXFJpw0zy3HSavA9I5FUN4VwyW4MNLU4nqlcRbg+hEU
	Fe3abthDpms+5Es/qxeLXkUfB8bTb5Ub7ixKOmOybDWPcTacBJgOPrOuJ3MIIY7G
	L+FNJNy6A+z/bLzxdTHww==
X-ME-Sender: <xms:Yt5OaosaoizvLj7h7KJf3mq_7N_LlXw9WHUfyZYaSp9mULc9-Ke9aQ>
    <xme:Yt5OanBssNmb5qTjq0lvc-5rkb_rMc_C-qrasIoFtvKdMBQTPpyKodxQYKS6uqYd-
    1tjnW4doHgaXortaJ-SIY3w4OgO-Ak467wtsvkGR9HzJtmJdxCHnA>
X-ME-Received: <xmr:Yt5OajBiVY83GO12PA2g1LEfCOVtzLqHIlR7cH1a4tDNOpEDDxbc_0Uyo-M>
X-ME-Proxy-Cause: dmFkZTFte9WprN0NxcJROcfQFoEYm4B20MOLRP0aieXCyUdPRt+dzeE8Foerkd28PADnVQ
    Q2OHQyexbOYRg0rBSNOhchlTE+r/ewb9pSaPJb36wKXVH9KGO8zOd2ACKSAkP71biec0nW
    AiYi6lJEcJuY92jHX23f2U7Qb1Dg05BGKYh0T/ac7eHxqJqxnMLvbEkhPqn19+QJmg51Bi
    R83/qttr1Zc3Z5ixxRe9NSaWY+LnlyEwiLj4EwFEmOG4Lb+4OmLVuoXmcpjG+fAzjJwsof
    el3RyOoiWDxEYOLUI/eLpV38WJAiH7Apu9E5tR2zCkAGUlL+0Ao0YBSWPfngxFwsSk3UpU
    ifQOS8Qx8+xD3hVYWeaQO6GhoSUDrGd6ZaWPkuwdjjNRqFSYKVcpWqSIRdHt7qrzXbXCVA
    QQilYqsK9ovE/7DOZBMXacUsCC6zVJc+IN30LxMzIdlBr7QKOXTylG/nTCC0+P9TnbzEhW
    hWrIARq/Dm9KT3t/R77TUj9IWUV+9EIJGeVOM/MwVLfJp/NdjrS7Al7nrHaqAR4mZWxlVj
    LTxREr328K2wOnPJL+PtnmDdNWiNP9WTk98mdOqC5SDMR61npCi5a/QfCIYefEs+fFjU2n
    H0DDIPFc4ND35RFgDLF4h1ID6i5NfOqCm/UzBJqkh/NDcSyH8r9+oYlZPrSQ
X-ME-Proxy: <xmx:Yt5OahrA0AxfINOTzFSEHRUkE2TiNfsJsiX0im3SyLD10chaolIBGQ>
    <xmx:Yt5OauE0Cm8SNXS62pWa2y7XqgVc0ms7B4PbV2hxWFdfMHAc3nlQXA>
    <xmx:Yt5OalsosaL3FZpFh_XiT8DhsVTH9UeyZorneH6orTmSouhPe3eHTA>
    <xmx:Yt5OakYShAor6Yuylle4O7IQHc0GZFogiSF06eQ-aZTB2T_J-trzFg>
    <xmx:Yt5OajyaDBRXk69icuWoBsS1XWQTB2wIVpXVA9W4ecyGps-1BvzxJvv5>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:33:52 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:31:17 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 12/18] vfio/pci: Add dmabuf TPH metadata storage and
 fd query helper
Message-ID: <20260708173117.3e399c4b@shazbot.org>
In-Reply-To: <20260702124224.57168-13-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-13-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:18 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add TPH metadata fields to struct vfio_pci_dma_buf to store PH,
> basic/extended ST and their validity flags.
> 
> Implement vfio_pci_dma_buf_get_pci_tph() to fetch TPH tag and PH from
> dmabuf, distinguish basic and extended ST namespace.
> 
> Add vfio_pci_dma_buf_get_tph_by_fd() to resolve TPH data via dmabuf fd,
> validate dmabuf owner ops. Provide stub implementation if
> CONFIG_VFIO_PCI_DMABUF is unset.
> 
> Lay dmabuf foundation for the upcoming TPH_RESOLVE feature.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 49 +++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   |  6 ++++
>  2 files changed, 54 insertions(+), 1 deletion(-)

Please don't send competing patches, just indicate the series is based
on Zhiping's series v#.  This makes all the naming changes that Zhiping
declined yet you still included their sign-off.  Thanks,

Alex

> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index c16f460c01d6..d9c5e434e586 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -19,7 +19,14 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> -	u8 revoked : 1;
> +
> +	/* Protected by dmabuf->resv. */
> +	u8 revoked:1;
> +	u8 tph_ph:2;
> +	u8 tph_st_valid:1;
> +	u8 tph_xst_valid:1;
> +	u8 tph_st;
> +	u16 tph_xst;
>  };
>  
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -81,6 +88,26 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>  	kref_put(&priv->kref, vfio_pci_dma_buf_done);
>  }
>  
> +static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +					u16 *tag, u8 *ph)
> +{
> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> +
> +	dma_resv_assert_held(priv->dmabuf->resv);
> +
> +	if (extended) {
> +		if (!priv->tph_xst_valid)
> +			return -EOPNOTSUPP;
> +		*tag = priv->tph_xst;
> +	} else {
> +		if (!priv->tph_st_valid)
> +			return -EOPNOTSUPP;
> +		*tag = priv->tph_st;
> +	}
> +	*ph = priv->tph_ph;
> +	return 0;
> +}
> +
>  static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>  {
>  	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> @@ -106,6 +133,26 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.release = vfio_pci_dma_buf_release,
>  };
>  
> +int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *ph)
> +{
> +	struct dma_buf *dmabuf;
> +	int ret = 0;
> +
> +	dmabuf = dma_buf_get(fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
> +out:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}
> +
>  /*
>   * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>   * It allows the two co-operating drivers to exchange the physical address of
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index c997cc9bf330..d7bc52f488c6 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -122,12 +122,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  }
>  
>  #ifdef CONFIG_VFIO_PCI_DMABUF
> +int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *ph);
>  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  				  struct vfio_device_feature_dma_buf __user *arg,
>  				  size_t argsz);
>  void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>  #else
> +static inline int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended,
> +						 u16 *tag, u8 *ph)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int
>  vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  			      struct vfio_device_feature_dma_buf __user *arg,

