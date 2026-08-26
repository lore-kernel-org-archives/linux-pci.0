Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51843BD643
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736186; cv=none; b=YpwmKbwUDfi++mx1XghGZ35SNMBZ2Krcm4IeBaf7CkKOyUsp8MglKgD23Htaj0GlvI2v79MgVMAYxeX6BLUHaEvNX7xp9WJ8CdxWH+HhVuRfkivVQnz9CeLU/BMHAaQSs4VxgtvBhsysh+2bJBaiGMJkvkVsMLYEZk0l1Z6cys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736186; c=relaxed/simple;
	bh=1qlCb/31LfaLgG84KqEgEX69PM/OvewAvuZ2k3BPXyc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFRAOftLF6OKgHAV+VWkyYJ5jPcBfxnTULQB/C59BSzLIdPFuK738/RBsLALUSYkQazVM3SU9HZ4U4aos4yG54W9G6vBWF5+xYtXGuaT13NTeRTozN7XJ4W1hXOuBM2d4DEDhW9qqORcEjvgDnmQIhNcBAmhDeXPSYXVKGHFnfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfAxgdbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfAxgdbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDE61F01566
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787736185;
	bh=y9yKGX1wK+d9EUShx30VfQc5I+KwOkgRLestKA60HKQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=NfAxgdbza9OwZEWP56BStDNJbF84ra5AAwS+264y7q1xCWIfshgrbuAP1gnbNwUBd
	 zNaw6mnxa5uhMnVeLtgO08eRoASoR7Rrj9U3B+yPORrer4T/zPPniiCEr1mijcRGO8
	 PbxmaLBxocW9PSYyOqk5jEW+PiFBLMO9azAlKnqrhRrGyQ+3C+HSuqNS2Q32KIOTVC
	 dTKVKw/Aj8G11zbumEQ9+BxCkSa85LVvpwWCWznkBTjlO4rqH4/5QHKalnIlxOPQzE
	 T6iCpQ6YcSnoX7beuhNB1X0c+J3Raha1qgUWHM97ooe/QteVZOrY7RLOFtJx2z6aSc
	 ULafG07OfmZQg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b29599b81cso672723e87.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 02:23:05 -0700 (PDT)
X-Gm-Message-State: AFuF++lZ9Grrs5oAlotF31n1O+ke1D09nz+wvFOIQ744HYkZyTPk3nQD
	Gb1WQyj8tOyrrKJogkHsVtMClInLgnkZv4De+/gwpinWX1CIF95hvlcjaZdn6qpAnJbfT0mT9Oi
	jfDjnPQ28dERixAOvPztrtWmbpUM+YIQ/5EscmzmGIA==
X-Received: by 2002:a05:6512:6890:10b0:5b3:420:884d with SMTP id
 2adb3069b0e04-5b4a905a01fmr1021956e87.18.1787736184069; Wed, 26 Aug 2026
 02:23:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 04:23:01 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 04:23:01 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 04:23:01 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mcr8Cz5OQ9RgZcZSV-bVM9cvGt=g52Pd3zK0NQnhc30fQ@mail.gmail.com>
X-Gm-Features: AcwNN1V8AlLM0yO_2-R9MDTZdZxUgdCJ_hXFurALxazCZ7642ar_0s4ChUjf0NU
Message-ID: <CAMRc=Mcr8Cz5OQ9RgZcZSV-bVM9cvGt=g52Pd3zK0NQnhc30fQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for RESX
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 13:41:31 +0200, Abel Vesa <abel.vesa@oss.qualcomm.com> said:
> The RESX GPIO may be provided by a sleeping GPIO controller, such as an
> I2C or SPI I/O expander. Calling gpiod_set_value() for such a GPIO
> triggers the following warning:
>
>   WARNING: ... drivers/gpio/gpiolib.c:4030 at gpiod_set_value()
>
> The TC9563 power-on and power-off callbacks already sleep while enabling
> or disabling regulators and while waiting for oscillator stabilization.
> Use gpiod_set_value_cansleep() for RESX so it can be driven without
> triggering the warning.
>
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
