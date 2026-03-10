Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6C3E3162
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172852; cv=none; b=fRB5ne95qdWtlw/uH1b+1kQ4ml4R+cyqgyEoorZ12BIHbr8S5sX+kh7YZ9H9JvOxJShWalvK8JhiR/vlm6Du9ODq2opfbzY/cZHQGC4A4sB5cJyYSGwI7NNeyptlL+KTmdyxuYO69z2LitH0d5h7pfkas584ZYQTSMeJDy52ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172852; c=relaxed/simple;
	bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egJBiUNDe26u/yMH6vUT2eZw+dDNpFtpPgMRZCrVAxG0Wtbv4vs+DNiVLTCTwRayZa+VciVvsQmoBVh14jKQhaUpMhDrA54G7hsvmGaRb9JdTntmm2F9MCUJshEpWOv4Zjd+P6HyP4BbcCGmlJuh7MFQhY6wjycFsfEWZPWPBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6UlQ2d9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6UlQ2d9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae49120e97so23765ad.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773172850; x=1773777650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
        b=u6UlQ2d9kj7DzeV5fPPeyV6YjBaajC4Y/10M+RIt67zJp/T+DHXFprbNcxNI//4Dgo
         4D2o3CIV4ibVYhgE33vsmHrwq72e1aB5Bcx9U64YiMD9yFScHSPz+jQLRCLYLjyPcDGs
         yWJU+Lo565I0bueE3HKWW+HgswTejHKCOhk9sN9q1WxzBQO+VgT7cJnlDoosqCPDy+jL
         SajF5/peb/sSt5YNw1p4pULrTpyBT6fO4smLrbec8V1dzzmWv0e81DHf4s5dVtrkPEcm
         5+tgTJukediSO+FrcY0ynO0uuZPmG9i6fyx/bUVNwhhNvKX3IVE5xYQpEXyGVYRgB2bY
         txvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172850; x=1773777650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
        b=dsJ+ZOKoQK2yt6cw3zvnbBHiHPGqt8+mNwyk5dxvkR33jQksV7n7GX9W0RpFeBA6V1
         545HgIaJT53zu4atrhRnUoHD2HGMhACMoysSzY9bedc++sM5QFbjXkoAejUcJGMgFC1p
         10t1UyCFcSes8+eYmsic+TrMxMQTeRvwFdB3hxvKdQkaRGL8CSkRQJRbg78zZx+ZTtBK
         PiqIZlNz5IKTL3kRjTUuDo9a1h3s5ccm/xIKNrwBmBajyqoFQXsh0V3rWAgPoT9rrn8R
         qR1gEVY7ieeVQz43Z8LUxu0FzXmTPTl4EXPcckI/cBkHbRHSyiRojOIYElYAdfx+NI58
         azXg==
X-Forwarded-Encrypted: i=1; AJvYcCX+lFo/gorLeXV0Fjlaw2GvuDeF1Nstp+b7V68AT9B1m7/uoAjZdzgp4sjR19NdfNcBe2WeTpCkk14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDy/zCc2HtqLATzGhYuyhJ+/168vHUMHBvfbKXDx61eSzHlBX
	iAvnTCd3l3nKKrXy9fo0BXz+EpFUCjhqwwIuGumC+l9bYD4u0MBgG01+rYks2PFnMg==
X-Gm-Gg: ATEYQzzE1PCiQb3Qgj/tNvYlbynBH4VEmMstEZDis3mIIjFOH1NxGT7cJaRSx0vj9FY
	ugOECSIZjVHx7IjIqysqSeGjA/uaAhq6jcfKXPnqZln+p9ESoxcq/oPVqRfQM5z62Zy8wg+orCg
	rvWFrRFiOQzqujPBVn7YTrjBa9OlGV1lJlQgdHW/wiMCi68JIF1kJdMvASnQ8t2tnMSfxzZ6KQL
	n9UCKzPORLFZDULOAsAALW4Ghv0yqL/CgqQeG9dn3dwisUJcFZnh9XP4zz8XzWBAzbBE8bF0dGT
	0R0pLHjq5UTYC0s0qoS3EhqLYc4elico1QuT5hciCt6w49xGKu4fnh6daCKzl681T3PBetX5xwu
	u8tHhUtmgSzg7/uG2apK0iupzoPT71R2C4cGAAR0eXJI8vyaNnwtzG6QFm4ogTEcltPItPmLHcY
	Zzc0IM3Muscvq7OBfZm2jVnxFhkbVly3nDea6fJ5NteHRempnBVtL36oSskKZYyQ==
X-Received: by 2002:a17:903:234d:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2aeae708648mr72605ad.3.1773172849749;
        Tue, 10 Mar 2026 13:00:49 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f110991esm3573204a91.13.2026.03.10.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:00:49 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:00:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB1VJ5Op24dMIog@google.com>
References: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
 <aasv1HYOKuuJyi1k@google.com>
 <20260306200321.GN1651202@nvidia.com>
 <aas0dLwKmZyL_iOL@google.com>
 <20260306202652.GP1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306202652.GP1651202@nvidia.com>

On Fri, Mar 06, 2026 at 04:26:52PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 08:22:08PM +0000, Samiullah Khawaja wrote:
>
>> But do you think doing the timeout logic without fencing would be good
>> enough?
>
>It is what ARM and AMD do, so I wouldn't object to it.

I think without any back pressure to the caller, a device will be able
to fill the invalidation queue with device IOTLB invalidations that get
stuck until the HW timeout occurs.
>
>> Currently VT-d blocks itself, until it gets an Invalidation Timeout
>> from HW, and system ends up in a hardlockup since interrupts are
>> disabled.
>>
>> Are you concerned that if fencing is done without an RAS flow, the
>> device might not be able to detect the failure (if it really needs ATS
>> to work)?
>
>Yes, and then the device is badly locked because nothing will fix the
>IOMMU fence.
>
>VFIO might fix it if it is restarted, but other approahces like
>rmmod/insmod won't restore the broken device.
>
>So I'd rather see a more complete solution before we add fencing to
>the iommu drivers. Minimally userspace doing a rmmod, flr, insmod
>should be able to restore the device.
>
>Then auto-FLR through RAS could sit on top of that.
>
>> I am thinking, we can do translated fence and timeout change for VT-d.
>> And the device can use existing RAS mechanism to recover itself. This
>> way we atleast make sure that caller of flush can reuse the memory/IOVAs
>> without UAFs.
>
>Without a larger framework to unfence I think this will get devices
>stuck..
>
>Jason
