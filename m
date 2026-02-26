Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312633123B
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149250; cv=none; b=sKYtP+oDAIARzb8Q29HpxbCbneYv/7vhUwpIG4+qt+ZnghEZYUKbwHYalPD+R9q0zgi/l9NlA+Xi6z0rioI4/nzY7y/IIXKyetzM46o3hdrSMo9ETv0u5HUJQcdyXtJfcwy58B27UsPa7/7U+j2aJ+S3xmqW3VIdXOJMpn3KTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149250; c=relaxed/simple;
	bh=773E1Qu3WZaNjUpNYslYsC6fIc6QMX05+z2A/JT5Lmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss40Qhcb0JyAon2v0hJ2LPWfLSTQy2RHzsp8P6TozkWo21c0qW/lGbV1Wsu00zw0Py6NsXZvFYenfI1PSWeyrfWuf5D0cLU3jSLviImonJJ1ab9AxqAPoDUbLw0nWiuTpULUPtq97Q6ITDWx6dLlQ4KmNKZrZHhmBNEIgk+hB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzfEJy+/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzfEJy+/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aadc18f230so9323495ad.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 15:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772149247; x=1772754047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dweZEP9P9syIIaIBNbJewu0YbCAV1KvejPrlkY4pDLk=;
        b=hzfEJy+/xVgMtXdTO18W8dd4TxjvUCU3ZO16mrYqOOWsNM3Cfj7xMKd7kOOeIqtHyO
         Bo7rfUDvMguucNMGYkRu0SYWYxm+MXGm5jdnkFayBykV3x/0dvRIMYw8eWrh/6ym+JQU
         rEZGESpNfJQUH/FKbTsOeOmFQ/XEsY4woCWZiBO5FSetVDJSUEZSkkvqG3JVZn8sWorh
         sNEumiWGre3q7OVZGoTe1clgaEMhB8jOemrj69eWBC//eGPOtk//SWjUpJVRBrcjheGj
         j6JSOvbi0iTH/nHPYjXvCtefKb9o7tw/8VOHqXWiZfdHoM0iS7dOZZI/UXh9pXMWiSN1
         iZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149247; x=1772754047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dweZEP9P9syIIaIBNbJewu0YbCAV1KvejPrlkY4pDLk=;
        b=S+oJavsJFGDhUFanJTQdxikDtKoba99UeecfroeseDRnMhWooRYseB9dXnLVRJUnMF
         gRdWV8LXA8hwxb1PE+EKyKlzbt068RssMg/skqxJvbEd2LPvWWD3YhNXU8JxzB1GYLNr
         ubyoEhzKgad+inhd66JPxSMxeGlWvjyprNGZtkooZqq0j27w4rcinjt8O1w8PppwGLy0
         48qMsna/Zdif1yLcKPR1Vm1kNzdNnY8VwnRCZSg7ZUwbeU3ghMlOX6qB61N3iyb9ceK8
         7xnrIUAiMaxGa3x0wLwArg4QhAGom72L+PlAoJQm9w1N5XpK8XrryVBPKooMW3C9Z4dh
         ntUw==
X-Forwarded-Encrypted: i=1; AJvYcCVo/G+XvnaJFYcCCBytWtuzI/Q6QWXM//WLI4GyYmZseugDlyrRKDKE/AXVOvP9D5Rc15BKIfIOfsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+2Po/ebhuhDg52wGn/e/iZIOrfFQwhQ0KSqCzK7Z5pm9tVcg
	Xs5WDZil/U4+PIGc2SmtLjfGB8F0rkpPpPh9C1aczdClw4NDhPRAKsexF59Gbq41Lw==
X-Gm-Gg: ATEYQzxZ41NcoHU8fZknMb9EhtF5QDGYgqfDLr7Am7Rbi1lg6/iHCiBHuKJbdGlkgWR
	cdLiiHqFjMElhriMvzGyTStXRD1seeNMC+1Y7U2JfcERejHWx6HU8yjns1AtVOosk0g0FNagBBo
	kzS6fjDtgfITtQWvVOE61/xsn7cDfoSuWBzsCxS8IWmdYB26FBV5hqCXFQH6ByQDy2qK60wq0pK
	WOZ64WQ5AZqdPp/8y2TW/OqIBB+RwfOonNW268wVYGR6Ev7BbWIBUuQp3tI+3nBM1/7mpcEnWhq
	TrKsrMO50mG6RRgJBa91WHnfOK9ZAy7klmYqZjDWZ+WFnZi6kNVfGmDjSAH+sDWKuaOIKEyE+mi
	3aG1O1JiiVe7x7fSyQH6NhLu66fblwj0kg/JKsbtYwfPFNutEAj9Fv1Tn5IQ0w8afXOg44klf9W
	3pvEpEK39lSyesu3gBdWlLj2OYRntZc8kw5Xil79ZpPki0oYpmw6uqeyRRGtdXyw==
X-Received: by 2002:a17:903:22c9:b0:2ad:cede:3a18 with SMTP id d9443c01a7336-2ae2e46bd8emr6748745ad.33.1772149246778;
        Thu, 26 Feb 2026 15:40:46 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b257esm36167495ad.4.2026.02.26.15.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:40:45 -0800 (PST)
Date: Thu, 26 Feb 2026 23:40:41 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
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
	Pranjal Shrivastava <praan@google.com>,
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
Message-ID: <aaDZ-ffs4kiUo3GY@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-7-dmatlack@google.com>
 <20260226155222.5452a741@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226155222.5452a741@shazbot.org>

On 2026-02-26 03:52 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:53 +0000 David Matlack <dmatlack@google.com> wrote:

> > diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> > index 8ceca24ac136..935f84a35875 100644
> > --- a/drivers/vfio/device_cdev.c
> > +++ b/drivers/vfio/device_cdev.c
> > @@ -52,6 +46,19 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
> >  	vfio_device_put_registration(device);
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(__vfio_device_fops_cdev_open);
> 
> I really dislike that we're exporting the underscore variant, which
> implies it's an internal function that the caller should understand the
> constraints, without outlining any constraints.
> 
> I'm not sure what a good alternative is.  We can drop fops since this
> isn't called from file_operations.  Maybe vfio_device_cdev_open_file().

Ack. Due to the bug you pointed out below, I think the changes in this
file will look fairly different in the next version. But no matter what
I'll avoid exporting a underscore variant without outlining the
constraints.

> > +	/*
> > +	 * Simulate opening the character device using an anonymous inode. The
> > +	 * returned file has the same properties as a cdev file (e.g. operations
> > +	 * are blocked until BIND_IOMMUFD is called).
> > +	 */
> > +	file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
> > +					&vfio_device_fops, NULL,
> > +					O_RDWR, FMODE_PREAD | FMODE_PWRITE);
> > +	if (IS_ERR(file)) {
> > +		ret = PTR_ERR(file);
> > +		goto out;
> > +	}
> > +
> > +	ret = __vfio_device_fops_cdev_open(device, file);
> > +	if (ret) {
> > +		fput(file);
> 
> Don't we end up calling vfio_device_fops.release with NULL
> file->private_data here with inevitable segfaults?  Thanks,

Yes indeed. In that case I think we need to call
vfio_device_try_get_registration() and vfio_allocate_device_file()
before anon_inode_getfile_fmode(). We could play games with file->fops
to avoid it calling vfio_device_fops.release here instead, but that
feels hacky.
