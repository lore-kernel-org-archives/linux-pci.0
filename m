Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/20] ARM64: implement pci_remap_cfgspace() interface
Date: Mon, 27 Feb 2017 15:14:15 +0000
Message-Id: <20170227151436.18698-5-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 linux-arch@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
and Posting") defines rules for PCI configuration space transactions
ordering and posting, that state that configuration writes
are non-posted transactions.

This rule is reinforced by the ARM v8 architecture reference manual
(issue A.k, Early Write Acknowledgment) that explicitly recommends
that No Early Write Acknowledgment attribute should be used to map
PCI configuration (write) transactions.

Current ioremap interface on ARM64 implements mapping functions
where the Early Write Acknowledgment hint is enabled, so they
cannot be used to map PCI configuration space in a PCI specs
compliant way.

Implement an ARM64 specific pci_remap_cfgspace() interface
that allows to map PCI config region with nGnRnE attributes, providing
a remap function that complies with PCI specifications and the ARMv8
architecture reference manual recommendations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/io.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 0c00c87..7a03250 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -173,6 +173,16 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iounmap				__iounmap
 
 /*
+ * PCI configuration space mapping function.
+ *
+ * PCI specifications disallows posted write configuration transactions.
+ * Add an arch specific pci_remap_cfgspace definition that is implemented
+ * through nGnRnE device memory attribute as recommended by the ARM v8
+ * Architecture reference manual Issue A.k B2.8.2 "Device memory".
+ */
+#define pci_remap_cfgspace(addr, size) __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
+
+/*
  * io{read,write}{16,32,64}be() macros
  */
 #define ioread16be(p)		({ __u16 __v = be16_to_cpu((__force __be16)__raw_readw(p)); __iormb(); __v; })
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
