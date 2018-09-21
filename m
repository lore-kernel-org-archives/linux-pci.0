Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525DCC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0404821568
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 18:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rof+nxiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0404821568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390619AbeIUXuy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:50:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37934 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390076AbeIUXuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 19:50:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so12499961ljc.5;
        Fri, 21 Sep 2018 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV9abJpc/Fo58oWk1J7NQlZY21GsuG1jmymWDui8Jso=;
        b=rof+nxiVlEzxSLx5DEsflOy4nHw0Y52YnaFDsrxTBX3PI/1gF6cw0II4XLbuJ8YD+j
         BcqKjIa/91gHPGpKZXCIm2T7TG53Ajm/5UJ/djHFq+jQcA+FtoCouuSUdqM3l8KDe+Nf
         Qeqrxnfq5cDR77xAyZSvmiPzxG72Eq1+OZNz1WQ1ZrI2eU1NPcSRkkYh/uKu4Z9totYn
         sb1IycYk/u5nSO0hx/UIMIuas8r2gdbU6umxovoUXpharPug8EBV6c2n0SCVi3cGLMTY
         rQaa+bpuK/PqDFIwbjOGtU4+mydBWPbF/dxVJsJMmgI5LbDzIFFlxfwldQbMO4Z3V0Ul
         QDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV9abJpc/Fo58oWk1J7NQlZY21GsuG1jmymWDui8Jso=;
        b=ZnbyX18ccXIlh61uTZkGCkP767ubXOxc0LzpEukfM+rX3e4QPLpCEEpnAXrOIIcLdk
         SIinpCdmnyN4mPI63tirGkVp10DEN42am/ENlF5J3/snxBu09zDYzSQG/EQchtkdMcrm
         GKS/iauD6zPUAESSU9pwfONIyjptimm0ElBvtqvz/8CtAjqRx7zTfnDfSJ1W665UeJM7
         /JLMZQuhMEKreCGEr31uj89zbDN1SlvFm1W1m140uzPPOq1QYoYnHGxnRUIdj94+IAKd
         QiJEJ6+Gi0wQC3hbetf53gE9W553ru631tGgK1zNlKjUSl92dtKF80muCiblke9SA7F0
         F/4w==
X-Gm-Message-State: ABuFfoh4HeXGsjJWSPf9Ph+yEtUhltufgzbC10lJqpyeYa55XkrZIKjy
        iWYS1Noon60tOk2pi0dGGa31oUp4YYoithhJugU=
X-Google-Smtp-Source: ACcGV62v75zXJxjwoIDlGI7nyRx6PACjrkbZOoNZS0yIgMzhANsNcwLVKamcpUErrmFtpGX6pdsZZHmiswcna5TjyiA=
X-Received: by 2002:a2e:93c4:: with SMTP id p4-v6mr2694146ljh.150.1537552851268;
 Fri, 21 Sep 2018 11:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-3-git-send-email-jim2101024@gmail.com> <CAOiHx=mEKoHz6t=PbnG801e2u8GG=ct7ypMTKZ=EALKJhBZf=g@mail.gmail.com>
In-Reply-To: <CAOiHx=mEKoHz6t=PbnG801e2u8GG=ct7ypMTKZ=EALKJhBZf=g@mail.gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 21 Sep 2018 14:00:39 -0400
Message-ID: <CANCKTBs1VqJCFFJAseJ8Kk8_d7PnniD55dc20-NwAKj8f6jFmw@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] dt-bindings: pci: add DT docs for Brcmstb PCIe device
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 20, 2018 at 5:06 AM Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
> On 19 September 2018 at 16:31, Jim Quinlan <jim2101024@gmail.com> wrote:
> > The DT bindings description of the Brcmstb PCIe device is described.
> > This node can be used by almost all Broadcom settop box chips, using
> > ARM, ARM64, or MIPS CPU architectures.
>
> Oh, hey, *one* email made it finally through :P

Sigh, I'm still having email issues, my apologies.

>
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> > new file mode 100644
> > index 0000000..a1a9ad5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> > @@ -0,0 +1,59 @@
> > +Brcmstb PCIe Host Controller Device Tree Bindings
> > +
> > +Required Properties:
> > +- compatible
> > +  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
> > +  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
> > +  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
> > +      the 7278).
> > +  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
> > +
> > +- reg -- the register start address and length for the PCIe reg block.
> > +- interrupts -- two interrupts are specified; the first interrupt is for
> > +     the PCI host controller and the second is for MSI if the built-in
> > +     MSI controller is to be used.
> > +- interrupt-names -- names of the interrupts (above): "pcie" and "msi".
> > +- #address-cells -- set to <3>.
> > +- #size-cells -- set to <2>.
> > +- #interrupt-cells: set to <1>.
> > +- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> > +     mapping of the PCIe interface to interrupt numbers.
> > +- ranges: ranges for the PCI memory and I/O regions.
> > +- linux,pci-domain -- should be unique per host controller.
> > +
> > +Optional Properties:
> > +- clocks -- phandle of pcie clock.
> > +- clock-names -- set to "sw_pcie" if clocks is used.
> > +- dma-ranges -- Specifies the inbound memory mapping regions when
> > +     an "identity map" is not possible.
> > +- msi-controller -- this property is typically specified to have the
> > +     PCIe controller use its internal MSI controller.
> > +- msi-parent -- set to use an external MSI interrupt controller.
> > +- brcm,enable-ssc -- (boolean) indicates usage of spread-spectrum clocking.
> > +- max-link-speed --  (integer) indicates desired generation of link:
> > +     1 => 2.5 Gbps (gen1), 2 => 5.0 Gbps (gen2), 3 => 8.0 Gbps (gen3).
> > +
> > +Example Node:
> > +
> > +pcie0: pcie@f0460000 {
> > +               reg = <0x0 0xf0460000 0x0 0x9310>;
> > +               interrupts = <0x0 0x0 0x4>;
>
> Your binding says two interrupts, your example has three - what's the
> third interrupt for?

Actually that's a single interrupt with three cells.  I need to add
another interrupt.  Note that we have #interrupt-cells set to 1
because that is for the legacy interrupts given in the interrupt-map.

> Also you define the same for MSI and PCIe (I assume) - is that expected?
No, these will be updated to two different interrupts.

Are there systems where they are
> different? I would expect the msi interrupt to be optional for the
> case where its the same as the pcie one, and only required if it is
> different.
>
> Also your binding requires an interrupt-names propery, but it's
> missing from the example.
Will fix.

Thanks,
Jim
>
> > +               compatible = "brcm,bcm7445-pcie";
> > +               #address-cells = <3>;
> > +               #size-cells = <2>;
> > +               ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
> > +                         0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
> > +               #interrupt-cells = <1>;
> > +               interrupt-map-mask = <0 0 0 7>;
> > +               interrupt-map = <0 0 0 1 &intc 0 47 3
> > +                                0 0 0 2 &intc 0 48 3
> > +                                0 0 0 3 &intc 0 49 3
> > +                                0 0 0 4 &intc 0 50 3>;
> > +               clocks = <&sw_pcie0>;
> > +               clock-names = "sw_pcie";
> > +               msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
> > +               msi-controller;         /* use PCIe's internal MSI controller */
> > +               brcm,ssc;
> > +               max-link-speed = <1>;
> > +               linux,pci-domain = <0>;
> > +       };
> > --
> > 1.9.0.138.g2de3478
> >
>
> Regards
> Jonas
