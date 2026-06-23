Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FED3A7F4E;
	Tue, 23 Jun 2026 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256419; cv=none; b=bMT93llfBsH2LnZgg7xYNKC7MekzccCwCrsqLfhjh5mFfx8wbi3EO+n1WdC22Bmc2iyNqj+MBL1Q3vy/b/Yit+Jc93t7/UmMR3CBkPzBaDH5/4XvK8SIA4VY4jsOQC5qF/hWNZEFrsITn+r04IGLavyDFXA8ylc8mYAkhSXBebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256419; c=relaxed/simple;
	bh=/pWFEqrUtO7R407UmkeLxHzK1S4uJ3myT1Rlgai5SgY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eoRQ/hEDnj3jc93E1XSdOZ4Gd1fz++cGauqudO4eUdIu1bwxcMdtYS0Y9LCkxIDArmUbmAWjLOh6XHR6I/+N6j5l+OKmzG9596wCNxVcWai+UNCczo3a0eBd/r4oOC3hCO6mA9ffue9ggeXVzwTTnuxokiLZf0fjLy0v43YXNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvxnc4bA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvxnc4bA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC051F000E9;
	Tue, 23 Jun 2026 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782256418;
	bh=dt8PsIzjXkg9JpHYae7llHpePxe0uk+0DRL1H1m+Tks=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Yvxnc4bAp3AicwFFJEHgnbT1XEytmRyOnwzJUMdVmpX4tDGR7jBdZADAiwuFNdqEB
	 xrefIUUyxzTRPBqkqRUI50xU1EyNM2R28qyhH3+l5DlW0PzhZaGIDPYpCXx5+Iba/g
	 B70E/0LLMq++8v/FJILH8TPqRTZ0iZ1cEbwCuOXlegW1AZUqGZAy/MzoqLCnrkl2RD
	 4ID7of9r93F2pM73xqGV+Z2k5xvOWLeBC9YVQ4R++yzSfKfSTVuBIoVBcBdNOSVwHP
	 NATlVhqUdAjqaw7FqRejB5aFz1OTxaXLtlUcPDVdLWTtPi/nd4eXjtbCWPXgpz0v0+
	 EajqujB76fUdA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D64E1F40070;
	Tue, 23 Jun 2026 19:13:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Jun 2026 19:13:36 -0400
X-ME-Sender: <xms:IBM7ape2WkIRLjqttncwbA7ZhwoH36sKta4UqPmmsRs9Gq13wvQh3Q>
    <xme:IBM7anovTCEWe0CKMaXalQSh6EUSIjocmeaYkdEt1m40zipDkIEVxYZwrlo1K9X6N
    so1wvgZ8oNdu0UhEotu4iaYb3QBASXzIapDnKRY6EQFHFc3AKgDaw>
X-ME-Received: <xmr:IBM7an8WTgVSYb5crjlTQPhtf3wXWPyAxhf2m_mJ7P-Z-o-2W-qzC_yfHDjrM0Hyi-oQ7x0Y5-Rqs8_X0icX2zWDwaNniTZP2DQ>
X-ME-Proxy-Cause: dmFkZTEKo9U7Kgu4Zj9ax0E4ioiVjTSiontLI/u8uopg7sAWTbwCVtOiSRUSyiM/HqOZ88
    wXkptFTPj1xfFcLsTdtR3diwcfJzx1KIAU9zK43Ys2UH0hmYALgMFrOB6fyGnI6xa2ExyW
    JUbUmou6ZMZ3lBeUp8q2BP29CCs5u3LNv97BTm+zKrABHA8Bv/g1k/mVG9kFOH1R8Hng/t
    8kBuEAspEU4BVJZVjyejxGfVO1S4HNC7iPoX5bCmSFqyzCA3bKjzZ2RJdmbT+stoqCwUEK
    280Z+IJ62ZvI7fclsmHqBehXEghCxFemdxfFnQiuQVG5WuWLa699dr6p2BbwUnkoWrMCB5
    EJ5ffycnUgilRJZeQg90w2rbWxW1v8o2pthONmZO1KLm9aHlbYlnZCLuQe+qKkdKTe3Zwd
    QkQAnFPS3hxctnuk3wvekO7Eozsvr7KqsnZWH1Abcmbwyv5Zo34BCr/8n6meu5npiOEBvH
    9xLBXLyReeZpV/hkDtdDuA6WPOFMqFFW6n7JQupnWZrNm2K7iNTh3Qi+zt1DyL4qQhb2DM
    4JxJMQCF96H6Z/xOEviiy8dMJxYAErthkJi0KlSKzaFzK/2dex9Ry8axrjcZSDsSACa0qe
    Iju7vreCRJW2z3znIPkfFFpCfnjia6RRf45dgHVtj6HZ9SstU9lg1A1cgI4Q
X-ME-Proxy: <xmx:IBM7ag4Fwl_Is2XOIjxMOHvcAvtTVj4r1Zopl2wC1LzSMAh_yu2k0w>
    <xmx:IBM7apgzxtpHAq3aNp0wwrNI3pari41k07VD2vjT-tQCQOZdrnIq8w>
    <xmx:IBM7avqOp64vA5vjVVgKgbuesb9hG-MOq5vKA5yPgawiDI2nTmvp7w>
    <xmx:IBM7atJhBunYZjKlhlB40Qfn9AA6xg4EYMZN6rwqKGh1zkG23a-V1g>
    <xmx:IBM7akv5QwOVsRR1xD6H8iglDK3BIJ5YHw9kg-MZhdirN4CSsqgmw93X>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 19:13:36 -0400 (EDT)
Date: Tue, 23 Jun 2026 16:13:35 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a3b131f453df_3c9f100db@djbw-dev.notmuch>
In-Reply-To: <20260623032453.3404772-3-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-3-smadhavan@nvidia.com>
Subject: Re: [PATCH v7 02/11] cxl: Cache decoder settings on PCI devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> Cache CXL core's HDM decoder settings in pci_dev->hdm as decoders are
> enumerated, committed, or reset. PCI reset paths can use this snapshot to
> restore HDM programming without walking CXL topology during reset recovery.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 81 +++++++++++++++++++++++++++++++++++++++++-
>  include/cxl/cxl.h      | 12 +++++++
>  include/linux/pci.h    |  6 ++++
>  3 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index fa978c297546..83cda63f76a5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -84,6 +84,76 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
> +static void clear_hdm_info(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +
> +	WRITE_ONCE(pdev->hdm, NULL);
> +}
> +
> +static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_port *port = cxlhdm->port;
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev;
> +	struct device *uport;
> +
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		uport = cxlmd->dev.parent;
> +	} else {
> +		uport = port->uport_dev;
> +	}
> +
> +	if (!dev_is_pci(uport))
> +		return 0;
> +
> +	pdev = to_pci_dev(uport);
> +	info = devm_kzalloc(&pdev->dev,
> +			    struct_size(info, settings, cxlhdm->decoder_count),
> +			    GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->decoder_count = cxlhdm->decoder_count;
> +	WRITE_ONCE(pdev->hdm, info);
> +
> +	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);

The CXL core can update the PCI cached HDM settings under the device
lock, but it should not be doing its own allocation. It also should not
clear the cached settings on shutdown. That would defeat the purpose of
having the HDM settings available while the device is disabled.
