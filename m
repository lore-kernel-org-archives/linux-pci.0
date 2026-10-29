Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265476;
	b=pPv63aNL+Cn03/Q4MIM3RPWtj0bEymKymEexYvu8isRn75+mcDFTg1vtnhqoqDaq06eh
	 HVpcEc282dKxUC7D1deaKs1LelV0Z4BKcWxDd6jWiYtr9hEvXk7MqbmyJdRZm/HqreoEU
	 NaaDYZaVY4r0XT2VYCPvys1MZOzVMheAnUYRgQ2jieviQSRv+tzEwuDkbpmaYYM7zu5LC
	 p+Bm1e+95DuPZmhh4UKfUdeK+LCBA0nwB3va4W4KChfD15zIf3aN4RI2bVYMmg7UyInta
	 2UsT2HGZWxrGesiwwov8IsqsTOuh1lPII+/k736p1ZlMHx4KZeBOQV2/gQU1MSqYgPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265476;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yqLFEPCmmvsKMVJ2ItVu5p99SawZ9mACHHkE40wGi2Q=;
	b=dSzCc4+ME8t72YR0VhCDf2Rsgk0ERt5Zmn0ArVF5u2kFNjwXg303/qxgyusyZtBJpWxK
	 YaRBIXOB1oZt2twCXNVdsmEhU9D81E2Lv1k3YMA6UKYZXFbYoYasvbA9nwtHf+yXzOISt
	 puvyZzrn99RWO71eVyV4NLCNvuGO1aWeMHBbBzVkrm7s9lb07AtqleYhNuCqw7YDaSNkJ
	 dr73gAKE3FDi9cJrl1aS+1rPcGrXk7yvZOdjDE4NOMH+GoyWscc/rLTqoTFoZCW+auKF9
	 jT/dRVv7YEM/MbJaWjvjF8YLrWe/oCeRfiw7L1RSaJSgLBnrScAao4hKeA0PPrs4M+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nGPGkK/g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD0606A31E;
	Thu, 29 Oct 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGPGkK/g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A760A1F031E2;
	Thu, 29 Oct 2026 09:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265476;
	bh=yqLFEPCmmvsKMVJ2ItVu5p99SawZ9mACHHkE40wGi2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nGPGkK/gAuvjlyGP53jKT/Po+1EKV3LrsoGFLEV5M7xeKa1r+0+i2bZpcZetlIUT8
	 iZxRtu/kQzGmjKoE/8wx9jEhnVFUaXBepvoMHbsp/LpxUcEh2K+grzwLip2z1kRhCV
	 LeE4H8gyfRuFZrgETtpocRB0rS4jfYRB2ekfY3hAzKbHcyoJ1U3i696Uj82Dlj2Ow7
	 nnOFT1+BCF39EWuFn7JKTtXnYpK3AN5rZS/gqkt88g1m8jO5YHmXMYC8wEBi06RFFS
	 9NbOer3Wfp7TDlKKOI9IuqON961HLGADoDANDap/3XNRrECVzDPqx2HF8+/upiQxdL
	 X920inhUMwCLQ==
Message-ID: <sashiko-outbox-189019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/14] iio/light: add new driver for macsmc
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
In-Reply-To: <20261029085504.3547-5-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-5-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:17:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] iio: light: unvalidated drv->size in macsmc_light_read_raw() overf=
lows buffer
- [Medium] iio: light: double byte-swap and wrong shift in macsmc_light_rea=
d_raw()
- [Medium] iio: light: missing event config callbacks in macsmc_light_info
- [Medium] iio: light: macsmc_light_probe() unconditionally registers RIGHT=
_LIGHT channel
- [Medium] iio: light: macsmc_light_channels omits indexed flag and uses ex=
tend_name
--

commit 03cf99563b174ff5a5c22b832e325621b25e1bec
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

iio/light: add new driver for macsmc

This commit adds an IIO ambient light sensor driver for Apple SMC devices
with left and right illuminance channels and change event support, and
registers the corresponding MFD cell in macsmc-core.

> diff --git a/drivers/iio/light/macsmc-light.c b/drivers/iio/light/macsmc-=
light.c
> new file mode 100644
> index 0000000000000..9d4532b34ef05
> --- /dev/null
> +++ b/drivers/iio/light/macsmc-light.c
> @@ -0,0 +1,189 @@

[ ... ]

> +static int macsmc_light_read_raw(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan,
> +		int *val, int *val2, long mask)
> +
> +{
> +	struct macsmc_light *drv =3D iio_priv(indio_dev);
> +	u8 buffer[10];
> +	int ret;
> +
> +	if (mask !=3D IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	switch (chan->channel) {
> +	case LEFT_LIGHT:
> +		ret =3D apple_smc_read(drv->smc, SMC_KEY(ALV0), buffer, drv->size);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (drv->size =3D=3D 10)
> +			*val =3D be16_to_cpu(get_unaligned_be16(buffer + 6)) >> 10;

[Severity: Medium]
Does this double-swap the endianness and shift away the sensor reading when
drv->size =3D=3D 10?

In include/linux/unaligned.h, get_unaligned_be16() already converts the
big-endian value to CPU byte order:

static inline u16 get_unaligned_be16(const void *p)
{
	return be16_to_cpu(__get_unaligned_t(__be16, p));
}

Passing its return value to be16_to_cpu() swaps the bytes a second time on
little-endian systems (and triggers a Sparse endianness warning).

In addition, in drivers/hwmon/applesmc.c, applesmc_light_show() handled the
10-byte ALV0 payload as a 10-bit big-endian value at buffer + 6 and shifted
it right by 2 only to fit into an 8-bit variable:

	/* newer macbooks report a single 10-bit bigendian value */
	if (data_length =3D=3D 10) {
		left =3D be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
		goto out;
	}

Shifting a 10-bit value right by 10 bits discards the entire reading. Should
this just be get_unaligned_be16(buffer + 6) (or shifted right by 2 if 8-bit
scaling is intended)?

> +		else
> +			*val =3D buffer[2];
> +
> +		break;
> +	case RIGHT_LIGHT:
> +		if (drv->size =3D=3D 10) {
> +			*val =3D 0;
> +			break;
> +		}
> +		ret =3D apple_smc_read(drv->smc, SMC_KEY(ALV1), buffer, drv->size);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D buffer[2];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}

[ ... ]

> +static const struct iio_event_spec macsmc_light_events[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_CHANGE,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec macsmc_light_channels[] =3D {
> +	{
> +		.type =3D IIO_LIGHT,
> +		.channel =3D LEFT_LIGHT,
> +		.extend_name =3D "left",
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec =3D macsmc_light_events,
> +		.num_event_specs =3D ARRAY_SIZE(macsmc_light_events),
> +	},
> +	{
> +		.type =3D IIO_LIGHT,
> +		.channel =3D RIGHT_LIGHT,
> +		.extend_name =3D "right",
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec =3D macsmc_light_events,
> +		.num_event_specs =3D ARRAY_SIZE(macsmc_light_events),
> +	},
> +};

[Severity: Medium]
Should macsmc_light_channels set .indexed =3D 1 (and use .read_label instea=
d of
the deprecated .extend_name field)?

In drivers/iio/industrialio-core.c, __iio_chan_prefix_emit() only includes
chan->channel in the sysfs attribute name when chan->indexed is set:

		if (chan->indexed)
			seq_buf_printf(&s, "%d", chan->channel);

Without .indexed =3D 1, the channel numbers are omitted from the sysfs
attribute names, whereas macsmc_light_event() pushes events using
IIO_UNMOD_EVENT_CODE(IIO_LIGHT, LEFT_LIGHT, ...) and
IIO_UNMOD_EVENT_CODE(IIO_LIGHT, RIGHT_LIGHT, ...) with channel indices 0
and 1.

> +
> +static const struct iio_info macsmc_light_info =3D {
> +	.read_raw =3D macsmc_light_read_raw,
> +};

[Severity: Medium]
Does macsmc_light_info need .read_event_config and .write_event_config
callbacks?

Because macsmc_light_events sets .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
the IIO core creates event enable sysfs attributes wired to
iio_ev_state_show() and iio_ev_state_store() in
drivers/iio/industrialio-event.c:

	if (!indio_dev->info->write_event_config)
		return -EINVAL;

and:

	if (!indio_dev->info->read_event_config)
		return -EINVAL;

With both callbacks left NULL in macsmc_light_info, reading or writing the
event enable attributes in sysfs will always fail with -EINVAL, and
macsmc_light_event() pushes events unconditionally regardless of whether
events are enabled.

> +
> +static int macsmc_light_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct macsmc_light *drv;
> +	struct apple_smc_key_info info;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*drv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	drv =3D iio_priv(indio_dev);
> +	drv->smc =3D dev_get_drvdata(pdev->dev.parent);
> +
> +	ret =3D apple_smc_get_key_info(drv->smc, SMC_KEY(ALV0), &info);
> +	if (ret < 0)
> +		return -ENODEV;
> +
> +	drv->size =3D info.size;

[Severity: High]
Can an unexpected info.size from the SMC overflow buffer[] or leak
uninitialized stack memory in macsmc_light_read_raw()?

In macsmc_light_read_raw(), buffer is a 10-byte uninitialized stack array:

	u8 buffer[10];
	...
	ret =3D apple_smc_read(drv->smc, SMC_KEY(ALV0), buffer, drv->size);

In drivers/hwmon/applesmc.c, applesmc_light_show() checked that the key
length did not exceed 10 before reading into buffer. Here drv->size is taken
directly from info.size without bounds checking. If info.size > 10,
apple_smc_read() will write past the end of buffer[] on the stack; if
info.size < 3, reading buffer[2] will return uninitialized stack bytes to
userspace (and ALV1 is also read using drv->size without checking ALV1's
own key size).

> +	drv->indio_dev =3D indio_dev;
> +	drv->nb.notifier_call =3D macsmc_light_event;
> +	ret =3D blocking_notifier_chain_register(drv->smc->event_handlers, &drv=
->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, macsmc_light_unregister_no=
tifier, drv);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D "macsmc-light";
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &macsmc_light_info;
> +	indio_dev->channels =3D macsmc_light_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(macsmc_light_channels);

[Severity: Medium]
Should RIGHT_LIGHT only be registered when a right sensor is actually
present?

macsmc_light_probe() unconditionally registers both LEFT_LIGHT and
RIGHT_LIGHT channels. On systems where drv->size =3D=3D 10, there is only a
single sensor in ALV0, so the right channel always returns a hardcoded 0 in
macsmc_light_read_raw() and never receives events in macsmc_light_event().
On systems where drv->size !=3D 10 but SMC_KEY(ALV1) is absent, reading
RIGHT_LIGHT in macsmc_light_read_raw() will fail when querying ALV1, while
macsmc_light_event() will still push change events for RIGHT_LIGHT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D4
