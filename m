Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988293;
	b=eDNhtmEQBmjYmN4qKb5DMLnwD8bkPS2Iwg4YWgCagqT+937bu01P/J8gGg5dvgB1iVgg
	 d0OZt9r9XgVmUfMOxfXx3liMNeG3Z7apel7h6HxU47yd0HQf+4YZrfdGKIBFkUdv52Zjd
	 QFueHwKA19F7gA/Qg2a0EnmGSUrOckNpCAMQWVrEkuHfbEYy99tmU0Yo3BPlsXKdL2wXq
	 h2ecc80VbWYT7/poyb8Xo2wYJDKUeZhvajUz3dHWDC/sWhlrPKE5QdsC1rEXUQ/2kFjwZ
	 3dkClk3mTrcKFR0pIYI9AdjZM7B9iSI+eYHCSfS780Uxg90V2wfykLIsenU2gl+k3Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=r1RbWjqFm7axK1WA6d2qj68hL+HcVofiqBMMK2TnnVw=;
	b=BQ8wX6tA7W//BIqKsZeIYbZzRekG83H8WmYoTzTWuSMEOeyOPSWgr7p59efLeHT2BtA/
	 ySmBYmJZGaoUNR9NuxcoDeNtDOd5U+GIq67YePs2IRIKHdX3ue5Bb0Vu1ae1BUvq+3+a8
	 auDNclo9U4XJ99NEDElHlMgoLuvwut2HAFK0uq1HUx29NX9w0o5CXqcI0yqGvD6YEOwS1
	 GwySBuINkwnunQmG7r5IazyGzHL00DoKk9OYe4ybbryeXNZexSrsr9jPUXzFbGDWhUDRp
	 lxbA1hxYYCk7NRvuJy7fQ+zdCxeOHrxoiI5+YyA5/nnZ7L1kxzulz+SgrGnkcO/x0vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LUoPGOVC;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BF606A332
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 07:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A89BF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LUoPGOVC
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ee254f6eefso50775ad.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 23:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794988292; x=1795593092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r1RbWjqFm7axK1WA6d2qj68hL+HcVofiqBMMK2TnnVw=;
        b=LUoPGOVCxwIAV8eWwoj8F3n1uK5UqmtzFRao+C0cCZUHq9IsJxO9vTwDbY2zSYPI8p
         1qfumvCJfVUCN5vKDO1spF1y7T91lMRReIpLQbHWsxPfGc/nbjXdqXvs2CQUZLMzNBj1
         aBFV1zfO2nYpMyw6C7gOvO9658HCrQbGItVnradArYhcMNZoTKTZ7QcGuKxMwyE4Bb+7
         V4gS2B6y5+UoHy28L9hMkvKhoYBVR1FS3LZ1S/Ut9d5YoLGHmEwTuoPwPJ4bqAArFBGs
         vHIkUJrjVYAoPkaNmVt9+FCPEOvYIHehWIWX3F+AosUqz6qs8XVD1oxRPHrsGj44E7gx
         Y5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794988292; x=1795593092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1RbWjqFm7axK1WA6d2qj68hL+HcVofiqBMMK2TnnVw=;
        b=bkAY/njCx6P7Bw0+L9+y4pb3mKVx6cD+LskRlOmokloNbD2sKfZcBo/lTow5pTk5vk
         ChRsTQh2bP1BPKbAq7DVIeGjbYl50ZJWwcdlVHfpUy0DoyDuA4F0P3K+k8DK7czFZshA
         vSOpyRvFE0qOG00d2QvB6JxXUJBvM5FOTw081Coq0B0AblDHh+Fln6mPTSUqZ2jcjJgl
         U+VoRfFBGLTZtn/9orJG3OLp2x1tZLfBh0cVI0EQqoYFRvcTFekAQJSE5rxQAdvNggrn
         KjZ/YLH4O6awug5SiqBJk0uVUdQI5t6docwtkQWJkZUeLjxkOOvwlJTH5EYJzYMFPPaL
         Dyrg==
X-Forwarded-Encrypted: i=1; AL+hErErxbcAgvI9URTVh5qYD3vyUVhH1sQrgCD6wRHFlgVyjYdG06np8etMJ8IOrAEXgtxqHsRQwupjdDA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TgGMnTPz8Nzz63cbfzwikb4Jdl63UZDj3shcrpFPnDAqADo92
	Omx9FqehspJfacsJcrXhJXuEPWws6uqVJkAz3+9ORNjrK60cha7WbVfGvJ5vmJecIQ==
X-Gm-Gg: AZFdTZcLwCZjw3V6BsmM+MwoDlREuZU85wxfGhoifuL6a6JNffb8X8puu/cDu7iJdCp
	czHMRyMHkLMH/9RHKM7Lr5ceh7hCsV9ddnejmr73Xb2c1e/vQNgrKRxqyYEWMnpWXx6J44uEf7m
	7nC/lJIIZn369wQ+euBcJR73t+xvbEylWP0jm62kCbFg4OxGDJFE58rgBuz/IkjUV37txrOCDmW
	ilCO5el7Y/ht2dFRgbBkygNpUyYl1+V5BbdDi4Ssb5LKaBBzpVc/VFuh+ZOj3kM1B6DJP8Jzj6Z
	O7lFGm5OKvFOeO5hU8tS/+/vUShY5vz0Bu+CTb7u39T79+AenCfy9wfnJez3U9qclGSsv+EBshN
	zwOEtsMWCooOkMBNFZy/GauEfD6TlX4ZP0TNGblzdT4jWi20CNDCXQNhbZdasrRx0VWBsMOIlNr
	+uDPesqdR14Gqp7XLuT6GnWfdGSRRIHx3W5Fkv8tg9s/ImXNRw43fLWcAkA+NMOcLcuaSf7GXGb
	WXHi/B8Jr7P9dzpIRUlYTkwyNza9TTxBRi20YuKXJxSHCYPp/fxzfQN0hJ6Ep22MxAV0pGhK3r9
	wWDOAuczFAYMTXuW+BiTAzNHw75+T9Bu4W/qh3VYWFsKXXYUVNbPGZr/kLo+kca3Tg==
X-Received: by 2002:a17:902:d544:b0:2e6:d25:d874 with SMTP id d9443c01a7336-2eff98d30f9mr2984215ad.10.1794988291451;
        Tue, 17 Nov 2026 23:51:31 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d56ab352sm1000229a91.2.2026.11.17.23.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:51:30 -0800 (PST)
Date: Tue, 17 Nov 2026 23:51:26 -0800
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
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <20261118065653.GE2250529.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMOAT4VV939P.2DI8CEOMMSKMY@google.com>
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
In-Reply-To: <DMOAT4VV939P.2DI8CEOMMSKMY@google.com>

On Fri, Nov 06, 2026 at 05:19:28PM +0000, David Matlack wrote:
> On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:
> > During retrieve():
> >  * Validate the handed-over struct vfio_pci_core_device_ser header,
> >    sizes, and flags.
> >  * Locate the registered vfio-pci device matching the serialized domain
> >    and BDF (requiring device->ops == &vfio_pci_ops) under the device
> >    lock. vfio-pci registers the vfio device before its probe completes,
> >    and the probe holds that lock, so a device that is still being probed
> >    is not returned.
> [...]
> >  * Open and return an anonymous VFIO cdev file via
> >    vfio_device_liveupdate_cdev_open().
> 
> Here's an idea for how the device file could be created on retrieve,
> which I'd like to hear your thoughts on.
> 
> The patches from Pasha at [1] lets userspace pass a
> file-handler-specific argument to LIVEUPDATE_SESSION_RETRIEVE_FD. In the
> next version of the tmpfs series, I'm planning to use that to have
> userspace create the file and pass it in the argument, and the kernel
> then restores the preserved file into it.
> 
> I wonder if VFIO should work the same way, e.g.:
> 
>   struct liveupdate_vfio_retrieve_arg {
>           __u32 size;
>           __s32 fd;
>   };
> 
> Userspace would open /dev/vfio/devices/noiommu-vfioX itself and pass
> the fd. retrieve() would check that it's an unbound vfio-pci cdev file
> for the preserved device (domain/BDF, noiommu, incoming, cfg_size),
> attach the incoming state to that file, and LUO would track that file
> as the retrieved file. VFIO_DEVICE_BIND_IOMMUFD would then take over the
> device as it does now. Since VFIO preservation is new, the argument
> could simply be required.
> 
> I think this could get rid of some of the special handling:
> 
>  - There'd be no need to fake a cdev open with an anonymous inode, so
>    PATCH 09 and PATCH 10 could probably be dropped.
> 
>  - retrieve() wouldn't need to look up the device by BDF, or reason
>    about racing with probe under the device lock. If userspace was able
>    to open the cdev, the device is registered and probed.
> 
>  - The device file would be opened through the normal cdev path, so the
>    usual permission and LSM checks on the device node would apply.
> 
>  - It would be the same model across file types.
> 
> A few things I think would need care if you go this way. The file check
> and the attach would need to happen under dev_set->lock so they can't
> race with a concurrent VFIO_DEVICE_BIND_IOMMUFD on the same fd. And the
> incoming state should probably be tied to that specific
> vfio_device_file rather than just the vdev, so only the file passed to
> RETRIEVE_FD can take over the device.
> 
> It would also change PATCH 12. Opening the cdev of an incoming device
> would have to succeed, so the check would move to the first open of the
> device instead: fail with -EBUSY if the device is incoming and the file
> being bound doesn't have the incoming state attached. That one check in
> vfio-pci would also cover VFIO_GROUP_GET_DEVICE_FD, which opens the
> device right away, so vfio_liveupdate_incoming_is_preserved() and its
> dev_is_pci() special case could be dropped from the VFIO core.
> 
> The next tmpfs version will also add a way for a file handler to say a
> failed retrieve can be retried, and a helper to claim an existing file
> before restoring into it (so a file LUO already manages, e.g. one that
> is preserved in an outgoing session, is rejected). Both seem useful
> here too, e.g. so that a mistake in the argument (wrong fd, an fd for
> another device, an already bound fd) doesn't make the device
> unretrievable. I'll Cc you when I send it, and I'm happy to share the
> branch before then.
> 
> What do you think?

Overall, I agree with the strategy. I think VFIO cdev retrieval should
happen as the flow you mentioned above. I want to hightlight two things:

1. This will lead to lot of code changes happening in vfio core. This
   means VFIO PCI live update code change will spill in vfio core.
   Should I create a config VFIO_LIVEUPDATE for VFIO core code. It will
   not be visible menuconfig option but selected when
   VFIO_PCI_LIVEUPDATE is enabled.
2. List of other inflight series that this series will depend on is
   increasing. It will be 3 (reset function, pci saved state, and
   restore into fd).

For '2', should I send v7 without changes you are recommending in this
patch and future version of this series can transition to the approach
you are suggesting after LUO changes are landed. VFIO liveupdate series
will go through more iterations, so we will have opportunity to make the
change. WDYT?
> 
> [1] https://lore.kernel.org/kexec/20261103010216.3447716-1-dmatlack@google.com/
