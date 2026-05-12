Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EDF382F00
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621367; cv=none; b=bKzGzfgK6UJ7GWHsTNbWYWVxcrHKEp0a5B5/9o0TPgzlWwoEkFSNpHgwHD3mYgQiWu0rk4b8Kd3Ll99hUpWq1ArFrblu2ZssBkjZqI9dtBh5QZVeKQ0E/zIIHk+jzJRtsFLCGX3XztrR39KCC8o7kZ1fIR+AsPCIQnQMFy+vMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621367; c=relaxed/simple;
	bh=PVEZ6lDsqfrkheYFwj2coqzGfYHxktZ0uXkER3yjEWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG50KcMaMw3mwJ09xFdCFH72Q++3jiGRn9/qm3cIq11dwCXTDX+yA+2Wl3jkMdtza4gsgRkp0jF/WgOl7RQS8SI2rAUUJFiSKfxAaz5AtDPnuXcRFUOXUm/2bv0mgvcn+aLgwnV9YLCVYM88ZWrAcGyp/wuRpW3hKtIqFbL31vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2TqEeYx; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2TqEeYx"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8d0945b3so28c88.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778621366; x=1779226166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9as17r1aSDL1/IjkeK3rxFdLzhg/o+IZ2HDHZMfPp0s=;
        b=O2TqEeYxQ++uEzCuAjSrp9S4rZXfnp3qCMLVHPDxioCo48GoTxdEgkrstQufcqRGl2
         5ugnERzU6ErV4dQjNB2XQbZVFCBoI62CIUqgsheQA3GuF8LNEuQIQHObJ48N1rW5bxBn
         p1VUyj9oN/kW8j7kutMQ2q/PtDM1bSRSErzS5XBXPs/J3JALkHzf7dFwE59NTSfuZQZ8
         BvDqmSJMaPdZ7+EqH+kSF0Q/I5Yuuc3X8tw4JhqU9w5umF1bPiJC8sq+Yxs10c8zEm/j
         2HzL7yJ/A4DOrx2RS3k1dt1nwUg6KaO9RE10N46u7bVIHJmPnql+qBD8hqmRPrOBP8ZW
         WHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621366; x=1779226166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9as17r1aSDL1/IjkeK3rxFdLzhg/o+IZ2HDHZMfPp0s=;
        b=jcRcIgjyyppBxlrRlUIc1T+jAcwTkX6we4yAHwbuzcgSazf8l3ZR8TaOBk1Jha3Kqi
         GHdO9X7/JsoO7qFckQW314cb4YCAZaJY+Me46Paz6BqPNONwG6/ll+aID9g+JiQAZYey
         Y9sxAp46msIm5MQFFBlBTDWVscrP7RdGc0KKMkXtmg+U7jLMHUOSbRWgJ+Qv0V2ejJ+4
         Rfo3hyUdJKiVlqrEpgAeFB/4QlEqkqt4eRx1mBwb5Wk9n1/9zIntkhi1wtZXqddGK3rn
         UrbKSR8T4ruMcZq+7bGl59bNsM0ZCSnBsTaby2nhytxOFLuQfqA9bj23eJu3+K6Mxf3H
         50BA==
X-Forwarded-Encrypted: i=1; AFNElJ+rwGCRc+ac1KSumASDOgScURifIcmrQ3vu3cVfyQclN1yhsulzmgEfAuiH4r3iOCFL1k+J80F+vds=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqNWQc8i7sYsOITUe1sJ3EWxCM4PJw+lryZ/IZuqRrEAy/AVC
	M/SSW3q/xDSr5QcV9q7G6CbNlPTmqPA0YqgWImBg0sipE7sfhMIL2ay3UFcBsekx07wZO1Bj/xm
	HGkj6m1Lh
X-Gm-Gg: Acq92OGGW21T9M6lsq0aXTbxxTOHe6LaBteYYNg/YgXFgcgt3gJMkVHizMydIpT9qlW
	6zFpaJ+QpChZYxmXpTuuFCmTsRXzf8gGpyTGipojn4YyRr1hhgB/2/uQuHNa6mZEeM2R4WhIQP1
	WIwd8jLcriLn5nY5uOb1g6WaIBIYMTu4YqdbT4JlAyN92SrCLGBLR6+3smVmZp4gftGr+wIawsL
	b98NBXPF9PJVCYFkGdgG8EH9QD/dRYi6ctODhLlcnCnq+4vra8U7TR9QfyQ/Tv2ea9hnnz5oSQm
	YeGjrP0l097TK+M/pvqni4NPWr/+bSRIrshOkOu3hM/qNBOH3eGbzZs2TtkDNCF5FiyDzLw1lF2
	lqwyONPV959vXhiCp+iikKL91jnkoZw8Q2VCnkc8pHBkxpDVnXYq7Tuc9icVCZ8pLdF8/D2JbzN
	gim4tFabZVSpmZn8zOFGNUTrgEiI0sWofA7w8QSkhtD4yo9E6fUfmxmSuowKepvAKjtxx638ha
X-Received: by 2002:a05:7022:699a:b0:132:1e01:2d6d with SMTP id a92af1059eb24-13401ba684emr108868c88.2.1778621364956;
        Tue, 12 May 2026 14:29:24 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm23087120c88.7.2026.05.12.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:29:24 -0700 (PDT)
Date: Tue, 12 May 2026 14:29:19 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, 
	lukas@wunner.de, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20260512211412.GA2819150.vipinsh@google.com>
References: <20260511234802.2280368-1-vipinsh@google.com>
 <20260511234802.2280368-3-vipinsh@google.com>
 <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>

On Tue, May 12, 2026 at 01:59:51PM -0700, David Matlack wrote:
> On Mon, May 11, 2026 at 4:48 PM Vipin Sharma <vipinsh@google.com> wrote:
> 
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index c12d614fc6c4..019de053f116 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -45,13 +45,15 @@ config VFIO_PCI_IGD
> >
> >  config VFIO_PCI_LIVEUPDATE
> >         bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > -       depends on PCI_LIVEUPDATE
> > +       depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
> >         help
> >           Support for preserving devices bound to vfio-pci across a Live
> >           Update. This option should only be enabled by developers working on
> >           implementing this support. Once enough support has landed in the
> >           kernel, this option will no longer be marked EXPERIMENTAL.
> >
> > +         Enabling this will disable support for VFIO PCI DMA buffer.
> > +
> >           If you don't know what to do here, say N.
> >
> >  endif
> > @@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
> >           To enable s390x KVM vfio-pci extensions, say Y.
> >
> >  config VFIO_PCI_DMABUF
> > -       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> > +       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER && !VFIO_PCI_LIVEUPDATE
> 
> Why does enabling VFIO_PCI_LIVEUPDATE require disabling
> VFIO_PCI_DMABUF? I saw the cover letter says "to keep things simple",
> but what specific problem does this solve or simplify?

I should have provided more details there.

When device is getting reset in vfio_pci_liveupdate_freeze(), we are
zapping userspace mapped bars, we also need to use
vfio_pci_dma_buf_move() to revoke dma buffer access or
vfio_pci_dma_buf_cleanup() combination. Cleanup takes the memory lock
which freeze already takes, and there are some refcounts which are
managed in both of these APIs. This was causing complexities with code
flow based on result of pci_load_saved_state(). All this was adding more
refactoring than I wanted in the series.

I decided to just drop the change and disable the support of DMA Buffer for
now to keep number of patches less in the series. This will go away once
we remove reset condition in freeze.
