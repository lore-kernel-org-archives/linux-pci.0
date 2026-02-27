Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66228726D
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232455; cv=none; b=GqYIy2mRy7Dqqw41XAm02cnoNgXUMmcYGcMHJEy/57S8FMTC4J0z7fTbtkZRlT7YdPlfbfPII79SImZ8rCSfI/Q8v4e+5CHGtzzg2IaEPKV9bfHB9pfAe5QYF/3T4IySl2k5QT6v5VoVtdbPJFXb5ILJXAsfUVTKRpDp0KTEfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232455; c=relaxed/simple;
	bh=0OFMgdCGU7B5hBrb8XzSrkdIeEEvEG+dl8cgnT9z9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/cT1EqdyPoXvrLjT2Bsyk9oEV+EtMZNgcH0wkmnWH0SsU79hNmA9plOFkWPggfEp4ZYKOdrnh1t8D1Of7aihepJGggkAeUWfQvg5WY8Q6E1N+FuOQFVR3ze1/O2Af3a1g3zPLIoBXV/rOkqbCf/KVLV4ucWs/cqINTroJvAM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJesD51g; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJesD51g"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a8ebde349so2245473e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 14:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232452; x=1772837252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+TH6jAGK26TrEc9oITkY4dihAUESin1rX1KN45OKxY=;
        b=YJesD51gPmXp7QCQaoGa/HLWzj38Qplh+wOreH4d/Fp3SOGCmlAM0wlmvsVY3oKCKb
         kAEnUWzTbcssVI9j8Yi5nPbD4by7Q6ii1aWt9KsUFnSpbw8LhJ3wa7UvJO/jEvyV3/MI
         sRXEWnA+Hn10CDUxSj17Okfz+/5l+X0QGlego40WtjEJ921bTHifuShb7XAruyMYWSGd
         gYSWuOEXT5Tz6zcK2lhJZp0o5Pbo8EQXR8AZWGeXL8H8O5wvHWERsLheFF1FsU+B8JY8
         jqLNe+fzJQ9IXgdlmrvhwqawOKjTL1FLbrKF6oBeBO9NWazOE5DajMIKV0MC7VsP0adx
         MWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232452; x=1772837252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+TH6jAGK26TrEc9oITkY4dihAUESin1rX1KN45OKxY=;
        b=k88D1ymJlnx3BD/1hbfa9zOXiI2nc7aAgnlh/T7KtqWUTgzh7il9ndSkEO205U90Cp
         kf+C6q940hzfftLdIOrbh2vcQZb4gn3KWOJLVEMeEzp/bfEbbd7GdRDhlB9gO34grDaG
         VGH8pkbjLCbLI+Wzw+mXHbAuNXoj8P0frqbh93vuGU2h0XjZlAnIE9EX6DUOqY0qtBdF
         Sk2Mv/RQ+XmMrtaR0VwSztgtkV3WWoxfVq+Wh8qA9riTvg/lF3kZVvugiEJHxXxOh+qf
         bvn9RdO3+f9HXQAABhP1y3gHaAXQrOI8oEegiViqsHX3o+fC2trUioa0+Xo/nmdBkID6
         lpNw==
X-Forwarded-Encrypted: i=1; AJvYcCX4WLyg3EshutmqrEEqpTNnSsidjIObyT8LwM5Q6f/NbVf2kpH8Mt7uZI4ykp0J6ZWZrs9hMRtjqQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VlhYzt2urVPlJnMo8jG6QZ2zXk6yjRi1hHc0rprcstF3SsVO
	zVJu49hVsmlgQlNjWE9rOhkROVIZb1fqC28pn1uj14errXPz652feOmj
X-Gm-Gg: ATEYQzyb3945Oe8+KCTYYnwkRwW9cuLsGwRHMNh9zI0y9QvTOMUCiLzS4mPzgv6S6xV
	h/YbfTyQJ3bz4j+m7xyvUwoYdS8tt9sOO3RqGK93kOP7ia9Qk717AACZw/Y6w0qGJtlH4OSQlTD
	j0ODj1AA5oD/LuIwiXI3dPEiL9B1yKG8t2bqnXSbNaAi+JW5y5/J2rujSUxA+raFz+UBRD+gHTI
	ScGcIhUS1C5Mv3ETslKRJvklU+P5NgbSfHpqfgKykGOA3hqRWOqyFUFtQUdxQIwFww34J4OpFxl
	/a5d1UTXV1ntu2vC1J9Z4wVkSM7UZ5FoBOCHG/qY02lNxnATg/SSZemcZpHuuhVoljRYkgy6P9A
	+U2ix2Uqlm1mkJI9cuJgqx2c7csJxcPaUBRY/vUsaH/ZUljbXWL5uhPyW92pmGYIEcoZ3aMMtL7
	wAMCcDSKG9wg==
X-Received: by 2002:a05:6122:4b08:b0:566:3c58:efcb with SMTP id 71dfb90a1353d-56aa09ebdcbmr2825977e0c.3.1772232452162;
        Fri, 27 Feb 2026 14:47:32 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91bd2291sm8103706e0c.9.2026.02.27.14.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:47:30 -0800 (PST)
Date: Fri, 27 Feb 2026 19:47:23 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] PCI: rockchip: drive at 2.5 GT/s only and error
 out other speeds
Message-ID: <aaIe-_WCD7s6Cd5j@geday>
References: <cover.1772169998.git.geraldogabriel@gmail.com>
 <9e3754ee0d1f5bc8051e28e1a5b8c046440456f5.1772169998.git.geraldogabriel@gmail.com>
 <b44e454e-f98b-4505-5603-bfc4455d11b9@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44e454e-f98b-4505-5603-bfc4455d11b9@manjaro.org>

On Fri, Feb 27, 2026 at 06:33:34PM +0100, Dragan Simic wrote:
> Hello Geraldo,
>

Hi Dragan,

> On Friday, February 27, 2026 06:36 CET, Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > Configure the core to be driven at 2.5 GT/s Link Speed and error
> > out on any other speed. The reason is that Shawn Lin from Rockchip
> > has reiterated that there may be danger of "catastrophic failure"
> > in using their PCIe with 5.0 GT/s speeds.
> > 
> > While Rockchip has done so informally without issuing a proper
> > errata, and the particulars are thus unknown, this may cause
> > data loss or worse.
> > 
> > This change is corroborated by RK3399 official datasheet [1], which
> > states maximum link speed for this platform is 2.5 GT/s.
> > 
> > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
> > 
> > Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> > Cc: stable@vger.kernel.org
> > Reported-by: Dragan Simic <dsimic@manjaro.org>
> > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > index 0f88da378805..26fc350a66c1 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -66,8 +66,9 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> >  	}
> >  
> >  	rockchip->link_gen = of_pci_get_max_link_speed(node);
> > -	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> > -		rockchip->link_gen = 2;
> > +	if (rockchip->link_gen < 0 || rockchip->link_gen >= 2)
> > +		return dev_err_probe(dev, rockchip->link_gen,
> > +				     "Invalid Link Speed\n");
> 
> I'm quite surprised to see what happened here in the v4?  The changes
> introduced in this diff block in the v3 were perfectly fine, i.e. we need
> to correct any runtime occurrences of Gen2 speed setting in the rockchip_
> pcie_parse_dt() function, together with emitting a warning that urges
> the users and the board dtb maintainer to fix the board dtb.  I'll get
> back to this below.

I see what you mean now. Sure, this could be incorporated for v5 without
a problem and is the more proper way to solve it.

> 
> >  	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
> >  		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
> > @@ -147,12 +148,8 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> >  		goto err_exit_phy;
> >  	}
> >  
> > -	if (rockchip->link_gen == 2)
> > -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
> > -				    PCIE_CLIENT_CONFIG);
> > -	else
> > -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> > -				    PCIE_CLIENT_CONFIG);
> > +	rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> > +			    PCIE_CLIENT_CONFIG);
> >  
> >  	regs = PCIE_CLIENT_ARI_ENABLE |
> >  	       PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
> 
> At this point we need to check and bail out if no longer supported Gen2
> speed setting is received, which also applies to the appropriate spot in
> the PCIe endpoint driver.

Right, it is a bit of a double-check I think but it can't hurt.

> 
> To clarify, it's the responsibility of the rockchip_pcie_parse_dt()
> function to validate and possibly correct the speed setting, because it
> is what receives that setting as a value from the board dtb, while the
> consumers of that validated speed setting should check it, to make sure
> the speed is right because they no longer can handle requests for Gen2
> speed, and simply bail out if the received speed isn't right, i.e. if
> it differs from Gen1.
> 

Like I said, it ends being a double-check, because we can't let probe
progress if link_gen ends up being different than 1. Either we force
2.5 GT/s with a fair warning or we error out on the probe already.

Thank you,
Geraldo Nascimento
