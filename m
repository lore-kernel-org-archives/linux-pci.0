Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CB361947;
	Thu, 27 Aug 2026 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863426; cv=none; b=bYV7fgNQYIduHqKgtxBG62FUBO1zKMK/KzoUWzMqbp+Op5vBIZBP6/Q0V/zlW2ZVsn18YNmdcg7e3UQmDFUHZZ+8YoUQeXogJ5zCtVwMJzPyh2oAeFOYOHw1KdZ4au0jhvCzJzW6rjeI9QsYnvYDWbaUEQfDeW62nIvVaTt3dQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863426; c=relaxed/simple;
	bh=0hY5nRl6me77n06A7F0ptD5VdecxUHVUFq7N2kvYsmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWprZyPn8iqBzbjNRvS+1moPa8kZq4uFrAd5npjPM3wM/aSFlXVwoPAz+Vwh/pTlSM88yoebIq24tp/MkS1NiN+Pmvi//HIYOHvUDpBNmRjLEvjQAAuGdaP2jm/o9wi+t9yKGD6lUt9a6jbKbghAsj8Xe99+QpXR1+bfbLanJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=uIYBXb4M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDof0vCr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="uIYBXb4M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDof0vCr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61A3E7A01C3;
	Thu, 27 Aug 2026 16:43:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 27 Aug 2026 16:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787863418;
	 x=1787949818; bh=jk1dP7bSpz8nBG41hKcZ//Y9AAjhpvgTnhyCJgTBhkE=; b=
	uIYBXb4MFiGf/L1WN7iYhUBdzfqIV2XZLjFCykdD1K18GjZgqgjq3kEMAgR2kHaK
	sRkeaxL41TI8DJpfgorQDsH94UfEEaYEZEz2a/dQUSwpHa+OXHdgDzRsSM0k7Ctb
	57hMCQRKGnUbEt8L5yEnPYM1H8RoGLFnxWzF6RWcm8XYSEXK+u/u96feKiQKP4tr
	LrfuNg0ce/TVZEL2INFL4Pv1E8CsgW+zCCSRDDGFVZ5t09AdSVjS90pJ9UyqDg8R
	RgdceRPQ0Q7lOy3GP6zfTpAGmKH42rxV5EIIUX0FfDgnu2CYEFTy98Aj2TT0R0xR
	tFYKw1mv3dUXGANQPTg2NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787863418; x=
	1787949818; bh=jk1dP7bSpz8nBG41hKcZ//Y9AAjhpvgTnhyCJgTBhkE=; b=e
	Dof0vCrlk3EEKrMCeDYCEUgOUo6K9/PRAS7opJ7mlKy5802sf0maPUYt8xeDA01o
	ujnYTOBeKN7fUY35pYLNZpymtG/Wxm7JWZRmlvGcfB70ck4530RG7q0J0xBwbXe1
	OWnbh2CmtWgqwFJxXoI2neIGtonhQ/KuhoP0bSgWPAtmKMp+ZF6sYLzbhCBThqsG
	t/qztRdM6GLzNJyjX8+bUrSzgXuWYbsY6QKsKdyAMZUtuKt/k37QHLQIzvPs8K3x
	tchAJfPC0/pLPWBPYJelAAXvlWdFdyJ+6Gg7N2YbDj63nVpGgDVRmjLRSHOU24F1
	DoanXQ8yOHf2ajVVY188Q==
X-ME-Sender: <xms:eaGQap-HyqqbDYNZQ5tF41MB8X7gI3Xw7j7CYXDZCWLR3VLPJZIT5A>
    <xme:eaGQarVTSOSTJxn2y3adTUJMhMx6h-mwIgSFflBEyS48F6nSULDzINhJBM6F_5YSI
    Fe-oUruD8AaF8OHI0VS_iu_xVqIlX11s4f7q7Dobo9Eei0H_PJgWw>
X-ME-Received: <xmr:eaGQaubTFB54KBrUDYk3RAT7tHhJ3XAgYCUSHv0bBbf3StkgeRtVz56coWZ0Ew>
X-ME-Proxy-Cause: dmFkZTGhkkL3d5wJkHr+/n8koWe6hN91UvtBGPt+asMVUnYW+CFuGztxykiESGQVt8oQWz
    SzgoP9EWVb1RGARPgum8C3YktkNVBAwiBpNRiTtJKak7QsxdjUVMIRyW4mcCEF9Ap6kRl9
    vYa2uyoPlSs3hQGkAsAKU3zutY+9xpb2H0q4b3kCFrBY7JjPclKCxOMjmqtFkR66riqxbe
    u3j8LaOp8DeTSpvZfSw4+07a0M/V6GWTcwofzTLW8e08AuMtCT3Kiplrmz2uIhougkC9PO
    801ARfnxLAuyO6iI+Zw4kbmNHZOl1cN4KYIBDMb2zK/TPQFMgOmC40eMuw9BQV3oXhU3CF
    sGOZHKRyUCyBG8D2G+wzp9YaivkVFnF3aHqk5GuBvC9ipNqotGygdzb0ZkpVkY1wGbRKaN
    TUIrFiRDbbiXRSL4ER0zba4k18E6/fXSEv4u3n0a+rEc8DA5fG32tR44Z44CVZhh8LQnM3
    TJ/seaytbLI+X4oCJZTJr8grYv9Q8sbJ0KN4QbYL96DcEX8/+pIDd/HOwnnPkZVNHs7pmR
    LPZzanVXVAUE2E3umZc3GwbTV46g8g+PGm5UM+/nlyx4XTJ2pdAsI0WJot9AR617k4fAiN
    tYryZL6H+oO9X0fT7mg7o3JePzWGHO7KraW1kjhkOxNbgvwsrg24XIU50sog
X-ME-Proxy: <xmx:eaGQalqpbiO2qnnmvbm9d6VBEVeBCd09GLx70JQh4g3BbWp9sFsahA>
    <xmx:eaGQal6vJLdPyfFBNOJOP-ArErGz8XIQ79zBEf5xb5faHop9qYD68w>
    <xmx:eaGQavWfZAL8jd_2js0hN9aWCuk7ouxBW1Fjx0fj5_UV4CGQBQP8lA>
    <xmx:eaGQajuESGMmJkaLP2TZynlOUtkGWE5SYuqTXNzt4wpIk-OO-eOVBQ>
    <xmx:eqGQauqVG7RLCb7rgbij4f1FQPBpNk7BwNBkuuC6qUMur9rTnSrTVKa1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 16:43:35 -0400 (EDT)
Date: Thu, 27 Aug 2026 14:43:33 -0600
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
Subject: Re: [PATCH v4 09/27] vfio/cxl: Create the CXL memory device at bind
Message-ID: <20260827144333.222fe7fb@shazbot.org>
In-Reply-To: <20260813093631.2288172-10-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-10-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:13 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Read the HDM region size from decoder 0, cached in pdev->hdm at
> enumeration, and use it to size the accelerator device state. A Type-2
> accelerator has no mailbox, so cxl_set_capacity() establishes the
> capacity that devm_cxl_probe_mem() then uses to join the device to the
> CXL topology and resolve the host physical range.
> 
> Everything here is devm-scoped to the PCI device, so it is unwound when
> vfio-pci unbinds. If pdev->hdm is not populated yet, defer the bind.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 53 ++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index cbec7319452c..125e11354a46 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -6,15 +6,67 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/range.h>
>  #include <linux/vfio_pci_core.h>
> +#include <cxl/cxl.h>
> +
> +/**
> + * struct vfio_cxl_state - per-device state for a vfio-cxl device
> + * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
> + * @cxlmd: memory device joined to the CXL topology at bind
> + * @hpa_range: host physical range of the HDM region
> + */
> +struct vfio_cxl_state {
> +	struct cxl_dev_state cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct range hpa_range;
> +};
>  
>  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  {
> +	struct pci_dev *pdev = vdev->pdev;
> +	struct vfio_cxl_state *cxl;
> +	struct cxl_memdev *cxlmd;
> +	u64 hdm_size, serial;
> +	u16 dvsec;
> +	int ret;
> +
> +	/* pdev->hdm is populated at PCI enumeration; defer until it is. */
> +	if (!pdev->hdm)
> +		return -EPROBE_DEFER;

How would a device get to a PCI driver probe function without being
enumerated by the PCI core?  This also looks like an infinite loop; if
there's an error setting the hdm pointer, this is forever deferred.

> +
> +	hdm_size = range_len(&pdev->hdm->settings[0].hpa_range);

We don't validate the number of hdm ranges until the next patch.

> +	if (!hdm_size)
> +		return -ENXIO;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	serial = pci_get_dsn(pdev);
> +
> +	cxl = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM, serial,
> +					dvsec, struct vfio_cxl_state, cxlds,
> +					false);
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	ret = cxl_set_capacity(&cxl->cxlds, hdm_size);
> +	if (ret)
> +		return ret;
> +
> +	cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl->hpa_range);
> +	if (IS_ERR(cxlmd))
> +		return PTR_ERR(cxlmd);
> +
> +	cxl->cxlmd = cxlmd;
> +	vdev->cxl = cxl;
> +
>  	return 0;
>  }
>  
>  static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
>  {
> +	vdev->cxl = NULL;
>  }
>  
>  static const struct vfio_cxl_ops vfio_cxl_ops = {
> @@ -39,3 +91,4 @@ module_exit(vfio_cxl_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
>  MODULE_ALIAS("vfio-cxl");

I missed commenting on this in the previous patch, but why do we need to
declare an alias to the name the module already has?  AIUI this is for
providing an alternate name for the actual name of the module.  Thanks,

Alex

> +MODULE_IMPORT_NS("CXL");

