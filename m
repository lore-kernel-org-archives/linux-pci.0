Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC353F1AB6
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288706; cv=none; b=ARfHaDjmMnvq66reA70Ro66FMnP3PoRocC07dNPAZcH9uMnCnw4s1rN3+9dRBYHQL97a4Kghl/iClZ4brwJEdACsO5eiY337z/GcHI9fCDPR0+TUisM0FviSI3GgJK5TCmGlYT4X51SRJfkQLjFlzOMzz06SzIlxx2LNRn+30Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288706; c=relaxed/simple;
	bh=FA4gZ0vHmdeVsJwZEdfiluV2UoJo+V0cIxjlbvjgR48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx3LRJeIuUtF16jhNQ95ZV39uCZLZJC4OZGSMNzEIWirCD3VNfzDWibq0OwlSCAt1JwnbJsZHARzPOXBXl+xlGlU/lMiHq+eEEyqCfYrL78lb03dBknIbtkYsGjDakCdpCg91j6n7FK/oMu4xJKwtRCle5YDAkwI7rqJpf5vt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fLI2FEb/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fLI2FEb/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-516389a9b70so54889651cf.3
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779288704; x=1779893504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz1t1QkWZCmUP77wepzR0Q4pYzk5BCD7dYEJvWGE+AY=;
        b=fLI2FEb/TmV7dYjGyMt/DSeaPpCgc2CGOWSSqUGTtinWFgNDar7hERryuw5oZGizfW
         tlFn9Sz2h6cHKy9xegurTkgCruJZmFy0EevrQTUuo5CX8rmL5dhe1WMFqikd0UCfdsGd
         //dVMeCEiSfVK4FXaX/ViO8AcS457qylpYOobiHs4Y3IefQb2Vpj7ZQNBIenEpMiEfxO
         p2FMtsuqunGrbWDhb7Oy/NMxHsn1SLNf7rB+kjx1rkVatd7i6QigZHL9vuLildS+Qgsu
         oXzLMaJSWpGtgwnVoRZgSIqP2rMs+EnC2D8bhczkDD+5RH9H/m2xEk9cR2KakQ6eEal0
         ozAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288704; x=1779893504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pz1t1QkWZCmUP77wepzR0Q4pYzk5BCD7dYEJvWGE+AY=;
        b=qBNZuIwA/Y37LYe++VBPx2jMEIMU36uXccvM8e0l8ORijmsmAWQZqZn6Cq0grdbz9l
         jTo3MVTqidytaXRcJ5wPvD8KiN7xuD6F9zsi/1azcT0gpptO3X6/GGC6BcdU+YT1teDs
         XGQTYLxGqrey6Lb4qc9y+dsl96mcbxY6WaSxPrwG8i0uro/0uGI5GIPG4k5B7KMyC/Ay
         /enB6OnM3FdukthWqwFEdPg2kPSYh2tTRaK5QK0GGHoz5f6Oxvbc9WvKDQrz4FEdNZX4
         WltBjoDNu2fZcxojegrayhk0cqvFPGYrkkqaMshtZhUI5NUciqgf6U/c6ju9YuPxA9iQ
         gkwA==
X-Forwarded-Encrypted: i=1; AFNElJ/XPllc8RzuhKwCosIzfJ5Pk+DKx5wHrAgnrwx5tPLZs+Y1HRrMRmp9o07/yQ80U0NKGXY00X9z478=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0EtSaw8cKsguTCC000w5xPiDahsUspzb4ZGdsfKUAliMpC5AN
	ALO9/JBawolEyM05GI9pH1xTrmt0kIF2MD49rkKr1K3tpOBhJXfN4Qb8oHckvqZJcykqKEcIoVm
	XVBWO
X-Gm-Gg: Acq92OHWwEW901mo16ff5ZzAs1dcMxCz/XZteTiJz6nfLUIQe7CqLQE68gDA6r5NMSN
	D7302kdCunJ2R7bfbHKK1ZDMUglJtJ/UA5Uz7AVSHz8JPFxM22p5qxA5yijprfumMzggsbdG+3z
	oZ0hkJTpgNBiVRE6Avq08SFEPkyjiQmepdtitFXT/VuKWUo/2ydj5JzLQeelzPhpOtWUvihrPrp
	ENUQg0W/yp+tHYnnus4RTvM1anIuYua197yiC8rhoTklHOHhfiCN6lKGOg6Ajj1Tb2AAXlNTiQK
	faaHA2+dTg4Z6EHMwi3NWnS/j0t+SyagFiALPGdYqrhSSHv78E0Op0ngUooN8xyS7QNZk9QXVCC
	0qJ6XwO3j1Z25DtXKOBUbGws1goy+CLNPleuEJtwEFSgJk1qGdKUtPRe9R2w4LWZhrjAn6WmYYU
	sTbEUxMF/XvYhOYcYylq2D2aVZFIS/XIuolgvlmfHt2Nwc1c1weYRvHKrDSgWyi2o+EB66kufhV
	mEnrA==
X-Received: by 2002:a05:622a:4c85:b0:50d:66b6:1564 with SMTP id d75a77b69052e-51659fe9204mr326177381cf.14.1779288703679;
        Wed, 20 May 2026 07:51:43 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456b6856sm194612161cf.7.2026.05.20.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:51:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPiGs-0000000HIHG-0eTP;
	Wed, 20 May 2026 11:51:42 -0300
Date: Wed, 20 May 2026 11:51:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260520145142.GU7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3EL10WAIImL9XR@google.com>

On Wed, May 20, 2026 at 02:24:47PM +0000, Pranjal Shrivastava wrote:

> However, I'm thinking what's the right thing to do if pci_enable_ats() 
> fails in attach_commit():
> 
> 1. Fail to attach but unmerging the invs_array entry is complicated.

Is it? We should be able to keep the the original invs and not free
it, just put the pointer back?

> 2. Move the pci_enable_ats() to attach_prepare()

IIRC ATS cannot be enabled until the invs are loaded with ATS
invalidations, hence the issue.

So you'd put the new invs list, turn on ATS, if it fails restore the
invs list back to what it was and RCU free the new one(s).

Jason
