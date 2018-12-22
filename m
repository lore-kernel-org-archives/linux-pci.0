Return-Path: <SRS0=4uNc=O7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C01C43387
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 23:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37EC2195D
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545519629;
	bh=1n0M3ffLnedJPSXcvbSq5B6cV6I4bWz3wU+AkjS0MNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D6+WD/GRO8cCN/qu6Ms1FW5hdByxfw8EKqo9iWYAnrDAr1PzRfDfHXwJQJu0h0Kno
	 UQmLLrIGpo8D4w36qgACkP3bNj33Ni57Kp2wEWiqpflDiUbTg1TgWJZhdksjG4kT7T
	 IW4YOldGfvhlSApjFZYvaYvYd4f2NhtAAHdm6xvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392897AbeLVXA2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:00:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbeLVXA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Dec 2018 18:00:28 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55A02195D;
        Sat, 22 Dec 2018 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545519627;
        bh=1n0M3ffLnedJPSXcvbSq5B6cV6I4bWz3wU+AkjS0MNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nxQbJPbsSD7WpC9kL4eZdL/05olDzTV6n2UrKzKkOF+UEQWDvXTB3pOdpz6eHFbBh
         U1kpor/nu49wjNZxAuC8X1kH+FQAf1JuQRDvytIEleXL19Sdp32jrHKiN4H1G5QBhB
         Yyktg7Li4MBCzxS+YfxUKyKHLcif/xeRAUHlcnqA=
Received: by mail-oi1-f181.google.com with SMTP id u18so7648797oie.10;
        Sat, 22 Dec 2018 15:00:27 -0800 (PST)
X-Gm-Message-State: AJcUukd+dc3+6gcQlEouXZXQCafQ3Oc+w/mS/FdYsDKFlRtN4pGqeLT6
        EythlwrpoZ9+0Dl8NSmYVpYidm22wwbupeenraY=
X-Google-Smtp-Source: AFSGD/Xig4w8AJawR5FnB3rKOW/HKLulwGUOKr0OuJS8q7jRONWk/9IeJQM+bWePQ961TiPyeBhAcxwYJVSJBuiYRZs=
X-Received: by 2002:aca:e755:: with SMTP id e82mr4429967oih.153.1545519626941;
 Sat, 22 Dec 2018 15:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20181222090720.19234-1-okaya@kernel.org> <20181222090720.19234-4-okaya@kernel.org>
 <20181222164013.2l7etklpxjrrobnm@wunner.de>
In-Reply-To: <20181222164013.2l7etklpxjrrobnm@wunner.de>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Sun, 23 Dec 2018 02:00:15 +0300
X-Gmail-Original-Message-ID: <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
Message-ID: <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 22, 2018 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sat, Dec 22, 2018 at 09:07:12AM +0000, Sinan Kaya wrote:
> > This driver depends on the PCI infrastructure but the dependency has not
> > been explicitly called out.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
>
> This series doesn't have a cover letter so it's unclear to me through
> which tree it's supposed to go in?  Each patch through the individual
> subsystem tree or all through the same tree?  If the former I guess I
> could push this to drm-misc...
>

Feel free to apply individual patches independently. Let me know which
one you applied so that I can drop them on the next rev.

> Thanks,
>
> Lukas
>
> > ---
> >  drivers/gpu/vga/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
> > index b677e5d524e6..d5f1d8e1c6f8 100644
> > --- a/drivers/gpu/vga/Kconfig
> > +++ b/drivers/gpu/vga/Kconfig
> > @@ -21,6 +21,7 @@ config VGA_SWITCHEROO
> >       bool "Laptop Hybrid Graphics - GPU switching support"
> >       depends on X86
> >       depends on ACPI
> > +     depends on PCI
> >       select VGA_ARB
> >       help
> >         Many laptops released in 2008/9/10 have two GPUs with a multiplexer
> > --
> > 2.19.0
