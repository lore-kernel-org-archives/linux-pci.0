Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109C3D6494
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037373; cv=none; b=gV2n3QvP3f8m3XMh+1rJR5NvoG+1NPHICSGCeC6ulTL3ZsK7iQGLBYG1lK+n5AHIT0dMBULylQm3v184qKHvFrGme8I7b1LBy+eakpEwRt6KlyTnIao6qWFAlYmyG1lGpOQoN3lmDLfcwf45oEcaQvXyXQsMEeMEafFa9ZjFiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037373; c=relaxed/simple;
	bh=8N9ZUyumLhZPpREviRbZwKlXS861tjEA3KjPMdkQopg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR44HKnVnOfEGKGH3EMpB9xE+YX2U9OJ0Q4Tcx3gLsaX9ejiMHk2zAJMg+QSj5z4O1QsAs1uQuKlVDhuWNILlFbryGQStUoAnRGd4zLEYZ/uLVC/waSLslJgEGcKtf4zhOEC3tF9p7WqaJGGUfskzSquBfsyB8KN5E+fQOnsXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RmEhauIs; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RmEhauIs"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5062fc5d86aso64134021cf.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777037368; x=1777642168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ezbOz+DNq/Ln5lGWJ2GbxuTePwedL+fzC5CYxvFRhc=;
        b=RmEhauIsLfxW6jH629GW4pWujwRJ8y91I3dBHvLzdqkILcwvhWgkHV9du5aa6+vVqO
         4edw6N7ZtxzQcCuFOCPHC6mu8ds1UXTlT8riBOKNnhVJKVZRxHEcgzw6EpNcwdomH/Uf
         24ytX8IUXD7f788ltV5nBwvwhRhak2QMaRCTWyE8TqUrmXS4AU6gR6Uf1bmH23dAoLGn
         TXsPDTb7wBIp8bzzTj77X2xDa2nFyGKbWKaeWJ0zGxWr+IRLAUd8kZaa8NepCGwu/ybi
         Vq9lSWJbbMItZ4arPqMVuEHgdez221JWjzVK0rfarsOswm27SyGOK6TG912QD/SIftpB
         g9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037368; x=1777642168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ezbOz+DNq/Ln5lGWJ2GbxuTePwedL+fzC5CYxvFRhc=;
        b=gb2xJJGkiwpKCLG6vjQB4h2qbZg7WNttqaYMZI7Ih8t5/i/miuIXtq9Q7XQh0Obq7O
         o62v7drSpIMXd26gyJEFhIAg91y1syjiFXaqRunHnF55x0NeBInfWQHSYTb/hU1+H8Ni
         ei+nIxPdK4Suir6aGL0MsPrGR5dUvCWNMeBLiv4tpDeuOVEP+h1j1pAOn7qEJiqcz6ig
         WDOE3F0aUW0PDWJaJF7Xzn2NhINc4F9pgCboe1AJO9SLL9BJ0r1CmBVkX4dHa+3lgBDo
         K+5HVAzkCTfs77D80kyWwhxKGf8LdQS8fPC0gLMOgwgTUrMhPctTqtvWk6WPqRg5tMaS
         BUgg==
X-Forwarded-Encrypted: i=1; AFNElJ8DwHxVS5QHQ1R2E7voviROckDRSIp5M4J7xo/4FfzXab7TcnAMW2zPkYjNUjEssHsZGk6fCsO2wTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhs47NhIZkQgjW7TIr8K9ams/ei4OqrGjfbM344NGPj95xgaNp
	hNRPyO70+z7PE/vdb6qM12d354xagGBaFOd5GqcOcCaTuhe1CG1uVKiBG8oDM8PZdt0=
X-Gm-Gg: AeBDiestPBMWVx5RGOSlqkXV/3DvQcK2EbOJrLcfZCmP/4gzjJTsTehpO1u9BKB1Rem
	uaj12baOtsl1zUDPpfyOVNKQHPzpD4UT8LOPFt/g6Z7r/uc64/4DFcX/VqlqcBEj7rc/ynXxV8g
	3qHUZe9t1h48uIfQdarNNinNw1lK4lj/xuxF187+d4Xdh59FX7Nlj3CtUnkIprRbQ8mex8T/bqE
	DGQP0GPgc1FaBR7xALplhvdQ5UnBqveG038U5y1w0WiMNM79rynihoQ4TlC6OZ81EJegrJgpyBD
	iRHA8jR3CcRtLigR26zI4aqXmClA2RCZyGtm404NqEcJ+6rW59f2pF5NA3w+InAu+WEaELaxRfD
	989TlmGhjU6qydPSXf3RVt0Qrs7ZLQqiIMusg2eyP1iuQ11Cd+Bjdjvqhy9OazM69a1mDYqEe+/
	RXYLR6j8muqe6k554Atjnan1PxTYbF/QNKbXt6uAhKBpTW4MPSEDLtdTdRnJTaEA==
X-Received: by 2002:a05:622a:1f0d:b0:50f:c36a:381a with SMTP id d75a77b69052e-50fc36a3bd2mr157337571cf.55.1777037367645;
        Fri, 24 Apr 2026 06:29:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb5fc8e04sm101886121cf.13.2026.04.24.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:29:26 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:29:24 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aetvAkM0y45WAmfV@plex>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzeck45yin.fsf@kernel.org>

On 04-24 14:33, Pratyush Yadav wrote:
> Hi David,
> 
> On Thu, Apr 23 2026, David Matlack wrote:
> [...]
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c9b7b6f9828e..94af31837375 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/PCI/pci-error-recovery.rst
> >  
> > +PCI LIVE UPDATE
> > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > +M:	David Matlack <dmatlack@google.com>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Supported
> > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > +B:	https://bugzilla.kernel.org
> > +C:	irc://irc.oftc.net/linux-pci
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > +F:	drivers/pci/liveupdate.c
> > +F:	include/linux/kho/abi/pci.h
> > +
> 
> Can we please also add these files under the "LIVE UPDATE" entry. The
> code here concerns both live update and PCI. We can figure out the
> maintenance details as we go along, but I think the live update
> maintainers should at least get all the patches for PCI live update.
> 
> Perhaps also add the kexec list here? We plan to use it to maintain the
> LUO patches, and adding it will make sure we get the patches in case
> someone updates the file list here but forgets to update it in the LIVE
> UPDATE entry.

+1

These files should also be added to the Live Update entry, and the kexec
mailing list should be included.

Changes specific to Live Update should be routed through the
liveupdate/linux.git tree, while generic PCI changes should go through
pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
acks are required from the Live Update group.

Pasha
