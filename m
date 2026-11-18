Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984950;
	b=0TuRTEEclu/QwCUJGn8ERvvGd4d4/sBq3QeZKSuTF19mkxsOgszdqip1CO83geDTkDXl
	 jXdYcYpjWSoMlNPkgruZ4vDCdJxU+HD/KdR20dvGiaOu0XaVm9tS+zbg1u2mg+PBpHB2W
	 i/+XTSqJNVjTgoSoV8zVclz0wZCzcpC7jinS/bP+FRMbRT1ojgpyRQ82eYiPo/urNVHDd
	 MeAJ+mM9KtbuCbN4iGPLMSYm6fMGZ3kdvIwH3RM5idyKJ0+wBEQhYJrtavXmT6l6A672h
	 CT4i1tESvrCbhqps/a3pNYLeOlMNTUcoHqbTQwfOpgM3rly/61icv+ffMqfjG03jeNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=D3IFWTA7ou2igClaDYSbsGTVSgzRWm+OXVAzSzama/M=;
	b=hBVLgZdC6GIRnuD0CBQ6a6bOE5lYK6ApqHdsbKzpXG22/VlrgbmbBx7Qku1WuAdpihvj
	 JjR8+25WQu67K1e8F1s0x4aM6JAFIIiqDxVd3Lf12bcwAVZm58+uYmzZgM+Fw3qAuC4pd
	 vRW8JL0546BM9rVTuZ24i0R7/YiMzZeAINJ+oPzuCXd39iDzdRE3Fky1l1QCZGlQhLgRv
	 ZLfF+YLJGln0drgnK39eGRaXcNHfhtm9sJ4ulKbHITLXEnNT9Oj6q5m7akB4y+UOEW3Qw
	 wg4hWdzkxDAL5e5rSl5cs5HfAq2a8UROub1rzl9vmaWwB/ZBv+aXcTf4V25hmpJldIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nM+9DlRr;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA96606A334
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 06:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEA96606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nM+9DlRr
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ee254f6eefso48105ad.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 22:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794984949; x=1795589749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3IFWTA7ou2igClaDYSbsGTVSgzRWm+OXVAzSzama/M=;
        b=nM+9DlRrSc+VH8u2ub3VdFxYKqtFiGInc/JZw8T73N7OAqXa44YAOksg8x7jKYkkuF
         yOwhOSelLbR3ciacjrREpqKFfhwK5r7r/lk1Uuk8xfjoCoH/lNZCee8mUf7VWzgC2Bpb
         tu4epm3+IlJ0ND44vTbQq5ss3XdQK9+PEMFYKwhU6O5AlBrQKFaQWO73Goy4f29mqVNF
         kOuWgxQrag89XkFP2hXkoPYCBeCCPY7IogUEhAraGQ1G4jNGdi2k90Bcg85Nv9zDziAx
         kxmiwEPofn984RQ60OOeumbDhK4iguBvHixxVMsJ3QgsnlDAMgH23D0cSlu0yXLJ2j5K
         Zj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984949; x=1795589749;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3IFWTA7ou2igClaDYSbsGTVSgzRWm+OXVAzSzama/M=;
        b=vd7LrzOaZ0iBjlaeqv9t1jrfAY4uzJkUgwdo5yQNiAwolpXXufmNofLWbITfAb1JgA
         TCkc1Ho9NWXk7VaaOVFeG/gWL6dPCoTPqV2nYlUaNVEzEi3x7vflFuyVgFz2RDCyunTV
         J/FmlITHGnNZlGLNCsSHVuY5+gKpemiXXWEn2hjRIZoIc0auhWttzeiikL6bY3sLk6FV
         BFSPAK9co7kzwqE+gbk06Q0iTHDgMLzaHsW47geSmlyq7xKGpaauVCq0rbZbxDGPqoVG
         D4DNUjeGyWBivGHAJdXyySPn8sEJZtzJ/PZT/64d1NJgnntPB31JWY8YX5SCRSBRMA9S
         jtbQ==
X-Forwarded-Encrypted: i=1; AL+hErG1v23AYLa2tvJfLMj5qbGQRAT/b7XyhTMfG/sMi1wH2GeKXR7yTlnJFq7eIRs1PbmPS52bqU0uuww=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Zf576op4AMxUcd/RKG9LXWuKog2BoqHt95oD0uGACPCs38sIj
	lWoOnMhq0y9n4HtrK5wE6jiEB/6YSWhWhbMXhmWQl0STr36MASXsqjfGMCqb0fI75Q==
X-Gm-Gg: AZFdTZceS07bAmPvXCWUT0QmCsZVOD/UwGB0tdYc5wGcpTRqMmSw/F8ZOW/qDd1JQoH
	+5qydxWkM0E20i0quAR1kfSvJ3fdntmyLN6+JYozZ9wWQWxq/BGOPcUQ+2kYOQRJlVvXYk4MKCG
	YLmkNry0QqCCpHl8MFKywSzLHTIbfHFNFJEMr0ZYopDYUXwMN2FcJpzqB/uBVrp5OhUtKby8R4j
	6vuFnO3kHTMaR0k8PDQubYbiMwtmfloS0b02ii9B0ZEDWKdz/fhldjPc/2SF1GsdaiLd3nsGQ8G
	AUkrOqoDCZrz8qUu+IE+AywBDWumBa6lFJUc0fGSwTlbIcNPrPvHM5/WVuovIULRx7bXgL2I7BP
	H/j7I5ZxBPLGmDMKxte66/f+4tlk1JdJFOwiriEZlO5rSf5HxvvIJ9eYvy35Zl7UBVXd/HTPFBs
	KF2043qmdCXmOA5iU8r1pUSm4/isyGogFMLn2Y3jlHZvWJDTzvEYjSspG/UI+XOuV+XAohxOPq+
	744+J04DlckHtd+TSRZi9ewyS5LvbXwPPZzRfJWOdEDb2mRluqRfujCItnfmIyf8ffSTPoyZ8R7
	C3XNidGASpD1f5ehybAaAyVXnZcE/VrnLJBUnVuqjP3v88rwD8GEPovVDDuwPfki
X-Received: by 2002:a17:902:ce10:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2eff9952062mr2886095ad.17.1794984948419;
        Tue, 17 Nov 2026 22:55:48 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca5bf959sm657169b3a.20.2026.11.17.22.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:55:47 -0800 (PST)
Date: Tue, 17 Nov 2026 22:55:44 -0800
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20261118064707.GD2250529.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
 <au5VMy7zhOb65xIE@google.com>
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
In-Reply-To: <au5VMy7zhOb65xIE@google.com>

On Fri, Nov 06, 2026 at 10:35:27PM +0000, Samiullah Khawaja wrote:
> On Mon, Nov 02, 2026 at 07:36:36AM -0800, Vipin Sharma wrote:
> > +/**
> > + * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
> > + * device.
> > + *
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @cfg_size: Size in bytes of the device's PCI configuration space
> > + *            (``PCI_CFG_SPACE_SIZE`` or ``PCI_CFG_SPACE_EXP_SIZE``).
> > + * @size: Total size in bytes of this serialized buffer, equal to
> > + *        ``sizeof(struct vfio_pci_core_device_ser) + 2 * @cfg_size + @saved_state_size``.
> > + * @flags: Bitmask of ``VFIO_PCI_SER_*`` flags; unknown bits are rejected.
> > + * @saved_state_size: Size in bytes of the serialized &struct pci_saved_state_ser
> > + *                    blob stored in @data after ``config_map``, or 0 if none.
> > + * @reserved: Reserved for future use; must be 0.
> > + * @data: Variable-length payload containing, in order:
> > + *        1. ``u8 vconfig[@cfg_size]`` - VFIO virtualized config space snapshot
> > + *           captured during ``freeze()``.
> > + *        2. ``u8 config_map[@cfg_size]`` - VFIO capability map snapshot
> > + *           captured during ``freeze()``.
> > + *        3. ``u8 saved_state[@saved_state_size]`` - serialized
> > + *           &struct pci_saved_state_ser captured during ``preserve()``.
> > + */
> > +struct vfio_pci_core_device_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 cfg_size;
> > +	u32 size;
> > +	u32 flags;
> > +	u32 saved_state_size;
> 
> We will need space for iommufd_token when we preserve that, we should
> probably add it now as otherwise the compatibility would be broken when
> we add it? Is the reserved here for that?

No, reserved was just to align data[] to 4 bytes boundary.

Based on David's suggestion, I am gonna get rid of variable length
data[]. This whole serialization struct will be fixed length.

I think it will be fine to extend this struct by adding a new field at
the end of struct in your series along with updated flag when you add
iommufd support. 

iommufd preserved vfio device cannot be rollbacked to this kernel where
there is no support for iommufd preservation, so, flags will be correct
to reject the change.

Do you have some other concerns when yiou compatibility would be broken?

> > +	u32 reserved;
> > +	u8 data[];
> > +} __packed;
> > +
