Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6F2EB862
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057190; cv=none; b=f7DfwQg7M9i365gZLrELFDfj7m4/zpzek2VgCJZvcuYgR81hYf2GR+mA3Q3Vg0CETIXxOhAUCkd98v2oAyCyzhr7l9BDEhrWkHPtK21J6xg+p2MtNPloruqIL+dSGiDfJmUuiY1nsGaORo/UYWt5/M1yHMVuuxt2+Jppnqwfd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057190; c=relaxed/simple;
	bh=LJWtxfMSbjaR7UL7hdep9H/YDcNXa8SN1R3pQvw0+Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tikt0EtG4jYQDmzQM26cZvt5hGssAUGg3WoL0Yd+8EkAdVeXAxTtik4hq6l6IvIK/fiTZEn0dZXDcrikYKn+B99TkE4T9P+1hFbPqVSo52ozghaby67xfIrC8wRrRuOAQvyDoJB/CNV0gDgph6pik7qT0nBDnghY/yYhWCEA0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tA+Pbm0Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tA+Pbm0Y"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ada9e4ea32so11295ad.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 14:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772057189; x=1772661989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKxFO5jbcj0n3yx3uCDHTRhkwPsNZ/ADjqKpvoexazc=;
        b=tA+Pbm0YWZZbEJBWS4Tr4W7PpkLvYJdLDNIcSF8/87i9oDVFj+Oz+s3bBv0r6W7PlG
         NEcFRl6QB/YdLaxiel9L3DCwLztCmQrSXxaUxtdkefuFoWFIHG3VgRMJv0nj0eSkW2AI
         /G3DvLZmmXsW7d1ZDWanlu+GBMsmI3FhtUrnRlW9tgPwglg1jugdpYuUjdwZbuj7aHK1
         CbBmH2tQ70fyIVwV+ZJtG1FEJ/z3vmGea+A/4TMAJ3ZHCx6TrHQtCxC+YVbWui3pWRu0
         jHvSqojoeLrA7wPutUbnsggmp2BfW13G/svB/7nm7sLAoLTHZsCb+8kGv34V2nIapyAp
         eF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772057189; x=1772661989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKxFO5jbcj0n3yx3uCDHTRhkwPsNZ/ADjqKpvoexazc=;
        b=vT5oriRs7+HXHKkzclqsivwn6FhNzHwsgwuVDSGSBUQkCJkS+of2Ek9fb9G0WrO6pm
         wOJuD3QeaBkdRV/WD8uuwCz55iNHwbEiKXIhSa4d9lvy1Qn+FPhjisaf3McF+pKGmzch
         VhZZ+Rp17Z360hUKA1zxP2+O3ZX3wERoetIvslgufdoaAJ5gcPcROshj8KymPgRDZ6ra
         mRuJzx5qENhhXX3HvGDi8v2/z1zUgwagwQhQtFVaQVqsyRXMWWTeLIVmH5Q2o/jihHJI
         yG/ZDVCmyDVY2GjO2SyvO42JQA3OzyUQ3/KJqDav2cCWt1PbewxUO7JiASxj5msMXhrs
         HFHA==
X-Forwarded-Encrypted: i=1; AJvYcCUm6c/SBgYaOX659SBGzndY2QLe63IiyDABDNMoauYuLn+xCzcthfR/UB6JK8xXmhbJ/XaqcJEUF4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkDwnDqWyrOxnW/12pr8ai/HWPWI4MKzXlLNoI6WnV/PgR9/f
	07KpT26mCNUuaCg57SrLtmvwkJN0k6+9XRqm0+dOFK+THXdOaqHZlbcT3AE96CqA2g==
X-Gm-Gg: ATEYQzyq03mVulUFbpc6PnzM99QxPGyeo9bfe300LHOF/mgz/z73s4dPv6OFOa+QJE/
	UX7QUQhbQmFQ/pVN0P84dvWeu3V6zf7Wy3aif8SJzFefHYof3cAMZYxLx9AaAPqqXFwfF2wQ4pB
	qL5GrxbUyAXMvS6bHrwjFRzmDVN8xUL4QD9nAY/anX532y1rnFrYAY+UnZCfoyXeMilmZzQEloi
	/6dcZAuAHiGTkNnxwiDHQVX2FrrdDL2MlCK0VvvrBUqJwZLaMqTPIkDlR91nUGv+3DlxQzx36we
	6rsHnfCSaAhsKVosjtQNTNzJ0Wct4+HURFpDus1NLu5cOK0pMK3FsGWqdukZxgCjW6v2cZLl3hw
	ZQVJUsCy3kRzad8ZKeZIysAXP9QYd3AVVr7o33USL3jy1NPiZUz8h44NPG+eSY23HoNY0zWfBlg
	T4CXaSUsdZL6tJpr6H/Ygwe1nP7WtCReVIWqnd4FYMVlAQgZncro38Dl6+uRd4RcsHWVy6bxc=
X-Received: by 2002:a17:903:2a86:b0:29e:27f4:bac0 with SMTP id d9443c01a7336-2adf77c692amr672495ad.16.1772057188344;
        Wed, 25 Feb 2026 14:06:28 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a05e831sm236247b3a.58.2026.02.25.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:06:27 -0800 (PST)
Date: Wed, 25 Feb 2026 22:06:18 +0000
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
Message-ID: <aZ9yWlcqs2b6FLxy@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225143328.35be89f6@shazbot.org>

On Wed, Feb 25, 2026 at 02:33:28PM -0700, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:51 +0000
> David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 0c771064c0b8..19e88322af2c 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -258,6 +258,10 @@ static int __init vfio_pci_init(void)
> >  	int ret;
> >  	bool is_disable_vga = true;
> >  
> > +	ret = vfio_pci_liveupdate_init();
> > +	if (ret)
> > +		return ret;
> > +
> >  #ifdef CONFIG_VFIO_PCI_VGA
> >  	is_disable_vga = disable_vga;
> >  #endif
> > @@ -266,8 +270,10 @@ static int __init vfio_pci_init(void)
> >  
> >  	/* Register and scan for devices */
> >  	ret = pci_register_driver(&vfio_pci_driver);
> > -	if (ret)
> > +	if (ret) {
> > +		vfio_pci_liveupdate_cleanup();
> >  		return ret;
> > +	}
> >  
> >  	vfio_pci_fill_ids();
> >  
> > @@ -281,6 +287,7 @@ module_init(vfio_pci_init);
> >  static void __exit vfio_pci_cleanup(void)
> >  {
> >  	pci_unregister_driver(&vfio_pci_driver);
> > +	vfio_pci_liveupdate_cleanup();
> >  }
> >  module_exit(vfio_pci_cleanup);
> >  
> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > new file mode 100644
> > index 000000000000..b84e63c0357b
> > --- /dev/null
> > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > @@ -0,0 +1,69 @@
> ...
> > +static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> > +	.can_preserve = vfio_pci_liveupdate_can_preserve,
> > +	.preserve = vfio_pci_liveupdate_preserve,
> > +	.unpreserve = vfio_pci_liveupdate_unpreserve,
> > +	.retrieve = vfio_pci_liveupdate_retrieve,
> > +	.finish = vfio_pci_liveupdate_finish,
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
> > +	.ops = &vfio_pci_liveupdate_file_ops,
> > +	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
> > +};
> > +
> > +int __init vfio_pci_liveupdate_init(void)
> > +{
> > +	if (!liveupdate_enabled())
> > +		return 0;
> > +
> > +	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +}
> 
> liveupdate_register_file_handler() "pins" vfio-pci with a
> try_module_get().  Since this is done in our module_init function and
> unregister occurs in our module_exit function, rather than relative
> to any actual device binding or usage, this means vfio-pci CANNOT be
> unloaded.  That seems bad.  Thanks,

Hmm... IIUC the concern here is about liveupdate policy if the user 
wants to unload a module which was previously marked for preservation?

AFAICT, In such a case, the user is expected to close the LUO session FD,
which "unpreserves" the FD. Finally, when rmmod is executed, the __exit 
(vfio_pci_cleanup) calls vfio_pci_liveupdate_cleanup() which ends up 
calling liveupdate_unregister_file_handler(), thereby dropping the ref
held by the liveupdate orchestrator which allows the module to be
unloaded.

I think we should document this policy somewhere or have a dev_warn to
scream at the users when they try unloading the module without closing
the session FD.

Thanks,
Praan

> 
> Alex
> 
> > +
> > +void vfio_pci_liveupdate_cleanup(void)
> > +{
> > +	if (!liveupdate_enabled())
> > +		return;
> > +
> > +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> > +}
