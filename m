Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A669314A67
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148710; cv=none; b=tk3OnP7K7Oqu1xLgy8N67fv0FW0gDv/YzqDTTNolIU/yXAGlOzuldolOW/CFdKDrjhNnkkSoy/wuS3Gz5ZfXqYFYaq7+xDv1VNh977tciwdsbDwnfIvrnXIT1IZl5OzqvQoiC2emS6cv3Am6wvhzD7g6qFRPqi0NZLdKl+T7wo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148710; c=relaxed/simple;
	bh=AAF7fByBTFvHIdoynRYlkawoyRHswdrvQIY2msLKBYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3M5Iv9P6jDG6QyjUHDCPo/wYDe5L/VRLDakRokk9A/pENIxjX7NJHsGgTCxxS+0Lzcf09Hy0Vt/rjJYtXp/gvnZKqbEXet6AbKgn93TlRpmLDfTvFOp/ggzC6hSrTQMVAya7T3MurTDKOEI2PZcVqi7UmyZNwZTUiHNr5e9ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdeHi2ng; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdeHi2ng"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaed195901so7132535ad.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 15:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772148708; x=1772753508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ19nP7LWyVtbwlYCJ4KZaeb2FLacueUWULaQoURJXE=;
        b=fdeHi2ngbLtudCw29sk0ANC/rvY74LDswMpIo85pe4L3DkXLDhoUtfu8d+zS8xmVaE
         oRn+nKfDrOM3MM2ecdwfWBeSB6fMIevw/Q7E9Fx8bMXF87+Z9BT6bi+VFc7uxKsao7kU
         lXcbvqou7XO441ypiWEiPy/vA9UUU8lnXEaFDQUAXIxAkRUl0MaNOrr5/c0A8HAezZVi
         G+lFe5WWH9dSPNva19h3f5d1xpGnEy2QvV/3sUK1b5Wteov/d1Kw8QfEz45XEjcFv/64
         Is6AsNwWAXfLHYr/rVy4zp5U0hvwu2bk6MxXt2B9lIaPCfGz7PeJ+dzb1npIRYp9tSrU
         6q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772148708; x=1772753508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ19nP7LWyVtbwlYCJ4KZaeb2FLacueUWULaQoURJXE=;
        b=VH5p0SYyrDmoVhWitT2x2zK05eBScKAQkk/fpEuCXtQVHLwyWCwtC2ieN2cfajCVNV
         eGaSZQ3AcpiqumYAvysBHfxnqQRmxzVkyTw8giEvtFpJnPyeGSlzUEPQa72yS75ZZ7Me
         Henq6AHpbX2cILi1r2ffkjjOzeqC+BbbLd5DOAIEF7qExVwFGisBNrSa/6yNq3IQR7Gd
         WSzt3UlfCAAgc7N9BsLG7j6j0RP+dyWOEMISgXgn+0FWYZUcZyo1BCXQqv7zLVYr1JA5
         LIvVHjlGFaCLQQcBo3/qzVmC+MnZnqCZ7D9uNlHaX5qXBtZUfik5ZDdt2hcBlG07hGxh
         Bg1w==
X-Forwarded-Encrypted: i=1; AJvYcCXU86Qrix8nqNg1dD0rdRwC0L3UZX3v5qQfTvljZutRn3wBUQYpzZTwAh0sPBxXcq2jI2n4Dr6OWvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9YgQPRoyppjDeXAjI18Z4La+AR+0hj+a1fievq0myqM16DrLu
	aZpx4ioAN6MGLuxUDgDI5IqEPN9HUR7f783jCb6hd7awyN5nw2URIesdMzAkbUNK0A==
X-Gm-Gg: ATEYQzxRVhFCpa4erqPmy3Wv8y903zIqBHqJ9gxXgPih7OIkznyBIAd7T6fRjk9JIbj
	AHneYu4jjWXPpdTyrz5qxwa07cIK2m9J25EaukkXihaQMbwPMxVT7iRLR23thC7YqFK9VFLqNZ5
	PDNwsYo3wPrE/59J0Fssu/0gvjmXOEIqv+W8XIkpMLFn1Ow/OEC4PrTDBXyUAF35nxNHuCLZCWg
	KQg8oNzpRiCCbuWifH9zOzSh1Uv3UxT5G8TO8DmD0NHMsteVB7CvgrH6XfmF3AgfKFDZd++MEtM
	mkJqwQmHWeEhV3av7mbb8s/mhmX7FTgIt1TVgbe0dsYL4rEpslWlExPyJwDFTDw+79oh+pL5kWP
	PEfOJ29Tjnc2iYb2h0giAq61kWmEHqxTaGS8JO/w5hhV05ojeLTmr2KP0B9zochT9zfnj3H9524
	L84frB+ZXPRAFFAd/NxOUlcsg/xgJeSarI2HGB5nRPn1C0Yfn+rMbhZe7LO8Tx6Q==
X-Received: by 2002:a17:902:dacb:b0:2a7:919c:34c6 with SMTP id d9443c01a7336-2ae2e4cd74bmr5371545ad.38.1772148707814;
        Thu, 26 Feb 2026 15:31:47 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a0432sm53850525ad.52.2026.02.26.15.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:31:46 -0800 (PST)
Date: Thu, 26 Feb 2026 23:31:43 +0000
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
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <aaDX34yT_3dwUi4I@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226160353.6f3371bc@shazbot.org>

On 2026-02-26 04:03 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:54 +0000 David Matlack <dmatlack@google.com> wrote:

> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > index 7f4117181fd0..ad915352303f 100644
> > --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > @@ -53,6 +53,8 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
> >  	if (IS_ERR(ser))
> >  		return PTR_ERR(ser);
> >  
> > +	pci_liveupdate_outgoing_preserve(pdev);
> 
> Why do we get to ignore the return value here?

Ugh, we do not. This is a bug, thanks for catching.

> > @@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
> >  	if (!liveupdate_enabled())
> >  		return;
> >  
> > +	WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh));
> 
> This is propagation of a poor API choice in liveupdate, the unregister
> should return void, it shouldn't be allowed to fail, IMO.  Thanks,

Ack. I'll make pci_liveupdate_unregister_fh() unable to fail and follow
up with the maintainers of LUO about liveupdate_unregister_flb().
