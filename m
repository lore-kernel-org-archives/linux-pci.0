Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI/AER: Use a common function to print AER error bits
Date: Mon, 30 Apr 2018 14:52:15 -0500
Message-Id: <20180430195218.27654-1-mr.nuke.me@gmail.com>
In-Reply-To: <20180417170943.1767-1-mr.nuke.me@gmail.com>
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On errors reported from CPER, cper_print_bits() was used to log the
AER bits. This resulted in hard-to-understand messages, without a
prefix. Instead use __aer_print_error() for both native AER and CPER
to provide a more consistent log format.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

Changes since v1:
  - Parse aer regs for first error pointer instead of disabling it
On the Dell machine where I tested this, the first error pointer is
reported correctly by firmware.

 drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index cfc89dd57831..b5612cc51b63 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -216,28 +216,30 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer)
 {
-	int layer, agent, status_strs_size, tlp_header_valid = 0;
+	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
-	const char **status_strs;
+	struct aer_err_info info;
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
-		status_strs = aer_correctable_error_string;
-		status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
-		status_strs = aer_uncorrectable_error_string;
-		status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
 	}
 
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
+	memset(&info, 0, sizeof(info));
+	info.severity = aer_severity;
+	info.status = status;
+	info.mask = mask;
+	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	cper_print_bits("", status, status_strs, status_strs_size);
+	__aer_print_error(dev, &info);
 	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
-- 
2.14.3
