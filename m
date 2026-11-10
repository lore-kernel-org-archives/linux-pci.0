Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336338;
	b=IElQIHMQRc28Er3opSdfUuSoWYc7MVAKCDM/6+QTkYnGxwzfL+byZhNZGv1i58KDIrjs
	 NJu7AQ2gNKFPDpvNYdqvpNjGurL7C5zCyHt1e94WRjnSJiQvfI7l1I52nyY4/px513PGQ
	 uJ4oAgo7iKdHL6piVKw9jTx70ninuyXLvkD9jUJ9dhkNbPhAItNSKO3XTo8UjC54TKHSU
	 nsRmX1/1Igfhgvxl6lFdbd3FqfC6HSzRiaURoAuzcf+drg5dyrqPg0Iny93PzVL2m1bN5
	 8ORYKP9R5RXCOtviFsWtZfVNivruxri5MkPT/H/zuTPWCzizF/vMEMgGV6XRtXsssKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=j6HenvetdiqKK5Mv1KKa157Ln9/E8xXqIQ72cYSu+2Y=;
	b=CpkD0KxIKzoHjmk+fsfKSjU57mvM6zfDhEBzXgsSzdvc5B5+mlHM305vX9nKBxSMuy79
	 8cHdJRy3VuOj0PW6UT//6FMlokVtvXFDwuFRIyEclmx9kjaonn3K5bFHzIJIsKkblQY6V
	 2kKpczKo333P8Xy7jbojRNRVM5i43LLdHbYhPYsNz57iFIDqBuNQZkdp0ereg0NgnOfkS
	 aSaJrIjj/b+i81NqW6fX3GuIpxme7I8r9oinJTiJmria7qetNqUd4x8wD97530XkFJyQp
	 YShcxttExAYUMXEuITmxRxqzYQGcjXcZGoO4Cg7fwPFJD9PoWFuY7CXuEdW5neTrRlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fqYza+qT;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC84606A333
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 18:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DC84606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fqYza+qT
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2eb0a52d605so6555ad.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794336338; x=1794941138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j6HenvetdiqKK5Mv1KKa157Ln9/E8xXqIQ72cYSu+2Y=;
        b=fqYza+qTmu263ZJR6IQbgcfkkw9jmBae56WVI+o3f6yE+Kb1eAns8SLyCefyix05sI
         yNFEQKraXZrzlgeP0EDS4+8DlSYhhDPuNHBvo9HtQkvkE80biYpP/AWmMZMb4N/avCqc
         tiBIiao8l8HKCuoG0Mts/I6lvZxkuP9qJfXB7Cyhx7J46AAPju6wNkwpIXeVimtsE/cG
         GqmB+KwHAwkczSt+6neTbRmWUTaNZHyZbOq/lWaPoci+yXV25lxstqc4zN1oce/Vkxwn
         mLCQsVZ9HPbXapT6AxcKUs02u2n1Y2y/FccJnECWdMdOU1ViJg38CiOwYx0X1JHRx/0Z
         HWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794336338; x=1794941138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6HenvetdiqKK5Mv1KKa157Ln9/E8xXqIQ72cYSu+2Y=;
        b=oV8gEW+W/lAceUjWUgI4n/3x/Ao4SX6PmN4572tNhdNJQNR/HrLBTMBLSXebsukikz
         9M0G74uG0D4TFjcvhH84/C3BTU/3TX629xEOc/7ryfFK9m8/XVhh5k7/EHlITlFrW632
         L4o0xKW4Nb/GtFeNEZcdHnRE7RqWvqKlcFtu4gU6GHO6droyD5RlUNrZqwc90dYqZXY5
         kJppZ16HosCbmWWESlZa2thgq7mHY0c5VOfwsaV0VOzZblERSwgFyGyTewc09ikKvwRj
         As80QOH50Gcv6Uta10EDGI9siGooRbORJo0eWZgyCZBkju41XaZtwQtG56AZKiVj0cDg
         G6OA==
X-Forwarded-Encrypted: i=1; AL+hErGLuooyOnV8Tu7KrwaFS3r9/Imr5ucItl+E9JPzsI2aAYS7CP7Ev9GrNXKsc3aFMhxGykGTtOscdPI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0AedkGY2X3Fbjpay29c1Fsncaqpr/j5diuSCoYS3dialqT641
	U9I3oKef0CAwjdk7SpzqjW2Pkfd8CRQH0j35irqj42jR4+I66HoQm9fBQsEZkhppMg==
X-Gm-Gg: AYBFou2EetfOlRPTEXgUeiviPlPUSdBi5Sad2O8xlEkJY+JpjXoBT8lFGILjUlqg3FR
	1Yc5lLqT5wEJo8EqmN8N7FphJk69oRTaJ9tNDz3iR5IdO60XmEDiX3I67kqezxebQH+x/aMUPp+
	O8gsKR26I8OSYGhULZ387OFLCepAMh16wXBuXmmf0WL8438w87fQRnJ7LvPh2e8bqbZqtHKbJ30
	bvtfJ5QzRUvXw/Or9NScWoDHGfeTLWDfvm/fWqIjBqQMEiwjzAqfyQ7hiXWPTRonZHq0qqG9lZf
	xyVX7nhKK4w9O+cz2cNCiVtlH/uvrpfz3lVZtcAuvTVde/ba09pG9bVX+4DQuIZ16mTnfgws1Ti
	z+lJPD4sGDbIifVQY+WcPyoKuleLxV99DK+A6/PnOWWxsFn3TAs8TAZYDdgE5rkEdntjDca+4qd
	qIArMA6ttVrdGvgx0bnX+rtOAV1/CF/exqCaxsJFbKQVb6r2Tc6JSJ3Q9dNXw29IYBGbnOECytZ
	sOQMgrHQYGFhMdm7HV0jEV0/Hm9RKpOBtePMmtm8iEh3YTLb7bSPQvoT+Hm3KH74xnITDZODTjr
	aLSTFeZwnO3HJjjJayR6Ou6PJXUbIs0ApxBuLtShorGoKGKkF80wz/X1eATqkyHu
X-Received: by 2002:a17:903:2a86:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2edd7110fa8mr255665ad.2.1794336337416;
        Tue, 10 Nov 2026 10:45:37 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86ce5fsm1317128b3a.21.2026.11.10.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:45:36 -0800 (PST)
Date: Tue, 10 Nov 2026 10:45:32 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 00/27] VFIO PCI Live Update (noiommu mode)
Message-ID: <20261110184339.GB519525.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <DMOH7D1PZUM4.1X82LVQK7E54Q@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMOH7D1PZUM4.1X82LVQK7E54Q@google.com>

On Fri, Nov 06, 2026 at 10:20:10PM +0000, David Matlack wrote:
> On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:
> 
> > David Matlack (4):
> >   vfio: Enforce preserved devices are retrieved via
> >     LIVEUPDATE_SESSION_RETRIEVE_FD
> >   docs: liveupdate: Add documentation for VFIO PCI
> >   vfio: selftests: Add vfio_pci_liveupdate_uapi_test
> >   vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
> >
> > Vipin Sharma (23):
> >   vfio/pci: Factor out the reset logic in VFIO PCI device close path
> >   vfio: Export various helpers from VFIO
> >   liveupdate: Export symbols needed by modules
> >   vfio/pci: Register a file handler with Live Update Orchestrator
> >   PCI: liveupdate: Add helpers to preserve struct pci_saved_state
> >   vfio: Add helpers to identify device files that can be preserved
> >   vfio/pci: Preserve vfio-pci device files across Live Update
> >   vfio: Introduce vfio_find_device() helper
> >   vfio: Refactor vfio_device_fops_cdev_open()
> >   vfio: Add API to open cdev device for Live Update restore
> >   vfio/pci: Retrieve preserved device files after Live Update
> >   vfio/pci: Protect incoming preserved devices until they finish Live
> >     Update
> >   vfio/pci: Take over preserved devices without resetting them
> >   vfio: selftests: Build liveupdate library in VFIO selftests
> >   vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
> >   vfio: selftests: Add iommufd noiommu mode
> >   vfio: selftests: Add helpers to map DMA memory at IOVA == PA in
> >     noiommu mode
> >   vfio: selftests: Add helpers for Live Update DMA memory and sysfs
> >     state
> >   vfio: selftests: Add an attach() driver op
> >   vfio: selftests: Test preserving noiommu devices in
> >     vfio_pci_liveupdate_uapi_test
> >   vfio: selftests: Add vfio_pci_liveupdate_kexec_test
> >   vfio: selftests: Verify that opening VFIO device fails during Live
> >     Update
> >   vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
> 
> This series is getting quite long. I would consider splitting out the
> selftests into its own series and we can iterate on each separately.

I think it is a good idea. In next version, v7,  I will send two series,
kernel and selftests patches.

