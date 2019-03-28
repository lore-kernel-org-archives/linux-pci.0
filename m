Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B1FC10F03
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 16:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFD820693
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 16:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfC1QcG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:32:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35685 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1QcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 12:32:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id e1so12493414vsp.2;
        Thu, 28 Mar 2019 09:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEjKnpBtYMgzuamyOdK751vAyLPO1HmSF4gNbz/laBA=;
        b=cIV5arXlTN6wvrcuibLS8eOhV+roCjIhZJQr0svwX415yPdP8T0cwDOmmoYOGE7hXT
         OT9ugL2NJH6LEAfJ8h5vkKjVmZw7yg8q//sSBlJGdtCzlSh2hOc7Z9iIE8RICed8VfyF
         NXa+AfNveqCv+biwPAVeGbx6PzALWKsUt6OspZvUrMsNfiWAXqXIGFHuccwu2NfI99YN
         MWypBelrvRYumLXIlqI67AWMxMcCZvzjqP3Fr46/zVLF0MD3NBeHLeqPYfuFk3IJpR8Z
         qXXo+m/DCfCkh8gdP0fQAzS5CfoqJ1rrH3xT4Bzw9YNcGrCJ2gZ1FPwN5XwC2Po045mk
         cHyA==
X-Gm-Message-State: APjAAAVIK6lpMJGrCU8qbq+LUgHo4+XMJJ6kmtmb7XYJnY7kzqcV7HQ8
        caHea5rTEKFqkGb3wByoYk0Flu/fcJyfF8UBvRc=
X-Google-Smtp-Source: APXvYqx8yEp1Yu4tPDjEMUM55a/2qCHVUB8wEAxCVjhHr2FNJsmV01809Bf7ih4Mt6XF9bUkBTb/wUZ6jK5OzRSadOY=
X-Received: by 2002:a67:f843:: with SMTP id b3mr26539050vsp.152.1553790724229;
 Thu, 28 Mar 2019 09:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190325114101.10198-1-marek.vasut@gmail.com> <20190325114101.10198-6-marek.vasut@gmail.com>
 <20190327113023.zhnx5v5spcx7uoqj@verge.net.au> <CAMuHMdW_6hutek-vk+mwDHJ1kBUytLvtkgLKb2mkSEFFasJ_0g@mail.gmail.com>
 <efcf526b-cfbc-ea54-f97e-f280e1f672fa@gmail.com> <CAMuHMdU7dQ=8UaSCoZ8TucMfaGyu38rxDYV=Tspw_UmCu5YVwQ@mail.gmail.com>
 <20190328162857.GB19825@red-moon>
In-Reply-To: <20190328162857.GB19825@red-moon>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Mar 2019 17:31:52 +0100
Message-ID: <CAMuHMdWuGx8wDmW7LZ3mbocieL1ZaKBvr=Um4XZ8FKdjiFqdzA@mail.gmail.com>
Subject: Re: [PATCH V4 6/6] PCI: rcar: Fix 64bit MSI message address handling
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Thu, Mar 28, 2019 at 5:28 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Mar 28, 2019 at 09:02:00AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 28, 2019 at 4:19 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> > > On 3/27/19 1:22 PM, Geert Uytterhoeven wrote:
> > > > On Wed, Mar 27, 2019 at 12:30 PM Simon Horman <horms@verge.net.au> wrote:
> > > >> On Mon, Mar 25, 2019 at 12:41:01PM +0100, marek.vasut@gmail.com wrote:
> > > >>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > >>> The MSI message address in the RC address space can be 64 bit. The
> > > >>> R-Car PCIe RC supports such a 64bit MSI message address as well.
> > > >>> The code currently uses virt_to_phys(__get_free_pages()) to obtain
> > > >>> a reserved page for the MSI message address, and the return value
> > > >>> of which can be a 64 bit physical address on 64 bit system.
> > > >>>
> > > >>> However, the driver only programs PCIEMSIALR register with the bottom
> > > >>> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
> > > >>> not program the top 32 bits into PCIEMSIAUR, but rather programs the
> > > >>> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
> > > >>> SoCs, however may fail on new 64 bit R-Car SoCs.
> > > >>>
> > > >>> Since from a PCIe controller perspective, an inbound MSI is a memory
> > > >>> write to a special address (in case of this controller, defined by
> > > >>> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
> > > >>> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
> > > >>> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
> > > >>> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
> > > >>> cause memory corruption or other issues.
> > > >>>
> > > >>> There is however the possibility that if virt_to_phys(__get_free_pages())
> > > >>> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
> > > >>> to 0x0 _and_ if the system had physical RAM at the address matching the
> > > >>> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
> > > >>> physical address matching the value of PCIEMSIALR and a remote write to
> > > >>> such a buffer by a PCIe card would trigger a spurious MSI.
> > > >>>
> > > >>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > >>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > > >>> Cc: Simon Horman <horms+renesas@verge.net.au>
> > > >>> Cc: Wolfram Sang <wsa@the-dreams.de>
> > > >>> Cc: linux-renesas-soc@vger.kernel.org
> > > >>> To: linux-pci@vger.kernel.org
> > > >>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >>
> > > >> Does this warrant a Fixes tag?
> > > >
> > > > (digging in old sent email)
> > > > Fixes: 290c1fb358605402 ("PCI: rcar: Add MSI support for PCIe")
> > >
> > > But does it really fix that commit, given that on Gen2 and earlier, it
> > > was not broken as those were 32bit platforms ?
> >
> > It does not fix the bug on that commit, as the bug cannot happen on arm32.
> > It does fix that commit, in that that commit used "unsigned long" for a
> > physical address, which is wrong, even on arm32 (esp. with LPAE).
> > If you insist on having a Fixes tag for a commit where the bug could be
> > seen:
> > Fixes: e015f88c368da1e6 ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
> >
> > Apart from that, drivers should use the DMA API instead of virt_to_phys().
> > However, now we have a better understanding of how MSI interrupts
> > work, we don't even need to allocate that page. All we need is the
> > physical address of a page that is guaranteed not to be backed by RAM
> > (i.e. not to be a valid target for a legitimate PCI bus mastering
> > transaction).
>
> Agreed but I would merge this patch first since it is a fix
> and update it later.

Sure, definitely.

> Shall I go with the Fixes: tag above ?

Fine for me, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
