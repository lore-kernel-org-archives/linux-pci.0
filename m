Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F7C43334
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jul 2022 10:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiGSKAS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Jul 2022 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiGSKAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 06:00:16 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E886341;
        Tue, 19 Jul 2022 03:00:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id A5ADF40D4004;
        Tue, 19 Jul 2022 10:00:02 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] ACPI: remove useless comparisons in acpi_pci_link_check_possible(), acpi_pci_link_check_current()
Date:   Tue, 19 Jul 2022 12:59:50 +0300
Message-Id: <20220719095950.5420-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Local variable 'p' is initialized by an address
of field of acpi_resource, so it does not make
sense to compare 'p' with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 drivers/acpi/pci_link.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 58647051c948..aa1038b8aec4 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -95,7 +95,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 	case ACPI_RESOURCE_TYPE_IRQ:
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				acpi_handle_debug(handle,
 						  "Blank _PRS IRQ resource\n");
 				return AE_OK;
@@ -121,7 +121,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 		{
 			struct acpi_resource_extended_irq *p =
 			    &resource->data.extended_irq;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				acpi_handle_debug(handle,
 						  "Blank _PRS EXT IRQ resource\n");
 				return AE_OK;
@@ -182,7 +182,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
 	case ACPI_RESOURCE_TYPE_IRQ:
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				/*
 				 * IRQ descriptors may have no IRQ# bits set,
 				 * particularly those w/ _STA disabled
@@ -197,7 +197,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
 		{
 			struct acpi_resource_extended_irq *p =
 			    &resource->data.extended_irq;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				/*
 				 * extended IRQ descriptors must
 				 * return at least 1 IRQ
-- 
2.25.1

