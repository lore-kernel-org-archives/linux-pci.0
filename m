Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CE175A8A;
	Wed, 26 Aug 2026 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787778723; cv=none; b=Utm6RTtAaBY4JT+wgGgPQUSVShUHD/w8REXcOvhGMCn63fJlX8bnCq6J40PwenqRl10nJG4sgc0QLaLqVEe6OHuYOZrSFdFRXY0Q4g7aWwN9MQQtCoNlbcr/+g7dhqK0gnu46DCpfHx4EyLS9JPPd0jZtiqlkz++ltuUnjwD8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787778723; c=relaxed/simple;
	bh=uDpCg2NUdgNPB8vVggZUtXIvlUFPLoHhHi6zPWg7eks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCmwwACdEhYn01pM09cQE3JamCzi2/xOeijVz3lVqR55hg75peoOdPrAePWrNEoiKwTqO+V6jNZ2rYRW7N8oGEJbPCUzTiFzE8n4CMMrk9WKnvVWxDQ3UGCrTMAr1PpcMN96eY9ZXUJ9io0uPWPH+/RJ4+M1d6sczCqUWrXFVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Wle+fMPp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jtpsDMzZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Wle+fMPp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtpsDMzZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F33814000D7;
	Wed, 26 Aug 2026 17:11:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 26 Aug 2026 17:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787778719;
	 x=1787865119; bh=XBtTfHY+WDdkLyh0K0L+xi9uGC1gMRbwPFuNWOJMBXw=; b=
	Wle+fMPpazMDVaQ9O6e0HHe9V925gAr59VZq3viP6AxzJ8JGNtiZeEkSJ7WYNWvM
	H9mpchL11d7/J8jWZ9qK92UR78WVrEQ0TT9xKBXagxJQAAlQCooWx+dlEgnuWbIw
	xiTEcSTpgxR2gj9v6b7z5QQaIdRnVPN/cuUqfraw0gj4o9nxcZz1JJhj7Lky0gW5
	fgs7nfGzK+Nwyit82tjBb8I1MlOXTu48k3J4dqZbluPTlvbwav9JcCgW0xYAu4tv
	d70mrJeTiqtkrrc0U38zv3ZpARP+foK//e2scmbwmkoXo1goPjfWHZgm05W8JWMS
	jMpmgMp5yBnSKESYl/r3SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787778719; x=
	1787865119; bh=XBtTfHY+WDdkLyh0K0L+xi9uGC1gMRbwPFuNWOJMBXw=; b=j
	tpsDMzZ1MNXp4PaxoO0GHqoB703Tqzs78CU1MQROde3JpIwwVHwJ0dgKQ3tSwXZm
	D3JKr+GZIwdOzVOJ7GA0ihCJcgPnrR8zMNsdtJIGLOYfaW7Fb1wdGMgGW3fa3kSA
	/JrXxiim5OxWtGr/KfpgQvrhsquTzbuATqk2hRRV2QZJvV+E3JVDmDPLFim7HJi5
	yubb/q9ZYlJL9ImdWT6/l5oEEgUDJ63QjB09Dyznw1F2iDUNa2/bYEEcVGiIhrWE
	zTlWng8wm0p4YYouSrPFCq+S5gBm2b6202dwKgL8SLMqysDr8jkpX3ksqUdlQtDy
	QzI6NBfRsKFTph3xDuhKQ==
X-ME-Sender: <xms:nlaPapR909DTYcpbfmu_jfu88i5IvPinrTNzswCnOz3MfMT_LjdaEg>
    <xme:nlaPagYr71aYDkoF96nVdYCiwVmpFhbUg4QMcz6i52mV6quSodqByMDkh3kTqYjFv
    -IWItd9AoLR_0R0R0DRisv_JklFDDEIIYp24xD8-uq8kdUc0FK8i2A>
X-ME-Received: <xmr:nlaPamNHPZGQ0v-gixsoGMbKPk6hI5sV9V4abqGugTOsOzXFgPRHb4EIYCwcTA>
X-ME-Proxy-Cause: dmFkZTEXGJSF0uJGejRe3ioHj/n4Wpef56fXiylaceh+6G7pUZPBVN+LeXmG2tRpI5AMO6
    0TXJ/tcBYEQg7FjgK1JdTPhiduFRunWkZ9aTN0LMeVrJcLkLARNGqlOTbstprIfK3BOcBH
    dKwhXjWL26ish5Qap4mvjQO7JVwB7dpLo0iU0B+/GT+LOyGimcRDg4jH/53EZFGOPZkz7t
    i0EUtLTMy6Sr09by1VooXpOjqqvYf0ahP5HdwEcn8uuvHKJCUa2Lug03KOrNfkEvaBsz/z
    Gghz1To5woz7Keoiy4nJK0fPY44FpJvSBI/9zfJ2mTmEzBgF2XWZoFJOkAKv0mGZYMRYtf
    Qru0r/bPxGzepRCJGo4CUvXPxpt9Sdf3YWRO3V9agIYbH/Kj1s3/tmyo7l5wrFUPG8rTuw
    2mP96umyaMt5h6L8UcDTDDMWp7NZo6li7Hx8zaIWyulK3vbmOFQKaquQgQokqPN4mXcs7h
    PF2j+/aKNQK1anw0ZvMDb2rkfbomw16zYBT8wvVo4XAytixQLtUeYmoaCmPJFUK8ArLkkE
    Gs/CtxdSlXDmFMQAyk0BzINzaRmZ59F+dTB2+f94EY7TISdLTLDovmoWHeK8EmUA5wL8GI
    1/5bVYxtbPxeZJWg2lAzPnga+Wwx7ZE58CZGeRvY7tuagJ96N4EqKhvMHkdw
X-ME-Proxy: <xmx:nlaPapMjpmCjPUqgsRSylJRG-tB6AUCgD1mGJqeuqllWT5cPrsshrg>
    <xmx:nlaPaqPvHrrH6Rb0ZxPUTwn2HLeg8appwl54_k9EWevCS1B4nxhm8A>
    <xmx:nlaPalb7SzKDLrm9JmH11Qie1FbqVg4m6Qu63aer23eG1IUPG-UHqQ>
    <xmx:nlaPaoiSTwBHAZXPyoUE9gkwjC4Nq3vADfmlN3ue4M48wdY0CvIEag>
    <xmx:n1aParMtagkqRIMVTzEg7gGMNZ49iaLrQ1TmJTDCUgSI-9KIR0svszrg>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 17:11:56 -0400 (EDT)
Date: Wed, 26 Aug 2026 15:11:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v4 06/27] vfio/pci: Add CXL ops registration interface
Message-ID: <20260826151154.19486297@shazbot.org>
In-Reply-To: <20260813093631.2288172-7-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-7-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:10 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> vfio-pci-core must stay free of any CXL header dependency, so CXL
> Type-2 handling lives in a separate vfio-cxl module that plugs in a set
> of callbacks. Add the registration interface: vfio-cxl registers a
> single struct vfio_cxl_ops at module_init, and vfio-pci-core stores it
> under a mutex.
> 
> The owner field lets a later patch pin vfio-cxl for the lifetime of each
> bound CXL device. No caller yet; the detection path is added next.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 27 +++++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    | 10 ++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f11a9624b9c..88e68d43af9a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2670,6 +2670,33 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>  	}
>  }
>  
> +static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
> +static DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
> +
> +int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&vfio_pci_cxl_ops_lock);
> +	if (vfio_pci_cxl_ops)
> +		ret = -EBUSY;
> +	else
> +		vfio_pci_cxl_ops = ops;
> +	mutex_unlock(&vfio_pci_cxl_ops_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_register_cxl_ops);
> +
> +void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
> +{
> +	mutex_lock(&vfio_pci_cxl_ops_lock);
> +	if (vfio_pci_cxl_ops == ops)
> +		vfio_pci_cxl_ops = NULL;
> +	mutex_unlock(&vfio_pci_cxl_ops_lock);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
> +

Use guards to simplify these, especially the registration path where we
can then just return -EBUSY.

I see the get function stores a per-vdev cxl_ops pointer with module
reference held for the life of the device, so the serialization on the
mutex is only per-device at probe time, but it might still be
worthwhile to preempt that with a rwsem here where both these paths are
writers and the get is a reader.

>  static void vfio_pci_core_cleanup(void)
>  {
>  	vfio_pci_uninit_perm_bits();
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 9a1674c152aa..14753972e714 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -66,6 +66,16 @@ struct vfio_pci_device_ops {
>  			       size_t nr_ranges);
>  };
>  
> +struct vfio_cxl_ops {
> +	int	(*init_device)(struct vfio_pci_core_device *vdev);
> +	void	(*release_device)(struct vfio_pci_core_device *vdev);
> +	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
> +	struct module *owner;
> +};

To mirror vfio_device_ops, should these drop _device and just become
.init and .release?  I think that better reflects their actual usage
while the eventual .open_device and .close_device already reflect the
mapping into vfio_device_ops sequencing.  Thanks,

Alex

> +
> +int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
> +void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops);
> +
>  #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
>  int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,
>  				struct vfio_region_dma_range *dma_ranges,

