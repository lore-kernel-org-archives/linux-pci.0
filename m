Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
To: Yinghai Lu <yinghai@kernel.org>
CC: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>
Subject: RE: [PATCH v2 2/6] ACPI, PCI: Notify acpi_pci_drivers when
 hot-plugging PCI root bridges
Date: Wed, 5 Sep 2012 04:32:17 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A4A4240@G01JPEXMBYT03>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
	<20120903170442.c406455c.izumi.taku@jp.fujitsu.com>
	<4A338DB2991D2A44B9A44B8718AECF650A4A2DCD@G01JPEXMBYT03>
 <CAE9FiQVJ0JRCgZsh+iSB8VC4TqJDcetPyno36L8=UW-UQUK4vQ@mail.gmail.com>
In-Reply-To: <CAE9FiQVJ0JRCgZsh+iSB8VC4TqJDcetPyno36L8=UW-UQUK4vQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of
> Yinghai Lu
> Sent: Wednesday, September 05, 2012 4:12 AM
> To: Kaneshige, Kenji/金重 憲治
> Cc: Izumi, Taku/泉 拓; linux-pci@vger.kernel.org; bhelgaas@google.com;
> linux-acpi@vger.kernel.org; jiang.liu@huawei.com
> Subject: Re: [PATCH v2 2/6] ACPI, PCI: Notify acpi_pci_drivers when
> hot-plugging PCI root bridges
> 
> On Tue, Sep 4, 2012 at 12:58 AM, Kaneshige, Kenji
> <kaneshige.kenji@jp.fujitsu.com> wrote:
> >>   -v2: Move add calling to acpi_pci_root_start by Yinghai
> >>  static int acpi_pci_root_start(struct acpi_device *device)
> >>  {
> >>       struct acpi_pci_root *root = acpi_driver_data(device);
> >> +     struct acpi_pci_driver *driver;
> >> +
> >> +     list_for_each_entry(driver, &acpi_pci_drivers, node)
> >> +             if (driver->add)
> >> +                     driver->add(device->handle);
> >>
> >
> > I think this (invoke .add callback for each acpi pci driver) should be
> done
> > after pci_bus_add_devices().
> 
> We need to load ioapic driver and dmar driver before normal pci drivers.

Ok, my understanding of your comment is that IOAPIC and DMAR drivers are implemented
as ACPI PCI driver (or you have a plan to implement IOAPIC and DMAR drivers as ACPI
PCI driver), and those drivers need to be loaded before PCI device drivers. Is my
understanding correct?

Regards,
Kenji Kaneshige



> 
> >
> > It seems ACPI pci drivers run *after* pci_bus_add_devices() at the boot
> time
> > (because no acpi pci drivers is loaded at that time). On the other hand,
> it
> > seems that ACPI pci drivers run *before* pci_bus_add_devices() at the
> hotadd
> > time. Those should be the same.
> 
> for boot time, sequence : normal pci driver still get loaded after
> ioapic and dmar drivers.
> otherwise those driver will have problem to get irq and iommu work correctly.
> and if ioapic and dmar are static, and they will get initialized
> around pci device get scanned and pci_bus_add_devices get called
> already.
> but that time normal devices driver does not get registered yet. those
> pci drivers will get loaded (should be bounded)
> for pci devices when those driver get registered.
> 
> Thanks
> 
> Yinghai
