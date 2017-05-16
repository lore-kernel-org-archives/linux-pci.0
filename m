Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: David Daney <david.daney@cavium.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: Avoid bus reset for Cavium cn8xxx root ports.
Date: Mon, 15 May 2017 17:17:36 -0700
Message-Id: <20170516001736.4001-3-david.daney@cavium.com>
In-Reply-To: <20170516001736.4001-1-david.daney@cavium.com>
References: <20170516001736.4001-1-david.daney@cavium.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jon Masters <jcm@redhat.com>, Robert Richter <robert.richter@cavium.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Root ports of cn8xxx do not function after bus reset when used with
some e1000e and LSI HBA devices.  Add a quirk to prevent bus reset on
these root ports.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 085fb78..02cd847 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3347,6 +3347,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
 
+/*
+ * Root port on some Cavium CN8xxx chips do not successfully complete
+ * a bus reset when used with certain types child devices.  Config
+ * space access to the child may quit responding.  Flag the root port
+ * as not supporting bus reset.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
-- 
2.9.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
