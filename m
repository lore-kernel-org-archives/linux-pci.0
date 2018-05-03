Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 May 2018 15:16:36 +0100
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
Message-ID: <20180503141636.GA23270@e107981-ln.cambridge.arm.com>
References: <cover.1524577064.git.gustavo.pimentel@synopsys.com>
 <c6cfd167838ae8e226dee0820983efe918fa4e1f.1524577064.git.gustavo.pimentel@synopsys.com>
 <20180426165605.GA6370@e107981-ln.cambridge.arm.com>
 <b65caf2e-b002-f591-6215-ff2241b2dfb8@ti.com>
 <20180501115417.GD19391@e107981-ln.cambridge.arm.com>
 <5d625d04-38fe-7d5a-67fc-5ea92039474c@ti.com>
 <20180501142607.GA21911@e107981-ln.cambridge.arm.com>
 <bfaebf3c-2175-f4b2-89c5-336ff9396ed0@synopsys.com>
 <20180502165144.GB4871@e107981-ln.cambridge.arm.com>
 <cf2772d5-26c0-b0e3-1e5b-ace91c1ea105@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cf2772d5-26c0-b0e3-1e5b-ace91c1ea105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 12:03:15PM +0530, Kishon Vijay Abraham I wrote:

[...]

> >> Since the linkup notifier and BAR index (where auxiliary registers are
> >> located) may be configurable and is something platform dependent,
> >> perhaps the configuration of this variables should be done by module
> >> parameter and not by configfs, leaving this configuration
> >> responsibility in charge of each platform.
> > 
> > They are platform dependent because they depend on the EP controller.
> > That's why I said that those are EP controller parameters. I do not
> > think they are module parameters either - they should be part of HW
> > description in firmware.
> 
> The problem is because pci-epf-test cannot be described in HW. pci-epf-test is
> also not automatically bound to the EP controller but is bound by the user like
> below
> ln -s functions/pci_epf_test/func1 controllers/51000000.pcie_ep/
> 
> So given that user anyways has to bind the epf device to the controller, based
> on the platform the user can use a different configfs entry like below
> ln -s functions/pci_epf_test_dw/func1 controllers/51000000.pcie_ep/ or
> ln -s functions/pci_epf_test_k2g/func1 controllers/21800000.pcie-ep/
> 
> If the epf can be described in dt, then something like below can be done
> pcie1_ep: pcie_ep@51000000 {
> 	compatible = "ti,dra7-pcie-ep";
> 	interrupts = <0 232 0x4>;
> 	num-lanes = <1>;
> 	num-ib-windows = <4>;
> 	num-ob-windows = <16>;
> 	phys = <&pcie1_phy>;
> 	phy-names = "pcie-phy0";
> 	pci_epf_test: pci_epf_test@0 {
> 		name = "pci_epf_test_dw";
> 		<other properties>;
> 	}
> };
> 
> With this pci-dra7xx.c driver should create pci_epf_device using
> pci_epf_create("pci_epf_test_dw");
> 
> Then the driver_data corresponding to "pci_epf_test_dw" will select linkup
> notifier or BAR index etc.

Those two properties are properties of the EP controller (it is not 100%
clear to me how the test BAR register is defined), is this correct ?

If yes, given that those properties are not useful before an EPF is
bound to an EPC, can't they be retrieved at bind time from the EPC
controller data (that we can add through DT bindings) ?

Thanks,
Lorenzo
