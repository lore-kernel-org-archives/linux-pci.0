Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEF1A6828
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 04:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772684364; cv=none; b=lU7+bgqejF1AhifTX3VL+55yMJ5jbQNhMdnehUxpJ04LQ4aHhFnNH4+8CekTUpfJeK6devbprRa0hFOEtWvzHrEr/YEDS9be2dbxtZLYajS71QLnx71ISs/IksAcSL5zQ5hBiKeEYf/i+yKnsoamOD3p11Uq0GTbh3497TMle4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772684364; c=relaxed/simple;
	bh=YLMX93OqrPLVPWJSCEb4hxhP3JLrjkjT+PELt9gAHVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE9fmmOb2JcUutLk3T9wKYyz/l9AAwcDrb7OOR0j/mUTuXaG56Kp9nLuTU/4YuNT3RuQlGxUNf1vz+crY0tKbzcjLkXeoj7LLg0A7waVab06VBeNOfjiPey0dP4QrmFP0bQ56D9M0H4Cr32dTEHRiAlPAyiYxFh7DHCbTNifqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaIfmz0p; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaIfmz0p"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94de6081c1cso4635354241.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 20:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772684362; x=1773289162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcwLPgCuX5qGk1VO8dlUrj59t6r//UFI20kbYxyl5TI=;
        b=OaIfmz0pr/GOJnZ6UrTlAZlyZ84zmHR5mibsTnGDmjD3tieI3UCGpTrajeCLx2bkcs
         SOofoITN4oTEfjZQAyq44GzwYMogydLMmEbZHEnVjEAAFN0gK8W6nefXIBSbo5A901fP
         TmKsZ4/4WwNS/+azt5jNSjGMaUM4NGjTZx0oMieimIdi8wnDZMRPctSVmwE8L0c8R6wm
         teRap4imXUD/v3wiovjSFcs1OAdYISBrWIJfKlSB+D3/rKzhSVzUqq4EB9Zm24Up4P/g
         GYcjRK06IK+fD13R7WtrhF0y+we/vKFtUB1/1ZYlru/J5ZpjyDOJxHAySdc65R4nV2V1
         UR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772684362; x=1773289162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcwLPgCuX5qGk1VO8dlUrj59t6r//UFI20kbYxyl5TI=;
        b=K4IvcpeKA6GZ5hq6sfJrlPg+zVMDLTLnzpOJ3ZwuX4hjOTNM/Ry+TIzOFEbX44rSAL
         7IeSWMZIAreGD7YR9LxRSASAV5KXW2ygRf04NSgTIZqksRSbk3TD/jgjfwbdoC4XfzP/
         VLd3gzhOZgtYfoxwLGGqmSV17yYsS8cegrrItcn60yRM2bZYhCKSNvvx0hTu7IxTY8T4
         RUYcW95NpTrsZGuElHMEX5c90uDLHeuRscCN7u5OHTmC321RJRhB2vxgZ5U1ArRyO77/
         rN8+yYteHLyndCUHZRnumw84BQ84MnSR5curaf8VSH6wNCRRBWQQHw3HaFXyQXldP/Ro
         6w2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1LpQFXq0MRx2QwT5if6ke76LvVX6Ij8X5mB//zLLj3I2zK6qROvOcjKpJlgLzTRee7r7DHOi4Hx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvK5Ula6hZMy7557mb8z3nu6x1bkAejbMhHDi+wuiPH0YVgRHr
	ZrkEDSVhGaWs6swMd57ipDRfqmUoO8ZsVR+2UHP3kNLtiMMU2OLOat5j
X-Gm-Gg: ATEYQzxj23CpcyvdUumKMhg4zc8dtzz/91mvoefmqFMS96r3dFpxKjGse9o8T5P2HnZ
	mydaW/HV9MjqUi7PtnlLdzWe3GGeTBSWoLZajCii3A0IdrrLL+08hXSQWAKLMmgNtX36RV8zzbk
	XUXjnxJdcuGlITz7QlMGW3BOWe6bZqtBL/fVbt6oQAEyJOek5n+0Wkbl97vLlGUZOkDd2NoI/e0
	mrI7qggg5jKZaNiwvJw7GrmhEZ7PEm8qci4RAmtBwf6nXTSatZUHhUdM1Rtgd3y7IX79Lw5y+ob
	KNdKVaspulzfOL59nX19x0gtTqU0iF+RsunfLCFS1xdcYNKzUguEQiAt3T0A9hmSoekVDOkdp+w
	uCZgXJgv+Prkgh4ODNQ8GBS5YcCS4G/Gh+8sA9FsaghMPwBgCwRW1NdxBNDwyAmaBcouU2h29h1
	Q=
X-Received: by 2002:a67:fbce:0:b0:5ff:b8d8:b40d with SMTP id ada2fe7eead31-5ffb8d8d44bmr1248639137.21.1772684362172;
        Wed, 04 Mar 2026 20:19:22 -0800 (PST)
Received: from geday ([2804:7f2:8080:fd2e::1])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df6577a4fsm21273560241.10.2026.03.04.20.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 20:19:21 -0800 (PST)
Date: Thu, 5 Mar 2026 01:19:15 -0300
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
Subject: Re: [PATCH v5 3/4] PCI: rockchip: drive at 2.5 GT/s, error other
 speeds
Message-ID: <aakEQ_qtBbYCaUsA@geday>
References: <cover.1772239598.git.geraldogabriel@gmail.com>
 <2a0a4aa97bb8b0cb511cb651c5d66c9ec8bab97a.1772239598.git.geraldogabriel@gmail.com>
 <d2b91260-7666-3606-69ec-0e7cb7a48c02@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b91260-7666-3606-69ec-0e7cb7a48c02@manjaro.org>

On Sat, Feb 28, 2026 at 07:16:41AM +0100, Dragan Simic wrote:
> Hello Geraldo,

Hi Dragan,

> 
> On Saturday, February 28, 2026 01:55 CET, Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > Configure the core to be driven at 2.5 GT/s Link Speed and ignore
> > any other speed with a warning. The reason is that Shawn Lin from
> > Rockchip has reiterated that there may be danger of "catastrophic
> > failure" in using their PCIe with 5.0 GT/s speeds.
> > 
> > While Rockchip has done so informally without issuing a proper errata,
> > and the particulars are thus unknown, this may cause data loss or
> > worse.
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
> >  drivers/pci/controller/pcie-rockchip.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > index 0f88da378805..2f211d1f4c7c 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -66,8 +66,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> >  	}
> >  
> >  	rockchip->link_gen = of_pci_get_max_link_speed(node);
> > -	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> > -		rockchip->link_gen = 2;
> > +	if (rockchip->link_gen < 0 || rockchip->link_gen >= 2) {
> > +		rockchip->link_gen = 1;
> > +		dev_warn(dev, "invalid max-link-speed, fix your DT\n");
> > +	}
> 
> I'd suggest using a bit more formal message here, like the one below,
> which would also avoid addressing the user directly:
> 
>   "Invalid max-link-speed found, limited to Gen1 to avoid data corruption"

We really should spare on characters here, but I see your point and will
try to cook up a better way.

> 
> >  	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
> >  		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
> > @@ -147,12 +149,13 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> >  		goto err_exit_phy;
> >  	}
> >  
> > -	if (rockchip->link_gen == 2)
> > -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
> > -				    PCIE_CLIENT_CONFIG);
> > -	else
> > +	if (rockchip->link_gen == 2) {
> > +		/* 5.0 GT/s may cause catastrophic failure for this core */
> > +		dev_warn(dev, "5.0 GT/s may cause data loss or worse\n");
> > +	} else {
> >  		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> >  				    PCIE_CLIENT_CONFIG);
> > +	}
> 
> I don't think we need to emit a warning here, because, as we've already
> established through earlier discussions, the rockchip_pcie_init_port()
> function should never receive an invalid speed value.

Just as a lame excuse, those messages were everywhere in the mid of my
development, this is one that escaped deletion, will drop.

> 
> >  	regs = PCIE_CLIENT_ARI_ENABLE |
> >  	       PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
> 
> It would make most sense to squash all three patches in this series
> into a single patch, because they all form a single logical unit, which
> introduces changes that are just going to be harder to track down later
> if it's all scattered into multiple separate patches.

I agree, having all drops in one big patch is the better tactic here.

> 
> The only possible issue with the squashing comes from the inability to
> have different patch subject prefixes for different driver changes, but
> I think that's actually not an issue.  The long-term benefits of having
> everything as a single patch outweighs the benefits of having different
> patch subjects with separate patches.
> 

Sure, will do so for v6.

Many thanks,
Geraldo Nascimento
