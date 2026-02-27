Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382482DA749
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232130; cv=none; b=fDdAfwtSAMnBhFdBDydHN34CGJSRQAaSGUXXJ2XxVcUFqJMaxoVErHXmlEW3RJrFeEo/xOk1sYGiR9RHRN+VP8Kl4tb0BaDERKNXuG5zuLAoxDdQK3hZq1cywP/G3o00ZBSM0+JUUmpscqFlIS22vPjUSvM+pISLY2elA+fwypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232130; c=relaxed/simple;
	bh=GGTHCQqtWNWEf4/VgXYvCG4Jv/erlZY7q1egpAC/z+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ5saxSd3H2t13qoh2pYH2lPRYYil1XF40KRRG4gzxIB2FdYFXdx3T2C2RfOEmcMfJC0lzwNT/PsibQ2OHEnf1cFIpWZYBN9Q+Nq/K9AFeloP1/A1bf8j/UxnXn/MJiGUE2AtN+irLxwblFbr3VJ8gM2SAI0iFhRsx6aHoxLUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrITStiU; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrITStiU"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5ff19e7476bso819687137.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 14:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232128; x=1772836928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSRwxud/Sjz5N6XXPU8dLJmT5Ixl2X0gYrwgt+M20jE=;
        b=VrITStiUzcESdGuRuH158lwy54cZFzPINpsrhM1v7qbZiv3wewrmTWoosiVRh41Uth
         w8QT4gCfKBIVLuLAQeVJykvAfCx7ja3lFqGNzFa/drgXoZJXkzixlXJ+T6gIqAOnllOV
         0DHsw3A+svSxKdPZG7yKcA5webvpctemIa/0fuY43nb9UCt+hKbQrX1kK6H0fpJ9MOWx
         oyI7U0Oc9BdPsooMss8EttGalEbghZPz2YDIogZlrfWtRX/3CTdeWmNDNAqpJ6VOCthL
         fdX2pu0/BI9DMIYs1P/kOEhrMTz/OrGn2jMHnE5xv3B20tzW/hhZXhntnM0fjdrwjqt2
         6FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232128; x=1772836928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSRwxud/Sjz5N6XXPU8dLJmT5Ixl2X0gYrwgt+M20jE=;
        b=CSJGBnpy84Hg09RbRzpeBlhwJgmkl4Trp5lNJxCULwI6yiefzhP1nHPtgniZHSaP6W
         aX0fttahaO/T5F36aqVjs3+c9s3/Qqol+Rb++q0GkoqSAPqQiKAoEWI5qgg0jeRF0rr+
         mc4gfUKiLH5w/9LlEKwOQAmr1VY81MT99S5GXb//OB+7UeHEi0Ec16njL3Q2DN5SRWsa
         Oa+mlijH6jyvE3ktfjvj/IGYLFEvG1XvLtYxf99gs3YxHFgZWNv1sMzKwzkAAwjRDqhO
         Aodpc600BQ0byetLeKcPa4lFJsoYyD116wDKfzI8lKkHpwFk6ljcwZ3g1tb+pdpuUpxE
         y4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHF8GhJSFda9xHghrkWl0nqOrK27RSK+JXn+YKW4O7aN25580eg3R7WgziVMdcRoY9UNGo9o5ZkFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9L7wj09Od0iyrHcbI8YV2htGgIqpw/alCBdjrTjRyGoHRbQ0u
	tg/V6ls5smEMBWRpQOXKA/mADFxR6XNP8eTx6M6jJjHFy1tpdnyoA/Ai
X-Gm-Gg: ATEYQzwF7i2/MrgTdowIQj+9dFSk1SEJNnI21xa2wvSiBGNzfcMukC5l6em8uLViNkY
	e53nyH4G57djDYIkwzBRsdfeX62JX8IjdN4q2vY9xh7R7tfD3pzs9yjIZem8kgIZxIvI2aLtqL+
	aATTMXRO722z/QmJU5Vcygj4/XfCeXi6152K6gSMwm4KDXIeJmz8kH4hS8Y/9vPo+z4N19lmnQQ
	V3H28/JdxZ0WYHytpcUJRR38rwikmEwO9NcJqqis1NtIhUVrblk8jY/TDjZ1bn11YMoBBuQMHO7
	ettcCknts2izA+9v9BFOkc2XqkrfsjEfX6n1BNKLWZrumJIEINW42izNuvz33a0Oym+qGDvzJv4
	WlaPVmfmPCQAoR6IsyKfz2NgcoIhfBhYQMMSLO8UkJ3W/2bzb9JzylEpkyXdPWNVrNUKI114vPM
	upQgnhN3B5jw==
X-Received: by 2002:a05:6102:3f42:b0:5ef:b3fa:c89a with SMTP id ada2fe7eead31-5ff32537f8amr2390137137.32.1772232128028;
        Fri, 27 Feb 2026 14:42:08 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df6577a4fsm6403120241.10.2026.02.27.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:42:07 -0800 (PST)
Date: Fri, 27 Feb 2026 19:42:01 -0300
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
Subject: Re: [PATCH v4 1/4] PCI: rockchip: drop 2.5 GT/s defines
Message-ID: <aaIduRsXvcUZrj8E@geday>
References: <cover.1772169998.git.geraldogabriel@gmail.com>
 <5172389ba8d291fe05bc0887bc97fe73f110c5c0.1772169998.git.geraldogabriel@gmail.com>
 <878qceku1j.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qceku1j.fsf@posteo.net>

Hi Charalampos,

On Fri, Feb 27, 2026 at 04:53:00PM +0000, Charalampos Mitrodimas wrote:
> Geraldo Nascimento <geraldogabriel@gmail.com> writes:
> 
> > Drop the 2.5 GT/s Link Speed defines from Rockchip PCIe header
> > definitions. The reason is that Shawn Lin from Rockchip has
> > reiterated that there may be danger of "catastrophic failure"
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
> >  drivers/pci/controller/pcie-rockchip.h | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> > index 3e82a69b9c00..b5da15601b58 100644
> > --- a/drivers/pci/controller/pcie-rockchip.h
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -42,7 +42,6 @@
> >  #define   PCIE_CLIENT_MODE_RC			HWORD_SET_BIT(0x0040)
> >  #define   PCIE_CLIENT_MODE_EP			HWORD_CLR_BIT(0x0040)
> >  #define   PCIE_CLIENT_GEN_SEL_1			HWORD_CLR_BIT(0x0080)
> > -#define   PCIE_CLIENT_GEN_SEL_2			HWORD_SET_BIT(0x0080)
> 
> This commit alone won't compile right? PCIE_CLIENT_GEN_SEL_2 is still
> referenced by rockchip_pcie_init_port():

You are correct, thanks for catching it.

> 
>          if (rockchip->link_gen == 2)
>                  rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
>                                      PCIE_CLIENT_CONFIG);
> 
> This reference is removed by the next patch in the series but not sure
> if we want to do it here instead.
> 
> >  #define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
> >  #define   PCIE_CLIENT_INT_IN_ASSERT		HWORD_SET_BIT(0x0002)
> >  #define   PCIE_CLIENT_INT_IN_DEASSERT		HWORD_CLR_BIT(0x0002)
> > @@ -197,8 +196,6 @@
> >  	(((x) & PCIE_CORE_PL_CONF_LS_MASK) == PCIE_CORE_PL_CONF_LS_READY)
> >  #define PCIE_LINK_UP(x) \
> >  	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
> > -#define PCIE_LINK_IS_GEN2(x) \
> > -	(((x) & PCIE_CORE_PL_CONF_SPEED_MASK) == PCIE_CORE_PL_CONF_SPEED_5G)
> 
> Same for this, references elsewhere tho.
> 

Thanks for pointing this out. I'll do better for v5.

Geraldo Nascimento

> >  
> >  #define RC_REGION_0_ADDR_TRANS_H		0x00000000
> >  #define RC_REGION_0_ADDR_TRANS_L		0x00000000
