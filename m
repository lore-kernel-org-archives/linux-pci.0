Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F747C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 10:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDCD20842
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 10:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDCD20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeIYQ4u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:56:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbeIYQ4u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 12:56:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 158997A9;
        Tue, 25 Sep 2018 03:49:53 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AC9B3F5B7;
        Tue, 25 Sep 2018 03:49:51 -0700 (PDT)
Date:   Tue, 25 Sep 2018 11:50:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
Message-ID: <20180925105027.GA29857@red-moon>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
 <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
 <20180918134152.GA31440@e107981-ln.cambridge.arm.com>
 <CAK8P3a3cWHK=DNCFn+p_NjSyXhoLQw07EVedVf5-UFdz4V4OPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3cWHK=DNCFn+p_NjSyXhoLQw07EVedVf5-UFdz4V4OPA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 10:53:13PM +0200, Arnd Bergmann wrote:
> On Tue, Sep 18, 2018 at 3:42 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Mon, Jun 04, 2018 at 09:17:49AM -0500, Rob Herring wrote:
> > > +Arnd
> > >
> > > On Tue, May 29, 2018 at 4:58 PM, Ray Jui <ray.jui@broadcom.com> wrote:
> > > > Update the iProc PCIe binding document for better modeling of the legacy
> > > > interrupt (INTx) support
> > > >
> > > > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > > > ---
> > > >  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
> > > >  1 file changed, 24 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > > index b8e48b4..7ea24dc 100644
> > > > --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > > +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > > @@ -13,9 +13,6 @@ controller, used in Stingray
> > > >    PAXB-based root complex is used for external endpoint devices. PAXC-based
> > > >  root complex is connected to emulated endpoint devices internal to the ASIC
> > > >  - reg: base address and length of the PCIe controller I/O register space
> > > > -- #interrupt-cells: set to <1>
> > > > -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> > > > -  mapping of the PCIe interface to interrupt numbers
> > > >  - linux,pci-domain: PCI domain ID. Should be unique for each host controller
> > > >  - bus-range: PCI bus numbers covered
> > > >  - #address-cells: set to <3>
> > > > @@ -41,6 +38,16 @@ Required:
> > > >  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
> > > >  address used by the iProc PCIe core (not the PCIe address)
> > > >
> > > > +Legacy interrupt (INTx) support (optional):
> > > > +
> > > > +Note INTx is for PAXB only.
> > > > +
> > > > +- interrupt-controller: claims itself as an interrupt controller for INTx
> > > > +- #interrupt-cells: set to <1>
> > > > +- interrupt-map-mask and interrupt-map, standard PCI properties to define
> > > > +the mapping of the PCIe interface to interrupt numbers
> > > > +- interrupts: interrupt line wired to the generic GIC for INTx support
> > > > +
> > > >  MSI support (optional):
> > > >
> > > >  For older platforms without MSI integrated in the GIC, iProc PCIe core provides
> > > > @@ -77,9 +84,14 @@ Example:
> > > >                 compatible = "brcm,iproc-pcie";
> > > >                 reg = <0x18012000 0x1000>;
> > > >
> > > > +               interrupt-controller;
> > > >                 #interrupt-cells = <1>;
> > > > -               interrupt-map-mask = <0 0 0 0>;
> > > > -               interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> > > > +               interrupt-map-mask = <0 0 0 7>;
> > > > +               interrupt-map = <0 0 0 1 &pcie0 1>,
> > >
> > > Are you sure this works? The irq parsing code will ignore
> > > interrupt-map if interrupt-controller is found. In other words, you
> > > should have one or the other, but not both.
> > >
> > > Maybe it happens to work because "pcie0" is this node and your irq
> > > numbers are the same.
> > >
> > > Arnd, any thoughts on this?
> >
> > To start with, I think the destination IRQ number is wrong, what the
> > mappings actually do is mapping the PCI interrupt line (ie #INTA, #INTB,
> > #INTC, #INTD) to input {0,1,2,3} of the PCI host bridge (pseudo)
> > interrupt controller.
> >
> > I really want to clean this up since currently there are different
> > DT bindings defining this in different ways which resulted in
> > non-consistent kernel code.
> >
> > AFAICS, the Aardvark PCIe controller bindings define the mapping
> > as I expect:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/aardvark-pci.txt?h=v4.19-rc4
> >
> > but I would like to get Rob and Arnd viewpoint on this so that
> > we can close this topic once for all.
> 
> It seems ambiguous at best, as Rob suggested it may only
> work by accident. Since there is only one upstream interrupt,
> could we simply list <GIC_SPI 100 IRQ_TYPE_NONE> as
> the destination for any IntX?

I think that would not be correct from an HW description standpoint
since there is some logic in the host bridge that behaves as an
interrupt controller (eg registers to ack/mask IRQs).

AFAICS the aardvark (it is an example) bindings below should be correct,
with an interrupt controller node within the PCI host bridge:

	pcie0: pcie@d0070000 {
		compatible = "marvell,armada-3700-pcie";
		device_type = "pci";
		reg = <0 0xd0070000 0 0x20000>;
		#address-cells = <3>;
		#size-cells = <2>;
		bus-range = <0x00 0xff>;
		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
		#interrupt-cells = <1>;
		msi-controller;
		msi-parent = <&pcie0>;
		ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
			  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
		interrupt-map-mask = <0 0 0 7>;
		interrupt-map = <0 0 0 1 &pcie_intc 0>,
				<0 0 0 2 &pcie_intc 1>,
				<0 0 0 3 &pcie_intc 2>,
				<0 0 0 4 &pcie_intc 3>;
		pcie_intc: interrupt-controller {
			interrupt-controller;
			#interrupt-cells = <1>;
		};
	};

Thoughts ?

Lorenzo
