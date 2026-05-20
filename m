Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36C72D94B5
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284291; cv=none; b=FZBWQeV8jhTDrK9IYK2fmo/Hg+wvdhf7XB+CawD6pr7pNHEznl773HJNcIJ2i2F5e5xIKnozX0Ef095MqL+WTFl35ZKaK/Ntm9vi2CmMBbVJtlcORagwpw6UlYH+7e/nvvo6G+rN778a6grnpxEhP3njDzmtqfkhJLOEL/ioiTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284291; c=relaxed/simple;
	bh=FcTKYryF3HlZcFivdjcw94sl1hUA9PtC2/zgtt2ZZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY6CKOuDe5vaMBdJV3VAI71X51J5fLWzfwBUI+qNKMUVS8iglzHMsVVVESm83ES6PbM0BVwIZXVuDArGZMCQ7o0D+nT5wTcLyjxU5dgIGkVbbWmcGHDNI6Dg8akrJ6i+r8xxV/adBJFWHgSSe8BbmuX3k3sWvyQLqHazAdfdDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cBzOeB90; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cBzOeB90"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-910f734b477so542117285a.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779284289; x=1779889089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ta3JnaFAadHaT886JLq7+5Wp7lPw1ufIXyuy/64QRsk=;
        b=cBzOeB90De6JH9YZRFW4WdvPomMlPt+GLQnVKxGLpjoAW9+MZqNKeid4oFTWgQ11k5
         9vt4MvanJfFqfc0J7YsM82g3CPSDDBbEnEX/6L4fV2XTMUc/puxSVOI3bzTcEtcMcmqH
         v1/iG/yQlqyVlfl1XeHsKgPDYOHSvnqy+xHQQoMXiwf5ZX+i2IIcD65QmN+GCDdUKQV3
         fjhyMGr6UFZTz/iqinGH2Jn/MnFb3n6FkD6lL7MOfEwck6DTMJs8OY/kL4L8PQmd4spr
         Vs22mr5Ruv2OSsSaw5v+x+zjF/dQdPNixEh1rHLzVwhHyHwWg9uaI+epPBP23XLfwJiE
         z2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284289; x=1779889089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta3JnaFAadHaT886JLq7+5Wp7lPw1ufIXyuy/64QRsk=;
        b=M3m7twSWEYIhxux+V/C11e1CIbthN0Kddhl5q5ir4MBHYoe1r7QVRC9dXJ8Pebp353
         +dUhFNEG949OsIFg6g9JxxuUhzQlgpDN9LffO2MLtL3QHUuV2sEP8sFybMqVm+a3WOUe
         UObhkgvHUiADyqBtXnDbfC65LXtCS7Bdrv6JcYq75Nkd171HmBv7F6lkbeohQ/VmLnFl
         PzL/1HEJMvjETlkOEOGnV6tYQUsBa0fqv+tiXt7JI8t0lDC0tyit9qwtRAR8v+FuCwXd
         WTEd2NEthYgH4yHZTfKqFpiAQj9eMbdWJphudXA4oAcy8EXMPCC9xNfiO72FKQJP0U49
         CdTw==
X-Forwarded-Encrypted: i=1; AFNElJ9qXaPUkuWpc+sclOdigF6svs9m7ZBzCl2unAbRAIx8pCXJgJuUYo8tTtfwThT43KQiTjqKGOfh2Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLlRNbclVMgVwib8hVLlQqJUpEUnPj+BTqaz2uZIASncoZiKV
	sQKv5kB4ovvJW382wW9geq7isg9SPbp7mbaSx5nlpcPafPYnOn4CL/Bh+6QAaHdEQms=
X-Gm-Gg: Acq92OHGpbTtUa8uiajlG2AHc1a79LV7o8Qj9iqduOIE3t6olKr5O8CxeZQOJoF0076
	kBXGl1KBaJb+0VM2R8ByJpNyDCTWw+j5gQmAd+XNPLAb6e3fovmv/Y0xc2xYtsRbPnmlRCkcz6W
	9Wxeb129FQerXLx4HHkFZAyZtr2yn8ywk5vrTcNASs3SHDKUxCCcWvmpFbwPuNZJJIY8kyBf4KE
	/Ih1+GCdQ5iSudJUh/LOc7Zk3ooYYxlPc4e+CXfu0VkedJ1mT+0lOJCNkjkj1Gx1RMHvJP0uaDo
	ntjsph4p4URKpSgrzaXMGqp0dhfq8ji9vsBHebCDgljKIfttNqnn3iqUCiEf/rlcY8fvn9O4ynf
	Fs4T6UH6n7yq/80YCBkqNlUIk9Ve50KVQP2Gr+AHvXM7zyCi9qUjLTYApmR8YcUrHJkdL+YjI/R
	vLO59Qr+RwMVfNj+XtG80e/mNmNHoAeZlleS3MOzGE7Zig+qzAH5koqYCo9p3uz/QxkQHPhd0je
	O936VuG61i0S8lp
X-Received: by 2002:a05:620a:2950:b0:8ef:f1c0:ab7f with SMTP id af79cd13be357-911ce524059mr3564626085a.24.1779284288689;
        Wed, 20 May 2026 06:38:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83ff00sm2144919485a.26.2026.05.20.06.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:38:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPh7f-0000000HAxk-0y0i;
	Wed, 20 May 2026 10:38:07 -0300
Date: Wed, 20 May 2026 10:38:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 1/4] iommu: Move Hyper-V IOMMU driver to its own
 subdirectory
Message-ID: <20260520133807.GS7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
 <20260515221918.GJ7702@ziepe.ca>
 <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <elo7enhxk5m7x4rc4quiqnkgbwsqa3ex7di2ksv7szu75xqe6x@zum5nwmkl6kn>

On Wed, May 20, 2026 at 02:37:03PM +0800, Yu Zhang wrote:
> On Fri, May 15, 2026 at 07:19:18PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> > > From: Easwar Hariharan <eahariha@linux.microsoft.com>
> > > 
> > > The Hyper-V IOMMU driver currently only supports IRQ remapping.
> > > As it will be adding DMA remapping support, prepare a directory
> > > to contain all the different feature files.
> > 
> > Any possibility we could put the irq remapping thing under the irq
> > directory?
> > 
> > The other drivers have it here because they are co-mingled with their
> > iommu HW, will hyperv have the same issue?
> > 
> 
> Good question. I don't think Hyper-V have the same co-mingling issue.
> 
> But from a code organization perspective, I think drivers/iommu/hyperv/
> is still the most natural place:
> 
> - The IRQ remapping framework itself (drivers/iommu/irq_remapping.c
>   and its internal header irq_remapping.h) lives under drivers/iommu/,
>   and all three backends (intel/, amd/, hyperv/) sit there today.
>   hyperv/irq_remapping.c includes that internal header directly.

IMHO it is a fair question if that even belongs under iommu.

I think it was dumped into here because of the co-mingled drivers..

Jason
