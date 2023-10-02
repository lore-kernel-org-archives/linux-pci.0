Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFF8E784AC
	for <linux-pci@archiver.kernel.org>; Mon,  2 Oct 2023 13:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjJBNyC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Oct 2023 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbjJBNyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 09:54:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05431E6;
        Mon,  2 Oct 2023 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254839; x=1727790839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0iczxjgf4Ie892NJSryS5MvdoCgiYH0AtCxc5GWpQHs=;
  b=R2CalH1N4wekZtdc7/m2n/6bPAhpPbN6oOCXpoL+YLhy7HSXrLuurYOO
   6sykNadUIV4uDKhyF4x13GnmfbPqkVr4natcFkdct3RmVtoWFRotPkSRM
   HfZ7vuo8vxMW1IMqS53vqJhyCt9WV9z6WCIsEwsjz6ExwuRmvzjkcU/rF
   Oehnrl4YzwGDq1I6WXSGskt3L4Oekr97pxC5TLnkK1maSn2FhT5yJP+k1
   8Y2rrfOmsrIsbphsNumdSTdjD/24izlovGfVsfsxb6SXuPLOLaFENsF8J
   A+M0frRjZz2NFb7axSzqPrEEwuL30oBfy1YLFqjkP7K9ZfU21MgvTpCZs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="372995203"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372995203"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="840990880"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="840990880"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2023 06:53:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DCF131A7; Mon,  2 Oct 2023 16:53:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI: ACPI: Switch to use acpi_evaluate_dsm_typed()
Date:   Mon,  2 Oct 2023 16:53:52 +0300
Message-Id: <20231002135352.2603096-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pci-acpi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a05350a4e49c..cf108259aef6 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1215,12 +1215,12 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 	if (!pci_is_root_bus(bus))
 		return;
 
-	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
-				DSM_PCI_POWER_ON_RESET_DELAY, NULL);
+	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
+				      DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
 	if (!obj)
 		return;
 
-	if (obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 1) {
+	if (obj->integer.value == 1) {
 		bridge = pci_find_host_bridge(bus);
 		bridge->ignore_reset_delay = 1;
 	}
@@ -1376,12 +1376,13 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	if (bridge->ignore_reset_delay)
 		pdev->d3cold_delay = 0;
 
-	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 3,
-				DSM_PCI_DEVICE_READINESS_DURATIONS, NULL);
+	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
+				      DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
+				      ACPI_TYPE_PACKAGE);
 	if (!obj)
 		return;
 
-	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
+	if (obj->package.count == 5) {
 		elements = obj->package.elements;
 		if (elements[0].type == ACPI_TYPE_INTEGER) {
 			value = (int)elements[0].integer.value / 1000;
-- 
2.40.0.1.gaa8946217a0b

