Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960390;
	b=2cAMr3Cd28WycAmPjQW562OLVSrAB++Z+/Q1Zvf7QmwViTvXgtcQcBVZqCGhQXJu/hY5
	 2cgcHjM2pgwXoU73L0F7CyGo9+WsPVqbOvR4qQTOPidxaiAQMa0jDnSiCkQQwr+5oF4FO
	 lmcl4q5v8xLTtrqyfxKKPoH4gZZS6n5fM9s2lfdgYEx8yyc2l7HuVvQyfVjMYK58ZrPVT
	 ftDOz3ARXIbMR9brQaXPYjWbUEa65CNNjthMkzTGq5IhaiUj4sTzYviyeuAmREH+TgzwK
	 kyl/tWTt6PcoxB4YJaBVctxsBQui/0TQiC5Ebp+GaVm490j0WtdfWWk2SuenESTraeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+xymGBMHB+69JfGsfO7yJc2L/tC6s5DquTHBRYW2RuM=;
	b=heeNyxSbWGpYc6ubHY66dUUUEJrleArDW6Fcnyt741aEuTwO0xAq+3tX/j3j6p0C8m1K
	 hf+mZdX9EouP1a4bvIYY9rlbNK9z8T/TS+tbt4w3aub5/XaxZ9beCtJ8Ba5tqMarQxYtV
	 Ji/wWySMJlq+NCQ1uU/JoRT+3HqiTv+RrqmyljT1cvCTcKaoxwvOvMBauTFO37DYN5dIt
	 JDdRSlaAGhyF6AGb/WlL7UJF3uQAE15jkMpH6nAW+gaDcxcz40Qv60UAWHfJiL+H9qNAT
	 MAbGHD+Io6ny+RMHI0zUcAfdHRQrjzheud1zDusLCCDgztvlYVuJ9OpCygjMLtBsDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UEquQA1G;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61A606A32A
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 00:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D61A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UEquQA1G
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9f6a16afcso12415ad.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 16:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794960388; x=1795565188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+xymGBMHB+69JfGsfO7yJc2L/tC6s5DquTHBRYW2RuM=;
        b=UEquQA1GKaFVZK88VYdviZy0Zd0/BVA+h4rqojd8tzowKo622JYGb5eLgoDDju4ge+
         N0SzNcmvvbwRPejifezn4wO+yOUAMLdZXzGH2bN7sr46DEvDrXw9qrshLLxfWJSm1sAd
         j+fZ8m3hY5qaFDFJL88f9O0WKh9D8xuBCC7y2b/+eJJ8LYmfZUPu8UiAZjhqBIcLvAOx
         5UGuieDAVUezp94H3qKjJjJM2ouD/lUopTUEfHZHEtZSL4xvkz4MRxtqWzp44wZTarye
         XZzpMKW8+DH2Bz8U4OFX44AhEqXhDbASX72T4QpN1eKMoNQmbacBi2pOkCk9zyg1h1Xh
         kZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794960388; x=1795565188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xymGBMHB+69JfGsfO7yJc2L/tC6s5DquTHBRYW2RuM=;
        b=Pkm4139NSaQyzA7r5k3mkgrGm6amTR0+mVCSndbezydDYSqSZ/q6Q5SYreCex1qiwy
         YSBRvTyZy1n1Rh8fpk06g0ZWcjq1oiYuWcY/QDBl1V4aNQvlvqFULk089rRBIhD2XMBc
         wwd0B+LfWPNrolHgQdzyYuCwe6IGGDj/ZRYcOMKsI92Imfjl9naubX2Cj5zGOQT0EwUE
         D5NQZnp3lcHOMkt0Qyeg/z7i5GaiMiOLNrrXY1GnkayCq+ivG9+K9hPkh+GXDdcfMoGs
         VlkvByr2llbaxLZ9SEbmen3Kk5OZPUNiw0LczXB7r/Rq3TlJb2aoDob3uNXasZWl04Ez
         3wxA==
X-Forwarded-Encrypted: i=1; AL+hErFQ7CCka/EH6serrim8QzxSGj/LQMbfdaOO0ZsL+7R14Jl+KAiUgywITzIihTsRk1XdhhbLQxTmomQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Y9GyHrwbHfS3vjIC/9ewmXqT5EAWz3fTwRuqG2Ffity83AvUx
	U7YaB4uGzqbfCkC4OoCTLmFU+hpugHVp0URvq9FWxBxeDqEfhthVjW3Uoxjj5eO2TQ==
X-Gm-Gg: AZFdTZfOuuVhBEX80U0kxlmc3lTrOZLZHd7Z4LhfOwlhcRxbr9U9upb4FX0BSOikIUs
	FIbYFrtc/Pu7AIdugrhTx+9kpPqg+QqZwAu3IA8/SLiA4OLvHXBwVFdr0LdS7twjH263XI15u/G
	p0X7ycIIrZ02vhbz35/FoImavMEwmBqEbbWhYaOFkddEvkbrUWK9ZKvlxabS/gQV5+ffRS8mpa0
	6TnHVhVT1K6XVzvRSNhfLqv3TVe8mkIkJf5OXlh0BcbZHXu7OdLTasR+AYkS/a5Rx20KbIwF6kh
	WM+rhhpLi08v4TFO9wSYaLbbhCi7MtffTlKXOKbIiuJzZCrXgH8Aivp41v/rTtAZDe/iYHyWlxd
	wuSYFZ/CpoaEeq7TeRcLKxn2bJCEXFeKalDLU862Jln/c+ErRG3ktSm8VHMcW9eP98clALYfmNK
	8M2CP09NOPG3s+Rx41T/CqK2XApY1gkDZecRo2jmmP4AL/2fUncJKAaXnMAJzaWC3N/0F3qYQws
	xW2d8fRENCkRoEDTurbm0gEM0UkNFaEBhXRrl2p8W198ILzOi457d+0fleP/yz2EUDI64NxwMJq
	JxXbS8Nj3C9/ci7WXn/bQAaN9BnybZSG0WmF9vXh/AibQcdhknE2sSWt2FVyGCWBqps=
X-Received: by 2002:a17:903:3510:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2eff77a8714mr2438805ad.1.1794960388076;
        Tue, 17 Nov 2026 16:06:28 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d19b5e8asm1142449a91.8.2026.11.17.16.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:06:27 -0800 (PST)
Date: Tue, 17 Nov 2026 16:06:23 -0800
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>, 
	kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
Message-ID: <20261118000511.GC2250529.vipinsh@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <an0BOyexLcOjFJw9@google.com>
 <20261117225559.GB2250529.vipinsh@google.com>
 <avzfBjBZiOnJUH4W@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avzfBjBZiOnJUH4W@google.com>

On Tue, Nov 17, 2026 at 11:31:08PM +0000, Samiullah Khawaja wrote:
> On Tue, Nov 17, 2026 at 03:02:00PM -0800, Vipin Sharma wrote:
> > On Thu, Aug 13, 2026 at 10:30:45PM +0000, Samiullah Khawaja wrote:
> > > On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
> > > > It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
> > > > while SR-IOV is enabled.  This can not only result in an uncoordinated
> > > > disruption of the use of the associated VFs, but the ongoing use of and
> > > > access to the VF has the potential to result in machine checks.
> > > >
> > > > This series proposes that this gap is largely an oversight of
> > > > pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
> > > > violates the scope boundary of the pci_reset_function() API.
> > > 
> > > Hi Alex,
> > > 
> > > Thanks for sending out the RFC to fix this issue. I cherry-picked it
> > > into my environment to verify that whether it fixes the issue I was
> > > experiencing and it does fix it. I will continue to do more testing, but
> > > when you send this as a formal v1, you can add:
> > > 
> > > Tested-by: Samiullah Khawaja <skhawaja@google.com>
> > > Reported-by: Samiullah Khawaja <skhawaja@google.com>
> > > 
> > 
> > Hi Alex,
> > 
> > Is this series still on your radar for formal v1?
> > 
> > If this is the direction we are going in I can use it for liveupdate work
> >  https://lore.kernel.org/all/auzftbPFO_6XBYVw%40google.com/
> > 
> > Thanks
> > Vipin
> 
> Hi Vipin,
> 
> Alex asked me whether I or someone on our team could pick up this
> series. Pranjal is working on it and will send out a new version. There
> is some extra work needed on the IOMMU side to make sure that the device
> is moved to a blocking domain when the reset is skipped.
> 
> But I think the patch you need is fairly independent and can be sent out
> separately from this series:
> https://lore.kernel.org/kvm/20260812045325.2733631-6-alex.williamson@nvidia.com/
> 

That works for me. I can send this patch separately.

Thanks,
Vipin
