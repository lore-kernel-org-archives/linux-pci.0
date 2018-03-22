Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 22 Mar 2018 08:35:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "dann.frazier@canonical.com" <dann.frazier@canonical.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "andriy.shevchenko@linux.intel.com"
        <andriy.shevchenko@linux.intel.com>,
        "joe@perches.com" <joe@perches.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "agraf@suse.de" <agraf@suse.de>
Subject: Re: [PATCH v17 00/10] LPC: legacy ISA I/O support
Message-ID: <20180322133544.GA236400@bhelgaas-glaptop.roam.corp.google.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <20180321233940.GI38649@bhelgaas-glaptop.roam.corp.google.com>
 <334da3b2-5233-5ad3-728e-7ae95231bf01@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <334da3b2-5233-5ad3-728e-7ae95231bf01@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 10:38:37AM +0000, John Garry wrote:
> On 21/03/2018 23:39, Bjorn Helgaas wrote:
> > On Thu, Mar 15, 2018 at 02:15:49AM +0800, John Garry wrote:
> > > This patchset supports the IPMI-bt device attached to the Low-Pin-Count
> > > interface implemented on Hisilicon Hip06/Hip07 SoC.
> > >                         -----------
> > >                         | LPC host|
> > >                         |         |
> > >                         -----------
> > >                              |
> > >                 _____________V_______________LPC
> > >                   |                       |
> > >                   V                       V
> > >                                      ------------
> > >                                      |  BT(ipmi)|
> > >                                      ------------
> > > ...
> > 
> > > Gabriele Paoloni (2):
> > >   PCI: Remove unused __weak attribute in pci_register_io_range()
> > >   PCI: Add fwnode handler as input param of pci_register_io_range()
> > > 
> > > John Garry (4):
> > >   ACPI / scan: rename acpi_is_serial_bus_slave() to widen use
> > >   ACPI / scan: do not enumerate Indirect IO host children
> > >   HISI LPC: Add ACPI support
> > >   MAINTAINERS: Add maintainer for HiSilicon LPC driver
> > > 
> > > Zhichang Yuan (4):
> > >   LIB: Introduce a generic PIO mapping method
> > >   PCI: Apply the new generic I/O management on PCI IO hosts
> > >   OF: Add missing I/O range exception for indirect-IO devices
> > >   HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings
> > > 
> > >  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
> > >  MAINTAINERS                                        |   7 +
> > >  drivers/acpi/pci_root.c                            |   8 +-
> > >  drivers/acpi/scan.c                                |  33 +-
> > >  drivers/bus/Kconfig                                |   8 +
> > >  drivers/bus/Makefile                               |   2 +
> > >  drivers/bus/hisi_lpc.c                             | 623 +++++++++++++++++++++
> > >  drivers/of/address.c                               |  96 +++-
> > >  drivers/pci/pci.c                                  |  95 +---
> > >  include/acpi/acpi_bus.h                            |   2 +-
> > >  include/asm-generic/io.h                           |   4 +-
> > >  include/linux/logic_pio.h                          | 124 ++++
> > >  include/linux/pci.h                                |   3 +-
> > >  lib/Kconfig                                        |  15 +
> > >  lib/Makefile                                       |   2 +
> > >  lib/logic_pio.c                                    | 282 ++++++++++
> > >  16 files changed, 1229 insertions(+), 108 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
> > >  create mode 100644 drivers/bus/hisi_lpc.c
> > >  create mode 100644 include/linux/logic_pio.h
> > >  create mode 100644 lib/logic_pio.c
> > 
> > I applied this whole series to pci/lpc for v4.17.
> > 
> > I made the following whitespace and other trivial corrections.
> > Hopefully I didn't break anything.
> > 
> 
> Hi Bjorn,
> 
> Super thanks for doing this. In general the changes look ok. However a build
> issue has appeared, below.

It didn't just "appear"; I added it myself!  I fixed it and repushed the
branch.
