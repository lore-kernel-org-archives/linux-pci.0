Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265577;
	b=HqfbWxPWDwYzWStJpDizznHChhQxIjc5AueINJJRZgBy+0rNx8LwiYlgGxdiDBDiMcbp
	 NMjSOnU0WZP7OCOr8xq09RoRw7HniNCacYH3ZuMP3cSq3Dqm3PgLdpHKLFpmqosPBNY7a
	 3lzdhvlSHxAHJmEr8RPsl/U8GN3hdbTXCUr86H/wwZFFth0uxNL1cb4gwpJBlClae50Z5
	 L/hWCCIEPkW6dev3ldzqVqWatJYTCLC8jYMPm9bfra+2rFaP2kQEBBa1WqtHGx+qah9Zg
	 y2qOLYkpJNnJpYMcgBNzhfQaJQwZz6Qj6R5g3l4H2/vhAFZ5m/CRmDaO2snPg9s24mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265577;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V2e+D7RolMrPpU0f9XMQkrgGvr/8cN5nFds9RUQu7TE=;
	b=Sbf7g0bIBaU4e+gSnxa6EWI097dL85/AhXQ3crFvsXIF8fMA6ufT2jbHir9N7da0Oryw
	 ZvAZSklF3uQKqc/uIxI3LTH10droWGuyNaPda/Gm9RHIG0gRAM15/sYaBao/c/Cd8tlGc
	 vnA9K0c2Vm76ltuQ1HBfU+6c3FSWs8TDn+dNGo2wluW62v7MDIrKe/76MSXAxGwzSlHnF
	 Pk5OjXcUGXAv0bSngbyNtTtGp0z+Sfabtfil7KBIvmJY/KiU7eiGG13ZPxqcGn5xsM26M
	 M9z3TWifqFAm1y+jjZbspP8VXmVEoUAzPyQ5ZHWliMsLdgC28rvb0ozZOH/Ri2eCZ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrPFzEFM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D78606A31E;
	Thu, 29 Oct 2026 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrPFzEFM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0611F031E4;
	Thu, 29 Oct 2026 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265576;
	bh=V2e+D7RolMrPpU0f9XMQkrgGvr/8cN5nFds9RUQu7TE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrPFzEFMqPBq8TD5KQJje4l7j0OgD1al1rv+AOFrxexwd97Ooch9lQOoMcKg+7HaC
	 YvUoLPFmRi3McMAfXva0jWfc3aIi11SqpyRhG3y9Y+txEC+1wojOTsj7823Z6MJUsN
	 YdN5aF9TyNww2LwZKqAdfUV7Au9CYdrbr1Rmvf/CxeZ5ZK0qJ+QztNoFWrS6jmimvw
	 EmugMEqBtv+uqkMDLpjikNSUEWHs6ffK9wPHbTtXJLNYiQ2QZyP3u2P2boEMgaGaW6
	 5zEN1we27EZX61xua4afsgPbCU5paobE/Yw2zC016ihS8/Ts+nWbWw4qllPC+GJy1G
	 65u4OhBZuJAUA==
Message-ID: <sashiko-outbox-189024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/14] power/supply: add support for x86 macs in
 macsmc-power
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
In-Reply-To: <20261029085504.3547-11-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-11-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:19:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] power: supply: macsmc: NULL deref in macsmc_power_remove() without=
 battery
- [High] power: supply: macsmc: notify handler UAF and ref leak in macsmc_p=
ower_probe()
- [High] power: supply: macsmc: unchecked power supplies in macsmc_power_ac=
pi_notify()
- [Medium] power: supply: macsmc: uninitialized adapter_status in macsmc_po=
wer_probe()
- [Medium] power: supply: macsmc: missing swab16() for B0TE on ACPI Macs
- [Medium] power: supply: macsmc: missing else in macsmc_power_probe() batt=
ery check
- [Medium] power: supply: macsmc: 32-bit overflow in macsmc_battery_acpi_re=
ad()
- [Low] power: supply: macsmc: build failure when CONFIG_ACPI is disabled
--

commit 14a9bd57ae09c9ca5072f486dd3745277286ab3b
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

power/supply: add support for x86 macs in macsmc-power

This commit adds support for Intel Macs to the macsmc-power driver,
exposing battery and AC adapter sensors as well as charge limit controls
on ACPI-based Apple systems.

> diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/m=
acsmc-power.c
> index ced37a7019981..1d64d8185ed7b 100644
> --- a/drivers/power/supply/macsmc-power.c
> +++ b/drivers/power/supply/macsmc-power.c

[ ... ]

> @@ -322,6 +362,198 @@ static int macsmc_battery_get_capacity_level(struct=
 macsmc_power *power)

[ ... ]

> +static int macsmc_battery_acpi_read(struct apple_smc *smc, smc_key key, =
int *val,
> +	int scale)
> +{
> +	int ret;
> +	struct apple_smc_key_info info;
> +
> +	ret =3D apple_smc_get_key_info(smc, key, &info);
> +	if (ret)
> +		return ret;
> +
> +	switch (info.type_code) {
> +	/* 32-bit IEEE 754 float */
> +	case __SMC_KEY('f', 'l', 't', ' '): {
> +		int flt_ =3D 0;
> +
> +		ret =3D macsmc_battery_acpi_read_f32_scaled(smc, key, &flt_, scale);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D flt_;
> +		break;
> +	}
> +
> +	/* 3.13 fixed point decimal */
> +	case __SMC_KEY('f', 'p', '3', 'd'): {
> +		u16 fp3d;
> +
> +		ret =3D apple_smc_read_u16(smc, key, &fp3d);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D mult_frac(be16_to_cpu(fp3d), scale, BIT(13));
> +		break;
> +	}

[ ... ]

> +	/* 3.12 signed fixed point decimal */
> +	case __SMC_KEY('s', 'p', '3', 'c'): {
> +		s16 sp3c;
> +
> +		ret =3D apple_smc_read_s16(smc, key, &sp3c);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D mult_frac((s16)be16_to_cpu(sp3c), scale, BIT(12));
> +		break;
> +	}

[Severity: Medium]
Can the mult_frac() calls for the fp3d and sp3c types overflow a 32-bit
signed int when scale is 1000000?

Inside mult_frac(x, n, d):

    typeof(x_) q =3D x_ / d_;
    typeof(x_) r =3D x_ % d_;
    q * n_ + r * n_ / d_;

Because x is u16 or s16 and scale is int (1000000), r * n_ is evaluated as
a 32-bit signed int multiplication before being converted to unsigned long
for division by BIT(13) (8192) or BIT(12) (4096). Whenever the fractional
remainder r is 2148 or larger, r * 1000000 exceeds INT_MAX and wraps around,
producing corrupted (and often negative) current, voltage, or power reading=
s.

[ ... ]

> @@ -359,36 +594,71 @@ static int macsmc_battery_get_property(struct power=
_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
>  		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0TF), &vu16);
> -		val->intval =3D vu16 =3D=3D 0xffff ? 0 : vu16 * 60;
> +		if (power->smc->is_acpi)
> +			val->intval =3D vu16 =3D=3D 0xffff ? 0 : swab16(vu16) * 60;
> +		else
> +			val->intval =3D vu16 =3D=3D 0xffff ? 0 : vu16 * 60;
>  		break;

[Severity: Medium]
In macsmc_battery_get_property(), POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW right
above this case reads SMC_KEY(B0TE) into vu16 without byte-swapping when
power->smc->is_acpi is true:

	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0TE), &vu16);
		val->intval =3D vu16 =3D=3D 0xffff ? 0 : vu16 * 60;
		break;

Since macsmc_power_probe() registers POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW on
ACPI Macs when B0TE is present, should B0TE also apply swab16(vu16) on ACPI
systems just like B0TF does here?

[ ... ]

> @@ -634,6 +1003,23 @@ static int macsmc_power_event(struct notifier_block=
 *nb, unsigned long event, vo
>  	return NOTIFY_DONE;
>  }
> =20
> +static void macsmc_power_acpi_notify(acpi_handle handle, u32 event, void=
 *context)
> +{
> +	struct macsmc_power *power =3D context;
> +
> +	if (event =3D=3D 0x80) {
> +		acpi_status status =3D acpi_evaluate_integer(power->adapter->handle, "=
_PSR", NULL,
> +								&power->adapter_status);
> +		if (ACPI_FAILURE(status))
> +			return;
> +
> +		power->adapter_status =3D !!power->adapter_status;
> +		power_supply_changed(power->batt);
> +		power_supply_changed(power->ac);
> +	}
> +}

[Severity: High]
What happens in macsmc_power_acpi_notify() if either power->batt or
power->ac failed to register during macsmc_power_probe()?

In macsmc_power_probe(), if devm_power_supply_register() fails for one of
the supplies, the failed pointer is set to NULL and probe continues as long
as the other supply succeeded. Unlike macsmc_power_event(), which checks
if (power->batt) and if (power->ac), macsmc_power_acpi_notify() passes both
pointers unconditionally to power_supply_changed(), which immediately
dereferences the pointer.

> +
> +
>  static int macsmc_power_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -670,15 +1056,19 @@ static int macsmc_power_probe(struct platform_devi=
ce *pdev)
>  	 * Check for battery presence.
>  	 * B0AV is a fundamental key.
>  	 */
> +	if (smc->is_acpi && apple_smc_read_flag(power->smc, SMC_KEY(BBIN), &fla=
g) =3D=3D 0 && flag)
> +		has_battery =3D true;
> +
>  	if (apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &vu16) =3D=3D 0 &&
>  	    macsmc_battery_get_status(power) > POWER_SUPPLY_STATUS_UNKNOWN)
>  		has_battery =3D true;

[Severity: Medium]
Should the second battery check be an else if (!smc->is_acpi && ...) branch?

As written, ACPI Macs always fall through to the second check and call
macsmc_battery_get_status(power), which queries Apple Silicon SMC keys
(CH0R, CHCE, CHCC, AC-i, BSFC, CHNC, CHSC) even when smc->is_acpi is true
and BBIN indicated no battery is present.

[ ... ]

> @@ -858,9 +1297,26 @@ static int macsmc_power_probe(struct platform_devic=
e *pdev)
>  	if (!power->batt && !power->ac)
>  		return -ENODEV;
> =20
> -	power->nb.notifier_call =3D macsmc_power_event;
> -	blocking_notifier_chain_register(smc->event_handlers, &power->nb);
> +	if (!smc->is_acpi) {
> +		power->nb.notifier_call =3D macsmc_power_event;
> +		blocking_notifier_chain_register(smc->event_handlers, &power->nb);
> +	} else if (power->has_battery) {
> +		power->adapter =3D acpi_dev_get_first_match_dev("ACPI0003", NULL, -1);
> +		if (!power->adapter)
> +			return -ENODEV;
> =20
> +		ret =3D acpi_dev_install_notify_handler(power->adapter, ACPI_DEVICE_NO=
TIFY,
> +					macsmc_power_acpi_notify, power);
> +		if (ret)
> +			return ret;
> +
> +		acpi_status status =3D acpi_evaluate_integer(power->adapter->handle, "=
_PSR", NULL,
> +					&power->adapter_status);
> +		if (ACPI_FAILURE(status))
> +			return -EIO;
> +
> +		power->adapter_status =3D !!power->adapter_status;
> +	}
>  	return 0;
>  }

[Severity: High]
If acpi_evaluate_integer() fails here in macsmc_power_probe(), does this
leave macsmc_power_acpi_notify() installed with a freed power context
pointer?

acpi_dev_install_notify_handler() is not devm-managed, so returning -EIO
causes devres to free power while the ACPI notify handler remains registered
on power->adapter; a subsequent 0x80 notify event will then dereference
freed memory in macsmc_power_acpi_notify(). In addition,
acpi_dev_get_first_match_dev() takes a reference on power->adapter via
get_device(), which is never released with acpi_dev_put() on these error
paths or in macsmc_power_remove().

[Severity: Medium]
Also in macsmc_power_probe(), devm_power_supply_register() is called for
both power->batt and power->ac before power->adapter is looked up and before
_PSR is evaluated into power->adapter_status.

Because __power_supply_register() queries the supply properties during
registration, won't the initial reads of POWER_SUPPLY_PROP_STATUS in
macsmc_battery_acpi_get_status() and POWER_SUPPLY_PROP_ONLINE in
macsmc_ac_get_property() always observe power->adapter_status as 0 even when
AC power is connected? Furthermore, evaluating _PSR directly into
power->adapter_status and normalizing it in place afterwards allows
concurrent property reads to observe the unnormalized value.

> =20
>  static void macsmc_power_remove(struct platform_device *pdev)
>  {
>  	struct macsmc_power *power =3D dev_get_drvdata(&pdev->dev);
> =20
> -	blocking_notifier_chain_unregister(power->smc->event_handlers, &power->=
nb);
> +	if (!power->smc->is_acpi)
> +		blocking_notifier_chain_unregister(power->smc->event_handlers, &power-=
>nb);
> +	else
> +		acpi_dev_remove_notify_handler(power->adapter, ACPI_DEVICE_NOTIFY,
> +				macsmc_power_acpi_notify);
>  }

[Severity: High]
On desktop Intel Macs without a battery (where power->smc->is_acpi is true
and power->has_battery is false), power->adapter is never initialized in
macsmc_power_probe() and remains NULL.

When macsmc_power_remove() runs on those machines, won't passing
power->adapter to acpi_dev_remove_notify_handler() cause a NULL pointer
dereference when it accesses adev->handle?

[Severity: Low]
Finally, does this driver still build when CONFIG_ACPI is disabled (for
example, on arm64 Apple Silicon configs with CONFIG_ACPI=3Dn)?

In include/acpi/acpi_bus.h, the full definition of struct acpi_device as
well as acpi_evaluate_integer(), acpi_dev_install_notify_handler(), and
acpi_dev_remove_notify_handler() are only provided under #ifdef CONFIG_ACPI
without !CONFIG_ACPI stubs, so dereferencing power->adapter->handle and
calling those functions in macsmc_power_acpi_notify(), macsmc_power_probe(),
and macsmc_power_remove() will fail to compile when CONFIG_ACPI is not
enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D10
