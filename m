Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5C3546CB
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218131; cv=none; b=BEK2eAFFDFPFvbV9ZeAlRF7Z7fnR08MJNjCqFOvLwE7/JTccHrnNlIDZAeXqW0m3d8KRDPst5uOy8M0aealKNDgLX3+LHtOI5j1u7HnRa3W4RMGeny13lGLcYftN00QqM4DBq6Eh62WAUcgA4c18DeovC4km4+1QWIChi3Z75nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218131; c=relaxed/simple;
	bh=95h8LSQop+NXtAUTCY4WUxyMxHyiOTBXq32dcommAVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJMEWtUvD/DDJcMMQQugUNKmQJSGnC1e9K6J7i9/ZfBIrnT4o3RWxCAZV+kSaZMLSu17fA+miLMdsgxazzw+i4phU8k4i/I7+H9/p3RqtST62fdOJVeiKjMsAux2DFnEJwHvNiixysTOhR9CjHyXXaDRiiReJZFvim6rGWKu8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XI3OzYRP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XI3OzYRP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso45765ad.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782218129; x=1782822929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zrUGuQC1RmyduYSJ3/JT9tG3Cdq2ls0SnT0GavGxSKw=;
        b=XI3OzYRPuh+VGu5iy43ta0hsdp8r6UYasd9B0XvVRNtCos2aDIBFVhop2BvMoC4Ujt
         egW8tR1BgHtBiMdghes+V23GHd3oyy0QYNs6IUlx4Z5zvfq66y9BtoUX1eimw6k1i2oY
         Q10mPK0HZxz/mFGghr85woGDuOJGrdXVL0IjaO+12/2I64V5qwkHSzzqebCC36NKt5GO
         GLRxIucveAWo0HPDEhRcipefEyCb/jjzlodcrzAZpDlYfCizh5LT14C0KwFpTPuMvwOw
         Si/9mB2Prjft7StL9yU7ljsraDKWM7Rku88sjz/Sdb0EHEKqRiEXdQ6DTQ5OOsaJQwDJ
         Gtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782218129; x=1782822929;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrUGuQC1RmyduYSJ3/JT9tG3Cdq2ls0SnT0GavGxSKw=;
        b=aL7xfzl8PD+C6eiP2XR/BHYn1i1Va0y74mgD28bS8lSSp5mK/zUuHHzKno1IKPwM1y
         TRnv+JtgK4jlQ2gRc38gYyqASop3/DDbvlx14yRwvmJ34HOCy6cI4rfY/eNbHZFJ+8K7
         6tiJuTL35dtS4sJ/iVUDdwzg8YO5rAdGl5PiO++pfrafWssMMvkvQMSEheEy63+dvwDq
         32TbCGbj6aKvZGoCzUKWmuDaL0QDBGsUAeYt4q21GQUt8cJcQ2wQrSj98J0dOkoVKTIa
         HvrGk+fZqEwP2LUhrtkldm9x2ZR8JRDtIGRf1wm3hypb0tHIj2vlMJf1U+DEvE09+V3l
         vf4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq9f0psHQkDynpDGVJkStCKjvOF+LoWsuQ6Wj/7h4JRJDxAPYPWEykesDsEb+RVbh1Wvkk4AOVTMLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+CHWb7oebaQfCjY4OASFE4+w9E5uH6gJ3r77k8WlT+wgNWlVo
	7pkINsjayn8giC21vEkAojR8ZD+oEi7OikHzF5TXZMPp/OF6kzP8iVlF3w2zPL8ZEw==
X-Gm-Gg: AfdE7cmN3ar6DV8cGL3Jq+Th4aCBjcsWmUZQzcmQegOgxjrHG/mORxb+egqGprR0kZQ
	SkkKL3bA4J+0AH9xT6MxLdmQS+Cmi2ITOF0ODeRkqm6+GEtlDsn++hhJJPZ2yg2i28P1aWtZDuY
	XY2cPGegJIcldORruuAH7vFsIRiVLPHessHpTFU43apjyr/qkrNHEqodtbvXASqM3/Yhi9UeKaI
	ovsIV/XRkSvgHoeN2TJVMn1wc5Es+1vH3DQt9LPiu0Vio4DRQv1Xksw+sohX0iKZP0Yt5TH3X2K
	PGTk3+T3NG6lq/gDCuSFUGRMKvyARK5BcsPzcXdK0Q6wtIttrbdGDggyzZDiGipZfVSjeavhnfH
	PpE4Rr7GgD3Hrx6CNo1Kjw6lzWkUYUSSsbK630RsuQVWNtU4SMO5xY5xylhzAtvGu8vm/S+uFig
	UqIagbiRV8x2mi0yB3mv7+ImDb41+W1hAjPJyOfyn4ahIQ4GyRFA==
X-Received: by 2002:a17:903:2c06:b0:2b2:70ba:305c with SMTP id d9443c01a7336-2c7c5030b6emr2113265ad.8.1782218128496;
        Tue, 23 Jun 2026 05:35:28 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad83sm105841775ad.79.2026.06.23.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:35:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:35:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Leon Romanovsky <leon@kernel.org>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <ajp9hwIw657qxji5@google.com>
References: <20260610154327.37758-7-matt@ozlabs.org>
 <aixgZQiBQKgS7yIM@google.com>
 <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
 <ajGbRE3WWJxNxcrg@google.com>
 <BYAPR11MB3687AE280241C9E00B46FCF98CE42@BYAPR11MB3687.namprd11.prod.outlook.com>
 <24f34e59-7c3b-4b56-83bf-cb07e3f369a6@ozlabs.org>
 <20260619133116.GB278945@nvidia.com>
 <55ea7422-08d8-4c92-aa59-8ff6f9e9d781@ozlabs.org>
 <20260622171336.7d13f548@shazbot.org>
 <fbb2b1a6-594f-48eb-887f-7cf0cdd4c336@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb2b1a6-594f-48eb-887f-7cf0cdd4c336@ozlabs.org>

On Tue, Jun 23, 2026 at 12:08:30PM +0100, Matt Evans wrote:
> Hi Alex,
> 
> On 23/06/2026 00:13, Alex Williamson wrote:
> > On Fri, 19 Jun 2026 16:13:17 +0100
> > Matt Evans <matt@ozlabs.org> wrote:
> > 
> >> Hi Jason,
> >>
> >> On 19/06/2026 14:31, Jason Gunthorpe wrote:
> >>> On Thu, Jun 18, 2026 at 05:02:58PM +0100, Matt Evans wrote:
> >>>   
> >>>> My understanding is that the sequences above wake a device that happens
> >>>> to have previously been put into D3, and AFAICT it could only have got
> >>>> there because of a previous vfio_pci_set_power_state().  Seems its only
> >>>> caller is from the emulation of PCI_PM_CTRL using
> >>>> vfio_lock_and_set_power_state(), and this zaps/revokes BAR access before
> >>>> a transition to D3.  Similarly, an attempt to access a BAR via an
> >>>> ioctl/through vfio_pci_core_do_io_rw() fails the D3 check in
> >>>> __vfio_pci_memory_enabled(), and besides will try to take the memory_lock.  
> >>>
> >>> I thought the general design was the bars were made inaccessible
> >>> before going to a low power state, and remain inaccessible while it is
> >>> in low power?
> >>>
> >>> So the order of D0 doesn't matter. If it is not in D0 then there is no
> >>> mappings and zap/revoke is a NOP.
> >>>
> >>> If is it in D0 then it doesn't matter because D0 is a nop.  
> >> Yes, that's what I'm getting at. :)  If it's in D3 then BARs are
> >> inaccessible, so as long as we go into D0 before the DMABUF move, the
> >> order of the zap relative to the "go to D0" doesn't matter.
> > 
> > I believe this is correct as well, but importantly we cannot assume
> > that a stray read or write just returns -1 or gets dropped.  This is
> > exactly why we have such hard protections against the user accessing
> > the device while it's disabled.  Not all platforms, even within
> > architectures that might otherwise be considered lenient of such
> > accesses, consider this benign and might escalate to system level
> > faults.
> 
> We are in enthusiastic agreement here.
> 
> > Let's be careful not to frame this as "the access doesn't matter
> > anyway", the answer is instead that non-D0 devices already lack any
> > mappings to access the device.  Thanks,
> 
> I agree that is not the right thing to say, for exactly that reason.
> (For avoidance of any doubt, I didn't say that :) )
> 
> Thanks for confirming the behaviour.  I hope Praan and Kevin are
> satisfied that this patch doesn't cause the issues they first worried
> about (the changed order of the zap relative to the D0 transition
> doesn't have a detrimental effect because of the existing inaccessibility).
> 
> Alex, I'll post v4 soon, but if you have any comments in the pipeline
> please shout and I'll hold off awhile.

I think the discussion addresses my concerns. I'm in agreement as well.

Thanks,
Praan
