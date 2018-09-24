Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D3ECE568
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 20:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B72087A
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 20:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6B72087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeIYC5d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:57:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34148 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeIYC5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 22:57:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id x23-v6so11079839qtr.1;
        Mon, 24 Sep 2018 13:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIrtdQ364BeyHhq+FNO7GGk/sMLbUf4kKqcB3Gpb1I0=;
        b=WRwwnEc/e7MRJ5erX6Nj2KGLRXiA5UCvkMeM3/td1sKr9TBBq2y9guDl/3RNehr+hD
         cLRfAgRqjF9CyPTwG0/oqNicA7rkDBycf+UR5dgRB+MJBiahJ/7udhkwuHCxYvCNCUh7
         5QC8wXZsCGUpSKml7l7m18GtE/2dkqnWF8l50IHDH7uorIrmeLhsoI0NFOAUl9LlhVcP
         kI++iQ57g0SHoJQOYGMINf+iwbmuL1qSeFUrcXpJWnBUnum/lFcHUusxgxMoBoieByqt
         c/7AbZbCZMWh3/z4iQeh6AskrjTjweB6TnrZQm2bg5c3cOHFVrBQR+iICLoItaMiNBtM
         N5iQ==
X-Gm-Message-State: ABuFfoguFPtFxzAILFK+XU2wJJgnxvMa599L0ouQCtK1zRV5kVeoNUzk
        fzENA9I8kJ+1nnpCgMLZ4e1PPA2B9axZEHNKgg4=
X-Google-Smtp-Source: ACcGV61z02eSwVfJbY0fvvqTjpZ94LZDg6tQ1XzrFcsKZCa1MUJR3dgXFarwtqyUn0DfDFeV5UZRyvMUKnu4sLTY/kk=
X-Received: by 2002:ac8:7254:: with SMTP id l20-v6mr479300qtp.213.1537822409634;
 Mon, 24 Sep 2018 13:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-2-git-send-email-ray.jui@broadcom.com> <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
 <20180918134152.GA31440@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180918134152.GA31440@e107981-ln.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 22:53:13 +0200
Message-ID: <CAK8P3a3cWHK=DNCFn+p_NjSyXhoLQw07EVedVf5-UFdz4V4OPA@mail.gmail.com>
Subject: Re: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 18, 2018 at 3:42 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Jun 04, 2018 at 09:17:49AM -0500, Rob Herring wrote:
> > +Arnd
> >
> > On Tue, May 29, 2018 at 4:58 PM, Ray Jui <ray.jui@broadcom.com> wrote:
> > > Update the iProc PCIe binding document for better modeling of the legacy
> > > interrupt (INTx) support
> > >
> > > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > > ---
> > >  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
> > >  1 file changed, 24 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > index b8e48b4..7ea24dc 100644
> > > --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > @@ -13,9 +13,6 @@ controller, used in Stingray
> > >    PAXB-based root complex is used for external endpoint devices. PAXC-based
> > >  root complex is connected to emulated endpoint devices internal to the ASIC
> > >  - reg: base address and length of the PCIe controller I/O register space
> > > -- #interrupt-cells: set to <1>
> > > -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> > > -  mapping of the PCIe interface to interrupt numbers
> > >  - linux,pci-domain: PCI domain ID. Should be unique for each host controller
> > >  - bus-range: PCI bus numbers covered
> > >  - #address-cells: set to <3>
> > > @@ -41,6 +38,16 @@ Required:
> > >  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
> > >  address used by the iProc PCIe core (not the PCIe address)
> > >
> > > +Legacy interrupt (INTx) support (optional):
> > > +
> > > +Note INTx is for PAXB only.
> > > +
> > > +- interrupt-controller: claims itself as an interrupt controller for INTx
> > > +- #interrupt-cells: set to <1>
> > > +- interrupt-map-mask and interrupt-map, standard PCI properties to define
> > > +the mapping of the PCIe interface to interrupt numbers
> > > +- interrupts: interrupt line wired to the generic GIC for INTx support
> > > +
> > >  MSI support (optional):
> > >
> > >  For older platforms without MSI integrated in the GIC, iProc PCIe core provides
> > > @@ -77,9 +84,14 @@ Example:
> > >                 compatible = "brcm,iproc-pcie";
> > >                 reg = <0x18012000 0x1000>;
> > >
> > > +               interrupt-controller;
> > >                 #interrupt-cells = <1>;
> > > -               interrupt-map-mask = <0 0 0 0>;
> > > -               interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> > > +               interrupt-map-mask = <0 0 0 7>;
> > > +               interrupt-map = <0 0 0 1 &pcie0 1>,
> >
> > Are you sure this works? The irq parsing code will ignore
> > interrupt-map if interrupt-controller is found. In other words, you
> > should have one or the other, but not both.
> >
> > Maybe it happens to work because "pcie0" is this node and your irq
> > numbers are the same.
> >
> > Arnd, any thoughts on this?
>
> To start with, I think the destination IRQ number is wrong, what the
> mappings actually do is mapping the PCI interrupt line (ie #INTA, #INTB,
> #INTC, #INTD) to input {0,1,2,3} of the PCI host bridge (pseudo)
> interrupt controller.
>
> I really want to clean this up since currently there are different
> DT bindings defining this in different ways which resulted in
> non-consistent kernel code.
>
> AFAICS, the Aardvark PCIe controller bindings define the mapping
> as I expect:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/aardvark-pci.txt?h=v4.19-rc4
>
> but I would like to get Rob and Arnd viewpoint on this so that
> we can close this topic once for all.

It seems ambiguous at best, as Rob suggested it may only
work by accident. Since there is only one upstream interrupt,
could we simply list <GIC_SPI 100 IRQ_TYPE_NONE> as
the destination for any IntX?

        Arnd
