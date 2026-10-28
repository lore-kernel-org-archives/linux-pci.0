Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148938;
	b=HJDwHzYeBAHyGIvOsQSJKYGtKBUSI0k6s9fZF2HM0Ne1jtShM19g2Lj6Q/F4xL7T5E15
	 eqnPyq5JJeW35714x3ieJJtmirePiqtdHq2Ej2781Kcz5zydxGFvONTteo4CqF71txDDE
	 R4AECoHxTtE22nWyBQ51ign/rJkqbeK0SQ/J9TCnr75I3/UW5UUwGXPhvmsWY1WDTFdlj
	 jXX4KNH8O3W1lB+2GX/HQf9ltzkjPa9OT/wX36BRopZZHdNmzKIpLv9maQNJ/xWkv9SpD
	 Kib1Pn/62EnZNc4hQJ0tsIAdV7tQ1cUUHqC3UkYXnCFRyjzk/m8CKcgYrABpA2LXwcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HzH8rykX5lmcZm9pB6FHq6gj3hJ7Y5hZ3zn+8svQBtg=;
	b=EXv8yDEN6eYPSyhe+n0R+mUE+JBEn30PqT6bVOPQfFVNoJ/PK+U8taLosf3n25Wozvdp
	 I4ROxxcGGC252YtC1KqmukELrOVski/TALJMP6ORH4EE4lnNxWIZyx15H5foVDBSyI48p
	 k94ZDn+annv/ktlLppiBiZRzg1kAz5ELRp0CLeLUsjhhirT6mLcFAdbed9mrkXoQeIAux
	 eJdU4UugPxjPNwFchJUS3WxspjLZ2o+XRZBozQEcstyK7p1ciVMMTeQrtzHnRWPgWr2V+
	 J4ub5Ve99y6S60CBVZvD7ow7HrEt6zU6qpR6SNly8lSjEtPox3XtHjUVteJEYH5LkKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Hs2emRg;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1736606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 00:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1736606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Hs2emRg
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so2884405e9.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 17:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148936; x=1793753736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HzH8rykX5lmcZm9pB6FHq6gj3hJ7Y5hZ3zn+8svQBtg=;
        b=0Hs2emRg91qIM8PJTETU1uctThZ6xzoZy7RfV4IYtkSbB2npBvofG0LkEmloIA+7Qw
         uyIKtxOwqYlIuVFJ5OoVN/atFvsTck/gM4njkRSG1rTHwODgoXb+piapKtOWlvsGamVW
         q0ur5ex1UJV99FnY2ePxOIJ5rWi7wLSr4IgZYvB3A1tndimjxAIR8Atc3rwyVLprsVFQ
         kZZltfPSpi2/pymLQ555h1m+q6P9WSQIteP+7U5nSG7KX66gZGUQPkdnczFvr81I412q
         mXh6+TjzjOck86MyH1Tw9fyMZt6C5noj3lBZRebvxAD2ZuEbcUuxzJ6NHJxfuFxdA+w1
         r8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148936; x=1793753736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HzH8rykX5lmcZm9pB6FHq6gj3hJ7Y5hZ3zn+8svQBtg=;
        b=tYqW4lfM8Qgnkc1tSKvIhR4fUgc1vspl9imlXPg8hKilzh7HSvuxH3JOsHnnZtEdUf
         cjjuCdLpPY/jgErJzPVaCqqf9XxGvfc57V3Ses8VVj0drR+QOfTQ4Lv5M5DjEl7pXFjC
         aV2NtlmqGheJw7khphQ+2gv0GQs7/AaEA1LseOVplhvTDOm/SAmUlPLKDG8vI2Tft1zB
         ESTgMmZ1Hs1wkhXiwIgnIDzHG7RKLequeWXSbzD7UDRxy9AkfghkSvikqGVSdJULNFub
         o46AinGbkGmW3cguaSGS7ULYARuGnCGgYcHRHqjA0Wrt4hCu8okyCs7CN8H76L+IgHfF
         ww6A==
X-Forwarded-Encrypted: i=1; AKwUvBzHAgZpZbow4f7KizKITBA6FBVPHjjEjpE2kw+dovK+pB675AIkl3w3yqEZyE5pkUWqLAKpN4azyIA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLj9ZZCxzOOBqHim1jOsnF6JGZhMijvxb2YnZ09T6gFCfW0aNsO
	UjchyHIaWOeDG2DhpW7nNjG51HrGIgWtX55VRop76Z7wZOFfrNEs+7o+
X-Gm-Gg: AYBFou1sibguuOBvNvPRGxHlfZWADkqU1NQqYTD1j9A5iKYZ812J4FpWE9aY6o8Eraa
	H4B85HqCuCfm0gDvBUx81ATiPxoDUZBCZzUCU2dwIhWCmPsNDkyvwMWDMKQuHWvouBnkRzvB9DX
	gJlX+Y75o37jp0upxFhJ919/jp0epp9hXzz+kV2i6dKJPtOheuKTNkw+LfJ/DyOb/6EKdv76eEk
	A/HEnZ7hbingyXYGbVRYu5sxNfS/BwemO9FPhSVTlW4ZIy4AgqHLwpa9zLitnbgYjW0MVqMDgy4
	rs+smDXakn39uNUe8zox0bTDDm/uXU9ViK+jmcO8MICP4U3genbPtEFyIwM6z4osxfup1ICd0bG
	1ycuX87QE01yPtowcfYVS7RORAZ7QXRbgADH9vuSUmH3ixakrylBNKc9Fhf6fNPr+k5mxxkyC9L
	z+SY9HjrB9fTu2qdhXp9ZgqHw+h3htICCNXBiVQvBKy2wa6Wk6vnMApyr9oaDMWg/khJe7xfDvM
	jB2HzCUTbdmIqaCy2FzNS5h6+XROroXlHF+T31reI426JY+90USB+Ig+U1yFdjvTAPtP4yjfSya
	aWPMTd3ay+iLTGBFku6y9Y3wAAqNZ3fR4THuaygMYYYn/fheqJ1s+aGiEiW/aZ5PoJxHnjkAG4n
	Yqg81HMJMmTc2FlyVfpPCTJw1c0jSIYZRUpBwZY6AW9Kgpw==
X-Received: by 2002:a05:600c:a11:b0:4a1:e11f:b2e1 with SMTP id 5b1f17b1804b1-4a966773233mr13027905e9.15.1793148935956;
        Tue, 27 Oct 2026 17:55:35 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a978d57b39sm13261575e9.10.2026.10.27.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:55:34 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iav@iav.lv
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is already valid
Date: Wed, 28 Oct 2026 00:55:32 +0000
Message-ID: <20261028005532.2399083-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179196286749.38040.5597453767131590054.b4-reply@b4>
References: <20260911211559.207990-1-ehbello@gmail.com> <179196286749.38040.5597453767131590054.b4-reply@b4>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026 12:57:47 +0530, Manivannan Sadhasivam wrote:
> This is hard to believe. First of all, Tpvperl is the min time specified by
> the CEM spec to allow the power to be stable, not the max.

Agreed, and the patch should not have implied otherwise. Waiting longer than
Tpvperl breaks no requirement, and I am not claiming the current code
violates the spec. What the patch rests on is only your next point: that the
wait is redundant when the supplies are already up.

> Maybe the issue is with the delay between PERST# assert and deassert?

That is exactly the variable this patch changes, and I buried it under the
power-validity argument. Let me restate the mechanism in those terms,
because I think we agree on it.

PERST# is asserted when the GPIO is acquired, not at the top of
rockchip_pcie_host_init_port():

  pcie-rockchip.c:
	rockchip->perst_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_LOW);

and it is released at the end of the init sequence:

  pcie-rockchip-host.c:
	gpiod_set_value_cansleep(rockchip->perst_gpio, 0);	/* already low */
	rockchip_pcie_init_port(rockchip);			/* PHY, clocks */
	... register writes, Gen1 training enable ...
	msleep(PCIE_T_PVPERL_MS);
	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);	/* release */

So the low pulse spans the regulator enables, the PHY init and the register
writes, and commit c47f90be4c89 added 100 ms to the end of it. Removing that
sleep does not shorten the time power has been valid -- which, as you say,
is seconds by then -- it shortens the PERST# assertion by 100 ms. That is
the only behavioural difference the patch makes at probe, and it is what the
boot statistics in the commit message measure.

> But claiming that the Endpoint doesn't tolerate this 100ms delay, but still
> several seconds of the boot delay is quite hard to believe.

The endpoint is not held in reset for seconds. Before this driver probes,
the pin is in whatever state the bootloader left it; the reset the endpoint
sees is the pulse the driver applies, from the gpiod acquisition above to
the release, and c47f90be4c89 made that pulse 100 ms longer. Whether that
crosses a threshold in this particular endpoint's firmware is what the
measurements below address.

> Is the PERST# signal polarity on the board DTS correct?

As far as I can tell, yes. ROCK Pi 4 declares

	ep-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;

and the driver acquires the line with GPIOD_OUT_LOW and releases it with
gpiod_set_value(..., 1). PERST# is active low at the connector, so logical
low is physical low is reset asserted: the DTS polarity and the driver's use
of it agree. The Kobol Helios64 that Igor reports on uses the same polarity
(GPIO_ACTIVE_HIGH) with the same SoC and the same endpoint chip, and does
not show the boot failure, so polarity does not separate the two boards
either.

> I do agree that the Tpvperl delay is *redundant* if the supplies are already
> enabled by the bootloader. But I do not agree that it causes the Endpoint to
> not respond.

You were right, and the two claims needed separating. I have now run that
experiment, so here is the data rather than the argument.

I instrumented the driver with two module parameters, one sleeping before
the gpiod acquisition (so before PERST# is asserted) and one in place of the
existing msleep (so inside the assertion), plus a ktime delta across the two
gpiod_set_value() calls to measure the pulse the endpoint actually sees. One
kernel, both knobs writable at runtime, and the host driver rebound through
unbind/bind to re-run the whole probe -- I checked first that a rebind
reproduces the cold-boot failure, and it does, identically.

  before assert   after assert   measured pulse   trials   enumerated
  0 ms            0 ms            1-11 ms              5        5
  0 ms           10 ms           ~18 ms                3        3
  0 ms           15 ms           24-47 ms              4        4
  0 ms           20 ms           ~28 ms                3        1
  0 ms          100 ms          ~108 ms                4        0
  200 ms          0 ms            6-11 ms              5        5
  200 ms        100 ms          ~108 ms                1        0

Compare each 200 ms row with its 0 ms counterpart: delaying the assertion
changes nothing either way -- 5 of 5 with a short pulse, 0 of 4 and 0 of 1
with a long one -- while widening the pulse decides the outcome every time.
So it is the delay between assert and deassert, exactly as you guessed.

And your objection holds in a way I had not appreciated. vcc3v3_pcie on this
board is regulator-always-on and regulator-boot-on, so the supplies have
been valid for seconds before the driver probes in *every* row above,
including the failing ones. Tpvperl is therefore met whether the sleep runs
or not, which means it cannot be what distinguishes a working configuration
from a failing one. The redundancy of the wait is only the licence to drop
it; it was never the explanation. The commit message had that backwards.

Two caveats I should state rather than smooth over. The threshold is noisy,
not a cliff: at 15 ms one trial measured a 47 ms pulse and still enumerated,
while 20 ms fails at ~28 ms. Across every configuration with the sleep at
15 ms or less it enumerated 17 of 17; around 28 ms it fails more often than
not; at ~108 ms it has never once worked, in 5 attempts (3 cold boots and
2 rebinds). And the failure is not a missing
device: the unanswered config read comes back as an external abort, so the
board dies with an asynchronous SError in rockchip_pcie_rd_conf() rather
than just enumerating nothing.

v3 therefore leads with the pulse width and demotes Tpvperl to the reason
the sleep can safely be skipped. The code is unchanged from v2: the two
cannot be had together in general, since on a board that powers the slot at
probe time the assertion does have to outlast Tpvperl, so skipping the wait
only where the supplies are already up is the conservative form of the fix.

Thanks for pushing back on this -- the causal claim deserved it, and the
alternative you proposed turned out to be the right one.
