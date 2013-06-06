Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Betty Dall <betty.dall@hp.com>
To: rjw@sisk.pl, bhelgaas@google.com, gong.chen@linux.intel.com,
	greg.pearson@hp.com
Cc: ying.huang@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Betty Dall <betty.dall@hp.com>
Subject: [PATCH v3 5/6] ACPI/APEI: Force fatal AER severity when bus has been reset
Date: Thu,  6 Jun 2013 12:10:50 -0600
Message-Id: <1370542251-27387-6-git-send-email-betty.dall@hp.com>
In-Reply-To: <1370542251-27387-1-git-send-email-betty.dall@hp.com>
References: <1370542251-27387-1-git-send-email-betty.dall@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The CPER error record has a reset bit that indicates that the platform
has reset the bus. The reset bit can be set for any severity error
including recoverable.  From the AER code path's perspective,
any error is fatal if the bus has been reset. This patch upgrades the
severity of the AER recovery to AER_FATAL whenever the CPER error record
indicates that the bus has been reset.

Changes since v1:
Fixed a typo in comment.

Changes since v2:
Set the aer_severity to AER_FATAL rather than using cper_severity_to_aer().
Simplified the comment.

Signed-off-by: Betty Dall <betty.dall@hp.com>
---

 drivers/acpi/apei/ghes.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)


diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d668a8a..ab31551 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -449,9 +449,19 @@ static void ghes_do_proc(struct ghes *ghes,
 			    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
 				unsigned int devfn;
 				int aer_severity;
+
 				devfn = PCI_DEVFN(pcie_err->device_id.device,
 						  pcie_err->device_id.function);
 				aer_severity = cper_severity_to_aer(sev);
+
+				/*
+				 * If firmware reset the component to contain
+				 * the error, we must reinitialize it before
+				 * use, so treat it as a fatal AER error.
+				 */
+				if (gdata->flags & CPER_SEC_RESET)
+					aer_severity = AER_FATAL;
+
 				aer_recover_queue(pcie_err->device_id.segment,
 						  pcie_err->device_id.bus,
 						  devfn, aer_severity);
