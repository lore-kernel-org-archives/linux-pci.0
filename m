Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863FA477E43
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573524; cv=none; b=u6HErOeF7K2jbRClUNv9fd2EKuPG7wigvL8dkngax3H+gU7PotTfFE6EfPQcDikDmHWfetMTiSp15/gH294NRLYBKOdipJPrNHjk1OiA0k7ifiBDFoUcUa1D0d0w3oXFgg2EdsJCcndGhw17phzr7EDFaC0wKzWs7r0V0vd71hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573524; c=relaxed/simple;
	bh=ZDryYlw3wmD6yJlXYdxSZE6y0ltm6/Y3efuvn9gp+xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HITNwTbZMnkqIGli4YZcmN5GDoQIKMxo2f0m56TaIdoqHmx3R4oLpiYz8xAn5f2jGzF0SNBMlxTMFBGZcH8bN/yhTZ9hs3wVrDsQnnhc7DO3hT10ADxRxsuYMu+NLFXdg8LijArbdLadsFTSx9jsGUJzOqF16bsFuSLCiJUoZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afjNWeYQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afjNWeYQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b46da8c48eso18925ad.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777573523; x=1778178323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSG/yM4Jbprzjr8hlewRTOp1V59hFoclV98ulyGviIc=;
        b=afjNWeYQu3LjCB32c7/96seA2fhq+Hi/Gyx5Xo1Hn+5XdT+7fACUbM1U3JPRZI7Hv0
         B7d6l9zps71Td/cArkdTNfZDMGVlh3Q4P/F2EunfOh78fy00NzbvdcJqT+n23a53SQAN
         n0oxsLXLEolhORpq6+/hBkEOGGf0TQjlW4KaWiaDocTn2foXvMGZ6H7vURYiroktyLPH
         ICgYU0msHUqQoTmeC9sPrps0Yio3A+tr8nNI5CCNGR5X9+dsInhnNAztPZAG9odzOuOE
         5Md0UJ7KzuKRtkrBHzO0nFP7P3035zEZWwhm4ryQ8OK0kcH/rbooDXZXRNgBhIYaT/va
         OlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573523; x=1778178323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSG/yM4Jbprzjr8hlewRTOp1V59hFoclV98ulyGviIc=;
        b=BPHaIfl/dImGu85Q2Rid7mkkHKoITNliPmdIE7fkRIjaCCqerKqDN7v5MQk0a+iNa4
         6sR7BbFQ2ZRLHNSwo7BgWpWIeU2a9TYcRWPmYRIJA7HLLFz3e7oQgxIYLb+aKgsg9T9V
         NPswAJSshReB90eZn6J1QumOWRD1JtfemBOXH6Vi4z0Ld5/RShVHoBovvHY8css4jzdj
         Uhe8Sp3haW+MNAU6H1bKAh1CKZyijvMSx9+avJeAgNzXIjhPMcOy+q+OLepNabTqFPtJ
         6TUrmiGMnCRUAWl490LfI1rxFfg5G5ZEv0pWl9Ur8cpD5sx+Z8QRdozW8hPB05/QnDib
         hHnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zzBQfMAD04+y1uVRF1S6mPV+J/dTX2jNCn3Yyf6M9HEZ9Iwcxm8En366AZ75etWegRDXDDgd95Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPVZ+izxJaU7TbsBbyp2cr4jQW+lyOO6GYC0ZPpovpZ3Lu2Ve
	Wca43zg8ipn8Rfao+dWe0kuAiIrVZev+xhLSAxGBtQYsDKwdUZCB9HwbIlzt3Ak3bQ==
X-Gm-Gg: AeBDieuczSvtPxHbcD+Vy0GzLmuk4BqJpQfNv7XaqY8rcl3W81VLGscC3UWe8+pPsVH
	MqOSCY4/lx8LS5InapY7kaSCpOX1VuTZKrQ8jlLxWtyI8Jc43XzKuhywNNbqC892uGKqEIyMqJU
	vh93QzsmfajN08KJAjAhx6TxmVOIVfPlspuPRwWTgyeqEsKE47d5a2+tSARMK7rMgSvX/NCQKBy
	J4Wd9RTj2pSSup9q+xWXVdiwhzUTCcy6/IgFTbByI61pUH/2am7RkycqdR4xH31SGHk7+6lm2af
	w70LrYbvvsQjJHDyLYTxDqmEch/mUS6FwMZZRWMY4scxJEBLgl0VMJMwdx79GhPOGhWuninzNfZ
	xyZDhlIlu4IzgurEn1q00NiVzVx0EEfouOe5/sCN7XLulOSHidf9mxrPWBznXRcgIk8mb/PT2rz
	KLKzBTTpALu1L9ON+QHGFlQkYprFX/qDfW07RoxZqNpBix1uVs1kpp2pYHtU9thqoDGOBa4sVqt
	tCdzRE=
X-Received: by 2002:a17:903:2a8f:b0:2b4:6153:e541 with SMTP id d9443c01a7336-2b9ce26a5dcmr69445ad.3.1777573521791;
        Thu, 30 Apr 2026 11:25:21 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbcaa477sm278266a12.31.2026.04.30.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:25:21 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:25:16 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260430175916.GA13902.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>

On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > +{
> > > +     struct pci_ser *ser;
> > > +     int i, ret;
> > > +
> > > +     guard(mutex)(&pci_flb_outgoing_lock);
> > > +
> > > +     ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (!ser)
> > > +             return -ENOENT;
> > > +
> > > +     if (dev->is_virtfn)
> > > +             return -EINVAL;
> > > +
> > > +     if (dev->liveupdate_outgoing)
> > > +             return -EBUSY;
> > > +
> > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > +             return -ENOSPC;
> > > +
> > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > +             /*
> > > +              * Start searching at index ser->nr_devices. This should result
> > > +              * in a constant time search under expected conditions (devices
> > > +              * are not getting unpreserved).
> > > +              */
> > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > +
> > > +             if (dev_ser->refcount)
> > > +                     continue;
> > > +
> > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > +             ser->nr_devices++;
> > > +
> > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > +             dev_ser->bdf = pci_dev_id(dev);
> > > +             dev_ser->refcount = 1;
> > > +
> > > +             dev->liveupdate_outgoing = dev_ser;
> > > +             return 0;
> > > +     }
> > > +
> > > +     return -ENOSPC;
> >
> > Since it is executing under a mutex, and we already failed
> > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > here and return -ENOSPC?
> 
> Yeah I wouldn't expect to ever reach here.

Will you be removing it or want to keep it just in case scenario?

> 
> > > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > > index 5c0e92588c00..5b4c8d9e462c 100644
> > > --- a/include/linux/kho/abi/pci.h
> > > +++ b/include/linux/kho/abi/pci.h
> > > @@ -23,19 +23,20 @@
> > >   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
> > >   */
> > >
> > > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
> >
> > Just curious, why did we change the version here?
> 
> Because a field in struct pci_dev_ser changed.
> 
> > It's not like just
> > previous patch is working enough to perform a live update. As the config
> > is experimental, can't we just keep it PCI-v1 for the whole series?
> 
> What is the benefit of keeping "pci-v1"?
>

I don't see any benefit in keeping v1 or changing to v2 as well.

My reasoning is that before this series is merged, there is no real need
for versioning here. This is first series which is introducing PCI
liveupdate. It is not gonna be that someone has merged patch 1 only, run
its kernel and then kexec to next kernel which has patch 2.

> I think it makes sense to follow the rule we set which is to update
> the compatibility string in any commit that changes the ABI.

Okay, this is also fine.

