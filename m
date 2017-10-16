Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:46048 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdJPJTZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2017 05:19:25 -0400
Received: by mail-it0-f52.google.com with SMTP id n195so401092itg.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Oct 2017 02:19:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <169eac7a-4dd1-f164-6342-9bac8b7dbf3a@sigmadesigns.com>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
 <1508018851-9272-4-git-send-email-festevam@gmail.com> <169eac7a-4dd1-f164-6342-9bac8b7dbf3a@sigmadesigns.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Oct 2017 11:19:24 +0200
Message-ID: <CACRpkdYG3CvjU8T2DUkxnH7tPb3S6Es_aEvkiyQ+5tX=CjLrpw@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: tango: Fix platform_get_irq() error handling
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Fabio Estevam <festevam@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Mason <slash.tmp@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 11:09 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:

> I don't think this patch is correct.
>
> AFAIU, on all but legacy platforms, when platform_get_irq() returns 0,
> it is to signal an error condition.
>
> Marc Z pointed out this discussion:
> http://yarchive.net/comp/linux/zero.html

Same comment as I had, more or less.

> I suppose it would be slightly nicer to write:
>
>         virq = platform_get_irq(pdev, 1);
>         if (virq <= 0)
>                 return virq ? virq : -ENODEV;

This looks good to me.

Yours,
Linus Walleij
