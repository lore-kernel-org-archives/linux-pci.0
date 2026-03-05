Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1C2D8DA8
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715717; cv=none; b=nimwhU77HU5lwrgY2R5BWp+ms8qpJnPN/7S5DPEgdF98q1K0DQ2bE6XjJib1+IrNPFsvfgiIihUo1X5dXGGc+BT6IehYeU9n+d6QGd6es8Ws8Qz7mgZxDUAP2VPIPITN+Fg3+CKxjYkKldK2O9P/v6ywI+aRMTnGNHUpJcEUp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715717; c=relaxed/simple;
	bh=mzxuHFEBJ8rIbeR5gmZexUBLMULkEpRVqRmwwCFyU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+jpU3X5dGwvU3v3ExKmnPtrwqzr2t0+HA2CyckOZDsPzfLafwMDAGbhOJdEG4KYr3xP7NjhRYQGIalujFFmu2xPbxou7quMvcJh+dGerDvma51bTF0EL+3M6e/9U6ADA9ph4GDMzLnki1YJl7G0+yDsvDGt6Cg6Nk/Ei5XNJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c2af7d09533so4884882a12.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 05:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715716; x=1773320516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IxpxVkGnClS/pzWnTPcTEx+bl+pPZR21vGpLksfVXc=;
        b=PON9qa7m0eTekyMoAuha5keTeLLwJrpMgkFArbogrPqqY2ia6TeUqHb/FHbeh78EBH
         9fYeozqqgtktiDPYdYnP7kQdN1Ws8Xj4IKalgaeZMdnafsfN9e/GZccFrSJcUIKFxbwn
         dBbeVSBRSfhS4f6LxZM09mv1SlzmFUe6muCI3OkBjSeSaW414rMHfWFUuTZQ95JT9wB+
         kPTsAffLPZoersG42O8ubMmEQW1iWy9hjHuy6cZDoaiBcJ/B6VxZLlOKwukNih/OlFhO
         ev1CPHfGhbE6YD5dabk6Q5JHSJZEITCOXxwAhoB8bk5pLojENLR983mpspNWKNsW5d7e
         04uA==
X-Forwarded-Encrypted: i=1; AJvYcCUOWpSgIzcFSGVCiVUFiYVChX1yvvGjxMfuxcZhomEbjahlehEJr5wpUI/tLRJGjxpklsQKI2ypynA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZQh2lJK5NcLzsRcmmJuZznYMDQ/to9JxNuh4nB9cUttl35Lx
	b45E8F65noMuNm2Ym3Wzy2qrckNURSlgPaNxEiSojZ4aB2D522h7R5l1
X-Gm-Gg: ATEYQzwQhwzjpEaMEx/9Cj1MoKWTBXoAGt6xLrSRzsTrTuje3FAlhcjgpfZVXLl9Cj1
	iMOp8q+VVKVmzIH3LotL2TIv0JPV6xC+8ybeQVWKlN8bF/IaoIymxafLtKtwJJs4iG099GSILMz
	PUxfe7+bJMFnoaWRSox+9CsPEiw4dJSuX50RsVEqKIDrfJOli4+inKtxWVOPMm0E51zjx9KTw1A
	23KFuMr8ZDajNq0mZ+j/ycVMHyg7IKdmWHBb980dscqQZqoe/qEvIMdwBv6jRHbbuXcBf+op/ez
	EmH9VlcBit9NQ1jRQN+/F0hU1913gpqalIQ7Wqjwc5OUQW84q5cyWP5Vz9cpgFfxQ3TQnjCbFSV
	VWXiKtAveFuiXZKjDZTgOsuDk3p5wjm+R6gCR6dfUxxAjhCwWA0JRQ7jqPre5iGJB5sh22PlJHt
	LuXYHGA8zrDWlvz7E5WDDIYmfWZodQxDxdr10lWQ3fAmzPthwnjx/iuPemzlXwLmaLWV3KDGQyK
	JhpO4lgRpB4WdMOz57CPLVQ4yMp+99k/EniX2bhp1AtbmfH5xHlzLY2nTaJIA==
X-Received: by 2002:a17:902:ce03:b0:2ae:5b52:3818 with SMTP id d9443c01a7336-2ae6a9deb2amr60551085ad.8.1772715711782;
        Thu, 05 Mar 2026 05:01:51 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae54136b28sm115696425ad.73.2026.03.05.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:01:50 -0800 (PST)
Date: Thu, 5 Mar 2026 22:01:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Joe Perches <joe@perches.com>,
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
Message-ID: <20260305130149.GA1659133@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
 <20260305122957.GA1652563@rocinante>
 <20260305123956.ojkt4k3ly64xz7fu@skbuf>
 <aal6kWDx_3XRGB4K@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aal6kWDx_3XRGB4K@shell.armlinux.org.uk>

Hello,

> > > For content match, it could also be:
> > > 
> > >   K:    phy
> > > 
> > > I believe this would match everything of interest?
> > 
> > Yeah, and way more. Think USB PHY, network PHY, etc. Don't want to drown
> > the linux-phy mailing list in unrelated patches, either.
> 
> Also phylink, any memory management / DMA stuff that happens to mention
> "physical", and probably numerous other examples.

Makes sense!  Sorry for the commotion here, then. :)

	Krzysztof
