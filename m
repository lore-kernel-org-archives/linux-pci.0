Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Wed,  8 Mar 2017 15:39:11 -0500
Message-Id: <1489005551-23598-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Mayurkumar Patel <mayurkumar.patel@intel.com>,
 open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When the operating system is booted with the default ASPM policy
(POLICY_DEFAULT), current code is querying the enable/disable
states from ASPM registers to determine the policy.

For example, a BIOS could set the power saving state to performance
and clear all ASPM control registers. A balanced ASPM policy could
enable L0s and disable L1. A power conscious BIOS could enable both
L0s and L1 to trade off latency and performance vs. power.

After hotplug removal, pcie_aspm_exit_link_state() function clears
the ASPM registers. An insertion following hotplug removal reads
incorrect policy as ASPM disabled even though ASPM was enabled
during boot.

This is caused by the fact that same function is used for reconfiguring
ASPM regardless of the of the power on state.

This patch builds some state info into pcie_aspm_cap_init() function.

Adding a flag and a counter to the struct pci_dev to save the
power up policy in the bridge during boot. ASPM enable counter is
used as a switch to determine when to use saved value.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
---
 drivers/pci/pcie/aspm.c | 21 +++++++++++++++++----
 include/linux/pci.h     |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 17ac1dc..63435b0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -338,8 +338,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
+static void pcie_aspm_cap_init(struct pci_dev *pdev, int blacklist)
 {
+	struct pcie_link_state *link = pdev->link_state;
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	struct aspm_register_info upreg, dwreg;
@@ -397,8 +398,20 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
 	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
+	/*
+	 * Save default state from FW when enabling ASPM for the first time
+	 * during boot by looking at the calculated link->aspm_enabled bits
+	 * above and aspm_enable_cnt will be zero.
+	 *
+	 * If this path is getting called for the second/third time
+	 * (aspm_enable_cnt will be non-zero). Assume that the current state
+	 * of the ASPM registers may not necessarily match what FW asked us to
+	 * do as in the case of hotplug insertion/removal.
+	 */
+	if (atomic_inc_return(&pdev->aspm_enable_cnt) == 1)
+		pdev->aspm_default = link->aspm_default = link->aspm_enabled;
+	else
+		link->aspm_default = pdev->aspm_default;
 
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
@@ -599,7 +612,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	 * upstream links also because capable state of them can be
 	 * update through pcie_aspm_cap_init().
 	 */
-	pcie_aspm_cap_init(link, blacklist);
+	pcie_aspm_cap_init(pdev, blacklist);
 
 	/* Setup initial Clock PM state */
 	pcie_clkpm_cap_init(link, blacklist);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..aa7bd7e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -321,6 +321,8 @@ struct pci_dev {
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
+	unsigned int	aspm_default;		/* ASPM policy set by BIOS */
+	atomic_t	aspm_enable_cnt;	/* ASPM policy initialization */
 #endif
 
 	pci_channel_state_t error_state;	/* current connectivity state */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
