Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567230CDB6
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006164; cv=none; b=mZN9s9dsc7UMBu32sUoZoz1yLxb0k1+DGRh60ZbGE0RFcNrmkThwUCcog/KAMoXfaFyYDE1NFE/awTCymtGihmhQvquXj0PQMk/cQ1gtkPiBgi2YBVSXlBhR9sTekGN7wvUQhdDJUbtmk8sx1W5qFrW85o/PjEO4Cd/JddJuBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006164; c=relaxed/simple;
	bh=/phNhW5Uy8/CpWeGcbySlurAcomYqpo/e8d49tUgN+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG0R674fKpUxyXYb6v2Sm/bhZ5WvJa4sxHs82deRXsBZn/QUtVTp8hhH+jKkdoykGDzIkb5lfHVb3ydP8uhDbiHw2NKBpEbUixfaMRaVbRe+W02LRSZL2yFsUjKeylZDAn+TOZoVIiL9rLVcxaFH9sElhAHI2RBIfmNL9M4cGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMr5HWXx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMr5HWXx"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aad8123335so58375ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772006163; x=1772610963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sT2VtKh2V5oEus0jIgTdEjDE+//UyVLRT7BohuHzzWw=;
        b=cMr5HWXxsinnyXoEwMHazVNRF3kOv/wkVKQxR+M98tFKdRWHFYT8B06/GW9yfsBqAW
         j5fFyDjk/0eKSa7ZENGTrj1QKZkZ75EZZYioyJhoS34pkZFhd3iC3jGQldklBdUtr90D
         ox8GgTpNMyc5aFO8FWk/RCKCyXYWDJ5Iqe2S1AVAbuiYtc54b7/YCL5SkVCCXzLcow+s
         2FpsosqfcxYfpLVjeGADRu3H4JO0TBCamAHtADHIVnFtQh98APl2+mvxIAJR5+qrI1XZ
         QPCVl26UKxp+e6jQQ+SOE1Q4WxjNLJYKkT4sCVAvh3byNDLO4broTTmZ4rO3wlC5jvso
         3PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772006163; x=1772610963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT2VtKh2V5oEus0jIgTdEjDE+//UyVLRT7BohuHzzWw=;
        b=w3dF85vAu8SphkMmjRGrWGJAzi5CJhBtViXQvnpVtdkiNZTLYZmuD2G53JJo8S1dOL
         jSeFOfTStFkdh7mgpTiwaRYRVLnUPm1hyR8//fExwLNiGYeDkCfX9KnRVzEU5yVoprmj
         weSqZtKL80WqU53+EKMwOfvz3DW+KBjGKYZ01J1mBDaoxyDS3WtGCBVF86YhM0PT3eGq
         +bR5ssW3086KB8qYgUBUC4YVmkNyVPC8E7ziQ677SceMZvDFn0bDbMZomXXEzNPUa2xp
         yhFJ7jGxWkHbmuxOhvqgBgBsFJ6DGqKq/JRU+O1/HVKMCTn1G8ldjrLabZYVjF9S7Zxg
         0e3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoyWxo/egwQgFym3r8Z6tJByDi+MoaL6U2Mdk5HezkV9/bcaEV6PNHQu41yN7dgnrxn7OausyeVGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxot4/LRIKBehOwiBEltAtnX62YRPJW8L/IWVvXXi2Cl9ZG0aj8
	h4+VZ1XFJKydRDwUyU0OeAOjToGZoGF4eUONowcZiSugbPyzmFjkmgh+ZDF+MoPuzw==
X-Gm-Gg: ATEYQzyrSpdUqwcRBThUVc5VnSTaWEIMirte7NLGfA2gKLaXLoJGfDS563nT2PL6LM9
	NZ0bUJdbbVW0uHBvbBoHuz20TMo5d20Bn1bLoI6OVXCSw7qbo89I/OdYl+10w1ZQPHKIeNlJq/u
	F+pHZ8EGV0ZsyGAHxcxutV1MH3GYt50wQg8e1aCQ8OcbkLfvCEETZPJCLDTUP55wFpFsGI5gP6u
	4MNlK9ZFkBbSBjHmLc88Oqd3kBBkfAr9zcfcEp8uV2XdPaqP5XPp68eLLLVWSrobRMgTADURA+g
	OqU8Xjjp+IsYRWKY1+8xnJTbqXh1eoSm3IWjzDX0gX5PF8+UkhMffA1BK1IJPVPaGUTKi4EIWG0
	2HDEcnXvjcpnf46NN5WDXz3WAnzCL24v9hIfrboHROac2GPGrrqVX3MD61pV0DDlItzIPVeQLFh
	UY8zt0wck+eWnyxAQAJxBEGq3lKYGXDzYRvk8ZI4rT/LWR6zywMYxiPB1laUKG
X-Received: by 2002:a17:902:d592:b0:2a7:6c4e:5924 with SMTP id d9443c01a7336-2adca6e950fmr1322615ad.12.1772006162194;
        Tue, 24 Feb 2026 23:56:02 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm124024035ad.52.2026.02.24.23.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:56:01 -0800 (PST)
Date: Wed, 25 Feb 2026 07:55:51 +0000
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
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <aZ6rB-zmpaR3RLB_@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-8-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-8-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:
> Notify the PCI subsystem about devices vfio-pci is preserving across
> Live Update by registering the vfio-pci liveupdate file handler with the
> PCI subsystem's FLB handler.
> 
> Notably this will ensure that devices preserved through vfio-pci will
> have their PCI bus numbers preserved across Live Update, allowing VFIO
> to use BDF as a key to identify the device across the Live Update and
> (in the future) allow the device to continue DMA operations across
> the Live Update.
> 
> This also enables VFIO to detect that a device was preserved before
> userspace first retrieves the file from it, which will be used in
> subsequent commits.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index 7f4117181fd0..ad915352303f 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -53,6 +53,8 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	if (IS_ERR(ser))
>  		return PTR_ERR(ser);
>  
> +	pci_liveupdate_outgoing_preserve(pdev);
> +
>  	ser->bdf = pci_dev_id(pdev);
>  	ser->domain = pci_domain_nr(pdev->bus);
>  
> @@ -62,6 +64,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  
>  static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>  {
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +
> +	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
>  	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>  }
>  
> @@ -171,6 +176,9 @@ static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
>  
>  static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
>  {
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +
> +	pci_liveupdate_incoming_finish(to_pci_dev(device->dev));
>  	kho_restore_free(phys_to_virt(args->serialized_data));
>  }
>  
> @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
>  
>  int __init vfio_pci_liveupdate_init(void)
>  {
> +	int ret;
> +
>  	if (!liveupdate_enabled())
>  		return 0;
> 
> -	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		return ret;

Nit: We might need to handle the retval here if we remove the
liveupdate_enabled() check above (as discussed in patch 2).

> +
> +	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> +	return ret;
>  }
>  
>  void vfio_pci_liveupdate_cleanup(void)
> @@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
>  	if (!liveupdate_enabled())
>  		return;
>  
> +	WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh));

same here.

>  	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
>  }

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Thanks,
Praan
