Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8B308F1D
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334410; cv=none; b=EablX2VUkR8K+ZGeHHMek8TdHpEgdtBbixrRi7bJq6TgJJ73bpr48iJYvGTYfyTLLMSJjsjT4/nhdUY6VUoZTxoZXy95ibrH4+P7/iZUuPvODoiXVFMwUXlswzECeh5zjiJeQ8aNULt8BwYQuaFFgxPf0zqC/molF7un282KvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334410; c=relaxed/simple;
	bh=D5Po78dEqgLiBX+e8ZeJ6Ti1UiQKA53NB1AL+0u7frw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJAmzqWMfHh2I8FniUbuapIm9YbeoNOa1VFzJkwli/xL46keWfDnnZ1QXiuwoSt4MJfRw2hJBQP/vCNR51ksUKacIc/nA3eEV19FsypoumBIflI9ntwO09+DmmUSMRekFcO299rmBFORnoiCT+xGTQQ8JCyyvYI6888YmhAyhSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9mNislZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9mNislZ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so4837799b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777334409; x=1777939209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tW+6Pw0a8+ahYm3oOFUJTtBa/jkSN4mmIAQkMqykSWk=;
        b=D9mNislZ1nd1MOwB0EFrABCTyP8+H7dP27gYWXe4a17R7768tHXu3Bvdx/wAU8nu3c
         bzgAs2z+SmB1mDdm9ar6bNfwcH9VD7cwKkBzfKUyHEeUbHUDcPTgmvSzv98nIHiUem70
         BoJ3iQN30e9oQzT9HySxGjwiqASdwzSAH+7k8o85o0BHvJQLmGIXjICavwYY/wK0RAdF
         4z1U/qlTcGkl10H+f3CFTVFamdygorvoekV8pjdSkqEZQ696NnJtl8rlfiT+ZDRQDxBo
         Tuzw8ZjSC9OenaA/6xzgAlQRbHM//2oo9VGM0BoonDgOv0gmvXpwTXatKMvl/b8S+59N
         XDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777334409; x=1777939209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW+6Pw0a8+ahYm3oOFUJTtBa/jkSN4mmIAQkMqykSWk=;
        b=n+Tuf7ZaOCZ711CmGiK+StWi0Eoh7jNdenTZkeOkA06gklOGdRycPAo/a1N61jY+u/
         KZo9NC5agq9lZzFSV9Mo12yLccO6VMFwp1HWLnda/7vOr4PVOkUILoWi5fAgmjv/GBDu
         hmraWAY1O/u3RPAUmLupQyssJnRNkNb0tE7rzJfeqdMyYtJVvRWJPML2IyTHKU+MAGRI
         QlnfBGN84mlbH/Cs28XqUDpS+j34eu724hq2VAFalMpTv2KVqctZ91LgYdsnQIznAeL9
         EODnyJR+mzEAPFFYY2AiBZX6CsvlksnO6xd5MwafVCawKRxe45I+ouYSvw4BjpLhI5Bg
         /Tug==
X-Forwarded-Encrypted: i=1; AFNElJ+kjWM1GlrXyuKbYMEOpmA+3y6Ir8axl+KN5UNk4lDSw6R2d/GmRdHZlzNWC0VwGviBXMhw788//yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGQkrhSd69AtxO6SnlFNrgsiZ53Ry0EU2NLK8GUN+M8Gx+H6V
	WsgimXPN6Bnmg+qHT+RLCek+w9Kn07m48mlH2PH7paY8Ylmsb6p9YV0qXQX9GxI9xA==
X-Gm-Gg: AeBDieuFB+UHFH94rOwrVNhI8W6WLmdyTdZtMcLh2O4bhHkZcCCwypC+9IxbJW2Lr5d
	lKQw60PQje/rUtqfJL+srS4CL4O40E3iVe6YmityNfh5bZ/hQ4mPG9sRF57JSOtVyrh8JBb881d
	358GMOX62DjoTlRpY1eMcmlo3/jK2vWDNzsBGjT+DM6NVLrLJAs8L0hYKYv3jmym0xv7pcHKu5W
	qJOQJMDvhIxt5/KC/84kOJY16QTHVGVzZ34+Pigk4X12Og1RPegsdAud9g1F+xcPvOt2l9sSx5b
	s4vvs2Jo+FdyKoh7q/Ad2a9xKoMVW7cfOxsFzy44CXvsPZDJOlwhxcDOnH+4XNN5qvQuiI4QcP/
	1Zof+BygkCL0Lrha/fScuSByFE5i/sBu1I6ItokayxtAIT30MI9gTE0WBsKpvm/RhqNfQNojXbB
	oqWRuzrFiuZK2awdWTP86GNMYhiHp0Muf64Nw3oSUng2XjLlf1Ar6HaTlZg0J+93PtVYJDjI8so
	aYCoA==
X-Received: by 2002:a05:6a00:1885:b0:82f:1d38:f68d with SMTP id d2e1a72fcca58-834ddc22f16mr638227b3a.34.1777334403001;
        Mon, 27 Apr 2026 17:00:03 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf7f43bsm633995b3a.58.2026.04.27.17.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 17:00:01 -0700 (PDT)
Date: Mon, 27 Apr 2026 23:59:58 +0000
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
Message-ID: <ae_4fg_18Rli2_Nt@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
 <aetvAkM0y45WAmfV@plex>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aetvAkM0y45WAmfV@plex>

On 2026-04-24 01:29 PM, Pasha Tatashin wrote:
> On 04-24 14:33, Pratyush Yadav wrote:
> > Hi David,
> > 
> > On Thu, Apr 23 2026, David Matlack wrote:
> > [...]
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index c9b7b6f9828e..94af31837375 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> > >  S:	Supported
> > >  F:	Documentation/PCI/pci-error-recovery.rst
> > >  
> > > +PCI LIVE UPDATE
> > > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > > +M:	David Matlack <dmatlack@google.com>
> > > +L:	linux-pci@vger.kernel.org
> > > +S:	Supported
> > > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > > +B:	https://bugzilla.kernel.org
> > > +C:	irc://irc.oftc.net/linux-pci
> > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > +F:	drivers/pci/liveupdate.c
> > > +F:	include/linux/kho/abi/pci.h
> > > +
> > 
> > Can we please also add these files under the "LIVE UPDATE" entry. The
> > code here concerns both live update and PCI.

Covering that intersection of Live Update and PCI was exactly my
intention with introducing this new PCI LIVE UPDATE entry. This ensures
we have maintenance coverage with knowledge of that intersection.

> > We can figure out the
> > maintenance details as we go along, but I think the live update
> > maintainers should at least get all the patches for PCI live update.

Would adding kexec@ here be sufficient or do you want to be CC'd
directly?

If you want to be CC'd directly do you think makes more sense to add the
Live Update maintainers as Reviewers under PCI LIVE UPDATE, or add
drivers/pci/liveupdate.c under LIVE UPDATE?

> > 
> > Perhaps also add the kexec list here? We plan to use it to maintain the
> > LUO patches, and adding it will make sure we get the patches in case
> > someone updates the file list here but forgets to update it in the LIVE
> > UPDATE entry.
> 
> +1
> 
> These files should also be added to the Live Update entry, and the kexec
> mailing list should be included.
> 
> Changes specific to Live Update should be routed through the
> liveupdate/linux.git tree, while generic PCI changes should go through
> pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
> acks are required from the Live Update group.

Do you want to merge changes to drivers/pci/liveupdate.c through the
live update tree or PCI tree? We should probably decide now. I was
assuming the PCI tree since its part of PCI core.

As we project this out there are going to be users of the Live Update
API across different parts of the kernel: PCI core, IOMMU core, IOMMU
drivers, VFIO core, VFIO PCI drivers, and KVM. I don't think it will
scale to take all that code through the live update tree.
