Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0087.outbound.protection.outlook.com ([207.46.100.87]:26592
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753635AbbJZK0p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2015 06:26:45 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v4] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Mon, 26 Oct 2015 10:26:38 +0000
Message-ID: <8520D5D51A55D047800579B09414719801692D8E@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1445066538-24638-1-git-send-email-bharatku@xilinx.com>
 <5705956.6YyKSO4LdH@wuerfel>
In-Reply-To: <5705956.6YyKSO4LdH@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > +       device_type = "pci";
> > +       interrupt-parent = <&gic>;
> > +       interrupts = < 0 118 4
> > +                      0 116 4
> > +                      0 115 4          // MSI_1 [63...32]
> > +                      0 114 4 >;       // MSI_0 [31...0]
> 
> Better write these as tuples:
> 
> 	interrupts = <0 118 4>, <0 116 4>, <0 115 4>, <0 114 4>;
> 
> And maybe reverse the order? It looks that might be what the soc
> integration person had in mind.
> 
> Also, what is interrupt <0 117 4>? Is that connected here as well?
> Better list it as well then, even if you don't use it.
> 
We have it but not using it, we will list it.

> > +       interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> > +       interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1
> > +                        0x0 0x0 0x0 0x2 &pcie_intc 0x2
> > +                        0x0 0x0 0x0 0x3 &pcie_intc 0x3
> > +                        0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
> 
> > +       msi-parent = <&nwl_pcie>;
> > +       reg = <0x0 0xfd0e0000 0x1000
> > +              0x0 0xfd480000 0x1000
> > +              0x0 0xE0000000 0x1000000>;
> 
> Same grouping for reg and interrupt-map as above for interrupts.

Grouping reg and interrupt-map as tuples will make lengthy line and reduces readability, is it compulsory ?
> 
> > +       reg-names = "breg", "pcireg", "cfg";
> > +       ranges = <0x02000000 0x00000000 0xE1000000 0x00000000
> > + 0xE1000000 0 0x0F000000>;
> 
> No I/O space or prefetcheable memory?
> 
> 	Arnd
