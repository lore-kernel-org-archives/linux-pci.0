Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH] PCI/ASPM: Suppress common clock mode setting failure
Date: Mon, 22 Jan 2018 12:28:00 -0500
Message-Id: <1516642093-15633-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rajat Jain <rajatja@google.com>,
 Yinghai Lu <yinghai@kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Code is emitting warnings when it tries to set the common clock mode for
ASPM and ASPM is already configured to common clock mode by the UEFI BIOS.
Let's bail out silently in such a case.

pci 0004:00:00.0: ASPM: Could not configure common clock

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9783e10..072178a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -253,6 +253,11 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Configure upstream component */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+
+	/* Port might be already in common clock mode */
+	if ((same_clock) && (reg16 & PCI_EXP_LNKCTL_CCC))
+		return;
+
 	parent_reg = reg16;
 	if (same_clock)
 		reg16 |= PCI_EXP_LNKCTL_CCC;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
