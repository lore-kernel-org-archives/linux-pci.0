Return-Path: <SRS0=su7V=BF=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=su7V=BF=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8CCcm_R3S1PbXZFqzvjAJVfU_bKpimVxbeQ78ciAgJyA@mail.gmail.com>
References: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
 <20170828180437.2646-2-ard.biesheuvel@linaro.org> <20170926173200.GL15970@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu8CCcm_R3S1PbXZFqzvjAJVfU_bKpimVxbeQ78ciAgJyA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 6 Oct 2017 15:52:03 +0100
Message-ID: <CAKv+Gu_MM--uHwQk_brJh1bPOdsUTH4j+aJUDyS1um3mHDdsEA@mail.gmail.com>
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

On 28 September 2017 at 16:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 26 September 2017 at 10:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Will]
>>
>> On Mon, Aug 28, 2017 at 07:04:36PM +0100, Ard Biesheuvel wrote:
>>> Some implementations of the Synopsys Designware PCIe controller implement
>>> a so-called ECAM shift mode, which allows a static memory window to be
>>> configured that covers the configuration space of the entire bus range.
>>>
>>> If the firmware performs all the low level configuration that is required
>>> to expose this controller in a fully ECAM compatible manner, we can
>>> simply describe it as "pci-host-ecam-generic" and be done with it.
>>> However, it appears that in some cases (one of which is the Armada 80x0),
>>> the IP is synthesized with an ATU window size that does not allow the
>>> first bus to be mapped in a way that prevents the device on the
>>> downstream port from appearing more than once.
>>>
>>> So implement a driver that relies on the firmware to perform all low
>>> level initialization, and drives the controller in ECAM mode, but
>>> overrides the config space accessors to take the above quirk into
>>> account.
>>>
>>> Note that, unlike most drivers for this IP, this driver does not expose
>>> a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
>>> given that this is not a true bridge, and does not require any windows
>>> to be configured in order for the downstream device to operate correctly.
>>> Omitting it also prevents the PCI resource allocation routines from
>>> handing out BAR space to it unnecessarily.
>>
>> This is a tangent, but does this mean the other drivers do not need to
>> expose a fake 00:00.0 device either?
>>
>
> To be honest, I am not so sure anymore. I am seeing some issues in
> ASPM code making the assumption that any device which is not a root
> port has a parent. If this is mandated by the spec, I guess there
> isn't a whole lot we can do except expose a fake root port on b/d/f
> 0/0/0. This used to work fine, though, and I have to confirm whether
> the issues I am seeing currently are due to different hardware or
> changes in the software.
>

OK, so the issue was new because I hadn't tried using a PCIe switch
before, and you have already queued the fix to make the ASPM code deal
with that.

So I think it /would/ be better for the other drivers to not bother
mocking up the root port, and simply expose the downstream device as
B/D/F 0/0/0 (assuming the bus range starts at 0).

It really looks like Altera, Aardvark, Sigma, etc are all in the same
boat here, and need to
a) filter type 0 config TLPs to avoid the downstream device to appear
32 times, and
b) mangle config space accesses to the 'root port' to hide BARs that
have different meanings in this context (the size of the inbound
window), in order to prevent the PCI resource allocation routines to
waste huge amounts of BAR space on them.

>> s/Designware/DesignWare/ in comments, changelogs, Kconfig text, etc.
>>
>
> OK
>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Jingoo Han <jingoohan1@gmail.com>
>>> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>  drivers/pci/dwc/Kconfig                | 11 +++
>>>  drivers/pci/dwc/Makefile               |  1 +
>>>  drivers/pci/dwc/pcie-designware-ecam.c | 77 ++++++++++++++++++++
>>
>> This really doesn't have any DesignWare specifics in it, and it seems
>> more related to drivers/pci/host/pci-host-generic.c than to anything
>> in drivers/pci/dwc.  Maybe it should be
>> drivers/pci/host/pci-host-generic-quirks.c or something?  That's
>> unwieldy, I admit.
>>
>
> I don't care where we put it, and I am fine with owning it if you prefer.
>
>> Putting it in pci/dwc would make Jingoo and Joao the default
>> maintainers; I don't know how they feel about that.  We would probably
>> have to tweak MAINTAINERS if we *didn't* put it in pci/dwc.
>>
>> Any thoughts on this, Will?
>>
>>>  3 files changed, 89 insertions(+)
>>>
>>> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>>> index d275aadc47ee..477576d07911 100644
>>> --- a/drivers/pci/dwc/Kconfig
>>> +++ b/drivers/pci/dwc/Kconfig
>>> @@ -169,4 +169,15 @@ config PCIE_KIRIN
>>>         Say Y here if you want PCIe controller support
>>>         on HiSilicon Kirin series SoCs.
>>>
>>> +config PCIE_DW_HOST_ECAM
>>> +     bool "Synopsys DesignWare PCIe controller in ECAM mode"
>>> +     depends on OF && PCI
>>> +     select PCI_HOST_COMMON
>>> +     select IRQ_DOMAIN
>>> +     help
>>> +       Add support for Synopsys DesignWare PCIe controllers configured
>>> +       by the firmware into ECAM shift mode. In some cases, these are
>>> +       fully ECAM compliant, in which case the pci-host-generic driver
>>> +       may be used instead.
>>
>> This doesn't quite read right.  It sounds like a controller in ECAM
>> shift mode might be fully ECAM compliant, but I don't think that's
>> what you intended.
>>
>
> Yes, that is what I mean. ECAM shift mode results in a fully compliant
> ECAM config space iff the IP was synthesized with a 32 KB granularity
> for the iATU windows. The default is 64 KB, though, in which case you
> need this driver.
>
>> IIUC, the controller can be in either "ECAM shift mode" (where we need
>> this new driver) or in a "fully ECAM compliant mode" (where we can use
>> pci-host-generic).
>>
>
> No, this is not the case
>
>>>  endmenu
>>> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
>>> index c61be9738cce..7d5a23e5b767 100644
>>> --- a/drivers/pci/dwc/Makefile
>>> +++ b/drivers/pci/dwc/Makefile
>>> @@ -1,5 +1,6 @@
>>>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>>>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>>> +obj-$(CONFIG_PCIE_DW_HOST_ECAM) += pcie-designware-ecam.o
>>>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>>>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>>>  ifneq ($(filter y,$(CONFIG_PCI_DRA7XX_HOST) $(CONFIG_PCI_DRA7XX_EP)),)
>>> diff --git a/drivers/pci/dwc/pcie-designware-ecam.c b/drivers/pci/dwc/pcie-designware-ecam.c
>>> new file mode 100644
>>> index 000000000000..ede627d7d08b
>>> --- /dev/null
>>> +++ b/drivers/pci/dwc/pcie-designware-ecam.c
>>> @@ -0,0 +1,77 @@
>>> +/*
>>> + * Driver for mostly ECAM compatible Synopsys dw PCIe controllers
>>> + * configured by the firmware into RC mode
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * Copyright (C) 2014 ARM Limited
>>> + * Copyright (C) 2017 Linaro Limited
>>> + *
>>> + * Authors: Will Deacon <will.deacon@arm.com>
>>> + *          Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/init.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_pci.h>
>>> +#include <linux/pci-ecam.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +static int pci_dw_ecam_config_read(struct pci_bus *bus, u32 devfn, int where,
>>> +                                int size, u32 *val)
>>> +{
>>> +     struct pci_config_window *cfg = bus->sysdata;
>>> +
>>> +     /*
>>> +      * The Synopsys dw PCIe controller in RC mode will not filter type 0
>>> +      * config TLPs sent to devices 1 and up on its downstream port,
>>> +      * resulting in devices appearing multiple times on bus 0 unless we
>>> +      * filter them here.
>>> +      */
>>> +     if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0) {
>>
>> Trivial, but maybe you could factor out this test?  We already have
>> these functions that do basically the same thing and it'd be nice to
>> use a similar pattern (altera and dw also check for the link being up,
>> which seems racy and possibly bogus to me):
>>
>>   altera_pcie_valid_device()
>>   dw_pcie_valid_device()
>>   rockchip_pcie_valid_device()
>>

This is rather difficult to factor out, I'm afraid:

static bool altera_pcie_valid_device(struct altera_pcie *pcie,
                                     struct pci_bus *bus, int dev)

static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
                                int dev)

static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
                                      struct pci_bus *bus, int dev)

They all use different struct types to describe the RC, and the fact
that they model a root port means the type0 TLP filter should be
applied to bus 1 not bus 0.
So I agree there is some similarity between these, but not as much
with the driver I am proposing.


>> The fact that altera and rockchip do essentially the same thing as dw
>> here suggests that this pattern is not limited to DesignWare.
>>

No.
>> These other functions also do something similar, though not structured
>> the same way:
>>
>>   hisi_pcie_rd_conf()
>>   advk_pcie_rd_conf()
>>   thunder_pem_bridge_read()
>>   rcar_pcie_config_access()
>>   gapspci_config_access()
>>
>
> I can look into that.
>

I think only hisi_pcie_rd_conf() comes close to what I need to do in
this driver, and this is not surprising given that it uses Synopsys IP
as well. I would like to replace that entirely with this driver at
some point, but for now I'd like to proceed with Marvell Armada 8k and
Socionext Synquacer only, given that those are the only ones I can
actually test myself.


So what I will do is respin the patch as an extension to
pci-host-generic, so we'll have something to poke at, and perhaps you
could give some more detailed guidance as to how to refactor these
existing routines.

Thanks,
Ard.
