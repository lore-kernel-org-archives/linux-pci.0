Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB643ACA5B
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960783; cv=none; b=uJCFm0zYtaKoN0G7xreSZ8uqVkMLCmPphtrPyI+CWuBqwEC4pfDWQR+EhXPHmNj+zPE4BH1hn7yCQjAoD+iwcvT6E13Ml/snRLmZLFhb+g+epP/KRACJVV07v3edD+1Bcti19IA0UGkXNr+T0XSSW0IvWGeHJPnQo4MeJpFwBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960783; c=relaxed/simple;
	bh=vOxQW4tIZDupBiA9aw4OS9PPKVcBbPJeLo4Nl1HE1fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMNw+hnbODli5fyscAvvNXsq44zve/H9k7TXLHjHWDDv2aYNUMEAiAEf18habRijpdgemajkpd9tByj6c4JjHWrE0TdqsPFcEKpl2atim3gp6YJosNhIBwgmDtRzpoegoi6tVZS/u/5QAAzFIdnM9hhHhABdurZxTImiqi/PTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2knlyTTs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2knlyTTs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ada9e4ea32so10305ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771960781; x=1772565581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gr8G2sJEnb4CcsPQ1rrAHuOyQl/uEocyHUTrMBlTuWs=;
        b=2knlyTTsvu2arP7M0ydIZT2YU23Ry9AcZ3C7VvMMQPZ6zbn9QTYj02FgPAmCyXV+0x
         jt/Wdd+6wQQrd7V+iTZwVu5VPj8nqxwiEx2Oa4hdhhhRa7nabopQmuwsX1/jIokX0oVi
         nDOee/RnAlwK8R+B8m0WXcjhIuYhlY3EVsSi42MPTjt5rGbnm1iUk8l3uFLxSuUisXgx
         wOO4tD2yQr9LyhjIkQyGi1f4s+INDLO+RYEw63/EOJMd5SQlE9CFYTLIDDMW6Ac36513
         307IKl8xNptgcDjBnSvrNOEWTw12I3255UpEheps0gZjxENuWIZy2/CgmjVnK2I60vck
         by4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960781; x=1772565581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gr8G2sJEnb4CcsPQ1rrAHuOyQl/uEocyHUTrMBlTuWs=;
        b=fJ8NiqsIaEHbwQ84JtHrCAb810eqSICHuapl63YhQjJDTEg6DWk2Vcs9Vh6vza8qU8
         0ApyjiEs6RVdlz1ah5c7sn6OThMirJSPTT+k+2eWbjMnbAyWv9a9/rtiT5J1o3oM3Vrh
         J7DFaqLAev7H6WklKVyyY0/i7/RAj8BQ9mfRxc2jn9bpe0+kd/Ir2pJPL/3iKqpaLG6o
         cXBGz9yJh/HCfAutQSlfkNq9Yw8SJYMjzG593aNvGf2q+quglBripIV8Tr0bdIGFbmOb
         CksqyFMU8OstAoUskzqRxruiaefX+Gaek+JtLnj9KmRnFeEvW3cmehxCcVdVeqlcwKzA
         qFww==
X-Forwarded-Encrypted: i=1; AJvYcCX824pojkCoe2IPp97lbsf+fhflSZ+Jgne3HykMSjyyKcmlurDGSNhVbU6rElFCtWTMfqlW3+bwLcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpeiMCeR5hN7j1KbCklnrJAWJBjDiBLW+O/7/DWGKjPDKbQbjx
	xM5BY4a6iYELHUOsJgjJFbZxip2NaOZF7sp4fKv0NKZXYVwBuqdBJVbd2grwmQsqvQ==
X-Gm-Gg: ATEYQzxqQ7t7Ifqq0WUS+S95pbvIJPHSuYm9qzLrJ3wllaS6lf5AnVNOKs52w/leBzC
	owS1vfO1MmkR+La+FBK/C5H+AxVc2XTGxFuYOjohNO/TLAmwU8X9duijzuRUNs7C04xU1WvxDcN
	ZkWfDUe9yfgKgCTWVDlKcq6d4e115mFzhcIvhmbFgI6qUdn5PUlCiNDKzwkgn4UCKQBZFYC4mx3
	xONjpm+vSTQXEufroyavdDXsFz8x7Sqj6/QZKx1Pn0FRjB9Ap77Dc3a/WfpeUOis5nZBbGKmLeO
	CGH2IQ627u47X9TlcGqxBH+aGbBWKHD0/j0Q9MprP1hbt0m0E+1yYgyFIGrE4DHulm1uiPwQ+MW
	1yt3qI29hFcu7nS251c1yCSlz+BbckDgamORX2Xhq5tMm8KM0+bjPm7lDAisGK14RRtf+1rhoZM
	Q8CmSAERbJ8Eu77xm+xrWFNWJkKtOcC/4wc9Vniy4JAcdPDnEIAguifDkF5c2w
X-Received: by 2002:a17:902:f64a:b0:2aa:d604:62f3 with SMTP id d9443c01a7336-2adca6c8c34mr298805ad.10.1771960780478;
        Tue, 24 Feb 2026 11:19:40 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd64367bsm11607309b3a.4.2026.02.24.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:19:39 -0800 (PST)
Date: Tue, 24 Feb 2026 19:19:30 +0000
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
Subject: Re: [PATCH v2 06/22] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <aZ35wv5CKUtVoYII@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-7-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-7-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:53PM +0000, David Matlack wrote:
> From: Vipin Sharma <vipinsh@google.com>
> 
> Enable userspace to retrieve preserved VFIO device files from VFIO after
> a Live Update by implementing the retrieve() and finish() file handler
> callbacks.
> 
> Use an anonymous inode when creating the file, since the retrieved
> device file is not opened through any particular cdev inode, and the
> cdev inode does not matter in practice.
> 
> For now the retrieved file is functionally equivalent a opening the
> corresponding VFIO cdev file. Subsequent commits will leverage the
> preserved state associated with the retrieved file to preserve bits of
> the device across Live Update.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Co-developed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/device_cdev.c             | 21 ++++++---
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 60 +++++++++++++++++++++++++-
>  drivers/vfio/vfio_main.c               | 13 ++++++
>  include/linux/vfio.h                   | 12 ++++++
>  4 files changed, 98 insertions(+), 8 deletions(-)
> 

The use of anon_inode_getfile_fmode() is clever! The abstraction is
clean as well. 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks!
Praan

> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 8ceca24ac136..935f84a35875 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -16,14 +16,8 @@ void vfio_init_device_cdev(struct vfio_device *device)
>  	device->cdev.owner = THIS_MODULE;
>  }
>  
> -/*
> - * device access via the fd opened by this function is blocked until
> - * .open_device() is called successfully during BIND_IOMMUFD.
> - */
> -int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
> +int __vfio_device_fops_cdev_open(struct vfio_device *device, struct file *filep)
>  {
> -	struct vfio_device *device = container_of(inode->i_cdev,
> -						  struct vfio_device, cdev);
>  	struct vfio_device_file *df;
>  	int ret;
>  
> @@ -52,6 +46,19 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>  	vfio_device_put_registration(device);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(__vfio_device_fops_cdev_open);
> +
> +/*
> + * device access via the fd opened by this function is blocked until
> + * .open_device() is called successfully during BIND_IOMMUFD.
> + */
> +int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
> +{
> +	struct vfio_device *device = container_of(inode->i_cdev,
> +						  struct vfio_device, cdev);
> +
> +	return __vfio_device_fops_cdev_open(device, filep);
> +}
>  
>  static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
>  {
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index f01de98f1b75..7f4117181fd0 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -8,6 +8,8 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/anon_inodes.h>
> +#include <linux/file.h>
>  #include <linux/kexec_handover.h>
>  #include <linux/kho/abi/vfio_pci.h>
>  #include <linux/liveupdate.h>
> @@ -108,13 +110,68 @@ static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
>  	return ret;
>  }
>  
> +static int match_device(struct device *dev, const void *arg)
> +{
> +	struct vfio_device *device = container_of(dev, struct vfio_device, device);
> +	const struct vfio_pci_core_device_ser *ser = arg;
> +	struct pci_dev *pdev;
> +
> +	pdev = dev_is_pci(device->dev) ? to_pci_dev(device->dev) : NULL;
> +	if (!pdev)
> +		return false;
> +
> +	return ser->bdf == pci_dev_id(pdev) && ser->domain == pci_domain_nr(pdev->bus);
> +}
> +
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
>  {
> -	return -EOPNOTSUPP;
> +	struct vfio_pci_core_device_ser *ser;
> +	struct vfio_device *device;
> +	struct file *file;
> +	int ret;
> +
> +	ser = phys_to_virt(args->serialized_data);
> +
> +	device = vfio_find_device(ser, match_device);
> +	if (!device)
> +		return -ENODEV;
> +
> +	/*
> +	 * Simulate opening the character device using an anonymous inode. The
> +	 * returned file has the same properties as a cdev file (e.g. operations
> +	 * are blocked until BIND_IOMMUFD is called).
> +	 */
> +	file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
> +					&vfio_device_fops, NULL,
> +					O_RDWR, FMODE_PREAD | FMODE_PWRITE);
> +	if (IS_ERR(file)) {
> +		ret = PTR_ERR(file);
> +		goto out;
> +	}
> +
> +	ret = __vfio_device_fops_cdev_open(device, file);
> +	if (ret) {
> +		fput(file);
> +		goto out;
> +	}
> +
> +	args->file = file;
> +
> +out:
> +	/* Drop the reference from vfio_find_device() */
> +	put_device(&device->device);
> +
> +	return ret;
> +}
> +
> +static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
> +{
> +	return args->retrieved;
>  }
>  
>  static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
>  {
> +	kho_restore_free(phys_to_virt(args->serialized_data));
>  }
>  
>  static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> @@ -123,6 +180,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
>  	.unpreserve = vfio_pci_liveupdate_unpreserve,
>  	.freeze = vfio_pci_liveupdate_freeze,
>  	.retrieve = vfio_pci_liveupdate_retrieve,
> +	.can_finish = vfio_pci_liveupdate_can_finish,
>  	.finish = vfio_pci_liveupdate_finish,
>  	.owner = THIS_MODULE,
>  };
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 276f615f0c28..89c5feef75d5 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -13,6 +13,7 @@
>  #include <linux/cdev.h>
>  #include <linux/compat.h>
>  #include <linux/device.h>
> +#include <linux/device/class.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
>  #include <linux/iommu.h>
> @@ -1758,6 +1759,18 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
>  }
>  EXPORT_SYMBOL(vfio_dma_rw);
>  
> +struct vfio_device *vfio_find_device(const void *data, device_match_t match)
> +{
> +	struct device *device;
> +
> +	device = class_find_device(vfio.device_class, NULL, data, match);
> +	if (!device)
> +		return NULL;
> +
> +	return container_of(device, struct vfio_device, device);
> +}
> +EXPORT_SYMBOL_GPL(vfio_find_device);
> +
>  /*
>   * Module/class support
>   */
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 9aa1587fea19..dc592dc00f89 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -419,4 +419,16 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
>  void vfio_virqfd_disable(struct virqfd **pvirqfd);
>  void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
>  
> +#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
> +int __vfio_device_fops_cdev_open(struct vfio_device *device, struct file *filep);
> +#else
> +static inline int __vfio_device_fops_cdev_open(struct vfio_device *device,
> +					       struct file *filep)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
> +
> +struct vfio_device *vfio_find_device(const void *data, device_match_t match);
> +
>  #endif /* VFIO_H */
> -- 
> 2.53.0.rc1.225.gd81095ad13-goog
> 
