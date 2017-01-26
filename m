Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org,
	cov@codeaurora.org
Subject: [PATCH] PCI/ASPM: reconfigure ASPM following hotplug
Date: Thu, 26 Jan 2017 17:51:32 -0500
Message-Id: <1485471092-16906-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When the operating system is booted with the default ASPM policy,
the current code is determining the ASPM policy by querying the
enable/disable states from ASPM registers.

In the case of hotplug removal, the ASPM registers get cleared by
calling the exit function.

An insertion following remove reads incorrect policy as disabled
even though ASPM was enabled during boot.

Adding a flag to the struct pci_dev and saving the power up policy
in the bridge to be reused during hotplug insertion. Bridge's enable
counter is used as a switch to determine when to use saved value.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 13 ++++++++++---
 include/linux/pci.h     |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 17ac1dc..32b8a86 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -338,7 +338,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
+static
+void pcie_aspm_cap_init(struct pci_dev *pdev, struct pcie_link_state *link,
+			int blacklist)
 {
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
@@ -398,7 +400,12 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
 
 	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
+	if (!atomic_read(&pdev->enable_cnt)) {
+		link->aspm_default = link->aspm_enabled;
+		pdev->aspm_default = link->aspm_default;
+	} else {
+		link->aspm_default = pdev->aspm_default;
+	}
 
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
@@ -599,7 +606,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	 * upstream links also because capable state of them can be
 	 * update through pcie_aspm_cap_init().
 	 */
-	pcie_aspm_cap_init(link, blacklist);
+	pcie_aspm_cap_init(pdev, link, blacklist);
 
 	/* Setup initial Clock PM state */
 	pcie_clkpm_cap_init(link, blacklist);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..d0ecde6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -316,6 +316,7 @@ struct pci_dev {
 	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
 						      controlled exclusively by
 						      user sysfs */
+	unsigned int	aspm_default;	/* aspm policy set by BIOS */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
