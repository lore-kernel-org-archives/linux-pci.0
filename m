Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EEC370AF5
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577204; cv=none; b=ltRCSIrerojerwu50GYVOTMuetzVu5v0CimUDliSqKcIf9jKOn3XlD39705kEIYnaQ7LQN4hUOYHn+oVHzD5C1p06jFT2pr2MT3ubW7sjAvAsBCrAZQyAHozxgkFF5xeKvYkSN4MquB8Y7Bcqak8bAa/8KB2eJbxPVdtXmGZdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577204; c=relaxed/simple;
	bh=BO645U9ifjKXOpO1PpIkP1j+0bMM0mr+PVso/igYqk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG3h0loGjs1UcQKgZ1AQnLCXXP1MBIDRi1B7i0/Bzoj7g5+kffrIRrvu1iHM5AP+AmL+XAtDdK+SAyQSiUycqFkdQbCyTi3C/qpQ/2Ev5KP8f/H1DuaCAeb5SiTm/vCKduPJNvDpqtUXwQlDGLA69ZxkT70w5n6ZjHbS/Km6Mvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AzNmp5gz; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AzNmp5gz"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e5d6f35c1so10754485a.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786577201; x=1787182001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2kewlUKaZr/ookoJLS4qbS+ZkvabPmZz+91AhGwFzXU=;
        b=AzNmp5gzTeXsgnNaxDPAG3PZQUuJwqeO/Xy9SL2BunsXIEFGidcUIxLA0ZQhiztH3a
         oKcxPF+gqsbmSudMgrmgBZAdMvIwvz2NDfBNo92dEBIM9+33eOpZDfFVxetE0JBVAyqg
         vurEXEizyFeQoal5UyK1YUCMYOqlnfzvTCAOij7H/bOPAZezo2zNqIpNpJ0orJ+atPGg
         pfSCEyeHFp43xl/5NERJVXqBxK9dvaEu+zStuJSmFsUrPdvKbFky/k1wJhvhacaxlKi+
         UEXdzoagNpzKnQkfjdUnA8Vwyl/mk/KHsGhUaCBeD+IAYO1vpY0jivZJZzdtv0wJriPa
         QOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577201; x=1787182001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kewlUKaZr/ookoJLS4qbS+ZkvabPmZz+91AhGwFzXU=;
        b=Zbcuk6DLgSQLmc5AUgHaIqhyo4B+lPrx4x3H7SrW9t7hyzuGBP7ODOSrVqSds5QrgT
         VC6OLoUwPlSW1NRJ3zcBHq77gGVusDk2KEwwITgWyJKF4rqnESGdpZx/J+aUMCVdzug/
         NOwrIc3Ruk6PCVuADwCmYBwjxL1Yabdbt6kIpAf4yATVthd5KYZ01RrPHO69EXswHBvy
         C39So4M7PjIXjIEq7rjCLWjgYxulrj8z26wx2c5+mwyUrEl3U8SXydQj3ZU2YDsWI3sh
         kTgmi6UFllgkqhAYo6fUgAxBjYq+M7igA9QtJoPiZXdQBhEtS/dBhnU/ChNi2t6f0OWr
         eJqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/YVqHlod2a2oCpM71q0+rxEJd6Y7458YyRm6W9pW4G2pV4s5e/zvdJjcsjeHPMrdX7PL5b+jT9Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXVGFktJqEKtmEI/R5s9TL/y8VUbt7VqjG3DzojaNzLxOfPCt
	oV73ZKGW50GYQm0QUPmT0ltD2A6ZBeJ0CIfnYHdkyx4ffSdvJzDGO97M8aSg09pdPOQ=
X-Gm-Gg: AR+sD13gaON2qMGs/f4ZSDVQS9EYukH+UAv+mJxAp97RBfYlgN8ud2F2aKg/Sz3PIKk
	Ohw7nI+SyrN4smjTADpBhgjWmfxQ79XOMAAqLGuug2Dsz7pY3teR9fQ02LEYf2lDBzWIdB3QjfH
	JWqm0caIQPOL3EdWWTlb/3GSo6a335dgwufS7g5BLVg27WgY2PEoiNi7CkAYpKUeG4f3wmhnJpU
	kBMZ308nLJMMtOStaaMHZrMIQHp2hN3fLerj4Yqrw/PeU1rU0oGanPEUqStF9M4qrJBB8TXz0iG
	5OERyvZqINDZ14c7u587UCWQdX5m/y4nQj3G8dnuNq/N8d5uwMr8VkgW/Uwp2q+GXPGpbxEFddb
	u5iHUOwajHuGop4dy9et924zRk8jt0cTM8Pqcc3UgDXIhROSomTif0GB3Pg5swrSvHPTxRZiCoM
	KIZIF28WJNgnwHfbT2ZdMcJr8AMZOOEtzAKxEIRA==
X-Received: by 2002:a05:620a:444e:b0:936:bbb5:330f with SMTP id af79cd13be357-936bfade9e8mr155811785a.40.1786577201439;
        Wed, 12 Aug 2026 16:26:41 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c196980dsm21757385a.12.2026.08.12.16.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:26:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuILG-00000003ZvO-3bmz;
	Wed, 12 Aug 2026 20:26:38 -0300
Date: Wed, 12 Aug 2026 20:26:38 -0300
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
Message-ID: <20260812232638.GH662699@ziepe.ca>
References: <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812205737.GG662699@ziepe.ca>
 <BN9PR12MB5146253D30587DC820486F4FF7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB5146253D30587DC820486F4FF7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>

On Wed, Aug 12, 2026 at 09:03:58PM +0000, Deucher, Alexander wrote:
> > Sure, but the end result is the GPU and SME are inherently incompatible, we
> > can't really fix it.
> >
> > What's wrong with blowing up at boot with a clear message that Linux must
> > have SME disabled on this HW printed to the UEFI console?
> 
> It's not very user friendly, plus it would break working systems.

Huh? You've explained that SME doesn't work with these GPUs? How are
there any working systems with SME turned on already running Linux?

>  I'm not sure the average user would know what to do.  

Turn off SME in the bios? Doesn't it default to off?

>  You aren't likely to want SME in the first place on one of these
>  laptops.  Why not flip the logic and print a clear message that if
>  the user wants SME they have to explicitly enable it via the kernel
>  command line.

That seems like it would be API breaking for server users that do want
SME

Jason
