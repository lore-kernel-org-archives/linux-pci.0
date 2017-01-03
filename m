Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:34356 "EHLO
        mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933567AbdACIJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 03:09:51 -0500
Received: from messenger-mbx.win.comsys.rwth-aachen.de (messenger-mbx.win.comsys.rwth-aachen.de [137.226.13.43])
        by lists.comsys.rwth-aachen.de (Postfix) with ESMTPS id 210EE3FF2E
        for <linux-pci@vger.kernel.org>; Tue,  3 Jan 2017 09:09:50 +0100 (CET)
To: <linux-pci@vger.kernel.org>
From: =?UTF-8?B?SmFuIFLDvHRo?= <rueth@comsys.rwth-aachen.de>
Subject: [PATCH] pci/aspm: Fix null pointer dereference during re-enumeration
 of PCI bus in pcie_aspm_init_link_state even though ASPM is off
Message-ID: <8dd91424-b38c-4875-9752-9cc42a6f5701@comsys.rwth-aachen.de>
Date: Tue, 3 Jan 2017 09:09:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes a null pointer dereference during PCI bus enumeration
when ASPM is off. On an IBM x3850 8664 this bug causes the kernel to
halt, this behavior did not appear in 3.10, so this is a regression.

pcie_aspm_sanity_check should only be called if ASPM is on.

Signed-off-by: Jan Rueth <rueth@comsys.rwth-aachen.de>
---
 drivers/pci/pcie/aspm.c | +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f981129..e758b56 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -552,11 +552,12 @@ static struct pcie_link_state
*alloc_pcie_link_state(struct pci_dev *pdev)
 void pcie_aspm_init_link_state(struct pci_dev *pdev)
 {
        struct pcie_link_state *link;
-       int blacklist = !!pcie_aspm_sanity_check(pdev);
-
+       int blacklist;
        if (!aspm_support_enabled)
                return;

+       blacklist = !!pcie_aspm_sanity_check(pdev);
+
        if (pdev->link_state)
                return;
