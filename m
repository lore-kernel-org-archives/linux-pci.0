Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55900 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbcF2Ozx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2016 10:55:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/22] sh: Add PCI host bridge driver for SH7751
Date: Wed, 29 Jun 2016 16:57:50 +0200
Message-ID: <4273068.i3RgB4Ufiy@wuerfel>
In-Reply-To: <1467207667-15768-13-git-send-email-ysato@users.sourceforge.jp>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp> <1467207667-15768-13-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 29, 2016 10:40:57 PM CEST Yoshinori Sato wrote:
> +               interrupt-map = <0x0000 0 1 &cpldintc 0 0>,
> +                                0x0800 0 1 &cpldintc 1 0>,
> +                                0x1000 0 1 &cpldintc 2 0>,
> +                                0x1800 0 1 &cpldintc 3 0>,
> +                                0x1800 0 2 &cpldintc 0 0>;

I just noticed the typo: you have more closing '>' than opening '<'
here, so this is not valid syntax.

> +
> +static __refdata struct platform_driver sh7751_pci_driver = {
> +       .driver = {
> +               .name = "sh7751-pci",
> +               .of_match_table = sh7751_pci_of_match,
> +       },
> +       .probe = sh7751_pci_probe,
> +};
> +builtin_platform_driver(sh7751_pci_driver);

I think you need to add '.suppress_bind_attrs = true' to prevent
the device to be unbound and rebound through sysfs, otherwise
the __init annotation on the probe function is wrong.

Everything else looks fine to me now.

	Arnd

