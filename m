Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496512;
	b=az48cMPB11vjrFUc5C5ZMM10A5BjpJ/9/1XP5jl6Mns716/aqi67Bj+oTo5Yv6jAeXkj
	 WRVCwT249jegdAFISXFNNmOvHQkdqMt8bhoelSLUmOnn9fEinADE26F/NscTxc2cEHQ/n
	 npDkyo8Idth3ajJmBrcWL7TgAmm1r1hdCVCR0v9KDXZap6W8pETAOrX1n10L9yN8qVZs0
	 vx+kmY7Vu+/bm9f4jNTuhAaf2xvW9rZWZQRry9lKLvX1cjXh978/5jvGxXIPJb9/wjP0j
	 X2zV1STXbBuxWP9BA8WUwCjTmodwH3kB3yEuS5lmyAGEgEN69Pa4UEfaYrYjguQLA5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496512;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9jxnaJU/GpcwWRWB/sWaXu2IklLN1zFRwShITZdyTMA=;
	b=acxSgF52fE1oPbtaNMxO1iHJS0P/3mStBgPTCIUau318Cl1Cg+515xK0dfAciVJhGQ4p
	 361oJ/haGkNLKzuO+RjOL7qj5tFv2SyBgFI7frrZpFTbiuGA0vx58poNNGaTtzedTdH7o
	 JAfN6mStnf1EQA0T6jpsbn7xWHq4lFhS+0fhC3CyQJ9rTKogzy9q5t5F6GjllCJkQgW1S
	 SMQWcFnDbBu/lFZmiJp4e+eaKdGJOExu6qjCAvJRJIfJQdz2E4s8tcW+NmNDAfEAJV8oj
	 3zVbkWgebGEe9lJ7HREokQP4gxo787gYGF8R8e3L4h3ioztk2JVFFcC5vlhKTN8CLTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DlUf8b/P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB697606A31A;
	Sun,  1 Nov 2026 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlUf8b/P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310021F00A02;
	Sun,  1 Nov 2026 01:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793496511;
	bh=9jxnaJU/GpcwWRWB/sWaXu2IklLN1zFRwShITZdyTMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DlUf8b/PjEZiH1rlFlhKz5afZUFvN3eB3xktIUb6mPXEXJc5nQw0YPKctxh3sUYb0
	 GAy9//9SZsye80mhB5yHFC2sMSHdbDF2VJhrkVF/xvtJExFSlVUkaixESAMNZ3yTGq
	 9IhnPp4IUYV9niMYchq4IdNft1SaAyiH60qUwBGWPOMtdc/LYdWJLs6TqdKJAachtX
	 +CLTYQmulxXH8ZaNJf3wxMiQU6jwPtY+YaTSxK1Tr52PcGpKri+z/3MTZFrLXQcD+e
	 VcTK7AE9owFIVm09wDwr+wn+fnr4M30yXt96j4Cl5+kB/DAt2P4Uy1h2AoKlnWSnP4
	 7ZwP0gffUx1aQ==
Date: Sun, 1 Nov 2026 01:28:12 +0000
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
Subject: Re: [RFC PATCH 04/14] iio/light: add new driver for macsmc
Message-ID: <20261101012812.3661789c@jic23-hlaptop>
In-Reply-To: <20261029085504.3547-5-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
	<20261029085504.3547-5-atharvatiwarilinuxdev@gmail.com>
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

On Thu, 29 Oct 2026 04:52:01 -0400
Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:

> Add a driver for the ambient light sensors, exposed through
> the standard IIO interface with left and right channels.
> 
> This replaces the light sensor support in applesmc.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Hi Atharva,

Given I'm generally in favour of bringing the overall
driver to modern standard subsystems, I'll just do a quick
review of the actual code in the IIO drivers.

Various comments inline.

thanks,

Jonathan

> diff --git a/drivers/iio/light/macsmc-light.c b/drivers/iio/light/macsmc-light.c
> new file mode 100644
> index 000000000..9d4532b34
> --- /dev/null
> +++ b/drivers/iio/light/macsmc-light.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Apple SMC Light Sensor Driver
> + *
> + * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> + *
> + * Based on drivers/hwmom/applesmc.c:
> + * Copyright (C) 2007 Nicolas Boichat <nicolas@boichat.ch>
> + * Copyright (C) 2010 Henrik Rydberg <rydberg@euromail.se>
> + */
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/mfd/macsmc.h>
> +#include <linux/platform_device.h>
> +#include <linux/unaligned.h>
Give these a sanity check against other drivers
and what is used. For instance I'd expect the notifier chain
header.  For IIO we follow IWYU roughly for all files.
I don't want to assume what is in mfd/macsmc.h given
that may change in subtle ways in future.

> +
> +enum {
> +	LEFT_LIGHT = 0,
> +	RIGHT_LIGHT
Add trailing comma. Whilst that may always be the last value
it's not a terminating style entry so we tend to assume
maybe one day something will come after it.

> +};
> +
> +struct macsmc_light {
> +	struct apple_smc *smc;
> +	struct notifier_block nb;
> +	struct iio_dev *indio_dev;
> +	u8 size;
Size of what? Can we have a more informative name?
> +};
> +
> +static int macsmc_light_read_raw(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan,
> +		int *val, int *val2, long mask)
> +
> +{
> +	struct macsmc_light *drv = iio_priv(indio_dev);
> +	u8 buffer[10];
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	switch (chan->channel) {
> +	case LEFT_LIGHT:
> +		ret = apple_smc_read(drv->smc, SMC_KEY(ALV0), buffer, drv->size);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (drv->size == 10)
> +			*val = be16_to_cpu(get_unaligned_be16(buffer + 6)) >> 10;

odd.... You only pull 4 bits from the buffer and they are all in one byte.
Why can't you do that without this dance via big endian conversions? 
Also get_unaligned_be16() got you a value in cpu endian. If this were a
big endian CPU be16_to_cpu() would be a noop, but it's not. So this just
undid the endian handling and we are back to whatever the buffer ordering is.

> +		else
> +			*val = buffer[2];
> +
> +		break;
> +	case RIGHT_LIGHT:
> +		if (drv->size == 10) {
> +			*val = 0;
> +			break;
> +		}
> +		ret = apple_smc_read(drv->smc, SMC_KEY(ALV1), buffer, drv->size);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = buffer[2];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int macsmc_light_event(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	struct macsmc_light *drv = container_of(nb, struct macsmc_light, nb);
	struct iio_dev indio_dev = drv->indio_dev;

> +	s64 timestamp = iio_get_time_ns(drv->indio_dev);
> +
> +	/* check if event is for us */
> +	if (event != 0x2A)

Give that a define in some common header...

> +		return NOTIFY_DONE;
> +
> +	iio_push_event(drv->indio_dev,
> +		IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +				LEFT_LIGHT,
> +				IIO_EV_TYPE_CHANGE,
> +				IIO_EV_DIR_EITHER),
> +		timestamp);

	iio_push_event(indio_dev,
		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, LEFT_LIGHT,
					    IIO_EV_TYPE_CHANGE,
					    IIO_EV_DIR_EITHER),
		       timestamp);

> +
> +	if (drv->size != 10) {

Why is size relevant? I'd add a comment, or a flag that names
what that means.  I guess we have one signal for one or two
sensors depending on what is present?  Then you are correct
to just signal them both.

> +		iio_push_event(drv->indio_dev,
> +			IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +					RIGHT_LIGHT,
> +					IIO_EV_TYPE_CHANGE,
> +					IIO_EV_DIR_EITHER),
> +				timestamp);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void macsmc_light_unregister_notifier(void *data)
> +{
> +	struct macsmc_light *drv = data;
> +
> +	blocking_notifier_chain_unregister(drv->smc->event_handlers,
> +					   &drv->nb);
> +}
> +
> +static const struct iio_event_spec macsmc_light_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_CHANGE,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec macsmc_light_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.channel = LEFT_LIGHT,
> +		.extend_name = "left",

No to extend_name.  That's a piece of ancient bad design (was mind
so I can be rude ;).  Use the read_label callback and provide labels
for the channels to indicate the equivalent info.

The extend_name thing makes a mess for standard userspace by putting
free form text into the middle of file names.  Userspace folk
objected rather strongly to that a long time back :(

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec = macsmc_light_events,
> +		.num_event_specs = ARRAY_SIZE(macsmc_light_events),
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.channel = RIGHT_LIGHT,
> +		.extend_name = "right",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec = macsmc_light_events,
> +		.num_event_specs = ARRAY_SIZE(macsmc_light_events),
> +	},
> +};
> +
> +static const struct iio_info macsmc_light_info = {
> +	.read_raw = macsmc_light_read_raw,
> +};
> +
> +static int macsmc_light_probe(struct platform_device *pdev)
> +{

There are enough uses of pdev->dev in here that I'd introduce
	struct device *dev = &pdev->dev;
as the dev to use for devm calls.

> +	struct iio_dev *indio_dev;
> +	struct macsmc_light *drv;
> +	struct apple_smc_key_info info;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*drv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	drv = iio_priv(indio_dev);
> +	drv->smc = dev_get_drvdata(pdev->dev.parent);
> +
> +	ret = apple_smc_get_key_info(drv->smc, SMC_KEY(ALV0), &info);
> +	if (ret < 0)
> +		return -ENODEV;
> +
> +	drv->size = info.size;
> +	drv->indio_dev = indio_dev;
> +	drv->nb.notifier_call = macsmc_light_event;
> +	ret = blocking_notifier_chain_register(drv->smc->event_handlers, &drv->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, macsmc_light_unregister_notifier, drv);

I wonder how many users there would be a devm_blocking_notifier_chain_register()
as it could be done more elegantly than this by stashing everything needed for
the unregister call.  Perhaps not something for this patch set though.

> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "macsmc-light";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &macsmc_light_info;
> +	indio_dev->channels = macsmc_light_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(macsmc_light_channels);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}

