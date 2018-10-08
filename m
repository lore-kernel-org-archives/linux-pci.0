Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D7C00449
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 09:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42442087D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 09:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYFtab0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42442087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeJHQzM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:55:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41177 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeJHQzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 12:55:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id x31-v6so2265796edd.8;
        Mon, 08 Oct 2018 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Meg3Bs0/GqsCryowAzrLarabsCcBRgg0wa6pSkTtAKI=;
        b=jYFtab0+/vDHw4sfrDh60jOlzlnLuihjU81vZh/jq4qP9I4+Ojc4gb6vyHD3HdDRDT
         3GNhH2F/U+5tB8x0ktaYh7Bwovxtpg1+74QLOcIvZpFaKiK1izU/ZdV5WCety/6GuWWX
         cwPzTGBZySPTPPRd9vpSxomO1JhPTqTOWA+vXjNgDdfS4TgqT3FBRuJ7TMq2uSvlzRuX
         dz6kVABdaBg4vD88DkvNG1hFgCCaE5rN0dL5WCzH7H+J5RceSJc3SbhnBN+xUHfijX9t
         UxBGhsdIz4KzifjF1H24+/RwCF5TVlzDHPfvKHd5kUxdr8UZeZ7aNh2y6RRdzXdH46MA
         xyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Meg3Bs0/GqsCryowAzrLarabsCcBRgg0wa6pSkTtAKI=;
        b=horxr7u4Xoay66JsK7XIiXhEIH3Svh73kD3RUbmSjrkaSOkhjiS+iJwETOHyOUM4ul
         PlnUyXSxVh3yYmi3j8qvMrTr9Ee5EdeGDachPd0PSu4oQ0uanJJdH8Y8IM30ziYJR8Oo
         v4OcycMHpvoyftkeMn5wKGSsc++F1CEfqRDBDoC/vcryxbvztm/wbJ38TkAmjG2Ndpfr
         bkr4L4fcX87U/uO8kBqVMstJQOu/IlsK+ro6NIYjw8ejrY5rH0IK7JFzbYbAza3jA4Q+
         +fZBDzpobLK8cDOxlZEGxx2E6WzsmcgHaV9/FXXbipnnwIca46Fpg/ULXu8IC4jWkrcI
         Hfvg==
X-Gm-Message-State: ABuFfoi/kCJcc+rTVH2SdlPXxeJ5h+z4uPgiuz7G7vl/qbnipToY/xVd
        PKLt6JtX0GI96snHcnd2l8SPNd0eTX4bgF1wTY0=
X-Google-Smtp-Source: ACcGV62AASRbaOHWgcYsbZja/AeI6e9oDavCjIiVt+2nJjdxwWs2VNMTpQvSlriYHWZYzeBCchINdv42ICSgm1ZIJoY=
X-Received: by 2002:a50:a643:: with SMTP id d61-v6mr2445874edc.281.1538991860016;
 Mon, 08 Oct 2018 02:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
 <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com> <20181003201244.GG120535@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181003201244.GG120535@bhelgaas-glaptop.roam.corp.google.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 8 Oct 2018 17:44:08 +0800
Message-ID: <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com>
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

On Thu, Oct 4, 2018 at 4:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 27, 2018 at 10:10:07AM +0800, Bin Meng wrote:
> > On Thu, Sep 27, 2018 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Sep 26, 2018 at 08:14:01AM -0700, Bin Meng wrote:
> > > > Add more PCI IDs to the Intel GPU "spurious interrupt" quirk table,
> > > > which are known to break.
> > >
> > > Do you have a reference for this?  Any public bug reports, bugzilla,
> > > Intel spec reference or errata?  "Which are known to break" is pretty
> > > vague.
> >
> > Sorry I used wrong words and should have been clearer. These devices
> > are validated to be broken. The test I used is very simple, just
> > unplug the VGA cable and plug it again, and "spurious interrupt" will
> > be seen on the interrupt line of the IGD device. I was not aware of
> > any public bugs filed to Intel, nor seen any errata from Intel.
>
> The original commit, f67fd55fa96f ("PCI: Add quirk for still enabled
> interrupts on Intel Sandy Bridge GPUs"), says some systems "crash"
> (not sure if that means an oops or an actual crash that requires a
> reboot) and on other systems, Linux disables the shared interrupt
> line.  I assume disabling the interrupt line keeps devices using that
> line from working, but does not directly cause a crash.
>

Correct, disable the shared interrupt line keeps all devices using
that line from working, which is current kernel's behavior w/o this
quirk handling: it disables the (shared) interrupt line after 100.000+
generated interrupts. But the side effect is that other devices become
unusable after that (eg: USB devices which share the same interrupt
line with the Intel GPU). That's why the original commit, f67fd55fa96f
("PCI: Add quirk for still enabled interrupts on Intel Sandy Bridge
GPUs") disables the GPU's interrupt directly, which should really be
done by the VGA BIOS itself (a buggy VBIOS!).

> What specific symptom do you see here?  I think it might be useful to
> collect details, e.g., dmesg logs, /proc/interrupts contents, output
> of "sudo lspci -vv", etc., for the systems you're quirking here.  I'm
> hoping we can eventually figure out a solution that doesn't require a
> quirk for every new GPU, and maybe that info will help find it.
>

The symptom was described briefly in the original commit f67fd55fa96f
too, that disables the (shared) interrupt line after 100.000+
generated interrupts (can be observed via /proc/interrupts).

> > > > See commit f67fd55fa96f ("PCI: Add quirk for still enabled interrupts
> > > > on Intel Sandy Bridge GPUs"), and commit 7c82126a94e6 ("PCI: Add new
> > > > ID for Intel GPU "spurious interrupt" quirk") for some history.
> > > >
> > > > Based on current findings, it is highly possible that all Intel
> > > > 1st/2nd/3rd generation Core processors' IGD has such quirk.
> > >
> > > Can you include a reference to these "current findings"?  I assume you
> > > have bug reports that include the device IDs you're adding?  If not,
> > > how did you build this list of new IDs?
> >
> > By "current findings" I mean given the IDs we have here, plus previous
> > one added by Thomas, it's highly possible this VGA BIOS bug exists in
> > every 1st/2nd/3rd generation Core processors.
> >
> > > The function comment added by f67fd55fa96f ("PCI: Add quirk for still
> > > enabled interrupts on Intel Sandy Bridge GPUs") suggests that this is
> > > actually a BIOS issue, not a hardware erratum, i.e., I don't see
> > > anything there that suggests a hardware defect.
> > >
> > > But there must be a hole somewhere -- the kernel can't be expected to
> > > disable interrupts in device-specific ways when there's no driver
> > > loaded.  Maybe it's simply a BIOS defect or maybe there's some
> > > interrupt or _PRT-related setup we're missing.
> >
> > It's a pure VGA BIOS bug, not the BIOS bug or _PRT etc. The VGA BIOS
> > forgot to turn off the interrupt on these devices.
>
> If this is a VGA BIOS defect, it's not very likely that it will
> magically be fixed for all new Intel GPUs, so in effect it sounds like
> we need to update this list of quirks in Linux every time a new Intel
> GPU comes out.  That prospect is a little daunting.
>

I don't have a relatively newer Intel board at hand for testing right
now. I can try to locate one. But as I said, it's highly possible at
least all 1st/2nd/3rd generation Core processors are affected. Maybe
we can add all these known GPU devices of  1st/2nd/3rd generation Core
processors all together for now? For newer GPUs, let's wait until
someone reports the issue again?

> Do you happen to know if Windows has the same problem?  I.e., if you
> boot an old version of Windows with a new GPU, and unplug the VGA
> cable, does Windows crash?  If Windows can figure out how to handle
> that situation gracefully, Linux should be able to do it, too.
>

I suspect Windows cannot handle it too. Without the GPU awareness, the
interrupt line is simply on and no driver claims the devices and will
cause issues. I can test this.

> > > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > > > Cc: <stable@vger.kernel.org> # v3.4+
> > > > ---
> > > >
> > > >  drivers/pci/quirks.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 6bc27b7..c0673a7 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -3190,7 +3190,11 @@ static void disable_igfx_irq(struct pci_dev *dev)
> > > >
> > > >       pci_iounmap(dev, regs);
> > > >  }
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
> > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
> > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
> > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
> > > >
> > > > --

Regards,
Bin
