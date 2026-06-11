Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC90241C8C
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189027; cv=none; b=fjtydc8RIqOGgEIu3dqIzu0kFiFmqYHTplQb7jqLSM2OTfL7iRE7stc4GCtV75DolUOvX4InmtgZpTGKG0ukMxAoRiYOcHo5r4d1z1ze4cbZ/jIeZ4lOAtYcoCoqU92I0h/y55t5jzySDphJcKHyIp1ZTdL2zFaW8f7X53U9sAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189027; c=relaxed/simple;
	bh=4K38vLXL5pZRZWOn0eeyFNBO1MRJdl577n+tvzdGp2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXx1ZqtBcw3yjP2AFR7ee9kSH4Tj5L6kG9Xv8bdmbAPaWRRMfql4sZY36tnNrywtryx68oX1EXOAetPlrBkyzKw01c0lVUJ4V1nvcoKiu2kiJRoflMzjzLRf1JtgsPX6Kq9B2urBBEGgxgtoAAMIFychH9xx/EwXiEA9C/j3vGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVsXoakb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVsXoakb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf22c18ad3so118855ad.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781189025; x=1781793825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oU1AMkEBXQ5YpUDfzthi5AIaf2cxjNsEqaUvYJpzuY=;
        b=wVsXoakbHvw2RwntNUa8A3P/XOVs68lTzIsUKYv6Qwk3H+ltMu0GOLtTxzlhPoSbfd
         9Fn0aRuwF2fO2DCzBoKcjpSAWOE+XfuOv786olIv2tjKzWpdQ3JGM9M5wt8iJCdMba3L
         H0KzqAzaiWKWj/B2H02idIXHr16f1wuEqKS+QcwCVUPKMxBZ2CpkIpWfYOsR5r5EBoZu
         X/C5hUv0RwaMhvL20NBEZqm+53XM4CcBfu2LwH4/IrXxP9Dnf5JAnHeSl8zez8oQdWWh
         TAbkQDpf7OQsCtyZ2wEBH0exrTgN9cBfkU13MBe8yLtDbAPEvawbsknFS3TP0nYROCdd
         nuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189025; x=1781793825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oU1AMkEBXQ5YpUDfzthi5AIaf2cxjNsEqaUvYJpzuY=;
        b=U1uYNTcLcszOEqQSdGGGx+cXsEPyuWFeNJ2oKCLGX4qWhYWKOVHl1Y996u5kmarH41
         KuTmxsQ9JCBcQpLCNaw1fPJ2e/bizorf8hEnefX+MMut3RMGweH8OJnTHvTIzqkTarGf
         RRe1ZF5yvNmjqJk9ZqSwHpsHRHN9aElwxIPFlnfijlFn1gnb3TysXUhbZ12Umyzku6jR
         v2NxdJWaUGI46LAIUJgc3hrq6catMcoJMsb6mavNZwEZ81MjexDO2j60q4ifzemg6yQk
         s7Yd5csxn4cRGjnkix4hd3Nsx044PAML2yVfId2PC7AoVs0HwdWPZN5bitBWBcMHa1JC
         hCgA==
X-Gm-Message-State: AOJu0YzU2bek+6OQiys0iBSDe73UyylWx/cL/UU8iHiFsEHUTstZfLr0
	YF9jUd/XUnc1P5dpwoaNDcIh/+tGgtSWkE0CTNPigU1tJcMK4PxbAkcjfOnXqTgfOQ==
X-Gm-Gg: Acq92OE/Sb0mbZHfJxE+vIqqYA1HFHI6Z0ShfyrZqCZQR1t8nOXddno1eiOxY+vKAK6
	h3aaE+2c/ja6clllE7Y9+zBkMw6eXLj+2cr4/aG+HuQIr+Q9xBeatl30unYBCGz8pMQSHMXJ/dp
	iy9ULmG2e62xHHFoYdDy/DYw47umcOoyzoJ+MN3rHzr0vU7e3bXOKkpd4+QIoQdy7+ZrH3jD20X
	xo7tC/mC95NZGYBODGYOtGtlzusLLK4es0OgcJqe31m/EvyN4xWGGVPuH2ohkjzX6JiaKZMYwWG
	RaItGWrvRzL6iAp0HyLitt6jAhw+pjTaxL8wuywuW8Po90XeJnXfal2gWWzoCi87xZSTYQAkfoa
	PCCU7WdUWLEj/1btwrToM6lCgnsTONpivJ4XkE8hFTNNeBmMGkKWz+23m/gA4l0NTwmQQYD/G4U
	n5b0Dia/nEnrdi/p8ltJOUKwuDTKsSRhEL0V8GgKtTJmO9tAgLShkRjoVGHzPzdwcL+6PSL2A=
X-Received: by 2002:a17:902:fb07:b0:2c1:ee6e:4e4f with SMTP id d9443c01a7336-2c2dff6a622mr1185485ad.32.1781189024806;
        Thu, 11 Jun 2026 07:43:44 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bbbfacsm2163232b3a.20.2026.06.11.07.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:43:44 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:43:38 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shivaji Kant <shivajikant@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <airJmkSQoAXao89K@google.com>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
 <airI0VIb563jHTcy@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airI0VIb563jHTcy@google.com>

On Thu, Jun 11, 2026 at 02:40:17PM +0000, Pranjal Shrivastava wrote:
> On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
> > 

[...]
 
> > > An alternative implementation has been explored which integrates with the
> > > ongoing VFIO DMABUF-mmap refactor [1]. In that approach, rather than
> > > registering a BAR as a system-wide P2P provider, VFIO optionally
> > > allocates ZONE_DEVICE pages only for specifically exported DMABUFs via a
> > > new VFIO_DMA_BUF_FLAG_ALLOC_STRUCT_PAGES flag.
> > 
> > That's probably more sensible but you can't have a DMABUF mmap
> > actually install non-special memory. The native vfio mmap still can,
> > but not mmap on the dmabuf fd. That's still workable, just keep in
> > mind.
> 
> Ack. I guess, we could have a separate mmap path in case of BARs that are
> struct page backed which doesn't go through the dmabuf exporter.
> 
> That said, we don't mind moving away from the old API if VFIO mmap can
> support this, we don't mind open-coding with devmem_remap_pages.

Minor correction, I meant: devm_memremap_pages 

Thanks,
Praan
