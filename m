Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802BDC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A70218EA
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556053805;
	bh=sg0arl26xeUKyxgLumfxC03xyPBJ6kvEGQFo0y0CKFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qIfeUYssPZPasyHIp8UZKxe+QbkDnt/e20oII9+zaCNIBCEIeb/nqSRK5RFpo1858
	 sybKlLg51vrZ36QYaY+Xp3r4UWxb//y/P1671NakITuiHI/s3zkT+EDA/xzTTAqaOi
	 Zdz62v57tko+T9i0zOCyktmXTrtdjpzp1C3NJfCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfDWVJ7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:09:59 -0400
Received: from casper.infradead.org ([85.118.1.10]:38646 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWVJ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 17:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2wCa3nFyIHBkX+W7L08Ddl9/YQMFyOa83nnq8nn7FoI=; b=N2hDZE6qZ5seHNnDs2TmZ6DEwF
        sapUo2Ma+lbARcWApPNvphi0Kp+5CJ4vZ4obzBQhef/uJTpi7YWjwdZDKYPzLCxyF0y7vTZxxlj4T
        arPi4FZm1vFa39rVgoYEVK3U53KRUGszkCl18oY8DXYQTkHMdZJQ3K9FD393XK1mDuYPv8j8wAH+S
        OTRIlrp+do3u+T7UlcsCWUgYXea7GoExQ3u+fyGEyHEOJiuVNgKJ/jqh4Ou2ui3hPc4fZE+vZdU6U
        C06x/wrfk1xsJJD4X5jcUVCBhaHbpyWcGTX5IEhQtinPda1tvY8qZsMkqidbsWMb5xKIz3F/JH+1l
        PcbaCB0g==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ2fq-0003nY-Po; Tue, 23 Apr 2019 21:09:55 +0000
Date:   Tue, 23 Apr 2019 18:09:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 12/63] Documentation: ACPI: move i2c-muxes.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190423180948.326fd3d8@coco.lan>
In-Reply-To: <20190423162932.21428-13-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-13-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:41 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For the conversion itself:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/acpi/i2c-muxes.txt              | 58 ------------------
>  .../firmware-guide/acpi/i2c-muxes.rst         | 61 +++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |  3 +-
>  3 files changed, 63 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/acpi/i2c-muxes.txt
>  create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst
> 
> diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
> deleted file mode 100644
> index 9fcc4f0b885e..000000000000
> --- a/Documentation/acpi/i2c-muxes.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -ACPI I2C Muxes
> ---------------
> -
> -Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
> -Device () scope per mux channel.
> -
> -Consider this topology:
> -
> -+------+   +------+
> -| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
> -|      |   | 0x70 |--CH01--> i2c client B (0x50)
> -+------+   +------+
> -
> -which corresponds to the following ASL:
> -
> -Device (SMB1)
> -{
> -    Name (_HID, ...)
> -    Device (MUX0)
> -    {
> -        Name (_HID, ...)
> -        Name (_CRS, ResourceTemplate () {
> -            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> -                          AddressingMode7Bit, "^SMB1", 0x00,
> -                          ResourceConsumer,,)
> -        }
> -
> -        Device (CH00)
> -        {
> -            Name (_ADR, 0)
> -
> -            Device (CLIA)
> -            {
> -                Name (_HID, ...)
> -                Name (_CRS, ResourceTemplate () {
> -                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> -                                  AddressingMode7Bit, "^CH00", 0x00,
> -                                  ResourceConsumer,,)
> -                }
> -            }
> -        }
> -
> -        Device (CH01)
> -        {
> -            Name (_ADR, 1)
> -
> -            Device (CLIB)
> -            {
> -                Name (_HID, ...)
> -                Name (_CRS, ResourceTemplate () {
> -                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> -                                  AddressingMode7Bit, "^CH01", 0x00,
> -                                  ResourceConsumer,,)
> -                }
> -            }
> -        }
> -    }
> -}
> diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
> new file mode 100644
> index 000000000000..3a8997ccd7c4
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
> @@ -0,0 +1,61 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +ACPI I2C Muxes
> +==============
> +
> +Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
> +Device () scope per mux channel.
> +
> +Consider this topology::
> +
> +    +------+   +------+
> +    | SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
> +    |      |   | 0x70 |--CH01--> i2c client B (0x50)
> +    +------+   +------+
> +
> +which corresponds to the following ASL::
> +
> +    Device (SMB1)
> +    {
> +        Name (_HID, ...)
> +        Device (MUX0)
> +        {
> +            Name (_HID, ...)
> +            Name (_CRS, ResourceTemplate () {
> +                I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> +                            AddressingMode7Bit, "^SMB1", 0x00,
> +                            ResourceConsumer,,)
> +            }
> +
> +            Device (CH00)
> +            {
> +                Name (_ADR, 0)
> +
> +                Device (CLIA)
> +                {
> +                    Name (_HID, ...)
> +                    Name (_CRS, ResourceTemplate () {
> +                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> +                                    AddressingMode7Bit, "^CH00", 0x00,
> +                                    ResourceConsumer,,)
> +                    }
> +                }
> +            }
> +
> +            Device (CH01)
> +            {
> +                Name (_ADR, 1)
> +
> +                Device (CLIB)
> +                {
> +                    Name (_HID, ...)
> +                    Name (_CRS, ResourceTemplate () {
> +                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> +                                    AddressingMode7Bit, "^CH01", 0x00,
> +                                    ResourceConsumer,,)
> +                    }
> +                }
> +            }
> +        }
> +    }
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index d1d069b26bbc..1c89888f6ee8 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -12,4 +12,5 @@ ACPI Support
>     osi
>     method-customizing
>     DSD-properties-rules
> -   gpio-properties
> \ No newline at end of file
> +   gpio-properties
> +   i2c-muxes



Thanks,
Mauro
