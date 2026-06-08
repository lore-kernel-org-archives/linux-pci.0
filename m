Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD23AFCF4
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955808; cv=none; b=Lj1bA1JFUrfgT8XNVNte4h+mb6T3CxNnbXfhGMvqA5ooDW6LMAH/PKhzeSM6xQbmx/cXjJfWdzfhV9L8QAYgYceIy+sCIKLuPLXJFT+oSWyX7oaU5uyuKi7SWKtj2iqakgho+YOiPUJa/tAS2Xts8AaVOn0UAv9P/aC9u8hhscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955808; c=relaxed/simple;
	bh=gceCkSBwwdt3mxcHAkII6lrOZohES5hppE4Qfe92JHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6wBLK7IGHHDei5CXMiMt45iXPHLwBVsrI7N42D9ePudS2vRoHn+EzPEsqiW7aKzRtwEWbYJ2kvzQHa1QwRY1wq2U1S1gBjNnW40Mq8lbjEqeuoCb0TwSdwQyXv/pxamZPMLo0WZ7Oo6CUM5KcQuT8F4FAmLj9/XgMOQeoC10fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iii9t7wi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iii9t7wi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso32796445ad.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780955805; x=1781560605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXXyfmnFaXTXjgYYiyfgw2DtQ2NRAhcXZrd2mOcuVWY=;
        b=Iii9t7wi4o2uvhqvMvVyeO/q+4rRUwL9VNCWvGmONfaTdfZ8XgL+FJ4nKCKhHG5enz
         +S3psov8dMgcP1PAdiDqGfC8VGvTfVcXv/k8x+s//PmrvuwBt2kttl1+i7eryrWg3KPy
         FunATCXGnJs4H2jsRwZq3PHEGyxq+s9GcdYSNMdQfC8DPBkpLGIbhfaL3h2z+YPTwgGC
         aVTQMp5/PNaLfLVznF7/pTRLCW56xikvnov5RGe7sl6ZEIrrPc2928umx2nbY63QMl3O
         6RmWq5ipMV0kyD0IDe8fMbSKT4JmImUphUJBxVQl17ylPdssJwErkLRLUx9H2hrWofUl
         UDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955805; x=1781560605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXXyfmnFaXTXjgYYiyfgw2DtQ2NRAhcXZrd2mOcuVWY=;
        b=HHSxn9LXuIYZ6VPjrFqpngQlwYDJeIdxl6Nx4TSFHKs10iiWjg73F94W4gCqF45lFo
         +DmTHarp4Ahw0CVxtDrLTkrIHXBpHJoqRoZG0jxnvu+jXcGVu0PSSBfBV8/JK8PQw179
         IrBlYFoQY+V/ZcvtU/1INTEpKiAKXe/iu4GsDtYsD2m53RXiojsgLd1M2rlRU8qfWSyO
         jtgpOd0QhPDl2wmvM9M27VJzxZzJz+qPkIpfyoXynURxhtHvxdtDBxf37tm5yqCD9QoW
         dTUjyQcdC/7T3QNdvk2XsGsj/P8vIDPZi1HCLr5SgvUwwD7dJyrgVZ6X+WXsEpML/uf8
         JNRA==
X-Forwarded-Encrypted: i=1; AFNElJ+Nn76cb5n9GgiPhxHVJYoVvmo68AeRHsXwDZyAwYOOI+r2Axnc/Ue87Be5zTYhxdujtjkFLcQ6ZAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeoVQL5/Z6Q/UqjujYLjB4zgiGqK60l1p6YlLDhPRjCCUMYP4
	D+OzdG/+KXNzhUzEQxmHuA+KYnahHbyUxQhEeHDDQ52lfXNkpfFT5UdZVFubWY5rfQ==
X-Gm-Gg: Acq92OEc5DoXSrnz3Yj95RrhPRcm+xgWXeQAnzcgPYnaGGJXW7jqzNkMSV2a0eomNtW
	zfYROhC7pjreGSpwN1VGBT6DearS/9JMoZ4IszPSxciWeD+k1UpqYz1HOveJuIu7mBSpFFDnIzW
	6IC8t8nJxXCvpLZjIwvdnoFKEO6IrSxbcK0FAgW7hG9idogJAMnqsqw4+FIHOnTBXz3qg7TMPaX
	BiQz2m3bXBzqr+6gAsu9IcSUtmOoTbdu6NW7pCAbbWx750gVRxt862XXxliPuY3LUrjfnOH2jE0
	5/uBvOPqtwR0xlY7+eTJkideZm5obeckBBnyaemUHRkRqYQNVwvbkwLjcsgEYswc8M4Tzmxlk1V
	565ID4f0ptD89vNr8rhIELXzoKUnC6xayYXI1Z7iDy7g5hvtA6vRUDEdyAcLDgielM/ku6HYLz1
	tTTeYH0q5XPEuUE3rkrGztvvSXOvE+L3I/gz2uSX/6Vgc7OBmnz1xrQ7G4wSNet0WPTDy1yuHE
X-Received: by 2002:a17:902:f542:b0:2c0:ab82:6bb8 with SMTP id d9443c01a7336-2c1e80cfb97mr203347285ad.27.1780955804952;
        Mon, 08 Jun 2026 14:56:44 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2d4sm177346225ad.77.2026.06.08.14.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:56:44 -0700 (PDT)
Date: Mon, 8 Jun 2026 21:56:41 +0000
From: David Matlack <dmatlack@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aic6mdiZ0qUJpFca@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiXWmR-ettxin4LC@google.com>

On 2026-06-07 08:37 PM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > Inherit Access Control Services (ACS) flags on all incoming preserved
> > devices (endpoints and upstream bridges) during a Live Update.
> > 
> > Inheriting ACS flags avoids changing routing rules while memory
> > transactions are in flight from preserved devices. This is also strictly
> > necessary to ensure that IOMMU group assignments do not change across
> > a Live Update for preserved devices, as changing ACS configurations can
> > split or merge IOMMU groups.
> > 
> > Cache the inherited ACS controls established by the previous kernel in
> > struct pci_dev so that ACS controls do not change after a reset
> > (pci_restore_state() calls pci_enable_acs()).
> > 
> > To simplify ACS inheritance, reject preserving any devices that require
> > quirks to enable ACS as those quirks would also have to take Live Update
> > into account.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/liveupdate.h       | 11 ++++++
> >  drivers/pci/pci.c              |  5 +++
> >  drivers/pci/pci.h              |  5 +++
> >  drivers/pci/quirks.c           |  7 ++++
> >  include/linux/pci_liveupdate.h |  6 +++
> >  6 files changed, 102 insertions(+)
> > 
> 
> [...]
> 
> >  
> > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > +{
> > +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> > +		return;
> > +
> > +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
> 
> I might be thinking out loud here, but as an attacker, this motivates me
> to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
> a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
> strips ACS protections.
> 
> Should we also serialize ACS state in ser somehow to ensure we aren't 
> fooled by something like this?

What does "EP FW" mean?

Does such an attacker even need Live Update to attack the system? It
seems like such an attacker could route TLPs in whatever malicious way
they want regardless of Live Update.

> 
> > +}
> > +
> > +int pci_liveupdate_enable_acs(struct pci_dev *dev)
> > +{
> > +	u16 acs_ctrl = dev->liveupdate.acs_ctrl;
> > +	u16 acs_cap = dev->acs_cap;
> > +
> > +	/*
> > +	 * Use liveupdate.was_preserved instead of liveupdate.incoming since the
> > +	 * device's ACS controls should not change even after the device is
> > +	 * finished participating in the Live Update.
> > +	 */
> > +	if (!dev->liveupdate.was_preserved)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The previous kernel should not have preserved any devices that
> > +	 * require device-specific quirks to enable ACS, but if such a device is
> > +	 * detected, log a big warning and fall back to the normal enable ACS
> > +	 * path.
> > +	 */
> 
> Nit: It might be worth adding a note here that this can also happen if a
> new device-specific ACS quirk is introduced in the incoming kernel for a
> device that was preserved by the old kernel (which didn't have the quirk).
> In such cases, the two kernels are essentially non-LUO-compatible..

Yes will do.

> 
> > +	if (pci_need_dev_specific_enable_acs(dev)) {
> > +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
> > +		WARN_ON_ONCE(true);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (acs_cap)
> > +		pci_write_config_word(dev, acs_cap + PCI_ACS_CTRL, acs_ctrl);
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
> >   * @dev: The PCI device to check
> 
> [...]
> 
> Thanks,
> Praan
