Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48839478D;
	Tue, 22 Sep 2026 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043388; cv=none; b=EP3gxySNjit97lSxHH8wQERGZh4pwiCAC7q+zzqDOoBEul2fPJwUfVTJdBA8p0wszkjH6Frg+o1p6zFxC/1jWEipJGl+qKCwCG5FC0om2JbQSSHZgLDf1nLgeuieGlxLcbtupu0qr9V7JgHLPJ6Ws6wzCgQ821RHn7NfHwqH5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043388; c=relaxed/simple;
	bh=EEJoiCla2xsUDDGT1wtYmVd1EDi1fyaRDjP8a/oievE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Euo7XGre14eWTsT4LSenbHoPCW7HJvCzH4723lhbsBsAJ3p6DVUzR3N04wtSrVrLNiaUfUn6sI7z7WdyuQ5t3whO8j4edZVGi0qMB6F9OboIG3WVOoX70uhp6MiNjAteJfodw775rXDsq7OofiT+4nFjxvAb5CbOtOs3MTGK/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=F0pPephy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d6mYCXRY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="F0pPephy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d6mYCXRY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 67D7A1D0006E;
	Mon, 21 Sep 2026 22:16:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Sep 2026 22:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043385;
	 x=1790129785; bh=ar8F8AzgyNlmO16jEqlT9kWnDi3NM31RTuSM9ujQ4Xc=; b=
	F0pPephym9xzr5FahNyQHnRR4pTV8gLsdo6QsZ1pv25EYYW7bSaIHw8NbZlpYjT9
	YSFSxFyQ5QEgjgpg8iwuNEps8PNiVIGlpTKumPcZifJe4/5679Onwnuzy3TY0iOm
	qS6whACt25D9/4HJw3/JJAUp+qzbEzlxrxE+XHzKgiF834D0RHfZXh0JJimIqln1
	A7UDpyzdQKZftFxVbi7z7Gb9VRsVqXTjh1ya8Z+tO7bgskxpOu8yTUZoR4a0NdwF
	4GyfxzWsHVh55v+/QrrRJZo8OfRa0xvCikf66kxcz+5ha5nVMKaZ3rrQn3PqB+/m
	YKxJfdqLFeqVdCupMxCK3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043385; x=
	1790129785; bh=ar8F8AzgyNlmO16jEqlT9kWnDi3NM31RTuSM9ujQ4Xc=; b=d
	6mYCXRYlIRIQr+qA645H6waUACIeRGaQ1A6lVOgjQATwoqWZD+TSKpwVQS19mDTp
	DE6acbWJPVK8PA6l/8fNo5C7qMQML5+M5kWc7Q3flN51fyp0b7q745Y1E92Hn0Ew
	+gSPHBjrPHoDL0ixrMu7aZ30HbBCUk8F/BETZcPO4EPWqqHIOye8coGlsw7mUtuV
	fODd/6OpS7Hgv2IEHXw+CyJoCUyB5Yyk+Z0cU5fUTzYlRRBZsrgHCiPfUsZIHZWV
	JVgnRwmv9sCt7BTnoKHAD0a0108ePI1mg8VqM3Q2h80p1xNtX3+zUOX8//ojebre
	EvYfvP3l+yEnoVfrwZGZA==
X-ME-Sender: <xms:-eSxapDDvgk3mmzQ_vt486rmdl-9bN4F6PAPkfTtiZsHinAzmu1zqA>
    <xme:-eSxanvAAXDn_BNaFFRvH2ymAE5sedrIOHk03l60MFPasmC5bDdGLbAHPof1tJfr9
    hYjrXil7CnkAZzaXANITNmar1RT4jm_QshvALDW6-J4wkykNhMN01Q>
X-ME-Received: <xmr:-eSxanPb9LLxKax24JAjXPtvmdDD3sHa-puY_zAnlNCNTJngFnWYBSZJiV6LKg>
X-ME-Proxy-Cause: dmFkZTEVaM7SvCFST2BBezPuJiixrkmE2Un+f6UT9OQLDoMu7BBs/TxdNVZOy7gDxZVSQ5
    +8GcT5lo4k3t5IPXUYNwiGS1d+hGarVl0PJ4l2J5eAUZwVQ89BRmaacJbmIs1CqcZcH7eg
    xICpG/aos5YgPWgz/di9OmUkGGcYk8mnwAJCrmSK6J8rHj+AzsFAizcpXVpdL+EPlo7OG8
    mhpip8AtjHf9SeAwi+YThGrGXoEi51Wd5YCyhtA2zpJhBCB65caCANdtlLG1hAHAbVCaag
    7jP40PLhRjruOFdBdUQ1ZA2xzdk+Vjot4L9OSsH6IFoXd/WfpIKyH8EaUUQ8CKrvzzLGD5
    jBUtObmkUa5QJgbPB/zPe4GF9/drxSIearOjix7dGHtI6U/qGZ66J5PvzyUZ3D/tv1BOwc
    Lx0/6vLELW4zJ3gWxGpWN97fkaEt3WQx+WP2aMcirURiPZgdGHyi6ajLzP6aw8UUpThtin
    Q6IwqOIaFHZauGNGBjfex01Wljy0mdl8HBNPTMrm1bTqVd7SF8XeHcIvtZzCq1B/vtyyit
    uPAR705fkpviElZyiBvXw0YxUOc/2CMz91zOKu4d3w3lpvlduHXAY16WIFXl9kUqxDh+sw
    jsSUJdOuGvl5tXySdd6LZqC7y7QfmXSUxL+Lrd5F/fdHLc3VFEhADOnIk6Xw
X-ME-Proxy: <xmx:-eSxavW47o07yNaNYGs4EAxyemfUh2Rs9-ccA5l4A2xDxKMSOFDOlA>
    <xmx:-eSxaiTTjrXaskC7P7QkLW3tIWxrKxrH8RCEJBakk9l9HWP7QWKNNw>
    <xmx:-eSxavbAfB6c1QNiGP-x7qjCy-3NonUfoi1JOPqNwnh7nX1HuCNbUA>
    <xmx:-eSxarB434PBeE8Z7T05dYlpMMYWA5DcKPwyt78JzMQDFJxU67ahZg>
    <xmx:-eSxajB5deTv8Ds579uLKIe2mAkdvOhSv0pt5erw6P5gE1epWEYB4XNl>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:16:18 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:14:30 -0600
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
 alex@shazbot.org, xinmengs@nvidia.com
Subject: Re: [PATCH v5 13/27] vfio/pci: Bracket PCI resets with the CXL
 reset hooks
Message-ID: <20260921201430.451af68f@shazbot.org>
In-Reply-To: <20260916183540.3813685-14-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-14-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:26 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 device must quiesce its coherent link before any reset and
> restore its HDM decoder state afterward, or a reset can leave the device
> mastering the bus over decoders that are no longer valid. This has to
> happen around every reset the PCI core drives for the device, not only
> the ones VFIO issues directly.
> 
> Add reset_prepare and reset_done to the CXL ops and register the matching
> pci_error_handlers callbacks.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 18 ++++++++++++++++++
>  include/linux/vfio_pci_core.h    |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 2f593b2721a1..a91e07181847 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2794,8 +2794,26 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
>  
> +static void vfio_pci_core_reset_prepare(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +
> +	if (vdev->cxl_ops)
> +		vdev->cxl_ops->reset_prepare(vdev);
> +}
> +
> +static void vfio_pci_core_reset_done(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +
> +	if (vdev->cxl_ops)
> +		vdev->cxl_ops->reset_done(vdev);
> +}

Flagging this because it's introducing one more vfio-pci-core use of
the convention of storing the vfio_pci_core_device in drvdata that's a
barrier for a Rust-based variant driver.  Likely this needs to be added
to the per-variant boilerplate or macro so variants provide the
vfio_pci_core_device pointer rather than expecting it in drvdata.
Thanks,

Alex

> +
>  const struct pci_error_handlers vfio_pci_core_err_handlers = {
>  	.error_detected = vfio_pci_core_aer_err_detected,
> +	.reset_prepare = vfio_pci_core_reset_prepare,
> +	.reset_done = vfio_pci_core_reset_done,
>  };
>  EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 643f32c2141f..6ebf9a26275e 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -72,6 +72,8 @@ struct vfio_cxl_ops {
>  	void	(*release)(struct vfio_pci_core_device *vdev);
>  	int	(*open_device)(struct vfio_pci_core_device *vdev);
>  	void	(*close_device)(struct vfio_pci_core_device *vdev);
> +	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
> +	void	(*reset_done)(struct vfio_pci_core_device *vdev);
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
>  };

