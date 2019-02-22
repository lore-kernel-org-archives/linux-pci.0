Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C59C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 02:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801EE20836
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 02:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPOa4ZAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBVCFD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:05:03 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40121 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBVCFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 21:05:03 -0500
Received: by mail-it1-f196.google.com with SMTP id i2so1000238ite.5;
        Thu, 21 Feb 2019 18:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNKHG+50EFTBKu9G1sPkF/C3jzwxcaKWS8VDvM7NO8A=;
        b=gPOa4ZAUZ8O0VGZsQVK632FkpxTffsbZic5NybSOS8y3sw+cM8gu89PkmSLrfgHO3s
         6mPs+8OiswY8FHWwos/Ly2eRhCtLBRYig8K1uElJArTSQ0bOoeGGO+2KBEbtS+XTFuAt
         0FajVpy6E67ntId66BM/OegNm9Bffvb78YZZc/xEOAjOC/5UnncivUQ68mT8LrQlu1jI
         Jf+hfqc88MmrndAj6DJyguQ/76MCcAbXvgXOzLTQ1OufRu7k4DjvPkrYApZkMnG0J8YY
         qwRMfa21wwk6tmafOlzrz4Uhw5UZFhrQoEeIVfmX/tmH8DQTs4FHGcyn4nkdvNk2t7KW
         qNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNKHG+50EFTBKu9G1sPkF/C3jzwxcaKWS8VDvM7NO8A=;
        b=s7u6QMB2BbvJNDIMVUH8pnmvlQT7seDCTkT/1p/2WEbQSxn6i6JuWKZnw9XT6Y7W3H
         fLVI9qGKkQDcjtsLxa+0CduDyq9dQ0yktJGBprfuoZSRVqmYQEZ1MeRz5zcbMahO5d1O
         x9Gs+eS/kvlis6QASTCKTMlL8a/Mcs3jOuYLf7Th3TGDj3kCVoCU3Vh30IJ/4Po+OHDo
         Sy+/wBPALNaDtKMIZjJSDmDl0ZzYtpYADxac60mWRDTQPQAEFNVs56qZIvFMXRTSay47
         ybAo2OHVdVU3u2IE1EC5lmNvKWhUa4IJ7hN1NCytZPdLPbw+Zw8zmKfIoCWwsaCHYhQK
         AltA==
X-Gm-Message-State: AHQUAuYYfOEg7OBtP1iJ8Y3IY+jPdAKcjVGeiNUSWY/LO3gJ62kYCwts
        JcBCOCn+zVK8x5sQhT4SffDM9lWmJ9N95OtM5zo=
X-Google-Smtp-Source: AHgI3IZBIV7xdg7sMN/VZYWi61mbCAN/QDRnKhu1zfkX18EMV+ZEWvISvScbqRqL2feprD0ZCLKFYEIWldcUW1+8+Yo=
X-Received: by 2002:a24:9102:: with SMTP id i2mr987734ite.4.1550801102692;
 Thu, 21 Feb 2019 18:05:02 -0800 (PST)
MIME-Version: 1.0
References: <20190220012031.10741-1-mr.nuke.me@gmail.com> <20190220012031.10741-5-mr.nuke.me@gmail.com>
 <20190221075634.uih5ysqwkna7cku4@wunner.de> <027101b4652c4e0c98b86649aa3e4732@ausx13mps321.AMER.DELL.COM>
In-Reply-To: <027101b4652c4e0c98b86649aa3e4732@ausx13mps321.AMER.DELL.COM>
From:   Oliver <oohall@gmail.com>
Date:   Fri, 22 Feb 2019 13:04:51 +1100
Message-ID: <CAOSf1CGqKePUE7Z9R3ojX6Ba_RxsdS7Y2rHONzbZNPNti8MtwQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/4] PCI: hotplug: Add quirk For Dell nvme pcie switches
To:     Alex_Gagniuc@dellteam.com
Cc:     Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Austin.Bolen@dell.com,
        Keith Busch <keith.busch@intel.com>, Shyam.Iyer@dell.com,
        okaya@kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com, Sinan Kaya <okaya@codeaurora.org>,
        poza@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 22, 2019 at 5:38 AM <Alex_Gagniuc@dellteam.com> wrote:
>
> On 2/21/19 1:57 AM, Lukas Wunner wrote:
> >
> > [EXTERNAL EMAIL]
> >
> > On Tue, Feb 19, 2019 at 07:20:30PM -0600, Alexandru Gagniuc wrote:
> >> --- a/drivers/pci/hotplug/pciehp_hpc.c
> >> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> >> @@ -952,3 +952,23 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
> >>                            PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> >>   DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
> >>                            PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> >> +
> >> +
> >
> > Duplicate newline.
> >
> >
> >> +static void fixup_dell_nvme_backplane_switches(struct pci_dev *pdev)
> >
> > Can we have a little code comment above the function such as:
> >
> > +/*
> > + * Dell <product name> NVMe storage backplanes disable in-band presence
> > + * (PCIe r5.0 sec X.Y.Z) but neglect to set the corresponding flag in the
> > + * Slot Capabilities 2 register.
> > + */
> >
> >
> >> +    if (pdev->subsystem_vendor != PCI_VENDOR_ID_DELL
> >> +            || pdev->subsystem_device != 0x1fc7)
> >
> > This looks a little unpolished, how about:
> >
> > +     if (pdev->subsystem_vendor != PCI_VENDOR_ID_DELL ||
> > +         pdev->subsystem_device != 0x1fc7)
> >
> >
> >> +            return;
> >> +
> >> +    pdev->no_in_band_presence = 1;
> >> +}
> >> +
> >> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_PLX, 0x9733,
> >
> > By convention there's no blank line between the closing curly brace
> > and the DECLARE_PCI_FIXUP_CLASS_FINAL().
>
> I'm sorry for all the style issues. I realize it's noise and should just
> be done right from the beginning. Is there a way to make checkpatch.pl
> catch these before they go out?
>
>
> > If the quirk is x86-specific, please enclose it in "#ifdef CONFIG_X86"
> > to reduce kernel footprint on other arches.
>
> That's a tricky one. If you look at p. 185 of [1], items 9, 11, and 12
> are standard x16 cards that would fit in any x16 slot. Those cards have
> the offending switches.
>
> On the one hand, you could take the cards and backplane and put them in
> a non-hax86 system. On the other hand, I don't see why someone would
> want to do this.

I have a couple of POWER boxes with Dell branded switch cards in them.
I have no idea why either, but it does happen.

>
> Alex
>
> [1] https://topics-cdn.dell.com/pdf/poweredge-r740xd_owners-manual_en-us.pdf
>
>
