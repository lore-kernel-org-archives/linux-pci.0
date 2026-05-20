Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B53363C6F
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294253; cv=none; b=QkIwZOVN1yKXk16x5onGtNCfxddxI/WJCRhaeUfFjp+lBQS2Bv+zPDSC/CFk7WFhrijbw1wvP6fmrkwouxs7g8xIwGeDtFDQFbH+g2gcMWkqOcUFh6SS4BYBBn2c/dwEknFUdtIMZiYvjzmEpb2VrRLuejkrwTE+Dj+VfjBD11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294253; c=relaxed/simple;
	bh=yH95AfxzT/+D60H+ywAWLG6d24H32sb2arUyyKK1J+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWo3bgVCNhdGwwt13o/Ho8MIOfLKOR43ajN6i1O2OLCv7e480s9GB9Tq5jJZL9yIrDNYZ+tvBrdHbyZ8qK2sefBI2EITeodkid9v2l6ooZdxWxFSVzMRnKkklUzJNw1oEicacdbq677ZfSkyKLJ99dBoFK3UHz9JigehCstWBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ppivqsVV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppivqsVV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1705ad.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779294251; x=1779899051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ju9p5eoCrFSkfcsgNxlnvpqY2cZIwhwQVw4yR1FEmcE=;
        b=ppivqsVVEniWeqBEkuCJlC5ElhQ1XwEevB1xqkckQyaXZSNbM/SLmqGiDyYVCTcMyz
         v5cTtAUmEyx/VL4oGNIlitRZxLEzXlBwW7RBUVGg0lEY4LWstIGzHPY1T+Iu6+fSKm5V
         GnhmtsPvv3UKdRLv5NMdJ+Xp3GsEAzjzqRDpNsZsLk63tHVohvZ5uStzal3xBtnynxS3
         GYR9j0yVLbqvOZ4gYqn4LmbfORv6sT9iooXLrw2LLq9HjVNPGEjzkb449BeBHbsGkjkd
         hidvlCkD4Vgb539Kp+rORxeRzKPj0bxOWU0B/FH7Iqqu3gSC8Vn9fMva7i3afFzHzTym
         7qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294251; x=1779899051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju9p5eoCrFSkfcsgNxlnvpqY2cZIwhwQVw4yR1FEmcE=;
        b=fPm4BQF2U5rK0yRkfRLSNHeKaSIwG9+/RVzvWTMvRdYIfx6j0jPIK5ktz/9bwTjzHD
         vz32MCJcHe0TcdtoQA2mutREdCZ9y0OLAq3hffmNXS2mHSgyEElEqmrJEKfHWpX6MYd9
         5H21bsw04MUcOoLkdOO4y4s5Jn7wJQWT+o3OctwFrRgcrBJZNcpfi8iBWEtDy/Bi7bZB
         5SLODkWtBQ3YSTzLan3rEwIjraSoFuNA1BpjI0AosUQTbgYpTs69iJ2ofa9B0rnQ1fCh
         qD9IJHiB+D8ozuUwz/8LEZmcstf37rP650P4E5koelYW7fkNIlDnMpOCV4MSDVs1+ZUY
         O4TA==
X-Forwarded-Encrypted: i=1; AFNElJ9tTAbGPFEjuubLUD7A3X8XagAjDZAdDt9pChzrxdyiwRC0TheIDMdevKI8/b2Qtl7S90X8IDIqUos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdbzYZBfGW7DtRNAKGq3KXNT9VbglmDhK6cDu14a/xlg3j0K1C
	SLbHINki2Liq/6tkrnbn915eJVPLEO2q6dracoSkRoG5skbXR7U/39VbA7AgH9ReXg==
X-Gm-Gg: Acq92OF9i7JiX0CUJhMSaln1K9YIKhFTgRJ3dIY/ezbrhWyrm1uJd0br+8k4FNmjGpF
	g1O8m+HlKOlWHJRrueFhthjfZTsMZG9HQpvX4pM36GXPKXa01EeZ6QYV3ylQt/j7uFL2ifT6Zjf
	5ijagTIO49R4DSUO7BotImrPnnYdbqZitQM2Qnfke7nYGhz2f1NG3Kcr5z+OzHAEQ+d+2x42vPy
	8Or9dDmDNJAq2NHIWDcnmW/d+G2L7ott1tjHTkV3CtmRX65zR9wXH1qVvI3PqixUwkGe030xfIu
	GKCn07dHcmSPBSiqMyrX8hNqCKiP+6NvIDJTSubqbIoE+zwJWjiW79asoKZFSqurBSryUyWFFon
	txwx+2R8Bgr8Kb+Aihp+v82Z37YE1oZQteM2TFnotkPJBhXw8y6VDgOBUQ9gcJhYSHLEy4YvHhP
	kpZeEbY9EtRxEQj2pHw0GblxJkngkXXxEoY7q/0qjCBG2dZaAK9dtmoUHUtY5SLBYVa9z8
X-Received: by 2002:a17:903:3205:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2bdb03a2d06mr8986155ad.4.1779294250730;
        Wed, 20 May 2026 09:24:10 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114c08sm21188897a12.23.2026.05.20.09.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:24:10 -0700 (PDT)
Date: Wed, 20 May 2026 16:24:04 +0000
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
Message-ID: <ag3gJLtY1jnT17Zv@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520145142.GU7702@ziepe.ca>

On Wed, May 20, 2026 at 11:51:42AM -0300, Jason Gunthorpe wrote:
> On Wed, May 20, 2026 at 02:24:47PM +0000, Pranjal Shrivastava wrote:
> 
> > However, I'm thinking what's the right thing to do if pci_enable_ats() 
> > fails in attach_commit():
> > 
> > 1. Fail to attach but unmerging the invs_array entry is complicated.
> 
> Is it? We should be able to keep the the original invs and not free
> it, just put the pointer back?

Reverting the invs pointer itself is straightforward, but IIUC the 
current implementation of arm_smmu_install_new_domain_invs() is a
destructive update as it calls kfree_rcu() on the old list immediately
after the swap.

Although, I guess we could refactor the RCU lifecycle to defer the 
kfree_rcu until after pci_enable_ats() succeeds in the commit phase?

> 
> > 2. Move the pci_enable_ats() to attach_prepare()
> 
> IIRC ATS cannot be enabled until the invs are loaded with ATS
> invalidations, hence the issue.

Ahh, right.
> 
> So you'd put the new invs list, turn on ATS, if it fails restore the
> invs list back to what it was and RCU free the new one(s).

I guess we'll have to to do the following:

1. Defer kfree_rcu of the old invs until attach_commit succeeds.
2. Implement a roll-back (writing the old STE/CD back) on enable failiure

Thanks,
Praan
