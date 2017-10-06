Return-Path: <SRS0=su7V=BF=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=su7V=BF=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171006224503.GH25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
 <20170828180437.2646-2-ard.biesheuvel@linaro.org> <20170926173200.GL15970@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu8CCcm_R3S1PbXZFqzvjAJVfU_bKpimVxbeQ78ciAgJyA@mail.gmail.com>
 <CAKv+Gu_MM--uHwQk_brJh1bPOdsUTH4j+aJUDyS1um3mHDdsEA@mail.gmail.com> <20171006224503.GH25517@bhelgaas-glaptop.roam.corp.google.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 7 Oct 2017 00:10:23 +0100
Message-ID: <CAKv+Gu9mcTfpDGse-QpiGDwzR7j-zV+kYQ7Ysmmi61-2a_R7Ew@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pci: designware: add driver for DWC controller in
 ECAM shift mode
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>,
	Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, Rob Herring <robh@kernel.org>,
	Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 6 October 2017 at 23:45, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Oct 06, 2017 at 03:52:03PM +0100, Ard Biesheuvel wrote:
>> On 28 September 2017 at 16:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 26 September 2017 at 10:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >> [+cc Will]
>> >>
>> >> On Mon, Aug 28, 2017 at 07:04:36PM +0100, Ard Biesheuvel wrote:
>> >>> Some implementations of the Synopsys Designware PCIe controller implement
>> >>> a so-called ECAM shift mode, which allows a static memory window to be
>> >>> configured that covers the configuration space of the entire bus range.
>> >>>
>> >>> If the firmware performs all the low level configuration that is required
>> >>> to expose this controller in a fully ECAM compatible manner, we can
>> >>> simply describe it as "pci-host-ecam-generic" and be done with it.
>> >>> However, it appears that in some cases (one of which is the Armada 80x0),
>> >>> the IP is synthesized with an ATU window size that does not allow the
>> >>> first bus to be mapped in a way that prevents the device on the
>> >>> downstream port from appearing more than once.
>> >>>
>> >>> So implement a driver that relies on the firmware to perform all low
>> >>> level initialization, and drives the controller in ECAM mode, but
>> >>> overrides the config space accessors to take the above quirk into
>> >>> account.
>> >>>
>> >>> Note that, unlike most drivers for this IP, this driver does not expose
>> >>> a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
>> >>> given that this is not a true bridge, and does not require any windows
>> >>> to be configured in order for the downstream device to operate correctly.
>> >>> Omitting it also prevents the PCI resource allocation routines from
>> >>> handing out BAR space to it unnecessarily.
>> >>
>> >> This is a tangent, but does this mean the other drivers do not need to
>> >> expose a fake 00:00.0 device either?
>> >>
>> >
>> > To be honest, I am not so sure anymore. I am seeing some issues in
>> > ASPM code making the assumption that any device which is not a root
>> > port has a parent. If this is mandated by the spec, I guess there
>> > isn't a whole lot we can do except expose a fake root port on b/d/f
>> > 0/0/0. This used to work fine, though, and I have to confirm whether
>> > the issues I am seeing currently are due to different hardware or
>> > changes in the software.
>> >
>>
>> OK, so the issue was new because I hadn't tried using a PCIe switch
>> before, and you have already queued the fix to make the ASPM code deal
>> with that.
>>
>> So I think it /would/ be better for the other drivers to not bother
>> mocking up the root port, and simply expose the downstream device as
>> B/D/F 0/0/0 (assuming the bus range starts at 0).
>>
>> It really looks like Altera, Aardvark, Sigma, etc are all in the same
>> boat here, and need to
>> a) filter type 0 config TLPs to avoid the downstream device to appear
>> 32 times, and
>> b) mangle config space accesses to the 'root port' to hide BARs that
>> have different meanings in this context (the size of the inbound
>> window), in order to prevent the PCI resource allocation routines to
>> waste huge amounts of BAR space on them.
>
> I don't know what to do about this.  Obviously it's not your problem
> to clean this up.
>
> I don't know anything about the topology of those systems.  If the
> ASPM thing was the only issue, we can probably fix that.  Of course,
> that means no device connected to the link from those RCs could use
> ASPM (maybe that's the case anyway with the mocked-up root ports).
>

That may be the answer, although I am not sure. The limited Synopsys
documentation I have access to does list 'L0s and L1 ASPM support;
software L1 and L2 support' as a feature, and what they expose as the
root port is actually a set of PCIe config registers that are in the
MMIO region of the controller (but cannot be remapped statically in
the ECAM space). But the same MMIO region has a BAR to configure the
inbound window, and has bridge BARs that can be programmed but don't
actually affect what gets passed onto the link.

The almost-ECAM mode is much more appealing for the use cases I am
involved with, and losing ASPM is no big deal, so I'd rather not use
the dwc/ drivers if I can avoid it.

>> >>> +static int pci_dw_ecam_config_read(struct pci_bus *bus, u32 devfn, int where,
>> >>> +                                int size, u32 *val)
>> >>> +{
>> >>> +     struct pci_config_window *cfg = bus->sysdata;
>> >>> +
>> >>> +     /*
>> >>> +      * The Synopsys dw PCIe controller in RC mode will not filter type 0
>> >>> +      * config TLPs sent to devices 1 and up on its downstream port,
>> >>> +      * resulting in devices appearing multiple times on bus 0 unless we
>> >>> +      * filter them here.
>> >>> +      */
>> >>> +     if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0) {
>> >>
>> >> Trivial, but maybe you could factor out this test?  We already have
>> >> these functions that do basically the same thing and it'd be nice to
>> >> use a similar pattern (altera and dw also check for the link being up,
>> >> which seems racy and possibly bogus to me):
>> >>
>> >>   altera_pcie_valid_device()
>> >>   dw_pcie_valid_device()
>> >>   rockchip_pcie_valid_device()
>> >>
>>
>> This is rather difficult to factor out, I'm afraid:
>>
>> static bool altera_pcie_valid_device(struct altera_pcie *pcie,
>>                                      struct pci_bus *bus, int dev)
>>
>> static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
>>                                 int dev)
>>
>> static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>>                                       struct pci_bus *bus, int dev)
>>
>> They all use different struct types to describe the RC, and the fact
>> that they model a root port means the type0 TLP filter should be
>> applied to bus 1 not bus 0.
>> So I agree there is some similarity between these, but not as much
>> with the driver I am proposing.
>
> Sorry, I didn't mean to factor all these out into a single routine; I
> just meant maybe we could add a pci_dw_valid_device() with a structure
> similar to those I mentioned.
>
>> >> The fact that altera and rockchip do essentially the same thing as dw
>> >> here suggests that this pattern is not limited to DesignWare.
>> >>
>>
>> No.
>> >> These other functions also do something similar, though not structured
>> >> the same way:
>> >>
>> >>   hisi_pcie_rd_conf()
>> >>   advk_pcie_rd_conf()
>> >>   thunder_pem_bridge_read()
>> >>   rcar_pcie_config_access()
>> >>   gapspci_config_access()
>> >>
>> >
>> > I can look into that.
>> >
>>
>> I think only hisi_pcie_rd_conf() comes close to what I need to do in
>> this driver, and this is not surprising given that it uses Synopsys IP
>> as well. I would like to replace that entirely with this driver at
>> some point, but for now I'd like to proceed with Marvell Armada 8k and
>> Socionext Synquacer only, given that those are the only ones I can
>> actually test myself.
>
> Sorry again, more unclear communication on my part.  I don't think we
> can easily factor these things out; I was really just making the
> observation that these all look pretty similar and it would be good to
> make this new driver look as similar to the existing ones as possible.
>

OK, fair enough. I took Will's advice and extended the
pci-host-generic driver instead, but I'm happy to do another round if
necessary.
