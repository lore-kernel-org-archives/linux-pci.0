Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56660512.1000808@broadcom.com>
Date: Mon, 7 Dec 2015 14:15:46 -0800
From: Florian Fainelli <fainelli@broadcom.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
CC: Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Marc Zyngier" <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Hauke Mehrtens" <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] Add iProc PCIe PAXC and MSI support
References: <1449250502-10679-1-git-send-email-rjui@broadcom.com> <20151207170122.GI7994@localhost> <5665ECC3.9040808@gmail.com> <20151207213339.GC14429@localhost>
In-Reply-To: <20151207213339.GC14429@localhost>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/12/15 13:33, Bjorn Helgaas wrote:
> On Mon, Dec 07, 2015 at 12:32:03PM -0800, Florian Fainelli wrote:
>> On 07/12/15 09:01, Bjorn Helgaas wrote:
>>> On Fri, Dec 04, 2015 at 09:34:57AM -0800, Ray Jui wrote:
>>>> This patch series adds support for the iProc PAXC interface and support for
>>>> event queue based MSI, integrated in the iProc PCIe core
>>>>
>>>> This patch series is based on Linux v4.4-rc1 and is avaliable here:
>>>> https://github.com/Broadcom/cygnus-linux/tree/iproc-msi-v5
>>>>
>>>> Changes from v4:
>>>> - Make 'iproc_msi_exit' inline to fix compiler warning when CONFIG_PCI_MSI
>>>> is disabled
>>>>
>>>> Changes from v3:
>>>> - Detect the number of possible CPUs instead online CPUs in the driver. Note
>>>> CPU notifier based implementation still needs to be added in the future, for
>>>> proper support of MSI IRQ affinity when CPU is brought online/offline at
>>>> runtime. Support in this dirver will be added when we support CPU hotplug in
>>>> one of iProc family of SoCs so the changes can be tested
>>>> - Use dma_zalloc_coherent for event queue host memory allocation and zeoring
>>>>
>>>> Changes from v2:
>>>> - Improved descriptions in the iProc MSI commit message
>>>> - Removed redundant host memory used for MSI address. The MSI posted writes
>>>> never really hit the memory. Use iProc PCIe controller base address instead
>>>> - Fixed deadlock when MSI vectors are used up
>>>> - Enforced the number of MSI groups to always be multiple of the number of CPUs
>>>> - Improved the efficiency of MSI event processing by only updating the head
>>>> pointer after finishing processing all outstanding events
>>>> - Fixed error handling code to make sure all configurations are rolled back
>>>> - Added code to zero the host memory used for event queues after allocation
>>>> - Removed redundant 'brcm,num-eq-region' and 'brcm,num-msi-msg-region' DT
>>>>   properties. Now determine the number of regions based on interface type
>>>> - Other misc. changes
>>>>
>>>> Changes from v1:
>>>> - Fixed incorrect 1-to-1 mapping between MSI vector and GIC interrupt. Now the
>>>> driver supports multiple MSI vectors per GIC interrupt
>>>> - Added MSI IRQ affinity support by distributing GIC interrupts across
>>>> available CPU cores and dynamically steer MSI vectors to the target CPU
>>>> - replace readl/writel with readl_relaxed/writel_relaxed since all register
>>>> accesses within the iProc MSI driver are to/from the same I/O block, i.e., the
>>>> iProc PCIe core
>>>> - Removed all redundant irq_chip callback assignments
>>>> - Changed to use uncached host memory for both MSI posted writes and event
>>>> queues
>>>> - Add functions to free resources in error/exit cases
>>>> - In pcie-iproc-platform.c, pass in interface type through OF device data
>>>> - Moved define for max number of interrupts from pcie-iproc.h to
>>>> pcie-iproc-msi.c
>>>> - Other misc. changes
>>>>
>>>> Ray Jui (5):
>>>>   PCI: iproc: Update iProc PCIe device tree binding
>>>>   PCI: iproc: Add PAXC interface support
>>>>   PCI: iproc: Add iProc PCIe MSI device tree binding
>>>>   PCI: iproc: Add iProc PCIe MSI support
>>>>   ARM: dts: Enable MSI support for Broadcom Cygnus
>>>>
>>>>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  40 +-
>>>>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |  22 +
>>>>  drivers/pci/host/Kconfig                           |   9 +
>>>>  drivers/pci/host/Makefile                          |   1 +
>>>>  drivers/pci/host/pcie-iproc-bcma.c                 |   1 +
>>>>  drivers/pci/host/pcie-iproc-msi.c                  | 675 +++++++++++++++++++++
>>>>  drivers/pci/host/pcie-iproc-platform.c             |  25 +-
>>>>  drivers/pci/host/pcie-iproc.c                      | 228 +++++--
>>>>  drivers/pci/host/pcie-iproc.h                      |  42 +-
>>>>  9 files changed, 1000 insertions(+), 43 deletions(-)
>>>>  create mode 100644 drivers/pci/host/pcie-iproc-msi.c
>>>
>>> Applied to pci/host-iproc for v4.5, with Marc's reviewed-by on "PCI: iproc:
>>> Add iProc PCIe MSI support".  Thanks!
>>
>> Including the last patch, or should I take this one via arm-soc? Thanks!
> 
> I had unthinkingly applied the last one too, but I dropped it so you
> can pick it up.

Not a problem, I picked it up, thanks!
-- 
Florian
