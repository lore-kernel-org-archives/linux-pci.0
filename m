Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E52C237E
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232194; cv=none; b=C7UShZRjJrJdQDDDspcbXDUOgi7iKC7GWpWElPDkvpcifUtJyOKMjGJHWSKaJPSNNBjQ1ztlFWToael7f4zvts09al6BBk72QmGtKxLrtRKZLyWfMeFj94M2R+Ix4tU1mhMTG9Q4KY1zm69hAx6CcHNYiaOvUhuhir19cHufY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232194; c=relaxed/simple;
	bh=0jrF4mv+UZ6lC1GT3jMpg4esmFEJ4sJ+l5v3+gfVwuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgSC0l0osF1p4HO02BxdclxUY+XYUhXhqYbZTotvChszmbtXpIWxXHa+Kz4ebYKk+xBhFADB8tGBd4oz1YGOQ8o8l5dhA2oqBExmKVALcFJiyVCb2s+bnG1CZazJ7e+PIqFGT6WTDL+OpiMYCRzP8Gs9hyPPUDWIqqeQoBFr5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaIMZzcV; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaIMZzcV"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5674cd243d9so2765485e0c.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232192; x=1772836992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrjLY/bl7kBvcwxLrBNZqDnyVSO3SRsmiAQG84aatrI=;
        b=GaIMZzcVtmfhgq6zIR2qOFHVxU4WcKzXmXFkJ6gL1elNXbFRby3Rm+fVV8rNEKy6/u
         uDxQXnT1kI0agphMDCwsUUnQpfUk47GeOB4nSYmg/iDzhPVogi9zh2L2Qv600fyCfDgu
         GeC84Z8Dn74GKhF6Y8FE2Z0PRfoFh4Pten20WIQEHc9HyQdc8Oup+amSsixKeE2G2y3S
         8X8vIZ1KGQpCwJQflKxwcpeJ2fbhvnYWGexUYQCr2GadIZj4AdpIPGX4R01/FqA4EfHJ
         CyAMTtPxmxggIv5ISu8x73gdiHIdJkbljd/jmoDTrQcv+rIfA97KuE2afJmmjdcUMLKc
         K49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232192; x=1772836992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrjLY/bl7kBvcwxLrBNZqDnyVSO3SRsmiAQG84aatrI=;
        b=RPd4LVSzkq9qONrLO/OpqmBj9T5xMB+9e7rbbgh5en2g0oRm4U3NUR1q1SKqTL1ZWp
         QPektkY2hzw2uHH1Gt6SfLFd0oL3oW4AW1az0wO+LwGX/46ok7Hkvp/WrA8XWwcQJEsn
         wTGHUVmanw4Hvnc10EK7IpGWCONNfx76/7itZLR2wcPyhqGGwsrlir+E++/gw6qoztJG
         VAii/jGu+vst3SlNG9pFK5kHTzKfArB87u8RMPDOswq2EctWSsMb34EJN04p80o31bEP
         w+XXmLMJgFsA2i7gkZziNx55GfV5m/HpdQMEooY69NPgQSeswzJv9uo8mJItfKvyGZtJ
         X6/A==
X-Forwarded-Encrypted: i=1; AJvYcCUg8lXgvrUCNgoJlsSCQnAZfeLIPWH9Ur53Ag25MiAFqMaf0ksT6KsBQgm/hLMQFhpQzovN73qhyG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0SvCsbspx67Uv8PKHdhzx04sBtgpGu/1HIkpDFj6fO3vnCz7
	FZSWSxDjSV6DuMOkkymq750rDXhT4g7J+Y4wWmkx1PFWEVly55uTCZQU
X-Gm-Gg: ATEYQzy6m/lGF+x6UZebjl1S92VkhD5Ioos1ArcfzQKulxdbyJWZqZX+kcv5Qx7KmFc
	aM908LtjkvgjeCMjRYsSSUzadlVu+DbNZONAH7XlDfRYlTskCaSU/wcRXfeTC4rTQR8U/bJgyFJ
	LfOjfoplSQeoEaHSNlz4uG+CH2ZsSiMKUz/79KsDUTYvwVsCJ8YNa+m96Ixr/ZBgDKlIIGyOPDV
	oXJ+h44PClm+v/Q/CGNyH3ag/dM8SIdfQObSpEbxWWz6sKNP5b/CrUAHj8kL5REEtkyB457QhqS
	X3gaIXq2j8LziAxoQCb3pr3++5HqROkWjpITxtfhgS7sJ36CsjvrENfItpSJ7x7EOBwf75YHZ/g
	vkGpnY7jNMVH1QbNZD4m9Hra/UyZccXWwt4OhzjSYMNQwQEIR0Dw3/zTy96JHMOOtHMp8y+MZPg
	MHVm9NWQBfrA==
X-Received: by 2002:a05:6102:e13:b0:5f9:39a6:3c13 with SMTP id ada2fe7eead31-5ff1cfc9d0amr5029522137.19.1772232191950;
        Fri, 27 Feb 2026 14:43:11 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df645b877sm5967626241.8.2026.02.27.14.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:43:11 -0800 (PST)
Date: Fri, 27 Feb 2026 19:43:05 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: rockchip-ep: do not attempt 5.0 GT/s
 retraining
Message-ID: <aaId-TU97Z8f5Mwy@geday>
References: <cover.1772169998.git.geraldogabriel@gmail.com>
 <c51c804bea56d772a59fd29fcb080541b7a367d2.1772169998.git.geraldogabriel@gmail.com>
 <87zf4ujf5b.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zf4ujf5b.fsf@posteo.net>

On Fri, Feb 27, 2026 at 05:00:03PM +0000, Charalampos Mitrodimas wrote:
> Geraldo Nascimento <geraldogabriel@gmail.com> writes:
> 
> > Drop the 5.0 GT/s Link Speed retraining code block from Rockchip PCIe
> > header definitions. The reason is that Shawn Lin from Rockchip has
> > reiterated that there may be danger of "catastrophic failure" in
> > using their PCIe with 5.0 GT/s speeds.
> 
> Patch body says "header definitions" but the change is to the drivers'
> source. Maybe you need to reword in a way that is clear as to what
> happened?
> 
> Cheers!

Indeed, I was the victim of reckless copy pasting here.

Will fix for v5.

Thanks,
Geraldo Nascimento
