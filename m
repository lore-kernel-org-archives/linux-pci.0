Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0090.outbound.protection.outlook.com ([207.46.100.90]:26144
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756430AbbHZNzB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 26 Aug 2015 09:55:01 -0400
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH V3 1/4] Honor ACPI _CCA attribute setting
Date: Wed, 26 Aug 2015 20:54:36 +0700
Message-ID: <1440597279-11802-2-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jeremy Linton <jeremy.linton@arm.com>

ACPI configurations can now mark devices as noncoherent,
support that choice.

NOTE: This is required to support USB on ARM Juno Development Board.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Will Deacon <will.deacon@arm.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 include/acpi/acpi_bus.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 83061ca..7ecb8e4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -399,7 +399,7 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
 	 * case 1. Do not support and disable DMA.
 	 * case 2. Support but rely on arch-specific cache maintenance for
 	 *         non-coherence DMA operations.
-	 * Currently, we implement case 1 above.
+	 * Currently, we implement case 2 above.
 	 *
 	 * For the case when _CCA is missing (i.e. cca_seen=0) and
 	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
@@ -407,7 +407,8 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
 	 *
 	 * See acpi_init_coherency() for more info.
 	 */
-	if (adev->flags.coherent_dma) {
+	if (adev->flags.coherent_dma ||
+	    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
 		ret = true;
 		if (coherent)
 			*coherent = adev->flags.coherent_dma;
-- 
2.1.0

