Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0D3A6F00
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392116; cv=none; b=C155/9SXOpYw7AjbOXCiy6hNWNGXxvnnPKlNJ7FmvSh1dvjEOTyqp0dz2VmM75FGtBfxXjnELFO5mLbuYx43Fx+IE85/8aSn07Mv72SyY9Vc7gM9ACrHICogyxfz9KQZcxSpERoA0cB8B+mSaAyRt222p6D4sp2N4D6MvDsaUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392116; c=relaxed/simple;
	bh=7WJLHqn+vCXpKoMsLpDMkqhdyw4mMxJn+ORetHQNEts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRPrbWejpKlEDCsrLkzbE/H5FrsthS+buAaMD8TKeBCOl/2bb+6/N0KOrtRyYRO05369mdYIX9GrYW+arlOrk6ca4cDUpCUDZOOQI6QFddgx3dm2Z0H1c1QWsynlioHbL4xmosYHbhD20Qn5ftxRP0q/obilkxo7NK3TQmULs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha62nN+/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha62nN+/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so14833825ad.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392113; x=1780996913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z//VwuvdHhuIm5iM3Xnk2cWF15mlTMeV9P1PgKLz92Q=;
        b=ha62nN+/Subkv1YLveQgAq2mJYZdBrfjOnngXduzmcCVG0ITh5liy+7CN8lYuOqN8J
         DBVSCDd9cqkTXHgRmkFRgAnePm1wRuLBI7inaTQg/xJmXnuKlWCXjQNr07s5sSPs1fDt
         ZQiFGVSeCk9ad04gkPyoGxhOlUYblkmLl9j60HgNMxcc/OrJ9kuRgj+iCo8ZXk8o0zGE
         Wu2+YjOfppnGJwoZHOhVowPyjVXikZZS3S7Rwz4fkydzQTsf0szwAjvREe/8tXGAbKqw
         B55Y/iznIgfDhpLAfve+HVlKvE5LRXjC6SITxczEisgwXEMrkq1EWRn2uCoDWvfuqU3u
         7fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392113; x=1780996913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z//VwuvdHhuIm5iM3Xnk2cWF15mlTMeV9P1PgKLz92Q=;
        b=nBrDGMO8eDWfP9zFeYlLzGcV/o0aLpGs9BCdnPH8fq0/GWsW3mcFfttk1iE8eQcnGo
         oDNvBOyZk7C869vVo/hHFkG2KBlATWKvs9z5OCCzBzDOtKjBm/YtN3BhIHUqNXXA3sHq
         qmS0840VQ4MJlH+6HKziF74kz2LsBhjOzBjOeCPfQWLnbb0JHh9DAKoMchiyXf396JDJ
         z+WnO+1fh9aJDAjMRfjARDbNHgBbSuO+AhAzeFGhBpInPekkQ4zTG1OYRM8YeDEuKKrX
         2+V67XrlBb+62G35ukAfUEkpt8OhHIy/JVpWMjsAgLTW8y/zSEhHiBH6wtfzUeidMjna
         D2Ng==
X-Forwarded-Encrypted: i=1; AFNElJ8wEut7sS+vWklaGyATq6UXoQZ/kgdnk3c/if8mkdnwpWOhKWNyUNcUHptXKIjs0ewJVmmXf3QvzC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfP0+eJPEqqTuqQNPYnb3/hNy9FRXlqiaPB8Qv0TM8qqghwOCG
	of7wEY2cCWWW+2Yz4TL0nYUEcMEtM/xFb4MTbHf77E6QrDgx/muX73zS
X-Gm-Gg: Acq92OHPfGVPi4YCKAFKMRj5JGq+Dzih0yFw3AFFaACcq5oBEDnAuase7UdkVkCiNEl
	nfTtndEqjIacXUus0ahoXOG/ficyTO4eZeo5rIaYYzRdbkqZFJ22w9kn1SujrbI1pqNObSdR9UZ
	/yEtmb2BfFvOvRmQOV4S3jPPfr0L0zu+rt57jclNGaFhEG4Ck1fIdqGO9SsHIK7rMpdQkjAhu+X
	m70vWXM/jb9oM1vMHDIfAHaIwxgSX19Y9Pwt0cN0YCYBTkBVKarI2g//ARVX0AkuWDYFVga71xv
	7L2HOwL060OBppZAvkjg9FUWDyIK4kpgfnnQBE6RTlk6/OMOD+81BooQKOUu8e4zq2ZbPBl4TBY
	1enWNnJDgiwpi34aaKknQVfEtAYCyVO8gR8IH3p7DG4YwEmWSav4zyH2Ur0LwLz2wAaOtSQnTRA
	hV3kSmjfvq/leeaCn0COGz25gKrXyK82ZpPQ==
X-Received: by 2002:a17:902:ccc8:b0:2bd:ba44:6c07 with SMTP id d9443c01a7336-2bf367f292cmr150201385ad.16.1780392113499;
        Tue, 02 Jun 2026 02:21:53 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c5a350sm173102185ad.83.2026.06.02.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:21:52 -0700 (PDT)
Date: Tue, 2 Jun 2026 17:21:32 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Zixian Zeng <sycamoremoon376@gmail.com>, 
	Han Gao <gaohan@iscas.ac.cn>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>
Subject: Re: (subset) [PATCH 0/2] riscv: sophgo: sg2042: Enable PCIe DMA
 coherence
Message-ID: <ah6gcvKQlHlrW1qn@inochi.infowork>
References: <20260331171248.973014-1-gaohan@iscas.ac.cn>
 <178028263198.557087.6386925175219722340.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178028263198.557087.6386925175219722340.b4-ty@b4>

On Mon, Jun 01, 2026 at 10:57:24AM +0800, Inochi Amaoto wrote:
> On Wed, 01 Apr 2026 01:12:46 +0800, Han Gao wrote:
> > The SG2042 hardware design supports cache-coherent PCIe.
> > 
> > With recent firmware updates [1], it allows to use DMA coherent.
> > 
> > [1] https://github.com/sophgo/edk2-non-osi/commit/017a5aea26a066fd2bf501b7893937183165af36
> > 
> > Han Gao (2):
> >   dt-bindings: pci: sophgo: Add dma-coherent property for SG2042
> >   riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
> > 
> > [...]
> 
> Applied to for-next, thanks!
> 
> [2/2] riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
>       https://github.com/sophgo/linux/commit/e728a57834d06b9bbf9bbed69e3ea16416d257d5
> 
> Thanks,
> Inochi
> 

Revoke this apply due to https://lore.kernel.org/sophgo/ahu57vcS0oOFmCI9@mertle/

Regards,
Inochi
