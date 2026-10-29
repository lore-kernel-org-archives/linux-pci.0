Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265388;
	b=A7MhxM7azyWfDgEvFdYLTQyqcLiHPBNOwDIKPBWAUW64Ox2fe12O7j0tQ2t1rvGnT9ik
	 c99c8lg1kuiBY1jqmuDtn3G2d8gVxnnUFfxUUCVPV48K7Kt3exjLsR6XE5drpSHkcnpk/
	 LVqTRne1L4Q4C6mHN0HEWgYGS8KJBInAB8+l/gYRk/u9RdxJLeVan9F62xrkg5Wf3wLMd
	 YAWPx6DDUm0yVTz6+W3Ao2+AGsaC5G+e4kcF2nrO2HMTdDTuOjEuRMrvqk4QQ7bK6LBoU
	 Zk5VVzML7eObFu0222bPV5vfVVUXbiEkZvtLVq409Uh1Kowl5DauLEzYVRAknMNOWsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YNgX5SFBiaSwcUYiUIFMJCezPEVB23e8ZTa3oJkkbD0=;
	b=S5LfK4SybmKWKh9nlkmDLI7jx/CDm7e0ZKbhpFIgEv2rdd6aVcm1RpqctO8tSW/oADUQ
	 j/WR3yTTgj3E/HIXaQfyCZVtodSb9CYmotnCxze4D7aJcnTb77Trky8EUAMbhXIgFsuXp
	 Q5EuKg8Ff2wKvxf6k58MwtrgqFh6HdIjKVm1MDIGkBlFyIBfM2yHCmKvk8oBFCBaR+NPE
	 Kcu8KTOoWkLNo1djX9ogxWuDNGZ+TjghZsqRhYfE/ZsCiaCPQ2Ti0s/+FLbTAG0KTbt0U
	 fASQBCtyaAyRtdrznr/bIZE/XQuIRpKdMcsH9GX3KK6e2F9AvQQfJK0nyyyTgJhTI1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qc5QJZSw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B8606A32A;
	Thu, 29 Oct 2026 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qc5QJZSw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F19B1F01825;
	Thu, 29 Oct 2026 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265387;
	bh=YNgX5SFBiaSwcUYiUIFMJCezPEVB23e8ZTa3oJkkbD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qc5QJZSwpHJgdtfKCiV3SajWICNMXRPg6ELzvOWJ5HKkW3B377mfi8xb/12Pkf9F/
	 y1cyPB3nECoJHTXSeJ9l/hGLYPsoWbwaNe+xPkYI2sW66nzzSU/eQed6EnXKCDxotc
	 YInhS4duiisDGcWl6M5kVbFfTDtqagPwskeQlYyd2PADGH72BTRDlfq2HKi8BQESCZ
	 /yektBzMjdMy92Qkl3voE42/7DU18fmIWwyz7vQVUpn/EdKRmfOBS1l3AUez/fByy1
	 45tiMiCZqG8bb5Vnu6b2chTGjmYtgyo/bJa9v3TVse45tqI9f9X/60/R2fZyGXPAsp
	 BIAFGrYyrTJkw==
Message-ID: <sashiko-outbox-189015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/14] leds: add support for macsmc kbl
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
In-Reply-To: <20261029085504.3547-7-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-7-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:16:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] leds: macsmc: sleeping SMC write registered as non-blocking bright=
ness_set
- [Medium] leds: macsmc: non-standard LED name breaks kbd_backlight discove=
ry
- [Medium] leds: macsmc: missing suspend/resume handling loses backlight st=
ate
- [Low] leds: macsmc: commit prefix, drv naming, and Makefile sort order vi=
olations
--

commit 62f13fe6413b6947c13026e13a39c022cd83dde2
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

leds: add support for macsmc kbl

This commit adds a LED class driver for the Apple SMC keyboard backlight on
Intel Macs and registers the macsmc-led MFD cell when the LKSB key is prese=
nt,
intended to replace the keyboard backlight support in applesmc.

>     leds: add support for macsmc kbl
>    =20
>     Add a LED class driver to control the keyboard backlight.
>    =20
>     This replaces the keyboard backlight support in applesmc.
>    =20
>     Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

[Severity: Low]
This isn't a bug, but should the commit subject follow the LED subsystem
convention of including the driver prefix and capitalizing the description,
such as "leds: macsmc: Add support for keyboard backlight"?

[ ... ]

> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4d4b089156e24..7c38dbef42390 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_LEDS_KUNIT_TEST)		+=3D led-test.o
>  obj-$(CONFIG_LEDS_88PM860X)		+=3D leds-88pm860x.o
>  obj-$(CONFIG_LEDS_ACER_A500)		+=3D leds-acer-a500.o
>  obj-$(CONFIG_LEDS_ADP5520)		+=3D leds-adp5520.o
> +obj-$(CONFIG_LEDS_MACSMC)		+=3D leds-macsmc.o
>  obj-$(CONFIG_LEDS_AN30259A)		+=3D leds-an30259a.o

[Severity: Low]
This isn't a bug, but the platform drivers section in drivers/leds/Makefile
is kept sorted alphabetically. Should leds-macsmc.o be placed in alphabetic=
al
order right before leds-max5970.o?

> diff --git a/drivers/leds/leds-macsmc.c b/drivers/leds/leds-macsmc.c
> new file mode 100644
> index 0000000000000..f38ef2113aced
> --- /dev/null
> +++ b/drivers/leds/leds-macsmc.c

[ ... ]

> +static enum led_brightness macsmc_led_get_brightness(struct led_classdev=
 *cdev)
> +{
> +	struct macsmc_led *drv =3D container_of(cdev, struct macsmc_led, cdev);
> +
> +	return drv->brightness;
> +}
> +
> +static void macsmc_led_set_brightness(struct led_classdev *cdev, enum le=
d_brightness value)
> +{
> +	struct macsmc_led *drv =3D container_of(cdev, struct macsmc_led, cdev);
> +
> +	drv->brightness =3D (u8) value;
> +
> +	apple_smc_write_u16(drv->smc, SMC_KEY(LKSB), drv->brightness);
> +}
> +
> +static int macsmc_led_probe(struct platform_device *pdev)
> +{
> +	struct macsmc_led *drv;

[Severity: Low]
This isn't a bug, but could the private data pointer be named ddata instead
of drv in macsmc_led_get_brightness(), macsmc_led_set_brightness(), and
macsmc_led_probe() to match the LED subsystem naming convention?

> +
> +	drv =3D devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->smc =3D dev_get_drvdata(pdev->dev.parent);
> +
> +	drv->cdev.name =3D "macsmc-led";

[Severity: Medium]
Will setting drv->cdev.name to "macsmc-led" in macsmc_led_probe() cause a
regression for userspace tools discovering the keyboard backlight?

In drivers/hwmon/applesmc.c, which this driver replaces, the LED class devi=
ce
is registered with the name "smc::kbd_backlight":

    static struct led_classdev applesmc_backlight =3D {
        .name            =3D "smc::kbd_backlight",
        .default_trigger =3D "nand-disk",
        .brightness_set  =3D applesmc_brightness_set,
    };

Documentation/leds/leds-class.rst also specifies that keyboard backlight LED
devices should use kbd_backlight as the function suffix so that userspace
consumers (such as upower and systemd-backlight) can identify them under
/sys/class/leds/. Should this keep "smc::kbd_backlight" to preserve UAPI
compatibility?

> +	drv->cdev.max_brightness =3D 255;
> +	drv->cdev.brightness_get =3D macsmc_led_get_brightness;
> +	drv->cdev.brightness_set =3D macsmc_led_set_brightness;

[Severity: High]
Can registering macsmc_led_set_brightness() on drv->cdev.brightness_set in
macsmc_led_probe() sleep in atomic context when an atomic LED trigger or
software blink timer fires?

When software blinking or an atomic trigger updates the LED, the call chain
led_timer_function() or led_trigger_event() -> led_set_brightness_nosleep()=
 ->
led_set_brightness_nopm() -> __led_set_brightness() invokes the
brightness_set callback synchronously without deferring to
set_brightness_work:

    /* Use brightness_set op if available, it is guaranteed not to sleep */
    if (!__led_set_brightness(led_cdev, value))
        return;

However, macsmc_led_set_brightness() calls apple_smc_write_u16() ->
apple_smc_write():

    int apple_smc_write(struct apple_smc *smc, smc_key key, const void *buf=
, size_t size)
    {
        guard(mutex)(&smc->mutex);
        return smc->be->write(smc->be_cookie, key, buf, size);
    }

This acquires a sleeping mutex and calls apple_smc_acpi_write(), which slee=
ps
via wait_for_completion_timeout() and fsleep(). Unlike applesmc, which queu=
ed
a work item on a workqueue in applesmc_brightness_set(), this sleeps direct=
ly
in the caller's context and also discards any error returned by
apple_smc_write_u16().

Should macsmc_led_set_brightness() be registered via
drv->cdev.brightness_set_blocking instead, and return the result of
apple_smc_write_u16()?

> +	drv->cdev.dev =3D &pdev->dev;
> +
> +	return devm_led_classdev_register(&pdev->dev, &drv->cdev);
> +}

[Severity: Medium]
Does omitting suspend and resume handling here cause the keyboard backlight
state to be lost across system suspend or hibernation?

In drivers/hwmon/applesmc.c, applesmc_pm_resume() and applesmc_pm_restore()
restore the saved brightness to the hardware key on resume:

    static int applesmc_pm_resume(struct device *dev)
    {
        if (smcreg.has_key_backlight)
            applesmc_write_key(BACKLIGHT_KEY, backlight_state, 2);
        return 0;
    }

Because macsmc_led_probe() does not set LED_CORE_SUSPENDRESUME in
drv->cdev.flags (and macsmc_led_driver does not define PM callbacks), the
keyboard backlight is not turned off on suspend or restored on resume. Note
 also that if LED_CORE_SUSPENDRESUME is enabled, the custom brightness_get
callback returning drv->brightness would return 0 during resume after
led_classdev_suspend() sets the brightness to 0, unless the LED core's
cached brightness is used instead of a custom brightness_get callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D6
