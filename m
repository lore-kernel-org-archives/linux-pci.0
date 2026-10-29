Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265385;
	b=yKh+q9Edv/HutNnY19ygxqpXktlFyUCSE+EkIFgjz3S/brCk7BLgjXWDApK7tQwkxzQ1
	 UmlOmjJb/elUAsc2Zz8prwyR5jATvTTMb6HLNp6PQr1JkMP5DCxrXehq/f2gb7dLKYTw0
	 j+vAo2bXRjtACzLbc9L7j8GhyWCNgTiNdesIX6hV4Ih6TkIFUmimw0UOZNyRc4dtLaxt+
	 eicC15l7Z5eOqr6FikIya21ftxNASML8OGbO0TotEWbnIhaPSnidT6IPWn7hOsIzhR4o+
	 ZsF+ppBp4IlxCiZP6MByZy5Z5XnCAtfEDD4QSZz8ALxdS5A5YinjUroW10/EVzwd1Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dGHNi/NZnZGReejnQ5XVpgXrV8Ai0qujer2PftKvzu4=;
	b=X/lZMS4MQzazRyiPUmEIWih63Kf+CkO29KozVMS6kLdq+u/mZpjnf3u7jbNeWKfF0LmW
	 HyCHSNZdi/V/xt1Zrb9+BJvWwtAr90uCddRgyvJmQ6T5A9TMVZSodavjcvQhn5dvSapZY
	 e8WbyWgoZHRWjt4NSe3BsyT2RCtjDnuz/8stmv3dOqI6/rsInmLcOfmX0+zC9d6uFL7kO
	 BIH66J0/XyA32sITw1E3wrjZDt2wAo2RXORtFsFE7AXjO3JM3X3WSjD893KEW4b8svBzM
	 Mx2+SZINFRsq4x03rcF/A8mYRvFS+TkAa/UXXy6IPDYFtRlx5MXSp1kTK3dkdBnWUmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKUfiBzX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171EC606A31E;
	Thu, 29 Oct 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKUfiBzX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EFD1F01825;
	Thu, 29 Oct 2026 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265384;
	bh=dGHNi/NZnZGReejnQ5XVpgXrV8Ai0qujer2PftKvzu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKUfiBzXW0isL1VxjwcNLWqKKgN54t2RVWOBRihFqvh8HhGryskTaPMxb7zkkklom
	 P+HPTEl8rFtMuU1aGrZEYiLACeEZscTIUTgo+eYvNXxprKlQg/zJcwl/G+PbmU4QKf
	 d83A/vvPco4zBc3aKcSRL6jGIWEaemmEH99hhggpMO8c6d7riU6cYie3KBJAKoulVA
	 D2s41nfJg7JYISdL3HvHJa71FSf6UhWm0eStvpxCBFQPhuesGgGvZcNpXaENDgHIJm
	 v04l2luYkKnx/BOG8PURuxgZbC+XW0N9vtiUiIshErOnzS6L7azBnHJK8xsUy0KRRF
	 UsLdmdGqF1h4Q==
Message-ID: <sashiko-outbox-189014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/14] treewide: disable other rtc's in t2 macs
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
In-Reply-To: <20261029085504.3547-10-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-10-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:16:22 +0000
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
- [High] rtc: acpi_tad_probe() and cmos_do_probe() miss CONFIG_MACSMC_ACPI =
check
- [High] rtc: cmos_do_probe() leaves x86 CMOS wallclock callbacks active on=
 T2 Macs
--

commit 8f32ab6b5995f6b8ccbfee083b09d400a56632a7
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

treewide: disable other rtc's in t2 macs

This commit disables the ACPI TAD real-time clock capability and aborts
probing the CMOS RTC driver on Apple T2 Macs when CONFIG_RTC_DRV_MACSMC is
enabled, leaving macsmc-rtc as the active RTC.

> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 45459a4cafae3..a137a39e5e67f 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
[ ... ]
> @@ -845,6 +846,9 @@ static int acpi_tad_probe(struct platform_device *pde=
v)
>  		return -ENODEV;
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_RTC_DRV_MACSMC) && has_apple_t2_chip)
> +		caps &=3D ~ACPI_TAD_RT;

[Severity: High]
Could checking only IS_ENABLED(CONFIG_RTC_DRV_MACSMC) in acpi_tad_probe()
and cmos_do_probe() leave T2 Macs without any registered RTC device when
CONFIG_MACSMC_ACPI is disabled?

In drivers/rtc/Kconfig, RTC_DRV_MACSMC only depends on MFD_MACSMC_CORE:

config RTC_DRV_MACSMC
	tristate "Apple Mac System Management Controller RTC"
	depends on MFD_MACSMC_CORE

However, on x86 T2 Macs, the macsmc-rtc MFD child device is only registered
via apple_smc_acpi_probe() -> apple_smc_probe(), which requires
CONFIG_MACSMC_ACPI in drivers/platform/x86/Kconfig:

config MACSMC_ACPI
	tristate "Apple SMC (System Management Controller) ACPI Backend"
	depends on MFD_MACSMC_CORE && ACPI && !SENSORS_APPLESMC

When CONFIG_RTC_DRV_MACSMC is enabled alongside CONFIG_SENSORS_APPLESMC (or
when CONFIG_MACSMC_ACPI is otherwise disabled), macsmc-rtc is never
instantiated, yet acpi_tad_probe() and cmos_do_probe() will still disable
both the ACPI TAD RTC and the CMOS RTC.

Should both checks also verify IS_ENABLED(CONFIG_MACSMC_ACPI)?

> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index fa04ece151b8b..bdb436e24bb82 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
[ ... ]
> @@ -944,6 +945,9 @@ cmos_do_probe(struct device *dev, struct resource *po=
rts, int rtc_irq)
>  		.priv =3D &cmos_rtc,
>  	};
> =20
> +	if (IS_ENABLED(CONFIG_RTC_DRV_MACSMC) && has_apple_t2_chip)
> +		return -ENODEV;

[Severity: High]
When cmos_do_probe() returns -ENODEV here, what happens to the x86
architectural wallclock callbacks in x86_platform?

In arch/x86/kernel/x86_init.c, x86_platform defaults to the legacy CMOS
routines:

	.get_wallclock			=3D mach_get_cmos_time,
	.set_wallclock			=3D mach_set_cmos_time,

These are invoked by read_persistent_clock64() and
update_persistent_clock64() in arch/x86/kernel/rtc.c, which call
mc146818_get_time() and mc146818_set_time() directly on CMOS I/O ports
0x70/0x71 regardless of whether the rtc-cmos driver probed.

During NTP synchronization in kernel/time/ntp.c, sync_hw_clock() tries the
persistent clock before falling back to the RTC class device:

	/* Try the legacy RTC first. */
	res =3D update_persistent_clock64(to_set);
	if (res !=3D -ENODEV)
		goto rearm;

	/* Try the RTC class */
	res =3D update_rtc(&to_set, &offset_nsec);

Because mach_set_cmos_time() -> mc146818_set_time() writes to the CMOS ports
and returns 0 (or -EINVAL, never -ENODEV), sync_hw_clock() will take the
goto rearm path and never call update_rtc() to update macsmc-rtc.

Similarly, timekeeping_init(), timekeeping_suspend(), and
timekeeping_resume() call read_persistent_clock64(), which will still read
the non-working CMOS clock via mach_get_cmos_time(). If that returns a
non-zero timestamp, persistent_clock_exists is set to true and
timekeeping_rtc_skipsuspend() causes rtc_suspend() to skip macsmc-rtc across
suspend and resume.

Should x86_platform.get_wallclock and x86_platform.set_wallclock also be
redirected to x86_init_noop / x86_wallclock_noop on T2 Macs when macsmc-rtc
is used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D9
