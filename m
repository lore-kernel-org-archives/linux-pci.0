Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170C372B4F;
	Thu, 30 Apr 2026 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583204; cv=none; b=DhiBl9NPww5ooOkKYGSf8VDLe3+pT2xsAnulk3ObJ2vzSEcWGzgStxNTtW7reUaYdyTJO+KdM87KvrozZuSpygh6AaJkZdEvtKbPE8DRWMJimqqoes+gNk1tG1gyTXlQ+cgQjnWXHfn6AuovdKIjxvdhzolf30ed9SUgd/5eD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583204; c=relaxed/simple;
	bh=fSFeh7LyM/VW+wkyTESwF1r98DYurH8l0qUBEQElk78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EZCcGsnvTI103uvaKb30A+ujVBLiYisr6Vw1wbxobuU+dnkC6rs95jtbTLSBNKBjvfxbnKUYko9ll98OvmS8guITzNkRS2ybWMCXO+tbGkWCKcJsaHZiDdquyLHtPWbrO4TVmOPfc4LRpF+63XwbmZrfSlGMkYhEs+coUKbPnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puQeAZOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puQeAZOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40FAC2BCB3;
	Thu, 30 Apr 2026 21:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777583204;
	bh=fSFeh7LyM/VW+wkyTESwF1r98DYurH8l0qUBEQElk78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=puQeAZObx6LcsJjZvu1WHP+8Qjize0ip9P2cmvV8hYk+1hbARQsBepTiOkBvWthHE
	 APtvhoP5m8I/E1y18V1kD/BTX+C9Pm/HjCuQycbFK5Jfpa+ZiRcj/X5jsQaWJ9yA+Z
	 gZ/MVR+TMtwrBvUy/REkOHTbIlNzOpb6jzNWtJHsZ4tT6+SSq2ep9KlR1Fsb5yi0rh
	 3mZuRSvjEI/bYoelZD7EGAAq6Dn80fISgjTt8OAIkRxPbeKMYn2JqYdjFWaqkD5+fj
	 svxk+yuFxLyw188ejvfehH9ozLGi75STutLaHibMhH6Z6IOF0uCXaxI2yaRttJVO7G
	 jOJaHcSyl23Sw==
Date: Thu, 30 Apr 2026 16:06:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, iommu@lists.linux.dev,
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
Message-ID: <20260430210642.GA439800@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afFHC6C1Qbwio4pH@google.com>

On Tue, Apr 28, 2026 at 11:47:23PM +0000, David Matlack wrote:
> On 2026-04-28 05:50 PM, Pasha Tatashin wrote:
> > On 04-27 23:59, David Matlack wrote:
> > > On 2026-04-24 01:29 PM, Pasha Tatashin wrote:
> > > > On 04-24 14:33, Pratyush Yadav wrote:
> > > > > On Thu, Apr 23 2026, David Matlack wrote:
> > > > > [...]
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index c9b7b6f9828e..94af31837375 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> > > > > >  S:	Supported
> > > > > >  F:	Documentation/PCI/pci-error-recovery.rst
> > > > > >  
> > > > > > +PCI LIVE UPDATE
> > > > > > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > > > > > +M:	David Matlack <dmatlack@google.com>
> > > > > > +L:	linux-pci@vger.kernel.org
> > > > > > +S:	Supported
> > > > > > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > > > > > +B:	https://bugzilla.kernel.org
> > > > > > +C:	irc://irc.oftc.net/linux-pci
> > > > > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > > > > +F:	drivers/pci/liveupdate.c
> > > > > > +F:	include/linux/kho/abi/pci.h
> > > > > > +
> > > > > 
> > > > > Can we please also add these files under the "LIVE UPDATE" entry. The
> > > > > code here concerns both live update and PCI.
> > > 
> > > Covering that intersection of Live Update and PCI was exactly my
> > > intention with introducing this new PCI LIVE UPDATE entry. This ensures
> > > we have maintenance coverage with knowledge of that intersection.
> > > 
> > > > > We can figure out the
> > > > > maintenance details as we go along, but I think the live update
> > > > > maintainers should at least get all the patches for PCI live update.
> ...

> > This is the way we agreed to handle kexec changes: Baoquan He is the 
> > maintainer, and without his Reviewed-by tag, we won't take changes to 
> > kexec. This is the approach we follow with MM for KHO changes to 
> > memblock and memfd preservation, as well as the upcoming 
> > hugetlb/guestmemfd preservation. 
> > 
> > This is also the approach we should continue using when adding LUO 
> > support to other components like PCI, VFIO, IOMMU, and KVM. It keeps 
> > life easier for the core component maintainers and ensures we do not 
> > regress LU by staging everything in the same tree and sending LU merge 
> > requests from a single tree.
> 
> Ok it sounds like we are aligned on keeping drivers/pci/liveupdate.c,
> include/linux/kho/abi/pci.h, and Documentation/PCI/liveupdate.rst in the
> PCI LIVE UPDATE entry and not duplicating them in the LIVE UPDATE entry.
> 
> I think the only open question is what tree to use for the PCI LIVE
> UPDATE entry, PCI tree or Live Update tree. You are proposing the Live
> Update tree.
> 
> Bjorn are you ok with that approach?

Yes, I think that makes sense, at least to start.  In early days, it
would probably be a headache to coordinate LU things across multiple
trees.
