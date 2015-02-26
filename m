Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:53984 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbbBZHlj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 02:41:39 -0500
Received: by mail-oi0-f53.google.com with SMTP id u20so7791090oif.12
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2015 23:41:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5150533.nuGgOOyLIn@wuerfel>
References: <5150533.nuGgOOyLIn@wuerfel>
Date: Thu, 26 Feb 2015 08:41:37 +0100
Message-ID: <CACRpkdbBsLQ_RSrDHBTZJVKoq33ySF9Eo4Bp9R=-Ak2ek-7GKA@mail.gmail.com>
Subject: Re: [PATCH] pci-versatile.c: Update for API change in list_for_each_entry()
From: Linus Walleij <linus.walleij@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Joachim Nilsson <troglobit@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 25, 2015 at 4:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> From: Joachim Nilsson <troglobit@gmail.com>
>
> In Linux 4.0-rc1 ARM Versatile PCI build fails to build due to what
> appears to be an API update.  This patch is a very simple correction,
> merely posted as a heads-up to the maintainers.  Hopefully a better
> fix can be forwarded to Linus.
>
> [arnd: the patch actually looks correct, so let's take this version]
>
> Signed-off-by: Joachim Nilsson <troglobit@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
> Joachim reported the bug, and I independently found the same problem.
> The patch he sent to the list did not apply for me for an unknown reason,
> but I fixed it up and forward it now to the right list of recipients.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
