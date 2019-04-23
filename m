Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E360DC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A410217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556052938;
	bh=pyg/k++Z3t1uNl14Aj7zUq4i8AGk1IV/U3vqWiTUT1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ugyoQb2Vc0ZjcW3HyKfdx/nce7rqXKkN8P/T72OfUWJlgmZKtPCoSjDwGwhff2uDS
	 rQjTdlw2WybqRnY+uVx7d0S8lF7NVSOgCw3MTDR+N9NsNHo2FtshqYUHP1K3nbcW0e
	 5tr7zNNfegDr8Imz8EPIl6HWFvOTTgDH5TaDM97I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfDWUz0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:55:26 -0400
Received: from casper.infradead.org ([85.118.1.10]:37178 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfDWUzZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 16:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CVBYmm1hEOoJEoYntKDMh59UohbZkOJFVmFCMBSQUIY=; b=F2nlZrpHGJ3l6sKpqRhIDy5oZ5
        AFT2I7WZl+ftQB0ygbcoEptcYoPA4KSdUDO5aK4KXh116LX1QxLzWMLem03p3UiVNMsqbP9hDQHEB
        h9tS/Q70O6l9O6aYTVsS9+AWWggO/mhNl6qVXIDXFPLg2TmVZc07Q/LHKNQwHKKeendN1R2F+tGji
        ImltfVMR+C8yS9jWgCnL/6m1MGYXKtxhTe1Cxg05TJimsDJDzVSf9xDqNJCJBZoszyG+vjsM/jK+u
        qiDK/bsxqtMLovArjcWZA3XooneeNQB0LCoxOz0RQezElvzxDvstCueyrH5uNnqbzT8yM5t6+KgOY
        +pYxnt4g==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ2Rl-00037Q-7r; Tue, 23 Apr 2019 20:55:21 +0000
Date:   Tue, 23 Apr 2019 17:55:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 08/63] Documentation: ACPI: move gpio-properties.txt
 to firmware-guide/acpi and convert to reST
Message-ID: <20190423175515.58e78c0b@coco.lan>
In-Reply-To: <20190423162932.21428-9-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-9-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:37 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../acpi/gpio-properties.rst}                 | 78 +++++++++++--------
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 46 insertions(+), 35 deletions(-)
>  rename Documentation/{acpi/gpio-properties.txt =3D> firmware-guide/acpi/=
gpio-properties.rst} (81%)
>=20
> diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/firmw=
are-guide/acpi/gpio-properties.rst
> similarity index 81%
> rename from Documentation/acpi/gpio-properties.txt
> rename to Documentation/firmware-guide/acpi/gpio-properties.rst
> index 88c65cb5bf0a..89c636963544 100644
> --- a/Documentation/acpi/gpio-properties.txt
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -1,5 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  _DSD Device Properties Related to GPIO
> ---------------------------------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  With the release of ACPI 5.1, the _DSD configuration object finally
>  allows names to be given to GPIOs (and other things as well) returned
> @@ -8,7 +11,7 @@ the corresponding GPIO, which is pretty error prone (it =
depends on
>  the _CRS output ordering, for example).
> =20
>  With _DSD we can now query GPIOs using a name instead of an integer
> -index, like the ASL example below shows:
> +index, like the ASL example below shows::
> =20
>    // Bluetooth device with reset and shutdown GPIOs
>    Device (BTH)
> @@ -34,15 +37,19 @@ index, like the ASL example below shows:
>        })
>    }
> =20
> -The format of the supported GPIO property is:
> +The format of the supported GPIO property is::
> =20
>    Package () { "name", Package () { ref, index, pin, active_low }}
> =20
> -  ref - The device that has _CRS containing GpioIo()/GpioInt() resources,
> -        typically this is the device itself (BTH in our case).
> -  index - Index of the GpioIo()/GpioInt() resource in _CRS starting from=
 zero.
> -  pin - Pin in the GpioIo()/GpioInt() resource. Typically this is zero.
> -  active_low - If 1 the GPIO is marked as active_low.
> +ref
> +  The device that has _CRS containing GpioIo()/GpioInt() resources,
> +  typically this is the device itself (BTH in our case).
> +index
> +  Index of the GpioIo()/GpioInt() resource in _CRS starting from zero.
> +pin
> +  Pin in the GpioIo()/GpioInt() resource. Typically this is zero.
> +active_low
> +  If 1 the GPIO is marked as active_low.
> =20
>  Since ACPI GpioIo() resource does not have a field saying whether it is
>  active low or high, the "active_low" argument can be used here.  Setting
> @@ -55,7 +62,7 @@ It is possible to leave holes in the array of GPIOs. Th=
is is useful in
>  cases like with SPI host controllers where some chip selects may be
>  implemented as GPIOs and some as native signals. For example a SPI host
>  controller can have chip selects 0 and 2 implemented as GPIOs and 1 as
> -native:
> +native::
> =20
>    Package () {
>        "cs-gpios",
> @@ -67,7 +74,7 @@ native:
>    }
> =20
>  Other supported properties
> ---------------------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> =20
>  Following Device Tree compatible device properties are also supported by
>  _DSD device properties for GPIO controllers:
> @@ -78,7 +85,7 @@ _DSD device properties for GPIO controllers:
>  - input
>  - line-name
> =20
> -Example:
> +Example::
> =20
>    Name (_DSD, Package () {
>        // _DSD Hierarchical Properties Extension UUID
> @@ -100,7 +107,7 @@ Example:
> =20
>  - gpio-line-names
> =20
> -Example:
> +Example::
> =20
>    Package () {
>        "gpio-line-names",
> @@ -114,7 +121,7 @@ See Documentation/devicetree/bindings/gpio/gpio.txt f=
or more information
>  about these properties.
> =20
>  ACPI GPIO Mappings Provided by Drivers
> ---------------------------------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  There are systems in which the ACPI tables do not contain _DSD but provi=
de _CRS
>  with GpioIo()/GpioInt() resources and device drivers still need to work =
with
> @@ -139,16 +146,16 @@ line in that resource starting from zero, and the a=
ctive-low flag for that line,
>  respectively, in analogy with the _DSD GPIO property format specified ab=
ove.
> =20
>  For the example Bluetooth device discussed previously the data structure=
s in
> -question would look like this:
> +question would look like this::
> =20
> -static const struct acpi_gpio_params reset_gpio =3D { 1, 1, false };
> -static const struct acpi_gpio_params shutdown_gpio =3D { 0, 0, false };
> +  static const struct acpi_gpio_params reset_gpio =3D { 1, 1, false };
> +  static const struct acpi_gpio_params shutdown_gpio =3D { 0, 0, false };
> =20
> -static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] =3D {
> -  { "reset-gpios", &reset_gpio, 1 },
> -  { "shutdown-gpios", &shutdown_gpio, 1 },
> -  { },
> -};
> +  static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] =3D {
> +    { "reset-gpios", &reset_gpio, 1 },
> +    { "shutdown-gpios", &shutdown_gpio, 1 },
> +    { },
> +  };
> =20
>  Next, the mapping table needs to be passed as the second argument to
>  acpi_dev_add_driver_gpios() that will register it with the ACPI device o=
bject
> @@ -158,12 +165,12 @@ calling acpi_dev_remove_driver_gpios() on the ACPI =
device object where that
>  table was previously registered.
> =20
>  Using the _CRS fallback
> ------------------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  If a device does not have _DSD or the driver does not create ACPI GPIO
>  mapping, the Linux GPIO framework refuses to return any GPIOs. This is
>  because the driver does not know what it actually gets. For example if we
> -have a device like below:
> +have a device like below::
> =20
>    Device (BTH)
>    {
> @@ -177,7 +184,7 @@ have a device like below:
>        })
>    }
> =20
> -The driver might expect to get the right GPIO when it does:
> +The driver might expect to get the right GPIO when it does:=EF=BC=9A

Hmm... there is a small typo here:

	": :" -> "::"

For the conversion itself, after correcting the above typo:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>



> =20
>    desc =3D gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> =20
> @@ -193,22 +200,25 @@ the ACPI GPIO mapping tables are hardly linked to A=
CPI ID and certain
>  objects, as listed in the above chapter, of the device in question.
> =20
>  Getting GPIO descriptor
> ------------------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +There are two main approaches to get GPIO resource from ACPI::
> =20
> -There are two main approaches to get GPIO resource from ACPI:
> -	desc =3D gpiod_get(dev, connection_id, flags);
> -	desc =3D gpiod_get_index(dev, connection_id, index, flags);
> +  desc =3D gpiod_get(dev, connection_id, flags);
> +  desc =3D gpiod_get_index(dev, connection_id, index, flags);
> =20
>  We may consider two different cases here, i.e. when connection ID is
>  provided and otherwise.
> =20
> -Case 1:
> -	desc =3D gpiod_get(dev, "non-null-connection-id", flags);
> -	desc =3D gpiod_get_index(dev, "non-null-connection-id", index, flags);
> +Case 1::
> +
> +  desc =3D gpiod_get(dev, "non-null-connection-id", flags);
> +  desc =3D gpiod_get_index(dev, "non-null-connection-id", index, flags);
> +
> +Case 2::
> =20
> -Case 2:
> -	desc =3D gpiod_get(dev, NULL, flags);
> -	desc =3D gpiod_get_index(dev, NULL, index, flags);
> +  desc =3D gpiod_get(dev, NULL, flags);
> +  desc =3D gpiod_get_index(dev, NULL, index, flags);
> =20
>  Case 1 assumes that corresponding ACPI device description must have
>  defined device properties and will prevent to getting any GPIO resources
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/=
firmware-guide/acpi/index.rst
> index 0e05b843521c..61d67763851b 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -11,3 +11,4 @@ ACPI Support
>     enumeration
>     osi
>     DSD-properties-rules
> +   gpio-properties
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09f43f1bdd15..87f930bf32ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6593,7 +6593,7 @@ M:	Andy Shevchenko <andriy.shevchenko@linux.intel.c=
om>
>  L:	linux-gpio@vger.kernel.org
>  L:	linux-acpi@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/acpi/gpio-properties.txt
> +F:	Documentation/firmware-guide/acpi/gpio-properties.rst
>  F:	drivers/gpio/gpiolib-acpi.c
> =20
>  GPIO IR Transmitter



Thanks,
Mauro
