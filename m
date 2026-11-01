Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496948;
	b=ru+Ek74qIE/Z0XYJTqU/tD1Ypw9oppCWKm+6tRhTRO6gnK8gQi0MF0LQsPIkKPepCpqH
	 TaoSU2jn8YxYjsN21qYo2XRK1mKLFEl2RzDIhl8pyQn7riHfz37b3AlmGPUVyAjyM34Mg
	 rY9oa46ezQg0iJ+0ZuDrGHKBoqMTgrZbiIftaiSlHwJizoSCwdImrdaZfVbOj9nhwY+/U
	 7+f7eYaHe2gAhLuam1Oxu3gtRrnoEps1qS0kG0tvvL9IZGXX4BMh6pt5LE8cAo7p9hzKL
	 yjJ2DAXH4KtTQpZ8+BGtWrHhEf6jnHGi9OuXS9cOa6IrAp1epchZIrx6kqzUp6T5xuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496948;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3/UA5eq8UhqC01ANv2DkHHzT6Uf2Fa1k+OjUJFR7HHI=;
	b=3X1p/EfC5RUiAGCzRkr6JW80pVR0MrKxvtGrp4gYEE937VS3hfHZo/BXBx4RrlBwA+PO
	 IlvUiyb1gYb+fIERdxbAQunVDc7M4zkFgcSPKpZ6pD7zSMUy3KkFGZVhuMjvYeb1C+3uX
	 YKByqJftEYpQ5Z7Eu2gUaxVPYNluMx1p5UGJ5o032DzwfMeJ9wZjjDgaUXFkdKZoSDIK/
	 ZzjJv+AuJo3nReZHGXnLfBrg8qBblIHnsjIrZpeqhuSBJhU81k1GODj3fBlxWXxYfQuW8
	 lFib7kj/IOtGD9KjBwgC4mpb0MVOAoZblraUwUX7YGb4SxAplt4WBdAzYVYCUjuldhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C1/CxCNi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCD606A31A;
	Sun,  1 Nov 2026 01:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1/CxCNi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326421F000C1;
	Sun,  1 Nov 2026 01:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793496947;
	bh=3/UA5eq8UhqC01ANv2DkHHzT6Uf2Fa1k+OjUJFR7HHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C1/CxCNih+rJ7aU19oSj6rxAmzSvKPnaJ3q/aff8tY5XZFESTJNUdJCslzNX8V7Jd
	 tOTNCQTVvW5fagUfH/ktAhD1ZvyEDmwSYUEakYfiGWAYUxEjt+hTFaaskzS0rHLsdH
	 2HuRSXGT4zgioWnQzl+8y1zNXNH4ULcQzxKkf51ETcBzt0KsyS2vM6uKCev0swMKta
	 C06v0N0InMdR0xQ/AT9wHwn9NyRGaG5ls0fEr8ie2jRYZliZvVbH6RtL+W83MgmhEa
	 CBMUjVXtmZRlqUIOYpFDIiyMHH5GXfHuQijmgjVuPAmHoSzI475RcryxKe+N/Mz9xM
	 EPVT2f0JlIDVw==
Date: Sun, 1 Nov 2026 01:35:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau
 <j@jannau.net>, Neal Gompa <neal@gompa.dev>, Guenter Roeck
 <linux@roeck-us.net>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Griffin
 Kroah-Hartman <griffin@kroah.com>, Hans de Goede <hansg@kernel.org>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Sebastian Reichel
 <sre@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim
 Van Sebroeck <wim@linux-watchdog.org>, Jarkko Sakkinen <jarkko@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, mfd@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 05/14] iio/accel: add driver for apple SMS
Message-ID: <20261101013540.3af16ea0@jic23-hlaptop>
In-Reply-To: <20261029085504.3547-6-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
	<20261029085504.3547-6-atharvatiwarilinuxdev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 04:52:02 -0400
Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:

> Add a driver for the Sudden Motion Sensor accelerometer,
> exposed through IIO. It reports the three axes and also
> drop, orientation and shock events.
> 
> This replaces the motion sensor support in applesmc.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
A few specific comments inline.

> diff --git a/drivers/iio/accel/macsmc-accel.c b/drivers/iio/accel/macsmc-accel.c
> new file mode 100644
> index 000000000..0abf81e7b
> --- /dev/null
> +++ b/drivers/iio/accel/macsmc-accel.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SMC sudden motion sensor (SMS) driver
> + *
> + * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> + *
> + * Based on drivers/hwmon/applesmc.c:
> + * Copyright (C) 2007 Nicolas Boichat <nicolas@boichat.ch>
> + * Copyright (C) 2010 Henrik Rydberg <rydberg@euromail.se>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mfd/macsmc.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +
> +struct macsmc_accel {
> +	struct apple_smc *smc;
> +	struct iio_dev *indio_dev;
> +	struct notifier_block nb;
> +};
> +
> +enum {
> +	SMS_DROP = 0,

Novel ABI, which means unused ABI given no tools will have
a clue.  Look at other drivers and the comments below for how
to do this.

> +	SMS_ORIENTATION,
> +	SMS_SHOCK,
> +};
> +
> +static int macsmc_accel_read(struct macsmc_accel *drv, smc_key key, s16 *p)
> +{
> +	int ret;
> +
> +	ret = apple_smc_read_s16(drv->smc, key, p);
> +	if (ret < 0)
> +		return ret;
> +
> +	*p = (s16)be16_to_cpu(*p);
> +	return 0;
> +}
> +
> +static int macsmc_accel_dev_init(struct macsmc_accel *drv)
> +{
> +	int ret, total;
> +	u16 buf;
> +
> +	for (total = 0; total < 100; total++) {
> +		ret = apple_smc_read_u16(drv->smc, SMC_KEY(MOCN), &buf);
> +		if (!ret && buf)
> +			return 0;
> +
> +		buf = 0xE0;

Some define in this file to give that magic value some meaning (if we
have any info) If not, add comment to say this was from the older
driver (and any info that had on where the magic value came from).

> +		apple_smc_write_u16(drv->smc, SMC_KEY(MOCN), buf);
> +		msleep(50);
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int macsmc_accel_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +		int *val, int *val2, long mask)
> +{
> +	struct macsmc_accel *drv = iio_priv(indio_dev);
> +	int ret;
> +	s16 buf;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		ret = macsmc_accel_read(drv, SMC_KEY(MO_X), &buf);

I'd just have the switch set a local variable for SMC_KEY(whatever)
and then unify the actual read after the switch statement.

> +		if (ret < 0)
> +			return ret;
> +
> +		*val = buf;
> +		return IIO_VAL_INT;
> +	case IIO_MOD_Y:
> +		ret = macsmc_accel_read(drv, SMC_KEY(MO_Y), &buf);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = buf;
> +		return IIO_VAL_INT;
> +	case IIO_MOD_Z:
> +		ret = macsmc_accel_read(drv, SMC_KEY(MO_Z), &buf);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = buf;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int macsmc_accel_event(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	struct macsmc_accel *drv = container_of(nb, struct macsmc_accel, nb);
> +	u64 code;
> +
> +	/* check if event is for us */
> +	if (event != 0x60 && event != 0x69 && event != 0x6F)

As in previous driver, these should be defines in some header.

> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case 0x60:
> +		code = IIO_UNMOD_EVENT_CODE(IIO_ACCEL, SMS_DROP,

These need to be more informative to be useful to userspace.
See below for discussion of the channels.

> +					    IIO_EV_TYPE_CHANGE,
> +					    IIO_EV_DIR_NONE);
> +		break;
> +	case 0x69:
> +		code = IIO_UNMOD_EVENT_CODE(IIO_ACCEL, SMS_ORIENTATION,
> +					    IIO_EV_TYPE_CHANGE,
> +					    IIO_EV_DIR_NONE);
> +		break;
> +	case 0x6F:
> +		code = IIO_UNMOD_EVENT_CODE(IIO_ACCEL, SMS_SHOCK,
> +					    IIO_EV_TYPE_CHANGE,
> +					    IIO_EV_DIR_NONE);
> +		break;
> +	}
> +
> +	iio_push_event(drv->indio_dev, code, iio_get_time_ns(drv->indio_dev));
> +	return NOTIFY_OK;
> +}

> +
> +static const struct iio_event_spec macsmc_accel_event_spec = {
> +	.type = IIO_EV_TYPE_CHANGE,
> +	.dir = IIO_EV_DIR_NONE,
> +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +};
> +
> +static const struct iio_chan_spec macsmc_accel_channels[] = {
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Y,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Z,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.channel = SMS_DROP,

Drop sounds like a typically falling threshold on all axis
event?  Lots of drivers support these via the slightly unusual
looking X&Y&Z modifier.

> +		.event_spec = &macsmc_accel_event_spec,
> +		.num_event_specs = 1,
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.channel = SMS_ORIENTATION,

This one needs some more info.  What is it about the acceleration
values that leads to this event?  Do we have any info on that?

> +		.event_spec = &macsmc_accel_event_spec,
> +		.num_event_specs = 1,
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.channel = SMS_SHOCK,

That's normally an over threshold on X|Y|Z. See how other
drivers do this.

> +		.event_spec = &macsmc_accel_event_spec,
> +		.num_event_specs = 1,
> +	},
> +};


