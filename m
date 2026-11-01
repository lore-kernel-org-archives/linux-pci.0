Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793495270;
	b=sV+nKmmp4mfUUU9VheKr89SkE1FlZhZSw2ACT3S4jXUblh4XX32LKLnxOZ3XvglC17GH
	 gQ4ZL+oXAVT84ZAlvL63DpXzPE8vtpVQB+7LmBqM7+uAbrM2p5yG9nPxsgxxe99kgpCMb
	 WkMmUyT3aSLPyncoudO0PayJD/wna7GM6JC/bWopzKqLWs10L0MQnHBUrS4B0XagnCy2p
	 wWSbFWUWDmx2fYp0ABS4i1kD/VcSqU8gFmWfukTqTw599kLjiogcobhuBPXbQ06Ml1bzA
	 TyAixXulQ4dVdvO9ynKFvh5LBZoV9M938wSkPnLCdpFt+Wtfhv7wlA6d9ApsqR9YKcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793495270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=o0dKNKFP2TnkjHjwq1OngqcbhclebE6bDgXM6dq7QKU=;
	b=GRz/w0aoy0qF0RZFUBYZeUqAQZoMuOA9Vl8Uaj3osM+d+s3VOu+H9ryamds43U1rhq2C
	 1Bi5WBvmTOXRxDohD+QMNQJ5TlkaswkbE2P8S8BPjJl6uru19Z15uWAUdBodTtVbpI+dR
	 4ivIz+yxKVQ/D8+5MUAuNa8GQk0pDYdDKxb/N6wxFD2QmBLNKqtuQl3Q//ktm5iuSPEx1
	 8OG5rFpmkyt8EJ3hqexEJxGJUH+VLIP6ZwCOXiATSzydR4nqBQgkBDE3k1fj9uV99QP1/
	 Z0AKFjoInj7cwvAbIQKRoEa9vkTjZRAzCHF1OQv2MN7+qmF1NwnHA689xtIb3pn+MOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1eb1dRO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF086606A31A;
	Sun,  1 Nov 2026 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1eb1dRO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE9E1F000C1;
	Sun,  1 Nov 2026 01:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793495269;
	bh=o0dKNKFP2TnkjHjwq1OngqcbhclebE6bDgXM6dq7QKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a1eb1dROmAhVQ61MQlal6Ap7Wbtl+Ngz2TIMIAwEsgCwttIY4YtbfkeB4YLLcsjlZ
	 nz2xZEH1C/YJ9YaO/y6ogOD0fTzo/Me7AaL8H1e6qmsGqtN10cu2zlIWrgi/kBM+wB
	 MLMQ5Nu7I9HGgwHt0MM4z7x8pDENFn2pbc5+hHJXjTo72OrLTLBFDOSBdGX3dhDSSR
	 bBHJNI+ivrnkPZM/X8KAU/N3tBO5EDmY8B4PfVrayskaUDgvp1GxwKuytbBEbHXGe0
	 YH8p3wDfYo7OWUEof1MPQcH304m2+9ot0CEYIxjGL8lrPtQDY3oiB2v6/T7dtKSTT+
	 AiBAUdcvR+i4g==
Date: Sun, 1 Nov 2026 01:07:37 +0000
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
Subject: Re: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing
 applesmc
Message-ID: <20261101010737.203951cd@jic23-hlaptop>
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
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

On Thu, 29 Oct 2026 04:51:57 -0400
Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:

> applesmc is very old, and all of its code is lumped into one
> driver. Fan control, sensors, the light sensor, the motion
> sensor and the keyboard backlight in a single file
> with its own way of talking to the SMC. It is hard to extend
> and to support new machines.
> 
> This series adds Intel Mac support to the macsmc drivers that
> were written for Apple Silicon (the Asahi implementation).
> The SMC works the same way on both platforms, so we share a
> lot of code with Asahi. Only the way of talking to the SMC
> differs.
> 
> To make that work, patch 1 splits the macsmc driver into a
> common core and a backend. The existing RTKit code moves into
> its own backend. Patch 2 adds an ACPI backend for Intel Macs
> with I/O port, MMIO and interrupt support. After that, each
> function gets its own small driver using the standard kernel
> interfaces (hwmon, IIO, LEDs, power supply, RTC, watchdog),
> instead of one large driver doing everything.

Are we looking at ABI changes as a result of this? That
tends to happen with split ups of unified drivers and mapping
them to more standard kernel subsystems.

What is the plan to handle them if so?

Thanks,

Jonathan

> 
> On Intel Macs these drivers replace applesmc (hwmon, light
> sensor, motion sensor and keyboard backlight) and acpi-sbs
> (battery and adapter). They are mutually exclusive with the
> drivers they replace, so only one is used at a time.
> 
> This is an RFC to get early feedback on the design. The macsmc
> split and the Intel Mac backend touch fundamental parts, so I
> would rather change them now if maintainers ask. After that I
> will test the series on more macsand send it upstream as a
> proper series.
> 
> The series is organised as follows:
> 
>   1      Split macsmc into a core and backends
>   2      ACPI backend for Intel Macs
>   3-6    New drivers: watchdog, IIO light and accelerometer,
>          keyboard backlight LED
>   7-9    RTC support for T2 Macs, a T2 detection flag, and
>          disabling the broken ACPI RTCs
>   10-11  Power supply support, replacing acpi-sbs
>   12-13  hwmon support for Intel Macs
>   14     ioctl for userspace access to SMC keys
> 
> 
> Tested-on: MacBookPro16,1 , iMac20,1 , MacBookAir4,2 , MacBookPro12,1 ,
> MacBookPro15,1
> 
> NOTE: Almost all drivers have been tested except the motion sensor
> driver as i was not able to find any device that had one.
> 
> Atharva Tiwari (14):
>   treewide: Add backend for macsmc
>   platform/x86: add backend for macsmc in intel macs
>   watchdog: add driver for apple smc
>   iio/light: add new driver for macsmc
>   iio/accel: add driver for apple SMS
>   leds: add support for macsmc kbl
>   rtc: add support for x86 macs in macsmc-rtc
>   treewide: Add a flag to detect the Apple T2 chip
>   treewide: disable other rtc's in t2 macs
>   power/supply: add support for x86 macs in macsmc-power
>   acpi: disable battery and adapter for x86 apple machines
>   hwmon/macsmc: add more types
>   hwmon: add support for x86 macs in macsmc-hwmon
>   mfd/macsmc: add ioctl to access smc keys
> 
>  MAINTAINERS                                   |    2 +-
>  arch/x86/kernel/quirks.c                      |   37 +
>  drivers/acpi/acpi_tad.c                       |    4 +
>  drivers/acpi/sbs.c                            |   17 +-
>  drivers/acpi/x86/utils.c                      |    4 +
>  drivers/gpio/Kconfig                          |    2 +-
>  drivers/gpio/gpio-macsmc.c                    |   13 +-
>  drivers/hwmon/Kconfig                         |    7 +-
>  drivers/hwmon/macsmc-hwmon.c                  | 1126 ++++++++++++++++-
>  drivers/iio/accel/Kconfig                     |   10 +
>  drivers/iio/accel/Makefile                    |    1 +
>  drivers/iio/accel/macsmc-accel.c              |  248 ++++
>  drivers/iio/light/Kconfig                     |   11 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/macsmc-light.c              |  189 +++
>  drivers/leds/Kconfig                          |   11 +
>  drivers/leds/Makefile                         |    1 +
>  drivers/leds/leds-macsmc.c                    |   69 +
>  drivers/mfd/Kconfig                           |   15 +-
>  drivers/mfd/Makefile                          |    2 +-
>  drivers/mfd/macsmc-core.c                     |  362 ++++++
>  drivers/platform/x86/Kconfig                  |   10 +
>  drivers/platform/x86/Makefile                 |    1 +
>  drivers/platform/x86/macsmc-acpi.c            |  642 ++++++++++
>  drivers/power/reset/Kconfig                   |    2 +-
>  drivers/power/supply/Kconfig                  |    2 +-
>  drivers/power/supply/macsmc-power.c           |  751 ++++++++---
>  drivers/rtc/Kconfig                           |    2 +-
>  drivers/rtc/rtc-cmos.c                        |    4 +
>  drivers/rtc/rtc-macsmc.c                      |  126 +-
>  drivers/soc/apple/Kconfig                     |   14 +
>  drivers/soc/apple/Makefile                    |    2 +
>  .../macsmc.c => soc/apple/macsmc-rtkit.c}     |  185 ++-
>  drivers/watchdog/Kconfig                      |   11 +
>  drivers/watchdog/Makefile                     |    2 +-
>  drivers/watchdog/macsmc_wdt.c                 |  140 ++
>  include/linux/mfd/macsmc.h                    |  104 +-
>  include/linux/platform_data/x86/apple.h       |    5 +
>  .../platform_certs/keyring_handler.h          |    8 -
>  security/integrity/platform_certs/load_uefi.c |   38 +-
>  40 files changed, 3786 insertions(+), 395 deletions(-)
>  create mode 100644 drivers/iio/accel/macsmc-accel.c
>  create mode 100644 drivers/iio/light/macsmc-light.c
>  create mode 100644 drivers/leds/leds-macsmc.c
>  create mode 100644 drivers/mfd/macsmc-core.c
>  create mode 100644 drivers/platform/x86/macsmc-acpi.c
>  rename drivers/{mfd/macsmc.c => soc/apple/macsmc-rtkit.c} (70%)
>  create mode 100644 drivers/watchdog/macsmc_wdt.c
> 

