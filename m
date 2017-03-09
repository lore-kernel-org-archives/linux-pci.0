Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH v3 0/7] PCI: dwc: Miscellaneous fixes and cleanups
Date: Thu, 9 Mar 2017 12:08:58 +0530
Message-ID: <1489041545-15730-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: nsekhar@ti.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Resending since it bounced from quite a few lists.

This should be the final set of cleanups/fixes before endpoint
support can be merged.

Keerthy's patch is a general fix in dra7xx driver and is not
directly related to endpoint mode.

This v1 of this series was previously sent with a different
cover letter $subject [1]

Changes from v2:
*) Kconfig changes that was spilled into a patch is removed.
*) In addition to renaming _unroll() to _ob_unroll(), all the
   _unroll configurations is also moved a separate function.

Changes from v1:
*) included a patch to rename _unroll() to _ob_unroll() as
   similar thing has to be done for inbound window in the case
   of EP mode.
*) used 'size_t' instead of 'int' for specifying the size
   in read_dbi/write_dbi function arguments.
*) Populate cpu_addr_fixup ops for artpec6 as suggested by
   Niklas

This series is based on 4.11-rc1

[1] -> https://lkml.org/lkml/2017/2/16/270

Keerthy (1):
  PCI: dwc: dra7xx: Push request_irq call to the bottom of probe

Kishon Vijay Abraham I (6):
  PCI: dwc: designware: Add new *ops* for cpu addr fixup
  PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
  PCI: dwc: artpec6: Populate cpu_addr_fixup ops
  PCI: dwc: all: Modify dbi accessors to take dbi_base as argument
  PCI: dwc: all: Modify dbi accessors to access data of 4/2/1  bytes
  PCI: dwc: designware: Move _unroll configurations to a separate
    function

 drivers/pci/dwc/pci-dra7xx.c           |   35 +++----
 drivers/pci/dwc/pci-exynos.c           |   14 +--
 drivers/pci/dwc/pci-imx6.c             |   62 +++++++------
 drivers/pci/dwc/pci-keystone-dw.c      |   16 ++--
 drivers/pci/dwc/pcie-armada8k.c        |   39 ++++----
 drivers/pci/dwc/pcie-artpec6.c         |   22 +++--
 drivers/pci/dwc/pcie-designware-host.c |   20 ++--
 drivers/pci/dwc/pcie-designware.c      |  156 +++++++++++++++++++++-----------
 drivers/pci/dwc/pcie-designware.h      |   13 ++-
 drivers/pci/dwc/pcie-hisi.c            |   17 ++--
 10 files changed, 241 insertions(+), 153 deletions(-)

-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
