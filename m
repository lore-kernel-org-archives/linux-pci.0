Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PCI: thunder-pem: Add support for cn81xx and cn83xx SoCs.
Date: Wed, 11 Jan 2017 11:22:11 -0800
Message-Id: <20170111192211.29049-1-ddaney.cavm@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David Daney <david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The pci-thunder-pem driver was initially developed for cn88xx SoCs.
The cn81xx and cn83xx members of the same family of SoCs has a
slightly different configuration of interrupt resources in the PEM
hardware, which prevents the INTA legacy interrupt source from
functioning with the current driver.

There are two fixes required:

1) Don't fixup the PME interrupt on the newer SoCs as it already has
the proper value.

2) Report MSI-X Capability Table Size of 2 for the newer SoCs, so the
core MSI-X code doesn't inadvertently clobber the INTA machinery that
happens to reside immediately following the table.

Signed-off-by: David Daney <david.daney@cavium.com>
---

Changes from v1: Fixed comment typo.

 drivers/pci/host/pci-thunder-pem.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index af722eb..52b5bdc 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -36,7 +36,7 @@ struct thunder_pem_pci {
 static int thunder_pem_bridge_read(struct pci_bus *bus, unsigned int devfn,
 				   int where, int size, u32 *val)
 {
-	u64 read_val;
+	u64 read_val, tmp_val;
 	struct pci_config_window *cfg = bus->sysdata;
 	struct thunder_pem_pci *pem_pci = (struct thunder_pem_pci *)cfg->priv;
 
@@ -65,13 +65,28 @@ static int thunder_pem_bridge_read(struct pci_bus *bus, unsigned int devfn,
 		read_val |= 0x00007000; /* Skip MSI CAP */
 		break;
 	case 0x70: /* Express Cap */
-		/* PME interrupt on vector 2*/
-		read_val |= (2u << 25);
+		/*
+		 * Change PME interrupt to vector 2 on T88 where it
+		 * reads as 0, else leave it alone.
+		 */
+		if (!(read_val & (0x1f << 25)))
+			read_val |= (2u << 25);
 		break;
 	case 0xb0: /* MSI-X Cap */
-		/* TableSize=4, Next Cap is EA */
+		/* TableSize=2 or 4, Next Cap is EA */
 		read_val &= 0xc00000ff;
-		read_val |= 0x0003bc00;
+		/*
+		 * If Express Cap(0x70) raw PME vector reads as 0 we are on
+		 * T88 and TableSize is reported as 4, else TableSize
+		 * is 2.
+		 */
+		writeq(0x70, pem_pci->pem_reg_base + PEM_CFG_RD);
+		tmp_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
+		tmp_val >>= 32;
+		if (!(tmp_val & (0x1f << 25)))
+			read_val |= 0x0003bc00;
+		else
+			read_val |= 0x0001bc00;
 		break;
 	case 0xb4:
 		/* Table offset=0, BIR=0 */
-- 
2.9.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
