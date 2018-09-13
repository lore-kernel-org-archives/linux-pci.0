Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Andrew Murray <andrew.murray@arm.com>
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 yuanzhichang@hisilicon.com, dann.frazier@canonical.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, andy.shevchenko@gmail.com
Subject: [PATCH] asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP
 && CONFIG_INDIRECT_PIO
Date: Thu, 13 Sep 2018 13:48:27 +0100
Message-Id: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: jean-philippe.brucker@arm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 suzuki.poulose@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
prevent users from making I/O accesses outside the expected I/O range -
however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
contradictory to its other users.

The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
mangling the given port rather than capping it.

We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
implementation of ioport_map by using the comparison operator and
returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
we don't break existing buggy drivers that somehow rely on this masking.

Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/asm-generic/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 66d1d45..d356f80 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1026,7 +1026,8 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
 #define ioport_map ioport_map
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
+	port &= IO_SPACE_LIMIT;
+	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
 }
 #endif
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
