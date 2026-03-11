Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996813750A9
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258301; cv=none; b=jsGwB7HmXQEIoIgSnp7e7ZL2RVxiKmMNkmAWfQlFzCbp3iAPRjFoES/8aYQ76ZSL3yS7oPH1qeeYOUMZ/BjWdgXqO2btMYArnqhe3idPRSTBqE/suQqYx0UcZojQrZwn3f4CCNvEIg4g11Q3CVuf64wCmk6R6buhmuM9CzYHAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258301; c=relaxed/simple;
	bh=bGzkEAlghozexdiJRNQPbgg3VMzti/9i5mXejNA+j0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVRtE0n/PjnjcJVRiB//TremFBf3V4d5arEeVC7NAVSUffAC0STyEJH0xzRM0qBUYL3WatlJhKp8R0seHmTy8a0NxVY2yiWONA4BehZ79bYOxJM1WV4nThl2V0umwuKpH2cNwsmfH5Q6MOEBi3+b6Hzo8097U5rwEvy6rzzBJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+CfdcCe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAPhTRaq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+CfdcCe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAPhTRaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773258297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoMDbJU2xDFYUQd1hXlmSs8yylpms2iEAMhOVCgJXGI=;
	b=L+CfdcCeOIgy61TNFU5T+aW6l8qndL2Ms4m2y1393T6wSuQ543jko/ctLOsmpqpbQA/IAP
	6zbI950dgI6fJBLH/z/T33eZewTNcGTsxTV3JSUAFaYtQpLT41b3gWkxoXGhc6IT9ngHr+
	JYFCYQxkTGwLCLVtbMEo+GsdV44hMEs=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Cji7qr9AM5iGLQqlvu6k4Q-1; Wed, 11 Mar 2026 15:44:56 -0400
X-MC-Unique: Cji7qr9AM5iGLQqlvu6k4Q-1
X-Mimecast-MFC-AGG-ID: Cji7qr9AM5iGLQqlvu6k4Q_1773258295
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67bb2273d42so4170643eaf.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773258295; x=1773863095; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GoMDbJU2xDFYUQd1hXlmSs8yylpms2iEAMhOVCgJXGI=;
        b=bAPhTRaq06k13ZPPQ8hzDtanAS+QqmhkIaMTPRDalkjyGVznFr4nYDazt9dbqVQosb
         6D2RiRH1k71wbkioxFPvFntAx2/aLhl4PUoEPY5MEsdf4ZFDmVs/RmTmElxRJ9G4vmAV
         F/XwMzi7bJDE4qOrd6ZmVOhY28YDN3NBMkbgCZsazRgUXJGBcVfvizI7o41FtJdg242f
         z6BLWzz+lFgv3DDda4NWwqLsh1IP7JXYPT5rGl42UTQIZzqG82EkiPtzu8zS9G38s5P7
         SDHoCZtQQCkERtYf4QsqWG19qtMfxgtB4MaLE3wx81iHUetJq0WyJjcRAo01qGdquPM7
         Ljig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258295; x=1773863095;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoMDbJU2xDFYUQd1hXlmSs8yylpms2iEAMhOVCgJXGI=;
        b=KW5yKPR+K8xsYj4XOfVVVFTpLXuQq2Fva0LfotF0TXM/+arfFcjseFVkYDjCCBP7Ro
         947PSMNOEkNDAOfqf+r1RRy9LbxAS1Q5NfLEZc2BwWryp9XnuHd87XHfd4VCRVH1vTxn
         l7GDW54/sH9Y2Fm716crZMgZAR80Vv2fABZ3O0uhkmy17El7mmDo1zQtrnPfM87W9jN8
         aqZRYNciFVRvTonpYWQVDyD+brnZWWHH2GYGx1Jc2R+lCDtrnO32LKTa4KcctDKxCvy0
         w+t05FoDvO4YV6sbcIauEx9Gvhqbmi02bk/HN3zbDnMcVPElGjf9pS+S8SFhCQUdz/8e
         /Gkg==
X-Forwarded-Encrypted: i=1; AJvYcCWBcpNqM/wwbAwxSmLU6q/rd7MOuIW2UmzCPjOAai0wZT3qOuG/zlKHVUJ2HNG5e0Em9Mshvp8nf4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3BB7LKYoOHEc1efvwLMA/SRbK27Z8IOTMjSWpPq33gjAp3qF
	+68kxcHsI0YcRsY4ZS6J8S5vDzDO8zcECXIw8NPYVM96aHsQnrcT0E6YUDu7Yz/PJ6vsE2pgGRq
	NC0M9oS+Rn50ZSJqVJd7ommGmR2Z6jj/GXpGFK1WbjoQ7GYQhImMcq2JQZ79tLQ==
X-Gm-Gg: ATEYQzy2rkBwcNMx2WzwBFB7XbCQ27YSGGNDnNykRWuoZYg+oawcnImKrOB4MCj78vz
	vqFKFiLzLbhkuD6tS6j2nnCx1fukEkEdl9ygUhcSSjo5E+MPaBFqYkSHcl8uhcAbKBccqcgTXK7
	rVPQBjqGb8unRb4rm+75CWCt2nBC50BHuVfVEn0U0FWyr7DDdxn5rcqphP1pYpUv8qKcrad/LDM
	SleaPWgX0d/ShNb/s6XaEZNtrRWwTAIB8ztCQ/mILscFov26iyHWiDV5tuS6hJKiSODGJ8AJi4Q
	CF6V0OBcvW+HkvpwPabaQrLeeFEOSrziS1tk9lYe4bsl3r/y3rWkWQICy3sckN7I82jHmdmZFm3
	NSlX1K8JUUo9mPMAVmRpX
X-Received: by 2002:a05:6820:468b:b0:67a:47b:5a1a with SMTP id 006d021491bc7-67bc8a92d45mr2060524eaf.65.1773258295395;
        Wed, 11 Mar 2026 12:44:55 -0700 (PDT)
X-Received: by 2002:a05:6820:468b:b0:67a:47b:5a1a with SMTP id 006d021491bc7-67bc8a92d45mr2060493eaf.65.1773258294899;
        Wed, 11 Mar 2026 12:44:54 -0700 (PDT)
Received: from redhat.com ([2600:382:7704:370d:c6a3:6b0f:aa31:6ca2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc8efb85esm1894481eaf.1.2026.03.11.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:44:54 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:44:50 -0400
From: Brian Masney <bmasney@redhat.com>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-mips@vger.kernel.org, naseefkm@gmail.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, tsbogend@alpha.franken.de,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, vkoul@kernel.org, neil.armstrong@linaro.org,
	p.zabel@pengutronix.de, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, nbd@nbd.name,
	ansuelsmth@gmail.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/8] clk: airoha: Add econet EN751221 clock/reset
 support to en7523-scu
Message-ID: <abHGMgGCyPh1G5jC@redhat.com>
References: <20260309131818.74467-1-cjd@cjdns.fr>
 <20260309131818.74467-3-cjd@cjdns.fr>
 <abF-qFC1Oa4dz-fh@redhat.com>
 <de6e8440-99a1-4be7-80aa-3645fdb0bdb9@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de6e8440-99a1-4be7-80aa-3645fdb0bdb9@cjdns.fr>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Wed, Mar 11, 2026 at 06:12:59PM +0100, Caleb James DeLisle wrote:
> Hello Brian,
> 
> Thank you for taking the time!
> 
> 
> On 11/03/2026 15:39, Brian Masney wrote:
> > Hi Caleb,
> > 
> > On Mon, Mar 09, 2026 at 01:18:12PM +0000, Caleb James DeLisle wrote:
> > > EcoNet EN751221 clock/reset driver is significantly similar to the
> > > EN7523 / EN7581, however the EN751221 does not have a neat batch of clock
> > > divider registers so there are fewer known clocks, and the frequency of
> > > each clock is derived differently. This clock driver will probably work
> > > correctly on EN751627, EN7528, and EN7580.
> > > 
> > > Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> > > ---
> > >   static u32 en7523_get_base_rate(const struct en_clk_desc *desc, u32 val)
> > >   {
> > > @@ -604,7 +703,8 @@ static int en7523_clk_hw_init(struct platform_device *pdev,
> > >   	en7523_register_clocks(&pdev->dev, clk_data, base, np_base);
> > >   	return en7581_reset_register(&pdev->dev, np_base, en7523_rst_map,
> > > -				     ARRAY_SIZE(en7523_rst_map));
> > > +				     ARRAY_SIZE(en7523_rst_map),
> > > +				     en7581_rst_ofs);
> > I assume the mix of en7523 and en7581 is ok here?
> 
> 
> Correct, en7581 came first, then when en7523 was added they reused the
> function. I'm only changing the offsets to be passed in because en751221 has
> more reset registers so different offset table than the others.

Sounds good. I just wanted to confirm.

> > > +	else
> > > +		clk_data->hws[key] = hw;
> > Should the error code be returned here? I know the function has try in
> > it's name, however if this fails, then it still registers it.
> 
> 
> This function follows the general pattern of en7581_register_clocks(). If a
> clock can't be registered, leave clk_data->hws[key] as NULL, log, and
> continue. There's only two possible reasons for failing, if
> clk_hw_register_fixed_rate() fails then it's not registered because it
> failed. If key >= EN751221_MAX_CLKS, it does register but I'll fix this so
> it's checking that before clk_hw_register_fixed_rate().

I see that Stephen picked up this driver in 2022 with that behavior. I'm
fine with it if he is.

> > > +	/* BUS */
> > > +	rate = FIELD_GET(EN751221_REG_BUS_MASK,
> > > +			 readl(np_base + EN751221_REG_BUS));
> > > +	rate *= 1000000;
> > > +	en751221_try_register_clk(dev, EN751221_CLK_BUS, clk_data, "bus",
> > > +				  rate);
> > > +
> > > +	/* CPU */
> > > +	en751221_try_register_clk(dev, EN751221_CLK_CPU, clk_data, "cpu",
> > > +				  rate * 4);
> > > +
> > > +	/* HPT */
> > > +	switch (hid) {
> > > +	case HIR_EN751221:
> > > +	case HIR_EN751627:
> > > +	case HIR_EN7526C:
> > > +	case HIR_EN7580:
> > > +	case HIR_EN7528:
> > > +		rate = 200000000;
> > > +		break;
> > > +	case HIR_MT7505:
> > > +		rate = 100000000;
> > > +		break;
> > > +	case HIR_MT751020:
> > > +		rate = 800000000 / 3;
> > > +		break;
> > > +	default:
> > > +		rate = 250000000;
> > Should a warning be logged here or in get_hw_id() above? hid can be set
> > to HIR_UNKNOWN here.
> 
> Now that I'm looking at this again, I'm starting to think it might be better
> to just remove it and use a fixed-clock in the DT. I wrote it aiming for
> completeness, but this particular clock has so much code supporting it, I'm
> feeling like it just doesn't make any sense.
> 
> Let me know if you have a feeling on this because I'm swaying in the
> direction of just re-sending with it removed.

That makes sense to me.

Brian

