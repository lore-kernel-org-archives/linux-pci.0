Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH v3 5/8] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for MIPS
Date: Tue, 14 Nov 2017 17:12:09 -0500
Message-Id: <1510697532-32828-6-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-mips@linux-mips.org, linux-pci@vger.kernel.org,
 Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
 Jim Quinlan <jim2101024@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add MIPS as an arch that supports PCI_MSI_IRQ_DOMAIN and add
generation of msi.h in the MIPS arch.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/include/asm/Kbuild | 1 +
 drivers/pci/Kconfig          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7c8aab2..8c78ba7 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index c32a77f..927c335 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -25,7 +25,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86
+	def_bool ARC || ARM || ARM64 || MIPS || X86
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
1.9.0.138.g2de3478


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
