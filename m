Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB213C43334
	for <linux-pci@archiver.kernel.org>; Wed, 20 Jul 2022 09:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiGTJr4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Jul 2022 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGTJr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 05:47:56 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C34765598;
        Wed, 20 Jul 2022 02:47:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 6116840D403D;
        Wed, 20 Jul 2022 09:47:49 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] ACPI/PCI: Remove useless NULL pointer checks
Date:   Wed, 20 Jul 2022 12:47:43 +0300
Message-Id: <20220720094743.471304-1-strochuk@ispras.ru>
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

