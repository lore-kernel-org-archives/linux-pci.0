Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6887C282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 06:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E13821736
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 06:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfAVGp5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:45:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49478 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfAVGp4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jan 2019 01:45:56 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1glpoj-0003zl-0U; Tue, 22 Jan 2019 06:45:49 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, bhelgaas@google.com, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has unreliable ACPI wake
Date:   Tue, 22 Jan 2019 14:45:44 +0800
Message-Id: <20190122064544.27426-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are some e1000e devices can only be woken up from D3 one time, by
plugging ethernet cable. Subsequent cable plugging does set PME bit
correctly, but it still doesn't get woken up.

Since e1000e connects to the root complex directly, we rely on ACPI to
wake it up. In this case, the GPE from _PRW only works once and stops
working after that.

So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
platform firmwares that have unreliable GPE wake.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci-acpi.c | 2 +-
 drivers/pci/quirks.c   | 8 ++++++++
 include/linux/pci.h    | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7efd9c..184e2fc8a294 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -430,7 +430,7 @@ static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
 
 	pci_dev = to_pci_dev(context->dev);
 
-	if (pci_dev->pme_poll)
+	if (pci_dev->pme_poll && !pci_dev->unreliable_acpi_wake)
 		pci_dev->pme_poll = false;
 
 	if (pci_dev->current_state == PCI_D3cold) {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b0a413f3f7ca..ed4863496fa8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4948,6 +4948,14 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 
+static void quirk_unreliable_acpi_wake(struct pci_dev *pdev)
+{
+	pci_info(pdev, "ACPI Wake unreliable, always poll PME\n");
+	pdev->unreliable_acpi_wake = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bb, quirk_unreliable_acpi_wake);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bd, quirk_unreliable_acpi_wake);
+
 /*
  * Some IDT switches incorrectly flag an ACS Source Validation error on
  * completions for config read requests even though PCIe r4.0, sec
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f082..d22065c1576f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -331,6 +331,7 @@ struct pci_dev {
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
+	unsigned int	unreliable_acpi_wake:1;	/* ACPI Wake doesn't always work */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
-- 
2.17.1

