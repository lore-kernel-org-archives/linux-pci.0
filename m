Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 21 Mar 2018 18:39:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
        arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net,
        dann.frazier@canonical.com, andy.shevchenko@gmail.com,
        robh@kernel.org, andriy.shevchenko@linux.intel.com,
        joe@perches.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, frowand.list@gmail.com, agraf@suse.de
Subject: Re: [PATCH v17 00/10]  LPC: legacy ISA I/O support
Message-ID: <20180321233940.GI38649@bhelgaas-glaptop.roam.corp.google.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 02:15:49AM +0800, John Garry wrote:
> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
> interface implemented on Hisilicon Hip06/Hip07 SoC.
>                         -----------
>                         | LPC host|
>                         |         |
>                         -----------
>                              |
>                 _____________V_______________LPC
>                   |                       |
>                   V                       V
>                                      ------------
>                                      |  BT(ipmi)|
>                                      ------------
> ...

> Gabriele Paoloni (2):
>   PCI: Remove unused __weak attribute in pci_register_io_range()
>   PCI: Add fwnode handler as input param of pci_register_io_range()
> 
> John Garry (4):
>   ACPI / scan: rename acpi_is_serial_bus_slave() to widen use
>   ACPI / scan: do not enumerate Indirect IO host children
>   HISI LPC: Add ACPI support
>   MAINTAINERS: Add maintainer for HiSilicon LPC driver
> 
> Zhichang Yuan (4):
>   LIB: Introduce a generic PIO mapping method
>   PCI: Apply the new generic I/O management on PCI IO hosts
>   OF: Add missing I/O range exception for indirect-IO devices
>   HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings
> 
>  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
>  MAINTAINERS                                        |   7 +
>  drivers/acpi/pci_root.c                            |   8 +-
>  drivers/acpi/scan.c                                |  33 +-
>  drivers/bus/Kconfig                                |   8 +
>  drivers/bus/Makefile                               |   2 +
>  drivers/bus/hisi_lpc.c                             | 623 +++++++++++++++++++++
>  drivers/of/address.c                               |  96 +++-
>  drivers/pci/pci.c                                  |  95 +---
>  include/acpi/acpi_bus.h                            |   2 +-
>  include/asm-generic/io.h                           |   4 +-
>  include/linux/logic_pio.h                          | 124 ++++
>  include/linux/pci.h                                |   3 +-
>  lib/Kconfig                                        |  15 +
>  lib/Makefile                                       |   2 +
>  lib/logic_pio.c                                    | 282 ++++++++++
>  16 files changed, 1229 insertions(+), 108 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>  create mode 100644 drivers/bus/hisi_lpc.c
>  create mode 100644 include/linux/logic_pio.h
>  create mode 100644 lib/logic_pio.c

I applied this whole series to pci/lpc for v4.17.

I made the following whitespace and other trivial corrections.
Hopefully I didn't break anything.


--- changelogs.orig	2018-03-21 18:37:47.209217927 -0500
+++ changelogs	2018-03-21 18:37:35.993074570 -0500
@@ -1,29 +1,31 @@
-commit cc88cacce96a
+commit eb3a2ff7e72e
 Author: John Garry <john.garry@huawei.com>
 Date:   Thu Mar 15 02:15:59 2018 +0800
 
-    MAINTAINERS: Add maintainer for HiSilicon LPC driver
+    MAINTAINERS: Add John Garry as maintainer for HiSilicon LPC driver
     
-    Added maintainer for drivers/bus/hisi_lpc.c
+    Add John Garry as maintainer for drivers/bus/hisi_lpc.c, the HiSilicon LPC
+    driver.
     
     Signed-off-by: John Garry <john.garry@huawei.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit e6e915fd9c90
+commit 6d22e66ef6ea
 Author: John Garry <john.garry@huawei.com>
 Date:   Thu Mar 15 02:15:58 2018 +0800
 
     HISI LPC: Add ACPI support
     
-    Based on the previous patches, this patch supports the
-    LPC host on hip06/hip07 for ACPI FW.
+    Based on the previous patches, this patch supports the LPC host on
+    Hip06/Hip07 for ACPI FW.
     
-    It is the responsibility of the LPC host driver to
-    enumerate the child devices, as the ACPI scan code will
-    not enumerate children of "indirect IO" hosts.
+    It is the responsibility of the LPC host driver to enumerate the child
+    devices, as the ACPI scan code will not enumerate children of "indirect IO"
+    hosts.
+    
+    The ACPI table for the LPC host controller and the child devices is in the
+    following format:
     
-    The ACPI table for the LPC host controller and the child
-    devices is in the following format:
       Device (LPC0) {
         Name (_HID, "HISI0191")  // HiSi LPC
         Name (_CRS, ResourceTemplate () {
@@ -50,216 +52,214 @@
           )
         })
     
-    Since the IO resources of the child devices need to be
-    translated from LPC bus addresses to logical PIO addresses,
-    and we shouldn't modify the resources of the devices
-    generated in the FW scan, a per-child MFD is created as
-    a substitute. The MFD IO resources will be the translated
-    bus addresses of the ACPI child.
+    Since the IO resources of the child devices need to be translated from LPC
+    bus addresses to logical PIO addresses, and we shouldn't modify the
+    resources of the devices generated in the FW scan, a per-child MFD is
+    created as a substitute.  The MFD IO resources will be the translated bus
+    addresses of the ACPI child.
     
+    Tested-by: dann frazier <dann.frazier@canonical.com>
     Signed-off-by: John Garry <john.garry@huawei.com>
     Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
-    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
-    Tested-by: dann frazier <dann.frazier@canonical.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
 
-commit 3e1f89c344c6
+commit ac3f7a357d2d
 Author: John Garry <john.garry@huawei.com>
 Date:   Thu Mar 15 02:15:57 2018 +0800
 
-    ACPI / scan: do not enumerate Indirect IO host children
+    ACPI / scan: Do not enumerate Indirect IO host children
     
-    Through the logical PIO framework systems which otherwise have
-    no IO space access to legacy ISA/LPC devices may access these
-    devices through so-called "indirect IO" method. In this, IO
-    space accesses for non-PCI hosts are redirected to a host
-    LLDD to manually generate the IO space (bus) accesses. Hosts
-    are able to register a region in logical PIO space to map to
-    its bus address range.
-    
-    Indirect IO child devices have an associated host-specific bus
-    address. Special translation is required to map between
-    a logical PIO address for a device and it's host bus address.
-    
-    Since in the ACPI tables the child device IO resources would
-    be the host-specific values, it is required the ACPI scan code
-    should not enumerate these devices, and that this should be
-    the responsibility of the host driver so that it can "fixup"
-    the resources so that they map to the appropriate logical PIO
-    addresses.
-    
-    To avoid enumerating these child devices, we add a check from
-    acpi_device_enumeration_by_parent() as to whether the parent
-    for a device is a member of a known list of "indirect IO" hosts.
-    For now, the HiSilicon LPC host controller ID is added.
+    Through the logical PIO framework, systems which otherwise have no IO space
+    access to legacy ISA/LPC devices may access these devices through so-called
+    "indirect IO" method.  In this, IO space accesses for non-PCI hosts are
+    redirected to a host LLDD to manually generate the IO space (bus) accesses.
+    Hosts are able to register a region in logical PIO space to map to its bus
+    address range.
+    
+    Indirect IO child devices have an associated host-specific bus address.
+    Special translation is required to map between a logical PIO address for a
+    device and its host bus address.
+    
+    Since in the ACPI tables the child device IO resources would be the
+    host-specific values, it is required the ACPI scan code should not
+    enumerate these devices, and that this should be the responsibility of the
+    host driver so that it can "fixup" the resources so that they map to the
+    appropriate logical PIO addresses.
+    
+    To avoid enumerating these child devices, add a check from
+    acpi_device_enumeration_by_parent() as to whether the parent for a device
+    is a member of a known list of "indirect IO" hosts.  For now, the HiSilicon
+    LPC host controller ID is added.
     
-    Signed-off-by: John Garry <john.garry@huawei.com>
-    Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
-    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
     Tested-by: dann frazier <dann.frazier@canonical.com>
+    Signed-off-by: John Garry <john.garry@huawei.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
+    Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
-commit b4eee6c070c3
+commit 87200d40b07a
 Author: John Garry <john.garry@huawei.com>
 Date:   Thu Mar 15 02:15:56 2018 +0800
 
-    ACPI / scan: rename acpi_is_serial_bus_slave() to widen use
+    ACPI / scan: Rename acpi_is_serial_bus_slave() for more general use
     
-    Currently the ACPI scan has special handling for serial bus
-    slaves, in that it makes it the responsibility of the the slave
-    device's parent to enumerate the device.
-    
-    To support in future other types of slave devices which require
-    the same special handling, but where the bus is not strictly a
-    serial bus - such as devices on the HiSilicon LPC controller bus -
-    rename acpi_is_serial_bus_slave() to
-    acpi_device_enumeration_by_parent(), so that the name can fit the
-    wider purpose.
+    Currently the ACPI scan has special handling for serial bus slaves, in that
+    it makes it the responsibility of the slave device's parent to enumerate
+    the device.
+    
+    To support other types of slave devices which require the same special
+    handling but where the bus is not strictly a serial bus, such as devices on
+    the HiSilicon LPC controller bus, rename acpi_is_serial_bus_slave() to
+    acpi_device_enumeration_by_parent(), so that the name can fit the wider
+    purpose.
     
-    Associated device flag acpi_device_flags.serial_bus_slave is also
-    renamed to .enumeration_by_parent.
+    Also rename the associated device flag acpi_device_flags.serial_bus_slave
+    to .enumeration_by_parent.
     
     Signed-off-by: John Garry <john.garry@huawei.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
-commit d9de40ca46a7
+commit a9a860ecbea9
 Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
-Date:   Wed Mar 21 18:33:39 2018 -0500
+Date:   Wed Mar 21 17:23:02 2018 -0500
 
     HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings
     
-    The low-pin-count(LPC) interface of Hip06/Hip07 accesses the peripherals in
-    I/O port addresses. This patch implements the LPC host controller driver
-    which perform the I/O operations on the underlying hardware.
-    We don't want to touch those existing peripherals' driver, such as ipmi-bt.
-    So this driver applies the indirect-IO introduced in the previous patch
-    after registering an indirect-IO node to the indirect-IO devices list which
-    will be searched in the I/O accessors to retrieve the host-local I/O port.
-    
-    The driver config is set as a bool instead of a trisate. The reason
-    here is that, by the very nature of the driver providing a logical
-    PIO range, it does not make sense to have this driver as a loadable
-    module. Another more specific reason is that the Huawei D03 board
-    which includes hip06 SoC requires the LPC bus for UART console, so
-    should be built in.
+    The low-pin-count (LPC) interface of Hip06/Hip07 accesses I/O port space of
+    peripherals.
     
+    Implement the LPC host controller driver which performs the I/O operations
+    on the underlying hardware.  We don't want to touch existing drivers such
+    as ipmi-bt, so this driver applies the indirect-IO introduced in the
+    previous patch after registering an indirect-IO node to the indirect-IO
+    devices list which will be searched by the I/O accessors to retrieve the
+    host-local I/O port.
+    
+    The driver config is set as a bool instead of a tristate.  The reason here
+    is that, by the very nature of the driver providing a logical PIO range, it
+    does not make sense to have this driver as a loadable module.  Another more
+    specific reason is that the Huawei D03 board which includes Hip06 SoC
+    requires the LPC bus for UART console, so should be built in.
+    
+    Tested-by: dann frazier <dann.frazier@canonical.com>
     Signed-off-by: Zou Rongrong <zourongrong@huawei.com>
     Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
     Signed-off-by: John Garry <john.garry@huawei.com>
-    Acked-by: Rob Herring <robh@kernel.org> #dts part
     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
-    Tested-by: dann frazier <dann.frazier@canonical.com>
+    Acked-by: Rob Herring <robh@kernel.org> #dts part
 
-commit db64f8630d14
+commit 03be72aeeb79
 Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
 Date:   Thu Mar 15 02:15:54 2018 +0800
 
-    OF: Add missing I/O range exception for indirect-IO devices
+    of: Add missing I/O range exception for indirect-IO devices
     
     There are some special ISA/LPC devices that work on a specific I/O range
-    where it is not correct to specify a 'ranges' property in DTS parent node
-    as CPU addresses translated from DTS node are only for memory space on
-    some architectures, such as Arm64. Without the parent 'ranges' property,
-    current of_translate_address() return an error.
+    where it is not correct to specify a 'ranges' property in the DTS parent
+    node as CPU addresses translated from DTS node are only for memory space on
+    some architectures, such as ARM64.  Without the parent 'ranges' property,
+    of_translate_address() returns an error.
+    
     Here we add special handling for this case.
+    
     During the OF address translation, some checking will be performed to
-    identify whether the device node is registered as indirect-IO. If yes,
+    identify whether the device node is registered as indirect-IO.  If it is,
     the I/O translation will be done in a different way from that one of PCI
-    MMIO. In this way, the I/O 'reg' property of the special ISA/LPC devices
+    MMIO.  In this way, the I/O 'reg' property of the special ISA/LPC devices
     will be parsed correctly.
     
+    Tested-by: dann frazier <dann.frazier@canonical.com>
     Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
-    Signed-off-by: Arnd Bergmann <arnd@arndb.de>    #earlier draft
-    Acked-by: Rob Herring <robh@kernel.org>
-    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
-    Tested-by: dann frazier <dann.frazier@canonical.com>
+    Signed-off-by: Arnd Bergmann <arnd@arndb.de>    # earlier draft
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
+    Acked-by: Rob Herring <robh@kernel.org>
 
-commit 2add4c7b6bb7
+commit 54106314daf5
 Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
 Date:   Thu Mar 15 02:15:53 2018 +0800
 
     PCI: Apply the new generic I/O management on PCI IO hosts
     
-    After introducing the new generic I/O space management(Logical PIO), the
+    After introducing the new generic I/O space management (Logical PIO), the
     original PCI MMIO relevant helpers need to be updated based on the new
     interfaces defined in logical PIO.
-    This patch adapts the corresponding code to match the changes introduced
-    by logical PIO.
     
+    Adapt the corresponding code to match the changes introduced by logical
+    PIO.
+    
+    Tested-by: dann frazier <dann.frazier@canonical.com>
     Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
-    Signed-off-by: Arnd Bergmann <arnd@arndb.de>        #earlier draft
-    Acked-by: Bjorn Helgaas <bhelgaas@google.com>
-    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
-    Tested-by: dann frazier <dann.frazier@canonical.com>
+    Signed-off-by: Arnd Bergmann <arnd@arndb.de>        # earlier draft
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
 
-commit cb37d289dfc4
+commit 32f7562cfd58
 Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
 Date:   Thu Mar 15 02:15:52 2018 +0800
 
     PCI: Add fwnode handler as input param of pci_register_io_range()
     
-    In preparation for having the PCI MMIO helpers to use the new generic
-    I/O space management(logical PIO) we need to add the fwnode handler as
+    In preparation for having the PCI MMIO helpers use the new generic I/O
+    space management (logical PIO) we need to add the fwnode handler as an
     extra input parameter.
-    This patch changes the signature of pci_register_io_range() and of
-    its callers as needed.
     
-    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
-    Acked-by: Bjorn Helgaas <bhelgaas@google.com>
-    Acked-by: Rob Herring <robh@kernel.org>
-    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
+    Changes the signature of pci_register_io_range() and its callers as
+    needed.
+    
     Tested-by: dann frazier <dann.frazier@canonical.com>
+    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
+    Acked-by: Rob Herring <robh@kernel.org>
 
-commit 0b0694ca8843
+commit c9f9c9eed8e2
 Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
 Date:   Thu Mar 15 02:15:51 2018 +0800
 
-    PCI: Remove unused __weak attribute in pci_register_io_range()
+    PCI: Remove __weak tag from pci_register_io_range()
     
-    Currently pci_register_io_range() has only one definition;
-    therefore there is no use of the __weak attribute.
+    pci_register_io_range() has only one definition, so there is no need for
+    the __weak attribute.  Remove it.
     
-    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
-    Acked-by: Bjorn Helgaas <bhelgaas@google.com>
-    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
     Tested-by: dann frazier <dann.frazier@canonical.com>
+    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
 
-commit f3ac523feb71
+commit e180fa3830cf
 Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
 Date:   Thu Mar 15 02:15:50 2018 +0800
 
-    LIB: Introduce a generic PIO mapping method
+    lib: Add generic PIO mapping method
     
-    In commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
-    pci_pio_to_address()"), a new I/O space management was supported. With
-    that driver, the I/O ranges configured for PCI/PCIe hosts on some
-    architectures can be mapped to logical PIO, converted easily between
-    CPU address and the corresponding logicial PIO. Based on this, PCI
-    I/O devices can be accessed in a memory read/write way through the
-    unified in/out accessors.
-    
-    But on some archs/platforms, there are bus hosts which access I/O
-    peripherals with host-local I/O port addresses rather than memory
-    addresses after memory-mapped.
-    
-    To support those devices, a more generic I/O mapping method is introduced
-    here. Through this patch, both the CPU addresses and the host-local port
-    can be mapped into the logical PIO space with different logical/fake PIOs.
-    After this, all the I/O accesses to either PCI MMIO devices or host-local
-    I/O peripherals can be unified into the existing I/O accessors defined in
-    asm-generic/io.h and be redirected to the right device-specific hooks
-    based on the input logical PIO.
+    41f8bba7f555 ("of/pci: Add pci_register_io_range() and
+    pci_pio_to_address()") added support for PCI I/O space mapped into CPU
+    physical memory space.  With that support, the I/O ranges configured for
+    PCI/PCIe hosts on some architectures can be mapped to logical PIO and
+    converted easily between CPU address and the corresponding logical PIO.
+    Based on this, PCI I/O port space can be accessed via in/out accessors that
+    use memory read/write.
+    
+    But on some platforms, there are bus hosts that access I/O port space with
+    host-local I/O port addresses rather than memory addresses.
+    
+    Add a more generic I/O mapping method to support those devices.  With this
+    patch, both the CPU addresses and the host-local port can be mapped into
+    the logical PIO space with different logical/fake PIOs.  After this, all
+    the I/O accesses to either PCI MMIO devices or host-local I/O peripherals
+    can be unified into the existing I/O accessors defined in asm-generic/io.h
+    and be redirected to the right device-specific hooks based on the input
+    logical PIO.
     
+    Tested-by: dann frazier <dann.frazier@canonical.com>
     Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
     Signed-off-by: John Garry <john.garry@huawei.com>
-    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
-    Tested-by: dann frazier <dann.frazier@canonical.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
index 213181f3aff9..10bd35f9207f 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
@@ -1,8 +1,8 @@
-Hisilicon Hip06 low-pin-count device
+Hisilicon Hip06 Low Pin Count device
   Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
   provides I/O access to some legacy ISA devices.
   Hip06 is based on arm64 architecture where there is no I/O space. So, the
-  I/O ports here are not cpu addresses, and there is no 'ranges' property in
+  I/O ports here are not CPU addresses, and there is no 'ranges' property in
   LPC device node.
 
 Required properties:
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 88739f697ab5..a3fad0f0292f 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -66,12 +66,12 @@ config BRCMSTB_GISB_ARB
 	  and internal bus master decoding.
 
 config HISILICON_LPC
-	bool "Support for ISA I/O space on Hisilicon hip06/7"
+	bool "Support for ISA I/O space on HiSilicon Hip06/7"
 	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
 	select INDIRECT_PIO
 	help
-	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
-	  on Hisilicon hip06/7 SoC.
+	  Driver to enable I/O access to devices attached to the Low Pin
+	  Count bus on the HiSilicon Hip06/7 SoC.
 
 config IMX_WEIM
 	bool "Freescale EIM DRIVER"
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 9d38cfa17da1..2d4611e4c339 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -4,7 +4,6 @@
  * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
  * Author: Zou Rongrong <zourongrong@huawei.com>
  * Author: John Garry <john.garry@huawei.com>
- *
  */
 
 #include <linux/acpi.h>
@@ -23,16 +22,15 @@
 #define DRV_NAME "hisi-lpc"
 
 /*
- * Setting this bit means each IO operation will target to a
- * different port address:
- * 0 means repeatedly IO operations will stick on the same port,
- * such as BT;
+ * Setting this bit means each IO operation will target a different port
+ * address; 0 means repeated IO operations will use the same port,
+ * such as BT.
  */
 #define FG_INCRADDR_LPC		0x02
 
 struct lpc_cycle_para {
 	unsigned int opflags;
-	unsigned int csize; /* the data length of each operation */
+	unsigned int csize; /* data length of each operation */
 };
 
 struct hisi_lpc_dev {
@@ -41,7 +39,7 @@ struct hisi_lpc_dev {
 	struct logic_pio_hwaddr *io_host;
 };
 
-/* The maxIO cycle counts supported is four per operation at maximum */
+/* The max IO cycle counts supported is four per operation at maximum */
 #define LPC_MAX_DWIDTH	4
 
 #define LPC_REG_STARTUP_SIGNAL		0x00
@@ -57,27 +55,30 @@ struct hisi_lpc_dev {
 #define LPC_REG_WDATA			0x24 /* write FIFO */
 #define LPC_REG_RDATA			0x28 /* read FIFO */
 
-/* The minimal nanosecond interval for each query on LPC cycle status. */
+/* The minimal nanosecond interval for each query on LPC cycle status */
 #define LPC_NSEC_PERWAIT	100
 
 /*
- * The maximum waiting time is about 128us.
- * It is specific for stream I/O, such as ins.
+ * The maximum waiting time is about 128us.  It is specific for stream I/O,
+ * such as ins.
+ *
  * The fastest IO cycle time is about 390ns, but the worst case will wait
- * for extra 256 lpc clocks, so (256 + 13) * 30ns = 8 us. The maximum
- * burst cycles is 16. So, the maximum waiting time is about 128us under
- * worst case.
- * choose 1300 as the maximum.
+ * for extra 256 lpc clocks, so (256 + 13) * 30ns = 8 us. The maximum burst
+ * cycles is 16. So, the maximum waiting time is about 128us under worst
+ * case.
+ *
+ * Choose 1300 as the maximum.
  */
 #define LPC_MAX_WAITCNT		1300
-/* About 10us. This is specific for single IO operation, such as inb. */
+
+/* About 10us. This is specific for single IO operations, such as inb */
 #define LPC_PEROP_WAITCNT	100
 
-static inline int wait_lpc_idle(unsigned char *mbase,
-				unsigned int waitcnt) {
-	do {
-		u32 status;
+static int wait_lpc_idle(unsigned char *mbase, unsigned int waitcnt)
+{
+	u32 status;
 
+	do {
 		status = readl(mbase + LPC_REG_OP_STATUS);
 		if (status & LPC_REG_OP_STATUS_IDLE)
 			return (status & LPC_REG_OP_STATUS_FINISHED) ? 0 : -EIO;
@@ -97,10 +98,9 @@ static inline int wait_lpc_idle(unsigned char *mbase,
  *
  * Returns 0 on success, non-zero on fail.
  */
-static int
-hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev, struct lpc_cycle_para *para,
-		  unsigned long addr, unsigned char *buf,
-		  unsigned long opcnt)
+static int hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev,
+			      struct lpc_cycle_para *para, unsigned long addr,
+			      unsigned char *buf, unsigned long opcnt)
 {
 	unsigned int cmd_word;
 	unsigned int waitcnt;
@@ -121,9 +121,7 @@ hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev, struct lpc_cycle_para *para,
 	spin_lock_irqsave(&lpcdev->cycle_lock, flags);
 
 	writel_relaxed(opcnt, lpcdev->membase + LPC_REG_OP_LEN);
-
 	writel_relaxed(cmd_word, lpcdev->membase + LPC_REG_CMD);
-
 	writel_relaxed(addr, lpcdev->membase + LPC_REG_ADDR);
 
 	writel(LPC_REG_STARTUP_SIGNAL_START,
@@ -153,10 +151,9 @@ hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev, struct lpc_cycle_para *para,
  *
  * Returns 0 on success, non-zero on fail.
  */
-static int
-hisi_lpc_target_out(struct hisi_lpc_dev *lpcdev, struct lpc_cycle_para *para,
-		    unsigned long addr, const unsigned char *buf,
-		    unsigned long opcnt)
+static int hisi_lpc_target_out(struct hisi_lpc_dev *lpcdev,
+			       struct lpc_cycle_para *para, unsigned long addr,
+			       const unsigned char *buf, unsigned long opcnt)
 {
 	unsigned int waitcnt;
 	unsigned long flags;
@@ -193,17 +190,17 @@ hisi_lpc_target_out(struct hisi_lpc_dev *lpcdev, struct lpc_cycle_para *para,
 	return ret;
 }
 
-static inline unsigned long
-hisi_lpc_pio_to_addr(struct hisi_lpc_dev *lpcdev, unsigned long pio)
+static unsigned long hisi_lpc_pio_to_addr(struct hisi_lpc_dev *lpcdev,
+					  unsigned long pio)
 {
 	return pio - lpcdev->io_host->io_start + lpcdev->io_host->hw_start;
 }
 
 /*
  * hisi_lpc_comm_in - input the data in a single operation
- * @hostdata: pointer to the device information relevant to LPC controller.
- * @pio: the target I/O port address.
- * @dwidth: the data length required to read from the target I/O port.
+ * @hostdata: pointer to the device information relevant to LPC controller
+ * @pio: the target I/O port address
+ * @dwidth: the data length required to read from the target I/O port
  *
  * When success, data is returned. Otherwise, ~0 is returned.
  */
@@ -233,16 +230,15 @@ static u32 hisi_lpc_comm_in(void *hostdata, unsigned long pio, size_t dwidth)
 
 /*
  * hisi_lpc_comm_out - output the data in a single operation
- * @hostdata: pointer to the device information relevant to LPC controller.
- * @pio: the target I/O port address.
- * @val: a value to be outputted from caller, maximum is four bytes.
- * @dwidth: the data width required writing to the target I/O port.
- *
- * This function is corresponding to out(b,w,l) only
+ * @hostdata: pointer to the device information relevant to LPC controller
+ * @pio: the target I/O port address
+ * @val: a value to be output from caller, maximum is four bytes
+ * @dwidth: the data width required writing to the target I/O port
  *
+ * This function corresponds to out(b,w,l) only.
  */
 static void hisi_lpc_comm_out(void *hostdata, unsigned long pio,
-			     u32 val, size_t dwidth)
+			      u32 val, size_t dwidth)
 {
 	struct hisi_lpc_dev *lpcdev = hostdata;
 	struct lpc_cycle_para iopara;
@@ -265,19 +261,17 @@ static void hisi_lpc_comm_out(void *hostdata, unsigned long pio,
 
 /*
  * hisi_lpc_comm_ins - input the data in the buffer in multiple operations
- * @hostdata: pointer to the device information relevant to LPC controller.
- * @pio: the target I/O port address.
- * @buffer: a buffer where read/input data bytes are stored.
- * @dwidth: the data width required writing to the target I/O port.
- * @count: how many data units whose length is dwidth will be read.
+ * @hostdata: pointer to the device information relevant to LPC controller
+ * @pio: the target I/O port address
+ * @buffer: a buffer where read/input data bytes are stored
+ * @dwidth: the data width required writing to the target I/O port
+ * @count: how many data units whose length is dwidth will be read
  *
  * When success, the data read back is stored in buffer pointed by buffer.
- * Returns 0 on success, -errno otherwise
- *
+ * Returns 0 on success, -errno otherwise.
  */
-static u32
-hisi_lpc_comm_ins(void *hostdata, unsigned long pio, void *buffer,
-		  size_t dwidth, unsigned int count)
+static u32 hisi_lpc_comm_ins(void *hostdata, unsigned long pio, void *buffer,
+			     size_t dwidth, unsigned int count)
 {
 	struct hisi_lpc_dev *lpcdev = hostdata;
 	unsigned char *buf = buffer;
@@ -308,16 +302,15 @@ hisi_lpc_comm_ins(void *hostdata, unsigned long pio, void *buffer,
 
 /*
  * hisi_lpc_comm_outs - output the data in the buffer in multiple operations
- * @hostdata: pointer to the device information relevant to LPC controller.
- * @pio: the target I/O port address.
- * @buffer: a buffer where write/output data bytes are stored.
- * @dwidth: the data width required writing to the target I/O port .
- * @count: how many data units whose length is dwidth will be written.
- *
+ * @hostdata: pointer to the device information relevant to LPC controller
+ * @pio: the target I/O port address
+ * @buffer: a buffer where write/output data bytes are stored
+ * @dwidth: the data width required writing to the target I/O port
+ * @count: how many data units whose length is dwidth will be written
  */
-static void
-hisi_lpc_comm_outs(void *hostdata, unsigned long pio, const void *buffer,
-		   size_t dwidth, unsigned int count)
+static void hisi_lpc_comm_outs(void *hostdata, unsigned long pio,
+			       const void *buffer, size_t dwidth,
+			       unsigned int count)
 {
 	struct hisi_lpc_dev *lpcdev = hostdata;
 	struct lpc_cycle_para iopara;
@@ -384,13 +377,12 @@ static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
  * Returns 0 when successful, and a negative value for failure.
  *
  * For a given host controller, each child device will have an associated
- * host-relative address resource. This function will return the translated
+ * host-relative address resource.  This function will return the translated
  * logical PIO addresses for each child devices resources.
  */
 static int hisi_lpc_acpi_set_io_res(struct device *child,
 				    struct device *hostdev,
-				    const struct resource **res,
-				    int *num_res)
+				    const struct resource **res, int *num_res)
 {
 	struct acpi_device *adev;
 	struct acpi_device *host;
@@ -406,12 +398,11 @@ static int hisi_lpc_acpi_set_io_res(struct device *child,
 	host = to_acpi_device(hostdev);
 	adev = to_acpi_device(child);
 
-	/* check the device state */
 	if (!adev->status.present) {
 		dev_dbg(child, "device is not present\n");
 		return -EIO;
 	}
-	/* whether the child had been enumerated? */
+
 	if (acpi_device_enumerated(adev)) {
 		dev_dbg(child, "has been enumerated\n");
 		return -EIO;
@@ -450,7 +441,8 @@ static int hisi_lpc_acpi_set_io_res(struct device *child,
 			continue;
 		ret = hisi_lpc_acpi_xlat_io_res(adev, host, &resources[i]);
 		if (ret) {
-			dev_err(child, "translate IO range failed(%d)\n", ret);
+			dev_err(child, "translate IO range %pR failed (%d)\n",
+				&resources[i], ret);
 			return ret;
 		}
 	}
@@ -501,7 +493,7 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 		};
 
 		/*
-		 * For any instances of this host controller (hip06 and hip07
+		 * For any instances of this host controller (Hip06 and Hip07
 		 * are the only chipsets), we would not have multiple slaves
 		 * with the same HID. And in any system we would have just one
 		 * controller active. So don't worrry about MFD name clashes.
@@ -518,7 +510,7 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 					       &mfd_cell->resources,
 					       &mfd_cell->num_resources);
 		if (ret) {
-			dev_warn(&child->dev, "set resource fail(%d)\n", ret);
+			dev_warn(&child->dev, "set resource fail (%d)\n", ret);
 			return ret;
 		}
 		count++;
@@ -576,6 +568,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
 	if (!range)
 		return -ENOMEM;
+
 	range->fwnode = dev->fwnode;
 	range->flags = LOGIC_PIO_INDIRECT;
 	range->size = PIO_INDIRECT_SIZE;
@@ -588,10 +581,10 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	lpcdev->io_host = range;
 
 	/* register the LPC host PIO resources */
-	if (!acpi_device)
-		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
-	else
+	if (acpi_device)
 		ret = hisi_lpc_acpi_probe(dev);
+	else
+		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret)
 		return ret;
 
@@ -619,5 +612,4 @@ static struct platform_driver hisi_lpc_driver = {
 	},
 	.probe = hisi_lpc_probe,
 };
-
 builtin_platform_driver(hisi_lpc_driver);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index c434f65922bc..53349912ac75 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -738,11 +738,11 @@ static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
 
 	taddr = __of_translate_address(dev, in_addr, "ranges", &host);
 	if (host) {
-		/* host specific port access */
+		/* host-specific port access */
 		port = logic_pio_trans_hwaddr(&host->fwnode, taddr, size);
 		of_node_put(host);
 	} else {
-		/* memory mapped I/O range */
+		/* memory-mapped I/O range */
 		port = pci_address_to_pio(taddr);
 	}
 
diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index 8c78ff449d81..cbd9d8495690 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Copyright (C) 2017 HiSilicon Limited, All Rights Reserved.
  * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
  * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
- *
  */
 
 #ifndef __LINUX_LOGIC_PIO_H
@@ -13,7 +12,7 @@
 
 enum {
 	LOGIC_PIO_INDIRECT,		/* Indirect IO flag */
-	LOGIC_PIO_CPU_MMIO,		/* Memory mapped IO flag */
+	LOGIC_PIO_CPU_MMIO,		/* Memory-mapped IO flag */
 };
 
 struct logic_pio_hwaddr {
@@ -104,8 +103,8 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
 #endif
 
 /*
- * Below we reserve 0x4000 bytes for Indirect IO as so far this library is only
- * used by Hisilicon LPC Host. If needed in future we may reserve a wider IO
+ * We reserve 0x4000 bytes for Indirect IO as so far this library is only
+ * used by the HiSilicon LPC Host. If needed, we can reserve a wider IO
  * area by redefining the macro below.
  */
 #define PIO_INDIRECT_SIZE 0x4000
@@ -118,7 +117,7 @@ struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
 unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
 			resource_size_t hw_addr, resource_size_t size);
 int logic_pio_register_range(struct logic_pio_hwaddr *newrange);
-extern resource_size_t logic_pio_to_hwaddr(unsigned long pio);
-extern unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
+resource_size_t logic_pio_to_hwaddr(unsigned long pio);
+unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
 
 #endif /* __LINUX_LOGIC_PIO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index d9dd02cfe176..5fe577673b98 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -62,9 +62,10 @@ config INDIRECT_PIO
 	  On some platforms where no separate I/O space exists, there are I/O
 	  hosts which can not be accessed in MMIO mode. Using the logical PIO
 	  mechanism, the host-local I/O resource can be mapped into system
-	  logic PIO space shared with MMIO hosts, such as PCI/PCIE, then the
-	  system can access the I/O devices with the mapped logic PIO through
+	  logic PIO space shared with MMIO hosts, such as PCI/PCIe, then the
+	  system can access the I/O devices with the mapped-logic PIO through
 	  I/O accessors.
+
 	  This way has relatively little I/O performance cost. Please make
 	  sure your devices really need this configure item enabled.
 
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 8394c2d4e534..dc3e9695f7f5 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Copyright (C) 2017 HiSilicon Limited, All Rights Reserved.
  * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
  * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
- *
  */
 
 #define pr_fmt(fmt)	"LOGIC PIO: " fmt
@@ -16,7 +15,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
-/* The unique hardware address list. */
+/* The unique hardware address list */
 static LIST_HEAD(io_range_list);
 static DEFINE_MUTEX(io_range_mutex);
 
@@ -25,11 +24,11 @@ static DEFINE_MUTEX(io_range_mutex);
 
 /**
  * logic_pio_register_range - register logical PIO range for a host
- * @new_range: pointer to the io range to be registered.
+ * @new_range: pointer to the IO range to be registered.
  *
- * returns 0 on success, the error code in case of failure
+ * Returns 0 on success, the error code in case of failure.
  *
- * Register a new io range node in the io range list.
+ * Register a new IO range node in the IO range list.
  */
 int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 {
@@ -101,10 +100,9 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
  * find_io_range_by_fwnode - find logical PIO range for given FW node
  * @fwnode: FW node handle associated with logical PIO range
  *
- * Returns pointer to node on success, NULL otherwise
+ * Returns pointer to node on success, NULL otherwise.
  *
- * Traverse the io_range_list to find the registered node whose device node
- * and/or physical IO address match to.
+ * Traverse the io_range_list to find the registered node for @fwnode.
  */
 struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode)
 {
@@ -126,7 +124,7 @@ static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
 		if (in_range(pio, range->io_start, range->size))
 			return range;
 	}
-	pr_err("PIO entry token invalid\n");
+	pr_err("PIO entry token %lx invalid\n", pio);
 	return NULL;
 }
 
@@ -134,21 +132,20 @@ static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
  * logic_pio_to_hwaddr - translate logical PIO to HW address
  * @pio: logical PIO value
  *
- * Returns HW address if valid, ~0 otherwise
+ * Returns HW address if valid, ~0 otherwise.
  *
- * Translate the input logical pio to the corresponding hardware address.
- * The input pio should be unique in the whole logical PIO space.
+ * Translate the input logical PIO to the corresponding hardware address.
+ * The input PIO should be unique in the whole logical PIO space.
  */
 resource_size_t logic_pio_to_hwaddr(unsigned long pio)
 {
 	struct logic_pio_hwaddr *range;
-	resource_size_t hwaddr = (resource_size_t)~0;
 
 	range = find_io_range(pio);
 	if (range)
-		hwaddr = range->hw_start + pio - range->io_start;
+		return = range->hw_start + pio - range->io_start;
 
-	return hwaddr;
+	return (resource_size_t)~0;
 }
 
 /**
@@ -159,15 +156,14 @@ resource_size_t logic_pio_to_hwaddr(unsigned long pio)
  *
  * Returns Logical PIO value if successful, ~0UL otherwise
  */
-unsigned long
-logic_pio_trans_hwaddr(struct fwnode_handle *fwnode, resource_size_t addr,
-		       resource_size_t size)
+unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
+				     resource_size_t addr, resource_size_t size)
 {
 	struct logic_pio_hwaddr *range;
 
 	range = find_io_range_by_fwnode(fwnode);
 	if (!range || range->flags == LOGIC_PIO_CPU_MMIO) {
-		pr_err("range not found or invalid\n");
+		pr_err("IO range not found or invalid\n");
 		return ~0UL;
 	}
 	if (range->size < size) {
@@ -178,8 +174,7 @@ logic_pio_trans_hwaddr(struct fwnode_handle *fwnode, resource_size_t addr,
 	return addr - range->hw_start + range->io_start;
 }
 
-unsigned long
-logic_pio_trans_cpuaddr(resource_size_t addr)
+unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 {
 	struct logic_pio_hwaddr *range;
 
@@ -189,7 +184,8 @@ logic_pio_trans_cpuaddr(resource_size_t addr)
 		if (in_range(addr, range->hw_start, range->size))
 			return addr - range->hw_start + range->io_start;
 	}
-	pr_err("addr not registered in io_range_list\n");
+	pr_err("addr %llx not registered in io_range_list\n",
+	       (unsigned long long) addr);
 	return ~0UL;
 }
 
