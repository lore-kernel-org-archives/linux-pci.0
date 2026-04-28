Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE338BF9A
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420052; cv=none; b=jvCy8JShjz0Vh5uywhS6MFjFV21CM15/a5vWjTlptEIfZzZjqfFDz8WEWrjfmuU/H96oylAiV0DkgISJnhqsSDr5Evj5nQ3a7o5H90m3ygXLc3E5uzOU6Ewy04MZy+gY2D8569etYyxw9gDgEn/tXSjBeNTyHaJE+i6+9qTaVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420052; c=relaxed/simple;
	bh=oZv/inceMwaKLWNaXYQI3akHygkXQqc0/nr+tIR7BEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9nLl7ZLlhM9XTsxrmec8H5VYuaah1fqI9PXL9Dv/7RLVlpMU/ZWemUwIjtcEnLVz5nu0pVwVZ43SRsc4X0l8ItPqjnsXkLqHWZhO4c3wfH+7tRLGHodIqBCMIe9Yuw6zJFecVE3iNiFBUX4INNs0s3cNO2x2n0Fy05h1Ymg5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guptNxEn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guptNxEn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso8132456a91.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777420048; x=1778024848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpaL2C2UFwZgckez6PzSxOJ2+MS43lyhGR+45AYtYTo=;
        b=guptNxEnuVqRVcBEH8yVnH2nzhVloszzN7DtR7l2DInGibU6kgyefWP11YXJnx0KG1
         Qq6c66jkzODRm7YanpL4df8jksSFRTYpS7/II6r9pRz7KMcUxmvUziqoHuYxPHC2enEw
         7g6kwP7GimAEPRPK8d/8cyH5e71d9eaqUeeqbH2GS2qvWodeCF07Cg7GhlkFBXFC1Khr
         W6Yxxd4ktYTkcQpyHcGNfj2yvEEB5+MumdiycreJKrlcDwP1yDNlD9oPHKrpHemhQd7W
         2cwHC5MPFAop9iaCQzlW9iVx5tIBNKtogXH+ttJ0ftTD/Y1z9ceAGKfTxspTz7TTk/3y
         IanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777420048; x=1778024848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpaL2C2UFwZgckez6PzSxOJ2+MS43lyhGR+45AYtYTo=;
        b=W9X2a1OYH1mxg2+xCsJNeZ8j8uQjLUFtWoHLKM2ptncCnVgc8C9qiyJscRMlu1K8JP
         J2Uf4V3EY19In0gSPOtvAWLVFZn2QuyQE01tWIbVX8EOMEeeBQ3Yr3Y9G+yObX627y8e
         0SbrIZ+vwrStlmM43K08vblVQkyrsgLXOUG+mJOVnMmEWcuct+eZuEVm2OmbnWfFOzrK
         sbEp89mgmR4lLQZ8oqMXf5RaT1+qyrlP4Zxodmy9a2a+xZiWKSPcfw8JMCTLpsyDw4uQ
         QsIQbkw+SRslGc+NVSx5yk8S6DENuvke1AqK+Ho0PbTbY8gBLJ+psMduLz1c0I8P+nCq
         mWag==
X-Forwarded-Encrypted: i=1; AFNElJ/43f0QmAtVMTjNv5UuY73FqnSNGgU5c2+0qv14D6OyvNL51ESRRqlGA0aRlpIcAfxYISrb8BgvHH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLAQ2w6Xc0E0iSTHPyH2xxEvYjGmMcjoxkqG70rJnf+c2sBoI
	/eF36pq0+B3rW7JZEWD/COVFeHVEfSPaWpwMzvE/BlO7V51wkIpTdGjkihhg9YVT8g==
X-Gm-Gg: AeBDieuBO9rDobXJXLE7KiMvF5iyJWxYyeQJO3lhA5hgC5IyjnHo3z0p3TN31za1ss4
	ETUshIHWVGzkorQ7ttyANo8UjYTHyC8roFvuK0TrxFvrQu86s5jPx51lJnLDwZsb9oN0dtLEMNT
	e1Z/e+3p0HDs5qlAhqkN2yNtGHh+im2xnHN9I7dagXmc3zxPQ4lgEEZ6q+j0OHhFFuALQiJfVbi
	7iPAx40gKgeqPtyg+u040zIBI1CsoUDQi26JCr6ysI6r7HgJI6Zj8zZMo1Eo/ogGsIIqnCZAUGw
	+GBE1QBd0FZ+3ZJSEFIU/g/V6UCS82RjRmUxcIYxDOXqkzvZBNBTWdJ+C/l6mnQqrwg48SVVkEA
	jLHPu8n1vzWPXFDcXjAuJioQne472GsoKA5DsXKRGJFDWjnZxfMHWuPMzrX83e1Bgy0LHDhdUZw
	pulRkxxgfoS3l8rurTpV54O3z9QMG2tkr+RQrcMgf9pAk8m918g2zhKlb0kvQ2jL02M3KpPthW8
	s/8MA==
X-Received: by 2002:a05:6a20:a120:b0:3a2:bd1d:d68c with SMTP id adf61e73a8af0-3a3af60f200mr1710132637.50.1777420047985;
        Tue, 28 Apr 2026 16:47:27 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd64f09fdsm178148a12.17.2026.04.28.16.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:47:27 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:47:23 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <afFHC6C1Qbwio4pH@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
 <aetvAkM0y45WAmfV@plex>
 <ae_4fg_18Rli2_Nt@google.com>
 <afDroRNDr9ttY4O9@plex>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDroRNDr9ttY4O9@plex>

On 2026-04-28 05:50 PM, Pasha Tatashin wrote:
> On 04-27 23:59, David Matlack wrote:
> > On 2026-04-24 01:29 PM, Pasha Tatashin wrote:
> > > On 04-24 14:33, Pratyush Yadav wrote:
> > > > Hi David,
> > > > 
> > > > On Thu, Apr 23 2026, David Matlack wrote:
> > > > [...]
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index c9b7b6f9828e..94af31837375 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> > > > >  S:	Supported
> > > > >  F:	Documentation/PCI/pci-error-recovery.rst
> > > > >  
> > > > > +PCI LIVE UPDATE
> > > > > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > > > > +M:	David Matlack <dmatlack@google.com>
> > > > > +L:	linux-pci@vger.kernel.org
> > > > > +S:	Supported
> > > > > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > > > > +B:	https://bugzilla.kernel.org
> > > > > +C:	irc://irc.oftc.net/linux-pci
> > > > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > > > +F:	drivers/pci/liveupdate.c
> > > > > +F:	include/linux/kho/abi/pci.h
> > > > > +
> > > > 
> > > > Can we please also add these files under the "LIVE UPDATE" entry. The
> > > > code here concerns both live update and PCI.
> > 
> > Covering that intersection of Live Update and PCI was exactly my
> > intention with introducing this new PCI LIVE UPDATE entry. This ensures
> > we have maintenance coverage with knowledge of that intersection.
> > 
> > > > We can figure out the
> > > > maintenance details as we go along, but I think the live update
> > > > maintainers should at least get all the patches for PCI live update.
> > 
> > Would adding kexec@ here be sufficient or do you want to be CC'd
> > directly?
> > 
> > If you want to be CC'd directly do you think makes more sense to add the
> > Live Update maintainers as Reviewers under PCI LIVE UPDATE, or add
> > drivers/pci/liveupdate.c under LIVE UPDATE?
> > 
> > > > 
> > > > Perhaps also add the kexec list here? We plan to use it to maintain the
> > > > LUO patches, and adding it will make sure we get the patches in case
> > > > someone updates the file list here but forgets to update it in the LIVE
> > > > UPDATE entry.
> > > 
> > > +1
> > > 
> > > These files should also be added to the Live Update entry, and the kexec
> > > mailing list should be included.
> > > 
> > > Changes specific to Live Update should be routed through the
> > > liveupdate/linux.git tree, while generic PCI changes should go through
> > > pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
> > > acks are required from the Live Update group.
> > 
> > Do you want to merge changes to drivers/pci/liveupdate.c through the
> > live update tree or PCI tree? We should probably decide now. I was
> > assuming the PCI tree since its part of PCI core.
> > 
> > As we project this out there are going to be users of the Live Update
> > API across different parts of the kernel: PCI core, IOMMU core, IOMMU
> > drivers, VFIO core, VFIO PCI drivers, and KVM. I don't think it will
> > scale to take all that code through the live update tree.
> 
> All Live-Update-specific changes should go through the liveupdate tree. 
> The liveupdate tree is the only Linux tree that will cover full Live 
> Update regression testing, and it contains reviewers and maintainers who 
> know the details of the Live Update process, its lifecycle, and its 
> requirements.
> 
> The request we are hearing from other subsystem maintainers is that they 
> want to make sure Live Update is isolated enough not to make their lives 
> harder. This means reducing the number of conflicts, the maintenance 
> burden, and testing responsibilities.
> 
> Therefore, the "PCI LIVE UPDATE" entry should specify you as a 
> maintainer, "kexec@lists.infradead.org" as the list to which all LU 
> changes should be CC'd, and "liveupdate/linux.git" as the git tree 
> against which changes should be applied.
> 
> It should also include "linux-pci@vger.kernel.org" so the PCI 
> maintainers are CC'd. In case there are larger changes that touch core 
> PCI and liveupdate.c/abi, we can ACK them, ensuring we are aware of 
> incoming conflicts during the current or next merge cycle.
> 
> It should also specify the members of LU group so we can stage the 
> changes.

Sorry what does this mean specifically?

> This is the way we agreed to handle kexec changes: Baoquan He is the 
> maintainer, and without his Reviewed-by tag, we won't take changes to 
> kexec. This is the approach we follow with MM for KHO changes to 
> memblock and memfd preservation, as well as the upcoming 
> hugetlb/guestmemfd preservation. 
> 
> This is also the approach we should continue using when adding LUO 
> support to other components like PCI, VFIO, IOMMU, and KVM. It keeps 
> life easier for the core component maintainers and ensures we do not 
> regress LU by staging everything in the same tree and sending LU merge 
> requests from a single tree.

Ok it sounds like we are aligned on keeping drivers/pci/liveupdate.c,
include/linux/kho/abi/pci.h, and Documentation/PCI/liveupdate.rst in the
PCI LIVE UPDATE entry and not duplicating them in the LIVE UPDATE entry.

I think the only open question is what tree to use for the PCI LIVE
UPDATE entry, PCI tree or Live Update tree. You are proposing the Live
Update tree.

Bjorn are you ok with that approach?
