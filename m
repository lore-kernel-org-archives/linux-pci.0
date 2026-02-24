Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E233AD9C
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958291; cv=none; b=bbgeIXqLmI98C3vcu4cJHMH7ucapVkmdmM+xf9b3plIGjSYzS6M+X42TloEq26YjPbTbJikkcVCZKodQYn8yA7eno2Svd+QE72TXljZQ1DyNgBVWkDfr+GeSeD0o9bFHXywrfczLtJ2VCeMrum5idGELiSwYQzU3Zp4NrDQrmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958291; c=relaxed/simple;
	bh=/VFws7yHRVwMx2ys0Mm0vU5eWYKCULINEPybUvkvc/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLAFUJltDMFv1uTVKjx4BxOs0j8T/aa4ycKHs9WYML5Gi6xs3slrDK7ydWNeJI+TcPRbiXouN1u24s0iJM39dmRZVfe76VXHnDZyVW94ddg9a3wiOIxlFbrMDYiQnUSrI0QCQY5K3p0mK+bkE/Pil8DEQG3dEjvhyIHQmPdTalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jio4gGX+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jio4gGX+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ada9e4ea32so5555ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771958289; x=1772563089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXKJ6/hKtL2Tqg7iZ1FrnbB55AHiiDCgqCoKiJbuxWs=;
        b=Jio4gGX+NVH6174cBnIXYHqlXMXET5t5wI2vpKorpxws64RY1Qpe/3PRCl4tUZO9Is
         EzNeeGn8/U9cfSmjeKCU+VIxWcXukC9ZR7AbjGFifsIUPMj+LnzITsCdiG3kFKbPRdpL
         QbtB8420qT7G6REqSmPj0O0AQVuw3HH58V63QT0uKjrABGPOVAcneGvrxtVI+xvD1W7i
         SXjM5PKsr52RUZTiG8TdXR3yu03Vf4hTJaoIg5lAY7bj7K/aQSGDJ1YmBba1V6GohF1O
         KIQzQX48pSLBEvIigiVkGuyFI2fMcwe+JuPkz/YHscK4rjAgnzBq9UCqPZE8fHy62SNf
         lLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958289; x=1772563089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXKJ6/hKtL2Tqg7iZ1FrnbB55AHiiDCgqCoKiJbuxWs=;
        b=BKFXH0UICiQu4yZ8KQgaozmLK1n+3m48UDLDxWyGcfq9+ItXWCjFEoPxq9ShTRvx2d
         nRU8GNbK7hD5BluRFisNvG5NpBzUks9ZxHfNiU5y1YCPls/OKIKfaoRBDyI+A4YSAZ86
         Vm/NrVkIfLnYEA9cZBTjnAOOzPjUMPblHkMcedRLqlhglQ1eIU4UOpIYJh2n35OLdLiK
         gu4sFtONisot0hmvL6jBfpK4A7TbibrKIKTd20EjXwCm8f4hJ2qVLAY00Pv+fO7hSByO
         gMtLofzuAPtyFVA1kJTCb6L/i6pg3Xbrniod+U12uJ7hS1lKCnmbi7YBFVjt2APFasH4
         veUA==
X-Forwarded-Encrypted: i=1; AJvYcCXKp0xtNmGCaAh2Hzm0RWy5teWfW8xBrmhNznUWtyOSn+dLWBQ0Wc/owN0bg6Q1rQsqQFuR2pzc5ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZoPiW9mK5HJf7lB3t0ayV/RLJkur2lsMAz6X94Kg6nAUarGY
	nLXx1Ms1KvV0GgCDtxMJnklYBkSo8BhWon8qjT137/zkjcVWAmqfbnaHqaC9ilRaNA==
X-Gm-Gg: ATEYQzxIJypYVjTUeTZ3QBsLYyO6gqgTNCEu9/hyyXtrXqw5hU2EKoLyj0vm9uUWvCp
	Xw82Zd78k4Ml4Swn/Nl5FXhFrNVk3SlJsWh9jTcnsEy2+vltR3dYovM6K3KA4Fzsb0E3hh/TrOq
	aDz3ikSPSaOEvyRrQCkEj6V0Q3EXP6UYf4iBGKbyFnwGSQLmWKvLzBKbTc+Z8hdPJ2CphpvfHM0
	epQ3rs4XtVh7Se8SOuO1ZpaFfuzA3YjEwb5hYrogzxt7lwSxszR66UZpbCwbbil3QO4kY5djgmt
	spMzoIfbHAhKSx+jzY1Mqx3RZ/0AAwuP0ruXusrK+wl1d64ig+wHhbyGd0hzZoIS2DuXAIr19qj
	kBQTNw/pZNm1xKGCqMdc0guafhqwbL+NECp2U5yLj3BGPKy+WGudHXJ8Blv7jbnPU76836qFNo8
	ZDC7fzSS+wbrMZc74ZvjKBhxPbzJgMZJeUlurlwpLzSVY29yh3oGegGV79Dxhv
X-Received: by 2002:a17:903:2f8b:b0:2ad:6f9b:7818 with SMTP id d9443c01a7336-2adca88478dmr70235ad.23.1771958288771;
        Tue, 24 Feb 2026 10:38:08 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5db00sm156866805ad.23.2026.02.24.10.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:38:07 -0800 (PST)
Date: Tue, 24 Feb 2026 18:37:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 05/22] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <aZ3wBpYSF7mQv_GZ@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-6-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-6-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:52PM +0000, David Matlack wrote:
> From: Vipin Sharma <vipinsh@google.com>
> 
> Implement the live update file handler callbacks to preserve a vfio-pci
> device across a Live Update. Subsequent commits will enable userspace to
> then retrieve this file after the Live Update.
> 
> Live Update support is scoped only to cdev files (i.e. not
> VFIO_GROUP_GET_DEVICE_FD files).
> 
> State about each device is serialized into a new ABI struct
> vfio_pci_core_device_ser. The contents of this struct are preserved
> across the Live Update to the next kernel using a combination of
> Kexec-Handover (KHO) to preserve the page(s) holding the struct and the
> Live Update Orchestrator (LUO) to preserve the physical address of the
> struct.
> 
> For now the only contents of struct vfio_pci_core_device_ser the
> device's PCI segment number and BDF, so that the device can be uniquely
> identified after the Live Update.
> 
> Require that userspace disables interrupts on the device prior to
> freeze() so that the device does not send any interrupts until new
> interrupt handlers have been set up by the next kernel.
> 
> Reset the device and restore its state in the freeze() callback. This
> ensures the device can be received by the next kernel in a consistent
> state. Eventually this will be dropped and the device can be preserved
> across in a running state, but that requires further work in VFIO and
> the core PCI layer.
> 
> Note that LUO holds a reference to this file when it is preserved. So
> VFIO is guaranteed that vfio_df_device_last_close() will not be called
> on this device no matter what userspace does.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Co-developed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/pci/vfio_pci.c            |  2 +-
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 84 +++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h       |  2 +
>  drivers/vfio/vfio.h                    | 13 ----
>  drivers/vfio/vfio_main.c               | 10 +--
>  include/linux/kho/abi/vfio_pci.h       | 15 +++++
>  include/linux/vfio.h                   | 28 +++++++++
>  7 files changed, 129 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 19e88322af2c..0260afb9492d 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
>  	return 0;
>  }
>  
> -static const struct vfio_device_ops vfio_pci_ops = {
> +const struct vfio_device_ops vfio_pci_ops = {
>  	.name		= "vfio-pci",
>  	.init		= vfio_pci_core_init_dev,
>  	.release	= vfio_pci_core_release_dev,
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index b84e63c0357b..f01de98f1b75 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -8,25 +8,104 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/kexec_handover.h>
>  #include <linux/kho/abi/vfio_pci.h>
>  #include <linux/liveupdate.h>
>  #include <linux/errno.h>
> +#include <linux/vfio.h>
>  
>  #include "vfio_pci_priv.h"
>  
>  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>  					     struct file *file)
>  {
> -	return false;
> +	struct vfio_device_file *df = to_vfio_device_file(file);
> +
> +	if (!df)
> +		return false;
> +
> +	/* Live Update support is limited to cdev files. */
> +	if (df->group)
> +		return false;
> +
> +	return df->device->ops == &vfio_pci_ops;
>  }
>  
>  static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  {
> -	return -EOPNOTSUPP;
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device_ser *ser;
> +	struct vfio_pci_core_device *vdev;
> +	struct pci_dev *pdev;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	pdev = vdev->pdev;
> +
> +	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
> +		return -EINVAL;
> +
> +	if (vfio_pci_is_intel_display(pdev))
> +		return -EINVAL;
> +
> +	ser = kho_alloc_preserve(sizeof(*ser));
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);
> +
> +	ser->bdf = pci_dev_id(pdev);
> +	ser->domain = pci_domain_nr(pdev->bus);
> +
> +	args->serialized_data = virt_to_phys(ser);
> +	return 0;
>  }
>  
>  static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>  {
> +	kho_unpreserve_free(phys_to_virt(args->serialized_data));
> +}
> +
> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
> +{
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device *vdev;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	pdev = vdev->pdev;
> +
> +	guard(mutex)(&device->dev_set->lock);
> +
> +	/*
> +	 * Userspace must disable interrupts on the device prior to freeze so
> +	 * that the device does not send any interrupts until new interrupt
> +	 * handlers have been established by the next kernel.
> +	 */
> +	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
> +		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
> +		return -EINVAL;
> +	}
> +
> +	pci_dev_lock(pdev);
> +
> +	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * Reset the device and restore it back to its original state before
> +	 * handing it to the next kernel.
> +	 *
> +	 * Eventually both of these should be dropped and the device should be
> +	 * kept running with its current state across the Live Update.
> +	 */
> +	if (vdev->reset_works)
> +		ret = __pci_reset_function_locked(pdev);

I see the 'Eventually both of these should be dropped' comment,
which acknowledges that a reset is a v1 crutch. However, I wanted to
clarify the fallback strategy here.

If vdev->reset_works is false, we skip the reset but still jump into the
new kernel. For devices that don't support FLR, are we comfortable jumping
with the device potentially still hot? 

> +
> +	pci_restore_state(pdev);
> +
> +out:
> +	pci_dev_unlock(pdev);
> +	return ret;
>  }
>  
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
> @@ -42,6 +121,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
>  	.can_preserve = vfio_pci_liveupdate_can_preserve,
>  	.preserve = vfio_pci_liveupdate_preserve,
>  	.unpreserve = vfio_pci_liveupdate_unpreserve,
> +	.freeze = vfio_pci_liveupdate_freeze,
>  	.retrieve = vfio_pci_liveupdate_retrieve,
>  	.finish = vfio_pci_liveupdate_finish,
>  	.owner = THIS_MODULE,
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 68966ec64e51..d3da79b7b03c 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -11,6 +11,8 @@
>  /* Cap maximum number of ioeventfds per device (arbitrary) */
>  #define VFIO_PCI_IOEVENTFD_MAX		1000
>  
> +extern const struct vfio_device_ops vfio_pci_ops;
> +
>  struct vfio_pci_ioeventfd {
>  	struct list_head	next;
>  	struct vfio_pci_core_device	*vdev;
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 50128da18bca..6b89edbbf174 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -16,17 +16,6 @@ struct iommufd_ctx;
>  struct iommu_group;
>  struct vfio_container;
>  
> -struct vfio_device_file {
> -	struct vfio_device *device;
> -	struct vfio_group *group;
> -
> -	u8 access_granted;
> -	u32 devid; /* only valid when iommufd is valid */
> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> -	struct kvm *kvm;
> -	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> -};
> -
>  void vfio_device_put_registration(struct vfio_device *device);
>  bool vfio_device_try_get_registration(struct vfio_device *device);
>  int vfio_df_open(struct vfio_device_file *df);
> @@ -34,8 +23,6 @@ void vfio_df_close(struct vfio_device_file *df);
>  struct vfio_device_file *
>  vfio_allocate_device_file(struct vfio_device *device);
>  
> -extern const struct file_operations vfio_device_fops;
> -
>  #ifdef CONFIG_VFIO_NOIOMMU
>  extern bool vfio_noiommu __read_mostly;
>  #else
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index f7df90c423b4..276f615f0c28 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1436,15 +1436,7 @@ const struct file_operations vfio_device_fops = {
>  	.show_fdinfo	= vfio_device_show_fdinfo,
>  #endif
>  };
> -
> -static struct vfio_device *vfio_device_from_file(struct file *file)
> -{
> -	struct vfio_device_file *df = file->private_data;
> -
> -	if (file->f_op != &vfio_device_fops)
> -		return NULL;
> -	return df->device;
> -}
> +EXPORT_SYMBOL_GPL(vfio_device_fops);
>  
>  /**
>   * vfio_file_is_valid - True if the file is valid vfio file
> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
> index 37a845eed972..9bf58a2f3820 100644
> --- a/include/linux/kho/abi/vfio_pci.h
> +++ b/include/linux/kho/abi/vfio_pci.h
> @@ -9,6 +9,9 @@
>  #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
>  #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
>  
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
>  /**
>   * DOC: VFIO PCI Live Update ABI
>   *
> @@ -25,4 +28,16 @@
>  
>  #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
>  
> +/**
> + * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
> + * device.
> + *
> + * @bdf: The device's PCI bus, device, and function number.
> + * @domain: The device's PCI domain number (segment).
> + */
> +struct vfio_pci_core_device_ser {
> +	u16 bdf;
> +	u16 domain;
> +} __packed;
> +
>  #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index e90859956514..9aa1587fea19 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -81,6 +81,34 @@ struct vfio_device {
>  #endif
>  };
>  
> +struct vfio_device_file {
> +	struct vfio_device *device;
> +	struct vfio_group *group;
> +
> +	u8 access_granted;
> +	u32 devid; /* only valid when iommufd is valid */
> +	spinlock_t kvm_ref_lock; /* protect kvm field */
> +	struct kvm *kvm;
> +	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> +};
> +
> +extern const struct file_operations vfio_device_fops;
> +

There seem to be two extern declarations for vfio_device_fops in both
vfio_pci_priv.h and include/linux/vfio.h. Could we consolidate these?

> +static inline struct vfio_device_file *to_vfio_device_file(struct file *file)
> +{
> +	if (file->f_op != &vfio_device_fops)
> +		return NULL;
> +
> +	return file->private_data;
> +}
> +
> +static inline struct vfio_device *vfio_device_from_file(struct file *file)
> +{
> +	struct vfio_device_file *df = to_vfio_device_file(file);
> +
> +	return df ? df->device : NULL;
> +}
> +

I'm a little uncomfortable with this part. Why is it necessary to expose
the internal vfio_device_file structure to drivers? If this is only to 
support vfio_device_from_file(), could we not keep the structure private
and just export the helper function instead? 

Exposing internal state into the public API introduces some maintenance
constraints for e.g. if vfio_main.c ever changes how it tracks 
file-to-device mappings or its internal security state (like 
access_granted), it now has to worry about breaking external drivers.

I believe we expose the struct just to power these static inline helper
(mainly vfio_device_from_file) ? Instead, could we treat
`vfio_device_file` as an opaque type in the public header (like struct 
iommu_group) and move the implementation of vfio_device_from_file() into
vfio_main.c as an exported symbol? This gives drivers the vfio_device 
pointer they need without leaking the core's private internals. Maybe
something like the following (untested):

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index f7df90c423b4..71e3dda53187 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1446,6 +1446,18 @@ static struct vfio_device *vfio_device_from_file(struct file *file)
        return df->device;
 }

+struct vfio_device *vfio_device_from_file(struct file *file)
+{
+       struct vfio_device_file *df;
+
+       if (file->f_op != &vfio_device_fops)
+               return NULL;
+
+       df = file->private_data;
+       return df->device;
+}
+EXPORT_SYMBOL_GPL(vfio_device_from_file);
+
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
  * @file: VFIO group file or VFIO device file
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514..182f192c5641 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -81,6 +81,15 @@ struct vfio_device {
 #endif
 };

+
+struct vfio_device_file;
+
+extern const struct file_operations vfio_device_fops;
+
+/* Public API for drivers */
+struct vfio_device *vfio_device_from_file(struct file *file);
+ [...]
+

>  /**
>   * struct vfio_device_ops - VFIO bus driver device callbacks
>   *
> -- 
> 2.53.0.rc1.225.gd81095ad13-goog
> 

Thanks,
Praan
