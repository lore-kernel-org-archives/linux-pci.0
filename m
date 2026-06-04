Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1D274B39
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597986; cv=none; b=d2ylNDfkYQsFzPMlq53K8Y4QdIOiq/7KTJtHOKaecoeVhK/hfRtVBcpzPuDCWUY7Mr/KWQ3uM9pQA3BFQBNMA0L4asvG2VkRVHOsVd2Ty61KxOLecgjPs2K4VKlfhJWO6Zl4bR4g5/L4OJvmAfc80Ap2uxnM2smGpBdDVCY5elc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597986; c=relaxed/simple;
	bh=+nl1kEKt44yDxCMl/11ffRuwiMWmCEuCgafc3BLq0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMnW83XkbHvnLRcSUpd6bem5M77W3vBXjEKH+Vr5QO+CNSqmE06uVxbveGfz4FBXqs/2yOPXWsFz670PpkiRGoPCIirU0zPVKMMc79nqT5ElicxGHL3FYfkT3vUf7xw93i1tMCax5gqT+GhA8pPqV44AkzMphDdbkzqoiHUMYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iugymXtY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iugymXtY"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91574384cc2so121825185a.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780597984; x=1781202784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/LCwRdhQlgTVuDKFSQeE5uTXHnTHhiJcy4MpZmW+vo=;
        b=iugymXtYDnBSUiU7gBpK6tJkMhXuIENh7Bv+NQIrFPx/jkV1evTZ24qfDEeo8GsfIN
         Qnt4N+XVZq7zx4dgzbx4lkjd1XGcrCJ7MkwBz5mc58a7OZPcjkgTabDM4sYB53En87pH
         D8qwqgkzK4ZQVTZm/8NHpxH1m6m7ALszYwB3lEfK8eARBqHRM6BXuu1Jrxg/poVOVYwP
         B7ySyr0SM9sthImhik+plVnvrjKoovnKeBGSG5ZoO3ziEtnEh11T5JL0TmN+V391VFg8
         g5YZlA/LC2KE1cfOeGkXTX6+yGki8fI6VZ4FWhKwdzp83m9Mf2zF9cdVizRPB62V6mLr
         W1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597984; x=1781202784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/LCwRdhQlgTVuDKFSQeE5uTXHnTHhiJcy4MpZmW+vo=;
        b=KozzzulU5hTWl23C6HJDR+1ndkR+0L542IcjwdrAlsw/R/BxS5hNZ/Z1G88qjcgPVz
         Cb97Xe0l2Gc9UOh+7uePoYb5ts7ytB+9zqmgxb31O9nnZav4TwC7LZD046tc5RZcjh7V
         rHrF003n2MhA5Yz0nQvcW5bPhUvlHyK/EgYtaIv269v1PtZ7QbSQxnmRdl+t1VhcxH8Y
         mSX46SUpK+EpRgwTL7V1gw10HcIBIP5rLGjixfa6SfVc9gSbcMPUNbgn0JTo2AZCXWiQ
         G2hTSh6Nd1KcqqTbtd5LuE4OvF1Dx8Jgs+EmA46g5qqG/jjyn7K+gf67Jk4xTvRbs/Ea
         YGOg==
X-Forwarded-Encrypted: i=1; AFNElJ/e08Jl+avpFPRSvO6nv4mvfkwnZ3LwkMIfYVQWmFcQe6VNRLEulgp8vitj7Ilx7DruB9TmCHPxU60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYX4arNW/QDdJB9MI8RlQfy0k/1LnEX1iT4QVgBubhxem3Meg
	iB6ly7wvbpqqyhuq9SrKiGJk7xqImIDarK+zTdeyggwLP/9ouvdUN84IJ/gnBVRKELE6vIFdvSC
	URiIe
X-Gm-Gg: Acq92OFUd9pVJt+kqgpJFiDnRUQsErhrtYcogVd19+UmoZZ5q7gRvLfx58Q0SKN4Knf
	LVClsGS4zn49TAdbpLePO8HLsfPfpNxQqTI8kNbO5VYHc1dcLhrA8sOmpKP10zh5UYXvadVUEca
	PsvFVBI0KjP2l8IzoEXhw5iy9ae1Q9p/x/ItNvGkb3R31rt6Mkf9ZGQuZkK3uxih6wwHsLpeIDO
	vXlr3i7+2/nwU+Ck49QpnqaZeqgAj0EpPBPAzHZivElEwKRHNoAkKBuZekz9eBepPY8AA4U1lOd
	EQ1OtzeK7IW43FPihKkh31t8XOPXnDVJ+6RBuc6f3rd5jBrHkqyZT8oQrRCRRpboO84gyGYyFJd
	qdXQr2+y6Zfy/XE9wQQVn5Lv9okT3F712j+MR+Et2xN0f3thRqffY43c1wdAcWHExWexOEOdY88
	KH7gM0h6dIurNgkjgWwftpReOjdmI6FgLUI0PYqXO7KU5N6VzxGn9x/sCeU+q9IT1XC+SdPixgb
	u6WPoIZyUe/SBaf
X-Received: by 2002:a05:620a:4550:b0:915:8ff7:e4fc with SMTP id af79cd13be357-915a9d892b2mr54215985a.33.1780597984062;
        Thu, 04 Jun 2026 11:33:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a40d566sm640266785a.47.2026.06.04.11.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:33:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVCsI-00000008gLN-47oc;
	Thu, 04 Jun 2026 15:33:02 -0300
Date: Thu, 4 Jun 2026 15:33:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: fengchengwen <fengchengwen@huawei.com>, wathsala.vithanage@arm.com,
	helgaas@kernel.org, wei.huang2@amd.com, zhipingz@meta.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Message-ID: <20260604183302.GD2487554@ziepe.ca>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
 <20260601095840.3aaaa508@shazbot.org>
 <59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
 <20260602170847.75bd159d@shazbot.org>
 <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
 <20260603004524.GL2487554@ziepe.ca>
 <20260603125308.0116aa14@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603125308.0116aa14@shazbot.org>

On Wed, Jun 03, 2026 at 12:53:08PM -0600, Alex Williamson wrote:
> On Tue, 2 Jun 2026 21:45:24 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Wed, Jun 03, 2026 at 08:34:53AM +0800, fengchengwen wrote:
> > 
> > > This translation helper is required to handle varied TPH configurations,
> > > including cases where ST entries live inside device private registers
> > > instead of MSI-X or TPH capability space.  
> > 
> > I thought we agreed vfio had to block that feature in config space due
> > to security concerns? That's what enable_unsafe_tph is about, right?
> 
> Steering tags can effectively live in one of three places.  The
> architected locations are the TPH capability itself and the MSI-X
> table, where support is mutually exclusive.  However the device can
> support either of these and still enable DS mode, thus essentially
> a third location.
> 
> None of these are particularly more or less unsafe than another.  It's
> inadvisable for drivers to write to the MSI-X vector table, versus
> using the SET_IRQS uAPI, but it's not prevented anymore via mmap. 

We'd have to go back to preventing it..

> We don't provide direct write access to the TPH capability, but
> backdoors to config space are not uncommon.  

I think we can discount this, if a device exposes TPH through config
then it should keep it secure.

> I'm actually still wrestling with the question whether any of this is
> really unsafe beyond the scope of ownership of the device at all.

Well there is certainly some kind of DOS argument for calling it
unsafe, and we don't actually know what effects the TPH value even
has.

I'd be much more worried about some "smart" accelerator device doing
something impactful based on TPH than insecure config space for
example.

> > I agree in general that the presence of enable_unsafe_tph VFIO has to
> > report the per-device steering tags to userspace so it can program the
> > device specific registers, nothing else can do this.
> 
> What's the scope of "nothing else" here?  The raw ST value for a CPU is
> derived from an ACPI _DSM associated to a root port.  So if the scope
> is that the kernel needs to provide that translation, I agree, but
> where in the kernel it's provided may still require some thought.

The APIs accept a PCI device:

int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
			unsigned int cpu, u16 *tag)


IIRC the ACPI allows it to vary based on the source. Nothing else
could provide the PCI device owned by VFIO to these functions..

> We also need to consider how this incorporates Zhiping's series, where
> TPH values can be associated to a dmabuf.  Would userspace get access
> to those raw TPH values to program the initiator?  It must for DS
> support.  Therefore the interface became one of the user handling raw
> ST values and the CPU ID to ST translation became this ill-fitting
> sidecar.

Arguably yes, likely iommufd would need an API to return the ST of the
dmabuf when it maps it.

Jason
