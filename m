Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265352;
	b=kXENxGMUcvKS5l+UyCDvMSovHbbAKWvSKPy0w8i2xlydutKK/NeSYSDrFzUaRyVv2GzF
	 1sk7H5/cSX3xBlKbkrGgqc/21afr3zth3jwlvLgSt+G9FHub38u68tx7+N34Yp6gdep40
	 /aXlGQ6k3EjGE50CIJxIVSA90QJIn0uZuLuMYCEy2Zh6dQFxNMB/LzVi5FO2fhGu+Vifg
	 9nUkNOD3mFl7oRDdmkt5isTZHWqZc/h0NpXnbCUi02yfIIN7b0FpZqMgDfB8Qi1sfaLGD
	 mFh6oXp2nRqLGmYASGMAJta6Ou0wZo20HjUiCtmZ1E6QYlAEFqDBVVAaq/ya9fm1Ecg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YvxwrRsi9DJ63HuWkLKPGzYGzmHIDab3JdLRqCRRUxI=;
	b=xJVKXHVct+hjHWkv2mDiphabXSodqcPZX2NNknSnrYPLOgG3F0d6SvtL943FxCxtlRP8
	 ItNoX5Yawb/wKgZnCWrsGyFT80G+GWHamxf0VbKv3EWbCdfElMk+ER6XmlTS/03yJqtmj
	 e+I8Qz0bFfhWBrUyTWlWU/0l/Jfa+h5ltQr610Onc+S5Sf6t3f3p7KCXBgsW65Lc0Ru/l
	 IILnM1O1/3O4RG/HXvdvqVc8eeJ6QNZCNRlcuFV+ZQJhL+iU0B8oVhCBe5mgOrKMrMgID
	 D40idD13vpvR9mAolgIq7evjzo7VHgn7cKJSFaRUqhIYM5ndycD9cONOZhFxSh/3aDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hi5SHs/Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FD606A31A;
	Thu, 29 Oct 2026 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi5SHs/Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC3A1F01825;
	Thu, 29 Oct 2026 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265351;
	bh=YvxwrRsi9DJ63HuWkLKPGzYGzmHIDab3JdLRqCRRUxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hi5SHs/QhiZ5zOLYZ1BUTOivYLQ+HichWGyXeOxVDvu+pS2E61RaoCzxIYZs70ZPw
	 f2LcV5Pvng1GucTr1ppsGXeNKvZrvrYLf4gOK7BQ1JcZTOO5dgb6+/Xq3wUgQnpjZh
	 IuOkQiz+qspqnloDbakygcZ6lnOl2KuE6PiKrlcBaSJiJoix8YWEQidIydEwFnyWKL
	 4G2ppHSmUrQvm+Y0XOzZMPDCYcN9FJ1Ej3AfSvgwmM0jDGBG6IlJMRYwRyvmkQ0JK/
	 7IWEBuxO1f1Zid3/aceoHUleTMBqO4q+uUPJSux+nR4fi8cvs8mJDJ2VQRK0OrcOYl
	 Rfut5junY7jKQ==
Message-ID: <sashiko-outbox-189013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/14] rtc: add support for x86 macs in macsmc-rtc
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
In-Reply-To: <20261029085504.3547-8-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-8-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:15:49 +0000
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
- [High] rtc: macsmc: uninitialized u64 clkl and wrong mask in macsmc_rtc_p=
robe()
- [High] rtc: macsmc: positive return on ACPI write failure in macsmc_rtc_s=
et_time()
- [Medium] rtc: macsmc: shift underflow when clkr is zero in macsmc_rtc_pro=
be()
- [Low] rtc: macsmc: missing kernel-parameters.txt entry for force_clkm
--

commit a291b39ce81e3a636ffdc1d72c951eb114ad04ea
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

rtc: add support for x86 macs in macsmc-rtc

This commit adds support for Intel T2 Macs to the macsmc-rtc driver. On the=
se
machines, the driver reads the clock rate and RTC offset from the SMC rather
than NVMEM, and optionally reads the clock via the asynchronous CLKL SMC ke=
y.

> diff --git a/drivers/rtc/rtc-macsmc.c b/drivers/rtc/rtc-macsmc.c
> index 8fe8830669569..37395c64cbb5e 100644
> --- a/drivers/rtc/rtc-macsmc.c
> +++ b/drivers/rtc/rtc-macsmc.c
[ ... ]
> @@ -20,13 +23,54 @@
>  /* 32768 Hz clock */
>  #define RTC_SEC_SHIFT 15
> =20
> +static bool force_clkm;
> +module_param(force_clkm, bool, 0644);
> +MODULE_PARM_DESC(force_clkm, "Force CLKM Key, instead of trying to use C=
LKL");

[Severity: Low]
Should the new rtc_macsmc.force_clkm module parameter also be documented in
Documentation/admin-guide/kernel-parameters.txt?

[ ... ]
> @@ -66,14 +121,20 @@ static int macsmc_rtc_set_time(struct device *dev, s=
truct rtc_time *tm)
>  	u64 ctr =3D 0, off =3D 0;
>  	int ret;
> =20
> -	ret =3D apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
> +	if (rtc->async_rtc && !force_clkm)
> +		ret =3D macsmc_rtc_read_clkl(rtc, &ctr);
> +	else
> +		ret =3D apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
>  	if (ret < 0)
>  		return ret;
>  	if (ret !=3D RTC_BYTES)
>  		return -EIO;
> =20
>  	/* This sets the offset such that the set second begins now */
> -	off =3D (rtc_tm_to_time64(tm) << RTC_SEC_SHIFT) - ctr;
> +	off =3D (rtc_tm_to_time64(tm) << rtc->shift) - ctr;
> +	if (rtc->smc->is_acpi)
> +		return (apple_smc_write(rtc->smc, SMC_KEY(CLKO), &off, RTC_BYTES) !=3D=
 RTC_BYTES);

[Severity: High]
What happens when apple_smc_write() fails in macsmc_rtc_set_time()?

Because struct rtc_class_ops.set_time is expected to return 0 on success and
a negative error code on failure, returning the boolean comparison result
evaluates to 1 when apple_smc_write() returns a negative errno or a short
write.

In the rtc_dev_ioctl() -> rtc_set_time() -> macsmc_rtc_set_time() call chai=
n:

drivers/rtc/interface.c:rtc_set_time() {
    ...
	else if (rtc->ops->set_time)
		err =3D rtc->ops->set_time(rtc->dev.parent, tm);
    ...
	return err;
}

a return value of 1 is either overwritten by 0 if update IRQs are enabled or
returned to userspace from the RTC_SET_TIME ioctl as a non-negative value,
causing a failed hardware clock update to be reported as success. Should th=
is
propagate negative error codes from apple_smc_write() and return -EIO on a
size mismatch?

[ ... ]
> @@ -102,18 +165,40 @@ static int macsmc_rtc_probe(struct platform_device =
*pdev)
[ ... ]
> +	if (rtc->smc->is_acpi) {
> +		ret =3D apple_smc_read_u32(rtc->smc, SMC_KEY(CLKR), &clkr);
> +		if (ret < 0 || clkr =3D=3D 0xFFFFFFFF)
> +			rtc->shift =3D RTC_SEC_SHIFT;
> +		else
> +			rtc->shift =3D ffs(clkr) - 1;

[Severity: Medium]
Can clkr be 0 if the SMC returns a zero value for the CLKR key in
macsmc_rtc_probe()?

If apple_smc_read_u32() succeeds with clkr =3D=3D 0, ffs(0) returns 0 and
ffs(clkr) - 1 underflows the uint8_t field rtc->shift to 255. That causes
subsequent shifts by rtc->shift in macsmc_rtc_probe(), macsmc_rtc_get_time(=
),
and macsmc_rtc_set_time() to shift 64-bit integers by 255 or 271 bits:

	rtc->rtc_dev->range_min =3D S64_MIN >> (rtc->shift + (64 - RTC_BITS));
	rtc->rtc_dev->range_max =3D S64_MAX >> (rtc->shift + (64 - RTC_BITS));

Also, if apple_smc_read_u32() fails after partially modifying clkr, the
dev_info() call below only checks clkr !=3D 0xFFFFFFFF and will log the
corrupted clkr value instead of 32768 even though rtc->shift fell back to
RTC_SEC_SHIFT. Would it make sense to guard against !clkr as well?

> +
> +		if (apple_smc_key_exists(rtc->smc, SMC_KEY(CLKL))) {
> +			u64 clkl;
> +
> +			ret =3D apple_smc_read(rtc->smc, SMC_KEY(CLKL), &clkl, RTC_BYTES);
> +			if (ret =3D=3D RTC_BYTES && clkl !=3D 0xFFFFFFFFFFFFFFFFULL)
> +				rtc->async_rtc =3D true;
> +		}

[Severity: High]
Does this read uninitialized stack memory and check against the wrong senti=
nel
mask in macsmc_rtc_probe()?

Here clkl is an uninitialized 8-byte u64 on the stack, but apple_smc_read()
only writes RTC_BYTES (6 bytes) into &clkl, leaving the upper 2 bytes
uninitialized when evaluating clkl !=3D 0xFFFFFFFFFFFFFFFFULL.

In addition, because CLKL is a 48-bit (6-byte) value, its all-ones invalid
sentinel is 0xffffffffffffULL, as checked in macsmc_rtc_read_clkl():

static int macsmc_rtc_read_clkl(struct macsmc_rtc *rtc, u64 *ctr)
{
	u64 request =3D 0xffffffffffffULL;
	u64 response =3D 0;
	...
				if (response !=3D 0xffffffffffffULL) {
					*ctr =3D response;
					return RTC_BYTES;
				}

Even if clkl is zero-initialized to 0, reading 6 bytes of 0xff into it
produces 0x0000ffffffffffffULL, which will never equal 0xFFFFFFFFFFFFFFFFULL
and will erroneously set rtc->async_rtc =3D true. Should clkl be initialize=
d to
0 and compared against 0xffffffffffffULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D7
