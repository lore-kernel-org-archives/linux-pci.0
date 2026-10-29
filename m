Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265467;
	b=uEMHDRCYfUZ8fslocste5Hle6ESe/2ZMISs9ydAEzJ7NqVGpj8XdoBn4ZXlMeCpEcPbd
	 Vbm9p1lOaFc4UrBKYVgakjhk4EOcbWXx/Rm6oTXRtjp5rDaP9ybRcW8WslJMbeb1ztOYK
	 aX71bwMJv1jE8Yv7yxXKxEoLCso9KN3NbSOCKG7rRHXb+KMUdcWZQzOctLGMv6GzyBSzn
	 sd9DrnabPWNDfoz25S+2K11tdOMX0rCuRd22lb9+Xktq7/tmAiUMkYK1CFWfDy3s4Z0b/
	 StJkzRm0Oq4BDXK3RtDu6MW5R7aj0pp43iHQchN99MWw2Gb113sRCm/vMyjSXx7kpow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OB2HeE9DKtC5yk+E2Xm08ENuV2evFbQBMYNRdVGUphQ=;
	b=JD54EEH7o+y2uRwL3YhbHCKvwdJi6AAvqYEx1SqGam0Lu5Lt0Ujr5vcqxFNrLlnTr9tO
	 RImQNfQ4O3t0g/iaLyQ0LEYXAwBg84NwCDlfuBlsESkVy20ZjHYsno4Pwj4bG+dEP9OfM
	 7bDe1ddyV0RLGQxxCTrjqfc/A5+a60ZlLAF20bABIKR/wzCokAuuBGM1kBNSAPrwGIbcV
	 n3eZj9vDcfHWLCuAb1bYgc0PNeeJ5qnlGpxX0BHtzeTcyGTSC78jJmhXnJJQT0tOCLOHD
	 yde7/NhKoeDOeoDTrd7yJVdAjeW19ipifxuQmvNVqsgJ5+Im8PViqmtFKExZMBdyBlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePmPrdiF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6D606A31A;
	Thu, 29 Oct 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePmPrdiF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB3F1F01825;
	Thu, 29 Oct 2026 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265467;
	bh=OB2HeE9DKtC5yk+E2Xm08ENuV2evFbQBMYNRdVGUphQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ePmPrdiFq5/iyxmE8gX22a3JwYROBZCFJz+5c/Vk34CbDGIp2Y1OXK/1x7l+QKcrx
	 zGBL9cdzKAbgD6wkfhaF2WsxgJlbsfNYHCk89zC+94P6JK6QKYBjUBMZ2uTnMmOLFG
	 Xf6U0qf15d+RNeOmyDwW1Pxil+CJKPznFQbrTdF7XzqXv/Ag7kdoK6gXg/Vg4rDSPu
	 HkkcZSgW62uu/ueldBSopACvXicPgYllaE140RvOZhIRCtT9KZsV10o5KNUovv2XR7
	 VOkPsrlTrGdSt9tpeFwXQTz3mdEwZeBZmS3UWhT6m6G7a5Rkt63EQykGHr7y5o3/Um
	 SthxlrpZjT7Fg==
Message-ID: <sashiko-outbox-189018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/14] watchdog: add driver for apple smc
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
In-Reply-To: <20261029085504.3547-4-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-4-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:17:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] watchdog: macsmc_wdt: u16 write to 8-bit NATJ key in macsmc_wdt_se=
t_timeout()
- [High] watchdog: macsmc_wdt: macsmc_wdt_set_timeout() arms stopped watchd=
og
- [High] watchdog: macsmc_wdt: missing WDIOF_MAGICCLOSE, parent, and stop h=
ooks
- [Medium] watchdog: macsmc_wdt: uninitialized default timeout in macsmc_wd=
t_probe()
- [Medium] mfd: macsmc: apple_smc_probe() only checks NATJ key for macsmc-w=
dt
- [Low] watchdog: macsmc_wdt: undocumented nowayout and timeout module para=
meters
--

commit 4d753d432c6f9bfd023f7ab788e1134dd8d67d8e
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

watchdog: add driver for apple smc

This patch adds a watchdog driver for the Apple SMC on Intel Macs and
registers the macsmc-wdt MFD device when the NATJ SMC key is present.

> diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
> index b8905c834c448..1c14698285456 100644
> --- a/drivers/mfd/macsmc-core.c
> +++ b/drivers/mfd/macsmc-core.c
> @@ -33,6 +33,10 @@ static const struct mfd_cell apple_smc_acpi_rtc[] =3D {
>  	MFD_CELL_NAME("macsmc-rtc"),
>  };
> =20
> +static const struct mfd_cell apple_smc_acpi_wdt[] =3D {
> +	MFD_CELL_NAME("macsmc-wdt"),
> +};
> +
>  int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, size_t=
 size)
>  {
>  	guard(mutex)(&smc->mutex);
> @@ -147,6 +151,13 @@ int apple_smc_probe(struct device *dev, const struct=
 apple_smc_backend_ops *ops,
>  				return ret;
>  		}
> =20
> +		if (apple_smc_key_exists(smc, SMC_KEY(NATJ))) {
> +			ret =3D devm_mfd_add_devices(dev, -1, apple_smc_acpi_wdt,
> +				ARRAY_SIZE(apple_smc_acpi_wdt), NULL, 0, NULL);
> +			if (ret < 0)
> +				return ret;
> +		}

[Severity: Medium]
In drivers/mfd/macsmc-core.c, apple_smc_probe() only checks for SMC_KEY(NAT=
J)
before registering apple_smc_acpi_wdt, whereas macsmc_wdt_probe() in
drivers/watchdog/macsmc_wdt.c checks for SMC_KEY(OSWD) on newer SMCs and
falls back to using both SMC_KEY(NATJ) and SMC_KEY(NATi) on older SMCs.

If a newer SMC provides SMC_KEY(OSWD) without SMC_KEY(NATJ), or if
SMC_KEY(NATJ) is present without SMC_KEY(NATi) and SMC_KEY(OSWD), will
device enumeration mismatch the keys required by macsmc_wdt? Should
apple_smc_probe() check for SMC_KEY(OSWD) || (SMC_KEY(NATJ) && SMC_KEY(NATi=
))
instead?

[ ... ]

> diff --git a/drivers/watchdog/macsmc_wdt.c b/drivers/watchdog/macsmc_wdt.c
> new file mode 100644
> index 0000000000000..38f68d0d87c10
> --- /dev/null
> +++ b/drivers/watchdog/macsmc_wdt.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Apple SMC Watchdog Driver
> + *
> + * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> + */
> +
> +#include <linux/mfd/macsmc.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +#define WATCHDOG_TIMEOUT 60 /* 60 sec default timeout */
> +
> +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started defa=
ult=3D"
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int timeout =3D WATCHDOG_TIMEOUT; /* in secounds */
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout,
> +		 "Watchdog timeout in seconds. 1 <=3D timeout <=3D 255, default=3D"
> +		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");

[Severity: Low]
Since nowayout and timeout are exposed as kernel command-line and module
parameters via module_param() in drivers/watchdog/macsmc_wdt.c, should they
be documented in Documentation/admin-guide/kernel-parameters.txt (and
Documentation/watchdog/watchdog-parameters.rst)? Also, MODULE_PARM_DESC for
nowayout is missing an opening parenthesis before default=3D.

> +
> +struct macsmc_wdt {
> +	struct apple_smc *smc;
> +	bool has_oswd; /* Newer version of watchdogs in macsmc */
> +	struct watchdog_device wdd;
> +};
> +
> +static int macsmc_wdt_set_timeout(struct watchdog_device *wdd, unsigned =
int timeout)
> +{
> +	struct macsmc_wdt *drv =3D watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	if (timeout)
> +		wdd->timeout =3D timeout;

[Severity: High]
When userspace stops the watchdog via ioctl(WDIOC_SETOPTIONS,
WDIOS_DISABLECARD) and then configures a new timeout via
ioctl(WDIOC_SETTIMEOUT), watchdog_set_timeout() in
drivers/watchdog/watchdog_dev.c invokes wdd->ops->set_timeout(wdd, timeout)
while WDOG_ACTIVE and WDOG_HW_RUNNING are cleared.

Because macsmc_wdt_set_timeout() unconditionally writes the non-zero timeout
to SMC_KEY(OSWD) or writes to SMC_KEY(NATi) and SMC_KEY(NATJ) without
checking watchdog_active(wdd), doesn't this immediately arm the hardware
countdown in the SMC while the watchdog core still considers the device
stopped?

In that state, watchdog_ping() sees !watchdog_hw_running(wdd) and returns 0
without feeding the hardware, and closing /dev/watchdog in watchdog_release=
()
sees !watchdog_active(wdd) and skips watchdog_stop(), leading to an
unstoppable system reset when the timer expires. Also, updating wdd->timeout
before the SMC writes complete leaves wdd->timeout out of sync if
apple_smc_write_u16() fails.

Should macsmc_wdt_set_timeout() only write to the SMC when
watchdog_active(wdd) is true (or when called from start/stop), and update
wdd->timeout only after any hardware writes succeed?

> +
> +	if (drv->has_oswd) {
> +		ret =3D apple_smc_write_u16(drv->smc, SMC_KEY(OSWD), (u16)(timeout << =
8));
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		/*
> +		 * NATJ =3D 2, makes the watchdog do force restart if NATi =3D=3D 0
> +		 * NATJ =3D 0, makes the watchdog do nothing if NATi =3D=3D 0
> +		 */
> +		if (timeout =3D=3D 0) {
> +			ret =3D apple_smc_write_u16(drv->smc, SMC_KEY(NATJ), 0);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		ret =3D apple_smc_write_u16(drv->smc, SMC_KEY(NATi), (u16)(timeout << =
8));
> +		if (ret < 0)
> +			return ret;
> +
> +		if (timeout !=3D 0) {
> +			ret =3D apple_smc_write_u16(drv->smc, SMC_KEY(NATJ), 2);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}

[Severity: High]
On Apple SMC hardware, NATi and OSWD are 2-byte keys (ui16), whereas NATJ is
a 1-byte key (ui8). In macsmc_wdt_set_timeout(), calling
apple_smc_write_u16(drv->smc, SMC_KEY(NATJ), ...) passes a length of 2 bytes
to the SMC backend in drivers/platform/x86/macsmc-acpi.c:

drivers/platform/x86/macsmc-acpi.c:apple_smc_acpi_port_write() {
	...
	if (apple_smc_acpi_port_write_byte(smc, len)) {
		dev_dbg(smc->dev, "port/write: write len failed, key: 0x%X, len: 0x%lX\n",
				key, len);
		return -EIO;
	}
	...
}

Won't writing 2 bytes to the 1-byte NATJ key cause apple_smc_acpi_port_writ=
e()
and apple_smc_acpi_mmio_write() to fail with -EIO when starting or stopping
the watchdog on machines without OSWD? (Additionally, even if NATJ were 16-=
bit,
passing unshifted 2 on little-endian x86 sends 0x0200 in big-endian.) Should
the NATJ writes use apple_smc_write_u8() instead of apple_smc_write_u16()?

[ ... ]

> +static const struct watchdog_info macsmc_wdt_info =3D {
> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity =3D "Macsmc Watchdog timer",
> +};
> +
> +static int macsmc_wdt_probe(struct platform_device *pdev)
> +{
> +	struct macsmc_wdt *drv;
> +
> +	drv =3D devm_kzalloc(&pdev->dev, sizeof(struct macsmc_wdt), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->smc =3D dev_get_drvdata(pdev->dev.parent);
> +	if (apple_smc_key_exists(drv->smc, SMC_KEY(OSWD)))
> +		drv->has_oswd =3D true;
> +	else
> +		drv->has_oswd =3D false;
> +
> +	drv->wdd.ops =3D &macsmc_wdt_ops;
> +	drv->wdd.info =3D &macsmc_wdt_info;
> +	drv->wdd.min_timeout =3D 1;
> +	drv->wdd.max_timeout =3D 255;
> +	watchdog_init_timeout(&drv->wdd, timeout, &pdev->dev);

[Severity: Medium]
In macsmc_wdt_probe(), drv is allocated with devm_kzalloc(), so
drv->wdd.timeout starts at 0 before calling watchdog_init_timeout(&drv->wdd,
timeout, &pdev->dev).

If a user passes timeout=3D0 (to request the default timeout) or an
out-of-range value (such as a negative value or > 255) to the module
parameter, watchdog_init_timeout() in drivers/watchdog/watchdog_core.c will
leave drv->wdd.timeout at 0. When /dev/watchdog is then opened,
macsmc_wdt_start() calls macsmc_wdt_set_timeout(wdd, 0), which runs the stop
sequence and leaves the hardware timer disabled while the kernel marks it
active.

Should drv->wdd.timeout be initialized to WATCHDOG_TIMEOUT before calling
watchdog_init_timeout(), and should the timeout module parameter be unsigned
int (uint)?

> +	watchdog_set_nowayout(&drv->wdd, nowayout);
> +	watchdog_set_drvdata(&drv->wdd, drv);
> +
> +	return devm_watchdog_register_device(&pdev->dev, &drv->wdd);
> +}
> +
> +static struct platform_driver macsmc_wdt_driver =3D {
> +	.probe =3D macsmc_wdt_probe,
> +	.driver =3D {
> +		.name =3D "macsmc-wdt"
> +	},
> +};

[Severity: High]
There are a few lifecycle details in macsmc_wdt_info, macsmc_wdt_probe(), a=
nd
macsmc_wdt_driver that affect how the watchdog behaves on daemon crash,
reboot, unbind, and suspend:

1. macsmc_wdt_info.options omits WDIOF_MAGICCLOSE. In watchdog_release() in
drivers/watchdog/watchdog_dev.c, if WDIOF_MAGICCLOSE is not set and nowayout
is disabled, closing /dev/watchdog without writing the magic 'V' character
still stops the watchdog. If a userspace watchdog daemon crashes, won't the
kernel disarm the SMC watchdog instead of letting it reset the machine?

2. Because the Apple SMC is an independent always-on microcontroller, won't
an active watchdog keep counting down and forcibly reset the machine during
system reboot/shutdown, driver unbind, or system suspend unless
watchdog_stop_on_reboot(&drv->wdd), watchdog_stop_on_unregister(&drv->wdd),
and PM suspend/resume callbacks are provided?

3. Should macsmc_wdt_probe() also set drv->wdd.parent =3D &pdev->dev before
calling devm_watchdog_register_device()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D3
