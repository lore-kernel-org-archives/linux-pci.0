Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DE7A13A
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065137; cv=none; b=Vndfi2YZIw96OK8otkBluQVNcK3+vPMxcXw57NgkWIIvCgqYoiWX000WfXM2fafgzHeUN3nYQS+K8OZ5yGFKs3CSb0DKgzHW+VPQWPRn/dDGn/uL29+yjzDNSAxzL67p62KobHpiG8aawBITnmY4GXkU7M9ho8xqJze72MMTGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065137; c=relaxed/simple;
	bh=5ETDtDJCz2/lDp8wvDlrZGEs/wjF93z8VEpvhKcaLkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzOo5CbCvDrI3tcq06hE4b/OOu0mMqxU1olWha/7n+FaucBva4mmW0K3XRX0VlJpTikKhHl+F/8hiee/KkF9Gx+HXt8IIkaIdy5YXwEVkkgXr+m8oYPZN+hunbZZ7Mk7IpsJLbRlbp3da/O9HB5MAQc8eb4+VLX221JxUoygBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJicNbmb; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJicNbmb"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94acd026e45so69452241.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065135; x=1772669935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aT/CuULkbwm3ZtLWPS1iAQDnaaV5hiK+YKdLvwy3we0=;
        b=dJicNbmbFzjln2wLRpX46qfbBM2n2n/wFFl6homgO7RZ5MEP4YJ7YW++eNjF5e496y
         UlcNYPDrVzKoWc63TO9lZ7v+RnkaRZCW3LWVpR3+RrkTYkriOWaWwSK9DWXWqnq5HQGR
         BdEEXA4Fm1j6IJjLw1/lJy7lce0GKVZKXdZhYRX/ApHev61mbPu2TGlgrRFSaw2S6Kws
         THVjqYINfgzxJnLxQRJbIMt80wSdUxAgel77RPqvCOaK5X/jfq9xyRMyB6DmbHfTzgBQ
         dLrhCQV5eRWfj6PJBE2hGDLnIZPgpz8zZ41l1TWYwHj1wa2sl2B0Wm3jGjdgIosqNX72
         wQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065135; x=1772669935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aT/CuULkbwm3ZtLWPS1iAQDnaaV5hiK+YKdLvwy3we0=;
        b=rZ9qMGymFhcE551sC/CjPwhE4Yymwfg9blp/+7ZgLhh0narzDYA50XwjsmdQYVDNhW
         EUxTVB8jopQGYhK+y6Q4V83qjve7scGj0LM4BbdXWif7K3kjVHaBkavm1+nkZg8lY6t8
         02Ac4lOQqIqsNyrxOLJWfPBVjOj82LXWxiaQnrTvOg61rfoOntmLOAeccoNOD89KXauO
         AdZDXhOaL8u5qdR6sv7fmvcVwnKVanDa0Khik1GYh7Y0ryUYJYPxPgd2WBay4vl0AwOe
         xL6pl9kMRrZjU7asaS4Ciwu7XaLZSSMhqHmnX9ftsTrhLHdLy01sQ00gGgAvPPzC2dXh
         T0gA==
X-Forwarded-Encrypted: i=1; AJvYcCW3iZP5MZVK+lykrhjEEiKVM14WqAEKyxT9wz06pjARVzL3+pdH91qo0NJfQgzTBzF5wqaEB0L2kTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWNjuH12E2kwDinRH/Ij+HEXW7hQb3oFzXWEy65PpenTqjgFx
	Dm/tv+m1wowLIo8BJLUChpM2cnfESE3GqzhINhlv7EMAZ6zp4A9fMnwg
X-Gm-Gg: ATEYQzxtkJFOh9Xn4M36bOENNSjSD+KCP/iG63bJMmrdfjnsF5dUHtW1YwyqOzUYpiX
	cbNUNPUHUsJtLTTjHsZVlaRlm2Xcyx+OL46jNWz40GzqRA4f188seoFjL6Zw5TGhV5LzxNMDD2D
	aZHKjrTGpuc13iIySOLU6gMWn7cfgDKWY3ShmLjkCP2gf7/RekzWcrT/HyBGYVLO02L7o12I7UD
	OOVfNo0NeY8TiUEsaIHD2fR5jy9A/3fdurl/SiLwzAnRhCuO+i2WW+bpCgfk1ChGbE+vCkN2MeX
	kqtSNrSuY7pg0QpTZ4jKqEb+DEJMskDnb+DVP8OyXiZGTHbX1a5aTYVIXzQ2YSK3UepfL5u3lFw
	eQB2jvrGO1Pkav3CdHFahodB2Ph1w3egKzdvWlNVSzFxtKlhlkMWx773i1cQDVpvuKGQuHjpFQp
	g1ooZORLNWhw==
X-Received: by 2002:a05:6102:358d:b0:5db:3bbf:8e62 with SMTP id ada2fe7eead31-5feb2e60d7dmr7045155137.1.1772065135433;
        Wed, 25 Feb 2026 16:18:55 -0800 (PST)
Received: from geday ([2804:7f2:800b:f14d::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea6ea19sm612107137.12.2026.02.25.16.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:18:54 -0800 (PST)
Date: Wed, 25 Feb 2026 21:18:48 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: rockchip-host: comment danger of 5.0 GT/s
 speed
Message-ID: <aZ-RaBLVfEZA_FxU@geday>
References: <8db835ffe384db63ee598a203751b298ad1cc267.1772057799.git.geraldogabriel@gmail.com>
 <20260226001229.GA3794668@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226001229.GA3794668@bhelgaas>

On Wed, Feb 25, 2026 at 06:12:29PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 25, 2026 at 07:27:44PM -0300, Geraldo Nascimento wrote:
> > According to Rockchip sources, there is grave danger in enabling 5.0
> > GT/s speed for this core. Add a comment documenting this risk of
> > "catastrophic failure" and discouraging end-users from forcing
> > higher speed.
> 
> A comment in the code might be useful but doesn't discourage end
> users.

Hi Bjorn, thanks for the quick review.

> 
> > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> > Cc: stable@vger.kernel.org
> > Reported-by: Dragan Simic <dsimic@manjaro.org>
> > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > index ee1822ca01db..4faf3e29b7d5 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -332,6 +332,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
> >  		/*
> >  		 * Enable retrain for gen2. This should be configured only after
> >  		 * gen1 finished.
> > +		 *
> > +		 * Dangerous and may lead to "catastrophic failure", with data loss
> > +		 * or worse!
> > +		 *
> 
> Wrap comment to fit in 80 columns like the rest of the file.
> 
> Remove spurious blank line at end.
> 
> This should probably be squashed with the first patch; I don't see the
> benefit of having them separate.
> 
> Why don't we just remove this whole "link_gen == 2" block?  If we
> don't want to use it, there's no point in keeping the code.

Yes, I think I'll go with this second option and remove the code
block outright.

Thanks,
Geraldo Nascimento

> 
> >  		 */
> >  		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
> >  		status &= ~PCI_EXP_LNKCTL2_TLS;
> > -- 
> > 2.52.0
> > 
> > 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
