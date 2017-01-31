Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH 1 0/4] PCI: Use of_device_get_match_data() to simplify probe
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Tue, 31 Jan 2017 14:19:51 -0600
Message-ID: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Roy Zang <tie-fei.zang@freescale.com>, linux-renesas-soc@vger.kernel.org,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Shailendra Verma <shailendra.v@samsung.com>,
 bcm-kernel-feedback-list@broadcom.com, Mingkai Hu <mingkai.hu@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This turned into much ado about nothing, but Shailendra's hisi patch
prompted similar cleanups in other drivers.  It's a minor simplification,
but I think worth doing consistently across drivers.

Basically this is Geert's observation that when the driver probe function
is called only as a result of matching something in <match_table>, a
subsequent of_match_device(<match_table>, dev) call should never fail.

Therefore, instead of this:

  struct of_device_id *match;

  match = of_match_device(<match_table>, dev);
  ... = match->data;

we can do this:

  ... = of_device_get_match_data(dev);

---

Bjorn Helgaas (3):
      PCI: iproc: Use of_device_get_match_data() to simplify probe
      PCI: layerscape: Use of_device_get_match_data() to simplify probe
      PCI: rcar: Use of_device_get_match_data() to simplify probe

Shailendra Verma (1):
      PCI: hisi: Use of_device_get_match_data() to simplify probe


 drivers/pci/host/pci-layerscape.c      |    7 +------
 drivers/pci/host/pcie-hisi.c           |    8 +++-----
 drivers/pci/host/pcie-iproc-platform.c |    7 +------
 drivers/pci/host/pcie-rcar.c           |    7 +------
 4 files changed, 6 insertions(+), 23 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
