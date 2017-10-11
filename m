Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:56714 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbdJKTEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2017 15:04:39 -0400
Received: by mail-io0-f173.google.com with SMTP id m81so2879240ioi.13
        for <linux-pci@vger.kernel.org>; Wed, 11 Oct 2017 12:04:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171011140224.3770968-1-arnd@arndb.de>
References: <20171011140224.3770968-1-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Oct 2017 21:04:38 +0200
Message-ID: <CACRpkdbv1ok6U-xOtH0t5esJ_SD0Sn_JDpxmZg6XViargOM99g@mail.gmail.com>
Subject: Re: [PATCH] PCI: v3-semi: print resources using %pR format string
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 4:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> A resource_size_t can be 32 or 64 bit on arm32, causing a number
> of warnings for incorrect format strings:
>
> In file included from include/linux/printk.h:327:0,
>                  from include/linux/kernel.h:13,
>                  from include/linux/interrupt.h:5,
>                  from drivers/pci/host/pci-v3-semi.c:19:
> drivers/pci/host/pci-v3-semi.c: In function 'v3_pci_setup_resource':
> drivers/pci/host/pci-v3-semi.c:536:4: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'phys_addr_t {aka long long unsigned int}' [-Werror=format=]
>     "I/O window start %08x, bus addr %08x, size %08x\n",
> drivers/pci/host/pci-v3-semi.c:536:4: error: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]
>
> The best way to print this instead is to pass the resource itself
> to printk as a pointerm, using the special '%pR' format string
> for pretty-printing the range.
>
> For the bus address, we use %pap, respectively.
>
> Fixes: 132d10e24ff3 ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ah this again.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sorry about it, is it that checkpatch doesn't warn for this?

Yours,
Linus Walleij
