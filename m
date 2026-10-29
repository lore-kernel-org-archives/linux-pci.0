Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265612;
	b=r1/8IhNpk3Anndnka9xNxEqwilTnFNtr4/Kkl2h+dkt2BjNhEUikXWmP1B4LTMJCXpee
	 WbnJn9l3Cev+M9UPCIeInMXTzdoJl3TQW68TeHlnhADp0V0USHM5YA6qX8+tSH11UqbpZ
	 Pbe7ur9BiOb8PfYLOwM+4OAWWJFk71NseL6yJiQCOu5AYWsieYT1vdsw83isZErgWAoiQ
	 7y2L8RoHrsZ9pzksZp1hVbanA7quqGwsIrHEvx5S8PtveXqfl/GKhMkwxBzJtP9UaIE7T
	 qn+TmUDlZXFlhy9RZCk0kVsoopQ7ZtX+8PKzke0iftUy3UrmJXCpiUr1BIvowMkQ4/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265612;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HSMs+yYFKEoS2+MTkImUlsUWlkmJUy2dSIxHLs9A0FQ=;
	b=f8NQMuBaRTVFv2z5pVcmZH9Ox7CNzYM34cqoalPuBnfZdxwsB8tPpwHB/WhQ5TFyz3pW
	 6fUAyh3zxB8qI+aEe3qJFN/+Gzfsb41GSpHqZk2l8wuZB5Thtp7ADlDKrJLhydbl3+z74
	 W3J6BHkJOOAKXl6cH/OqkAVmwV31ht347kBxR7FEwIM4Z96NdYkNcxKwNJZZ4CtmvxVxX
	 QKtsSLQi5Y6Rgt2i22K4tXPulVVpSLzlJVcUYWML9wPesLJETnk1pLARKYg+dZZI+gL87
	 IiHrGwM7exCL52MqRfQ1aPAg8WdtWGgcuTFVXyu2iMrE2y5Hfl5WpPOC1/POGkqUhJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVyYfG1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F174606A32C;
	Thu, 29 Oct 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVyYfG1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB441F031E0;
	Thu, 29 Oct 2026 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265611;
	bh=HSMs+yYFKEoS2+MTkImUlsUWlkmJUy2dSIxHLs9A0FQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVyYfG1QjV4KwYvB1w6R0Xm1uZK7uW7sw0JvQ6Rl5GrGbcO1IRmmIm3I8g66VKzGO
	 S8WWTXbV2o1yGVfZrivlj6Hm9B4ERrhI6LiTp05Ojk9CG6kJ7s+MPE4qAzuTDLgsAI
	 WaB6xAnJQlolAR0f+KodZBdDIvSskH5YFrjxFzrVyNeanZPUYH/RPb0EUhk+6+dQ2M
	 yilaSV9jfx6UMuIwiBkdxdos0tnrusk9mFr2LpzIiJ/zcb27+oFnKcd70kAZKh+Mkc
	 DghFY6+XBp23szIzwvqp/J9Rdmu/JqkwTWLcFhy0zwliJzrWJAjBfU+qEEB5DfoLvu
	 Hb6ot/oRW2xiA==
Message-ID: <sashiko-outbox-189026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/14] treewide: Add backend for macsmc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, "Sven Peter" <sven@kernel.org>, "Janne
 Grunau" <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>, "Guenter Roeck" <linux@roeck-us.net>, "Jonathan
 Cameron" <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?b?TnVubyBTw6E=?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Lee
 Jones" <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>, "Griffin
 Kroah-Hartman" <griffin@kroah.com>, "Hans de Goede" <hansg@kernel.org>,
 =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, "Sebastian
 Reichel" <sre@kernel.org>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, "Wim
 Van Sebroeck" <wim@linux-watchdog.org>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>, "Dmitry
 Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric Snowberg" <eric.snowberg@oracle.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, mfd@lists.linux.dev, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261029085504.3547-2-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:20:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mfd: macsmc: Kconfig split disables Apple SMC drivers in arm64 def=
config
- [Medium] mfd: macsmc: missing notification cleanup on apple_smc_probe() e=
rror
- [Low] mfd: macsmc: endianness type mismatch in apple_smc_probe() #KEY read
--

commit f3824312f6532aec08553002200ae557d8b3b0da
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

treewide: Add backend for macsmc

This commit splits the Apple SMC driver into a core MFD driver
(drivers/mfd/macsmc-core.c) and an RTKit backend driver
(drivers/soc/apple/macsmc-rtkit.c) so that additional SMC backends such as
ACPI on Intel Macs can share the core and sub-drivers.

[ ... ]

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 87ed55c155f03..c58cc3315f22a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -339,24 +339,15 @@ config MFD_LOCHNAGAR
>  	help
>  	  Support for Cirrus Logic Lochnagar audio development board.
> =20
> -config MFD_MACSMC
> -	tristate "Apple Silicon System Management Controller (SMC)"
> -	depends on ARCH_APPLE || COMPILE_TEST
> -	depends on OF
> -	depends on APPLE_RTKIT
> +config MFD_MACSMC_CORE
> +	tristate "Apple System Management Controller (SMC) Core"
>  	select MFD_CORE

[Severity: High]
Does removing this symbol without updating arch/arm64/configs/defconfig or
providing defaults cause a regression where all Apple SMC drivers become
disabled on arm64 builds?

In arch/arm64/configs/defconfig:

    CONFIG_MFD_MACSMC=3Dm

With that symbol removed and neither the new core option nor the new rtkit
backend option in drivers/soc/apple/Kconfig having a default, running
olddefconfig or building arm64 defconfig drops the unrecognized symbol and
disables the core, backend, and all dependent sub-drivers (gpio, reset,
hwmon, power supply, and rtc).

Should arch/arm64/configs/defconfig be updated and/or should the rtkit
backend select the core option and default to m or y when the Apple platform
dependencies are enabled?

[ ... ]

> diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
> new file mode 100644
> index 0000000000000..b8905c834c448
> --- /dev/null
> +++ b/drivers/mfd/macsmc-core.c
> @@ -0,0 +1,164 @@

[ ... ]

> +int apple_smc_probe(struct device *dev, const struct apple_smc_backend_o=
ps *ops,
> +		void *cookie, struct blocking_notifier_head *event_handlers, bool is_a=
cpi)
> +{
> +	struct apple_smc *smc;
> +	__be32 count;
> +	int ret;
> +
> +	smc =3D devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
> +	if (!smc)
> +		return -ENOMEM;
> +
> +	smc->dev =3D dev;
> +	smc->be_cookie =3D cookie;
> +	smc->be =3D ops;
> +	smc->is_acpi =3D is_acpi;
> +	smc->event_handlers =3D event_handlers;
> +	mutex_init(&smc->mutex);
> +	spin_lock_init(&smc->lock);
> +
> +	ret =3D apple_smc_read_u32(smc, SMC_KEY(#KEY), &count);
> +	if (ret < 0)
> +		return ret;
> +	smc->key_count =3D be32_to_cpu(count);

[Severity: Low]
Doesn't passing &count (declared as __be32) to apple_smc_read_u32() trigger
a sparse endianness warning?

In include/linux/mfd/macsmc.h, apple_smc_read_u32() expects a host-endian
u32 * pointer:

    static inline int apple_smc_read_u32(struct apple_smc *smc, smc_key key=
, u32 *p)
    {
        int ret =3D apple_smc_read(smc, key, p, sizeof(*p));
        return (ret < 0) ? ret : ((ret !=3D sizeof(*p)) ? -EINVAL : 0);
    }

Previously, apple_smc_probe() called apple_smc_read() directly with &count,
which took a void * buffer. Should apple_smc_probe() either call
apple_smc_read() as before or use a helper that accepts __be32?

[ ... ]

> diff --git a/drivers/mfd/macsmc.c b/drivers/soc/apple/macsmc-rtkit.c
> similarity index 70%
> rename from drivers/mfd/macsmc.c
> rename to drivers/soc/apple/macsmc-rtkit.c
> index 514cba7dc897a..eaebeb1be3734 100644
> --- a/drivers/mfd/macsmc.c
> +++ b/drivers/soc/apple/macsmc-rtkit.c

[ ... ]

> @@ -458,49 +450,32 @@ static int apple_smc_probe(struct platform_device *=
pdev)
>  		return -EIO;
>  	}
> =20
> -	dev_set_drvdata(&pdev->dev, smc);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&smc->event_handlers);
> =20
> -	ret =3D apple_smc_read(smc, SMC_KEY(#KEY), &count, sizeof(count));
> -	if (ret >=3D 0 && ret !=3D sizeof(count))
> -		ret =3D -EINVAL;
> -	if (ret < 0)
> -		return dev_err_probe(smc->dev, ret, "Failed to get key count");
> -	smc->key_count =3D be32_to_cpu(count);
> -
>  	/* Enable notifications */
> -	apple_smc_write_flag(smc, SMC_KEY(NTAP), true);
> -	ret =3D devm_add_action_or_reset(dev, apple_smc_disable_notifications, =
smc);
> -	if (ret)
> -		return ret;
> +	apple_smc_rtkit_rw_locked(smc, SMC_KEY(NTAP), &flag, sizeof(flag), NULL=
, 0);
> =20
> -	ret =3D devm_mfd_add_devices(smc->dev, PLATFORM_DEVID_NONE,
> -				   apple_smc_devs, ARRAY_SIZE(apple_smc_devs),
> -				   NULL, 0, NULL);
> -	if (ret)
> -		return dev_err_probe(smc->dev, ret, "Failed to register sub-devices");
> -
> -
> -	return 0;
> +	return apple_smc_probe(dev, &apple_smc_rtkit_backend_ops, smc,
> +			&smc->event_handlers, false);
>  }

[Severity: Medium]
If apple_smc_probe() fails before registering the
apple_smc_disable_notifications() cleanup action, won't SMC notifications
remain enabled on the error path?

In apple_smc_rtkit_probe(), notifications are enabled before calling
apple_smc_probe(). Inside apple_smc_probe() in drivers/mfd/macsmc-core.c,
several operations can fail and return early before
devm_add_action_or_reset() is called:

    smc =3D devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
    if (!smc)
        return -ENOMEM;
    ...
    ret =3D apple_smc_read_u32(smc, SMC_KEY(#KEY), &count);
    if (ret < 0)
        return ret;
    smc->key_count =3D be32_to_cpu(count);

    ret =3D apple_smc_get_key_by_index(smc, 0, &smc->first_key);
    if (ret < 0)
        return ret;

    ret =3D apple_smc_get_key_by_index(smc, smc->key_count - 1, &smc->last_=
key);
    if (ret < 0)
        return ret;

    dev_set_drvdata(dev, smc);

    ret =3D devm_add_action_or_reset(dev, apple_smc_disable_notifications, =
smc);

Previously, notifications were only enabled after reading the key count and
the devm cleanup action was registered immediately afterward. In addition,
apple_smc_disable_notifications(), apple_smc_enter_atomic(),
apple_smc_write_atomic(), and apple_smc_rw() in drivers/mfd/macsmc-core.c
unconditionally call backend ops without checking if the callback pointer is
null.

Could notification enabling and its devm cleanup action be kept together
(or guarded for backends that do not implement all callbacks)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1
