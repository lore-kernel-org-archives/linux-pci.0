Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E71C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 02:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21DC20666
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 02:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxxI0iIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21DC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeI0I0N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:26:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45016 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeI0I0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Sep 2018 04:26:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id t11-v6so3594889edq.11;
        Wed, 26 Sep 2018 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNTog7Ud4VAx5NlRB3/NDdJuJoHr6fMafWweSvJ7qgM=;
        b=rxxI0iIycCtl8VoYPwK/dbvpvqg/nGHA1XfwvUgLO0fh6kOEXUF8xiKzBukugKQ25Q
         TywYonPKsat12/4/V4PSv7UI5WwjtGiF3PuFxC/Qd0ynlRUOJCQSIO3V0mGmeeUqabTN
         ZXAkPuJ6sjz8FTwtBCuk4ysfO5JjX+NlqJ05xsgY7Kae+Q9yRWWfW5jU1jI6Yo4JGIhH
         qyBQ+pkQMxl0LuXoBXMjjg2fr7XUZk97jvTHQFSewB80lqZjiGBuSRfeM/vg+YFJ9688
         feYe1I6CavNwW8cZ2EVuKtt5ahHqSn4Rh310gKuNU89rtUKbjoAF4FAN0OUUPBfIk9hB
         c64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNTog7Ud4VAx5NlRB3/NDdJuJoHr6fMafWweSvJ7qgM=;
        b=HCoO83IkB+qMcRxWEUTb2efs3cqFxQ/w5DTpA9kCdzDbH70HoeLyRUMMqmGuUuVNlR
         KkjpZ9d+AUkZ+JUBaHz1nc31TJfhJWRoRmnnWYrLVsCg+tvCLf7uoy55s9XhDa8X9flN
         xlmtUns1gDTtEQ0UVzvLw4mGn+foXgmf/dZvuNdXAuokh2l3d5STha7DMrs2GbZz2Mbo
         WMb1ySXNy1jusZR4YN+jxZ002Ltoe8P5h0foTq6s22VqD++MqoAM/Se8wjJYsBgl7HWu
         WAXkC8A+U2tLz0Z3U1XpTvhNyTK21gKut1i8rhWkqNaSb2k29WlDKAercc2eY1obnATo
         PeIQ==
X-Gm-Message-State: ABuFfohT4ZCPYtaJArMFgBXsN8uAmMHPbslV3YuErtVDw7hExiWTLd34
        md7dXK5qd0OY5VOuMzOWQ21841UBWuR/rLc9YvU=
X-Google-Smtp-Source: ACcGV62tscOFDGNagqkmqvVn2qjS5P8IEsOxeACwRO8cog5fDoybQkqp3ubS9LapTgkHtKGHHXlvx68Oq8TlrOUgAng=
X-Received: by 2002:a50:97c8:: with SMTP id f8-v6mr14264666edb.243.1538014218525;
 Wed, 26 Sep 2018 19:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com> <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 27 Sep 2018 10:10:07 +0800
Message-ID: <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com>
Subject: Re: [PATCH] pci: Add a few new IDs for Intel GPU "spurious interrupt" quirk
To:     helgaas@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thomas Jarosch <thomas.jarosch@intra2net.com>,
        stable <stable@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Sep 27, 2018 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Intel DRM maintainers, etc]
>
> On Wed, Sep 26, 2018 at 08:14:01AM -0700, Bin Meng wrote:
> > Add more PCI IDs to the Intel GPU "spurious interrupt" quirk table,
> > which are known to break.
>
> Do you have a reference for this?  Any public bug reports, bugzilla,
> Intel spec reference or errata?  "Which are known to break" is pretty
> vague.
>

Sorry I used wrong words and should have been clearer. These devices
are validated to be broken. The test I used is very simple, just
unplug the VGA cable and plug it again, and "spurious interrupt" will
be seen on the interrupt line of the IGD device. I was not aware of
any public bugs filed to Intel, nor seen any errata from Intel.

> > See commit f67fd55fa96f ("PCI: Add quirk for still enabled interrupts
> > on Intel Sandy Bridge GPUs"), and commit 7c82126a94e6 ("PCI: Add new
> > ID for Intel GPU "spurious interrupt" quirk") for some history.
> >
> > Based on current findings, it is highly possible that all Intel
> > 1st/2nd/3rd generation Core processors' IGD has such quirk.
>
> Can you include a reference to these "current findings"?  I assume you
> have bug reports that include the device IDs you're adding?  If not,
> how did you build this list of new IDs?
>

By "current findings" I mean given the IDs we have here, plus previous
one added by Thomas, it's highly possible this VGA BIOS bug exists in
every 1st/2nd/3rd generation Core processors.

> The function comment added by f67fd55fa96f ("PCI: Add quirk for still
> enabled interrupts on Intel Sandy Bridge GPUs") suggests that this is
> actually a BIOS issue, not a hardware erratum, i.e., I don't see
> anything there that suggests a hardware defect.
>
> But there must be a hole somewhere -- the kernel can't be expected to
> disable interrupts in device-specific ways when there's no driver
> loaded.  Maybe it's simply a BIOS defect or maybe there's some
> interrupt or _PRT-related setup we're missing.
>

It's a pure VGA BIOS bug, not the BIOS bug or _PRT etc. The VGA BIOS
forgot to turn off the interrupt on these devices.

> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > Cc: <stable@vger.kernel.org> # v3.4+
> > ---
> >
> >  drivers/pci/quirks.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 6bc27b7..c0673a7 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3190,7 +3190,11 @@ static void disable_igfx_irq(struct pci_dev *dev)
> >
> >       pci_iounmap(dev, regs);
> >  }
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
> >
> > --

Regards,
Bin
