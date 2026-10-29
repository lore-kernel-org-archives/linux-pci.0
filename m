Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264273;
	b=SI4w3SMeUD5m7c1sERlQwy8SdEKeOW9P4eYKe4XK7PD8JDnkYu7nH+hOkcCeUyuD4Fd4
	 D5BazjIzQy40ffKfkQPErHqnJo6wIUdJhlAsqFVeiF5CVspxLE05hqLUdIQ3IMCexcoR2
	 wvAg3sWMzt1kJdt9EwKqHsVUPpd7qZ4D0nAAu75dj1EM/Bi4PRI34+zz6c005R39FB34v
	 uxTyibkr/D1yONJCf+JVZa9y0ITd2gE+FKXyXonvpmbOQSjDmn0IjY+He/VA5cCsIqDJ5
	 wt5EHNNNR8A07D4crftzfX3QblE5b4BBNYRe+6o+eqj6ToaoO/0wUedJ5++SCjre2XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cs7lasADMMl4bjEjGvbybzUuKYrhEora6V1skLnp0co=;
	b=DERTstkOuHG2j29F40+/m9di5306A9Z5R6WDfu+yj7CXGoIuLE5E58N921hx/sTld+LY
	 8R4xz4mA7k5G9S7qkstakzSlF+pphYyhZNGWsScDzWdXfwt9CB5PcQFkQLjrKahFnocvN
	 QzvVdIItjv/B/jLOED9YiGRzpoJ9U/Vx1BVS1DaKj6R/vBmFH0Rj/gAZDAtI3ONqHhtT/
	 H/5AW0VGM/WTcP+EyBGXex3YAGnU+pLC4x0kLDuTgZuuCCKojaelthsiNxCvH0cTrhbOy
	 YSqr5pTr4k0Vlz20Yc6kFgKGaalKETwQjauNqM47YJeQuGe4ZDJzmICKdY+zMAbPSHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRtT2iUT;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C94606A31D
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 08:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C94606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRtT2iUT
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a1947498bso1254501eec.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 01:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264271; x=1793869071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cs7lasADMMl4bjEjGvbybzUuKYrhEora6V1skLnp0co=;
        b=HRtT2iUTIP8tQw0W2BF26I1s3RT7ZhcG3VnZDhwJ0/tWXcgCT1stZLKnUS9jKYY/pe
         Qw8TAVw2OvDsE60gmnd+EW02UWEmkaqK9UP+jxxvNRtkxL/qYmdNkLloF7ZVUeUI/lcg
         hL2EgfJIc4uL4D/gFtXsvzUtZGcJiWiTVbonWyG2YL6Ya57C1P96E/CGd5gKuQCWIa9X
         94/0tUFVsZGEpt1X574eJA3ZBDxVk2zTZxqvXyddtci5lM2nRezNMD8TjE1ErEoWxHnr
         cCAb1f1omnp9csacXav36aPoiaX+swdxYOmk9bluvJP5ylS8bEuIhwcEV8GjTh+CoFPJ
         FVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264271; x=1793869071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cs7lasADMMl4bjEjGvbybzUuKYrhEora6V1skLnp0co=;
        b=nVo5xsJ7Be1TnegH6tFP8b2OAjzHopO5RE/ygoOrWKKS1PWSWh7M0DDw9Sotyab9xe
         IzU5AxDw6TClnKgKq7bvTtnjRhyD1pJwuzqqF/UUizo/wUX8VJ9QtJQTG0GW5KogFjii
         I9pMR7qOX3/BDr0FkM/OFl6mYPVHZlKLjdDzEs+8iXPfdX88qGHcw1pxJHA/fLCWam8u
         P0ABIYb1YzEOGuhpq3IyFaFM9ap3/as1kYF3X3y7hLVfNPwYqRU152TMhD3dbulOdBrE
         8OUT92EWg/FPkpWgeSitY+UCOYmXPraYGJ/qsvZh9GTK+Fgve8lbDve6hhHuCgylm8Rz
         yJqg==
X-Forwarded-Encrypted: i=1; AKwUvBwfqyY88Y8VC64BRJ+xv2nyoHNVoLizKV4JqYVOLkAaX22dyCE1NdTfDL/jvds/5z98wRd0vQJWROo=@vger.kernel.org
X-Gm-Message-State: AFq9FYInXkALB+O4j4h7XBrOLqreGwd4nxyEsDWt/JUEMq9b/yzXN9LK
	sZ1PcUJ2fDjtgNtU+eK6GaUoscwzYD8e4TOFNUtvTThqmJREELmvv0g=
X-Gm-Gg: AYBFou1OJu5H14PZBziykJj02kpTbOAAOUHNoJQLifT24oSkOBV1ngkV8v7dNak/4gI
	T4Nzsp0m91mxVV1ghJFhDTY+pUC9pS7U11ZRgEvqrD1l2vA6ppmzbfQVcsadzwSe1L9keR/IihT
	lOp7j8tX9OhOIGXhnX7QN+pPQn9B8kjwVSB0zWAzIsvWoMaLnSCcwUC6epPtlSFQOe1TXu8/IEp
	8aAzgBnHr7dgpNevn75tWW5VY+BaJu6wL5UBsvjVi1Js9QQo2/0Cs9eNkaq9kvR/vUBpoENo7od
	EwAbMJixv4Wpw1dxqrtukWmuSh9MN1wI6xCXWsOvPL/a0xF5fNLbP064ST7hUsfMK4QwuxsJKf2
	ZKnl7i/uolIWMW0fS3/6/2R6Au2CIClvK80GArvqg8huva/ZTA1Ku9MbEf4S6tyeSOc++u3H24h
	Jk/JhatFKbBWLvVICb2eFnm0sk2wrWU8A2mYYY+x0YbPW/uRztxGGjoP1ZBGuq+hsIBvfBE6nXm
	gE9my5yP78X7/r2y38tzRdsYFygpCZ60deOlijajB+1b0yEzJRLQrc2/4hLWogThfDUw/HogAlF
	jQbDwJ9op9IO0EtWwlaRb2s2UJIzPW1h5P589UMOA70H7XYgliLUnjxtwR38Nw==
X-Received: by 2002:a05:693c:4010:b0:36a:eee:bb41 with SMTP id 5a478bee46e88-36a202bc3ccmr7412692eec.1.1793264270972;
        Thu, 29 Oct 2026 01:57:50 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:57:49 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 04/14] iio/light: add new driver for macsmc
Date: Thu, 29 Oct 2026 04:52:01 -0400
Message-ID: <20261029085504.3547-5-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the ambient light sensors, exposed through
the standard IIO interface with left and right channels.

This replaces the light sensor support in applesmc.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/iio/light/Kconfig        |  11 ++
 drivers/iio/light/Makefile       |   1 +
 drivers/iio/light/macsmc-light.c | 189 +++++++++++++++++++++++++++++++
 drivers/mfd/macsmc-core.c        |  11 ++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/iio/light/macsmc-light.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 462fff1dd..f84707edc 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -457,6 +457,17 @@ config LV0104CS
 	  To compile this driver as a module, choose M here:
 	  the module will be called lv0104cs.
 
+config MACSMC_LIGHT
+	tristate "Apple SMC Light Sensor"
+	depends on MACSMC_ACPI
+	help
+	  Say Y here if you have a Intel-based Mac. and you
+	  want support for light sensors.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called macsmc_light
+
+
 config MAX44000
 	tristate "MAX44000 Ambient and Infrared Proximity Sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 6672ed01a..2ef4c054d 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_LTR390)		+= ltr390.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
 obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
 obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
+obj-$(CONFIG_MACSMC_LIGHT)	+= macsmc-light.o
 obj-$(CONFIG_MAX44000)		+= max44000.o
 obj-$(CONFIG_MAX44009)		+= max44009.o
 obj-$(CONFIG_NOA1305)		+= noa1305.o
diff --git a/drivers/iio/light/macsmc-light.c b/drivers/iio/light/macsmc-light.c
new file mode 100644
index 000000000..9d4532b34
--- /dev/null
+++ b/drivers/iio/light/macsmc-light.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Apple SMC Light Sensor Driver
+ *
+ * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
+ *
+ * Based on drivers/hwmom/applesmc.c:
+ * Copyright (C) 2007 Nicolas Boichat <nicolas@boichat.ch>
+ * Copyright (C) 2010 Henrik Rydberg <rydberg@euromail.se>
+ */
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/byteorder/generic.h>
+#include <linux/mfd/macsmc.h>
+#include <linux/platform_device.h>
+#include <linux/unaligned.h>
+
+enum {
+	LEFT_LIGHT = 0,
+	RIGHT_LIGHT
+};
+
+struct macsmc_light {
+	struct apple_smc *smc;
+	struct notifier_block nb;
+	struct iio_dev *indio_dev;
+	u8 size;
+};
+
+static int macsmc_light_read_raw(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan,
+		int *val, int *val2, long mask)
+
+{
+	struct macsmc_light *drv = iio_priv(indio_dev);
+	u8 buffer[10];
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	switch (chan->channel) {
+	case LEFT_LIGHT:
+		ret = apple_smc_read(drv->smc, SMC_KEY(ALV0), buffer, drv->size);
+		if (ret < 0)
+			return ret;
+
+		if (drv->size == 10)
+			*val = be16_to_cpu(get_unaligned_be16(buffer + 6)) >> 10;
+		else
+			*val = buffer[2];
+
+		break;
+	case RIGHT_LIGHT:
+		if (drv->size == 10) {
+			*val = 0;
+			break;
+		}
+		ret = apple_smc_read(drv->smc, SMC_KEY(ALV1), buffer, drv->size);
+		if (ret < 0)
+			return ret;
+
+		*val = buffer[2];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int macsmc_light_event(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct macsmc_light *drv = container_of(nb, struct macsmc_light, nb);
+	s64 timestamp = iio_get_time_ns(drv->indio_dev);
+
+	/* check if event is for us */
+	if (event != 0x2A)
+		return NOTIFY_DONE;
+
+	iio_push_event(drv->indio_dev,
+		IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+				LEFT_LIGHT,
+				IIO_EV_TYPE_CHANGE,
+				IIO_EV_DIR_EITHER),
+		timestamp);
+
+	if (drv->size != 10) {
+		iio_push_event(drv->indio_dev,
+			IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+					RIGHT_LIGHT,
+					IIO_EV_TYPE_CHANGE,
+					IIO_EV_DIR_EITHER),
+				timestamp);
+	}
+
+	return NOTIFY_OK;
+}
+
+static void macsmc_light_unregister_notifier(void *data)
+{
+	struct macsmc_light *drv = data;
+
+	blocking_notifier_chain_unregister(drv->smc->event_handlers,
+					   &drv->nb);
+}
+
+static const struct iio_event_spec macsmc_light_events[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec macsmc_light_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.channel = LEFT_LIGHT,
+		.extend_name = "left",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = macsmc_light_events,
+		.num_event_specs = ARRAY_SIZE(macsmc_light_events),
+	},
+	{
+		.type = IIO_LIGHT,
+		.channel = RIGHT_LIGHT,
+		.extend_name = "right",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = macsmc_light_events,
+		.num_event_specs = ARRAY_SIZE(macsmc_light_events),
+	},
+};
+
+static const struct iio_info macsmc_light_info = {
+	.read_raw = macsmc_light_read_raw,
+};
+
+static int macsmc_light_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct macsmc_light *drv;
+	struct apple_smc_key_info info;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*drv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	drv = iio_priv(indio_dev);
+	drv->smc = dev_get_drvdata(pdev->dev.parent);
+
+	ret = apple_smc_get_key_info(drv->smc, SMC_KEY(ALV0), &info);
+	if (ret < 0)
+		return -ENODEV;
+
+	drv->size = info.size;
+	drv->indio_dev = indio_dev;
+	drv->nb.notifier_call = macsmc_light_event;
+	ret = blocking_notifier_chain_register(drv->smc->event_handlers, &drv->nb);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, macsmc_light_unregister_notifier, drv);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "macsmc-light";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &macsmc_light_info;
+	indio_dev->channels = macsmc_light_channels;
+	indio_dev->num_channels = ARRAY_SIZE(macsmc_light_channels);
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver macsmc_light_driver = {
+	.probe = macsmc_light_probe,
+	.driver = {
+		.name = "macsmc-light",
+	},
+};
+module_platform_driver(macsmc_light_driver);
+
+MODULE_AUTHOR("Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("Apple SMC Light Sensor Driver");
+MODULE_ALIAS("platform:macsmc-light");
diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
index 1c1469828..6014df4fe 100644
--- a/drivers/mfd/macsmc-core.c
+++ b/drivers/mfd/macsmc-core.c
@@ -29,6 +29,10 @@ static const struct mfd_cell apple_smc_acpi_common[] = {
 	MFD_CELL_NAME("macsmc-power"),
 };
 
+static const struct mfd_cell apple_smc_acpi_light[] = {
+	MFD_CELL_NAME("macsmc-light"),
+};
+
 static const struct mfd_cell apple_smc_acpi_rtc[] = {
 	MFD_CELL_NAME("macsmc-rtc"),
 };
@@ -158,6 +162,13 @@ int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 				return ret;
 		}
 
+		if (apple_smc_key_exists(smc, SMC_KEY(ALV0))) {
+			ret = devm_mfd_add_devices(dev, -1, apple_smc_acpi_light,
+				ARRAY_SIZE(apple_smc_acpi_light), NULL, 0, NULL);
+			if (ret < 0)
+				return ret;
+		}
+
 	} else
 		ret = devm_mfd_add_devices(dev, -1, apple_smc_rtkit_devs,
 			ARRAY_SIZE(apple_smc_rtkit_devs), NULL, 0, NULL);
-- 
2.55.0

