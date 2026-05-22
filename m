Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DC175A72
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466452; cv=none; b=sKik0z7W2pYCRigCuLyOJpY86rHK8EYEqACxH3W2ffH2hzJK+mPU4scBzaTQ77XIKhEafLTrPBfHNKUBtgKgBLIjITnu3DB8CoXwz5Z9Tho5hSxrzT4GaFcBBDTeu3D5Zhq2xrn6Uv+0oYs9xToDCnIOjyQF4RC9mU5MXcNo9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466452; c=relaxed/simple;
	bh=QsZ2biNFsqwFiV9jdFAUogBn9H5YKkXmS0NpOnvA0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF46AmpIG4tc9+i3UtsMDbxY4/Z1mBAwSI/ufDGPYsYkv48hzfa0T0Ioge4T09Hi8r3C9yoZZYwouAtU9YDpaSNkBhaD9Y6YxPH/y7yMFDHqD5rnTbqkaU5LddMC4p/I177Dl7KZjV5luuDjG2OQE58BDdRL+77WOnjILcpqVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWnkGTtJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWnkGTtJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so2285ad.0
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779466449; x=1780071249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx+dP+hmSAXKr5MZgKel2k2lDy4SUxKpYpFDbZZsZBU=;
        b=lWnkGTtJlYKyR1Aqod42hbQnfs8w0dkniMdfVUs56p6LbEdWlWXupUSqaTyP9Nq/e4
         Hd8HuJVAlyd97kppFhYkVQbJXOJDznua/+tuBZ3FRrfsCVcBZumqhtL3N2eHcCD0IswC
         Wp+MMap8pDhSVmUnnair7ofu5pmWjUpiHGxgvwOLmHVJZD55nzUKTAdqp49gOaPevlXn
         AwgosdnONicGXdCicqgiagz736S9DHLhlGao70vrKhVTEvUvDwIUO/k8L9zak1Sljpfu
         bva/sNsweWzne85ROCv0STsJFOisReQum3n5Te3Gv1pSqh4+prDV28imKgXfPngJKf1w
         zdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466449; x=1780071249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx+dP+hmSAXKr5MZgKel2k2lDy4SUxKpYpFDbZZsZBU=;
        b=UuVXZ+oWhk6xdLYlbRRiY23NRepHFU9qR9nILa2TPNq3AeFCmHBvFRU8ZHweySlAYj
         A9/kUyMLyTqwlygQhLYMXVrVe66kkg7wRqHLC5ewr3c295jkAAOsBniUkA9yp3rbHwqv
         ol+ZLTxccg+us7fkx4/2otn/SUNaOvR7OMk5/+Zh0GcMx9fTd/0kNO6VKq/lYqIR00TF
         Wi35rvy1Irnw7ZsHckExeND5pO2REM9oZirmlYf31VhnFI43LvUnOdpOGHZYHbP70MsY
         PFrrBor1UNtTiPr+pFrpLyKGy15/RFLGuCIICxre5nApHJsMPn51wMFJTCxrcdSsDGCK
         LJOA==
X-Forwarded-Encrypted: i=1; AFNElJ98JDV61ykZIt5wxK/zqcoRj/vZaY2ogPcXakWF4u6tPt1eadDvTxWlwPJDIa4gbe/2wBndHCeSnZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kFbJ49HEI3bt7L1Qg3HQZ63cvKvORsl6aqA8bBNHOk6jhxoC
	QbPbSZs+5nkJChZmqtGr0wdZgVYLB7ag0AJyZHJ4zKZ40X2TPlHU7H4WhysWGHSwxQ==
X-Gm-Gg: Acq92OGiciFKgHEIPzWN1hgvRr3tMZAQK07g2Xc3JSKkBxaSdVL0TcMdM2DYXFkIE+3
	P8JPyZWWzxE/T1fxCbnb/Rq9ECb+4Kekv8iM31WsLkx1vaAW/Qj4KzZCugkXLjS7nT10gu1QqD1
	jMQgMlf1q5Vl7CZxpyvEfoBfvxdMqv+pQFMwV55NQ2aTUZ9QXZDeIZsDU9fHLw2+djRwrMudGak
	sJcIVSp1HJN/90U9XTWOpW4ksu8j4RcGrvJ6IxpgnrRABRf97x6aPkBsju1f2Hgz8auiUmaD3/p
	3WUTDNbuee9691TpkZ1i+PiAT4qXOxUOb+U5pJV8CDoLSyp8bJMsvSft/b7F95f4Ate701wXFD3
	DUUqqrWb3nSPLpuOQE8ed3BcdFcUsYwkIzOfTolfpof/KBa1argDs5+Gk+h56wHAA1BD/XkN344
	fl9AbXolVlCZM29WIU62wsrBWANHSyaODXUYR5JYGB+tJ4l9B6s7oT/pTNxIKURWqo91dBA2fP2
	mSk6vw=
X-Received: by 2002:a17:902:d2cc:b0:2bc:a58c:fd7a with SMTP id d9443c01a7336-2beb1a59b79mr2204035ad.16.1779466448755;
        Fri, 22 May 2026 09:14:08 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb569592dsm21372045ad.16.2026.05.22.09.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:14:08 -0700 (PDT)
Date: Fri, 22 May 2026 16:14:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <ahCAyZ_-2_CLIqPR@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
 <ag3gJLtY1jnT17Zv@google.com>
 <20260520163117.GX7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520163117.GX7702@ziepe.ca>

On Wed, May 20, 2026 at 01:31:17PM -0300, Jason Gunthorpe wrote:
> On Wed, May 20, 2026 at 04:24:04PM +0000, Pranjal Shrivastava wrote:
> > On Wed, May 20, 2026 at 11:51:42AM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 20, 2026 at 02:24:47PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > However, I'm thinking what's the right thing to do if pci_enable_ats() 
> > > > fails in attach_commit():
> > > > 
> > > > 1. Fail to attach but unmerging the invs_array entry is complicated.
> > > 
> > > Is it? We should be able to keep the the original invs and not free
> > > it, just put the pointer back?
> > 
> > Reverting the invs pointer itself is straightforward, but IIUC the 
> > current implementation of arm_smmu_install_new_domain_invs() is a
> > destructive update as it calls kfree_rcu() on the old list immediately
> > after the swap.
> > 
> > Although, I guess we could refactor the RCU lifecycle to defer the 
> > kfree_rcu until after pci_enable_ats() succeeds in the commit phase?
> 
> Yeah..
> 
> Though really pci_enable_ats is not working the way we want, writing
> the enable register can't actually fail - it is all the sanity
> checking for kernel bugs that is the problem here.
> 
> How about call pci_ats_supported() early in attach and fail, then if
> pci_enable_ats() fails just WARN_ON and keep going, kernel bug.
> 
> Re-organize pci_enable_ats() so it relies on pci_ats_supported() for
> all the sanity checks and cannot fail if supported is true.

Hmm, IIUC, the current situation says: 

pci_ats_supported ==> ATS cap check
pci_prepare_ats ==> ATS enablement prep 

Thus, I feel if the prepare fails, we should expect enable to fail. But
if prepare succeeds but enable didn't, that's the place we should
WARN_ON and move on.. because we (IOMMU) did the best we could have..

With the updated variants of pci_ats_support / pci_prepare_ats (in
patches 1 & 2), I believe we cover all the cases now..

And we plan to call prepare_ats only if (pci_ats_supported == true)

Thus, if prepare_ats failed, we fail at probe. And if probe succeeds but
enable ATS failed, that's something the IOMMU can't help with, hence we
WARN and move on? Does that sound good?

Thanks,
Praan
