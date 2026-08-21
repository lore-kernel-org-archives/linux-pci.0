Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC061C6FF5
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278862; cv=none; b=SrgSd+KA2xGmuNmy+2Ij7esitHu4fj9xogp1xjhceopYUTDUDnCwJhHH53oHXUb7FX86rwOiBZ/0pM7UjlYf5BADCFgAUuwwS6UUPJnafeRbtUzkhter9htodBo0uAvHVdqfhx9Qou4qxrblmG5CWbsQTbTKPcFpiVwkIpuxDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278862; c=relaxed/simple;
	bh=ODEamyaNinz8ndZY25u31wy9kg0XuQk5tLuO7i1Q1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5NL9nciIG//gfAiOe9sGNPleaKsd3RPiYoHG9mC2cqYHz12jvANETqJ+3jPds6qzg1n0uFLxlcq5ybddXi1oeeqDBr0Cm8rR4SRr8Ts43P0eJJPA9i7ue8Iud0yB9+8BrwTUY3KynkbBvy9wOqrpdryaINSc95fAQVf1VMZnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnrbBEe2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnrbBEe2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d3b445a84fso20815ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787278861; x=1787883661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vTISns22lLz3uE6OmdCyn6vQB2Si1JaLhFBQroGqygQ=;
        b=MnrbBEe2gHTV25ZX4gF0Ym6wkOXP1uUcryATFQ/+9qu9+v3yxiiHVhhujZS9iVhYeG
         h50K5uwjsmqNMP30lUy7sjnNhbPp/mwstvWO4TAsODYUbxHwqvPq/NqOFt1F5IsEFQRK
         2nCj+rtKcO0rsG6U5v2kBeDqPfGDn+9fqBLCtrN6fLphhkTx+/vnWyx/qm7zwfBvzIFK
         Pglp60ZllhKzR8KytEEROBPnmZjqEGYTjoKyZIEN9cQoARqBwAGXmEmSQMVN7M5HAz67
         EMuC2zmW+3odmR74swgDcASAeIgi2m7PKMsBHhNtqWPG5VlsZ2t69pmTjTFO1fhsQ7Fw
         Pbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787278861; x=1787883661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTISns22lLz3uE6OmdCyn6vQB2Si1JaLhFBQroGqygQ=;
        b=nNAzYRrsMj92jG7HJYNDIZcoAjm2BzIxb1u6m5l2/SLPQxEiUn9MV5mYezcWAJyeTj
         ktN9Qn+hvlzpDHNOPMV25gjN0IlvYdhXcRstD+isOZfFPned5S++d3r3xiZ+JFokl41u
         6MhAhk0Fskrkbkvl7oekSwKmGqeRsU3UQ0Vkty0c8RlAr3xf1KFYMdkbFiaLuk0p3VNI
         Thw7nfdN7g3dWiXLt9MeIyjqdUgNM45YyisXJ9BJFzPYc2eegcjCnQswy3fVegy0XZas
         maS0KcvzDC/QVjejrPMbz71hAFYSYnMrvKGBqAr6aSHCSV1ejdYyN392fRogn6dUQZ+o
         XlXA==
X-Forwarded-Encrypted: i=1; AHgh+RqAWvoJ8ZRsnRPiFJtSEHRnD35lofS2NBVRLZ0zG/U0zO2cY9ZtHVt+0wyp0UsyrO7/Ec6ErRFnte0=@vger.kernel.org
X-Gm-Message-State: AFuF++mtCZ2H2DsjxN1gK33HSwnh15TrwLjYZcsxYb4AggutHYqEaDwz
	arpkfzdA1TBXrAd4a1Dx9chWVD/Ow2/yLpPub0fTtFkJGTOrq4jKawtJR16PBlXIiA==
X-Gm-Gg: AR+sD10FsgmJiQGAGCCha4oWArWDf+AkncI5UrIN3NwAKAb7BNV5AtC9tVR6oOAXQys
	ubnW7FASfgvWVkK9awLmCISf90/hyMfhzqehNAYtA0GoZfBQ1kT7WVU0SkFiJPpCYPh/R4ilNTO
	UEdVIUQmsLWdZy8LPsulGCOrYMKyJxB01omTYAnbUZghX0iyarI862byYRwDgpRZdjkJkrVguWp
	IeHF2BClYOECQtkcaxj4vnKwF8VR/6r70pCzXlhgZZB5IP+5wXaP3Eyan7yXt2Gc4S7aGnVSZ8K
	V0CyJhwjJGhACzxGSUlaLnC290oRY1aHrVKy8yi6Eenf0dpfU3+YezY0cUXQ3jEe8mI9tdngaj1
	+38gIRXeE14jGDA2TiX5DEvyrw1K+DGjuXTiLZ1CuOSmTofvXOeuooHWhlZhCKmjQl9KgFqfv84
	DTSMMXPY2mLJDC8iiDOEZPMVa0aMtiUaViSgMTRNIIrakFgExLCbCLiAkuvJV7BYDnocBf27bkj
	zWKWl2kVPPo6oGOA4zhMOdwMuEYnKdL3eBQlPB7aU9iehRg9WwwcObzSPM=
X-Received: by 2002:a17:902:f552:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2d650dacb5cmr1955855ad.13.1787278860193;
        Thu, 20 Aug 2026 19:21:00 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4b82e5csm1054937a91.16.2026.08.20.19.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:20:59 -0700 (PDT)
Date: Fri, 21 Aug 2026 02:20:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, 
	Alex Williamson <alex.williamson@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, kvm <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <aoeffe1v--CgRK0a@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <aod22_H66eUth9av@google.com>
 <20260820233722.GA1110819@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820233722.GA1110819@ziepe.ca>

On Thu, Aug 20, 2026 at 08:37:22PM -0300, Jason Gunthorpe wrote:
>On Thu, Aug 20, 2026 at 10:38:07PM +0000, Samiullah Khawaja wrote:
>
>> > The blocking domain operation looks like it might be simplest to
>> > implement in the IOMMU core.  We can set a flag for a default blocking
>> > domain on the IOMMU group when we take_dma_ownership of the group.  Then
>> > release_dma_ownership picks the blocking rather than default domain.
>> >
>> > This is then unwound in use_default_domain, called via dma_configure,
>> > attaching the device to the default domain in probe of the next driver.
>> > Therefore until probe by another driver, a device used by vfio would
>> > remain in a blocking domain even while unused and unbound.
>>
>> The devices are expected to be attached to the default_domain even when
>> these are unbound and the use_default_domain assumes that, and it only
>> checks the ownership and doesn't switch the domain to default_domain. I
>> guess we should add a WARN in use_default_domain() if that is not true.
>> I will probably send out a patch for that separately.
>>
>> I think we can move the device back to default_domain after reset after
>> unbind, maybe it can be done in pci_dma_cleanup() based on
>> driver_managed_dma?
>
>This blocking domain stuff sounds very similar to what Nicolin
>implemented for the per-function ATS issue?

I see you are talking about this invalidation stuff:

https://lore.kernel.org/all/348c50ab6e95b5ec6d48ee3fa05d529a784a34c3.1765834788.git.nicolinc@nvidia.com/

But this was the case where the device is going to be reset and to
prevent ATS issues, we attach it to blocking domain before doing the
reset. But of course, with the PF reset here, it induces the same kind
of ATS issues on the VFs.

>
>Broadly we must setup a blocking domain in the iommu if ATS is
>available across reset or you get these ATS related issues.
>
>I think at the time he looked at doing SRIOV as well but it was
>tricky..

Hmm... doing that for SRIOV also, by allowing PF reset but attaching the
VFs to blocking domains before the PF is reset, will only resolve the
ATS issues. But the software state is still out of sync with hardware
state.
>
>Jason

Sami
