Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v4 00/15] ACPI IORT ARM SMMU v3 support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 iommu@lists.linux-foundation.org
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <e12c4831-f625-ca39-0f8c-9ff3f8ebaa53@linaro.org>
Date: Mon, 5 Sep 2016 17:41:37 +0800
MIME-Version: 1.0
In-Reply-To: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jon Masters <jcm@redhat.com>,
 Dennis Chen <dennis.chen@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/8/15 23:23, Lorenzo Pieralisi wrote:
> This patch series is v4 of a previous posting:
>
> https://lkml.org/lkml/2016/7/20/248
>
> v3 -> v4
> 	- Added single mapping API (for IORT named components)

Thanks, and it works for my platform msi patch set too :)

> 	- Fixed arm_smmu_iort_xlate() return value
> 	- Reworked fwnode registration and platform device creation
> 	  ordering to fix probe ordering dependencies
> 	- Added code to keep device_node ref count with new iommu
> 	  fwspec API
> 	- Added patch to make iommu_fwspec arch agnostic
> 	- Dropped RFC status
> 	- Rebased against v4.8-rc2
>

[...]
>
> The ACPI IORT table provides information that allows instantiating
> ARM SMMU devices and carrying out id mappings between components on
> ARM based systems (devices, IOMMUs, interrupt controllers).
>
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>
> Building on basic IORT support, available through [2],
> this patchset enables ARM SMMU v3 support on ACPI systems.
>
> Most of the code is aimed at building the required generic ACPI
> infrastructure to create and enable IOMMU components and to bring
> the IOMMU infrastructure for ACPI on par with DT, which is going to
> make future ARM SMMU components easier to integrate.

[...]
>
> This patchset is built on top and depends on these two patch series:
>
> [1] R.Murphy "Generic DT bindings for PCI and ARM SMMU v3" v4
>     https://marc.info/?l=devicetree&m=146739193215518&w=2
>
> [2] T.Nowicki "Introduce ACPI world to ITS irqchip" v8
>     https://marc.info/?l=linux-kernel&m=147091000919640&w=2
>
> and is provided for early review/testing purposes here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/iort-smmu-v4
>
> Tested on FVP models for ARM SMMU v3 probing path.

I tested this patch set on Hisilicon D03 board, with the ehci platform
driver loaded, on D03, ehci is using stream id 0x40080 when SMMU is
enabled, here is the IORT table entries I used:

[0004]                          Signature : "IORT"    [IO Remapping Table]
[0004]                       Table Length : 0000029e
[0001]                           Revision : 00
[0001]                           Checksum : BC
[0006]                             Oem ID : "HISI "
[0008]                       Oem Table ID : "HISI1610"
[0004]                       Oem Revision : 00000000
[0004]                    Asl Compiler ID : "INTL"
[0004]              Asl Compiler Revision : 20151124

[0004]                         Node Count : 00000008
[0004]                        Node Offset : 00000034
[0004]                           Reserved : 00000000
[0004]                   Optional Padding : 00 00 00 00

/* ITS 0, for dsa */
[0001]                               Type : 00
[0002]                             Length : 0018
[0001]                           Revision : 00
[0004]                           Reserved : 00000000
[0004]                      Mapping Count : 00000000
[0004]                     Mapping Offset : 00000000

[0004]                           ItsCount : 00000001
[0004]                        Identifiers : 00000000

/* SMMU PCIE */
[0001]                               Type : 04
[0002]                             Length : 003C
[0001]                           Revision : 00
[0004]                           Reserved : 00000000
[0004]                      Mapping Count : 00000001
[0004]                     Mapping Offset : 0000003C

[0008]                       Base Address : A0040000
[0004]              Flags (decoded below) : 00000001
                           COHACC Override : 1
                             HTTU Override : 0
[0004]                           Reserved : 00000000
[0008]                      VATOS Address : 0
[0004]                              Model : 00000000
[0004]                    Event Interrupt : 00000000
[0004]                      PRI Interrupt : 00000000
[0004]                     GERR Interrupt : 00000000
[0004]                     Sync Interrupt : 00000000

[...]

/* usb named component */
[0001]                               Type : 01
[0002]                             Length : 0046
[0001]                           Revision : 00
[0004]                           Reserved : 00000000
[0004]                      Mapping Count : 00000001
[0004]                     Mapping Offset : 00000032

[0004]                         Node Flags : 00000000
[0008]                  Memory Properties : [IORT Memory Access Properties]
[0004]                    Cache Coherency : 00000000
[0001]              Hints (decoded below) : 00
                                 Transient : 0
                            Write Allocate : 0
                             Read Allocate : 0
                                  Override : 0
[0002]                           Reserved : 0000
[0001]       Memory Flags (decoded below) : 00
                                 Coherency : 0
                          Device Attribute : 0
[0001]                  Memory Size Limit : 00
[0016]                        Device Name : "\_SB_.USB0"
[0004]                            Padding : 00 00 00 00

[0004]                         Input base : 00000000
[0004]                           ID Count : 00000001
[0004]                        Output Base : 00040080
[0004]                   Output Reference : 0000004C /* point to smmu 
pcie */
[0004]              Flags (decoded below) : 00000001
                            Single Mapping : 1

I mounted a USB storage and copy the data (should trigger the DMA :)),
and it works fine (if the wrong stream id is configured, I can't
find the USB storage). So with this patch set:

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

I think I also test Robin's SMMUv3 patchset for supporting no-pci
devices.

Thanks
Hanjun

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
