Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB0365A13
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275222; cv=pass; b=EVowKt30jt6Jh545ZrNuvOBSH5LM6BLzZo3tskMePjACvYKwUDphzrNUYivriPyWAubY7aG++9XQIXRojSkbWYgZRmwOd7vnmEIYCgKYfLudF4FqG6LdS083FQ2ScxQeVykADdDQhwWmqhs2jj1un4KDuumAqvAhIJIg8Giqas4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275222; c=relaxed/simple;
	bh=2bGDMG4l77cX9hw6ZXFvUynZCjcpi5tIL9qA48dVTZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMIDCvr7Jod7dBve57qhNu9iXOTOcVn5uGnpZq7uOXPIh7LQAkWAAIz4XiCQjqTLYnxndDLE/O1dROKPoJLH53tBkM7p+0YtwV/nXvLnwh3ZPEN/63CbR8IbTKZJd0eYXzy/Xcmj6a8Frg0rIhrb53nchRpOov8qS9IRCTxYL+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6hyVm4E; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6hyVm4E"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6c4a2458683so436815137.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 07:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781275220; cv=none;
        d=google.com; s=arc-20240605;
        b=RW0cVZv7z2cUScX5TjM7Ae1vIkArWnR2C4t0BsQzqJA+u5X+mAtzNrIBH8chSgH5lM
         0lPHYtoHYyoiK6J7iyh5WkIsD9RXrKbw6BZdwjyKAfNvkUI+471GaivWM8IqXxnuqLIk
         HYxTGjFlvcrU4j35Eg6U25jd8QQZUbM/tbSEMFdqFooWeunkVtOrBQjD+ps+sawl0L+x
         c51QnDMJ21sZO1iEH3GZ2mjho5a2aPxe/1YDdJF+oMdLFTK+rKI4/JefFGu519yxbES5
         BMVKk9DH+0q0jLMB9nilPfdDy5ZWPscwu9vmqc8lERVSs2LMZTbV5SNwdY3GkCtGl/hA
         rpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jws4kc/6HCJln3nPYNLHurE61VFKguu58eheUohgKlM=;
        fh=nIy99EuauuUfZBDiLZQcBc09RNFTiT3ITskK57WVWcU=;
        b=OXJsUAzpOmquDzJYm7x3JvM/VhA2cEc6uJMczpFi1+YyA6tAx/AJp2T1IKJaWoCKBG
         shauyZVwpj3u5sjcXqkSd1v7tVn48BKjRAhlBvfk9uuj7xIYx/WTvb+O6Wdj0yFx9kk+
         4wTQ2GGf1bXkhY1ChcB1ytDyXkKO6KLlnz0IwVA0xzyLlrw97D2Yx6nZk3ERQfV/6EoA
         eR4f27gH6p57pw62LHCaD6g8cQ6URXhSDkIfRW78aAmgXI/XRUpNggcDIBMzbeF8g1ho
         Re6Hqe4kPWiZYufoddWsgC64GHK16/FivQMgfbvf94SrHP5ckzdpr+3oKLJdqcJn/vVt
         /bGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275220; x=1781880020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jws4kc/6HCJln3nPYNLHurE61VFKguu58eheUohgKlM=;
        b=q6hyVm4E2pXDu7thkHH2Od7gdU/C4lz2D6xXry6k7IWNT0oli6yTkyIcJNyw1ORUrV
         SWrnWsYQtlgWY1hPRS6O4K9wKps5eGtPZcvY47Yzzao0xrPtyoMU4JWKVfxDO0F2Sv8a
         TyeP2yERThYCnZIGRz2BDG+k8+fmwAWbmVbac4AXkMBeqhWUKg1p4pkd0ouuGLAtR9Pt
         b+LJeajdPSb574v4W+AbbfuyAtlJeq1TIcfq6Isz//yCEuLtSg2J6Fl8zNTPMaxjs6Yl
         nzKm8nHT0HnLr4uJYIZ/X1ZZImg5n+8FGd98KgZHRPSExvkEuNe1x6/sCRKFIZwe7Fus
         P+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275220; x=1781880020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jws4kc/6HCJln3nPYNLHurE61VFKguu58eheUohgKlM=;
        b=FW+QDD/QGIZyyPg24zKm0IhjOYz+Fufz9KpDHN1zg1J1bXaDcKYZZ/cmUpDaYmYYIK
         f41L2yOiOxsfWhjOGWsYlNWVxtCTEnKgQE7ZNg8AYGvlL56wteC3gxG9C9tiA9ruKqz9
         XLR0J1GZ1cP3KTjmHz5rnvJwUK5ierYWWOK+j1y+NeZHFQHP5YJmR79vJy9XcL3gyWS7
         2aHmc76bU3kMLez/s/qxpV6w/SNXB/evKasWOVX8m7uHoEslRvHtvXXeYYBpylAtdpFh
         Hq1ZbIADRXuN5Gc1T8n+QO60LgayfWh1jnws4F0mDQYJyFnFrhdSPGoa5qLPG+Ck2k3m
         fO/g==
X-Forwarded-Encrypted: i=1; AFNElJ/4vnStJgaRslMwY+vdkofEnfs7gYHDs23flmM1sUjRM+80XPCxi9ER/1h4SixVk74tDIeyik2UluE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz727zP3vX8c9+ssbtcscv4MAMQT/jyYYuYYu4PyZUMHiOvBXWN
	Eyma0sSyOcUw5C0n5vhkvBAfsrPf7IqOqjrNHUF8uSuCkHhL35FyejIeOa58sIiLDj4MTWfs5jC
	kFC3ktrDg3fkLo2vXP96C4WKnPgsAz0o=
X-Gm-Gg: Acq92OHRCp4jiL8wK8WGoEv/1BBvUU4IAKpMFEG+cfMVEqdJxGIthJrLdRC1nzv/Uvc
	tuHvCht8g9n79OWViwzsgTNQplx5vkmmSWSYXWXXQFrHYqAYX3de6dNFrP+xnNHWm4JyVD4P94n
	d3Xcgi/Ocrt2eU9e+6/wwfYFLjOcvlWfO0mqZ9dxDhsuzd/oeBPK+9HDqHIH5SdbxydrvCMdXJA
	bDWAkdamI8iPnAEydjLKFUKEqVhtWxQefxTqbFmcPLuuIgfzdTt6FDFu6WnYcCvJMmpxDtyTH18
	0xxT7em+izS7ThgR2eudp3m/HyqXK3CpopIASb4=
X-Received: by 2002:a05:6102:3e8a:b0:633:f2bf:7de4 with SMTP id
 ada2fe7eead31-71e88b250c7mr1959385137.10.1781275220197; Fri, 12 Jun 2026
 07:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a0c86ab264cdc1c79c917e984b90991af51d827.1779123847.git.shuvampandey1@gmail.com>
 <20260611222653.GA527114@bhelgaas>
In-Reply-To: <20260611222653.GA527114@bhelgaas>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Fri, 12 Jun 2026 20:24:56 +0545
X-Gm-Features: AVVi8CdKAP86TtMoO599NkYV98Yvwx6Qva5SIn9Z5VQSeP_4V_va59YftVroKA4
Message-ID: <CANAAWH+qT8T4_OBwu0WxU6o0FTT7xqwpLTOFrWiV1dZbXHk+fw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: meson: Add missing remove callback
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Yue Wang <yue.wang@amlogic.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Fan Ni <fan.ni@samsung.com>, 
	Shradha Todi <shradha.t@samsung.com>, Hanjie Lin <hanjie.lin@amlogic.com>, 
	linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

> What's the user-visible effect of this?  Does it avoid an oops?
> Reduce power usage?

I don't have hardware with this controller, so I have not observed an
oops from this.

The concrete effect is that driver unbind/module unload gets the
matching teardown for the successful probe path: the DesignWare host
bridge is unregistered with dw_pcie_host_deinit(), and the PHY is
powered off with meson_pcie_power_off() before devres releases the
driver's resources.

So yes, it should reduce power usage after unbind. The host bridge
teardown is also the matching cleanup for dw_pcie_host_init(), but I
don't have hardware evidence of an oops on unbind.

> Of the 34 instances of .probe() in drivers/pci/controller/dwc/, on 12
> implement .remove(), so if this fixes a problem, I'm wondering whether
> other drivers have the same problem.

Yes, that may deserve a broader driver-by-driver audit. I only checked
Meson for this patch. Some DWC drivers implement .remove(), and several
others set .suppress_bind_attrs, which affects the manual sysfs
bind/unbind path. Before this patch, the Meson driver had neither, while
meson_pcie_probe() calls meson_pcie_power_on() and registers the host
bridge with dw_pcie_host_init().

Thanks,
Shuvam
