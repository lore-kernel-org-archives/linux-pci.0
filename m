Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38742 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHTU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Feb 2018 14:20:26 -0500
Received: by mail-yw0-f194.google.com with SMTP id m84so3420052ywd.5
        for <linux-pci@vger.kernel.org>; Thu, 08 Feb 2018 11:20:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208053354.41725-1-aik@ozlabs.ru>
References: <20180208053354.41725-1-aik@ozlabs.ru>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 8 Feb 2018 13:20:04 -0600
Message-ID: <CAErSpo7S7vJTKBrxuzH-G0y-U2Z15jKpPJDZEEuhh7vAs0hjOA@mail.gmail.com>
Subject: Re: [PATCH kernel] powerpc/pci: Fix broken INTx configuration via OF
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@ozlabs.org>,
        Rob Herring <robh@kernel.org>,
        Alistair Popple <alistair@popple.id.au>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

The original commit was merged via PCI, and I think it's a good idea
to merge fixes to it the same way.  I'll try to merge this in time for
v4.16-rc1.

On Wed, Feb 7, 2018 at 11:33 PM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> correctly states that of_irq_parse_and_map_pci() does the same thing as
> of_irq_parse_pci() does as it simply calls
> of_irq_parse_pci() and irq_create_of_mapping().
>
> However of_irq_parse_and_map_pci() not only returns 0 for success and
> negative value for an error but also a positive virq value from
> irq_create_of_mapping() which the mentioned commit ignores and
> INTx config fails.
>
> This fixes the of_irq_parse_and_map_pci() return value handling.
>
> Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> Found it on POWER9 + powernv system - almost all devices suddenly lost
> INTx support.
> ---
>  arch/powerpc/kernel/pci-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index ae2ede4..acbb44f2 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -370,7 +370,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>         memset(&oirq, 0xff, sizeof(oirq));
>  #endif
>         /* Try to get a mapping from the device-tree */
> -       if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
> +       virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
> +       if (virq <= 0) {
>                 u8 line, pin;
>
>                 /* If that fails, lets fallback to what is in the config
> --
> 2.11.0
>
