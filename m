Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:47383 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754739AbcIOIea (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Sep 2016 04:34:30 -0400
Subject: Re: [RFC PATCH 00/11] pci: support for configurable PCI endpoint
To: Arnd Bergmann <arnd@arndb.de>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <2837059.ka7z3gzjF2@wuerfel>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, <nsekhar@ti.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>, <linux-ntb@googlegroups.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57DA5CC1.6030502@ti.com>
Date: Thu, 15 Sep 2016 14:03:05 +0530
MIME-Version: 1.0
In-Reply-To: <2837059.ka7z3gzjF2@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Wednesday 14 September 2016 06:55 PM, Arnd Bergmann wrote:
> On Wednesday, September 14, 2016 10:41:56 AM CEST Kishon Vijay Abraham I wrote:
>> This patch series
>> 	*) adds PCI endpoint core layer
>> 	*) modifies designware/dra7xx driver to be configured in EP mode
>> 	*) adds a PCI endpoint *test* function driver
> 
> Hi Kishon,
> 
> I think this is a great start, thanks for posting early with a clear
> list of limitations and TODO items.

Thank you :-)
> 
> I've added the drivers/ntb maintainers to Cc, given that there is
> a certain degree of overlap between your work and the existing
> code, I think they should be part of the discussion.
>  
>> Known Limitation:
>> 	*) Does not support multi-function devices
> 
> If I understand it right, this was a problem for USB and adding
> it later made it somewhat inconsistent. Maybe we can at least
> try to come up with an idea of how multi-function devices
> could be handled even if we don't implement it until someone
> actually needs it.

Actually IMO multi-function device in PCI should be much simpler than it is for
USB. In the case of USB, all the functions in a multi-function device will
share the same *usb configuration* . (USB device can have multiple
configuration but only one can be enabled at a time). A multi-function USB
device will still have a single vendor-id/product-id/class... So I think a
separate library (composite.c) in USB makes sense.

But in the case of PCI, every function can be treated independently since all
the functions have it's own 4KB configuration space. Each function can be
configured independently. Each can have it's own vendor-id/product-id/class..
I'm not sure if we'll need a separate library for PCI like we have for USB.

Now the restriction for not allowing multi-function device is because of the
following structure definition.

struct pci_epc {
	..
        struct pci_epf *epf;
	..
};

EPC has a single reference to EPF and it is used *only* to notify the function
driver when the link is up. (If this can be changed to use notification
mechanism, multi-function devices can be supported here)

One more place where this restriction arises is in designware driver

struct dw_pcie_ep {
	..
        u8 bar_to_atu[6];
	..
};

We use single ATU window to configure a BAR (in BAR). If there are multiple
functions, then this should also be modified since each function has 6 BARs.

This can be fixed without much effort unless some other issue props up.

> 
> Is your hardware able to make the PCIe endpoint look like
> a device with multiple PCI functions, or would one have to
> do this in software inside of a single PCI function if we
> ever need it?

The hardware I have doesn't support multiple PCI functions (like having a
separate configuration space for each function). It has a dedicated space for
configuration space supporting only one function. [Section 24.9.7.3.2
PCIe_SS_EP_CFG_DBICS Register Description in  [1]].

yeah, it has to be done in software (but that won't be multi-function device in
PCI terms).

[1] -> http://www.ti.com/lit/ug/spruhz6g/spruhz6g.pdf
> 
>> TODO:
>> 	*) access buffers in RC
>> 	*) raise MSI interrupts
>> 	*) Enable user space control for the RC side PCI driver
> 
> The user space control would end up just being one of several
> gadget drivers, right? E.g. gadget drivers for standard hardware
> (8250 uart, ATA, NVMe, some ethernet) could be done as kernel
> drivers while a user space driver can be used for things that
> are more unusual and that don't need to interface to another
> part of the kernel?

Actually I didn't mean that. It was more with respect to the host side PCI test
driver (drivers/misc/pci_endpoint_test.c). Right now it validates BAR, irq
itself. I wanted to change this so that the user controls which tests to run.
(Like for USB gadget zero tests, testusb.c invokes ioctls to perform various
tests). Similarly I want to have a userspace program invoke pci_endpoint_test
to perform various PCI tests.
> 
>> 	*) Adapt all other users of designware to use the new design (only
>> 	   dra7xx has been adapted)
> 
> I don't fully understand this part. Does every designware based
> driver need modifications, or are the changes to the
> generic parts of the designware driver enough to make it
> work for the simpler platforms?

I have changed the core designware driver structures (like previously the
platform drivers will only use pcie_port, but now I introduced struct dw_pcie
to support both host and endpoint). This will break (compilation failure) all
the designware based drivers (except dra7xx). All these drivers should be
adapted to the new change (even if they work only in host mode these has to be
adapted).
> 
>> HOW TO:
>>
>> ON THE EP SIDE:
>> ***************
>>
>> /* EP function is configured using configfs */
>> # mount -t configfs none /sys/kernel/config
>>
>> /* PCI EP core layer creates "pci_ep" entry in configfs */
>> # cd /sys/kernel/config/pci_ep/
>>
>> /*
>>  * This is the 1st step in creating an endpoint function. This
>>  * creates the endpoint function device *instance*. The string
>>  * before the .<num> suffix will identify the driver this
>>  * EP function will bind to.
>>  * Just pci_epf_test is also valid. The .<num> suffix is used
>>  * if there are multiple PCI controllers and all of them wants
>>  * to use the same function.
>>  */
>> # mkdir pci_epf_test.0
> 
> I haven't used USB gadgets, but I assume this is modeled around
> the same interface. If there are notable differences, please mention
> what they are. Otherwise the general concept seems rather nice to me.

Yeah, both USB gadget and PCI endpoint use configfs interface but the semantics
are quite different.

Every directory in *usb_gadget* corresponds to a gadget device, and the gadget
device has a functions sub-directory which has the USB functions. And these
directories have fields or attributes specific to USB.

But in the case of PCI, every directory in *pci_ep* corresponds to a PCI
function and it has fields or attributes specific to PCI function.

The main reason for using configfs for PCI endpoint is to give the users to
control "which function has to be bound to which controller". The same concept
is used for USB gadget as well but there it is "which gadget device has to be
bound to which controller".
> 
>>  drivers/pci/{host => controller}/Kconfig           |  109 +++++-
>>  drivers/pci/{host => controller}/Makefile          |    2 +
>>  drivers/pci/{host => controller}/pci-aardvark.c    |    0
>>  drivers/pci/{host => controller}/pci-dra7xx.c      |  340 +++++++++++++----
>>  drivers/pci/{host => controller}/pci-exynos.c      |    0
>>  drivers/pci/{host => controller}/pci-host-common.c |    0
>>  .../pci/{host => controller}/pci-host-generic.c    |    0
>>  drivers/pci/{host => controller}/pci-hyperv.c      |    0
>>  drivers/pci/{host => controller}/pci-imx6.c        |    0
>>  drivers/pci/{host => controller}/pci-keystone-dw.c |    0
>>  drivers/pci/{host => controller}/pci-keystone.c    |    0
>>  drivers/pci/{host => controller}/pci-keystone.h    |    0
> 
> Maybe it's better to wait before moving it around, this will make
> it harder for you to rebase the patch series while you are working on
> it and other people are working on the existing code.

These patches just do "mv drivers/pci/host  drivers/pci/controller", so I guess
irrespective of the changes in the existing driver it should just move. Anyways
I have to check this.
> 
> I'd suggest dropping the rename patches for the moment and just work
> in drivers/pci/host.

Okay.
> 
> Let's talk (high-level) about the DT binding. I see that the way
> you have done it here, one will need to have a different .dtb file
> for a machine depending on whether the PCIe is used in host or
> endpoint mode. The advantage of this way is that it's a much
> cleaner binding (PCIe host bindings are a mess, and adding more
> options to it will only make it worse), the downside is that
> you can't decide at runtime what you want to use it for. E.g.
> connecting two identical machines over PCIe requires deciding
> in the bootloader which one is the endpoint, or using DT
> overlays, which may be awkward for some users. Is this a realistic
> use case, or do you expect that all machines will only ever be
> used in one of the two ways?

It would definitely be nice to select the mode at runtime. Even for this patch
series, I added a temporary dtsi patch to configure the pci controller in EP
mode (which can't be merged since the same controller is also used to test RC).

Thanks
Kishon
