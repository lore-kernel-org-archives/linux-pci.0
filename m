Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 7 Sep 2018 18:41:40 +0100
From: Will Deacon <will.deacon@arm.com>
To: yuanzhichang@hisilicon.com, dann.frazier@canonical.com,
 gabriele.paoloni@huawei.com, arnd@arndb.de, bhelgaas@google.com,
 andy.shevchenko@gmail.com
Subject: [REGRESSION] Commit 5745392e0c2b ("PCI: Apply the new generic I/O
 management on PCI IO hosts") breaks PCI for legacy virtio devices with
 kvmtool on arm64
Message-ID: <20180907174140.GI12788@arm.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I'm seeing a regression in Linux guests since 4.17 under kvmtool, where
legacy virtio devices using the PCI transport fail to probe. Legacy virtio
PCI devices must be accessed via "I/O space" (e.g. BAR0, which is
IORESOURCE_IO) and kvmtool assigns this to the guest physical range
0x0 - 0x10000.

On arm64, when the virtio legacy PCI driver calls pci_iomap() for this BAR,
it expands to ioport_map():

  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
  {
  	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
  }

Since the indirect PIO changes, MMIO_UPPER_LIMIT is defined as:

  /*
   * We reserve 0x4000 bytes for Indirect IO as so far this library is only
   * used by the HiSilicon LPC Host. If needed, we can reserve a wider IO
   * area by redefining the macro below.
   */
  #define PIO_INDIRECT_SIZE 0x4000
  #define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)

which corrupts the BAR address. For example, kvmtool has the BAR pointing
at 0x6200 on my system, but pci_iomap() actually maps offset 0x2200.
Changing PIO_INDIRECT_SIZE to 0 gets things working again.

Since this stuff doesn't revert nicely, I'm not sure how to proceed. Any
thoughts? Generally, having a per-platform magic constant hardcoded in
the PCI mapping code makes me feel slightly ill...

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
