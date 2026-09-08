Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF0367F2F
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884922; cv=none; b=qhALxIatm0dSUmA6kKkeA+ZWhDkLra3gCv24PeT1iqVJ6fOSe4rgUY3JH/rpqvlhSSBsp6vJZ5vpZoWiJ7lNx9F1u4So7dx5bedrOzIbk/Pb3XR+tPm3oIHq76o/AGFEVWf7I2NPRsT4uA6s9Pc14UBvdr29qWPy6p1KInvW/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884922; c=relaxed/simple;
	bh=2Pxagvfz4pD37M1EnYIbe0yDAerT6Q5PeiRlCdDwU9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke2trX8jdOOf7pRzELOokB3ffEPnjO02Ftb3SZF6goz5oRy8hNpKYPk/KwhVOHXlbIhjk+EQv38ZTv6ieET7ArvP1kHNdh5fnbGlswfmYG47E7wJgWgPgThNaODwRFQTLufgAjS0w14xT8S+UJMz3/I1B3jcOgcOTmKP5reMcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blNZT1Hp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blNZT1Hp"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso812237a91.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788884919; x=1789489719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tselhm+a528W90LG9l3xZCuYvZfjTJsda23jK66pgS4=;
        b=blNZT1HptP8zZNsmLqTjkeb1PC6SuAulXdyxwoWxgIABBfxTjaFRi/zBVA2X+UUJgp
         neCkIeciNU7Xez+1cX6iRIdZyeMK6w9+AMFiKlFmQtSwAnCul/Aq1Ko9m9nQH/YQeqGq
         Z4KByr58+WCWu6FJ6yZQsdGYi2QQxVHv7w2nL04Mnou0K5R2ykGHl87ABMGXMXcCosv6
         Y90LPBSoZUkp6jCBOWbCXyDlLe1vtlawfbfk6x4DgZOfJYo768RjMh8wRKLWDn5qweJG
         dluorhhVz1mwxoe3i/M2Flr01JFr9xwmrx+hO/7lhUpGHGnL58K+jckF9u1h48K72jMJ
         sHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788884919; x=1789489719;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tselhm+a528W90LG9l3xZCuYvZfjTJsda23jK66pgS4=;
        b=aClveuYYXhmIKj8BMjut5cjbTQ3p63kcbjp6amhWcITVCq/YriP4E94J1Qsg6wcser
         EAWy7w9dq34tBBikgPJFhPLLXvzMgHDBa8o0PJIRP2TvH1Nz5tpQZd9DdL/ffyNtFa63
         Jpy1wBYQ9gO5dMjPk1EZTcq1pMQw3AWDn+k0VTXazlDtFDnmvPp0CfxWtP6aUynYIlEU
         9L0cy5PiUYO9pkvFx1UHt9CFhfgW7LJnOX+XAJRbj2oiE78rqHxCNG6G7hsR0d+3Pu7a
         Wf/PO2kIt1pe8U27Wp+L50ysHcmZlP99cBjlqFu9iVE37nTQ0v7jDvdWZjb1FmKTQ5nc
         outg==
X-Forwarded-Encrypted: i=1; AKwUvBwP+nf6tzPsF0jnHgQ0VjXqW6uIzzo7o3LzutmvMkYfyTXvIkoQv38sTLOtzxNIckqjCuL76skvpOM=@vger.kernel.org
X-Gm-Message-State: AFuF++muj4QZQG21iDrVMFU3WYpIj4HQnGVTFgQL2CPtndlQVFhwCDKx
	ALSYj1/b4uVO7iscAXsp4k0jnjTEU1Hbo43RwzZj7py2FPKouGa0hQsJ
X-Gm-Gg: AYBFou3V0AovGbiYUVsdoi4ptv6g/AjtnkgU9vd08We77JLCeYY1Bf667CVX0a4gxGM
	TqLFH9/vYvZbxxKlbQnCtnW3kebvmAsCx62XdwcQtWnHhBlg5JmPePu8GYGX+LkkiWJP5iuf48A
	aiiVu56x6dalKCdODjMuB9IJjhoXQXfdAhfhIyhw+ojNO0LO7qT5A4sch9dxOK0qCMHMre5c6zK
	tCdeKtIYUjv3SuO7iglpONYIwamRjSqCSMuWOkKhe+YMxPVAsrfiY4fuzHiFRiHO2AWLPqNugQ+
	USZTtrkdnqnDJS5+wI6QnvUCSa6Zl5FZw5J5+mHWW9JTss/+b5UmqT0P5Z4Gc7B3vFBYlg/8pNc
	p8rDla2SS0XtzfZOsAXk2CDxHgIlFQ/ytS/uCjPEqEarwLfC0TNRwdwXm7cGfSGOIA/3XKLnJmb
	O5sOgrCxpw2pzFnhg/TGe6gnY3/BEMAoogfUP3fzH56GbdJ3dejsP0fb7+XXoYts6nSsSYE1W5S
	YMAgE18b7pSKdXfhv1f03MB25v1LT73zZTneA==
X-Received: by 2002:a17:90b:498c:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-39b260d3351mr40856809a91.5.1788884919201;
        Tue, 08 Sep 2026 09:28:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae92c5d72sm10198449a91.4.2026.09.08.09.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 09:28:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ab2b167-4362-4029-b995-6590c8893bfa@roeck-us.net>
Date: Tue, 8 Sep 2026 09:28:36 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] ARM: orion/dove/mv78xx0: remove all board files
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-rtc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-6-arnd@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260908152808.3928630-6-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/8/26 08:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'orion' platform is the predecessor to what linux now calls the
> 'mvebu' line of Marvell SoCs, and originally covered orion5x,
> mv78xx0, kirkwood, dove and a few others that do not have any
> upstream support at the moment.
> 
> Only a few board files remain here, these are the ones left
> in 2022 board file purge because they had some level of support
> in Debian or OpenWRT, mostly for commercial NAS or router boxes.
> This distro support is now gone, and nobody has converted the
> board files to devicetree, though the orion5x and dove platforms
> also come with devicetree support for some other machines.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Jeremy J. Peper <jeremy@jeremypeper.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Ulf Hansson <ulfh@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

