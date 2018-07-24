Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v3 0/3] PCI: NVMe reset quirks
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Date: Tue, 24 Jul 2018 10:14:19 -0600
Message-ID: <20180724160440.2729.75178.stgit@gimli.home>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

v3: Separate quirks, only for the afflicted devices

v2: Add bug link, use Samsung vendor ID, add spec references

Fix two different NVMe device reset issues with device specific
quirks.  The Samsung controller in patch 2 sometimes doesn't like
being reset while enabled, so disable the NVMe controller prior to
FLR.  This quirk is generic to all NVMe class devices, though I've
dropped the additional delay some devices require between disabling
and checking ready status.  This can be added later should any of
those devices need this quirk.  The Intel controller quirk is now
just a simple delay after FLR, which clearly any device needing
similar behavior can also use.  Thanks,

Alex

---

Alex Williamson (3):
      PCI: Export pcie_has_flr()
      PCI: Samsung SM961/PM961 NVMe disable before FLR quirk
      PCI: Intel DC P3700 NVMe delay after FLR quirk


 drivers/pci/pci.c    |    3 +
 drivers/pci/quirks.c |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 
 3 files changed, 108 insertions(+), 1 deletion(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
