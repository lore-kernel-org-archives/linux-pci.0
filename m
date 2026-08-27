Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF933911AB;
	Thu, 27 Aug 2026 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871799; cv=none; b=KOvWIwG7uNMnC/pImfxOlI89IR0HerbGP93CdHgjnal5cDBXxQkRzNWdcZedfuXgAA9tR2EgABfjxoVTl97T6teKRsxXJICIF21SxdKJ2/XPlJhKQDlCo2ufprBN1lErB0fRY6DIj/c2KZ1oevYvEBp7w6ETrdqWP0zGy1jqDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871799; c=relaxed/simple;
	bh=Q3ROe6UZQ2XHI7OM4E4jdPL0s2UiFcYNcRbqBx32qwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek0OKlCqm0DR1YhcPDO74zA0s3Lj+vnDkxde0/Pw2X58uZZdBiV/FvEegdfnMCkK7ylFU+08KyLmEcLHtF1v4bTyWhRISAaCYyc4x8qkW+Aw41DSa+4q0wpWOiZd+zyVoogAr4pu+SQC/l+MUVXB7cIX792AI4YwtYWhV7ltAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=o8DH1P3i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aP46dvbF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="o8DH1P3i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aP46dvbF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E8497A0016;
	Thu, 27 Aug 2026 19:03:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 27 Aug 2026 19:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787871795;
	 x=1787958195; bh=oFv5ctN3MoNjwwb47maBRelE0P7dtMhVcUhr1brD2uo=; b=
	o8DH1P3i++BByFDBl3Ng63n3XOyI1JTo6ZdVar1jXPRoZUTBh90CkxwilIzTFToP
	zwG0APEdSJabMVhP6k/l+ncVn7uDLMvKpZS/LiF/6hUvO1QFfWAWQIcvAazWyg0c
	chYAQE/8PKkZvXPtT+du8Sc8UVbut4d/GYdrmiRJBO8tN+P62Mkw9DTwao8yjZti
	ZCwn7P+vzZWyhFOmj7sLXVbd/HHYV9mlJuMftTQXAu3O/O1xh0j+abta9rQQ6nZV
	IgnOlPw9PT87mk1T/LtYH9LrRWkNH8MrYrJMV15gZJr9OSBzS8IGidNgoWz9zds7
	ZNm3F7KJgde0VWDTmpmsSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787871795; x=
	1787958195; bh=oFv5ctN3MoNjwwb47maBRelE0P7dtMhVcUhr1brD2uo=; b=a
	P46dvbFK7CgcCz2EDHL95f1o+wd+QTkThCKhF/tLtsidyz5ZY46zKOTlznAVhisu
	tzSlV/sqy0fR+zP0/LKbnbkaqimhATs2xLCVjwkn18oQ6g8PJ5W1M6BjyRHXQSqs
	rbL/fGLRZ+WUi1ov8KiXwojGhyfBvxgOT8R1HbcrADyaAjrW5Oj5v0cxBSe1qW7G
	DjjzV/APRc1/4KAPgBnQWHME5NiuASOeRzxCZyCqegjCAmfOxlzA07lPAsqCc/8A
	pumXB0wqm6Xmi972k7t+zAe0XCbsYLGYGBKKcxgdo7vtVDRMEhOnAe5LeWu1jysj
	Oz6e0o5jwhFuX9lSd1uxQ==
X-ME-Sender: <xms:MsKQas7jM0ezxp1hoNt-852SsXjp9pVopvzaqR8TY_98zqyK4k7Kkw>
    <xme:MsKQarjNSuOZZh06bslSIepWZnFXV_cekNxC4gUOlvJCeFpvUOt989eQhoyR_0Rvc
    6FNLMFAwyMfFyYM2TQQHcG4SLO8o-BOsq-LRr8Fu37dChqgA6TRzQ>
X-ME-Received: <xmr:MsKQai15hQAsvhgLrmr24jIju9gsYPAZUHhbDhs9QDGNAJdeel6rlOgA0g2RIA>
X-ME-Proxy-Cause: dmFkZTFGArgfXlP67i3IyLAY/5rqTjvp9/T/Lgmv8ki1utIdaqcZTAAaTB3ID04bAipGG6
    8QQrsYzPqQMeNFrKXCHs2bL+UkSzosnZAP0EXF9MAAJyZ5sDXi602OtzN1PY08NAK9R/Gj
    fUIhEYvyjutUilRlMIQv+5ndHX7RPLpVjT2PWpm+6/+f5bN+UdRm1fMbiOwUMft5hmCFvN
    j3OpENvDBWG8plJUyzagPfh77vC6urBYbaII4w0zPEnXGvUUgPp8VDD6yLMnT/qHR1dN5n
    aHkJct1yVGS1Sz8xKW0kOa+ss95OxOcyqD0+dup50XYvczrmZ8n77h5PnUhcCft8DLLwAc
    xnNrunsXWdgWoZ3SGig0lUBfJQnd43r/sY2ecWxj4KQhb52BZbV4heOa7Z2PiF9vmqk3JG
    0YAR6FyByN+j2UO/XND4/e+Gx4kSApP7+aGrP/GVd5vlnBt3oGXaHcaRk6VcZMOXk9FJs0
    3Dm9r4dtczGXciWGxR5ZFeYTMHdfd6146CBr0e8tlWi+2G4NTXDyFlN1GNzdxKhWjGJE9P
    TYAQogm3K+USmeYvT00oL8xwy50pfAaXvKYqiEKCHMjY6bDXPBQ1A7YSmbSHKaH2rwPrVp
    4Hy+GH4SVNSgfCT0cxPiMxuE1kYTlXIBevsgdjETipM44W/VsMnJLztvPifg
X-ME-Proxy: <xmx:MsKQapXSVrFp2PbaoJ3-hTE4ZnqxScLUYR0Bzcj3uTRXnh_vO5IXhg>
    <xmx:MsKQan0_beR7S1gwshkXasQfcdPnx28G5u-x6T6Pz2lOO0xLbRYHHA>
    <xmx:MsKQaijXWTo3xxKYUEX6k-F0hCfIFp0vqX_nC34XVZsSTx-EWgj__g>
    <xmx:MsKQavLWTKNRrB9zEdoR-wOqswviXaz-qO7O2UoA8BGHfa3jgkiUeg>
    <xmx:M8KQatVgAkg9BCsTUMCEPWN6HP7_qOMzjBW1rNaw3l6UDOzJf-TEH3Xz>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 19:03:12 -0400 (EDT)
Date: Thu, 27 Aug 2026 17:03:10 -0600
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
Subject: Re: [PATCH v4 15/27] vfio/pci: Call CXL open and close hooks around
 device use
Message-ID: <20260827170310.5f49eeda@shazbot.org>
In-Reply-To: <20260813093631.2288172-16-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-16-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:19 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Volatile CXL register state must be sampled from live hardware when the
> guest opens the device, not at bind, because a low-power transition
> between bind and open can leave bind-time values stale.

But patch 7 prevented such transitions, without really an explanation
why.  Accounting for being in full power state at open here further
diminishes the requirement to restrict idle lower power states in that
patch.
 
> Add open_device and close_device to the CXL ops and call them from the
> common enable and close paths. A failed open unwinds the enable like any
> other error. The callbacks are stubs here and are filled in next.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 11 +++++++
>  drivers/vfio/pci/vfio_pci_core.c     | 44 ++++++++++++++++++++++------
>  include/linux/vfio_pci_core.h        |  2 ++
>  3 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 966b7c22a6ac..d19fd638f538 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -100,9 +100,20 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
>  	vdev->cxl = NULL;
>  }
>  
> +static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
> +{
> +	return 0;
> +}
> +
> +static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
> +{
> +}
> +
>  static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.init_device	= vfio_cxl_init_device,
>  	.release_device	= vfio_cxl_release_device,
> +	.open_device	= vfio_cxl_open_device,
> +	.close_device	= vfio_cxl_close_device,
>  	.owner		= THIS_MODULE,
>  };
>  
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 49dfbdaf3f05..470730cdc88b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -584,6 +584,21 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
>  			   NULL)
>  };
>  
> +static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int i, bar;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		bar = i + PCI_STD_RESOURCES;
> +		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> +			continue;
> +		pci_iounmap(pdev, vdev->barmap[bar]);
> +		pci_release_selected_regions(pdev, 1 << bar);
> +		vdev->barmap[bar] = NULL;
> +	}
> +}
> +
>  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> @@ -660,8 +675,23 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  
>  	vfio_pci_core_map_bars(vdev);
>  
> +	if (vdev->cxl_ops) {
> +		ret = vdev->cxl_ops->open_device(vdev);
> +		if (ret)
> +			goto out_free_config;
> +	}
> +
>  	return 0;
>  
> +out_free_config:
> +	/*
> +	 * open_device() runs after vfio_config_init() and map_bars() have
> +	 * succeeded, but a failed first open never reaches vfio_pci_core_disable().
> +	 * Unwind the common vconfig and BAR state here so the allocations and BAR
> +	 * requests are not leaked for a later open to overwrite.
> +	 */
> +	vfio_config_free(vdev);
> +	vfio_pci_core_unmap_bars(vdev);

Unwind in the reverse order, this should start with unmap bars.  The
above comment is rather gratuitous and looks a bit like AI slop.
Thanks,

Alex

>  out_free_zdev:
>  	vfio_pci_zdev_close_device(vdev);
>  out_free_state:
> @@ -682,7 +712,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct vfio_pci_dummy_resource *dummy_res, *tmp;
>  	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
> -	int i, bar;
> +	int i;
>  
>  	/* For needs_reset */
>  	lockdep_assert_held(&vdev->vdev.dev_set->lock);
> @@ -737,14 +767,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	vfio_config_free(vdev);
>  
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		bar = i + PCI_STD_RESOURCES;
> -		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> -			continue;
> -		pci_iounmap(pdev, vdev->barmap[bar]);
> -		pci_release_selected_regions(pdev, 1 << bar);
> -		vdev->barmap[bar] = NULL;
> -	}
> +	vfio_pci_core_unmap_bars(vdev);
>  
>  	list_for_each_entry_safe(dummy_res, tmp,
>  				 &vdev->dummy_resources_list, res_next) {
> @@ -827,6 +850,9 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  #endif
>  	vfio_pci_dma_buf_cleanup(vdev);
>  
> +	if (vdev->cxl_ops)
> +		vdev->cxl_ops->close_device(vdev);
> +
>  	vfio_pci_core_disable(vdev);
>  
>  	mutex_lock(&vdev->igate);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 43755b91880f..7354dae1dd85 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -70,6 +70,8 @@ struct vfio_pci_device_ops {
>  struct vfio_cxl_ops {
>  	int	(*init_device)(struct vfio_pci_core_device *vdev);
>  	void	(*release_device)(struct vfio_pci_core_device *vdev);
> +	int     (*open_device)(struct vfio_pci_core_device *vdev);
> +	void    (*close_device)(struct vfio_pci_core_device *vdev);
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
>  };

