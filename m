Return-Path: <SRS0=MrkT=VI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E3C74A4B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Jul 2019 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1C0208E4
	for <linux-pci@archiver.kernel.org>; Thu, 11 Jul 2019 09:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfGKJcS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:32:18 -0400
Received: from foss.arm.com ([217.140.110.172]:43814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfGKJcS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jul 2019 05:32:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B681F337;
        Thu, 11 Jul 2019 02:32:17 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 987363F71F;
        Thu, 11 Jul 2019 02:32:15 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:32:10 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     Jonathan Chocron <jonnyc@amazon.com>, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, hanochu@amazon.com, hhhawa@amazon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe
 host bridge binding
Message-ID: <20190711093210.GA26088@e121166-lin.cambridge.arm.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
 <20190710164519.17883-6-jonnyc@amazon.com>
 <36e8c3b0-feeb-db8f-3808-0218b54adcec@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e8c3b0-feeb-db8f-3808-0218b54adcec@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 11, 2019 at 10:12:35AM +0300, Shenhar, Talel wrote:
> 
> On 7/10/2019 7:45 PM, Jonathan Chocron wrote:
> > Document Amazon's Annapurna Labs PCIe host bridge.
> 
> That is the way! (best to keep same wordings (Amazon's)

Guys,

as a heads-up, the original posting, for whatever reason, did not hit
linux-pci@vger, which means that from a PCI patches queue review point
of view it does not exist.

It ought to be fixed otherwise we won't be able to review the code.

Lorenzo

> > 
> > Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> > ---
> >   .../devicetree/bindings/pci/pcie-al.txt       | 45 +++++++++++++++++++
> >   MAINTAINERS                                   |  1 +
> >   2 files changed, 46 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
> > new file mode 100644
> > index 000000000000..d92cc529490e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
> > @@ -0,0 +1,45 @@
> > +* Amazon Annapurna Labs PCIe host bridge
> > +
> > +Annapurna Labs' PCIe Host Controller is based on the Synopsys DesignWare
> 
> Amazon's
> 
> 
> and what is the s' ? should it be for all
> 
> > +Example:
> > +
> > +	pcie-external0 {
> probably should have a reference with the address
> > +		compatible = "amazon,al-pcie";
> > +		reg = <0x0 0xfb600000 0x0 0x00100000
> > +		       0x0 0xfd800000 0x0 0x00010000
> > +		       0x0 0xfd810000 0x0 0x00001000>;
> > +		reg-names = "config", "controller", "dbi";
> > +		bus-range = <0 255>;
> > +		device_type = "pci";
> > +		#address-cells = <3>;
> > +		#size-cells = <2>;
> > +		#interrupt-cells = <1>;
> > +		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-map-mask = <0x00 0 0 7>;
> > +		interrupt-map = <0x0000 0 0 1 &gic_main GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>; /* INTa */
> gic_main->gic
> > +		ranges = <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
> > +	};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5a6137df3f0e..d555beb794bb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12205,6 +12205,7 @@ PCIE DRIVER FOR ANNAPURNA LABS
> AMAZON!
> >   M:	Jonathan Chocron <jonnyc@amazon.com>
> >   L:	linux-pci@vger.kernel.org
> >   S:	Maintained
> > +F:	Documentation/devicetree/bindings/pci/pcie-al.txt
> >   F:	drivers/pci/controller/dwc/pcie-al.c
> >   PCIE DRIVER FOR AMLOGIC MESON
