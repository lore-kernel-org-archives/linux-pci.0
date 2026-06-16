Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6747A0B2
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635919; cv=none; b=SCenh9XpQ02tzoS6qGibnPXSYTJvY/5gdNkSl934SoUoBJfQLPsBRYTUSPzozWSec/SbL87fvh0lfoWdawVUWq24Nushp9x0Mi9CrRmxOph+gx1UuJlfYg7g93FK4ZQqtQMI2udrdbcxaFP38ZF8PzNgJu8ZM/zLQcBfWxmD4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635919; c=relaxed/simple;
	bh=sZ7UNLwehwopPc6t3eGTeaf90dQl3G+H2ei/ClIX/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opbcU+88tySAIHpLBbHW6iNXCKoVpJvvevSSYCAsYypORNrmJJvqmnGKDGZUx+wbyOHziXC7VKm7VarDx2Q/GzU0Cm+NQ23A9TIzs5HGklcotl1LmN3K14PSXubWp9h51fUQbzgzCLZoDy/2Ku+KX0pVET5MdQ6ds7cEc4v7Ejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boKy3whj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boKy3whj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6a4eccab1so8715ad.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781635918; x=1782240718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvE0aCg+gv1l26GtSCjQQyNi/5Rf7OW5qgPEji4d+Bg=;
        b=boKy3whjYEJJm0rGPxoZsPFUXrYLfkE0KmCJKkJGtvZJWHAYiy9k3W7FxK9E35C+vv
         hnHOopHaPVWpMvT3JvtiIAaz97js7EBwzLbLdZJnxdhhTDubshQ/A0yd28nc7FViBqno
         W4ARWojYwqvib6My3+4Qon6aiOLWJd1HvcT87W6wgDn2An5yPZLt/7v10PAvQda79Fpc
         ySQy9XhVcZ+4HLhF2pka7k834a2GQUTRVpW7DiGQx2dUFNzVBtIOcFFua96S3nh0V+BJ
         +Ec/Zzgk1Gjm2C8VE+Ftn6lircTYtMvlkxqHzH1NHIHLI/kzqmWGJMNw9k9ZZu3OHU+Y
         5/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635918; x=1782240718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvE0aCg+gv1l26GtSCjQQyNi/5Rf7OW5qgPEji4d+Bg=;
        b=NlxG/sIgPXnJ94EtbINOKjSXgkns6BzCCGZFgTjI7DMjDipybqwoYWHHVcHCUhCUQg
         ZGGSqJtPED8D/gm5BsOM+Rm6zkfMtu0w+spsPksUbbvg/gioVbRnGLAfToFeWMWKY/S+
         TSWOGVrE4TNdPNxr8STSQHDvAz/FPHRZNf/XVpy+v86TuIP7iNWUD2qh+PyNvFBFFRXU
         UP0+8uVLsKexZECLT7nkGd6RahJrnWcRyRr9vJGtGqm7RrVWC4YMQSE6VHpHX9jjsIK7
         WLz92JWaJBTcnFV5ZoZ4vz7+r5/SfD6gBE3QcQGjZwF6oRkkAzNvCJRTXCA7+I3iQrIc
         GWMg==
X-Forwarded-Encrypted: i=1; AFNElJ/NNPM8CkWj6Ve2soBn2EgyAK6DYgXCtF43xNJiptguD0sdmbKoVgoQevpQ2Odm9pI8TZ+6Rn+ysDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9JrehiGvInNm3Xrx0CYICbgAB6iCGLV0P/xW/Efei0D4AgZf
	fYchKyOwDdmSBj/t0FOuiCVqm17wQAFnC3rdMYkipO1Dtv5yH2nHx1BYx7zeHx3Y2A==
X-Gm-Gg: AfdE7cn6jWhOJVvurlYyoJfqwbCeE+1P7CzrWqLhIiivprmIsTqA3Do3nRRqMW17qiw
	WOBmEI0Nfm4szsjZCoxn3UZJaTwIcrbAhuR190HeE7qMp0Q771dxjPqVb9wEeT3IVo8VKu5X8pE
	AKp4vEHgqmS/gc3segHK4kZESuJIYmdzUCNU6qwcU3tS6QKq3DwcUGwQny1ul74+OcAOulyfbwy
	shywclSxq9HBX7jY1EDJHtoOVPr1AzbxZDlbeCU0uHkf3ndjaQ3VAGXKq7JYxSbfFZZlApdMD2O
	UnZOvloyAwRghk8swID5KUEXOxWYHo861GomqkkWQYGipW6rmWvIq+vlRPKVwote/VfY2hRsiLa
	DaUbp8zJRDCy3kPlU5SaM0NYGqIZXLqrnajpvXhzAuuqAojtdwUEHdjRgJLeOHc6OJsL//781va
	prww0bl5L2FrSoY/XGpWAPjMBZOBXwlj/Zo351RDWVFrdCZ4GJ9Gp2iOWMKAMH
X-Received: by 2002:a17:903:2f84:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2c6bbc5d4eemr256505ad.19.1781635917134;
        Tue, 16 Jun 2026 11:51:57 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm13472996b3a.24.2026.06.16.11.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:51:56 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:51:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
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
Message-ID: <ajGbRE3WWJxNxcrg@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-7-matt@ozlabs.org>
 <aixgZQiBQKgS7yIM@google.com>
 <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>

On Tue, Jun 16, 2026 at 09:48:14AM +0000, Tian, Kevin wrote:
> > From: Pranjal Shrivastava <praan@google.com>
> > Sent: Saturday, June 13, 2026 3:39 AM
> > 
> > On Wed, Jun 10, 2026 at 04:43:20PM +0100, Matt Evans wrote:
> > > @@ -1264,7 +1265,7 @@ static int vfio_pci_ioctl_reset(struct
> > vfio_pci_core_device *vdev,
> > >  	if (!vdev->reset_works)
> > >  		return -EINVAL;
> > >
> > > -	vfio_pci_zap_and_down_write_memory_lock(vdev);
> > > +	down_write(&vdev->memory_lock);
> > >
> > >  	/*
> > >  	 * This function can be invoked while the power state is non-D0. If
> > > @@ -1277,10 +1278,11 @@ static int vfio_pci_ioctl_reset(struct
> > vfio_pci_core_device *vdev,
> > >  	 */
> > >  	vfio_pci_set_power_state(vdev, PCI_D0);
> > >
> > > -	vfio_pci_dma_buf_move(vdev, true);
> > > +	vfio_pci_zap_revoke_bars(vdev);
> > 
> > I'm wondering if this change in behavior is correct?
> > BEFORE this patch the sequence was:
> > 
> > 1. zap vma mappings
> > 2. Enter D0
> > 
> > After this patch the sequence becomes
> > 
> > 1. Take the lock
> > 2. Enter D0
> > 3. zap vma mappings
> > 
> > My worry is if user-space accesses a BAR *during* the transition to D0,
> > it could crash since the mappings still exist during the transition?
> 
> not 'crash' as you also noted later with all Fs on read and dropped writes.

Ack, "crash" is definitely a strong word, I just meant that the
user-space program isn't expecting to see all Fs today. Since today any
access during reset is faulted, however with this all apps may have to
lookout for all Fs during a read. Could this change cause existing apps
to crash?

> 
> > 
> > The old code is immune to it because it removed user-mappings first.
> > 
> > Following the discussion from v1 regarding the ordering of
> > vfio_pci_dma_buf_move() and the D0 transition.. while it makes sense to
> > perform the DMABUF revocation/move after the hardware is in D0.. I'm not
> > too confident about moving zap after D0 :/
> 
> probably add a comment to remind that ordering requirement for dma
> 

+1. That'd be helpful.

> > 
> > I mean, sure, the user would just see all Fs on a read and writes will
> > be dropped silently until we are in D0.. but the behaviour before this
> > change was that the user access will fault and hang on the memory_lock
> > instead which ensures that the user observes a consistent dev state..
> > 
> 
> I see this more consistent from another angle.
> 
> Old code only removes/blocks cpu access but not for device. DMAs
> are allowed to this device while it's transitioning between D0/D3.
> 
> New code at least make this part consistent - both cpu/p2p are allowed
> in the transition window.
> 
> Ideally a sane userspace shouldn't rely on the content read back when
> it has initiated a reset in parallel. So this behavior change sounds ok?

I agree on the CPU / P2P consistency part. However, my concern is for a
shared reset scenario where a reset triggered by one process (I guess it
was vfio_assign_device_set?) can affect multiple devices in a dev_set
that are owned by different, unrelated processes. 

In the old code, these peer processes are protected because their BAR
mappings are zapped immediately. Their MMIO threads simply stall in
a page fault until the reset is complete.

I agree for a single-reset scenario, sane user-space should never access
regions during a self-triggered reset.

Am I missing something?

Thanks,
Praan
