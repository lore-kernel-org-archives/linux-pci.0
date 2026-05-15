Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1660F3F5BE3
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883563; cv=none; b=J040Dq34vlexVMQQcYqFK0Vex+FCmnv++sdoqe4cT7IUiUj3xA2Q1yoIFpOo6fYUuzVWSx4HEF4oIdSSXitEG43SGKdJUPPqAd6+NzzCBfG0fDrpEDXKAcqx/hHSW43BMJCAQJer6r8BIEdeiGpAF5tHudBrS3qN+wQb96UYkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883563; c=relaxed/simple;
	bh=8SzpbZgJBvBRL/hzxIjQ/9GeIwvuw2el3nJZdpXd+WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEMYbpKLW7YPN51P8zB0hu+8ZC4HGloinT46q7moU9OuNZn68rIVHiQiYFgAVL3Obbs46a/iTKVuOt11r/WAjKA/ZU7OCZWkTqyYXnmX/FwPck8/sJtHeryFeEA82mbQtRIZ1wxzhEXp1oLl2sVmiERAwph5KoLJY71odUuz/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Oi067Wi+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Oi067Wi+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5148cbdea08so3900561cf.2
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778883560; x=1779488360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz77QHSF30CmLvYON6sVw/Gk6vw94UV9wtrxbUX8y+M=;
        b=Oi067Wi+P4Yx6RvbsIpM+7igYMAEy3+eLQdCmDQLjimAaOAccY2Sjla9OJTvYqZFMC
         QIGOPvYnE8V66UXsT8jkxGePlTpcpvUgxfCNxJ+qES+j2eM9z7u0UR9F6uGF3qbG/Vn+
         jPiNT32XjhaZjR7qzaCltoSdK9jnaVhJnlbuSV7MfgeffHHJdlgVAIPkeDE4oBIIFTua
         bNI1d1/TkqhsqbeoO1FrhRyH8eYYpqLn3xshhpXXFxxmkwW83Em/1RDTcwrsVMMBwGHl
         SJNT6uMMb/09pS6NZMOD6WEG+59G15EcD08Vk9oVfPAXdf89Ck71Gk1KvG3G7hafcWSf
         it9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883560; x=1779488360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz77QHSF30CmLvYON6sVw/Gk6vw94UV9wtrxbUX8y+M=;
        b=bwLv47XfSNdwtN8SCqHSpryRwlyGy0IOjFqWmXuy7LRloZyeRloBHTz/AFhGFhN7bn
         AyXuql5sLn27cTTt/eHBrZtFHhcXQYd3HeRUL17TcPQOC9aQ2boyZH0iMdrqUQuqLReg
         4UBpKM4BY6XHq76puGYp4cau97Z9j6Pb6ihkFiDkn1fK/DeL+QZITCjY+nT/56WzHHIy
         +Iy49xA6DqnyLVmEgSzwXh6R+1M2njXyURjpqu+/E7ASPq9vXdc0D9ZeLy0BZuH8fMv5
         8lJ3sHs0P47SBHt6r+FGSGQy1M8nadPgvqGBuwlpdq9jWFnRvM1o7LVfTji98i+FyLou
         y/+A==
X-Forwarded-Encrypted: i=1; AFNElJ/Ej4pkh/r2YjP86yvZ80043cDYobFEuDHQ5twf8IxmLGvwfsbj4RqCmlgAFuxVDk4Vljob6KgBBlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1pCpSJQ/GHQrCNlPdrqQQLSaO9MPKgt2u6H0SpZB3khmjWiQa
	MY8O78eWBhzc2naP40ThT7Qg1emKovCfQsSRZdTP1tp/L8RxwQ2dt9bYpRlAWi9eaq0=
X-Gm-Gg: Acq92OH44ilS5nyVdIyB+Vh2UYNTjTZtOqdShOCFXGbq2wr1soKErA7OsppjM6hQ55k
	tUH1DzNao7T9RUUaP4yejR459he8ZfJQZL1gh2ITvjcJGgiNcrzsVDKNtEvl7YNNUEUaa1Bp9rK
	TL73MCV3stEKGnqYN4Ml17T2Pf+HJQmB8kdDUD1haWrH5pZNvcUWdRV4naRd6CR6VSry0lZzRGS
	lq+KMtyMrDR482bdee4jaLcN+rVJQjmOviMg+4tHUZnqXKAhYNG+wgCX1mwNE/3okbZUK3bSCXq
	JWQLHI4amkOqpIIZ7ppoZ1BZKjdrELNbQkJQxlWOTa9PWL4j15xGW+zkPF2sG/Mfqa4GuB8UKU8
	TlQidZqkpnSq/Mu7WbXS4EJYIMQZBHOH3DF0HXakazj97PZ6Q0ffkCfPcbmaP8XzF3IR3y3Wots
	pDef5ji4RtlcFNtlFohaSVcfEh+Chx5yzjoockmCYoryMUtLIv94wBYhQ1n5uDDsVq1vGhZ4Cra
	bpCb9bFK2PTFNns
X-Received: by 2002:ac8:5742:0:b0:509:2858:3c63 with SMTP id d75a77b69052e-5165a0703c1mr85536381cf.23.1778883559652;
        Fri, 15 May 2026 15:19:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm58162851cf.18.2026.05.15.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:19:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO0sI-00000008D1f-2Swb;
	Fri, 15 May 2026 19:19:18 -0300
Date: Fri, 15 May 2026 19:19:18 -0300
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
Message-ID: <20260515221918.GJ7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>

On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> From: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> The Hyper-V IOMMU driver currently only supports IRQ remapping.
> As it will be adding DMA remapping support, prepare a directory
> to contain all the different feature files.

Any possibility we could put the irq remapping thing under the irq
directory?

The other drivers have it here because they are co-mingled with their
iommu HW, will hyperv have the same issue?

Jason
