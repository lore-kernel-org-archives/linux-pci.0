Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265842;
	b=myfn6J/K+SvkRjhhW6LDeZOFryNjiCINGhh04QcRZdjXBWMno1a5YNWX7w2TqY9cLqXB
	 QUf5y2YXftvMPhU+c43JqAjv+9czlBX4gqLXfmbTjQCX0+tm+QL2LI+acumdbUd+SxXuN
	 T4f/ymJjS4/Vi36VH71IOFpKPc24/EqYxltPpEPyxEa3GmlmRthAqp2LsXUOUNbMXCKnC
	 2PCSeXuIFLemNKPBVaDdy3l05i0km/4CaeOWIXRbY1y1tAi175SCQYDBHHMkSQLVCBkLF
	 V8tN4P120Wml18BPEz3UhIVNTknW881HbJAUBH4IPPpSUsxoPzaH4iSoHX3w+Xh6WnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1miR7mt69CvJakDOB4YhCdAPHXhSS8rfhOZeSW+3MCs=;
	b=OaDDc0OgYiw5AqXGjZa08mwRsN0kBq9COOeQffNgXiyymQiXqJcVO6pXpwtdDex546lQ
	 oFQXzHqH3KxMg/s+9cle+Me4iNn+LBcN+areNKO+a5FJ+Keyxoq8QcPUCFWGYlbOLxEdt
	 f4ofIoJuw8QdAzdAAv7oIkXmwODZ3DNFV7c75WwnxsIaIbBdDeLkyxHEU0XWp5Y+hjkVq
	 Ufq57fggAuq5UD+s5yAeyhYsPdhuoxF4WNLhOs0jEVvxwBaL9T9jCwoaotwsWDtGntOhm
	 NRLjO5wgmTXdtiRMpXmXGbHGteL++ic3LTDMj+nbZbyQEL40hr72UvyiYRShml/0srA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4rMnDmq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED464606A31A;
	Thu, 29 Oct 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4rMnDmq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970E51F01828;
	Thu, 29 Oct 2026 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265841;
	bh=1miR7mt69CvJakDOB4YhCdAPHXhSS8rfhOZeSW+3MCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C4rMnDmqzNxLY7RZJwohftIwqWs6dR9O0lgbvRk8cdqLcIYQyoNCPrGSRNjeY9Wh/
	 nquULI4c+84m7bxot2uK7MLDtm0407Aj+0YwaP/z+a9V/M42kLZfWfjEM0bL/Yd4Qw
	 f+d8pYPSV++T0Wuk7Ix0V/ppYJMi3aWvdRLuAH6BdoF6Vl7a0KV+zqN0LyRJmTv3Ou
	 BUrgdijpMPgnLNaF7SEf0ocadCTrgu/StL1DR7uX3Cx0Axveya0WldMfeZQZSkTPWl
	 DX7R9+RDjS0JvqjAuc2jj/LvKkjQ2McqOP05FR8qzbT8Nbv4uE+3S2OG5stGG5AUOt
	 veoATHyu5o87A==
Message-ID: <sashiko-outbox-189032@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/14] platform/x86: add backend for macsmc in intel
 macs
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
In-Reply-To: <20261029085504.3547-3-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-3-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:23:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] platform/x86: macsmc-acpi: uncanceled work on teardown causes =
use-after-free
- [High] platform/x86: macsmc-acpi: premature IRQ registration before init =
in probe
- [High] platform/x86: macsmc-acpi: off-by-one MMIO offsets in get_key_info=
()
- [Medium] platform/x86: macsmc-acpi: MMIO mapping from ioremap() leaked on=
 teardown
- [Medium] platform/x86: macsmc-acpi: broken status check in apple_smc_acpi=
_irq()
- [Medium] platform/x86: macsmc-acpi: unlocked SMC write in apple_smc_acpi_=
resume()
- [Medium] platform/x86: macsmc-acpi: return -EIO instead of negated SMC st=
atus byte
- [Medium] platform/x86: macsmc-acpi: broken SENSORS_APPLESMC exclusion and=
 I/O claim
- [Low] platform/x86: macsmc-acpi: duplicate MODULE_DEVICE_TABLE() breaks m=
odule build
- [Low] platform/x86: macsmc-acpi: wrong %lX format specifier for size_t len
--

commit b68788a4e706e4d383f7127b7089a3bd694321c8
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/x86: add backend for macsmc in intel macs

This commit adds an ACPI backend driver (macsmc-acpi) for the Apple System
Management Controller on Intel Macs, supporting both I/O port and MMIO
access as well as interrupt-driven command completion and event handling.

> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 9ce384e0475ea..ce21277407fca 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -202,6 +202,16 @@ config ADV_SWBUTTON
>  	  To compile this driver as a module, choose M here. The module will
>  	  be called adv_swbutton.
> =20
> +config MACSMC_ACPI
> +	tristate "Apple SMC (System Management Controller) ACPI Backend"
> +	depends on MFD_MACSMC_CORE && ACPI && !SENSORS_APPLESMC

[Severity: Medium]
Because SENSORS_APPLESMC is a tristate symbol in drivers/hwmon/Kconfig,
!SENSORS_APPLESMC evaluates to m when CONFIG_SENSORS_APPLESMC=3Dm, which
allows both CONFIG_SENSORS_APPLESMC=3Dm and CONFIG_MACSMC_ACPI=3Dm to be bu=
ilt
in the same configuration.

When both modules are present on an Intel Mac, udev can auto-load both
applesmc (via DMI modalias) and macsmc-acpi (via the APP0001 ACPI
modalias). Because apple_smc_acpi_walk_resources() and
apple_smc_acpi_probe() in drivers/platform/x86/macsmc-acpi.c record
smc->port_base without reserving the I/O port range via
devm_request_region(), applesmc_init()'s request_region(0x300, 32,
"applesmc") will not detect a conflict, allowing both drivers to access the
SMC ports concurrently without shared locking.

Should this dependency be SENSORS_APPLESMC=3Dn, and should macsmc-acpi also
reserve its I/O port and MMIO regions via devm_request_region() and
devm_request_mem_region()?

[ ... ]

> diff --git a/drivers/platform/x86/macsmc-acpi.c b/drivers/platform/x86/ma=
csmc-acpi.c
> new file mode 100644
> index 0000000000000..a06ec921ac320
> --- /dev/null
> +++ b/drivers/platform/x86/macsmc-acpi.c

[ ... ]

> +static int apple_smc_acpi_port_read(struct apple_smc_acpi *smc, u8 cmd, =
smc_key key,
> +				void *buffer, size_t len)
> +{
> +	int ret;
> +
> +	ret =3D apple_smc_acpi_port_valid(smc);
> +	if (ret)
> +		return ret;
> +
> +	if (apple_smc_acpi_port_write_cmd(smc, cmd) || apple_smc_acpi_port_writ=
e_key(smc, key)) {
> +		dev_dbg(smc->dev, "port/read: read argument failed, key: 0x%X, cmd: 0x=
%X\n",
> +				key, cmd);
> +		return -EIO;
> +	}
> +
> +	if (apple_smc_acpi_port_write_byte(smc, len)) {
> +		dev_dbg(smc->dev, "port/read: read len failed, key: 0x%X, len: 0x%lX\n=
", key, len);
> +		return -EIO;
> +	}

[ ... ]

> +static int apple_smc_acpi_port_write(struct apple_smc_acpi *smc, smc_key=
 key, const void *buffer,
> +		size_t len)
> +{
> +	int ret;
> +
> +	ret =3D apple_smc_acpi_port_valid(smc);
> +	if (ret)
> +		return ret;
> +
> +	if (apple_smc_acpi_port_write_cmd(smc, SMC_MSG_WRITE_KEY) ||
> +			apple_smc_acpi_port_write_key(smc, key)) {
> +		dev_dbg(smc->dev, "port/write: write argument failed, key: 0x%X\n", ke=
y);
> +		return -EIO;
> +	}
> +
> +	if (apple_smc_acpi_port_write_byte(smc, len)) {
> +		dev_dbg(smc->dev, "port/write: write len failed, key: 0x%X, len: 0x%lX=
\n",
> +				key, len);
> +		return -EIO;
> +	}

[Severity: Low]
In both apple_smc_acpi_port_read() and apple_smc_acpi_port_write(), len has
type size_t, which is unsigned int on 32-bit x86 (CONFIG_X86_32). Will
formatting len with 0x%lX instead of 0x%zX trigger a -Wformat warning on
32-bit builds?

[ ... ]

> +static int apple_smc_acpi_mmio_read(struct apple_smc_acpi *smc, u8 cmd, =
smc_key key,
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
> +	ret =3D ioread8(smc->iomem_base + SMC_MMIO_KEY_CMD);
> +	if (ret) {
> +		dev_dbg(smc->dev, "mmio/read: read failed, ret: 0x%X, key: 0x%X\n", re=
t, key);
> +		return -ret;
> +	}
> +
> +	memcpy_fromio(buffer, smc->iomem_base + SMC_MMIO_KEY_DATA, len);
> +	return 0;
> +}
> +
> +static int apple_smc_acpi_mmio_write(struct apple_smc_acpi *smc, smc_key=
 key, const void *buffer,
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
> +	ret =3D ioread8(smc->iomem_base + SMC_MMIO_KEY_CMD);
> +	if (ret) {
> +		dev_dbg(smc->dev, "mmio/write: write failed, ret: 0x%X, key: 0x%X\n", =
ret, key);
> +		return -ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int apple_smc_acpi_mmio_get_key_info(struct apple_smc_acpi *smc, =
smc_key key,
> +					struct apple_smc_key_info *info)
> +{
> +	u8 ret;
> +
> +	reinit_completion(&smc->cmd_done);
> +	apple_smc_acpi_mmio_clear(smc);
> +	iowrite32be(key, smc->iomem_base + SMC_MMIO_KEY_NAME);
> +	iowrite8(0, smc->iomem_base + SMC_MMIO_KEY_SMC_ID);
> +	iowrite8(SMC_MSG_GET_KEY_INFO, smc->iomem_base + SMC_MMIO_KEY_CMD);
> +
> +	if (apple_smc_acpi_mmio_wait(smc))
> +		return -EIO;
> +
> +	ret =3D ioread8(smc->iomem_base + SMC_MMIO_KEY_CMD);
> +	if (ret) {
> +		dev_dbg(smc->dev, "mmio/get_key_info failed, ret: 0x%X, key: 0x%X\n", =
ret, key);
> +		return -ret;
> +	}

[Severity: Medium]
In apple_smc_acpi_mmio_read(), apple_smc_acpi_mmio_write(), and
apple_smc_acpi_mmio_get_key_info(), ret is the 8-bit hardware SMC status
code read from SMC_MMIO_KEY_CMD (for example, 0x84 for key not found).

Returning -ret propagates a negated hardware status code rather than a
standard Linux errno value to callers of apple_smc_read(),
apple_smc_write(), apple_smc_get_key_by_index(), and
apple_smc_get_key_info(). Should these paths return -EIO on non-zero SMC
status, matching the PIO helpers and apple_smc_rtkit_cmd_locked()?

> +
> +
> +	if (!info)
> +		return 0;
> +	info->type_code =3D cpu_to_be32(ioread32(smc->iomem_base + SMC_MMIO_KEY=
_DATA));
> +	info->size =3D ioread8(smc->iomem_base + 5);
> +	info->flags =3D ioread8(smc->iomem_base + 6);
> +
> +	return 0;
> +}

[Severity: High]
In apple_smc_acpi_mmio_get_key_info(), ioread32(smc->iomem_base +
SMC_MMIO_KEY_DATA) reads the 4-byte type_code from offsets 0 through 3.

Doesn't reading info->size from smc->iomem_base + 5 and info->flags from
smc->iomem_base + 6 skip offset 4, placing the flags byte into info->size
and an uninitialized byte from offset 6 into info->flags? Shouldn't these
reads use offsets 4 and 5?

[ ... ]

> +static irqreturn_t apple_smc_acpi_irq(int irq, void *data)
> +{
> +	struct apple_smc_acpi *smc =3D data;
> +	uint8_t status =3D 0, int_id =3D 0;
> +	unsigned long flags;
> +
> +	if (smc->is_mmio) {
> +		status =3D ioread8(smc->iomem_base + SMC_MMIO_KEY_INTERRUPT_STATUS);
> +		if ((status & 0x20) =3D=3D 0 && status !=3D 0)
> +			return IRQ_HANDLED;
> +	} else {
> +		status =3D inb(smc->port_base + SMC_IO_CMD_PORT);
> +		if ((status & 0x40) =3D=3D 0 && status !=3D 0)
> +			return IRQ_HANDLED;
> +	}
> +
> +	int_id =3D inb(smc->port_base + 0x1F);

[Severity: Medium]
In apple_smc_acpi_irq(), if status reads as 0 (no interrupt pending), the
condition ((status & 0x20) =3D=3D 0 && status !=3D 0) evaluates to false and
falls through to read inb(smc->port_base + 0x1F). Also, when the interrupt
status bit is not set, returning IRQ_HANDLED reports an unhandled interrupt
as handled, and in PIO mode checking (status & 0x40) =3D=3D 0 can drop comm=
and
completion interrupts where bit 0x40 is not set.

Should apple_smc_acpi_irq() return IRQ_NONE when no SMC interrupt is
pending?

[ ... ]

> +static acpi_status apple_smc_acpi_walk_resources(struct acpi_resource *r=
es,
> +	void *data)
> +{
> +	struct apple_smc_acpi *smc =3D data;
> +	int ret =3D 0;
> +
> +	switch (res->type) {

[ ... ]

> +	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> +		if (!smc->is_mmio) {
> +			if (res->data.fixed_memory32.address_length < SMC_MMIO_MIN_SIZE) {
> +				dev_dbg(smc->dev, "found mmio support but its too small: %u\n",
> +					res->data.fixed_memory32.address_length);
> +				return AE_OK;
> +			}
> +			smc->iomem_base_addr =3D res->data.fixed_memory32.address;
> +			smc->iomem_base_size =3D res->data.fixed_memory32.address_length;
> +			smc->is_mmio =3D true;
> +		}
> +		return AE_OK;
> +
> +	case ACPI_RESOURCE_TYPE_IRQ:
> +		ret =3D devm_request_irq(smc->dev, res->data.irq.interrupts[0],
> +					apple_smc_acpi_irq,
> +					0, "macsmc-acpi", smc);
> +		if (ret < 0) {
> +			dev_dbg(smc->dev, "Unable to register interrupts\n");
> +			smc->has_interrupt =3D false;
> +			return AE_OK;
> +		}
> +		smc->has_interrupt =3D true;
> +		return AE_OK;

[Severity: High]
During apple_smc_acpi_probe() -> acpi_walk_resources() ->
apple_smc_acpi_walk_resources(), ACPI_RESOURCE_TYPE_FIXED_MEMORY32 sets
smc->is_mmio =3D true while smc->iomem_base is still NULL, and
ACPI_RESOURCE_TYPE_IRQ immediately registers and enables
apple_smc_acpi_irq() via devm_request_irq().

At that point in apple_smc_acpi_probe(), apple_smc_acpi_try_enable_mmio()
has not yet mapped smc->iomem_base, and smc->event_handlers,
smc->shutdown_work, smc->notifier_work, smc->event_lock, and
smc->event_fifo have not been initialized yet:

apple_smc_acpi_probe()
  acpi_walk_resources(..., apple_smc_acpi_walk_resources, smc)
    smc->is_mmio =3D true
    devm_request_irq(..., apple_smc_acpi_irq, ...)
  apple_smc_acpi_try_enable_mmio(smc)
  BLOCKING_INIT_NOTIFIER_HEAD(&smc->event_handlers)
  INIT_WORK(&smc->shutdown_work, ...)
  INIT_WORK(&smc->notifier_work, ...)
  spin_lock_init(&smc->event_lock)
  INIT_KFIFO(smc->event_fifo)

Similarly, if MMIO validation fails in apple_smc_acpi_try_enable_mmio(),
iounmap(smc->iomem_base) is called before smc->is_mmio is set to false.

If an interrupt fires during this window (for example, if NTOK was left
enabled across a warm reboot/module reload, or during the LDKN read in
apple_smc_acpi_try_enable_mmio()), won't apple_smc_acpi_irq() dereference a
NULL or unmapped smc->iomem_base and access uninitialized spinlock, kfifo,
and work_struct fields?

[ ... ]

> +static void apple_smc_acpi_try_enable_mmio(struct apple_smc_acpi *smc)
> +{
> +	if (!smc->is_mmio)
> +		return;
> +
> +	u8 ldkn;
> +
> +	smc->iomem_base =3D ioremap(smc->iomem_base_addr, smc->iomem_base_size);
> +	if (!smc->iomem_base)
> +		goto out;
> +
> +	if (ioread8(smc->iomem_base + SMC_MMIO_KEY_STATUS) =3D=3D 0xFF) {
> +		dev_dbg(smc->dev, "mmio enable failed: init status is 0xff\n");
> +		goto out_iomem;
> +	}
> +
> +	if (apple_smc_acpi_mmio_read(smc, SMC_MSG_READ_KEY, SMC_KEY(LDKN), &ldk=
n, 1)) {
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
> +	smc->is_mmio =3D false;
> +}

[Severity: Medium]
When apple_smc_acpi_try_enable_mmio() succeeds, smc->iomem_base remains
mapped with unmanaged ioremap(), and nothing calls iounmap() if
apple_smc_probe() subsequently fails or when the driver is unbound.

Does this leak the smc->iomem_base MMIO mapping on teardown, and should
devm_ioremap() (with devm_iounmap() on fallback) be used instead?

[ ... ]

> +static int apple_smc_acpi_probe(struct platform_device *pdev)
> +{
> +	struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
> +	struct apple_smc_acpi *smc;
> +	acpi_status status;
> +
> +	smc =3D devm_kzalloc(&pdev->dev, sizeof(*smc), GFP_KERNEL);
> +	if (!smc)
> +		return -ENOMEM;
> +
> +	smc->dev =3D &pdev->dev;
> +	init_completion(&smc->cmd_done);
> +	status =3D acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
> +				apple_smc_acpi_walk_resources, smc);
> +
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	apple_smc_acpi_try_enable_mmio(smc);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&smc->event_handlers);
> +	INIT_WORK(&smc->shutdown_work, apple_smc_acpi_shutdown_work);
> +	INIT_WORK(&smc->notifier_work, apple_smc_acpi_notifier_work);
> +	spin_lock_init(&smc->event_lock);
> +	INIT_KFIFO(smc->event_fifo);
> +	apple_smc_acpi_try_enable_interrupts(smc);
> +
> +	return apple_smc_probe(smc->dev, &apple_smc_acpi_be_ops, smc, &smc->eve=
nt_handlers, true);
> +}

[Severity: Critical]
In apple_smc_acpi_probe(), smc->shutdown_work and smc->notifier_work are
initialized with INIT_WORK(), and apple_smc_acpi_irq() schedules them via
schedule_work(). However, neither work item is ever cancelled if
apple_smc_probe() fails or when the device is unbound (and if
apple_smc_probe() fails before registering apple_smc_disable_notifications,
NTOK remains enabled).

Once devres frees struct apple_smc_acpi on teardown, can a pending or
running apple_smc_acpi_notifier_work() access freed memory via
smc->event_lock, smc->event_fifo, and smc->event_handlers? Could
devm_work_autocancel() be used here, and should interrupts be disabled and
synchronized before cancelling work on teardown?

> +
> +static int apple_smc_acpi_resume(struct device *dev)
> +{
> +	struct apple_smc *smc =3D dev_get_drvdata(dev);
> +	struct apple_smc_acpi *smc_acpi =3D smc->be_cookie;
> +
> +	/* NTOK may be set to 0 on resume */
> +	if (smc_acpi->interrupt_enabled) {
> +		smc_acpi->interrupt_enabled =3D 0;
> +		apple_smc_acpi_try_enable_interrupts(smc_acpi);
> +	}
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops apple_smc_acpi_ops =3D {
> +	.resume =3D apple_smc_acpi_resume,
> +};

[Severity: Medium]
In apple_smc_acpi_resume(), apple_smc_acpi_try_enable_interrupts() writes
the NTOK key to the SMC hardware and updates smc_acpi->interrupt_enabled
without holding smc->mutex.

If a child device or worker performs an SMC transaction concurrently during
resume, can these unsynchronized accesses race on the MMIO/PIO registers
and smc_acpi->cmd_done? Also, should apple_smc_acpi_ops use
DEFINE_SIMPLE_DEV_PM_OPS() with pm_sleep_ptr() so hibernation restore and
CONFIG_PM_SLEEP=3Dn builds are handled properly?

> +
> +static const struct acpi_device_id apple_smc_acpi_ids[] =3D {
> +	{"APP0001", 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, apple_smc_acpi_ids);
> +
> +static struct platform_driver apple_smc_acpi_driver =3D {
> +	.probe =3D apple_smc_acpi_probe,
> +	.driver =3D {
> +		.name =3D "macsmc-acpi",
> +		.acpi_match_table =3D apple_smc_acpi_ids,
> +		.pm =3D &apple_smc_acpi_ops,
> +	},
> +};
> +module_platform_driver(apple_smc_acpi_driver);
> +
> +MODULE_AUTHOR("Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>");
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_DESCRIPTION("Apple SMC ACPI backend");
> +MODULE_DEVICE_TABLE(acpi, apple_smc_acpi_ids);

[Severity: Low]
MODULE_DEVICE_TABLE(acpi, apple_smc_acpi_ids) is invoked twice in
drivers/platform/x86/macsmc-acpi.c (and linux/module.h is not explicitly
included). When building with CONFIG_MACSMC_ACPI=3Dm, doesn't the duplicate
MODULE_DEVICE_TABLE() macro fail to compile due to redefining
__mod_device_table__kmod_macsmc_acpi__acpi__apple_smc_acpi_ids?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085504.3547=
-1-atharvatiwarilinuxdev@gmail.com?part=3D2
