Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265605;
	b=uBt/dp1CG1+LPZmClncEZNrYuh1PSoPExfy0pALgHQWmDO0jBx3bxVD3uhJjLlnN37i5
	 xkd2HuFZ6tXfj2O/jWA3spl4yQ9kmqrYe+aj+jVICy6OhGzkZ9NJSgo8GIKH2XxSifdTQ
	 aLLEgq4uecjU9Br1TDOjNPPhjXsjZCktE0hlU+0Je7hh1XdCaTfngsf6cyd7K4y4tNTbK
	 hFMst+em6UQBiDyIqH3Hza6HKcvKmaoenty/yaxRUa+6fRoB6P+/oGvVEUm+RpcAfHF6R
	 8F2a0EeCKVd+xUnqsC/Fmg+3bqttym6kq5OaPITgPRua2QU8VXQk0810924xm9rnyPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265605;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+LAY5ClvQkwH4uXdIx8yGetaPg+PebtPtq61FX/w6tU=;
	b=jMcWhzOBtKDf3TwcV6VwsobDQsI73PsC+bPYDgkPCZydERVQNZiJygPMdsk+B4zAsc8k
	 unpU17FWTpof/M/OX5PTGHlTET4h6Lmj4xhwNmcCvBRg405Hs/uo43J0egUAOam1mEcLJ
	 Dz8VabnGMhNZtD52aSuUNUozf00I9LLRZwFz04Rz3J7HRTOLUcz8tof6qPebotiUs24V/
	 9cmxCrD1EJifcmUA23A9BWOFezb5sVePYiDWhiUP5crbVg3tGJA57/xvKjVEzr6H0gTOJ
	 cZXun/Gevk01dkRDfNa6g8pegI7zZpyNDCPS1Mrpi6Uq4Yl/RCoO2vg+3dBWEtTJdKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3PFyQYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD629606A31C;
	Thu, 29 Oct 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3PFyQYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CA61F01825;
	Thu, 29 Oct 2026 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265604;
	bh=+LAY5ClvQkwH4uXdIx8yGetaPg+PebtPtq61FX/w6tU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H3PFyQYd3eBGihfxRdFeEO8SjfeBXN7j5c8dPh94oOsnu2K7VkMMNo8vcITeUjVPl
	 zwfv2l95E1cd4E6by9+8eVyxoDdwN1chtvfwn1D+NLO0OjpOsOWn1f/dV+wFhskFfN
	 ysNxbHddL3Fxc6mNYPMf+X+UDa0ww4SklVS66yx+znw+k/0xZ006tqjgZsO7dKyKCc
	 c9evBgnEGR0VaS9IQLh9xmqk/2JDmfypCdy+nVuYbJhDjKvibrdruh+s7/McWvH+NG
	 LsB7PDZ5LLaTMyajuOyfFqzsVYTAPVPNgwKfxAom1COpJMFjv2IH0V++J+OvfIZDVc
	 is8D8ASA1/0dQ==
Message-ID: <sashiko-outbox-189025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/14] iio/accel: add driver for apple SMS
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
In-Reply-To: <20261029085504.3547-6-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-6-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:20:02 +0000
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
- [High] iio: accel: macsmc-accel: unindexed event channels cause -EBUSY pr=
obe failure
- [Medium] iio: accel: macsmc-accel: missing event config callbacks in macs=
mc_accel_info
- [Low] iio: accel: macsmc-accel: missing pm_sleep_ptr() wrapper on macsmc_=
accel_pm_ops
--

commit ee4b509c282b1a026627accf04e0b08185034ca5
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

iio/accel: add driver for apple SMS

This commit adds an IIO accelerometer driver for the Apple Sudden Motion
Sensor (SMS) to report X, Y, and Z axes along with drop, orientation, and
shock events, and registers the macsmc-accel MFD cell in macsmc-core when t=
he
MOCN key is present.

> diff --git a/drivers/iio/accel/macsmc-accel.c b/drivers/iio/accel/macsmc-=
accel.c
> new file mode 100644
> index 0000000000000..0abf81e7bd334
> --- /dev/null
> +++ b/drivers/iio/accel/macsmc-accel.c

[ ... ]

> +static const struct iio_event_spec macsmc_accel_event_spec =3D {
> +	.type =3D IIO_EV_TYPE_CHANGE,
> +	.dir =3D IIO_EV_DIR_NONE,
> +	.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +};
> +
> +static const struct iio_chan_spec macsmc_accel_channels[] =3D {
> +	{
> +		.type =3D IIO_ACCEL,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_X,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type =3D IIO_ACCEL,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_Y,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type =3D IIO_ACCEL,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_Z,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type =3D IIO_ACCEL,
> +		.channel =3D SMS_DROP,
> +		.event_spec =3D &macsmc_accel_event_spec,
> +		.num_event_specs =3D 1,
> +	},
> +	{
> +		.type =3D IIO_ACCEL,
> +		.channel =3D SMS_ORIENTATION,
> +		.event_spec =3D &macsmc_accel_event_spec,
> +		.num_event_specs =3D 1,
> +	},
> +	{
> +		.type =3D IIO_ACCEL,
> +		.channel =3D SMS_SHOCK,
> +		.event_spec =3D &macsmc_accel_event_spec,
> +		.num_event_specs =3D 1,
> +	},
> +};

[Severity: High]
Will macsmc_accel_probe() always fail with -EBUSY when registering these th=
ree
event channels?

In macsmc_accel_channels[], the SMS_DROP, SMS_ORIENTATION, and SMS_SHOCK
channels set .channel and .event_spec =3D &macsmc_accel_event_spec (which s=
ets
.mask_separate =3D BIT(IIO_EV_INFO_ENABLE)), but they leave .indexed as 0.

When devm_iio_device_register() registers the event attributes:

  macsmc_accel_probe()
    -> devm_iio_device_register()
      -> __iio_device_register()
        -> iio_device_register_eventset()
          -> __iio_add_event_config_attrs()
            -> iio_device_add_event_sysfs()
              -> iio_device_add_event()
                -> __iio_add_chan_devattr()
                  -> __iio_device_attr_init()
                    -> __iio_chan_prefix_emit()

drivers/iio/industrialio-core.c:__iio_chan_prefix_emit() only includes
chan->channel in the sysfs attribute name when chan->indexed is set:

	seq_buf_printf(&s, "%s_%s", dir, type);

	if (chan->indexed)
		seq_buf_printf(&s, "%d", chan->channel);

Because chan->indexed is 0 on all three event channels, each one generates =
the
same separate sysfs attribute name "in_accel_change_en". When the second ev=
ent
channel (SMS_ORIENTATION) is processed in __iio_add_chan_devattr(), it dete=
cts
the duplicate IIO_SEPARATE attribute name in ev_int->dev_attr_list and retu=
rns
-EBUSY:

	list_for_each_entry(t, attr_list, l)
		if (strcmp(t->dev_attr.attr.name,
			   iio_attr->dev_attr.attr.name) =3D=3D 0) {
			if (shared_by =3D=3D IIO_SEPARATE)
				dev_err(dev, "tried to double register : %s\n",
					t->dev_attr.attr.name);
			ret =3D -EBUSY;
			goto error_device_attr_deinit;
		}

Should these three event channels set .indexed =3D 1 (and should
macsmc_accel_event() use IIO_EVENT_CODE() or otherwise match the channel
configuration) so that their sysfs attribute names do not collide?

> +
> +static const struct iio_info macsmc_accel_info =3D {
> +	.read_raw =3D macsmc_accel_read_raw
> +};

[Severity: Medium]
Should macsmc_accel_info also provide .read_event_config and
.write_event_config callbacks, or should BIT(IIO_EV_INFO_ENABLE) be omitted
from macsmc_accel_event_spec?

Because macsmc_accel_event_spec sets .mask_separate =3D BIT(IIO_EV_INFO_ENA=
BLE),
iio_device_add_event() creates sysfs event enable attributes backed by
iio_ev_state_show() and iio_ev_state_store() in
drivers/iio/industrialio-event.c:

	if (!indio_dev->info->read_event_config)
		return -EINVAL;

and:

	if (!indio_dev->info->write_event_config)
		return -EINVAL;

With both callbacks left NULL in macsmc_accel_info, any userspace read or
write on the exported *_change_en sysfs attributes will fail with -EINVAL.

> +
> +static int macsmc_accel_restore(struct device *dev)
> +{
> +	struct macsmc_accel *drv =3D dev_get_drvdata(dev);
> +
> +	return macsmc_accel_dev_init(drv);
> +}
> +
> +static const struct dev_pm_ops macsmc_accel_pm_ops =3D {
> +	.restore =3D macsmc_accel_restore,
> +};

[ ... ]

> +static struct platform_driver macsmc_accel_driver =3D {
> +	.probe =3D macsmc_accel_probe,
> +	.driver =3D {
> +		.name =3D "macsmc-accel",
> +		.pm =3D &macsmc_accel_pm_ops,
> +	},
> +};

[Severity: Low]
Could macsmc_accel_pm_ops wrap macsmc_accel_restore with pm_sleep_ptr(), and
macsmc_accel_driver wrap &macsmc_accel_pm_ops with pm_sleep_ptr(), so the PM
callback and ops structure are compiled out when CONFIG_PM_SLEEP is disable=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D5
