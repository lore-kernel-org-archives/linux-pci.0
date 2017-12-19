Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
To: joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
 lorenzo.pieralisi@arm.com, bhelgaas@google.com
Subject: [PATCH V1 0/1] Fix kernel panic caused by device ID duplication
 presented to the IOMMU
Date: Tue, 19 Dec 2017 16:13:55 +0100
Message-Id: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jayachandran.Nair@cavium.com,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ganapatrao.Kulkarni@cavium.com, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Here is my lspci output of ThunderX2 for which I am observing kernel panic coming from
SMMUv3 driver -> arm_smmu_write_strtab_ent() -> BUG_ON(ste_live):

# lspci -vt
-[0000:00]-+-00.0-[01-1f]--+ [...]
                           + [...]
                           \-00.0-[1e-1f]----00.0-[1f]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family

ASP device -> 1f:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family
PCI-Express to PCI/PCI-X Bridge -> 1e:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
                           
While setting up ASP device SID in IORT dirver:
iort_iommu_configure() -> pci_for_each_dma_alias()
we need to walk up and iterate over each device which alias transaction from
downstream devices.

AST device (1f:00.0) gets BDF=0x1f00 and corresponding SID=0x1f00 from IORT.
Bridge (1e:00.0) is the first alias. Following PCI Express to PCI/PCI-X Bridge
spec: PCIe-to-PCI/X bridges alias transactions from downstream devices using
the subordinate bus number. For bridge (1e:00.0), the subordinate is equal
to 0x1f. This gives BDF=0x1f00 and SID=1f00 which is the same as downstream
device. So it is possible to have two identical SIDs. The question is what we
should do about such case. Presented patch prevents from registering the same
ID so that SMMUv3 is not complaining later on.

Tomasz Nowicki (1):
  iommu: Make sure device's ID array elements are unique

 drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
