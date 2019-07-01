Return-Path: <SRS0=J5oN=U6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB94C06510
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jul 2019 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B0B21721
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jul 2019 20:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGAUpR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:45:17 -0400
Received: from xes-mad.com ([162.248.234.2]:4156 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfGAUpR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 16:45:17 -0400
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id 01C5020356;
        Mon,  1 Jul 2019 15:45:16 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v4 1/3] PCI/ACPI: Homogenize _OSC negotiation output
Date:   Mon,  1 Jul 2019 15:45:13 -0500
Message-Id: <20190701204515.23374-2-asierra@xes-inc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701204515.23374-1-asierra@xes-inc.com>
References: <20190213213242.21920-1-git-send-email-asierra@xes-inc.com>
 <20190701204515.23374-1-asierra@xes-inc.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously, the format of messages printed after negotiating _OSC
depended on whether the entire operation was considered to be a success
or failure. Now, printed messages are homogenized to always show what
was requested versus what was granted.

Previous output (success):

  acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]

Previous output (failure):

  acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
  acpi PNP0A08:00: _OSC: platform willing to grant []

New output:

  acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
  acpi PNP0A08:00: _OSC: platform granted [PME AER PCIeCapability LTR]

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/acpi/pci_root.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 0d57f817ef1e..21aa56f9ca54 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -504,8 +504,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
 					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
+	decode_osc_control(root, "OS requested", requested);
+	decode_osc_control(root, "platform granted", control);
 	if (ACPI_SUCCESS(status)) {
-		decode_osc_control(root, "OS now controls", control);
 		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
 			 * We have ASPM control, but the FADT indicates that
@@ -516,8 +517,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			*no_aspm = 1;
 		}
 	} else {
-		decode_osc_control(root, "OS requested", requested);
-		decode_osc_control(root, "platform willing to grant", control);
 		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
 			acpi_format_exception(status));
 
-- 
2.17.1

