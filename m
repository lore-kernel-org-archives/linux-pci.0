Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494C1A9B24
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892030; cv=none; b=JhuCWS+eRPI/d0QD/SrDIgb477ejM0f65RGHzfjF8+KGnJTn/tDH04gMYQWatThdD6p6US/z2m+16xIGonl07TOrCwGY7Hhjm9qRQEEBeWM9jhYMyv/fAwpHjNUfyQgEwIXZxOf7AZO5wa9UGwST3vc7UELndimyfH61VZoUiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892030; c=relaxed/simple;
	bh=pddL6HSAhsH/1vbRoQdABpmyL+/jlM2lKi6+ZCYayko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFKEF02y2K/c/sgqy5tL1janAdmkETVBVZxXKL68jBPkmG8OwEisDdtXTWzHWJj37C3CroPV4mULnmCxcq4fsdQiswStX31nmwXIxyPgAokQHi6EbaSrmQFEkpy/04JRWQFYSXQ1Pju30Xx4yQcGmjfq3Y85hD5JVtX8+dRPq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZTotKH7l; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZTotKH7l"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52b6543169fso2638871cf.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 18:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785892028; x=1786496828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ySkDs/mLYNmACDFB7gbKhLkfCZF3JzEsyvOe84AN+FI=;
        b=ZTotKH7lWx8OCSnS/gWjNh13+51i4zpwdspt1ef8uMrj/Qdx1L6+80UzK/CLtyZnEu
         WGW1IXjfELZO55rCXTa1O5ZVG26Q5WJZRz0FjKuRQv9ugMwiYl1NMH63ylFvx1XwabXv
         EwACsThfIPTmQrPSdodcCL04MqDN+n6HJXNTQ2XVhLEMNo/VVKxV2gZYKkhPzr6GA7yX
         zUdU/aoozwLIghvLTNivi+mtkCkIMiH24STjgGbEG01yf5gnD4eXkRQ4yz8X3Kjekac4
         FvBImDIorcoMWU6934/y9L69RKK4O6Vy+euPP5kcnMJEibQbIvQ8BPXZcUKMRFl+PXHB
         320A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892028; x=1786496828;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ySkDs/mLYNmACDFB7gbKhLkfCZF3JzEsyvOe84AN+FI=;
        b=FlXNNtQQ7FsYJ8xw4fClu9ICP1feONzwnpkYn/chb4u7ih8DjFw8bTlI5BvxkzScCX
         VKD3yGNsZyOuM1WaZC3n1BoJDVryrv2EH5zfji1XOKX727KluGuskcNs6LuKyn+9ICQP
         Iwq+6XRKMBzsG10FrG2IQv2Nq9QO2DQ0TarRU23t/v8O4LzCzq/DGNP988vOLOdFpaNL
         tLsplGWgooAQzPaKwmU09HkY+OYuksTtgJA30SnC+XYvzpa+JphZG1psSYzkDq8lMmcN
         JxCd+J+3T1Er4gLprtfVLfZjQuDT4w7HZ8oXhz4OP6pKAekV3F0y5KiWpSFaRjP/vTJM
         dSeg==
X-Forwarded-Encrypted: i=1; AHgh+RrvmZs0jyEnCIqMz13ewcaSrzBF2jPfZSEfZnL9L4wCSBXImtcZnG/Fz8qfvMSqO6lfzUTxTydnd2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0vlYcjeSfK03jFkDOWtsXn3mQJU9lgmecle4mnZ+1ddOg3/N
	EhqBmlqsRZ6kJHGEgnVDxG6D3fPfJPQcmpjg6uIbSaFt7giMz5XrenOq1AuQ5TQ7I2Q=
X-Gm-Gg: AR+sD10tXeq1MxEbw+2hOX+eGBWlGiUOkESY0MZwGqKOD9NWF0cn9CFo10XjUFPho7m
	n4UahLkPAZL9Q9ttzdHhIJ+/kOmerPLFbVCsyfDiRQzCHerolLxtwBZmiFQhIJx2pMY9+hEqa2k
	TQpzdvmSeN5Y7XkjSEyUsFxxI19ugGdyKpPpFGwmHkhj2frtEvxDQ/n3L27P1WhjUvUEsLYUgKB
	1ggdISg/EWwOpWJBtt00XKaqSrNwyxoEG4AEBAgm+50Q7Y7sGzg1T14/OAti9tIWvQwH8XBDPjG
	iPTscEj3rKvKLIWaXCc+gpbERUwPzixTEx0Ehw0+8Qs6v9RQITdXlMHBkteN+onS2pq0LGedO8a
	Pl9uMKT+p5qAGiKYxgWRzP3B1LploY/jpTRWrGHftRtrgNWZ+wfUew9LrcyCEw98azZXF4POn+c
	m8kezkGhkxY/EGDOpivyc4Upu5ItcuUPsJl7Heyg==
X-Received: by 2002:ac8:5d45:0:b0:52b:581e:1274 with SMTP id d75a77b69052e-52ce5fb75d2mr38502211cf.19.1785892028002;
        Tue, 04 Aug 2026 18:07:08 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ff9de0csm14279016d6.1.2026.08.04.18.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:07:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wrQ66-00000000CpV-2ZEq;
	Tue, 04 Aug 2026 22:07:06 -0300
Date: Tue, 4 Aug 2026 22:07:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Kuehling, Felix" <felix.kuehling@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bhelgaas@google.com,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260805010706.GC28508@ziepe.ca>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
 <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>

On Thu, Jul 30, 2026 at 04:56:37PM +0530, Vasant Hegde wrote:

> Based on discussion so far in this thread and the link Mario shared earlier [1]:
>   - We still need identity mapping for APUs. I will fine tune the patch based on
> the discussion in this thread.

IMHO if certain HW has broken support for PAGING (eg because it can't
handle the isochronous needs) then it should be quirked and blocked
properly.

I thought the issue here was the PASID check forcing identity and
accidently capturing these raven chips too? It should just be moved
out to a normal quirk..

>   - Its fine to drop SNP check
>   - I am still not sure its safe to drop SME check (CC_ATTR_MEM_ENCRYPT)
>     Because here were are putting all APUs in identity mode.
>     Commit ea68573d408f explicitly error out for RAVEN and some of the older APU
> platform didn't support SME. But not sure about newer ones.

That's quite a hacky check to make in that commit..

> So I am inclined to keep SME check for now. Once this patch stabilized we can
> revisit the SME check?

The SME check makes no sense either, but if you want to stage things
I'm OK with it.

Jason
