Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V8 0/7] LPC: legacy ISA I/O support
To: dann frazier <dann.frazier@canonical.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <CALdTtnsoxNrfmaRn=OtessSC=Ln7pHV5dUBd75uDax3watEoAw@mail.gmail.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <58DDF8F1.8010309@hisilicon.com>
Date: Fri, 31 Mar 2017 14:36:33 +0800
MIME-Version: 1.0
In-Reply-To: <CALdTtnsoxNrfmaRn=OtessSC=Ln7pHV5dUBd75uDax3watEoAw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, rafael@kernel.org,
 benh@kernel.crashing.org, Will Deacon <will.deacon@arm.com>,
 linuxarm@huawei.com, Frank Rowand <frowand.list@gmail.com>,
 lorenzo.pieralisi@arm.com, Corey Minyard <minyard@acm.org>,
 xuwei5@hisilicon.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, John Garry <john.garry@huawei.com>,
 olof@lixom.net, Rob Herring <robh+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kantyzc@163.com,
 "zhichang.yuan" <zhichang.yuan02@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Zou Rongrong <zourongrong@gmail.com>, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Dann,

Many thanks for your tests!

Best,
Zhichang

On 2017/3/31 5:42, dann frazier wrote:
> On Thu, Mar 30, 2017 at 9:26 AM, zhichang.yuan
> <yuanzhichang@hisilicon.com> wrote:
>> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
>> interface implemented on Hisilicon Hip06/Hip07 SoC.
>>                         -----------
>>                         | LPC host|
>>                         |         |
>>                         -----------
>>                              |
>>                 _____________V_______________LPC
>>                   |                       |
>>                   V                       V
>>                                      ------------
>>                                      |  BT(ipmi)|
>>                                      ------------
>>
>> When master accesses those peripherals beneath the Hip06/Hip07 LPC, a specific
>> LPC driver is needed to make LPC host generate the standard LPC I/O cycles with
>> the target peripherals'I/O port addresses. But on curent arm64 world, there is
>> no real I/O accesses. All the I/O operations through in/out pair are based on
>> MMIO which is not satisfied the I/O mechanism on Hip06/Hip07 LPC.
>> To solve this issue and keep the relevant existing peripherals' driver
>> untouched, this patchset implements:
>>   - introduces a generic I/O space management framwork, LIBIO, to support I/O
>>     operations of both MMIO buses and the host controllers which access their
>>     peripherals with host local I/O addresses;
>>   - redefines the in/out accessors to provide unified interfaces for MMIO and
>>     legacy I/O. Based on the LIBIO, the calling of in/out() from upper-layer
>>     drivers, such as ipmi-si, will be redirected to the corresponding
>>     device-specific I/O hooks to perfrom the I/O accesses.
>> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC peripherals can
>> be supported without any changes on the existing ipmi-si driver.
>>
>> Changes from V7:
>>   - Based on Arnd's comment, rename the LIBIO as LOGIC_PIO;
>>   - Improved the mapping process in LOGIC_PIO to gain better efficiency when
>>     redirecting the I/O accesses to right device driver;
>>   - To reduce the impact on PCI MMIO to a minimum, add a new
>>     CONFIG_INDIRECT_PIO for indirect-IO hosts/devices;
>>   - Added a new ACPI handler for indirect-IO hosts/devices;
>>   - Fixed the compile issues on V6;
>>
>> Changes from V6:
>>   - According to the comments from Bjorn and Alex, merge PCI IO and indirect-IO
>>     into a generic I/O space management, LIBIO;
>>   - Adopted the '_DEP' to replace the platform bus notifier. In this way, we can
>>     ensure the LPC peripherals' I/O resources had been translated to logical IO
>>     before the LPC peripheral enumeration;
>>   - Replaced the rwlock with rcu list based on Alex's suggestion;
>>   - Applied relaxed write/read to LPC driver;
>>   - Some bugs fixing and some optimazations based on the comments of V6;
>>
>> Changes from V5:
>>   - Made the extio driver more generic and locate in lib/;
>>   - Supported multiple indirect-IO bus instances;
>>   - Extended the pci_register_io_range() to support indirect-IO, then dropped
>>   the I/O reservation used in previous patchset;
>>   - Reimplemented the ACPI LPC support;
>>   - Fixed some bugs, including the compile error on other archs, the module
>>   building failure found by Ming Lei, etc;
>>
>> Changes from V4:
>>   - Some revises based on the comments from Bjorn, Rob on V4;
>>   - Fixed the compile error on some platforms, such as openrisc;
>>
>> Changes from V3:
>>   - UART support deferred to a separate patchset; This patchset only support
>>   ipmi device under LPC;
>>   - LPC bus I/O range is fixed to 0 ~ (PCIBIOS_MIN_IO - 1), which is separeted
>>   from PCI/PCIE PIO space;
>>   - Based on Arnd's remarks, removed the ranges property from Hip06 lpc dts and
>>   added a new fixup function, of_isa_indirect_io(), to get the I/O address
>>   directly from LPC dts configurations;
>>   - Support in(w,l)/out(w,l) for Hip06 lpc I/O;
>>   - Decouple the header file dependency on the gerenic io.h by defining in/out
>>   as normal functions in c file;
>>   - removed unused macro definitions in the LPC driver;
>>
>> Changes from V2:
>>   - Support the PIO retrieval from the linux PIO generated by
>>   pci_address_to_pio. This method replace the 4K PIO reservation in V2;
>>   - Support the flat-tree earlycon;
>>   - Some revises based on Arnd's remarks;
>>   - Make sure the linux PIO range allocated to Hip06 LPC peripherals starts
>>   from non-ZERO;
>>
>> Changes from V1:
>>   - Support the ACPI LPC device;
>>   - Optimize the dts LPC driver in ISA compatible mode;
>>   - Reserve the IO range below 4K in avoid the possible conflict with PCI host
>>   IO ranges;
>>   - Support the LPC uart and relevant earlycon;
>>
>> V7 thread here: https://lkml.org/lkml/2017/3/12/279
>> v6 thread here: https://lkml.org/lkml/2017/1/24/25
>> v5 thread here: https://lkml.org/lkml/2016/11/7/955
>> v4 thread here: https://lkml.org/lkml/2016/10/20/149
>> v3 thread here: https://lkml.org/lkml/2016/9/14/326
>> v2 thread here: https://lkml.org/lkml/2016/9/7/356
>> v1 thread here: https://lkml.org/lkml/2015/12/29/154
>>
>>
>> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
>> zhichang.yuan (6):
>>   LIBIO: Introduce a generic PIO mapping method
>>   PCI: Apply the new generic I/O management on PCI IO hosts
>>   OF: Add missing I/O range exception for indirect-IO devices
>>   LPC: Support the device-tree LPC host on Hip06/Hip07
>>   ACPI: Support the probing on the devices which apply indirect-IO
>>   LPC: Add the ACPI LPC support
>>
>>  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
>>  MAINTAINERS                                        |   8 +
>>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |   4 +
>>  arch/arm64/boot/dts/hisilicon/hip06.dtsi           |  14 +
>>  arch/arm64/boot/dts/hisilicon/hip07-d05.dts        |   4 +
>>  arch/arm64/boot/dts/hisilicon/hip07.dtsi           |  14 +
>>  drivers/acpi/Makefile                              |   1 +
>>  drivers/acpi/acpi_indirectio.c                     | 344 +++++++++++++
>>  drivers/acpi/internal.h                            |   5 +
>>  drivers/acpi/pci_root.c                            |   8 +-
>>  drivers/acpi/scan.c                                |   1 +
>>  drivers/bus/Kconfig                                |   9 +
>>  drivers/bus/Makefile                               |   1 +
>>  drivers/bus/hisi_lpc.c                             | 547 +++++++++++++++++++++
>>  drivers/of/address.c                               |  95 +++-
>>  drivers/pci/pci.c                                  | 104 +---
>>  include/asm-generic/io.h                           |  50 ++
>>  include/linux/logic_pio.h                          | 174 +++++++
>>  include/linux/pci.h                                |   3 +-
>>  lib/Kconfig                                        |  26 +
>>  lib/Makefile                                       |   2 +
>>  lib/logic_pio.c                                    | 413 ++++++++++++++++
>>  22 files changed, 1758 insertions(+), 102 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>  create mode 100644 drivers/acpi/acpi_indirectio.c
>>  create mode 100644 drivers/bus/hisi_lpc.c
>>  create mode 100644 include/linux/logic_pio.h
>>  create mode 100644 lib/logic_pio.c
> 
> Booted up on a D05, was able to use the LPC-connected IPMI interface.
> 
> Tested-by: dann frazier <dann.frazier@canonical.com>
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
