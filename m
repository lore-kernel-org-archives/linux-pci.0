Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH v1] iov: add return failure condition for pci_setup_device
Date: Mon, 29 Aug 2016 15:28:01 +0800
Message-ID: <1472455681-18827-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Po Liu <po.liu@nxp.com>, Stuart Yoder <stuart.yoder@nxp.com>,
 Yang-Leo Li <leoyang.li@nxp.com>, linux-arm-kernel@lists.infradead.org, Bjorn
 Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

If pci_setup_device() return failure, return failure directly in the
pci_iov_add_virtfn().

Signed-off-by: Po Liu <po.liu@nxp.com>
---
 drivers/pci/iov.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2194b44..e30f05c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -136,7 +136,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
-	pci_setup_device(virtfn);
+	rc = pci_setup_device(virtfn);
+	if (rc)
+		goto failed0;
+
 	virtfn->dev.parent = dev->dev.parent;
 	virtfn->physfn = pci_dev_get(dev);
 	virtfn->is_virtfn = 1;
-- 
2.1.0.27.g96db324


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
