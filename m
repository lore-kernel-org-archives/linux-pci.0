Received: from mail-m4920.qiye.163.com (mail-m4920.qiye.163.com [45.254.49.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD73371CE3
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017495; cv=none; b=QfYBpCzVlJrV4yZt4rpqMdL4MeaxtGPjS0XBBYyIFnLeBA57XrcALDN/3DwapRrt5aPjNlPupHszGXpnXysqUR7BUwzS6AD5Sif+62HRPd+l7KWExfPwueWCns+RcGnhG4+3D7ZOERXq/BIfnTVqYa0RHRg3YZiVPrWYLw6jlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017495; c=relaxed/simple;
	bh=w0tT0pMAY8FDQMQ1E+O97sxqFcjrhFbKyuBgF0aq6p8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=O+ZIRnBuF9clKCrQKJtJTGCGJIubcLz5u3mtTIG+jvF7985sLuZIoeaXyZ17Z57jADyKgm5xuLnXuoekEZEluCRodviZ+e3KKSt67Qap8UcL4ORlTuyOH/FNKq2J9ClmoLvl1Lo3w+FkKL45Wic/8BIjdUwUZ4xwU4F76KVyPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JX7E3fPz; arc=none smtp.client-ip=45.254.49.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JX7E3fPz"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c02051d1;
	Fri, 24 Apr 2026 15:57:59 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 0/7] Add Devres managed IRQ vectors allocation
Date: Fri, 24 Apr 2026 15:57:33 +0800
Message-Id: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9dbe7ede8309cckunm66d640875e979
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEsYVklOTUNJGE9OTBlKQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	JDQ0xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=JX7E3fPzkzFo8a5zAYfFpqHqsYfgHTufD2IZmiMJVskJS6I7n60Z4Z+RUzamp+QsgYuykYMF1me4Z9ptFjQVafuLIEWTojVkvSo6vssGK0/Yi96/sRdC/TX8t7cisM5ttDwvQYiqrVnHjC8m3IjIK0lDb5Gn3BbCJ+4i9WOIvK4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=rMZ5mT8wR5QKhYbHC9DsNc+Q+jnAnsA8E3Uw38Fc1Pc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>


There is a long-standing design ambiguity in the PCI/MSI subsystem regarding
the management of IRQ vectors. Currently, the management operates in a "hybrid"
mode. Sometimes it's handled by devres but sometimes not, creating potential
for resource management bugs.

Historically, pcim_enable_device() implicitly triggers automatic IRQ vector
management when calling pci_alloc_irq_vectors[_affinity], as pcim_enable_device()
sets the is_managed flag, thus pcim_msi_release() will register a cleanup action.
However, using pci_enable_device() will not make pci_alloc_irq_vectors[_affinity]
register a cleanup action.

This creates an ambiguous ownership model. Many drivers follow a pattern of:
1. Calling pci_alloc_irq_vectors() to allocate interrupts.
2. Also calling pci_free_irq_vectors() in their error paths or remove routines.

When such a driver also uses pcim_enable_device(), the devres framework may
attempt to free the IRQ vectors a second time upon device release, leading to
a double-free. Analysis of the tree shows this hazardous pattern exists widely,
while 37 other drivers correctly rely solely on the implicit cleanup.

To identify the scope of this issue, I used the following shell commands to
search for drivers using pcim_enable_device and allocation functions but missing
the explicit free call:

grep -rl "pcim_enable_device" drivers/ \
  | xargs grep -l -E "pci_alloc_irq_vectors|pci_alloc_irq_vectors_affinity" 2>/dev/null \
  | xargs grep -L "pci_free_irq_vectors" 2>/dev/null

drivers/dma/hsu/pci.c
drivers/dma/hisi_dma.c
drivers/hid/intel-thc-hidintel-quicki2c/pci-quicki2c.
drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
drivers/hid/intel-ish-hid/ipc/pci-ish.c
drivers/accel/ivpu/ivpu_drv.c
drivers/accel/qaic/qaic_drv.c
drivers/accel/amdxdna/aie2_pci.c
drivers/platform/x86/intel/ehl_pse_io.c
drivers/media/pci/intel/ipu6/ipu6.c
drivers/mfd/intel-lpss-pci.c
drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
drivers/crypto/inside-secure/safexcel.c
drivers/thunderbolt/nhi.c
drivers/i2c/busses/i2c-mchp-pci1xxxx.c
drivers/i2c/busses/i2c-amd-mp2-pci.c
drivers/i2c/busses/i2c-thunderx-pcidrv.c
drivers/i2c/busses/i2c-designware-pcidrv.c
drivers/tty/serial/8250/8250_exar.c
drivers/tty/serial/8250/8250_pci.c
drivers/tty/serial/8250/8250_mid.c
drivers/gpio/gpio-merrifield.c
drivers/iommu/riscv/iommu-pci.c
drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
drivers/pci/switch/switchtec.c
drivers/pci/controller/vmd.c
drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
drivers/net/ethernet/cavium/thunder/thunder_bgx.c
drivers/net/ethernet/realtek/r8169_main.c
drivers/mmc/host/cavium-thunderx.c
drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
drivers/cxl/pci.c
drivers/spi/spi-pxa2xx-pci.c
drivers/spi/spi-pci1xxxx.c

To count how many drivers, including using lagacy APIs, have the double-free bugs, the
following shell commands find out 60 drivers.
grep -rl "pcim_enable_device" drivers/ --include="*.c" \
  | xargs grep -l -E "pci_alloc_irq_vectors|pci_alloc_irq_vectors_affinity" 2>/dev/null \
  | xargs grep -l "pci_free_irq_vectors" 2>/dev/null \
  | tee /dev/tty \
  | wc -l

drivers/dma/dw-edma/dw-edma-pcie.c
drivers/dma/plx_dma.c
drivers/dma/amd/ae4dma/ae4dma-pci.c
drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
drivers/perf/hisilicon/hisi_pcie_pmu.c
drivers/perf/hisilicon/hns3_pmu.c
drivers/platform/x86/intel_ips.c
....
drivers/hwtracing/intel_th/pci.c
drivers/bus/mhi/host/pci_generic.c
drivers/fpga/dfl-pci.c
51

grep -rl "pcim_enable_device" drivers/ --include="*.c" \
  | xargs grep -l -E "pci_enable_msi|pci_enable_msix" 2>/dev/null \
  | xargs grep -l "pci_disable_msi" 2>/dev/null \
  | tee /dev/tty \
  | wc -l

drivers/dma/ioat/init.c
drivers/dma/amd/ptdma/ptdma-pci.c
drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
drivers/crypto/ccp/sp-pci.c
drivers/i2c/busses/i2c-ismt.c
drivers/pci/msi/api.c
drivers/misc/mei/pci-me.c
drivers/misc/mei/pci-txe.c
drivers/block/mtip32xx/mtip32xx.c
9

This series introduces new managed APIs: pcim_alloc_irq_vectors() and
pcim_alloc_irq_vectors_affinity(). Drivers that wish to have devres-managed IRQ
vectors should use these functions to ensure proper automatic cleanup without
ambiguity.

Regarding the removal strategy discussed in v3 [1], two approaches were considered:
a) Introducing another hybrid function temporarily.
b) Duplicating code temporarily.

Following the discussion with Philipp, I agree that adding another hybrid function
does not guarantee the completion of the final cleanup work. Therefore, starting
from v4, I have chosen to duplicate the necessary code temporarily. Helper functions
have been factored out to minimize code duplication.

In the short term, the series converts two drivers within the PCI subsystem to
use the new APIs. The long-term goal is to convert all other drivers which wish to
use these managed functions. For the legacy APIs, like pci_enable_msix_range_*() and
pci_enable_msi(), we won't consider to provide devres-managed version for them but to
fix the only 9 double-free drivers by using the new APIs provided by this series. And
once ready, we could remove the problematic hybrid management pattern from
pcim_setup_msi_release() entirely.

[1]: https://lore.kernel.org/linux-pci/9dc66010d61670dc5182062ef5f1a932f7374323.camel@mailbox.org/T/#t


Changes in v4:
- Rework to create dedicated devres-managed function (Philipp)

Changes in v3:
- Rework the commit message and function doc (Philipp)
- Remove setting is_msi_managed flag from new APIs (Philipp)

Changes in v2:
- Rebase
- Introduce patches only for PCI subsystem to convert the API

Shawn Lin (7):
  PCI/MSI: Split __pci_enable_msi_range() for reuse
  PCI/MSI: Split __pci_enable_msix_range() for reuse
  PCI/MSI: Introduce __pcim_enable_msi_range()
  PCI/MSI: Introduce __pcim_enable_msix_range()
  PCI/MSI: Add Devres managed IRQ vectors allocation
  PCI: switchtec: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  PCI: vmd: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()

 drivers/pci/controller/vmd.c   |   4 +-
 drivers/pci/msi/api.c          |  84 +++++++++++++++++++++++++++++++
 drivers/pci/msi/msi.c          | 110 +++++++++++++++++++++++++++++++++++------
 drivers/pci/msi/msi.h          |   3 ++
 drivers/pci/switch/switchtec.c |   6 +--
 include/linux/pci.h            |  22 +++++++++
 6 files changed, 210 insertions(+), 19 deletions(-)

-- 
2.7.4

