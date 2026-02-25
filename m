Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C0330D23
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058594; cv=none; b=ZKu+sqvuMatRXFfBatENqmi1BqwplWVGvf+KYe6pfIHI9LDBYBMLAj69GOJ1kG6eUTxK+i55KJXmt0dDPcHmh0z3iFuALHchGOlaGwZWt4y+e75H19vMBQRLu2Y7+qwyoFkug1DHLmfG0D2/BH0STgzTYwCSVNVyV6LvJlZ2y1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058594; c=relaxed/simple;
	bh=GQ5r1G3VoaIJD/4mlI2bH7JYCa7TXODdwhiG6pJZSvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di3mxfcNekXQF46gi4e18E8D+KZN7ufKk6aOakTJq5fNcYGtdJzUTSjk76SJGjZUPVjtPBdbBALdt0yi+xoNv0j/abcjuEjv0BDzBNKOnNY2oS0dKtor4Dk5Jiz9LXzXKst9lea5V7oK2U2NLYXvS7yIiQQG8KHOhfU/Dx2Flog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPHKs0df; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPHKs0df"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aad8123335so14835ad.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772058591; x=1772663391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvlpF/Rbdy5yVGOyUM/AWdTkLEwWYWZDygf5cNk3LN8=;
        b=cPHKs0dfuLBGgP9RWwQzmk7U66+8Eq/gOPwRH/k1Xb0Y4nkwfPCZ24XFofGoEDIBqs
         Q0G7eW5zOXDzRBm4wn7YSnutAdpv53y6VrRE2RDcQTJT8FtApKQEN20OZ6nRtFAP8jWX
         RfysxOfv8MuykU81yo1oEOUIy6paNULcscWeYr9zvdjR8S9dBEiTWZrx8PVHJ/YT6DPD
         DoaY9s4zuj0QNt2tsnLipkHAQCcDJBhnW6uTt17O2AkaR+v5LiUgK5dV984uZOPeLW6i
         giWsPH1lm9RSap7rmBg/41ix4hX3tvohbZXhlcElEfSSNnOfSaz+oBqznDl7za2o/FD2
         Ag9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058591; x=1772663391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvlpF/Rbdy5yVGOyUM/AWdTkLEwWYWZDygf5cNk3LN8=;
        b=qFjbSxl+Q8Ha07aXiy0phHcGmWSkYO4FAHoEJpWg5ReMegSITV3QQI0b4QzniSdrhW
         ILhsHh5PBwmuktTE3DxKYEEFv2Zzdr5R2VuqupSdMeBHZMG/9pfSPkSmJQpVBlaHGQS5
         vzLfmzl9ZD4DQ/bMbg+rxQBKwlV6PDrDOYcX+SniJQvggwoeojyXPsf/Sid5wjkqgdV6
         IIKuRHKBMFxu63YSwIm0c+8jai0lUx8XjEBJH2ZQoJXUcfxRA0RMqJ9BLFwowe8mEKZ9
         fFBbn2Ehvd9VGKokkfhWKKrCl6rqLWHGB8svWa2BebADJPuB6N7/QdhdDR5ldF32+A5n
         WZvw==
X-Forwarded-Encrypted: i=1; AJvYcCXcV3+sh4NK5jUOabQ/ShORM9bpfhfvRGQK91QqpSEtmzUftD1qBCT4uh5q1ISvwdAGEMgivJ0wkl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7RGcDIN9kK17QASkrY46/4BExARKcDivYiMLYkf6Lssu1DXi
	2wbpRzBeQT8yBzt/46TsFXvuRX1iEAJMWIIorpokBNXdyz+iRIT6d6aOtVOYJQts4g==
X-Gm-Gg: ATEYQzweE2y2ICSz0EnWADhi8W3gcK2B1IJwPZauH2JOdMKR4k5W3I7aBBfFufvwVKV
	3mPQ8Sl/b2LLXT5Q+INUchWcu+btbqXWdVbkpLrMMQV1a4JpbAOqYxxlasTy6G7C+SRbeOWsOu3
	DTwp6NnRl5AfUI2chReNJm7k+lj+QVu4e/Gr6GUFz9s0KLSNvNG6+0M6wU83cA5Zo6EMGSBNIzc
	dsWLzOyjLkp604bd4pKhWZ1KJYktSO7KBqVMobahAcUytvKIOAJQJ3o32OIe83ysDWU+Mw9flVj
	NWHiuTSPw12swCwc/k12BEwbOp2lLixE7qKID4qeQuBW/xT2mjrhHPpzcdAUYmoIA7JCkxSstWW
	WprhRcMdheL6w9o2BPstoEHTt7ofa7p4cKS3yXK4ttBOEoYfslREjshgd/Xd6SLm8gNkmukRGD3
	+pfqlcRvA0hewWi1cLcHx7HBbYnKMTBwUPO7G1QyTLX2e/9aw1CFM/mSZobjc3CUwyHKwzRqk=
X-Received: by 2002:a17:903:15ce:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2adfefd95b6mr300155ad.3.1772058591084;
        Wed, 25 Feb 2026 14:29:51 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b2309sm2774685ad.19.2026.02.25.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:29:50 -0800 (PST)
Date: Wed, 25 Feb 2026 22:29:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>,
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
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <aZ931bYILhhkhW-Y@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org>
 <aZ9yWlcqs2b6FLxy@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9yWlcqs2b6FLxy@google.com>

On Wed, Feb 25, 2026 at 10:06:18PM +0000, Pranjal Shrivastava wrote:
> On Wed, Feb 25, 2026 at 02:33:28PM -0700, Alex Williamson wrote:
> > On Thu, 29 Jan 2026 21:24:51 +0000
> > David Matlack <dmatlack@google.com> wrote:
> > > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > > index 0c771064c0b8..19e88322af2c 100644
> > > --- a/drivers/vfio/pci/vfio_pci.c
> > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > @@ -258,6 +258,10 @@ static int __init vfio_pci_init(void)
> > >  	int ret;
> > >  	bool is_disable_vga = true;
> > >  
> > > +	ret = vfio_pci_liveupdate_init();
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  #ifdef CONFIG_VFIO_PCI_VGA
> > >  	is_disable_vga = disable_vga;
> > >  #endif
> > > @@ -266,8 +270,10 @@ static int __init vfio_pci_init(void)
> > >  
> > >  	/* Register and scan for devices */
> > >  	ret = pci_register_driver(&vfio_pci_driver);
> > > -	if (ret)
> > > +	if (ret) {
> > > +		vfio_pci_liveupdate_cleanup();
> > >  		return ret;
> > > +	}
> > >  
> > >  	vfio_pci_fill_ids();
> > >  
> > > @@ -281,6 +287,7 @@ module_init(vfio_pci_init);
> > >  static void __exit vfio_pci_cleanup(void)
> > >  {
> > >  	pci_unregister_driver(&vfio_pci_driver);
> > > +	vfio_pci_liveupdate_cleanup();
> > >  }
> > >  module_exit(vfio_pci_cleanup);
> > >  
> > > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > > new file mode 100644
> > > index 000000000000..b84e63c0357b
> > > --- /dev/null
> > > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > > @@ -0,0 +1,69 @@
> > ...
> > > +static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> > > +	.can_preserve = vfio_pci_liveupdate_can_preserve,
> > > +	.preserve = vfio_pci_liveupdate_preserve,
> > > +	.unpreserve = vfio_pci_liveupdate_unpreserve,
> > > +	.retrieve = vfio_pci_liveupdate_retrieve,
> > > +	.finish = vfio_pci_liveupdate_finish,
> > > +	.owner = THIS_MODULE,
> > > +};
> > > +
> > > +static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
> > > +	.ops = &vfio_pci_liveupdate_file_ops,
> > > +	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
> > > +};
> > > +
> > > +int __init vfio_pci_liveupdate_init(void)
> > > +{
> > > +	if (!liveupdate_enabled())
> > > +		return 0;
> > > +
> > > +	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > > +}
> > 
> > liveupdate_register_file_handler() "pins" vfio-pci with a
> > try_module_get().  Since this is done in our module_init function and
> > unregister occurs in our module_exit function, rather than relative
> > to any actual device binding or usage, this means vfio-pci CANNOT be
> > unloaded.  That seems bad.  Thanks,
> 
> Hmm... IIUC the concern here is about liveupdate policy if the user 
> wants to unload a module which was previously marked for preservation?
> 
> AFAICT, In such a case, the user is expected to close the LUO session FD,
> which "unpreserves" the FD. Finally, when rmmod is executed, the __exit 
> (vfio_pci_cleanup) calls vfio_pci_liveupdate_cleanup() which ends up 
> calling liveupdate_unregister_file_handler(), thereby dropping the ref
> held by the liveupdate orchestrator which allows the module to be
> unloaded.
> 

Ohh wait, You're right, Alex. I just realized the __exit won't even be 
reached because of the internal pin. The current implementation creates
a catch-22 where the module pins itself during init and can't reach the
unregister call in exit. I believe we should drop the ref when the user
closes the session FD? Additionally, should we move try_module_get out of
the global liveupdate_register_file_handler() and instead take the ref
only when a file is actually marked for preservation?

Thanks,
Praan

> I think we should document this policy somewhere or have a dev_warn to
> scream at the users when they try unloading the module without closing
> the session FD.
> 
> Thanks,
> Praan
> 
> > 
> > Alex
> > 
> > > +
> > > +void vfio_pci_liveupdate_cleanup(void)
> > > +{
> > > +	if (!liveupdate_enabled())
> > > +		return;
> > > +
> > > +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> > > +}
