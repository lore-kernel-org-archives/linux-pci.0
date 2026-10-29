Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265193;
	b=hTcyqdgkHJjCcbFPQ7KLcn077gjOtvbWcsNtmc9BPkm6ev7PSRgOxqjuAR9Z8XAeU/Zh
	 IxMTxysuBwkQlvm74oGpjYoHcuPOQ3Pg8Pb5SiseZIAWGcsFkKylnXVPNWCnWiDxLcW8q
	 /9UfzvPgvGYxvXxcikRXb1ZquUOkZpDetutftF0HBgy60RpjgONQbB0LAFhcpMtjD301u
	 +NTicXtaQA6xyTm+/ud/qL15UH+MKxf2YKqcjmNK9rnrb3ABr1IvRTCQHsiM5x+MHPYcV
	 ba9EAowbnn/ItSVlczD5rQEeInKBl3s+YtNLsHOO9yqPvFtji8uHGHzduZCtu21ZVYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265193;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mSkWD197l6SdZ1PFc0zg6L/iSD0NHxPgBeNtnPjXuPQ=;
	b=Hxuu+GMfGZNo7qso6dc/2KVlU0d2+N20j6L41iSJseWkLjl26HgvvTsZqYbDE26EIfGZ
	 lehcpCUJLOrYtK7IOGalvBRyqEP7rH2lmmUHZMebQKLBspjXqLBBval0uITVlUawei2Rz
	 oGN4tvczXvzgIgI/DpeAMcsj6nfqrq5pDUYkqp+Ie+OoQh4m1ybTRY7LRYXae5Lq3sPVk
	 5RzUE2RntkwqAO7ozqYp1RxXUWJb0zQQ2m4DptBdHNAwvj14OphKgIrSlf6qDZdciT1o/
	 RpLEtGTRNalGNgipwW/ZLknhlLSMCm+RF70xTX5aw98Mgr3MbbkSKdzkzo63744YDgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H794KHoW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812D606A31F;
	Thu, 29 Oct 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H794KHoW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE4C1F01825;
	Thu, 29 Oct 2026 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265192;
	bh=mSkWD197l6SdZ1PFc0zg6L/iSD0NHxPgBeNtnPjXuPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H794KHoW2vrBAmP4DDCbKqlnsxH1oUuwC5deCeV6vA0p0aJOGwCKZdUeD0dpzDLSz
	 LMV7shcr0Rp6sXehaNuu57F+RVkKv/NOCAxGH+Hp/3KwrEtLVaKNRy0pvzSwvLuYKM
	 38umQt1xC2yUDE+ZhjHLC3su73j8I9u5RLgsXcKhhDMhTusCAu9r5Nk/HvUwDFM7xu
	 YxxeC4d6KXZOsfyvB9Bsrsxc5TAMX4We1gA5html5nROZUzoe2o73G0+AdVz59kKJg
	 eLxwS9s5FawU8oMxNrCdkb/41X19+N3MoCI0Ct5T/y/VmL9dJQRCt7WGc9wYdXzgx2
	 QNxRovfoPvzBg==
Message-ID: <sashiko-outbox-189006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/14] acpi: disable battery and adapter for x86
 apple machines
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
In-Reply-To: <20261029085504.3547-12-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-12-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:13:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] acpi: sbs: SMBus hang and probe failure in acpi_sbs_probe() on App=
le x86
- [High] acpi: missing CONFIG_MACSMC_ACPI check disables battery and AC on =
x86 Macs
--

commit a9ef8c0ab923a26344436713c10dccfd42ea84d9
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

acpi: disable battery and adapter for x86 apple machines

This commit skips the ACPI SBS, battery, and AC adapter drivers on x86 Apple
machines when CONFIG_MACSMC_POWER is enabled to avoid registering duplicate
power supply devices.

> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index f10bbf13c242f..b12f2acc0a15d 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -634,6 +634,9 @@ static int acpi_sbs_probe(struct platform_device *pde=
v)
>  	int result =3D 0;
>  	int id;
> =20
> +	if (IS_ENABLED(CONFIG_MACSMC_POWER) && x86_apple_machine)
> +		return -ENODEV;
> +
>  	device =3D ACPI_COMPANION(&pdev->dev);
>  	if (!device)
>  		return -ENODEV;
> @@ -655,14 +658,12 @@ static int acpi_sbs_probe(struct platform_device *p=
dev)
> =20
>  	result =3D 0;
> =20
> -	if (!x86_apple_machine) {
> -		result =3D acpi_manager_get_info(sbs);
> -		if (!result) {
> -			sbs->manager_present =3D 1;
> -			for (id =3D 0; id < MAX_SBS_BAT; ++id)
> -				if ((sbs->batteries_supported & (1 << id)))
> -					acpi_battery_add(sbs, id);
> -		}
> +	result =3D acpi_manager_get_info(sbs);
> +	if (!result) {
> +		sbs->manager_present =3D 1;
> +		for (id =3D 0; id < MAX_SBS_BAT; ++id)
> +			if ((sbs->batteries_supported & (1 << id)))
> +				acpi_battery_add(sbs, id);
>  	}

[Severity: High]
What happens on x86 Apple machines when CONFIG_MACSMC_POWER is disabled?

When CONFIG_MACSMC_POWER=3Dn, acpi_sbs_probe() does not return early on
x86_apple_machine, and removing the !x86_apple_machine check causes it to
call acpi_manager_get_info(sbs) -> acpi_smbus_read(..., ACPI_SBS_MANAGER, .=
..).

Commit 9faf6136ff46 ("ACPI / SBS: Disable smart battery manager on Apple")
and commit 630b3aff8a51 guarded this call because accessing ACPI_SBS_MANAGER
on Apple hardware causes the SMBus and EC controller to hang for several
minutes when unplugging the AC adapter. Doesn't removing the
!x86_apple_machine check reintroduce this controller hang whenever
CONFIG_MACSMC_POWER is disabled?

In addition, by removing the !x86_apple_machine condition around
acpi_manager_get_info(sbs), the preceding result =3D 0 assignment becomes a
dead store, and sbs->manager_present remains 0 only when
acpi_manager_get_info(sbs) returns a non-zero error:

	result =3D acpi_manager_get_info(sbs);
	if (!result) {
		sbs->manager_present =3D 1;
		...
	}

	if (!sbs->manager_present)
		acpi_battery_add(sbs, 0);

	acpi_smbus_register_callback(sbs->hc, acpi_sbs_callback, sbs);
end:
	if (result)
		acpi_sbs_remove(pdev);
	return result;

When acpi_manager_get_info(sbs) fails with a non-zero result, the
!sbs->manager_present fallback registers battery 0 and the SMBus callback,
but because result is still non-zero at the end label, acpi_sbs_remove(pdev)
immediately tears everything back down and fails the probe. Should the
!x86_apple_machine check be kept?

> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 418951639f511..9f3b9b7d9c27c 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -14,6 +14,7 @@
>  #include <linux/dmi.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include "../internal.h"
> @@ -608,6 +609,9 @@ bool acpi_quirk_skip_acpi_ac_and_battery(void)
>  	long quirks =3D 0;
>  	int i;
> =20
> +	if (IS_ENABLED(CONFIG_MACSMC_POWER) && x86_apple_machine)
> +		return true;

[Severity: High]
Should both acpi_quirk_skip_acpi_ac_and_battery() and acpi_sbs_probe() also
check IS_ENABLED(CONFIG_MACSMC_ACPI)?

In drivers/power/supply/Kconfig, MACSMC_POWER only depends on
MFD_MACSMC_CORE:

config MACSMC_POWER
	tristate "Apple SMC Battery and Power Driver"
	depends on MFD_MACSMC_CORE

However, on x86 Apple machines, the macsmc-power MFD device is only
registered when apple_smc_acpi_probe() in drivers/platform/x86/macsmc-acpi.c
probes the SMC device, which is controlled by CONFIG_MACSMC_ACPI in
drivers/platform/x86/Kconfig:

config MACSMC_ACPI
	tristate "Apple SMC (System Management Controller) ACPI Backend"
	depends on MFD_MACSMC_CORE && ACPI && !SENSORS_APPLESMC

If a kernel is built with CONFIG_MACSMC_POWER enabled and CONFIG_MACSMC_ACPI
disabled (for example, whenever CONFIG_SENSORS_APPLESMC is enabled), won't
checking only IS_ENABLED(CONFIG_MACSMC_POWER) disable the ACPI SBS, battery,
and AC adapter drivers on x86 Macs without any macsmc-acpi backend built to
instantiate macsmc-power?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D11
