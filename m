Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, alex.williamson@redhat.com
Subject: [PATCH V12 5/5] PCI: Warn periodically while waiting for device to
 become ready
Date: Wed, 23 Aug 2017 00:56:11 -0400
Message-Id: <1503464171-6471-5-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
References: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add a print statement in pci_bus_wait_crs() so that user observes the
progress of device polling instead of silently waiting for timeout to be
reached.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
[bhelgaas: check for timeout first so we don't print "waiting, giving up",
always print time we've slept (not the actual timeout, print a "ready"
message if we've printed a "waiting" message]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 93b89dd..4b30df7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1841,11 +1841,16 @@ bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 l, int timeout)
 	 */
 	while ((l & 0xffff) == 0x0001) {
 		if (delay > timeout) {
-			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
-			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
-			       PCI_FUNC(devfn));
+			pr_warn("pci %04x:%02x:%02x.%d: not ready after %dms; giving up\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
+
 			return false;
 		}
+		if (delay >= 1000)
+			pr_info("pci %04x:%02x:%02x.%d: not ready after %dms; waiting\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
 
 		msleep(delay);
 		delay *= 2;
@@ -1854,6 +1859,11 @@ bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 l, int timeout)
 			return false;
 	}
 
+	if (delay >= 1000)
+		pr_info("pci %04x:%02x:%02x.%d: ready after %dms\n",
+			pci_domain_nr(bus), bus->number,
+			PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
+
 	return true;
 }
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
