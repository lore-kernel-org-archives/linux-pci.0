Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF4481FC3
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122255; cv=none; b=BSsWX9YyX09oth/DYiVbQ0kkqburpJ9kl61vSZjc7Tl3pPy3aGTFDE+evlh5lTXgahbeorNu3mkkMh8k+G4au2d8rtfFEuldzXDNAYuvEbzw1HO0KU0X62ujPV6A0g1zzq9BKhUG9zE9NQ+sGMgA0fRBu+Pzq86aI/hGICK+FDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122255; c=relaxed/simple;
	bh=opLnOv8rcGGpMzk9NYT62osXVn/LxJ7Ob8lhc0zDKrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH3xfA/L9ZKqLFmYG22u97PnmCrLh/c9V0LFg7A/5GZBAf0KV2X4QPi9CHQogrj70WqcvBbKq7Ukp7QnbGvQmH7CmRM6fVLiYODBiZC1h9VIXohE2aRYsDt1buBfO7XJfkF9QUN900Q4bR3zZvrwbf0uLG1Lc7gwoQ2O9s5Lov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2Q8oU6l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2Q8oU6l"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso5085ad.1
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779122254; x=1779727054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+pfGbgcaleoCc2Ifk0qdh18kJSuW5oqOcEuMwE4BYsU=;
        b=P2Q8oU6lQk05pqegx9wz2Ckm4pDXPQZea1FepjyKI/zkJrjl11E+xDSNSU3l6Hqtdc
         D1b9XotvaV/jHWJ40QukJxeJjr0ABXujWSFUNWcdOzVYen/UIIHT3n+YnpGy1FzvRfVe
         oDtCSXbsE7guueyK9OwwVN0vod9he4MfeDgN+YdZjXoxKj/EcGl1UcRQSBR+b9KKKeJG
         XoaUBpcyP2yaGieaQ3WX+yXa5Ucjh54IlLTwgQaphG4uQaZMq/QtSwKgnC4AtUcWt2WC
         Iky9yA+EOh7/FVX/JNOxUxkl545i55IxKnv2pG7wYCoEpuuhy68cNUnSHi6021Aqa1nm
         y6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122254; x=1779727054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pfGbgcaleoCc2Ifk0qdh18kJSuW5oqOcEuMwE4BYsU=;
        b=Opvc/uyROzHWznnLgJwHumYJ9zGPMM6sydZIM4V3fyQCxAFYeDAZyRi0KqJC94mnQi
         T/y1OJqM5TL01pwvqMP3D/sUHBAOZzsmwro8loci/tKZ74PT7E4UuolcVkahW2qG9aDb
         9J/D6LBiNNmvTJVtJ/dqe8ydDDDxfBGRxTwb7wNERjL4mup5NBuf5HBWCCSaMTZelT/m
         UhAhEQrbRy45Gt6eMNCQ7ejdiNztu5BURP/miLAPxB23vmV3SzkTSx7cWMyUGgGxSuN7
         wLQySlLbgwZWfmiJETfUQXeDsH+/XPLITb8epDJimGXoWeROWYi0MDoLk9zOweZJzIOY
         M4oQ==
X-Forwarded-Encrypted: i=1; AFNElJ9a4a479S5n7iff72I6V6iBOtfVOUEd5jjvJgVz8hkGXEZXo3AiWrc2XAN2w9sNkJ4C/5XeY08lk/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LBtcQD4Vg6VPgn0MjAwRwKXd2G1eWtWCluYCaDVfe7GwU58x
	9L96eePPgk4wC1i2whpNIJg4lweX1OjdEGB6FoEr6V5dlRnpByec3fcbqjsRfSZxSw==
X-Gm-Gg: Acq92OGSGAlKw9mZVW5WbS0LsHnWj/mwXPQyS0r1Hd9jTXQDh0lVxi5PeAvj3FeiFsY
	4R17jJIJRBBVIx/6xmaNPpV0QN0EA3xf1upa2L2MdYA5UQ8NTDkxoq9hYJoveUxDt1fYt65aRm2
	EH5E7ZVbJ4zSYm1SpOUQq7RVmeSngGkda04KSMe9m/n6WlAwgQhl7huVCwRWOjK5qRGxM0cJohe
	LXfq/WZ/3F5CwMisgAHcdUa/31gWuH0b8rXj9EmkhgGKIhPlCPWfHMFXShhreZ0XChX8G3dYrbM
	ixOAXpojC5hsHDQhexA4H0MXHJT5AAYZCnG/24cIK/LfSOHnvUdCtdbA2Qhr1Rlv46gnqf9Rz3t
	W0q8ls5RRYtO5RKqx/7y0j6L8BW6vUc3mGbW9J1hTNV2rLA57mhWsGCI822gFRvoCtbvsHVD3LP
	k+Y6MnQTZKZAGCgOiNB49GMzYDmjLeq9LUa2IaQ69AhKkeIArSS7A64RmJmD2GhszLv1LaUL4=
X-Received: by 2002:a17:902:d512:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bdb0109472mr2960365ad.0.1779122253168;
        Mon, 18 May 2026 09:37:33 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121cd6sm14018626a12.30.2026.05.18.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:37:32 -0700 (PDT)
Date: Mon, 18 May 2026 09:37:28 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, 
	lukas@wunner.de, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, rananta@google.com, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20260518152420.GA3281683.vipinsh@google.com>
References: <20260511234802.2280368-1-vipinsh@google.com>
 <20260511234802.2280368-3-vipinsh@google.com>
 <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>
 <20260512211412.GA2819150.vipinsh@google.com>
 <agT9bYpXskVwW0E_@google.com>
 <2vxzcxyy9fpd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxzcxyy9fpd.fsf@kernel.org>

On Thu, May 14, 2026 at 05:24:46PM +0200, Pratyush Yadav wrote:
> On Wed, May 13 2026, Samiullah Khawaja wrote:
> 
> > On Tue, May 12, 2026 at 02:29:19PM -0700, Vipin Sharma wrote:
> >>On Tue, May 12, 2026 at 01:59:51PM -0700, David Matlack wrote:
> >>> On Mon, May 11, 2026 at 4:48 PM Vipin Sharma <vipinsh@google.com> wrote:
> >>>
> >>> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> >>> > index c12d614fc6c4..019de053f116 100644
> >>> > --- a/drivers/vfio/pci/Kconfig
> >>> > +++ b/drivers/vfio/pci/Kconfig
> >>> > @@ -45,13 +45,15 @@ config VFIO_PCI_IGD
> >>> >
> >>> >  config VFIO_PCI_LIVEUPDATE
> >>> >         bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> >>> > -       depends on PCI_LIVEUPDATE
> >>> > +       depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
> >>> >         help
> >>> >           Support for preserving devices bound to vfio-pci across a Live
> >>> >           Update. This option should only be enabled by developers working on
> >>> >           implementing this support. Once enough support has landed in the
> >>> >           kernel, this option will no longer be marked EXPERIMENTAL.
> >>> >
> >>> > +         Enabling this will disable support for VFIO PCI DMA buffer.
> >>> > +
> >>> >           If you don't know what to do here, say N.
> >>> >
> >>> >  endif
> >>> > @@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
> >>> >           To enable s390x KVM vfio-pci extensions, say Y.
> >>> >
> >>> >  config VFIO_PCI_DMABUF
> >>> > -       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> >>> > +       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER && !VFIO_PCI_LIVEUPDATE
> >>>
> >>> Why does enabling VFIO_PCI_LIVEUPDATE require disabling
> >>> VFIO_PCI_DMABUF? I saw the cover letter says "to keep things simple",
> >>> but what specific problem does this solve or simplify?
> >>
> >>I should have provided more details there.
> >>
> >>When device is getting reset in vfio_pci_liveupdate_freeze(), we are
> >>zapping userspace mapped bars, we also need to use
> >>vfio_pci_dma_buf_move() to revoke dma buffer access or
> >>vfio_pci_dma_buf_cleanup() combination. Cleanup takes the memory lock
> >>which freeze already takes, and there are some refcounts which are
> >>managed in both of these APIs. This was causing complexities with code
> >>flow based on result of pci_load_saved_state(). All this was adding more
> >>refactoring than I wanted in the series.
> >
> > Maybe we can return -EOPNOTSUPP if any dmabufs for this vfio cdev are
> > exported during preserve?

Currently, no APIs are present to fetch if dmabufs are exported or not.
I will add one patch to this series to return EOPNOTSUPP and remove
condition from the config.

> 
> Whichever way you go with, a TODO/comment would be nice to have so
> someone (including future you) looking at this code knows why this
> restriction exists.
> 

I will add comment in the next version.
