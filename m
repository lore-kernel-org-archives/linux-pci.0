Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F0368D51
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293168; cv=none; b=kn7AQDxlBDgOPPkkQ6VoAHvuezdqJEmyaTkRnKPGns4qNAnV0zquLjePuc1O3KL2Fe1rbLYAsGdWCss1MdjUiOKbcyXKVTl+ifn+oKjlfeOVdAV2SvuALbWUDqgXaTpa02L7D8Xvv3D1Y31SCc39pRQWBtQuUdi0SNmfAf6TefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293168; c=relaxed/simple;
	bh=rSgh5DEmzOlsxgEt+jpYxiGLFfp04B5K+fyf1Dp3QZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2g32xFcQFOJ4Kspub1zZ+XFRtfvDXHFKwDn4by418PshVd8QLEF34viYAgv+pv4kGnS5glbm6K8ZvMoHNLmWPN5EMReUkWVyCRiUhNB8xl75vLon9lb7TqOVTm+uITkTd331q4tz7sXBqEvodcXGNbpctLFwQ0eL3PXtRF15cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWDzio3i; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWDzio3i"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf2d865383so15635ad.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781293166; x=1781897966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7hmvmA/ZOPAMkxJPFMHlsykhA7hRG+rHWgxmIiSF5c=;
        b=JWDzio3iEhujEIlwxW3FOjAZbnAi+cJyvoynRaZHvR2+4pTd8/4mjW88FyOn9l7rBw
         IEjE+ok8nCBmokUeNGnj3ue/LGDbVl29/ySU/ru3BCZMBL29bhhorqjHyAkJQaUFlONJ
         pufxkCYUHEUAfaL0ojzr8Fj3JmC9rjcPClR0djP6YJh0qRpMt7s7UmmU/pbM2wWz5fP+
         u611Acmrl05N0i9RhdldTBoFMss0ovkIunXnazvjzDwnULuhjsTpQ9mJPXBJdOVolsxn
         MlVQc/OgqnUYYQltqdtOH14RlC0HHKEjd8GaPpt7DmKQTsSccPrl8pCt1by4kGn6oZ6t
         4OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293166; x=1781897966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7hmvmA/ZOPAMkxJPFMHlsykhA7hRG+rHWgxmIiSF5c=;
        b=W1NDLXo+60WVd6+4EBpG0x+nK06tLu4fkWDOGL+opzre4D7se+NQ3R5UcUMYkDHoec
         HnXSsWVDCZsStCkKX0hrWqH5OYn4cp0LVf2VNVmXwmtAeaiNaxxO9lLcM9hpSLPqjNUF
         TrQNsn6t4HpoNk2Xqr9VV/RCpQi3tJj8cZOZP+9Skz2XEHoeyfWPHg0m0nmKLurLRuI8
         bD6mK1KLcmU0l1n3/mKboEC99wCux/je3LbaUkX2RZ3vGmhPgZEXZWo+KqUWZwoiZE83
         xavUub9dIS8b7jHqjKjjM0IfXFOFDkE+LB8tSLNjwVhtJLPiOeegINpdAplF7CwgIqak
         rZXg==
X-Forwarded-Encrypted: i=1; AFNElJ8xVoSWoWCEOUuKPK2kFjgmw3StZSrLGb+wff2aEMUu3wYFSsPeBZ+SZErqPKXl3T7hBBbYzyS7JHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudUXJ/KseGRH+3q+k2RLYE5ThWm7IkA68j4tNZB9qm4pCQLzo
	8Bt89GfepuABUG4m2i+UFrenMhlH0ZbUJwiZLFPzYQYNXr9+vPKQVmJuZscBwBeq4w==
X-Gm-Gg: Acq92OGTnYLi2hJ86tFF0fNG/nho7FDUXPiwrZd94tfHiLwVWi0caR3HxXdsjHNmUOE
	Zpe7d0yzMsvKsEJMK/eo3unioNQemibf6e3V9c+zbBbtzMxiz9TINSLm6cET0/W3lFeYBlS5/PY
	9RpU5NUJqqKzcbrOZk2wWwubPcGcj2VCSBUmaXSKMX6nzXb5LWz6zlVrmzIeQqQmBfXGcFOUMvK
	uXr/SLhWtDFiC8ee3tTNdTcdUtsHtHneEVedgLbgZvA0fi2hRu03kqbuyK0FddDHwpT6jQQtsZf
	79/26arkLDQYmGIGsOcU2AJJB04wfhL6h0WYdWrsjQt6xAeeGHW8pUQufCoHuKFJdIj2YLDx2zy
	3PZTAadKT0rEogMTkdnVbSjukVkeCovvTnl8IW3+egmSm/7FNG+5EpSudbwKS71z8yModkD+5U9
	cJ8dkKOqvfjO/3WqhJJiagAOjEACTOYFJqPwx8ZHgGH2OaGp2E99kkenaHXep8
X-Received: by 2002:a17:903:2d0:b0:2c1:ee6e:be1d with SMTP id d9443c01a7336-2c665ec6cc3mr4015ad.27.1781293165632;
        Fri, 12 Jun 2026 12:39:25 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd66fsm3628185a91.12.2026.06.12.12.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:39:24 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:39:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <aixgZQiBQKgS7yIM@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-7-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-7-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:20PM +0100, Matt Evans wrote:
> Previously, vfio_pci_zap_bars() (and the wrapper
> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
> calls to vfio_pci_dma_buf_move().
> 
> This commit replaces them with a unified new function,
> vfio_pci_zap_revoke_bars() containing both the vfio_pci_dma_buf_move()
> and the unmap_mapping_range(), making it harder for callers to omit
> one.  It adds a wrapper, vfio_pci_lock_zap_revoke_bars(), which takes
> the write memory_lock before zapping, and adds a new
> vfio_pci_unrevoke_bars() for the re-enable path.
> 
> As of "vfio/pci: Convert BAR mmap() to use a DMABUF", the
> unmap_mapping_range() to zap is no longer performed for vfio-pci since
> the DMABUFs used for BAR mappings already zap PTEs when the
> vfio_pci_dma_buf_move() occurs.
> 
> However, it must be assumed that VFIO drivers which override the .mmap
> op could create mappings _not_ backed by DMABUFs.  So, the zap is
> still performed on revoke if .mmap is overridden, using a new
> zap_bars_on_revoke flag.  A driver can explicitly opt out; the flag is
> cleared by the hisi_acc_vfio_pci driver, since its .mmap just wraps
> vfio_pci_core_mmap() and so still uses DMABUFs.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  8 +++
>  drivers/vfio/pci/vfio_pci_config.c            | 30 ++++----
>  drivers/vfio/pci/vfio_pci_core.c              | 70 +++++++++++++------
>  drivers/vfio/pci/vfio_pci_priv.h              |  3 +-
>  include/linux/vfio_pci_core.h                 |  1 +
>  5 files changed, 73 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 86362ec424a5..51990f6d66d5 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1692,6 +1692,14 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>  	if (ret)
>  		goto out_put_vdev;
>  
> +	/*
> +	 * hisi_acc_vfio_pci_mmap() calls down to
> +	 * vfio_pci_core_mmap(), so BAR mappings are still
> +	 * DMABUF-backed.  They don't require a zap on revoke, so opt
> +	 * out:
> +	 */
> +	hisi_acc_vdev->core_device.zap_bars_on_revoke = false;
> +

This seems to be happening after we vfio_pci_core_register_device, which
could be slightly problematic if another device in the same group races 
to trigger a hot reset before we can set this to false. Could we 
initialize this flag before registration instead?

>  	hisi_acc_vfio_debug_init(hisi_acc_vdev);
>  	return 0;
>  
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index a10ed733f0e3..8bfab0da481c 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -590,12 +590,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		virt_mem = !!(le16_to_cpu(*virt_cmd) & PCI_COMMAND_MEMORY);
>  		new_mem = !!(new_cmd & PCI_COMMAND_MEMORY);
>  
> -		if (!new_mem) {
> -			vfio_pci_zap_and_down_write_memory_lock(vdev);
> -			vfio_pci_dma_buf_move(vdev, true);
> -		} else {
> +		if (!new_mem)
> +			vfio_pci_lock_zap_revoke_bars(vdev);
> +		else
>  			down_write(&vdev->memory_lock);
> -		}
>  
>  		/*
>  		 * If the user is writing mem/io enable (new_mem/io) and we
> @@ -631,7 +629,7 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		*virt_cmd |= cpu_to_le16(new_cmd & mask);
>  
>  		if (__vfio_pci_memory_enabled(vdev))
> -			vfio_pci_dma_buf_move(vdev, false);
> +			vfio_pci_unrevoke_bars(vdev);
>  		up_write(&vdev->memory_lock);
>  	}
>  
> @@ -712,16 +710,14 @@ static int __init init_pci_cap_basic_perm(struct perm_bits *perm)
>  static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
>  					  pci_power_t state)
>  {
> -	if (state >= PCI_D3hot) {
> -		vfio_pci_zap_and_down_write_memory_lock(vdev);
> -		vfio_pci_dma_buf_move(vdev, true);
> -	} else {
> +	if (state >= PCI_D3hot)
> +		vfio_pci_lock_zap_revoke_bars(vdev);
> +	else
>  		down_write(&vdev->memory_lock);
> -	}
>  
>  	vfio_pci_set_power_state(vdev, state);
>  	if (__vfio_pci_memory_enabled(vdev))
> -		vfio_pci_dma_buf_move(vdev, false);
> +		vfio_pci_unrevoke_bars(vdev);
>  	up_write(&vdev->memory_lock);
>  }
>  
> @@ -908,11 +904,10 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>  						 &cap);
>  
>  		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
> -			vfio_pci_zap_and_down_write_memory_lock(vdev);
> -			vfio_pci_dma_buf_move(vdev, true);
> +			vfio_pci_lock_zap_revoke_bars(vdev);
>  			pci_try_reset_function(vdev->pdev);
>  			if (__vfio_pci_memory_enabled(vdev))
> -				vfio_pci_dma_buf_move(vdev, false);
> +				vfio_pci_unrevoke_bars(vdev);
>  			up_write(&vdev->memory_lock);
>  		}
>  	}
> @@ -993,11 +988,10 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>  						&cap);
>  
>  		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
> -			vfio_pci_zap_and_down_write_memory_lock(vdev);
> -			vfio_pci_dma_buf_move(vdev, true);
> +			vfio_pci_lock_zap_revoke_bars(vdev);
>  			pci_try_reset_function(vdev->pdev);
>  			if (__vfio_pci_memory_enabled(vdev))
> -				vfio_pci_dma_buf_move(vdev, false);
> +				vfio_pci_unrevoke_bars(vdev);
>  			up_write(&vdev->memory_lock);
>  		}
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f9636d8f9e2a..5ea0bd4e7876 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -319,8 +319,7 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
>  	 * The vdev power related flags are protected with 'memory_lock'
>  	 * semaphore.
>  	 */
> -	vfio_pci_zap_and_down_write_memory_lock(vdev);
> -	vfio_pci_dma_buf_move(vdev, true);
> +	vfio_pci_lock_zap_revoke_bars(vdev);
>  
>  	if (vdev->pm_runtime_engaged) {
>  		up_write(&vdev->memory_lock);
> @@ -406,7 +405,7 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
>  	down_write(&vdev->memory_lock);
>  	__vfio_pci_runtime_pm_exit(vdev);
>  	if (__vfio_pci_memory_enabled(vdev))
> -		vfio_pci_dma_buf_move(vdev, false);
> +		vfio_pci_unrevoke_bars(vdev);
>  	up_write(&vdev->memory_lock);
>  }
>  
> @@ -1256,6 +1255,8 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +static void vfio_pci_zap_revoke_bars(struct vfio_pci_core_device *vdev);
> +
>  static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  				void __user *arg)
>  {
> @@ -1264,7 +1265,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	if (!vdev->reset_works)
>  		return -EINVAL;
>  
> -	vfio_pci_zap_and_down_write_memory_lock(vdev);
> +	down_write(&vdev->memory_lock);
>  
>  	/*
>  	 * This function can be invoked while the power state is non-D0. If
> @@ -1277,10 +1278,11 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	 */
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
> -	vfio_pci_dma_buf_move(vdev, true);
> +	vfio_pci_zap_revoke_bars(vdev);

I'm wondering if this change in behavior is correct?
BEFORE this patch the sequence was:

1. zap vma mappings
2. Enter D0

After this patch the sequence becomes

1. Take the lock
2. Enter D0
3. zap vma mappings

My worry is if user-space accesses a BAR *during* the transition to D0,
it could crash since the mappings still exist during the transition?

The old code is immune to it because it removed user-mappings first.

Following the discussion from v1 regarding the ordering of 
vfio_pci_dma_buf_move() and the D0 transition.. while it makes sense to
perform the DMABUF revocation/move after the hardware is in D0.. I'm not
too confident about moving zap after D0 :/ 

I mean, sure, the user would just see all Fs on a read and writes will
be dropped silently until we are in D0.. but the behaviour before this
change was that the user access will fault and hang on the memory_lock 
instead which ensures that the user observes a consistent dev state..

> +
>  	ret = pci_try_reset_function(vdev->pdev);
>  	if (__vfio_pci_memory_enabled(vdev))
> -		vfio_pci_dma_buf_move(vdev, false);
> +		vfio_pci_unrevoke_bars(vdev);
>  	up_write(&vdev->memory_lock);
>  
>  	return ret;
> @@ -1648,20 +1650,37 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
>  }

Thanks,
Praan
