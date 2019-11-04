Return-Path: <SRS0=bcLC=Y4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3DCA9EA0
	for <linux-pci@archiver.kernel.org>; Mon,  4 Nov 2019 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7509E222C2
	for <linux-pci@archiver.kernel.org>; Mon,  4 Nov 2019 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572863557;
	bh=ScqUgBBmRpqzOBhrkXnuQEd1xbsl4ZRZh7AIASAi5bU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X8S4Nz4/RU0/KAsPuavpQ9zy3GuHyDYWHEKjxbDe2jCwbafdDj9re1lI9CBlGqbuk
	 sXHaGKngk03/cY74PwKTpjYedlpiXRZQzJ9xnw5sXsZ6iCWoo8KGF5l53xwANto5ks
	 nIeFkQA+yzB3fCZlJxLNls/1GYWeu50rjinuxzRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfKDKcd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:32:33 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45817 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfKDKcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 05:32:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id k2so13596386oij.12;
        Mon, 04 Nov 2019 02:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6lyDAj0tuP2cHmlqSgAsnFiMmf3nt5wMrq1nXuIoEc=;
        b=BuUjb8Rxz2vp5pk60DpXqq8QwZhHbvj0nieZIOFzX9mGQnbLRHLie7FYtTz5j6JsM6
         QEc5VSy5sHDY7lndLexjdNn6mIHpt1fR+wC5lYeScLAf8gWlsusYHrqYKBwY8p1zqv1b
         fXrko93hG2r/Zo4SB/FwsBk1nzGeLE0jy3f95cRHDxsWeYoPanYjfOoepWFHSilUBTT3
         kOxKElSe3O8/XalnMzFS/FjvuZP8oWRzBBxLDUwXpXItQ0h/hLA+b+MY9FLb2VmgUMEv
         Ngqtq6PDcRXj12M0lYgzr+1xB+NyihtcPOz7JDxROEnkJpMn0st1BQ5RW5qoQ920Z8hw
         XF4g==
X-Gm-Message-State: APjAAAVwYML/c7AJ5kxzzGBiA16WxpQylERwV0Iy0AiWK+cjhTYrPBY3
        iidkedmTTxCoHae6US9x1Pl5vBjt1ebzxS9EleU=
X-Google-Smtp-Source: APXvYqxGAHWKlMyhVxsNbtFeB4L54p9HKFB0LZbkk3IeP9bk4jL4QIw8uTzzMkD3oHv5XJjHlOz+XGDjNdV7iG8625Q=
X-Received: by 2002:aca:fdd8:: with SMTP id b207mr8232972oii.57.1572863551996;
 Mon, 04 Nov 2019 02:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20191101204558.210235-1-helgaas@kernel.org> <20191101204558.210235-5-helgaas@kernel.org>
In-Reply-To: <20191101204558.210235-5-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Nov 2019 11:32:21 +0100
Message-ID: <CAJZ5v0hOrVXkBie4Ub31OJA4Cuc_4AdZBx2DFnk6HWToJUk4jQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] xen-platform: Convert to generic power management
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 1, 2019 at 9:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Convert xen-platform from the legacy PCI power management callbacks to the
> generic operations.  This is one step towards removing support for the
> legacy PCI callbacks.
>
> The generic .resume_noirq() operation is called by pci_pm_resume_noirq() at
> the same point the legacy PCI .resume_early() callback was, so this patch
> should not change the xen-platform behavior.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>

Good idea:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/xen/platform-pci.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
> index 5e30602fdbad..e06e8769eb84 100644
> --- a/drivers/xen/platform-pci.c
> +++ b/drivers/xen/platform-pci.c
> @@ -168,13 +168,17 @@ static const struct pci_device_id platform_pci_tbl[] = {
>         {0,}
>  };
>
> +static struct dev_pm_ops platform_pm_ops = {
> +       .resume_noirq =   platform_pci_resume,
> +};
> +
>  static struct pci_driver platform_driver = {
>         .name =           DRV_NAME,
>         .probe =          platform_pci_probe,
>         .id_table =       platform_pci_tbl,
> -#ifdef CONFIG_PM
> -       .resume_early =   platform_pci_resume,
> -#endif
> +       .driver = {
> +               .pm =     &platform_pm_ops,
> +       },
>  };
>
>  builtin_pci_driver(platform_driver);
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
