Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38458 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968978AbdDSSmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2017 14:42:33 -0400
Received: by mail-wm0-f46.google.com with SMTP id r190so29949345wme.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Apr 2017 11:42:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170419175513.88138-1-arnd@arndb.de>
References: <20170419175513.88138-1-arnd@arndb.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Apr 2017 13:42:11 -0500
Message-ID: <CAErSpo4BrrOrGTyzsw+s4mn-RVGpoZbGpPc95MJ3aDF64SBY_w@mail.gmail.com>
Subject: Re: [PATCH] PCI: faraday: use %pap format string for printing resources
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 19, 2017 at 12:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> resource_size_t may be either 32-bit or 64-bit wide, so we have to use
> the special %pap format string to avoid warnings like:
>
> drivers/pci/host/pci-ftpci100.c: In function 'faraday_res_to_memcfg':
> drivers/pci/host/pci-ftpci100.c:174:586: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]
> drivers/pci/host/pci-ftpci100.c:174:586: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]
>
> This relies on resource_size_t and phys_addr_t being the same width,
> as other code already does.
>
> Fixes: 5c18f2b240bd ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, folded into the initial commit.

> ---
>  drivers/pci/host/pci-ftpci100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
> index 4ae5418a1aad..c0f29d1de341 100644
> --- a/drivers/pci/host/pci-ftpci100.c
> +++ b/drivers/pci/host/pci-ftpci100.c
> @@ -171,8 +171,8 @@ static int faraday_res_to_memcfg(resource_size_t mem_base,
>                 pr_warn("truncated PCI memory base\n");
>         /* Translate to bridge side address space */
>         outval |= (mem_base & FARADAY_PCI_MEMBASE_MASK);
> -       pr_debug("Translated pci base @%08x, size %08x to config %08x\n",
> -                mem_base, mem_size, outval);
> +       pr_debug("Translated pci base @%pap, size %pap to config %08x\n",
> +                &mem_base, &mem_size, outval);
>
>         *val = outval;
>         return 0;
> --
> 2.9.0
>
