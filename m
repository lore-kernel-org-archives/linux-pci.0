Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:6642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751526AbeCNSRI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 14:17:08 -0400
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>,
        <andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v17 00/10]  LPC: legacy ISA I/O support
Date: Thu, 15 Mar 2018 02:15:49 +0800
Message-ID: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset supports the IPMI-bt device attached to the Low-Pin-Count
interface implemented on Hisilicon Hip06/Hip07 SoC.
                        -----------
                        | LPC host|
                        |         |
                        -----------
                             |
                _____________V_______________LPC
                  |                       |
                  V                       V
                                     ------------
                                     |  BT(ipmi)|
                                     ------------

When master accesses those peripherals beneath the Hip06/Hip07 LPC, a specific
LPC driver is needed to make LPC host generate the standard LPC I/O cycles with
the target peripherals'I/O port addresses. But on curent arm64 world, there is
no real I/O accesses. All the I/O operations through in/out accessors are based
on MMIO ranges; on Hip06/Hip07 LPC the I/O accesses are performed through driver
specific accessors rather than MMIO.
To solve this issue and keep the relevant existing peripherals' drivers untouched,
this patchset:
   - introduces a generic I/O space management framework, logical PIO, to support
      I/O operations on host controllers operating either on MMIO buses or on buses
     requiring specific driver I/O accessors;
   - redefines the in/out accessors to provide a unified interface for both MMIO
     and driver specific I/O operations. Using logical PIO, th call of in/out() from
     the host children drivers, such as ipmi-si, will be redirected to the
     corresponding device-specific I/O hooks to perform the I/O accesses.

Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC peripherals can
be supported without any changes on the existing ipmi-si driver.

The whole patchset has been tested on Hip07 D05 board both using DTB and ACPI.

Differences to v16:
- Add patch to rename acpi_is_serial_bus_slave()
Note: Could not rebase on recent linux-next as either build broken or fails
to boot.

Differences to v15:
- addressed further coding style comments in LLDD and logic PIO code
  from Andy
- rebased to linux next 20180302

Differences to v14:
- addressed coding style comments from Andy
- applied tags from Rafael, Andy, and Dann
- rebased to linux next 20180223 (had to fix locally arm64 build issue)

Differences to v13:
- dropped ACPI scan handler and added patch to not enumerate children
  of indirect IO hosts in ACPI code
- tidied up logic_pio.c a bit for kerneldoc and made some APIs clearer
  to understand
- tided (and simplified) hisi_lpc.c and added new ACPI probe code
  (same as previous ACPI scan handler code, so comments from Rafael
  and Andy included)
- reinstated PCI range upper limit check in pci_pio_to_address()
- dropped Dann Frazier's "tested-by" tag in light of changes
- rebase to linuxnext 20180219 (had to fix locally arm64 build issue)

Differences to v12:
    - Addressed ACPI comments from Rafael and Andy, including:
     - added SPDX license identifiers (other new files in the series got this also)
     - fixed style issues, like superflous newlines and symbol naming
     - add fuller acpi_indirectio.c patch commit message
     - dropped acpi_indirectio_host_data (author's decision) to simplify
    - added Rob Herring's tag
    - rebase to linux-next 20180212
    
Differences to v11:
    - fixed build errors for i386, m68k, and tile
    - added a comment in LPC driver commit log why we set
       the kernel config as bool
    - some tidying logic_pio code

Differences to v10:
    - dropped CONFIG_LOGIC_PIO. Reason is that CONFIG_PCI
      depends on this, and CONFIG_PCI is a per-arch CONFIG.
      So we would require all arch's kconfig to select this.
    - Addressed Dann Frazier's comments on LPC driver, and
      sopme other cleanup
    - Moved logic_pio.h to be included in generic asm io.h
    - Fixed ACPI indirect IO host setup to handle >1 child
    - Relocated ACPI indirect IO host setup code to
      drivers/acpi
    - Rebased to linux next-20180118

Changes from v9:
  - patch 2 has been split into 3 patches according to Bjorn comments on
    v9 thread
  - patch 1 has been reworked accordign to Bjorn comments on v9
  - now logic_pio_trans_hwaddr() has a sanity check to make sure the resource
    size fits into the assigned range
  - in patch 5 the MFD framework has been used to probe the LPC children
    according to the suggestion from Mika Westerberg
  - Maintaner has changed to Huawei Linuxarm mailing list

Changes from v8:
  - Simplified LIB IO framewrok
  - Moved INDIRECT PIO ACPI framework under acpi/arm64
  - Renamed occurrences of "lib io" and "indirect io" to "lib pio" and
    "indirect pio" to keep the patchset nomenclature consistent
  - Removed Alignment reuqirements
  - Moved LPC specific code out of ACPI common framework
  - Now PIO indirect HW ranges can overlap
  - Changed HiSilicon LPC driver maintainer (Gabriele Paoloni now) and split
    maintaner file modifications in a separate commit
  - Removed the commit with the DT nodes support for hip06 and hip07 (to be
    pushed separately)
  - Added a checking on ioport_map() not to break that function as Arnd points
    out in V7 review thread;
  - fixed the compile issues on alpha, m68k;

Changes from V7:
  - Based on Arnd's comment, rename the LIBIO as LOGIC_PIO;
  - Improved the mapping process in LOGIC_PIO to gain better efficiency when
    redirecting the I/O accesses to right device driver;
  - To reduce the impact on PCI MMIO to a minimum, add a new
    CONFIG_INDIRECT_PIO for indirect-IO hosts/devices;
  - Added a new ACPI handler for indirect-IO hosts/devices;
  - Fixed the compile issues on V6;

Changes from V6:
  - According to the comments from Bjorn and Alex, merge PCI IO and indirect-IO
    into a generic I/O space management, LIBIO;
  - Adopted the '_DEP' to replace the platform bus notifier. In this way, we can
    ensure the LPC peripherals' I/O resources had been translated to logical IO
    before the LPC peripheral enumeration;
  - Replaced the rwlock with rcu list based on Alex's suggestion;
  - Applied relaxed write/read to LPC driver;
  - Some bugs fixing and some optimazations based on the comments of V6;

Changes from V5:
  - Made the extio driver more generic and locate in lib/;
  - Supported multiple indirect-IO bus instances;
  - Extended the pci_register_io_range() to support indirect-IO, then dropped
  the I/O reservation used in previous patchset;
  - Reimplemented the ACPI LPC support;
  - Fixed some bugs, including the compile error on other archs, the module
  building failure found by Ming Lei, etc;

Changes from V4:
  - Some revises based on the comments from Bjorn, Rob on V4;
  - Fixed the compile error on some platforms, such as openrisc;

Changes from V3:
  - UART support deferred to a separate patchset; This patchset only support
  ipmi device under LPC;
  - LPC bus I/O range is fixed to 0 ~ (PCIBIOS_MIN_IO - 1), which is separeted
  from PCI/PCIE PIO space;
  - Based on Arnd's remarks, removed the ranges property from Hip06 lpc dts and
  added a new fixup function, of_isa_indirect_io(), to get the I/O address
  directly from LPC dts configurations;
  - Support in(w,l)/out(w,l) for Hip06 lpc I/O;
  - Decouple the header file dependency on the gerenic io.h by defining in/out
  as normal functions in c file;
  - removed unused macro definitions in the LPC driver;

Changes from V2:
  - Support the PIO retrieval from the linux PIO generated by
  pci_address_to_pio. This method replace the 4K PIO reservation in V2;
  - Support the flat-tree earlycon;
  - Some revises based on Arnd's remarks;
  - Make sure the linux PIO range allocated to Hip06 LPC peripherals starts
  from non-ZERO;

Changes from V1:
  - Support the ACPI LPC device;
  - Optimize the dts LPC driver in ISA compatible mode;
  - Reserve the IO range below 4K in avoid the possible conflict with PCI host
  IO ranges;
  - Support the LPC uart and relevant earlycon;

V16 thread here: https://lkml.org/lkml/2018/2/26/584
V15 thread here: https://lkml.org/lkml/2018/2/26/584
V14 thread here: https://lkml.org/lkml/2018/2/19/460
V13 thread here: https://lkml.org/lkml/2018/2/13/744
V12 thread here: https://lkml.org/lkml/2018/1/23/508
V11 thread here: https://lkml.org/lkml/2018/1/21/38
V10 thread here: https://lkml.org/lkml/2017/10/27/465
V9 thread here: https://lkml.org/lkml/2017/5/25/263
V8 thread here: https://lkml.org/lkml/2017/3/30/619
V7 thread here: https://lkml.org/lkml/2017/3/12/279
v6 thread here: https://lkml.org/lkml/2017/1/24/25
v5 thread here: https://lkml.org/lkml/2016/11/7/955
v4 thread here: https://lkml.org/lkml/2016/10/20/149
v3 thread here: https://lkml.org/lkml/2016/9/14/326
v2 thread here: https://lkml.org/lkml/2016/9/7/356
v1 thread here: https://lkml.org/lkml/2015/12/29/154

Gabriele Paoloni (2):
  PCI: Remove unused __weak attribute in pci_register_io_range()
  PCI: Add fwnode handler as input param of pci_register_io_range()

John Garry (4):
  ACPI / scan: rename acpi_is_serial_bus_slave() to widen use
  ACPI / scan: do not enumerate Indirect IO host children
  HISI LPC: Add ACPI support
  MAINTAINERS: Add maintainer for HiSilicon LPC driver

Zhichang Yuan (4):
  LIB: Introduce a generic PIO mapping method
  PCI: Apply the new generic I/O management on PCI IO hosts
  OF: Add missing I/O range exception for indirect-IO devices
  HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings

 .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
 MAINTAINERS                                        |   7 +
 drivers/acpi/pci_root.c                            |   8 +-
 drivers/acpi/scan.c                                |  33 +-
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/hisi_lpc.c                             | 623 +++++++++++++++++++++
 drivers/of/address.c                               |  96 +++-
 drivers/pci/pci.c                                  |  95 +---
 include/acpi/acpi_bus.h                            |   2 +-
 include/asm-generic/io.h                           |   4 +-
 include/linux/logic_pio.h                          | 124 ++++
 include/linux/pci.h                                |   3 +-
 lib/Kconfig                                        |  15 +
 lib/Makefile                                       |   2 +
 lib/logic_pio.c                                    | 282 ++++++++++
 16 files changed, 1229 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
 create mode 100644 drivers/bus/hisi_lpc.c
 create mode 100644 include/linux/logic_pio.h
 create mode 100644 lib/logic_pio.c

-- 
1.9.1
