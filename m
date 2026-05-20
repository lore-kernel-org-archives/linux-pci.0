Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6CD33260C
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287097; cv=none; b=Ypw50MPYisRvzmgRzGZkHRKhvU+LER43/PWjO1mLxaRtO2mbq8NvpOPz9r3FQEz4CJICo6rnz3iFD0t37RfmNhys336odf8MEW4zLBrLDzBHC+IX344w5zDHIvK2cS/qK5a0mtCZjLRICnl2q/ch4IAN17ICVZ7mUzKt7KnoQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287097; c=relaxed/simple;
	bh=KKCcdWqFNYQ5lipEqQIK8EuzMF7TRsUFT4LWZRN90h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecP3HHLI2inV7x3bgjEEFbgyNloUAgFk1l3tFf17pIL5NNsNqoFVjtyfSJ62XSlmH0REgT1NvmDlfQhs0TiVbHQcyzVl/6qHvBQokMm2P8iALYDlHZrTQUZQ4Ms6qgw/429gPYAF4po42d0uWwJ8ZFLVquPtKEmmhIU1MJHYXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb55ctQt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb55ctQt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b46da8c48eso1355ad.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287095; x=1779891895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXG3Uft8ZSTS8sDCEl0ZuECcCo/afwgtykht3rN3rLI=;
        b=Cb55ctQtsW50BQXXLzx9EUN7wra7erpTrVaMVsxZ/JFKhq9h9oFXNl7dMe+U1IZVz8
         1l/psaTIcipTnFVSYbNcXFIlj/BeyUGbD5ekmF2Tn3+xdUDEH8uPEdmfOjkzz1dHTyOH
         9dqgS+h0H0nEifl2SLRrSbHmak7fj1F2ZZVzLycL74+mdL5cFoIEumzE1naH1KBVokiy
         wfhvjxK6k3oyAdA8NzDWsyzNJCV8IisG1wPn/vSp3JXY40g498bR6EJjZNA3/RlVjdB8
         b9yKHu4YVk3k5GXjbFBitDx+WuLBKtZLc3CWlm3uYAKNKTw1IcOvpemQ1icm/nOSnVxo
         KCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287095; x=1779891895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXG3Uft8ZSTS8sDCEl0ZuECcCo/afwgtykht3rN3rLI=;
        b=osyVX0+s2wuwdFHNDrt0sKq6eVqGloUOPpg6v3ce7JoDS4+bXCABJLAU7P5z5TQlJm
         BH3yBQBBQtKkhaJlI+u8+gv3QhJwfdAkoVpyHTAMzBCFV0Sl0z7Fie6bnwRCmIgxneI9
         br4Ymd1+n1EiBFbTN/6STiaQoly4Ll1KzWl0G8wAy6PIPkjZJQ2Pp2Bgj6joWA8UD3p1
         MMbhfugzX3IjKAFDQo5I/0/iUv8Y7/8N8VvWyXBAd0+Dc3+1dNDlOisniOH6b4jRobms
         6b083y6CO024NRnnKEFf5SWqpTZyqEYVswY1rf9oL7PqTtQs7ncgEMKDO7mqqDyLb0jr
         l3hg==
X-Forwarded-Encrypted: i=1; AFNElJ8p+s2fB04BI4Q48/wXEgLGKI3X+LCR6tVDDScGU6JDva6Z+SYhnzKXDQOwc69i/nF4kUt2u6qOIkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGeSQl1TedJdcGUEyoSOJOBdDccpydLQA+1tM+E6JIQCqc/gQd
	HCmatVivyy38bn8ZzuwN5tFwkqDlOM1ETxaWrm/5pbB70HYYv2Jn1cFRgoGMIPTJVg==
X-Gm-Gg: Acq92OFuKq7V4KQ50rFm7XEy8n0/bfssKkvmqbAS9F3iOIBJxCUZuJorDT8Gerz2pn4
	ajIueX4tmq2GsmZ/J3wMlx5MTubQN2xvslcR/HSr+hPFRX6mLW9UvtVVdK882XtKR6n8Ai9Q7Ud
	SUwGNT8yigkQVi9giNf9auatvuV4+Wpf1pg6Q4+xB/Ozp+vreGZFuUP+EULx3ubt/72/V/x+F9w
	KcDV217k9lU2qrjd8gU6lwv5ajeE6c+Wnb9/tVTM+OxHZJLASGrQWFYYIcEFadd9fcLd/D8ua/O
	3YVh5Hp6LkA9mCyCs47wTsC6UuLHhTC29lkiZSWNWi2NxHs2aL/orB5FtlR8dPI7yFZurjeum0r
	UoqXVxibcsp/INrcQyFVD2GpnpzPKb4W9eHMGfXvlA2x6Qrlml8JPKUrSrO5+bVQgTVWvtcaD02
	UYEJiKNYBEsDenkGKECjUrS+ycxb7T8fr42L0NPKrgXIC66xY3fLrbI+SGZgaOM60pxKq70Tf99
	hY46Rg=
X-Received: by 2002:a17:902:da4b:b0:2bc:a58c:fd7a with SMTP id d9443c01a7336-2bdb0410499mr9865105ad.16.1779287094622;
        Wed, 20 May 2026 07:24:54 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f5d2sm220239565ad.23.2026.05.20.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:24:53 -0700 (PDT)
Date: Wed, 20 May 2026 14:24:47 +0000
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
Message-ID: <ag3EL10WAIImL9XR@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519145947.GK7702@ziepe.ca>

On Tue, May 19, 2026 at 11:59:47AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 02:55:54PM +0000, Pranjal Shrivastava wrote:
> > On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> > > > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> > > >  	if (dev_is_pci(dev)) {
> > > >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > > >  
> > > > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > > > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> > > > +			master->ats_prepared = true;
> > > >  	}
> > > 
> > > This should fail not keep going, it is a kernel bug if
> > > pci_prepare_ats() fails.
> > 

[...]
 
> > If ats isn't supported or if there's a STU mismatch, shuoldn't we just
> > ensure that we don't try enabling ATS for that device?
> 
> No, the kernel is broken somehow.
> 
> > Returning an error here would fail the device probe.. which seems like a
> > big hammer for devices that can't reliably use ATS.. 
> 
> It has nothing to do with devices, the kernel is broken if it fails.

Ack. I see your point.. none of these should happen if the kernel isn't
broken somewhere.

> 
> > We have a special case in SMMUv3 where we pre-allocate stuff in prepare
> > but actually enable ATS in attach_commit, which IMO neeeds to be gated 
> > based on client device's ATS capabilities?
> 
> Yes, all of this should be gated by pci_ats_supported()
> 
> But also failing to enable should translate into a failed attach.

Ack. I guess we already check pci_ats_supported during attach_prepare()
while setting the state->ats_enable. Based on this state->ats_enable we
call pci_enable_ats() in attach_commit().

However, I'm thinking what's the right thing to do if pci_enable_ats() 
fails in attach_commit():

1. Fail to attach but unmerging the invs_array entry is complicated.
2. Move the pci_enable_ats() to attach_prepare()
3. Continue without *really* enabling ATS.. 

Thanks,
Praan
