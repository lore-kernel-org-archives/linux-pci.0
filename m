Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D73A0EBF
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715975; cv=none; b=OSrGkIP5Ha8HyZNh58Lfd6pxpOLZByOhpx2zF26Bgf+ziU4gQghuQeEF4MdEsaFy/abdz6HS5RCfnR2iADKrvDlBifnVKKjUHalRHCZOhPuYf4YrGzpY6fC6kgMeN8T09tu9RByuNe/ruX84z3hRCXDd4+i7PjAJ2CTBs4JOnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715975; c=relaxed/simple;
	bh=An6z6pGF00+43VUaOecTwb49LKqdBH2wGqINr17mp5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S44yDGumbdutPs8x6BVDAHTiKGRB8v00TYFfdyn5g1aSnkhX22wkjh4z3zMCmDTGaRjsAklQYWJMoZ4P61jzi4TRt92tY76RjNBfO1Qv0XI/4Y5b/YUMhkuXaMxy5fffuTj2tku2NlpsqBvOlhrGKTaBEcY+0fHUhSvv5Q/JcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso602067a12.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 05:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715972; x=1773320772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/3ao61LTSp6jCCF+e+2SF+gp23jwVu9a+x2K0Dcxpg=;
        b=g8AB5LAgNIUzZCA9sx3ikWIGk646Rx6HOJGPlaCxBteezAQRHjGfq0h0YqHCvrDN6O
         htGdOjesNvUFsb83NNMbnWxhteN1lTTt7+NrQYLf2ZW66forVxYEmK6gj2pz/sgeDU9c
         LS3T7yehhn4Lkn8MIRaT+oIxP5ciPhvRhG9uwmxE86P9+Uoh4EoxeAKvN5+aXpOAOvmZ
         gBLgdsCcdaWGNSU32G/qT7dVpDDTisBjnlppLpcHqvtb6j5b3D8ExR6u1fTWC90jRdDL
         Akr/v87n0k01SkTn85KR8LRDJxe/iiP3is2mZO1/hXJxU1iw+iha0Cm5ElxI/xqB8zaK
         yAgg==
X-Forwarded-Encrypted: i=1; AJvYcCW1UMuS5Hzb84iIkr9oLk/uAyDW0XWVrdur5ZaaL/y8OKA8IspHF3HQUJ5sHVMzng9EfhzAwevT0Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JCbLd4Kg2XY7l7EcIfatcCErqfhuQW3MUmaV6opedqR4t5yz
	o42MXpS3MEu9FZq+l06vLxmp2m4PnOR74GFcuk2pbBshdUNMhWOtNBlr
X-Gm-Gg: ATEYQzwgboOk7H8bXId1AkxlEsnGWCpXBTZx6a4hWXB0h/GkkLLn1SCGYqRnf6+VSFi
	4SFGVue/rSDAxVoVjtK9QxE6eqXc1Y5OV6pu2jjhry79KxBdykkWA7HZlYtXwysR5zEQ/xUgG3p
	+HPJGkJEIFFBbRrC0USjwb3eQUI+ItJ3chPN2mzjyFcjc6f5e+OtkxN9wIW4uUUpfeNqbBLfiwT
	nIfhUfikmRmD1Jat6T25K9WPy/bgSkSg6UJ7m28CopjR9zT5oh0eAMNAzRZSqCbea+SDCCnFLP/
	NH4MALnBjHODOLRENBSL4D1ctZISEu3RYEV+5ZEoe9op8SSrbdyxH2hZaOyk/YnSdDYiuK1x5CW
	Jl5L+vXHqbqPpx5EkraBTEh9Ny4xsJop9yshdX07qorcSddckmoBBCCpF0+vLjf1EezhabdeIH4
	bUOMer0GKjDGyrfHNo3x4U0xE3BaMCn/f20z76MJhKpXpd5tzGHb6S2e4nSR00UgcjYEMXQrraO
	DhBTO2P6RBGxZMa9tXk7qZtpCIS4mNTuKtXj63nSTSxIZalLp8=
X-Received: by 2002:a17:902:f68a:b0:295:560a:e499 with SMTP id d9443c01a7336-2ae6a9cd41cmr53596975ad.5.1772715971749;
        Thu, 05 Mar 2026 05:06:11 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d19559csm154128355ad.5.2026.03.05.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:06:10 -0800 (PST)
Date: Thu, 5 Mar 2026 22:06:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Joe Perches <joe@perches.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305130609.GB1659133@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
 <20260305123843.i47asdrjychwlgdt@skbuf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305123843.i47asdrjychwlgdt@skbuf>

Hello,

> > > K:    \b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
> > > K:    \bphy_(?:create|remove)_lookup\b
> > > K:    \bphy_(?:get|set)?_drvdata\b
> > > K:    \b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
> > > K:    \bphy_pm_runtime_(?:get|put)(?:_sync)?\b
> > > K:    \bphy_(?:init|exit|power_(?:on|off))\b
> > > K:    \bphy_|(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
> > > K:    \bphy_(?:reset|configure|validate|calibrate)\b
> > > K:    \bphy_notify_(?:connect|disconnect|state)\b
> > > K:    (?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b
> > > K:    (?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)
> > 
> > What about
> > 
> >   F:    drivers/*/*phy*
> > 
> > or something along these lines.
> > 
> >         Krzysztof
> 
> I don't understand your suggestion. Is it meant as a replacement for the
> keyword regexes? Your file pattern matches on:

I was thinking more along the lines of using wildcards, the F: was just an
example.

[...]

> There are a lot of false positives, and a lot of false negatives.

Yeah, the "catch-all", for lack of better word, will not work here.

	Krzysztof
