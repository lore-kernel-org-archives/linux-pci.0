Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836508;
	b=uAd9kg02NxuwdHGglmE0DI8VYDJZRtFM2WaISjS1/bSplmrOetpUoKdXNiF3GppRNwpS
	 xP2tqS/wNTUUQaZGEWystLpfH0PXglkwWVBhgg6cN42/HMG1x76H30tSUViNlH0FGu4ay
	 pEe2Dfwi7fNmA9RjCCNwLU+G3lBVqFCQ0sDa3VVNXo4kd32wobbNQy2EzS9B3a+K0ejfp
	 EOwiThAdL4rms6l67EFpfBetA8zwqCNpLIIHKrYVdHjc4uMpPX0AQ31kgk5KjKVvgBemH
	 Ev0eM2Fi3l5PsvrbbdI9Sv9M7IyAnHRyzTLFhbVDeWid2YT2xwOTNvpG88IaD/vncSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836508;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/LahQotUT6Zyx5GMdomeN9fJ6TxmksE/N+MzR4egS40=;
	b=npqLpswVVJZEytQJN3yYzjJRYUBYRJDsAB5WTkH4yjZwpsTJuANFYzclkEuCT7d4g/0H
	 +3P7G4SUA7bbtRqzrR6ceDiE2l9WdjnwEubjSQnk5W5D9m3wpBhN12nLzhGX3beC0Z3H6
	 yon9VXK0UTv29/lDKlGS3iAmuTR4M1w/vTdagzMyCvgKlBure+Jq5ZrOZWbhI1bsca2nC
	 DKn1r9hCeAqFDVAjy1ZlD8fpiNRg7LOZ8uQ0Syp79f5qaEjR3E0j7LghOerSn8ye8DTz1
	 mD0lV0qTqmhOLG0MQYdGGQP6py1sqhkTlr6Xlee2wK71yG/KSuo6eo0FK6389fn1Z/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=buTyPYNv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iVJy7dgy;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B03606D80A
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88B03606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=buTyPYNv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iVJy7dgy
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 65281EC019D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 18:55:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Nov 2026 18:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793836505;
	 x=1793922905; bh=/LahQotUT6Zyx5GMdomeN9fJ6TxmksE/N+MzR4egS40=; b=
	buTyPYNvlbiHROFDb/B1KRniMHFQRqNL9BO9ZdqMJbKYngY7T7vpCBYI3Dc0VKRs
	24TKn9HlbqQkagpR4XHMJ0/wNS9MzRHgxgINLE42r0Y683kslUcqH3ERJg+towPo
	C8VGzYZvV/mQlyrLOIOfke04Vb3epJo+OuzDPdd3y79J83MyzefEskOvJSZ7pcL9
	AQJi1hYNIsOcnYNx7pH/2gCzHwLZmTrw6vpu0jmGDE1OIeeabyUdgKz8ST6dK404
	Mepv+wlIfRvVTIcvMF9uW0HB0foZD7Fs25M5tpM0TxwmN14NAiFl1HqAK+FtORhb
	nqwE9Ew+WBxoWyywKq9O3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793836505; x=
	1793922905; bh=/LahQotUT6Zyx5GMdomeN9fJ6TxmksE/N+MzR4egS40=; b=i
	VJy7dgyyyqcnVI0oqyGno4tq/f2Pr3g40HXqV/uy+/wvzM5rb8s9XlZLxYqK91I1
	j4HrfsLIAiLxHrtjyLdC0mI/WKmnwxiVgLVDNGpDyzGGej5gDnItQYlfuTfqL8Ez
	y5Hpz6F6C/BZdx6SSuNjSZSUZ2jkn68ncdsglW8YIZGgI6k4EkSEPPtmZ+tCTv/4
	X0iiy4fI/ytFsqR/xa4rA80Hp9tRntjLQBQmxFd3lhxxvQ7us8/d6mUnChNrCURs
	LGDaxdrXi0P6EaeaY/u9mS+zt82VGaHkR0sfdbfDXjl/UMSriiTeqe7jzqmA6IsH
	beZpckWLC5yjoCsnJJHiQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793836505; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:H3bAIZPj9ZWPVXB3z3hbhKnAIsX9U4U+7TQ5OF1y3nnGLpK
	MeRLUuYvy51RnplypGZ/EhzQOwpn9HcTcpJiTkNaxRn5l1kxDfiEZULsMQ5JkjWh
	NrWjWBPqmtTD7lVUIlP+pbkN28dKrLKTdUL/xa9z0EtrVYdcxIBW8peIZVU+gvik
	d5/xc1J982xzXf79Rlse59DJWo/jklOI4cFUOR38H9T97fu8XtgXtN4hbnxDdibR
	IphGVInECcGv6hMvy60hPZt1ZuZW/Xo2A+NuspacLAq7s/xEcKfJMsHw6GyJ+6+m
	Z5sfsbXGrOl0w75bWv8BkAI/Vm1xzGevOR9Ajgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JPjNwY6qCG8gkmGdnKaaT7WOOaugHCgPKLtNMRngSF8=:q3h88itWQmyd3B+UEAY+TewhTtpVxOMFr4fng73e8eA=;
X-ME-Sender: <xms:2MXrah1vKxEpQrIwA00nxHEDmu7CisZ5VoWFqj4x-ukPB3hEB8Rj7Q>
    <xme:2MXralsYrjcHjK8UxNK3lZys5wFudqJ1z8wpEf_fo2Lpq41IUy6XvYS4YE4Cc8vgS
    UqvmN1ZK_E8w2IeurjMzCfgMWJHaAAjlUBV9KRiSJBRwpHeDo_5>
X-ME-Received: <xmr:2MXrapSyHkz1oY44oDaLouBXeON8YxgoHUh1RhyJ5GxipIg3LpcwExPEfaNHEQ>
X-ME-Proxy-Cause: dmFkZTFU/kbVOsWxOTPcCpe6x61hsj1WNmmGso+RiYOPL9PXBn0IITeBo+AW6SFW+G4ekC
    /hzYoF162vC7PC2Mtt2USNZ/eCRzPfnSvLH4GpnZYykCQlv/g/2dfaxUihNQ2PdVnmznVt
    eyzTFpFT8ROSV9PpSF+vkXBd8GjUZhM6/FJB6rHUdJL+IEmDIn9qqg8D9AaoFAEgqB3zaI
    LQuuKEKLXGp7sIkYnu8IYt8f4dndp/+v360R0jn1bNCYEbWntuZR9TDLjZCVdVdTAj6SKy
    IHj9Y41QEBh5Iv1k5SCIJDAY7TVRfrnmdQbz1lqnEzzeOazcj9kVYNjTrGiFbntAEPcYZz
    yvoTE1jZOdoqcWowBk4XbW649bNeEFTfrUhjVyt/eW3lRhhwgA+0KDJFQgg4VWGhyRJF06
    C5WM/hjhnCrWmkZ/hL73tJNMnOsmdh4S3GzHN1s2u/d77FbVcc727FkO8mteMnIODcLJjl
    PKgSTdOxY7vAu4s2vfIBQMfY04jfy1nRoNG6JxeEG0b1rEs6TOZikLjtcMBtJU2rkRKHmq
    LQ591WVAtFQB9m+01Kf1tGQ6V40zJD81YuBCFrlE8Kx0MZ9Qj08mY62AtIvNf4HShJl4qf
    EN+XasJAjiWbBLTyJiTyklqe0OS2AzoITqG4mNP9/ybtgy09tY37NOb7rzsQ
X-ME-Proxy: <xmx:2MXranDNGshqPhNniWP3b87a6HSQ6kXjynPVKbyzx7ALSw-iR0YSpg>
    <xmx:2MXrarzQI9XRJQfeR4BRfOQackSLy1fvvRUP-iq5SrVGrI8VTuksXQ>
    <xmx:2MXravtIqEa_vwuoB0JdGZ8uGQJSff1N4o5dJOjQSY01YUj-YJXC5w>
    <xmx:2MXrasnfekN83pLdQFxpgsJFOh7OhjapuHcQ4tCWWnhYPeqBsNv64g>
    <xmx:2cXramBX-pVAAJf97im8lOAukEIzPL6Gf6hL30uR7iPPzrQjIsfDec24>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:55:02 -0500 (EST)
Date: Wed, 4 Nov 2026 16:53:12 -0700
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
Subject: Re: [PATCH v6 06/31] vfio/pci: Add the CXL provider ops
 registration interface
Message-ID: <20261104165312.647d930e@shazbot.org>
In-Reply-To: <20261016161839.2765592-7-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-7-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 21:48:13 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> vfio-pci-core must stay free of any CXL header dependency, so CXL Type-2
> handling lives in a separate vfio-cxl module that plugs in a set of
> callbacks.
> 
> Add the registration interface:
> - vfio-cxl registers a single struct vfio_cxl_ops at module_init
> - vfio-pci-core stores it under an rwsem.
> 
> A second registration is refused with -EBUSY.
> 
> The owner field will be used to pin vfio-cxl for the lifetime of each
> bound CXL device.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 24 ++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    | 10 ++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 6757054e9d87..2cc5dd20396c 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2178,6 +2178,30 @@ static void vfio_pci_vga_uninit(struct vfio_pci_core_device *vdev)
>  					      VGA_RSRC_LEGACY_MEM);
>  }
>  
> +static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
> +static DECLARE_RWSEM(vfio_pci_cxl_ops_rwsem);
> +
> +int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
> +{
> +	guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
> +
> +	if (vfio_pci_cxl_ops)
> +		return -EBUSY;
> +
> +	vfio_pci_cxl_ops = ops;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_register_cxl_ops);
> +
> +void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
> +{
> +	guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
> +
> +	if (vfio_pci_cxl_ops == ops)
> +		vfio_pci_cxl_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
> +
>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  {
>  	struct vfio_pci_core_device *vdev =
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 9a1674c152aa..9fe0d1a3a370 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -66,6 +66,16 @@ struct vfio_pci_device_ops {
>  			       size_t nr_ranges);
>  };
>  
> +struct vfio_cxl_ops {
> +	int	(*init)(struct vfio_pci_core_device *vdev);
> +	void	(*release)(struct vfio_pci_core_device *vdev);
> +	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
> +	struct module *owner;
> +};

A forward declaration would be sufficient and cleaner here.  It doesn't
buy us anything to start defining the structure until we begin to use
it.  Thanks,

Alex

> +
> +int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
> +void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops);
> +
>  #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
>  int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,
>  				struct vfio_region_dma_range *dma_ranges,

