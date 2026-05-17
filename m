Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FE81724
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778992754; cv=none; b=V9qrbkyK10GQNHzErBZAYVgE5ay4FX+Lceaoxg1RPmbtJH1diEV5Z194a4LvIdQdNAVkZmX76Q/pmklkycE67x44Fvhlm1MEbhVCLp8LRGL30yo5dubgKJZcj0HohCRrg2n1SJuMVzkll8Xvwi5wQxPcfye0R52ixFxFpl2el24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778992754; c=relaxed/simple;
	bh=B53Eth2f9zx7Ds38V+i6Tl5WwFoLUCpbyhLtK9uDXwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+7nkFRr0QOW2y3ZUhqds0ZUeSlxJe+Anoo8a8qOzQ3jG6zaSZflcfYKTJdYAEbqj+tybQ73v3oBU+LZaiF9fMNd+S6U/LvBih5vIlJu6IInbd75aVBxMhLAnpsvpg680J4AGMg42icThfn2ykGL08VU7ZWTfSM8s52NaS+mLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2TNqyPL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2TNqyPL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2baca4df358so6013575ad.2
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 21:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778992753; x=1779597553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9YiFxSU/JN6ra5dSPQegj5u+vVdgZzmNJtIRWj7eJHA=;
        b=F2TNqyPLYmFkC7mXZLNodbFbfPWJRrX5JLf5cvNQacuDtRx3DOUuHzARLzQF+GWBsP
         ILGeJxR/Zw0KU/LhZ1x5C3S+45hf1tQna5aJbVDKQU7oOmoSZU4INhpQJ7vjEqMWbt6j
         1R2cqUljhIHDxyP7wxAsyXOzJcxGFgdj5YvJhX6WgmLFV7eeugzlvaH4W6tpnEWrIY7f
         +TZSg9augzzhEQjrR0uNENEjx14bY+5mFMaHWTN7vgZO06xZIShtECs4U2CK/3Or7IFB
         13JBcTivaffuPUXpu5MpEctY7NbTisaEFQ7LOIywrBMo7/qSHsOLdIKEs7sU+SO3CvfP
         Ix3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778992753; x=1779597553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YiFxSU/JN6ra5dSPQegj5u+vVdgZzmNJtIRWj7eJHA=;
        b=YKGD7fKj1Hayl3pIoLzFIbzYDL030mC/aLs8aTMOIbr5IMEYExc2PSkl2vy6L2uzn+
         u22A11B1lzLIRGJ9mf1hSkIAd/+wzw0GN5A629YWuN51PAH4hNw8eG+xVJxmJSsnAxDF
         LoneRiApuH26VHfvJQZcKruB7wZ2f0yr33GBhabsN7luTbKhPTBusIeMpT+XgtVNoeP3
         xNRC21409K0Kj2cHXckPrzXBLEsbmk2dM4xAGFn7hpalpasEGW1zLRQHsadzUjX38zbB
         tftxA282FXXgXHbYMPqbeVU2UmNVRNZdfBQifK02GAD8/pmyTDTlp8w+ldFYms4QAsEz
         Q7TQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yYdtX2AK2eL657La5SoUmtIwXyJXizwXQSFLC3aKHvRRKaRF730/H6ryk9DD30JtfbSjM9yNj0vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+LhZ0uKoT7Iggz4knpbFGl4HY1dsBrIw6w1l4ENubCx0+NMi
	A088Cn3fLTsT5NDsqREI0rEg2LuY98ycj1tzKQeTWtUkqhSeJ7B7M4Da
X-Gm-Gg: Acq92OEjOZnRvWk4Kr0cJit7KSnNiOZgpkLOjvtZNjbLxsBAPzp1nZmIzna7hyZMEd8
	+Ne7E5DpEX5eA2BNZiovOH1Uvg9iqXKc8BaBX3rkO1/G2pqSlHB1kD17D6FKYNXwyNl4PS4fWEQ
	GmiiALpfFPOF43fXTp6Co95GLqxxNKhrnEiGm0B17dCNix/kCFAW9oSJp/F4mu99a7jeo1uKd51
	/eaBXULemv5bm8dHdeCk/ojXj+x3+pYR/UrnGQXP35HYoTFlM1Jo5GI9OGof0qV8OYoDQtCicA4
	lHSxbno0XxCze5Jjfai0n+fJUBTw9VorEn/HM84fV2ti+4xEHB9NuWG8+p5Sjo6pPrg+GG76o6i
	IjWP626cw8FJqY6RM/ld2MLqVUQLKCvu19DbQQtTjFD33ZQRpmXySUBjmpkwRx6mvCqzv2wpmmh
	mWm/fk4YHmbKG0VpFPKvFL9ehw7sloo08AxQ==
X-Received: by 2002:a17:903:907:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bd7e8ae548mr112810025ad.5.1778992752826;
        Sat, 16 May 2026 21:39:12 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f287sm143282535ad.24.2026.05.16.21.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 21:39:12 -0700 (PDT)
Date: Sun, 17 May 2026 12:38:39 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: sashiko-reviews@lists.linux.dev, Inochi Amaoto <inochiama@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: PCI: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <aglF_fbl--RgS7gQ@inochi.infowork>
References: <20260517014841.254085-5-inochiama@gmail.com>
 <20260517024848.4F346C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517024848.4F346C19425@smtp.kernel.org>

On Sun, May 17, 2026 at 02:48:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] The binding completely omits the `interrupts` and `interrupt-names` properties for the host controller.
> - [Medium] The schema omits standard legacy INTx interrupt routing properties (`#interrupt-cells`, `interrupt-map`, `interrupt-map-mask`).
> - [Low] The `phy-names` property lacks an `items` definition to restrict valid string values.
> --
> 
> commit 7b8ba34456e71d6a9cf1028caa5504d64e8f58ba
> Author: Inochi Amaoto <inochiama@gmail.com>
> 
> dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
> 
> This commit adds device tree binding support for the PCIe controller on the
> SpacemiT K3 SoC. The controller is based on the Synopsys DesignWare PCIe IP
> with some extra link and reset state control.
> 
> > diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > new file mode 100644
> > index 0000000000000..46147a37a9ce6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> [ ... ]
> > +  reset-names:
> > +    items:
> > +      - const: dbi
> > +      - const: mstr
> > +      - const: slv
> > +
> > +  msi-parent: true
> > +
> 
> The driver implementation reads and clears interrupt status registers for
> host-level events, and references registers for receiving INTx events from
> downstream devices.
> 
> Should this binding include interrupts and interrupt-names properties to
> document the host's interrupt routing?
> 
> Additionally, should standard legacy INTx interrupt routing properties like
> #interrupt-cells, interrupt-map, and interrupt-map-mask be included in the
> schema and example to support downstream devices that do not use MSI?
> 

The driver just does the interrupt cleanup as it requires, and no
additional interrupt is needed

> > +  phys:
> > +    description:
> > +      PHY phandle from the Combo PHY, the lane number does not depends
> > +      on this, since the number of lanes provided by Combo PHY can be
> > +      1 or 2.
> > +    minItems: 1
> > +    maxItems: 6
> > +
> > +  phy-names:
> > +    minItems: 1
> > +    maxItems: 6
> 
> This isn't a bug, but the phy-names property lacks an items definition to
> restrict valid string values. The schema allows any arbitrary string here.
> 
> Since the driver retrieves PHYs by index rather than name, is this property
> necessary, or should the expected string items be defined?
> 

The driver just use index, and the name follow generic DesignWare
binding.

> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260517014841.254085-1-inochiama@gmail.com?part=4

Regards,
Inochi
