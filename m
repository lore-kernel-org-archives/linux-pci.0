Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51022 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933483AbcIVNfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 09:35:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, hch@infradead.org,
        Joao.Pinto@synopsys.com, mingkai.hu@nxp.com, m-karicheri2@ti.com,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com
Subject: Re: [RFC PATCH 00/11] pci: support for configurable PCI endpoint
Date: Thu, 22 Sep 2016 15:34:00 +0200
Message-ID: <6722152.QTF992tLpW@wuerfel>
In-Reply-To: <57DA5CC1.6030502@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com> <2837059.ka7z3gzjF2@wuerfel> <57DA5CC1.6030502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 15, 2016 2:03:05 PM CEST Kishon Vijay Abraham I wrote:
> On Wednesday 14 September 2016 06:55 PM, Arnd Bergmann wrote:
> > On Wednesday, September 14, 2016 10:41:56 AM CEST Kishon Vijay Abraham I wrote:
> > I've added the drivers/ntb maintainers to Cc, given that there is
> > a certain degree of overlap between your work and the existing
> > code, I think they should be part of the discussion.
> >  
> >> Known Limitation:
> >> 	*) Does not support multi-function devices
> > 
> > If I understand it right, this was a problem for USB and adding
> > it later made it somewhat inconsistent. Maybe we can at least
> > try to come up with an idea of how multi-function devices
> > could be handled even if we don't implement it until someone
> > actually needs it.
> 
> Actually IMO multi-function device in PCI should be much simpler than it is for
> USB. In the case of USB, all the functions in a multi-function device will
> share the same *usb configuration* . (USB device can have multiple
> configuration but only one can be enabled at a time). A multi-function USB
> device will still have a single vendor-id/product-id/class... So I think a
> separate library (composite.c) in USB makes sense.

Ok, makes sense.

> But in the case of PCI, every function can be treated independently since all
> the functions have it's own 4KB configuration space. Each function can be
> configured independently. Each can have it's own vendor-id/product-id/class..
> I'm not sure if we'll need a separate library for PCI like we have for USB.

I think it depends on whether we want to add the software multi-function
support you mention.

> Now the restriction for not allowing multi-function device is because of the
> following structure definition.
> 
> struct pci_epc {
> 	..
>         struct pci_epf *epf;
> 	..
> };
> 
> EPC has a single reference to EPF and it is used *only* to notify the function
> driver when the link is up. (If this can be changed to use notification
> mechanism, multi-function devices can be supported here)
> 
> One more place where this restriction arises is in designware driver
> 
> struct dw_pcie_ep {
> 	..
>         u8 bar_to_atu[6];
> 	..
> };
> 
> We use single ATU window to configure a BAR (in BAR). If there are multiple
> functions, then this should also be modified since each function has 6 BARs.
> 
> This can be fixed without much effort unless some other issue props up.

Ok.

> > 
> > Is your hardware able to make the PCIe endpoint look like
> > a device with multiple PCI functions, or would one have to
> > do this in software inside of a single PCI function if we
> > ever need it?
> 
> The hardware I have doesn't support multiple PCI functions (like having a
> separate configuration space for each function). It has a dedicated space for
> configuration space supporting only one function. [Section 24.9.7.3.2
> PCIe_SS_EP_CFG_DBICS Register Description in  [1]].
> 
> yeah, it has to be done in software (but that won't be multi-function device in
> PCI terms).
> 
> [1] -> http://www.ti.com/lit/ug/spruhz6g/spruhz6g.pdf

Ok, so in theory there can be other hardware (and quite likely is)
that supports multiple functions, and we can extend the framework
to support them without major obstacles, but your hardware doesn't,
so you kept it simple with one hardcoded function, right?

Seems completely reasonable to me.

> >> TODO:
> >> 	*) access buffers in RC
> >> 	*) raise MSI interrupts
> >> 	*) Enable user space control for the RC side PCI driver
> > 
> > The user space control would end up just being one of several
> > gadget drivers, right? E.g. gadget drivers for standard hardware
> > (8250 uart, ATA, NVMe, some ethernet) could be done as kernel
> > drivers while a user space driver can be used for things that
> > are more unusual and that don't need to interface to another
> > part of the kernel?
> 
> Actually I didn't mean that. It was more with respect to the host side PCI test
> driver (drivers/misc/pci_endpoint_test.c). Right now it validates BAR, irq
> itself. I wanted to change this so that the user controls which tests to run.
> (Like for USB gadget zero tests, testusb.c invokes ioctls to perform various
> tests). Similarly I want to have a userspace program invoke pci_endpoint_test
> to perform various PCI tests.

Ok, I see. So what I described above would be yet another function
driver that can be implemented, but so far, you have not planned
to do that because there was not need, right?

> > 
> >> 	*) Adapt all other users of designware to use the new design (only
> >> 	   dra7xx has been adapted)
> > 
> > I don't fully understand this part. Does every designware based
> > driver need modifications, or are the changes to the
> > generic parts of the designware driver enough to make it
> > work for the simpler platforms?
> 
> I have changed the core designware driver structures (like previously the
> platform drivers will only use pcie_port, but now I introduced struct dw_pcie
> to support both host and endpoint). This will break (compilation failure) all
> the designware based drivers (except dra7xx). All these drivers should be
> adapted to the new change (even if they work only in host mode these has to be
> adapted).

Ah, so we have to do two separate modifications to each designware driver:

a) make it work with your patch (mandatory)
b) make it support endpoint mode (optional)

> >> HOW TO:
> >>
> >> ON THE EP SIDE:
> >> ***************
> >>
> >> /* EP function is configured using configfs */
> >> # mount -t configfs none /sys/kernel/config
> >>
> >> /* PCI EP core layer creates "pci_ep" entry in configfs */
> >> # cd /sys/kernel/config/pci_ep/
> >>
> >> /*
> >>  * This is the 1st step in creating an endpoint function. This
> >>  * creates the endpoint function device *instance*. The string
> >>  * before the .<num> suffix will identify the driver this
> >>  * EP function will bind to.
> >>  * Just pci_epf_test is also valid. The .<num> suffix is used
> >>  * if there are multiple PCI controllers and all of them wants
> >>  * to use the same function.
> >>  */
> >> # mkdir pci_epf_test.0
> > 
> > I haven't used USB gadgets, but I assume this is modeled around
> > the same interface. If there are notable differences, please mention
> > what they are. Otherwise the general concept seems rather nice to me.
> 
> Yeah, both USB gadget and PCI endpoint use configfs interface but the semantics
> are quite different.
> 
> Every directory in *usb_gadget* corresponds to a gadget device, and the gadget
> device has a functions sub-directory which has the USB functions. And these
> directories have fields or attributes specific to USB.
> 
> But in the case of PCI, every directory in *pci_ep* corresponds to a PCI
> function and it has fields or attributes specific to PCI function.

Ok, I see.

> The main reason for using configfs for PCI endpoint is to give the users to
> control "which function has to be bound to which controller". The same concept
> is used for USB gadget as well but there it is "which gadget device has to be
> bound to which controller".

We should still find out whether it's important that you can have
a single PCI function with a software multi-function support of some
sort. We'd still be limited to six BARs in total, and would also need
something to identify those sub-functions, so implementing that might
get quite hairy.

Possibly this could be done at a higher level, e.g. by implementing
a PCI-virtio multiplexer that can host multiple virtio based devices
inside of a single PCI function. If we think that would be a good idea,
we should make sure the configfs interface is extensible enough to
handle that.

One use case I have in mind for this is to have a PCI function that
can use virtio to provide rootfs (virtio-blk or 9pfs), network
and console to the system that implements the PCI function (note
that this is the opposite direction of what almost everyone else
uses PCI devices for).

> > Let's talk (high-level) about the DT binding. I see that the way
> > you have done it here, one will need to have a different .dtb file
> > for a machine depending on whether the PCIe is used in host or
> > endpoint mode. The advantage of this way is that it's a much
> > cleaner binding (PCIe host bindings are a mess, and adding more
> > options to it will only make it worse), the downside is that
> > you can't decide at runtime what you want to use it for. E.g.
> > connecting two identical machines over PCIe requires deciding
> > in the bootloader which one is the endpoint, or using DT
> > overlays, which may be awkward for some users. Is this a realistic
> > use case, or do you expect that all machines will only ever be
> > used in one of the two ways?
> 
> It would definitely be nice to select the mode at runtime. Even for this patch
> series, I added a temporary dtsi patch to configure the pci controller in EP
> mode (which can't be merged since the same controller is also used to test RC).

I think it should be possible to have two bindings that define a
distinct set of properties, and have one node that is marked
as "compatible" with both of them in order to let the OS choose
one or the other mode.

	Arnd
