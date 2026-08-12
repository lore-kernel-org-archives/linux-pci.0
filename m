Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4EB3CBE80
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568262; cv=none; b=E++WvpzN1nyouAzTTT17IcmOa+9MBz4RhFUtalUaqGFcuJcT9EuKGpouRbcKoEQ+wX/nONN+tyeeZN/AkpnNWaOH8/2oikDIUhMHYTO3w20kZWdZZLa0h7NAoLrWFbm8/YsCom5iZ7LVY3ZHiBCDbY45bSRBzrCxYz0ZaTup8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568262; c=relaxed/simple;
	bh=+T8rIYQMA0RYua306DzF39UQaD76cYSTxyj942vKdRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpeQeZ2NXHGqhQwCrfQmEVsL/YelFa+KO1epIl/2WlvhG67L3+PuUyOi5ZEjskos+L8H6wPZcQ03W48VeJa72dnfwuQn2TAttJ05FvQ9Dwgg7FbVCj+EJwWcGoYu6gy7gELMUhU7Bvm9GnjgoODJIqs8+f9IG5XnPt6QYxGxwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xsy+Bvq/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xsy+Bvq/"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e65e18969so27219085a.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786568260; x=1787173060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J/JxJ+OXxlnRn0rZzk42XaW0KL3+pcXSN0DjXbqxyWs=;
        b=Xsy+Bvq/yfoxGZDcg4y8N88KfDJURk/KgZU/edRTce6eI368w2HjLufoDQ4GUzw+sU
         lFwMovaf00+jqikH+OFs8y8AGF9/kcpWSZxABIkaUe+n3Y33VDXk3obMWQzr7Ezg953i
         SBOTW3/CbiTmdxZ8gTpHdcNXSncHMUnsc3H7YSiCKmgKDMr3tsnG4Wv1JYejBAJeWWXB
         oZEFhps6rr8id5HCdv7qXRSbxbHZIMxZd4LNbw74EYRIC2Xr75Lw/tCANPHr+kKb4hlf
         8njKLZjoMpalQzb9b4fvaTSnbH4WSUXPIL2qJBSB7PrqaRqHqRLEiIx5IRvjTs/5ATKG
         DIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786568260; x=1787173060;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/JxJ+OXxlnRn0rZzk42XaW0KL3+pcXSN0DjXbqxyWs=;
        b=ZmifU1YKnOKgqJ1JwBGYMZiLrhqyCL8nAlQcXuoeWqGuIOdTI4KT9ij5vvT4ftKXG9
         N5CEbKJTepJHZi6rSxp+EUgCZigyMRWhWT5J65QT/YJEf03n4xyEBvKATI3KkF7dwS3E
         1LZmyY+AfsIUOInd05jZJCuo6cDMB5/5JB+ew4I60guwyYTZMGt6w+2VDPHhIKBm4nrb
         Gv7a1Z3mEM5D+Jqe6nUCWvD5FSJaLj1iRegnU1ZTiLHoLbfRwjYUlAnERED4K7le9JLw
         kLmGBKeFP4JfSNcfWwI+cH7HuHIMJBTxE+ahz/E7pHl6OAJEcNaUDDBIbqeUKJYqmef3
         crWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzjHuTwszYO8dmPpO9CB2liNH+8INKW04abKvnP8AhH/GNLFux2fL20xvi2vX1LquOfIvmX4iHCb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSocVhxhTEHCDb23HaQnNdlxOr+HyOV65c28VlRSMH/+cIakv
	z9zmjOxL2a5l+u2OKGJCZdodYfnnhjq681jYvJBre5OLxpA//syHG1U1aNiuJvbthDE=
X-Gm-Gg: AR+sD10tEFPWL3R7NE8kSyn2yjm+Fj781tgFwCPDs9l8cBnzzbZ98rmDpbJEN9e6giG
	ypYCxvH4t5eHmbtDa4890pQ1p66rkzPCpgx5QzImNQtSsp0q3M91CgCBcZUb47aaP+Bt/vnBNvZ
	Ktm8MKGsL7SY9OSjHnRsViWP3NuAgPrvJJ8qb/L4nHwl545m8NFVsfT5w+nL7bAvXy6BZR8lR2K
	Tv18QVq0tz+2+vlc7GLuJQ7z9KLINfelZ1zrjncwsDqFjRqABVelzsHbcJ5ks9DNbQcjMEf0hhL
	mDjx1bh04w0AlfQDbf3EKKBKLycNyTjFBY8At5LHU/MYT7BQ04ipA/7D923DWdJtjs7RbJEDZvd
	XSPStvc4/bq+YgF4yzCVqzS9nJbRxeIi2chOMV+bE101pYhyEkEE1bk9iIX/WIIUffMLt4eSczw
	FKVxggMk3wRcweM5LxPHWPxWsWTdu1Jbs8mnD9Bg==
X-Received: by 2002:a05:620a:278f:b0:936:a8cd:a28a with SMTP id af79cd13be357-936c07f15f7mr50947085a.22.1786568258588;
        Wed, 12 Aug 2026 13:57:38 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c199108csm778485a.19.2026.08.12.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:57:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuG13-00000003Y59-0iGE;
	Wed, 12 Aug 2026 17:57:37 -0300
Date: Wed, 12 Aug 2026 17:57:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260812205737.GG662699@ziepe.ca>
References: <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>

On Wed, Aug 12, 2026 at 08:29:24PM +0000, Deucher, Alexander wrote:
> AMD General
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, August 5, 2026 3:11 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> > iommu@lists.linux.dev; joro@8bytes.org; linux-pci@vger.kernel.org;
> > will@kernel.org; robin.murphy@arm.com; Suthikulpanit, Suravee
> > <Suravee.Suthikulpanit@amd.com>; bhelgaas@google.com; Longia,
> > Amandeep Kaur <AmandeepKaur.Longia@amd.com>
> > Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
> > only
> >
> > On Wed, Aug 05, 2026 at 06:12:05PM +0000, Deucher, Alexander wrote:
> >
> > > > On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander wrote:
> > > >
> > > > > IIRC, they supported SME, but it wasn't usable due to other
> > > > > limitations (e.g., the requirement for identity mappings due to
> > > > > the display hw bug and the latency impact of encryption for
> > > > > displays in system memory).  Do you could effectively pick either SME or
> > displays.
> > > >
> > > > IMHO the GPU driver should fail if it cannot work because it can't
> > > > reach the IOVA space requried for SME ...
> > > >
> > > > I don't think this should be a iommu problem to deal with
> > >
> > > That means no display for the user which is a not a good user
> > > experience. Most users of systems with integrated graphics would
> > > probably prefer displays over SME.
> >
> > You said IOVA translation doesn't work at all on these devices due to a bug, so
> > what is the iommu even supposed to do? It can't select identity because the
> > device doesn't work that way and it can't select paging because it doesn't work
> > that way either.
> >
> > Or are you saying paging sort of works enough to do something half-busted?
> 
> IOVAs worked fine for everything on the GPU (gfx, video enc/dec,
> etc.) except for displays.  You could avoid the problem by limiting
> displays to carve out, but many of these platforms shipped with so
> little carve out that that it wasn't feasible to use carve out for
> displays beyond the UEFI splash screen.  That's what we did on Linux
> initially until lots of OEMs started shipping platforms with minimal
> carve out and no way to change it.

Sure, but the end result is the GPU and SME are inherently
incompatible, we can't really fix it.

What's wrong with blowing up at boot with a clear message that Linux
must have SME disabled on this HW printed to the UEFI console?

Jason
