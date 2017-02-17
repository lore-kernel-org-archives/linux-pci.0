Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 17 Feb 2017 11:50:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: Pointers for writing a good PCIe driver
Message-ID: <20170217175054.GA16671@bhelgaas-glaptop.roam.corp.google.com>
References: <ff099b5f-efc8-bb5f-41e3-493398844cc0@free.fr>
 <05046a8a-ba9f-26f9-4c93-f657f9da6294@free.fr>
 <20170207200656.GA11659@bhelgaas-glaptop.roam.corp.google.com>
 <20170207214758.GC11659@bhelgaas-glaptop.roam.corp.google.com>
 <0f22720c-e47d-59f6-b5f7-5e40f4a1759d@free.fr>
 <20170212165033.GA31833@kroah.com>
 <0d785dab-c830-b887-d9f3-a2cd5338695c@free.fr>
 <20170217143803.GA10663@bhelgaas-glaptop.roam.corp.google.com>
 <eff9861e-043a-7ecd-5d52-c8e18a52ece8@free.fr>
MIME-Version: 1.0
In-Reply-To: <eff9861e-043a-7ecd-5d52-c8e18a52ece8@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 17, 2017 at 06:00:53PM +0100, Mason wrote:
> On 17/02/2017 15:38, Bjorn Helgaas wrote:
> 
> > On Fri, Feb 17, 2017 at 10:20:20AM +0100, Mason wrote:
> >
> >> There might be some kind of misunderstanding.
> >>
> >> I don't plan to write a driver for a device that plugs into a PCIe slot.
> >>
> >> I intend to write a driver for the PCIe controller itself, which is
> >> embedded in the SoC. (In order to support different types of PCIe
> >> devices, with their respective drivers already upstream.)
> >>
> >> I think the controller driver belongs in drivers/pci/host ?
> > 
> > Sorry, I indeed misunderstood you.
> > 
> > The native PCI host controller drivers indeed live in
> > drivers/pci/host/.
> > 
> > I don't know anything about your hardware or environment, but I highly
> > encourage you to use ACPI (drivers/acpi/pci_root.c, with a little bit
> > of arch support) or generic DT (drivers/pci/host/pci-host-generic.c)
> > instead of writing a custom host controller driver.
> > 
> > The native drivers in drivers/pci/host are a huge maintenance hassle
> > for no real benefit.
> 
> My SoC is built around an ARM Cortex A9.
> I don't think (?) this platform has any support for ACPI.

There's ACPI support on ARM64, but none that I know of for ARM32.

> I'm currently using this DT description:
> http://lxr.free-electrons.com/source/arch/arm/boot/dts/tango4-common.dtsi
> 
> The "legacy" driver sits at ~700 lines. It would be awesome to be able
> to discard all of it, and rely on generic upstream code. But I don't
> understand how it is possible for a generic driver to support whatever
> crazy solution some random vendor has come up with?

You're right that the programming model of the host bridge itself is
not specified by PCI specs, so it's impossible to have a generic
driver that can manage it completely by itself.

If you have firmware that initializes the bridge and tells the OS what
the windows are (bus numbers, memory space, I/O space) and where the
PCIe-specified ECAM space is, a generic driver can take it from there.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
