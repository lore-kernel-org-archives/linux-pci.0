Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E454C282DA
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2AD22321
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nmIYEBBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfDPNsC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:48:02 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:34834 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbfDPNsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 09:48:01 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 09:48:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id E3BDE64B;
        Tue, 16 Apr 2019 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1555421883; x=1557236284; bh=WzjzsrMyXY
        cT9KJtQRB01ZKYuznxJd30kyzyfTnBhNc=; b=nmIYEBBt2rLaGbmbQ0td8AZ5LZ
        rlTV8+cZz0//TsrxTKQz/rNRP8sb5CzST8QMfRI6GK/rCYSozVQRZPKX5iJEUHD2
        4m3odC6R2aHaCwvU1blyj4aFUwtw9sNsoszs6RcdBzZTctEf8LKHR/GLAjn70twT
        HoejYfr+pdRY62QEfPpZCN2uYW5GrfjonZVWCP1ipDgPm7L/DEOlwc8RzHLSe6oe
        WisCwzFE4HxEQ/3/KV79EgR9ftZesm/PUPDzQEQMBsrgkBQhd1Le1pNIl6Ose4w4
        YyrcwOXXqNze+LPa+Kt7qorGumXx4ZRFeOoR0gmEEXjja5Gd6vADQr8lbAxg==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zFND8aQT-eRu; Tue, 16 Apr 2019 08:38:03 -0500 (CDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id A5806516;
        Tue, 16 Apr 2019 08:38:03 -0500 (CDT)
Received: by mail-io1-f41.google.com with SMTP id f6so17645999iop.3;
        Tue, 16 Apr 2019 06:38:03 -0700 (PDT)
X-Gm-Message-State: APjAAAU5HFRWUg8R9xzxb/zEkbG5rRPOp6ht2YG0xVtmz0vEbNTqpbAj
        qsmawl9cQOZcHP7CQaUazUaIcVBho68tK9yhQEg=
X-Google-Smtp-Source: APXvYqz7SALzDJjOI9laFzjwuWIy+oYeJC5AJHqwqI0m0tbuyP1Yoj9TOl3G2RLLWuF2sdwuTn9fhouYeergHn8DlCg=
X-Received: by 2002:a6b:e50a:: with SMTP id y10mr1277286ioc.91.1555421883470;
 Tue, 16 Apr 2019 06:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <1555340058-3065-1-git-send-email-wang6495@umn.edu> <20190416072327.GA127769@gmail.com>
In-Reply-To: <20190416072327.GA127769@gmail.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Tue, 16 Apr 2019 08:37:27 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fEt9AZVp5VLWwubvAsvFit3V8D4EOD3H=vTaF3RJ_D5A@mail.gmail.com>
Message-ID: <CAAa=b7fEt9AZVp5VLWwubvAsvFit3V8D4EOD3H=vTaF3RJ_D5A@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: fix a memory leak bug
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 16, 2019 at 2:23 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Wenwen Wang <wang6495@umn.edu> wrote:
>
> > In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
> > found through pirq_find_routing_table(). If the table is not found and
> > 'CONFIG_PCI_BIOS' is defined, the table is then allocated in
> > pcibios_get_irq_routing_table() using kmalloc(). In the following
> > execution, if the I/O APIC is used, this table is actually not used.
> > However, in that case, the allocated table is not freed, which can lead to
> > a memory leak bug.
> >
> > To fix this issue, this patch frees the allocated table if it is not used.
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  arch/x86/pci/irq.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> > index 52e5510..d9bcb96 100644
> > --- a/arch/x86/pci/irq.c
> > +++ b/arch/x86/pci/irq.c
> > @@ -1119,6 +1119,8 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
> >
> >  void __init pcibios_irq_init(void)
> >  {
> > +     struct irq_routing_table *itable = NULL;
> > +
>
> Minor style nit: the canonical name of irq_routing_table local variables
> is usually 'rtable' or 'rt' - let's not add a third naming variant with
> 'itable'?
>

Thanks for your comment! I will rework the patch.

Wenwen

> >       DBG(KERN_DEBUG "PCI: IRQ init\n");
> >
> >       if (raw_pci_ops == NULL)
> > @@ -1129,8 +1131,10 @@ void __init pcibios_irq_init(void)
> >       pirq_table = pirq_find_routing_table();
> >
> >  #ifdef CONFIG_PCI_BIOS
> > -     if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
> > +     if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN)) {
> >               pirq_table = pcibios_get_irq_routing_table();
> > +             itable = pirq_table;
> > +     }
> >  #endif
> >       if (pirq_table) {
> >               pirq_peer_trick();
> > @@ -1145,8 +1149,10 @@ void __init pcibios_irq_init(void)
> >                * If we're using the I/O APIC, avoid using the PCI IRQ
> >                * routing table
> >                */
> > -             if (io_apic_assign_pci_irqs)
> > +             if (io_apic_assign_pci_irqs) {
> > +                     kfree(itable);
> >                       pirq_table = NULL;
> > +             }
>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>
> Thanks,
>
>         Ingo
