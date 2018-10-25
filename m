Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C156ECDE46
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE67120856
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 16:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE67120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xes-inc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJZAe5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:34:57 -0400
Received: from xes-mad.com ([162.248.234.2]:48259 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbeJZAe4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 20:34:56 -0400
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id 58E9A264AB;
        Thu, 25 Oct 2018 11:01:32 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/2] PCI/ACPI: Move _OSC test for native services to top
Date:   Thu, 25 Oct 2018 11:01:31 -0500
Message-Id: <1540483292-24049-2-git-send-email-asierra@xes-inc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
References: <1539642186-12821-1-git-send-email-asierra@xes-inc.com>
 <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the simple test for when PCIe native services are disabled
closer to the top, prior to where things get more complicated.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/acpi/pci_root.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc..eb9f14e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -441,6 +441,12 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
+	if (pcie_ports_disabled) {
+		dev_info(&device->dev,
+			 "PCIe port services disabled; not requesting _OSC control\n");
+		return;
+	}
+
 	/*
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
@@ -468,11 +474,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
-	if (pcie_ports_disabled) {
-		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
-		return;
-	}
-
 	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
 		decode_osc_support(root, "not requesting OS control; OS requires",
 				   ACPI_PCIE_REQ_SUPPORT);
-- 
2.7.4

