Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52356 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbeEDLTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 May 2018 07:19:04 -0400
Date: Fri, 4 May 2018 12:18:51 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 3/9] PCI: endpoint: functions/pci-epf-test: Add second
 entry
Message-ID: <20180504111843.GA5930@e107981-ln.cambridge.arm.com>
References: <20180426165605.GA6370@e107981-ln.cambridge.arm.com>
 <b65caf2e-b002-f591-6215-ff2241b2dfb8@ti.com>
 <20180501115417.GD19391@e107981-ln.cambridge.arm.com>
 <5d625d04-38fe-7d5a-67fc-5ea92039474c@ti.com>
 <20180501142607.GA21911@e107981-ln.cambridge.arm.com>
 <bfaebf3c-2175-f4b2-89c5-336ff9396ed0@synopsys.com>
 <20180502165144.GB4871@e107981-ln.cambridge.arm.com>
 <cf2772d5-26c0-b0e3-1e5b-ace91c1ea105@ti.com>
 <20180503141636.GA23270@e107981-ln.cambridge.arm.com>
 <aeb80d31-c79e-80a9-5e67-9bf1f277f39a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aeb80d31-c79e-80a9-5e67-9bf1f277f39a@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 04, 2018 at 11:28:58AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On Thursday 03 May 2018 07:46 PM, Lorenzo Pieralisi wrote:
> > On Thu, May 03, 2018 at 12:03:15PM +0530, Kishon Vijay Abraham I wrote:
> > 
> > [...]
> > 
> >>>> Since the linkup notifier and BAR index (where auxiliary registers are
> >>>> located) may be configurable and is something platform dependent,
> >>>> perhaps the configuration of this variables should be done by module
> >>>> parameter and not by configfs, leaving this configuration
> >>>> responsibility in charge of each platform.
> >>>
> >>> They are platform dependent because they depend on the EP controller.
> >>> That's why I said that those are EP controller parameters. I do not
> >>> think they are module parameters either - they should be part of HW
> >>> description in firmware.
> >>
> >> The problem is because pci-epf-test cannot be described in HW. pci-epf-test is
> >> also not automatically bound to the EP controller but is bound by the user like
> >> below
> >> ln -s functions/pci_epf_test/func1 controllers/51000000.pcie_ep/
> >>
> >> So given that user anyways has to bind the epf device to the controller, based
> >> on the platform the user can use a different configfs entry like below
> >> ln -s functions/pci_epf_test_dw/func1 controllers/51000000.pcie_ep/ or
> >> ln -s functions/pci_epf_test_k2g/func1 controllers/21800000.pcie-ep/
> >>
> >> If the epf can be described in dt, then something like below can be done
> >> pcie1_ep: pcie_ep@51000000 {
> >> 	compatible = "ti,dra7-pcie-ep";
> >> 	interrupts = <0 232 0x4>;
> >> 	num-lanes = <1>;
> >> 	num-ib-windows = <4>;
> >> 	num-ob-windows = <16>;
> >> 	phys = <&pcie1_phy>;
> >> 	phy-names = "pcie-phy0";
> >> 	pci_epf_test: pci_epf_test@0 {
> >> 		name = "pci_epf_test_dw";
> >> 		<other properties>;
> >> 	}
> >> };
> >>
> >> With this pci-dra7xx.c driver should create pci_epf_device using
> >> pci_epf_create("pci_epf_test_dw");
> >>
> >> Then the driver_data corresponding to "pci_epf_test_dw" will select linkup
> >> notifier or BAR index etc.
> > 
> > Those two properties are properties of the EP controller (it is not 100%
> > clear to me how the test BAR register is defined), is this correct ?
> 
> Right, these properties are specific to a platform. In some of the platforms
> like K2G (BAR0 is reserved i.e it is used to map PCIe app registers and cannot
> be used by pci_epf_test. In such cases we should use a BAR other than BAR0).

I do not think those properties are pci_epf_test specific, that's the
whole point I am making. Those are EPC controller features.

> > If yes, given that those properties are not useful before an EPF is
> > bound to an EPC, can't they be retrieved at bind time from the EPC
> > controller data (that we can add through DT bindings) ?
> 
> hmm..
> 
> We can have quirk in pci_epc, something like below
> 
> struct pci_epc {
> 	.
> 	.
> 	unsigned int quirks;
> 	.
> 	.
> };
> 
> #define EPC_QUIRKS_NO_LINKUP_NOTIFIER	BIT(0)
> #define EPC_QUIRKS_BAR0_RESERVED	BIT(1)
> #define EPC_QUIRKS_BAR1_RESERVED	BIT(2)
> #define EPC_QUIRKS_BAR2_RESERVED	BIT(3)
> #define EPC_QUIRKS_BAR3_RESERVED	BIT(4)
> #define EPC_QUIRKS_BAR4_RESERVED	BIT(5)
> #define EPC_QUIRKS_BAR5_RESERVED	BIT(6)
> 
> The controller driver can set the appropriate quirks
> epc->quirks |= EPC_QUIRKS_NO_LINKUP_NOTIFIER | EPC_QUIRKS_BAR0_RESERVED;
> 
> Then pci-epf-test driver can checks the quirks to see the supported EPC features.
> 
> Does something like above looks okay to you?

Well, it is better than the driver_data approach, I would not call them
quirks but features and for the BARs you should define a mask it does
not make sense to enumerate them. It is probably a good idea to leave
room for additional "features" so please choose the bits placement
wisely.

Thanks,
Lorenzo
