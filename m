Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED4346AFB;
	Thu, 27 Aug 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865191; cv=none; b=ODDr2lVyMllf8wtKQxS1N87wJRHk7YtDEvtSPMAjIOCzZPOeQM1kh4UGQQ73fFekMwyhWuOZ7ql+zkNa9u0uzQ+sGXEVZ2ujTheuer9mPpHSd0pGy5cIzcGRgpFlT1AlwobZ8tIgZl3xIUBQblisQglxtoaA13EuoMBWKQ/dNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865191; c=relaxed/simple;
	bh=S+fgmtzinaMT6PC/6Y/Opgh/LZ0E7mbntIY/+N5AQ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIOv195+M5OZerXTsMgVGvKQqYYE0NzHkz9YSxg/KIUMMwjI6TJgJVeZKAdhvwBN9t5q79V6LzM6EYgndVx/276v1bbO4fL1+bOtSacYW/iBmhCOMzhzUZO8wZ4XGgsWeqR/Qp/UJu5OHAavqx060KB3lQY5CnWZk1Xb+JbU5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=u+3DkoIe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYIpjhlR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="u+3DkoIe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYIpjhlR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0C877A016D;
	Thu, 27 Aug 2026 17:13:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Aug 2026 17:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787865187;
	 x=1787951587; bh=LptqgxJzL5yMM8ZmtUBx2wOHsHw6ZM/5+3kHAKDP8/k=; b=
	u+3DkoIeRgC5MaDtAVLw1+8rAclL1XUYyhj6gqLmeQOVQV1KcliwG0/nQYTBYQRZ
	iOpLzi31qFbNevL2+rYwq5ynz1bHvP1yswmNNiIlc3ng4BuBN6B7wGnZJ2RV1cQg
	+/pu9Kn0rwwg13yRl7bAiB0cZ7Je87vvaDIR9KAw3bz2HdYt1zWi2gCIB3Iu7wiC
	o+EN590kIFZ3FoGfy8I0peYvV4NoNK97mKmpW3AXR3YuZ9XITeaoBVn7TTxYYdzN
	3Fn2AQTTJpz0owdxBlQWn37DWTWXvIhT12XAwcVLweylivhDDNoC8lFk5NpP9BRJ
	3C++ptD1ZT8y+2giMJFnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787865187; x=
	1787951587; bh=LptqgxJzL5yMM8ZmtUBx2wOHsHw6ZM/5+3kHAKDP8/k=; b=Y
	YIpjhlRIf3LWT6a4+s9fu4MABtO1lKEbO3EKcCz2GDthH5PPtiYLGga3xPGI4mib
	lYH2KK5LrdMmSAeYYXzvrQX5NZR7qlHdkWpdUCku4GqKlby1aFKk327iEkxcoZMO
	2u+o9/Hzq7eZB9yie1w0I+Q3uEwQJRV+PB2ebgT3ZI1WqfO5N48H/0eoYS6HvA4z
	flDW4tJbmQW9EDW+L9ymgWGeCTs2sL6m19coT923pI/bv6UQiheWr70d2bb56Z8s
	vc1EjNnE/5OVEm+m9iBV0h4XsW1/mrEnPNwc9MGcyrXbi+2dKPmg4zEGyTMZiLKx
	X0wZPCrkZ+a9mpmkS9lkA==
X-ME-Sender: <xms:Y6iQaps6FCeqHQfwG4KeqhrZ2yrwhaWALVDEKCx5vUA-tkc7hCyDqA>
    <xme:Y6iQagHxx44NZn4Nw_E9fndcI7becgmARf0Vcp_fQ4BUQ_fcWg2SseWbzklKcwa5q
    14ofCl2Kky9TqnX4aM6bRjKtStWLN2-Y3hwDrUKOuHBnJenpY198Q>
X-ME-Received: <xmr:Y6iQakIVzUcHkd-ccRCo8BRi6Lw3G9U-EMCIobgjJolZWacuCoMknearj2zMkQ>
X-ME-Proxy-Cause: dmFkZTFD7fpP5X+zSXO8wgY+6E+tPLtVbuxfzuaraYC70hiVdeQTS49GSMwpZxKEt3Jxdi
    MG3tqiD+p58SyXN3LKDuWSHN3lirClEsO8vmSYt5rOqUvdtWCvyFveYmFGn1lrFS8CbeHO
    0Uuq0cif66UGUwt853Q7AXXNjBN7dHr+3FH63ViK/VogHAWZBiA4oHxPim/bVJITaMSvqz
    Alyhucf5+06WR+ebrdkwzR96Bvcc/xOz5DeOAUsOOdogDAh7vrHlvoTtwbsR2Ks1Js51sZ
    J2ab9Zb7x5jIPy8uPMGQ29o+nwJodyUg87mfxK0JDYhbHXB8p3xkFAANyRSJrGtTfqqZEx
    zDgosAnq0XE2QvLA5INdGP/kJjsAb44yFW3XG0eQtHgM0DVm9Mi5P5zS/sT9/l3Hcb5K/o
    I0kkepkWmdYAnhgWTvLjZJnggkR2TaSVVbFv6KdMLnQxpDANguFoKh0/bC2yp1X5Je9U+g
    5KWYX/e9NQmmlosfS3jQ0JmHhmRzTd2U1kvTmI+H5ZI6+Jhm04LvNSGF9kt62EwBMK0X9o
    0ZYtA03US6m3MMMHYQ07aYVFRD7mI3LyTGZDV0DtQwdIex6b5sW8x9ta+eu4nAzwk/zwmw
    qwFg8BGBXwjE3TCSuEqFzibT9KUNusKj3hcdoMP8FnlEHWFuJW5pxl+aH8ZA
X-ME-Proxy: <xmx:Y6iQaoYla3rDBva7p-4FtMiswCRAsmbjz1NePWWD2TZUNl9MWRrYNA>
    <xmx:Y6iQahoWxTgAysoGz-yyDBjjdwoVrFvvmdR-hl2tlmw1qPiOQh813w>
    <xmx:Y6iQagFGTQ0lCrf0MM57JC5sC3X1yuqCaKGMr5NpqDPSa3ZHhSe8Wg>
    <xmx:Y6iQalf_lYhoJpXa8SxturcUDr5aZ_unApHJvyHH3_p_bzMMPrV3NA>
    <xmx:Y6iQataMyPJWFdAROFggImjPu2BN-NM0fT5oLC1hZCRZn3eUlQP-F7Ll>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 17:13:04 -0400 (EDT)
Date: Thu, 27 Aug 2026 15:13:03 -0600
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
Subject: Re: [PATCH v4 11/27] vfio/cxl: Own the whole component register BAR
Message-ID: <20260827151303.5b34ef3b@shazbot.org>
In-Reply-To: <20260813093631.2288172-12-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-12-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:15 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> devm_cxl_probe_mem() maps the component registers through the CXL core.
> By default the core claims each HDM/RAS sub-block, which then collides
> with the full-BAR request that vfio-pci makes when the guest opens the
> device.
> 
> Discover the component registers into the device reg_map and pass
> bar_owned to cxl_pci_setup_regs(), so the core maps the sub-blocks
> without claiming them and vfio-pci owns the whole BAR.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 7edc53b25576..966b7c22a6ac 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/range.h>
>  #include <linux/vfio_pci_core.h>
>  #include <cxl/cxl.h>
> +#include <cxl/pci.h>
>  
>  /**
>   * struct vfio_cxl_state - per-device state for a vfio-cxl device
> @@ -70,6 +71,16 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  	if (!cxl)
>  		return -ENOMEM;
>  
> +	/*
> +	 * vfio-pci requests the whole component BAR when the guest opens the
> +	 * device. Declare the BAR owned so the CXL core maps the HDM/RAS
> +	 * sub-blocks without claiming them and that request does not collide.
> +	 */
> +	ret = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				 &cxl->cxlds.reg_map, true);
> +	if (ret)
> +		return ret;
> +
>  	ret = cxl_set_capacity(&cxl->cxlds, hdm_size);
>  	if (ret)
>  		return ret;

Previous comments on patch 2 suggest a different interface here, but do
note that cxl_pci_set_regs() can return -EPROBE_DEFER and if we do
actually want to defer the probe (until when?) we'd need to split this
errno out as a legitimate probe error case versus the fallback mechanism
for other errnos.  Thanks,

Alex
