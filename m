Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090594;
	b=h/HC+jHtUTyKEQQN4GShPX5HvLtFjfcNQZYfhOKEkOktY9kPZkQL/EqybKS8dlINyHLJ
	 YrCWgPrAaNaAUpxmyj9p6giL41YMAAuKTwmiekTFhBGz/Xe/1hTDcBkhdVXDJpz2t01hk
	 4ATd1JxhxOet0CW6fyGq23urascZN9irRHocv0JQ8lUkG3xfK8Kc+Ozq8NQ2RV9rxihUc
	 SeJeYKR+wD6wqMm9jFWPJ4h2oKJLA76WPQvYDF7BhBX9QWLzLK7A7XxGIU9ms3WtfB5dH
	 zdsG2egn4YpGe1schedm/jmf4GXM4SkQ0X/luofLTTg4Z6Lgd9+SRAmS3C3B+ZOEQKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=y3mTGo6FRBU+gYpImJ1+JuKUhlGLGeu1U4jVbw/Cy/I=;
	b=G41kh2ijWw5fhX4km4gzwqpV/oA00Dw1dMfH2a1Op7e5Fxf0Ehet+XQoRHYVWBnRRrvV
	 VEvJ6+YMNMbFqoRdTFNdBwhkUkBe+/kG31V20UUVVj4d65QESgc5fWmZzNSiouaiParz/
	 xbDoiKrTHem3S92reP3Ou14wnpmm0UcqqeYaxsaoR2IIIwk4bkdIsK5s6RYg9r8AE+JwH
	 C3t0M5oo7Fj7tOqAfNsTZ7u+oXEsvGxXhqUrLd/WqJzoQlM4560Egj7mT+PgYCmVbAlGR
	 RHPN/aZqZiJAGwI4d9EbAAZLiGiwudob07/cAj43M4+8mtTib9in8buxwVwFp46z8QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U+MCwusp;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AF606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 08:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708AF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U+MCwusp
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e60f9af6e6so33181065ad.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793090594; x=1793695394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y3mTGo6FRBU+gYpImJ1+JuKUhlGLGeu1U4jVbw/Cy/I=;
        b=U+MCwuspKVOe/KK7pWHUDK/JipbXiKDqESILed5yddyrB8jzOGCrRR1HLo9CIC7kpN
         YWW6ShXECFbKW62LREn7LHMdFXmrBdFoH1PLM62ubh/E5tnQKus8h8su1aUN7ckQH87o
         p+Nim5cuJl7XND8KTbx9UljIYReLcStP0wC+Ks5OvKSGRRQQZO8OlvL67yNQF/qVrbI7
         pU+PRwVQS5/z+jHby7XUUYDajwViLkC/Z/JNNYTRvtgQPCxs5PJiQUMEtvqE3EyL4Fbr
         HeX3QTP33FzySauLCgmMRbR2R/8CyCYzbFMsasZB2w0968yQX+VS18im2KtMPnH4mmKn
         DR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090594; x=1793695394;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3mTGo6FRBU+gYpImJ1+JuKUhlGLGeu1U4jVbw/Cy/I=;
        b=sO+ccM0U6Vk0hg61/Vq754UwhPLpiZOTjrmX3Ryi6iuVDi9VI1jAfbOGB0Z3AQcrGt
         8LgZOvgeQyw3iS/8pbHk4Ei6hEtDGSVfkNEfYgFGU22RM5Jp2W+DUvKAOtXmn7WRlNPt
         eLoRhVa+JSog16+4Aa04rEyWqCnLcwG3b7m9Z4X9H89aQqPc+jk6ne74KODFqR91lBNn
         z+VqjrbDhx8CqG/nKRJYBVnl6i4yMW7Nj2huMbVBoKPSGSnYPZXp79rYWKBMMmiKEEAd
         W0t1Ze3UH68R17VUG6+CxkeUlvjDO/M5sORJ6I6hwRSzP/26g2riFyBOvSe/Tj03glCt
         ZjlQ==
X-Forwarded-Encrypted: i=1; AKwUvByTgrdg72ZWT1+myFkdwvZat962jL5Sg1D6nhV2mrEEAxFAj5i7CrgdDEeafPFWmCf7U9aR+cEsc+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfJTD8qKNWaQnZ/gjWLI4f5z1/QspK4UzejZA69X8osgnQZuVw
	OVwcwi4dXCF96BHV0x0/ua6GZZFNja2VEcVaaObnFiORpGLPvzDgZcwB
X-Gm-Gg: AYBFou3dC91VhQzTomMQHTyh8wyyN1P18ocfK20Vi8saFDyPzFkhUVfpkKsQrL9yTf4
	K7QxTMMLcLzQ13moXceyl0FyZdRVLebo+gPpGcG/kITIcVhcbb1RYCADRzchtdb3GmVtZXbowhK
	rUbFJdwTm3os6fY8c9uSQem3QIj1UvqWizmzsKwpNl2DItF1RuY87HGhslYEveT5NVcrCFYxecH
	7Y7dxTNTEzw4DEz6mcGFlh70Bspuw5rAtVPQClmtvk7BIF4ZCAM51Q2/NWKrObhW/VcrEMiHBOw
	cknoxjrgFDLrhaBIqdXN23sPvicB/Ydu0z1FPa2+XhqP+zJrmSRBoqzVOx43Wi/GAQmM5lqX4Ed
	vRBrL3r6ryAMYAhwAdTQ26aE9SztjGqg13IN3DMZinBQaStbd4RLSbkADVrFxjQJdDPvQxu5ndB
	tgZQx4XEHmGiQe0cOuSAtO4XtTfIRG8PH6B8EbQDb5oRXqJDOqZHgBEdApscdvbuwwuLrDEHPNg
	xG/as0VQTGsq3zznmvqrJibitYYyyTYoAqodzp//gmh6HNY0tSyhAipM38fdd+G9YduUqK6pAV9
	MLwHYzE+jGR+aJW0wCNYaARumujY
X-Received: by 2002:a17:902:f68c:b0:2ea:cb4f:fd3 with SMTP id d9443c01a7336-2eacb4f10a9mr43735615ad.4.1793090593725;
        Tue, 27 Oct 2026 01:43:13 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c3d17csm5901625ad.53.2026.10.27.01.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:43:13 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:42:26 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Niklas Cassel <cassel@kernel.org>, Christian Bruel <christian.bruel@foss.st.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Randolph Lin <randolph@andestech.com>, Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Alex Elder <elder@riscstar.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Vidya Sagar <vidyas@nvidia.com>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v7 1/6] PCI: spacemit-k1: Add device data support
Message-ID: <auBj4o6t_RyT3wfk@inochi.infowork>
References: <20260929083755.458238-2-inochiama@gmail.com>
 <20261019164108.GA2177470@bhelgaas>
 <athuYJjPMkrecGm3@inochi.infowork>
 <atiB7-u5bxJbf-1q@ashevche-desk.local>
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
In-Reply-To: <atiB7-u5bxJbf-1q@ashevche-desk.local>

On Wed, Oct 21, 2026 at 12:12:15PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 21, 2026 at 03:51:20PM +0800, Inochi Amaoto wrote:
> > On Mon, Oct 19, 2026 at 11:41:08AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 29, 2026 at 04:37:47PM +0800, Inochi Amaoto wrote:
> 
> ...
> 
> > > > +struct k1_pcie_device_data {
> > > > +	const struct dw_pcie_host_ops *host_ops;
> > > > +	const struct dw_pcie_ops *ops;
> > > > +	int (*parse_port)(struct k1_pcie *k1);
> > > > +};
> > > 
> > > Does the "const" here add anything useful?  This patch suggests maybe
> > > not:
> > > 
> > >   https://lore.kernel.org/all/20260911233541.1650895-2-james.quinlan@broadcom.com/
> > 
> > I am not sure whether the compiler can make use it.
> > And I have not seen any explaination for why no reason
> > for that. It is good to have a clarification.
> 
> These const make no sense. First of all, the third one is missing it.
> And I have no idea what would be the proper syntax to add a such. But
> adding a such make it clear that there no sense to have them. Either
> you make the const the whole data type instance on the user level or
> don't do it at all.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Good, I will remove it.

Regards,
Inochi
