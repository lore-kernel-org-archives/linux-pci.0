Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42567 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbeGXMiB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2018 08:38:01 -0400
Received: by mail-yb0-f196.google.com with SMTP id c10-v6so1475328ybf.9
        for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2018 04:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180724093924.1752416-1-arnd@arndb.de>
In-Reply-To: <20180724093924.1752416-1-arnd@arndb.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Jul 2018 06:31:47 -0500
Message-ID: <CAErSpo4wWZGgxWwjLjds7qh9UmMpas4G7jR8UK8AdL8gbfz-rA@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix unused variable warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        james.puthukattukaran@oracle.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Anders]

On Tue, Jul 24, 2018 at 4:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The newly introduced function produces a warning without CONFIG_PCI_QUIRKS:
>
> drivers/pci/probe.c: In function 'pci_bus_read_dev_vendor_id':
> drivers/pci/probe.c:2221:18: error: unused variable 'bridge' [-Werror=unused-variable]
>
> Move the variable declaration into that #ifdef to avoid the warning.
>
> Fixes: ac5ea104a279 ("PCI: Workaround IDT switch ACS Source Validation erratum")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Fixed already with a patch from Anders Roxell
<anders.roxell@linaro.org>, thanks!

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1c581346c5b9..7a5323798312 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2218,9 +2218,9 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>                                 int timeout)
>  {
> +#ifdef CONFIG_PCI_QUIRKS
>         struct pci_dev *bridge = bus->self;
>
> -#ifdef CONFIG_PCI_QUIRKS
>         /*
>          * Certain IDT switches have an issue where they improperly trigger
>          * ACS Source Validation errors on completions for config reads.
> --
> 2.18.0
>
