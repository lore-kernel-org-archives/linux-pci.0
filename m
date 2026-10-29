Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278823;
	b=PVJRCj4KdgFEnJb83jgInSj4utzQcqdyCw7/TgcWf/nwKCJYXJuIL+8S15N8yuKIkEyi
	 yaaHBPH/WPxsaXlhouewsKdWPHJtmTAtCzg2yGxdD+oF3UK1A2DyiS3Ca+LUN7rEFiU6A
	 qHjPM8nJcoU3zrfDXfKBaAgFVpEttpltLH8xXe8QHDkJlFegCgibDDsgaKBLTqSj9NjWH
	 4qVCY3Fl+b0m4JTieXh9AMWf++Fa5TVHHlTpcJxfVBfgXok90xRecnGLO3ESUew1VpfjU
	 XWaQT/8FjJe/t5c8Qx4bMlHnZsY64JA86CxyKG+BDs4iHyrJxXia+ixd9R7DUg1v73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278823;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=e8owfEJpSE9Jnys+2aSeIDroUxjHdfvyjJl6Hc7Zcjs=;
	b=HDRcIL4tNfODpEggMiNSldtpnTTHmX9PVh0tda1zenaWcFOWqqntTbPvHIUKx83tt78O
	 yc1vrWtL6O846zkHc+rQmNYVyFa0p7D67Wdzy6QDV2yEK/f3Hou3KYI2o1zwCbkz9rgl/
	 pRTD5JyTFGEaBtzyvG25hmyaVoxbgKSasCscDDkGyb58w6ETB+yJuj9oEdZArunRCy6Qj
	 MPweMPRs2XEhDy0CCV6b/PsvXSwZsGmBrTSa3Ym213RPhCX+OU2SxNK48kz9nKxuuU/3i
	 fO2cp9YlcU6uCiZGXdETCCRU2fFn6/csrAxYxULmQtXL6ApfAUjXleJmgwQzF8L4VCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iV15jqlQ;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2C606A31E;
	Thu, 29 Oct 2026 13:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC2C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iV15jqlQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793278823; x=1824814823;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pQZ5jTIQQgWy5IOQkc0GctjtqZcLd8xfFvrDyC/7bpA=;
  b=iV15jqlQKLZfwR6gLD/x+HiOokKRqI18wRYY9PWs9witz2QGwST5WqIk
   y8+3GuJjbN0hiMTf1zM6uc3dk2o1mm6NXgMB7NBFSETgnVUn1zaQ2RxSb
   WCHatC+B7vBDM3RgrZyqVnbkEB1hOpg2kEDJWrUNv6yLcwJFM3M+GaE2F
   qpMBm0USPjZ3C7TX9icg1iKW0yPGGS0YWq9F/hXfwr9Mt/r40S7GqRVqB
   8k217e4l5ShqDlD8+EN7CXjAlOuitCTjv58oEX3Q7RFadP+O97ZeNHEqd
   Gdi6UGiyPFaLkcChlihX+YHUiHbs5kSxRUWbhRTZV4NcQV/JjkctyOsZZ
   Q==;
X-CSE-ConnectionGUID: kWG5BewiSQOGPJrBJkBQJA==
X-CSE-MsgGUID: X1nQKRR8Sw+Ji+5kLHqEMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1903126"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1903126"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:00:21 -0700
X-CSE-ConnectionGUID: aglSvOwORVS4Qiyuh8Rc+w==
X-CSE-MsgGUID: T9hQ0FJ4QB+MqSRu3PqRdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5243206"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.149])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:00:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Oct 2026 14:59:59 +0200 (EET)
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
    Len Brown <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>, 
    Bartosz Golaszewski <brgl@kernel.org>, Sven Peter <sven@kernel.org>, 
    Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
    Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, 
    David Lechner <dlechner@baylibre.com>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>, 
    Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, 
    Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>, 
    Hans de Goede <hansg@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Wim Van Sebroeck <wim@linux-watchdog.org>, 
    Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
    Roberto Sassu <roberto.sassu@huawei.com>, 
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
    Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
    James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
    asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
    linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
    linux-leds@vger.kernel.org, mfd@lists.linux.dev, 
    platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
    linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, 
    linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
    linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 02/14] platform/x86: add backend for macsmc in intel
 macs
In-Reply-To: <20261029085504.3547-3-atharvatiwarilinuxdev@gmail.com>
Message-ID: <0cba7eea-ed39-d4d8-8587-f1c07cb5b03f@linux.intel.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com> <20261029085504.3547-3-atharvatiwarilinuxdev@gmail.com>
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

On Thu, 29 Oct 2026, Atharva Tiwari wrote:

> Add a backend that talks to the SMC on Intel Macs over ACPI.
> It supports the old I/O port interface, and also MMIO and
> interrupt-driven completion, which applesmc doesn't have.
> If an interrupt is missed it falls back to polling.
> 
> This is the base that lets the macsmc drivers replace
> applesmc.

You have 72-75 chars. Don't split intentionally at . unless you really
start another paragraph.

> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  drivers/platform/x86/Kconfig       |  10 +
>  drivers/platform/x86/Makefile      |   1 +
>  drivers/platform/x86/macsmc-acpi.c | 642 +++++++++++++++++++++++++++++
>  3 files changed, 653 insertions(+)
>  create mode 100644 drivers/platform/x86/macsmc-acpi.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 4851bf451..448aa2db6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -202,6 +202,16 @@ config ADV_SWBUTTON
>  	  To compile this driver as a module, choose M here. The module will
>  	  be called adv_swbutton.
>  
> +config MACSMC_ACPI
> +	tristate "Apple SMC (System Management Controller) ACPI Backend"
> +	depends on MFD_MACSMC_CORE && ACPI && !SENSORS_APPLESMC
> +	help
> +	  This driver allows communication with the SMC (System Management Controller)
> +	  on Intel-Macs. It is used to control fans, control battery, and more.
> +
> +	  To compile this driver as a module, choose M here. The module will
> +	  be called macsmc_acpi.
> +
>  config APPLE_GMUX
>  	tristate "Apple Gmux Driver"
>  	depends on ACPI && PCI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index cab20a414..933aed4a8 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -28,6 +28,7 @@ obj-y				+= amd/
>  obj-$(CONFIG_ADV_SWBUTTON)	+= adv_swbutton.o
>  
>  # Apple
> +obj-$(CONFIG_MACSMC_ACPI)	+= macsmc-acpi.o
>  obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
>  
>  # ASUS
> diff --git a/drivers/platform/x86/macsmc-acpi.c b/drivers/platform/x86/macsmc-acpi.c
> new file mode 100644
> index 000000000..a06ec921a
> --- /dev/null
> +++ b/drivers/platform/x86/macsmc-acpi.c
> @@ -0,0 +1,642 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SMC ACPI backend
> + * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> + *
> + * PIO code taken from drivers/hwmon/applesmc.c:
> + * Copyright (C) 2007 Nicolas Boichat <nicolas@boichat.ch>
> + * Copyright (C) 2010 Henrik Rydberg <rydberg@euromail.se>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kfifo.h>
> +#include <linux/mfd/macsmc.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/spinlock.h>
> +#include <linux/unaligned.h>
> +#include <linux/workqueue.h>
> +
> +#define SMC_IO_DATA_PORT	0
> +#define SMC_IO_CMD_PORT		4
> +#define SMC_IO_NR_PORTS		32
> +
> +#define SMC_IO_STATUS_AWAITING_DATA	BIT(0)
> +#define SMC_IO_STATUS_IB_CLOSED		BIT(1)
> +#define SMC_IO_STATUS_BUSY		BIT(2)

Add include.

> +
> +#define SMC_MMIO_KEY_DATA		0
> +#define SMC_MMIO_KEY_INTERRUPT_STATUS	0x4000
> +#define SMC_MMIO_KEY_STATUS		0x4005
> +#define SMC_MMIO_KEY_NAME		0x78
> +#define SMC_MMIO_KEY_DATA_LEN		0x7D
> +#define SMC_MMIO_KEY_SMC_ID		0x7E
> +#define SMC_MMIO_KEY_CMD		0x7F
> +#define SMC_MMIO_MIN_SIZE		0x4006
> +
> +#define SMC_TIMEOUT_MS			1000
> +
> +struct apple_smc_acpi {
> +	struct device *dev;
> +
> +	u8 __iomem *iomem_base;
> +	u32 iomem_base_addr, iomem_base_size;
> +	bool is_mmio;
> +
> +	u16 port_base;
> +	bool has_port;
> +
> +	bool has_interrupt;
> +	bool interrupt_enabled;
> +	struct completion cmd_done;
> +
> +	struct blocking_notifier_head event_handlers;
> +	struct work_struct shutdown_work;
> +	struct work_struct notifier_work;
> +
> +	DECLARE_KFIFO(event_fifo, u8, 64);
> +	spinlock_t event_lock;

You must document what the lock protects.

> +};
> +
> +
> +static int apple_smc_acpi_port_wait(struct apple_smc_acpi *smc, u8 val, u8 mask)
> +{
> +	int ms;
> +
> +	for (ms = SMC_TIMEOUT_MS; ms != 0; ms--) {
> +		if ((inb(smc->port_base + SMC_IO_CMD_PORT) & mask) == val)
> +			return 0;
> +
> +		fsleep(1000);
> +	}

Something from iopoll.h should suffice for this.

> +	dev_dbg(smc->dev, "port/wait: timeout value:%u, mask:%u\n", val, mask);

Add include.

> +	return -ETIMEDOUT;
> +}
> +
> +static int apple_smc_acpi_port_write_byte(struct apple_smc_acpi *smc, u8 buf)
> +{
> +	int ret;
> +
> +	ret = apple_smc_acpi_port_wait(smc, 0, SMC_IO_STATUS_IB_CLOSED) ? :
> +		apple_smc_acpi_port_wait(smc, SMC_IO_STATUS_BUSY, SMC_IO_STATUS_BUSY);

Split this please.

> +	if (ret)
> +		return ret;
> +
> +	outb(buf, smc->port_base + SMC_IO_DATA_PORT);
> +	return 0;
> +}
> +
> +static int apple_smc_acpi_port_write_cmd(struct apple_smc_acpi *smc, u8 buf)
> +{
> +	int ret;
> +
> +	ret = apple_smc_acpi_port_wait(smc, 0, SMC_IO_STATUS_IB_CLOSED);
> +	if (ret)
> +		return ret;
> +
> +	outb(buf, smc->port_base + SMC_IO_CMD_PORT);
> +	return 0;
> +}
> +
> +static int apple_smc_acpi_port_write_key(struct apple_smc_acpi *smc, smc_key key)
> +{
> +	int i;
> +
> +	for (i = 3; i >= 0; i--) {
> +		if (apple_smc_acpi_port_write_byte(smc, (u8)(key >> (i * 8))))

I'd prefer ANDing with 0xff instead of relying on the cast.

> +			return -EIO;
> +	}
> +	return 0;
> +}
> +
> +static int apple_smc_acpi_port_valid(struct apple_smc_acpi *smc)
> +{
> +	int ret;
> +
> +	ret = apple_smc_acpi_port_wait(smc, 0, SMC_IO_STATUS_BUSY);
> +	if (!ret)
> +		return ret;
> +
> +	ret = apple_smc_acpi_port_write_cmd(smc, SMC_MSG_READ_KEY);
> +	if (ret)
> +		return ret;
> +
> +	return apple_smc_acpi_port_wait(smc, 0, SMC_IO_STATUS_BUSY);
> +}
> +
> +static int apple_smc_acpi_port_read(struct apple_smc_acpi *smc, u8 cmd, smc_key key,
> +				void *buffer, size_t len)
> +{
> +	int ret;
> +
> +	ret = apple_smc_acpi_port_valid(smc);
> +	if (ret)
> +		return ret;
> +
> +	if (apple_smc_acpi_port_write_cmd(smc, cmd) || apple_smc_acpi_port_write_key(smc, key)) {
> +		dev_dbg(smc->dev, "port/read: read argument failed, key: 0x%X, cmd: 0x%X\n",
> +				key, cmd);
> +		return -EIO;
> +	}
> +
> +	if (apple_smc_acpi_port_write_byte(smc, len)) {
> +		dev_dbg(smc->dev, "port/read: read len failed, key: 0x%X, len: 0x%lX\n", key, len);
> +		return -EIO;
> +	}
> +
> +	for (ret = 0; ret < len; ret++) {
> +		if (apple_smc_acpi_port_wait(smc,
> +				SMC_IO_STATUS_AWAITING_DATA | SMC_IO_STATUS_BUSY,
> +				SMC_IO_STATUS_AWAITING_DATA | SMC_IO_STATUS_BUSY)) {
> +			dev_dbg(smc->dev, "port/read: read failed, key: 0x%X\n", key);
> +			return -EIO;
> +		}
> +		((u8 *)buffer)[ret] = inb(smc->port_base + SMC_IO_DATA_PORT);

Why is buffer void * and not u8 *?

> +	}
> +
> +	return apple_smc_acpi_port_wait(smc, 0, SMC_IO_STATUS_BUSY);
> +}
> +
> +static int apple_smc_acpi_port_write(struct apple_smc_acpi *smc, smc_key key, const void *buffer,
> +		size_t len)
> +{
> +	int ret;
> +
> +	ret = apple_smc_acpi_port_valid(smc);
> +	if (ret)
> +		return ret;
> +
> +	if (apple_smc_acpi_port_write_cmd(smc, SMC_MSG_WRITE_KEY) ||
> +			apple_smc_acpi_port_write_key(smc, key)) {
> +		dev_dbg(smc->dev, "port/write: write argument failed, key: 0x%X\n", key);
> +		return -EIO;
> +	}
> +
> +	if (apple_smc_acpi_port_write_byte(smc, len)) {
> +		dev_dbg(smc->dev, "port/write: write len failed, key: 0x%X, len: 0x%lX\n",
> +				key, len);
> +		return -EIO;
> +	}
> +
> +	for (ret = 0; ret < len; ret++) {
> +		if (apple_smc_acpi_port_write_byte(smc, ((const u8 *)buffer)[ret])) {

Why is the buffer void *?

> +			dev_dbg(smc->dev, "port/write: write failed, key: 0x%X\n", key);
> +			return -EIO;
> +		}
> +	}
> +	return apple_smc_acpi_port_wait(smc, 0, SMC_IO_STATUS_BUSY);
> +}
> +
> +static int apple_smc_acpi_port_get_key_info(struct apple_smc_acpi *smc,
> +			smc_key key, struct apple_smc_key_info *info)
> +{
> +	u8 buf[6];
> +
> +	if (apple_smc_acpi_port_read(smc, SMC_MSG_GET_KEY_INFO, key, buf, 6))

sizeof(buf)

> +		return -EIO;
> +
> +	if (!info)
> +		return 0;
> +
> +	info->size = buf[0];
> +	info->type_code = get_unaligned_be32(&buf[1]);

Please use a proper endianness type. It would be preferrable to make a 
(__packed) struct out of this so you can properly name and type the 
members. It would also get rid if magic number offsets.

Don't forget add include if you use __packed.

> +	info->flags = buf[5];
> +
> +	return 0;
> +}
> +
> +static void apple_smc_acpi_mmio_clear(struct apple_smc_acpi *smc)
> +{
> +	if (ioread8(smc->iomem_base + SMC_MMIO_KEY_STATUS))
> +		return iowrite8(0, smc->iomem_base + SMC_MMIO_KEY_STATUS);
> +}
> +
> +static int apple_smc_acpi_mmio_wait(struct apple_smc_acpi *smc)
> +{
> +	int ms = SMC_TIMEOUT_MS;
> +
> +	if (smc->interrupt_enabled) {
> +		if (wait_for_completion_timeout(&smc->cmd_done,
> +					msecs_to_jiffies(SMC_TIMEOUT_MS)) > 0)
> +			return 0;
> +
> +		smc->interrupt_enabled = 0;
> +		dev_dbg(smc->dev, "mmio/wait: interrupt missed, reverting to polling\n");
> +	}
> +
> +	for (ms = SMC_TIMEOUT_MS; ms != 0; ms--) {
> +		if (ioread8(smc->iomem_base + SMC_MMIO_KEY_STATUS) & 0x20)

Name the literal with a define.

> +			return 0;
> +
> +		fsleep(1000);
> +	}
> +	dev_dbg(smc->dev, "mmio/wait: timeout");
> +	return -ETIMEDOUT;
> +}
> +
> +static int apple_smc_acpi_mmio_read(struct apple_smc_acpi *smc, u8 cmd, smc_key key,
> +		void *buffer, size_t len)
> +{
> +	u8 ret;
> +
> +	reinit_completion(&smc->cmd_done);
> +	apple_smc_acpi_mmio_clear(smc);
> +	iowrite32be(key, smc->iomem_base + SMC_MMIO_KEY_NAME);
> +	iowrite8(0, smc->iomem_base + SMC_MMIO_KEY_SMC_ID);
> +	iowrite8(cmd, smc->iomem_base + SMC_MMIO_KEY_CMD);
> +
> +	if (apple_smc_acpi_mmio_wait(smc))
> +		return -EIO;
> +
> +	ret = ioread8(smc->iomem_base + SMC_MMIO_KEY_CMD);
> +	if (ret) {
> +		dev_dbg(smc->dev, "mmio/read: read failed, ret: 0x%X, key: 0x%X\n", ret, key);
> +		return -ret;
> +	}
> +
> +	memcpy_fromio(buffer, smc->iomem_base + SMC_MMIO_KEY_DATA, len);
> +	return 0;
> +}
> +
> +static int apple_smc_acpi_mmio_write(struct apple_smc_acpi *smc, smc_key key, const void *buffer,
> +		size_t len)
> +{
> +	u8 ret;
> +
> +	reinit_completion(&smc->cmd_done);
> +	apple_smc_acpi_mmio_clear(smc);
> +	iowrite32be(key, smc->iomem_base + SMC_MMIO_KEY_NAME);
> +	memcpy_toio(smc->iomem_base + SMC_MMIO_KEY_DATA, buffer, len);
> +	iowrite8(len, smc->iomem_base + SMC_MMIO_KEY_DATA_LEN);
> +	iowrite8(0, smc->iomem_base + SMC_MMIO_KEY_SMC_ID);
> +	iowrite8(SMC_MSG_WRITE_KEY, smc->iomem_base + SMC_MMIO_KEY_CMD);
> +
> +	if (apple_smc_acpi_mmio_wait(smc))
> +		return -EIO;
> +
> +	ret = ioread8(smc->iomem_base + SMC_MMIO_KEY_CMD);
> +	if (ret) {
> +		dev_dbg(smc->dev, "mmio/write: write failed, ret: 0x%X, key: 0x%X\n", ret, key);
> +		return -ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int apple_smc_acpi_mmio_get_key_info(struct apple_smc_acpi *smc, smc_key key,
> +					struct apple_smc_key_info *info)
> +{
> +	u8 ret;
> +
> +	reinit_completion(&smc->cmd_done);
> +	apple_smc_acpi_mmio_clear(smc);
> +	iowrite32be(key, smc->iomem_base + SMC_MMIO_KEY_NAME);
> +	iowrite8(0, smc->iomem_base + SMC_MMIO_KEY_SMC_ID);
> +	iowrite8(SMC_MSG_GET_KEY_INFO, smc->iomem_base + SMC_MMIO_KEY_CMD);
> +	if (apple_smc_acpi_mmio_wait(smc))
> +		return -EIO;
> +
> +	ret = ioread8(smc->iomem_base + SMC_MMIO_KEY_CMD);

Don't name non-return-value variables "ret".

> +	if (ret) {
> +		dev_dbg(smc->dev, "mmio/get_key_info failed, ret: 0x%X, key: 0x%X\n", ret, key);
> +		return -ret;
> +	}

Largely identical to another function above? Add a helper?

> +	if (!info)
> +		return 0;
> +	info->type_code = cpu_to_be32(ioread32(smc->iomem_base + SMC_MMIO_KEY_DATA));
> +	info->size = ioread8(smc->iomem_base + 5);
> +	info->flags = ioread8(smc->iomem_base + 6);

Name the literal indexes with defines.

> +
> +	return 0;
> +}
> +
> +static void apple_smc_acpi_shutdown_work(struct work_struct *work)
> +{
> +	orderly_poweroff(true);
> +}
> +
> +static void apple_smc_acpi_notifier_work(struct work_struct *work)
> +{
> +	struct apple_smc_acpi *smc =
> +		container_of(work, struct apple_smc_acpi, notifier_work);
> +
> +	unsigned long flags;
> +	uint8_t event;

Kernel uses u8 for internal variables.

> +
> +	for (;;) {
> +		spin_lock_irqsave(&smc->event_lock, flags);
> +
> +		if (!kfifo_get(&smc->event_fifo, &event)) {
> +			spin_unlock_irqrestore(&smc->event_lock, flags);

Please use scoped_guard() to avoid having to split unlock paths.

> +			break;
> +		}
> +		spin_unlock_irqrestore(&smc->event_lock, flags);
> +
> +		blocking_notifier_call_chain(&smc->event_handlers, event, NULL);
> +	}
> +}
> +
> +static irqreturn_t apple_smc_acpi_irq(int irq, void *data)
> +{
> +	struct apple_smc_acpi *smc = data;
> +	uint8_t status = 0, int_id = 0;
> +	unsigned long flags;
> +
> +	if (smc->is_mmio) {
> +		status = ioread8(smc->iomem_base + SMC_MMIO_KEY_INTERRUPT_STATUS);
> +		if ((status & 0x20) == 0 && status != 0)
> +			return IRQ_HANDLED;
> +	} else {
> +		status = inb(smc->port_base + SMC_IO_CMD_PORT);
> +		if ((status & 0x40) == 0 && status != 0)

Name the literals with a define x2

(...) == 0 => !(...)

> +			return IRQ_HANDLED;
> +	}
> +
> +	int_id = inb(smc->port_base + 0x1F);
> +	switch (int_id) {
> +	case 0x4B: // SMC Command done

Don't add comments like this at all but make all those named defines,
you clearly seem to know about they are so name them accordingly.

> +		complete(&smc->cmd_done);
> +		break;
> +	case 0x40: // Shutdown Imminet
> +		schedule_work(&smc->shutdown_work);
> +		break;
> +	case 0x41: // bridgeOS Crash
> +		dev_crit(smc->dev, "BridgeOS Crashed!!!\n");
> +		break;
> +	case 0x2A: // ALS Change
> +	case 0x54: // Thermal Level Changed
> +	case 0x55: // PlatformFuntion
> +	case 0x60: // SMS Drop
> +	case 0x69: // SMS Orientation
> +	case 0x6F: // SMS Shock
> +	case 0x80: // PLimit Changed
> +		spin_lock_irqsave(&smc->event_lock, flags);
> +		if (!kfifo_put(&smc->event_fifo, int_id))
> +			dev_warn_ratelimited(smc->dev, "Notification lost: %u\n", int_id);
> +
> +		spin_unlock_irqrestore(&smc->event_lock, flags);
> +
> +		schedule_work(&smc->notifier_work);
> +		break;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static acpi_status apple_smc_acpi_walk_resources(struct acpi_resource *res,
> +	void *data)

Please align to ( or just use one line (you have long lines below anyway 
so I don't know why you split this one).

> +{
> +	struct apple_smc_acpi *smc = data;
> +	int ret = 0;

Why you need to init this?

> +
> +	switch (res->type) {
> +	case ACPI_RESOURCE_TYPE_IO:
> +		if (!smc->has_port) {
> +			if (res->data.io.address_length < SMC_IO_NR_PORTS)
> +				return AE_ERROR;
> +			smc->port_base = res->data.io.minimum;
> +			smc->has_port = true;
> +		}
> +		return AE_OK;
> +
> +	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> +		if (!smc->is_mmio) {
> +			if (res->data.fixed_memory32.address_length < SMC_MMIO_MIN_SIZE) {
> +				dev_dbg(smc->dev, "found mmio support but its too small: %u\n",
> +					res->data.fixed_memory32.address_length);
> +				return AE_OK;
> +			}
> +			smc->iomem_base_addr = res->data.fixed_memory32.address;
> +			smc->iomem_base_size = res->data.fixed_memory32.address_length;
> +			smc->is_mmio = true;
> +		}
> +		return AE_OK;
> +
> +	case ACPI_RESOURCE_TYPE_IRQ:
> +		ret = devm_request_irq(smc->dev, res->data.irq.interrupts[0],
> +					apple_smc_acpi_irq,
> +					0, "macsmc-acpi", smc);

Align to (

> +		if (ret < 0) {
> +			dev_dbg(smc->dev, "Unable to register interrupts\n");
> +			smc->has_interrupt = false;
> +			return AE_OK;
> +		}
> +		smc->has_interrupt = true;
> +		return AE_OK;
> +
> +	case ACPI_RESOURCE_TYPE_END_TAG:
> +		if (smc->has_port)
> +			return AE_OK;
> +		else
> +			return AE_NOT_FOUND;

Preferrably handle error first by reversing the logic.

Using else in such a construct unnecessary and should be dropped.

> +
> +	default:
> +		return AE_OK;
> +	}
> +}
> +
> +static void apple_smc_acpi_try_enable_mmio(struct apple_smc_acpi *smc)
> +{
> +	if (!smc->is_mmio)
> +		return;
> +
> +	u8 ldkn;

Wrong place.

> +
> +	smc->iomem_base = ioremap(smc->iomem_base_addr, smc->iomem_base_size);
> +	if (!smc->iomem_base)
> +		goto out;
> +
> +	if (ioread8(smc->iomem_base + SMC_MMIO_KEY_STATUS) == 0xFF) {
> +		dev_dbg(smc->dev, "mmio enable failed: init status is 0xff\n");
> +		goto out_iomem;
> +	}
> +
> +	if (apple_smc_acpi_mmio_read(smc, SMC_MSG_READ_KEY, SMC_KEY(LDKN), &ldkn, 1)) {

sizeof(ldkn) ?

> +		dev_dbg(smc->dev, "mmio enable failed: ldkn read failed\n");
> +		goto out_iomem;
> +	}
> +
> +	if (ldkn < 2) {
> +		dev_dbg(smc->dev, "mmio enable failed: ldkn version less than 2\n");
> +		goto out_iomem;
> +	}
> +	return;
> +
> +out_iomem:
> +	iounmap(smc->iomem_base);
> +out:
> +	smc->is_mmio = false;
> +}
> +
> +static void apple_smc_acpi_try_enable_interrupts(struct apple_smc_acpi *smc)
> +{
> +	if (!smc->has_interrupt)
> +		return;
> +
> +	const u8 enable = 1;
> +	int ret;

These are in wrong place.

> +
> +	if (smc->is_mmio)
> +		ret = apple_smc_acpi_mmio_write(smc, SMC_KEY(NTOK), &enable, 1);
> +	else
> +		ret = apple_smc_acpi_port_write(smc, SMC_KEY(NTOK), &enable, 1);
> +
> +	if (ret < 0) {
> +		dev_dbg(smc->dev, "Unable to enable interrupts\n");
> +		smc->interrupt_enabled = 0;
> +		return;
> +	}
> +
> +	smc->interrupt_enabled = 1;
> +}
> +
> +static int apple_smc_acpi_read(void *cookie, smc_key key, void *buf, size_t size)
> +{
> +	struct apple_smc_acpi *smc = cookie;
> +	int ret;
> +
> +	if (smc->is_mmio)
> +		ret = apple_smc_acpi_mmio_read(smc, SMC_MSG_READ_KEY,
> +			key, buf, size);
> +	else
> +		ret = apple_smc_acpi_port_read(smc, SMC_MSG_READ_KEY,
> +			key, buf, size);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return size;
> +
> +}
> +
> +static int apple_smc_acpi_write(void *cookie, smc_key key, const void *buf, size_t size)
> +{
> +	struct apple_smc_acpi *smc = cookie;
> +	int ret;
> +
> +	if (smc->is_mmio)
> +		ret = apple_smc_acpi_mmio_write(smc, key, buf, size);
> +	else
> +		ret = apple_smc_acpi_port_write(smc, key, buf, size);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return size;
> +}
> +
> +static int apple_smc_acpi_get_key_by_index(void *cookie, int index, smc_key *key)
> +{
> +	struct apple_smc_acpi *smc = cookie;
> +
> +	if (smc->is_mmio)
> +		return apple_smc_acpi_mmio_read(smc, SMC_MSG_GET_KEY_BY_INDEX, (smc_key) index,
> +				key, 4);
> +	else
> +		return apple_smc_acpi_port_read(smc, SMC_MSG_GET_KEY_BY_INDEX, (smc_key) index,
> +				key, 4);
> +
> +}
> +
> +static int apple_smc_acpi_get_key_info(void *cookie, smc_key key,
> +		struct apple_smc_key_info *info)
> +{
> +	struct apple_smc_acpi *smc = cookie;
> +
> +	if (smc->is_mmio)
> +		return apple_smc_acpi_mmio_get_key_info(smc, key, info);
> +	else
> +		return apple_smc_acpi_port_get_key_info(smc, key, info);
> +
> +}
> +
> +static void apple_smc_acpi_notifications(void *cookie)
> +{
> +	const u8 buf = 0;
> +
> +	apple_smc_acpi_write(cookie, SMC_KEY(NTOK), &buf, 1);

sizeof()

> +}
> +
> +static const struct apple_smc_backend_ops apple_smc_acpi_be_ops = {
> +	.read = apple_smc_acpi_read,
> +	.write = apple_smc_acpi_write,
> +	.get_key_by_index = apple_smc_acpi_get_key_by_index,
> +	.get_key_info = apple_smc_acpi_get_key_info,
> +	.disable_notifications = apple_smc_acpi_notifications,
> +};
> +
> +static int apple_smc_acpi_probe(struct platform_device *pdev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	struct apple_smc_acpi *smc;
> +	acpi_status status;
> +
> +	smc = devm_kzalloc(&pdev->dev, sizeof(*smc), GFP_KERNEL);
> +	if (!smc)
> +		return -ENOMEM;
> +
> +	smc->dev = &pdev->dev;
> +	init_completion(&smc->cmd_done);
> +	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
> +				apple_smc_acpi_walk_resources, smc);
> +
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	apple_smc_acpi_try_enable_mmio(smc);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&smc->event_handlers);
> +	INIT_WORK(&smc->shutdown_work, apple_smc_acpi_shutdown_work);
> +	INIT_WORK(&smc->notifier_work, apple_smc_acpi_notifier_work);

Don't these need cancelling on remove?

> +	spin_lock_init(&smc->event_lock);
> +	INIT_KFIFO(smc->event_fifo);
> +	apple_smc_acpi_try_enable_interrupts(smc);
> +
> +	return apple_smc_probe(smc->dev, &apple_smc_acpi_be_ops, smc, &smc->event_handlers, true);
> +}
> +
> +static int apple_smc_acpi_resume(struct device *dev)
> +{
> +	struct apple_smc *smc = dev_get_drvdata(dev);
> +	struct apple_smc_acpi *smc_acpi = smc->be_cookie;
> +
> +	/* NTOK may be set to 0 on resume */
> +	if (smc_acpi->interrupt_enabled) {
> +		smc_acpi->interrupt_enabled = 0;
> +		apple_smc_acpi_try_enable_interrupts(smc_acpi);
> +	}
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops apple_smc_acpi_ops = {
> +	.resume = apple_smc_acpi_resume,
> +};
> +
> +static const struct acpi_device_id apple_smc_acpi_ids[] = {
> +	{"APP0001", 0},
> +	{"", 0},

{}

No comma on the terminator.

> +};
> +MODULE_DEVICE_TABLE(acpi, apple_smc_acpi_ids);
> +
> +static struct platform_driver apple_smc_acpi_driver = {
> +	.probe = apple_smc_acpi_probe,
> +	.driver = {
> +		.name = "macsmc-acpi",
> +		.acpi_match_table = apple_smc_acpi_ids,
> +		.pm = &apple_smc_acpi_ops,
> +	},
> +};
> +module_platform_driver(apple_smc_acpi_driver);
> +
> +MODULE_AUTHOR("Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>");
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_DESCRIPTION("Apple SMC ACPI backend");
> +MODULE_DEVICE_TABLE(acpi, apple_smc_acpi_ids);
> 

-- 
 i.

