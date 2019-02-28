Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCCC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35096218AE
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ebrIHz0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbfB1QkO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:40:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35533 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1QkO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 11:40:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id y15so9621168wma.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Feb 2019 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KuDoYcExCy3hvAzLNoi6TJv4ojVwDHwabAUo6j+cvEw=;
        b=ebrIHz0RQwKW6xHNRE/oOZcCZIWtPxExTPZhtDDE6RI8+/+HlESyKHS10SlKRxmUjx
         UNibpJgsDpxdlAGFjqDRI6H+xn5bsjPeBAN/D6zM1xvZoc+66Qu7MbPcTU7y1p48k1Zc
         9nTvGJbgN0W6n8vvvmjkmI8WqqUEksOJioBfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KuDoYcExCy3hvAzLNoi6TJv4ojVwDHwabAUo6j+cvEw=;
        b=Q9ZAk0MfJy9b282bMhm0vtcKPdoBqVETg1IksqOpTHnI+LdbI5OaOxmiaSmCEVE4ym
         8S09RVyOumQWroD4oSIuGrez+aOqljuW2BH8PseCilYPlGh+AddE0vMY4TQiWfRARs+o
         j6cdDxsnG8fLn0w/Aj5oVw7vKLXdTPTH46P3aLl3V1i0w/gumnFAiQrgVSgdaQuJLIzm
         u8CGlhZ/6Vc6VdNcIBfILbx72qx62kJb59MyEEPj1gQr85i+z/AxV/qFu3VQLvobSEBJ
         a2x1/Edbq6gK7UVrKyM/S1jTU/ifzAkROvPsa5I3/KCZ+KRhIdptESSre15AX88cqgB/
         Corg==
X-Gm-Message-State: APjAAAX0ezVfEjknFLVKyJozjR/z0Iu6h39SUzqZpbonwT7KSJhSIBDO
        I65TNu5aVYCyhwtNUhuQvoWySo5vJqcXY/+7FFV2ag==
X-Google-Smtp-Source: APXvYqxaoeAV0c6/rMfYf1AwFx6LX0voFaEDbttj9b4HqSVBxUQyamfxFYleGqOBJEeqRzRmjn+sz095ZD2+tlrlpSE=
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr365771wmi.21.1551372011893;
 Thu, 28 Feb 2019 08:40:11 -0800 (PST)
MIME-Version: 1.0
References: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
 <1550680435-9706-3-git-send-email-srinath.mannam@broadcom.com> <20190228161303.GA23441@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190228161303.GA23441@e107981-ln.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 28 Feb 2019 22:10:00 +0530
Message-ID: <CABe79T7DCodtvWsEpA3kS=W+GubF4tyb_C=F9OWXguKOUsgufw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Thanks for the review.. Please see my comments below in line..

Regards,
Srinath.
On Thu, Feb 28, 2019 at 9:43 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Feb 20, 2019 at 10:03:55PM +0530, Srinath Mannam wrote:
> > In the present driver outbound window configuration is done to map above
> > 32-bit address I/O regions with corresponding PCI memory range given in
> > ranges DT property.
> >
> > This patch add outbound window configuration to map below 32-bit I/O range
> > with corresponding PCI memory, which helps to access I/O region in IA32
>
> I think you mean ARM 32-bit here, not IA32.
Yes ARM 32 bit.. Thank you.
>
> > and one to one mapping of I/O region to PCI memory.
> >
> > Ex:
> > 1. ranges DT property given for current driver is,
> >     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
> >     I/O region address is 0x400000000
> > 2. ranges DT property can be given after this patch,
> >     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
> >     I/O region address is 0x42000000
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>
> I asked you before, please point me at mailing list discussions where
> these review tags were given, v1 was already carrying them but that's
> not how the process works, they have to be given on mailing lists.
Sorry I missed your comment. These tags are our internal review list.
Many Thanks for sharing knowledge.
I will follow the process from next time onward. I will modify and
send next patch set.
>
> Lorenzo
>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index b882255..080f142 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> >                       resource_size_t window_size =
> >                               ob_map->window_sizes[size_idx] * SZ_1M;
> >
> > -                     if (size < window_size)
> > -                             continue;
> > +                     /*
> > +                      * Keep iterating until we reach the last window and
> > +                      * with the minimal window size at index zero. In this
> > +                      * case, we take a compromise by mapping it using the
> > +                      * minimum window size that can be supported
> > +                      */
> > +                     if (size < window_size) {
> > +                             if (size_idx > 0 || window_idx > 0)
> > +                                     continue;
> > +
> > +                             /*
> > +                              * For the corner case of reaching the minimal
> > +                              * window size that can be supported on the
> > +                              * last window
> > +                              */
> > +                             axi_addr = ALIGN_DOWN(axi_addr, window_size);
> > +                             pci_addr = ALIGN_DOWN(pci_addr, window_size);
> > +                             size = window_size;
> > +                     }
> >
> >                       if (!IS_ALIGNED(axi_addr, window_size) ||
> >                           !IS_ALIGNED(pci_addr, window_size)) {
> > --
> > 2.7.4
> >
