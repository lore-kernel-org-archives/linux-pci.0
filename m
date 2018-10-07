Return-Path: <SRS0=ld9y=MT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DFCC65C1B
	for <linux-pci@archiver.kernel.org>; Sun,  7 Oct 2018 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61B92087D
	for <linux-pci@archiver.kernel.org>; Sun,  7 Oct 2018 17:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZACf78P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61B92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJHAKh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:10:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36381 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeJHAKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Oct 2018 20:10:37 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so8972783itd.1;
        Sun, 07 Oct 2018 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BySx2ZW7o37OCQFUIM+WKKH2cvbcU7bEIXH3NrdwXnw=;
        b=NZACf78PTFDiXCmLzhrv9FtP/7RROEy/nyss/b0DwNwSpTt6Z26FweCjztMAMCLMma
         bRRZuZolYQlwX4PkaVghrJgKzZH+QcjUUwPJsnz/1VvrzdljIVnijXvlxUSI6kFnNr4a
         fWzDUEJKnuvtO0KfYmCNxB7a4qgHWOmEgkxGGNh5gH9WJxk3j17t500rVneZ4NH7ZLRR
         UAKy2pbmIfyuqGKCwkkW6syfiW9agsMNnSds5BP5ZauHnWDw5jkB1S2lPSQYXW4i8nQc
         aW0HCDoHrFH/2LGXZ1daGP9RoE9d76rQHYFq1L4k1K9bY42IBNul3iYcDWSTrW98SIOJ
         i4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BySx2ZW7o37OCQFUIM+WKKH2cvbcU7bEIXH3NrdwXnw=;
        b=ekyw0RvyKD6fdXs2ACK14htoTKldPn4CsquBH7n02yml1My5JfQ5iu1aZZQwWLUqga
         n7Z3O4ir7V7x8hwbz6mW7m4Vz0QkehyeV5J7ujV0QOaHQQiKqfx6vU4knJP9J0ZSrAKY
         PcDkp9nXGG9D7EPcsuFWhdn29Ypi4boVvUF0E/i/ee3Xcc5K6ZJeKPxk/UgM7UZC24nD
         swzHCS4IrfZsJga3UhwvGw5zuP4XbPant99IPGuYG4mdrdDLxpotZjkNC04aGvO4TiAD
         hoLBnSD5ztVxMdTcfJxMt5IZM1X1vTSJZLpJYAiHgSDBqSJVlc9kp98UnySTLnUZNZ1H
         W+7w==
X-Gm-Message-State: ABuFfojaF29HhnsdbQqdr+1PZ8Yc8sXP6Xjviok5IyWtzxlVNm9UCs3P
        2t5eKhTZKw7NvvnD1j5XmWMp1qzHe+/wHWoYGNsqkA==
X-Google-Smtp-Source: ACcGV61tcfGzgHqquoILSE9kk10Il9wwQwu9VpGY1r/AQV1a+/a/cly+Lzf/I4iQOEFZk0rWFU1LQdWtz7Cq2C7CXZM=
X-Received: by 2002:a05:660c:383:: with SMTP id x3mr14400111itj.121.1538931763496;
 Sun, 07 Oct 2018 10:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <fceb7567-dae1-f393-b2e9-bce6e1fa5159@infradead.org>
In-Reply-To: <fceb7567-dae1-f393-b2e9-bce6e1fa5159@infradead.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sun, 7 Oct 2018 10:02:32 -0700
Message-ID: <CAKgT0UfTULhJYvw2z8xHYLUJ=Mh+iuk4TQXUduXsgiUjicXxPA@mail.gmail.com>
Subject: Re: [PATCH] PCI: expand the "PF" acronym in Kconfig help text
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 6, 2018 at 8:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Tell users what a PCI PF is in the PCI_PF_STUB config help text.
>
> Fixes: a8ccf8a66663 ("PCI/IOV: Add pci-pf-stub driver for PFs that only enable VFs")
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/pci/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- lnx-419-rc6.orig/drivers/pci/Kconfig
> +++ lnx-419-rc6/drivers/pci/Kconfig
> @@ -73,9 +73,9 @@ config PCI_PF_STUB
>         depends on PCI_IOV
>         help
>           Say Y or M here if you want to enable support for devices that
> -         require SR-IOV support, while at the same time the PF itself is
> -         not providing any actual services on the host itself such as
> -         storage or networking.
> +         require SR-IOV support, while at the same time the PF (Physical
> +         Function) itself is not providing any actual services on the
> +         host itself such as storage or networking.
>
>           When in doubt, say N.

This looks good to me.

Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
