Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e192566903fe4b5eb9903e3b6c49a2e8@DM2PR05MB671.namprd05.prod.outlook.com>
References: <e192566903fe4b5eb9903e3b6c49a2e8@DM2PR05MB671.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Oct 2014 14:07:15 -0600
Message-ID: <CAErSpo4ROmCtdy+y-g4bZJmZKyCXjs6Hi28kHmeEp+QDmNHA1g@mail.gmail.com>
Subject: Re: Reducing dependence on BIOS for allocating memory at PCI root port?
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-acpi]

On Mon, Oct 13, 2014 at 12:32 PM, Rajat Jain <rajatjain@juniper.net> wrote:
> Hello,
>
> I have huge hot-plug systems that can have hundreds of hot plug PCI slots that may not be populated at the boot time. Since BIOS doesn't see all devices could be plugged in, so we ask it to hard code and allocate a fixed chunk of memory space (say 4 GB) for PCI at the root port.
>
> Now as we keep on developing new add-on cards with more PCI memory requirements - we have a problem because we need to increase that root port allocation. While asking the BIOS vendor to increase the memory for new releases is an option, I am in general thinking if there is a way to do this without depending on the BIOS allocation at all. We don't want to upgrade BIOS for just this. I'm hopeful this is a common problem - so I wanted to ask if there are there existing mechanisms that allow / instruct the kernel to ignore the BIOS allocations, and reprogram the PCI host controllers, (by maybe a kernel configuration or command line parameters etc for example).

As you know, the transition from CPU address space to PCI address
space is in the host bridge.  For PCIe, this is logically part of the
Root Complex and is logically upstream from the Root Ports.  If  you
want to reallocate space between Root Ports, i.e., remove space from
one and add it to another port below the same Root Complex, that's
strictly a PCI thing and is at least conceptually possible today with
no new firmware or DT support.

But you're probably asking about increasing the space assigned to the
Root Complex itself.  The ACPI model supports that -- the PNP0A08 host
bridge device could advertise a _PRS that shows how much space could
potentially be assigned to the bridge, and we could use _SRS to assign
more space (possibly after using _SRS on a different bridge to make
space available).  There is no Linux code to do this today, so at this
point it's just a theoretical possibility.  And, of course, it
requires BIOS support.

The ACPI driver (drivers/acpi/pci_root.c) is generic, so it doesn't
know how to reprogram the host controller except by using _PRS and
_SRS (and even that isn't implemented yet).

> PS: The immediate thought of device tree comes to mind - but what about architectures that don't support it yet. (FWIW - I'm using x86 - and I do not know if its host controller driver supports / will support any device tree options to specify PCI windows)

If you have DT and a native host controller driver, the driver may
know how to reprogram the host controller.  Then you would just have
to work out how to manage the address space you want to assign to the
controller.

If you're using the generic DT driver
(drivers/pci/host/pci-host-generic.c), it's in the same situation as
the ACPI driver: it doesn't know how to reprogram the windows.  And as
far as I know there's no DT mechanism similar to _PRS/_SRS.

Bjorn
