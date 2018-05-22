Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeEVNKW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 09:10:22 -0400
Subject: [PATCH v1 2/3] xtensa/PCI: Make variables static
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 08:10:21 -0500
Message-ID: <152699462102.162480.10622776995414606885.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Make these variables static, since they're only used in this file:

  pci_ctrl_head
  pci_ctrl_tail

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/xtensa/kernel/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index d451b4f5b1e0..e121b555fdb4 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -41,8 +41,8 @@
  * pci_bus_add_device
  */
 
-struct pci_controller* pci_ctrl_head;
-struct pci_controller** pci_ctrl_tail = &pci_ctrl_head;
+static struct pci_controller *pci_ctrl_head;
+static struct pci_controller **pci_ctrl_tail = &pci_ctrl_head;
 
 static int pci_bus_count;
 
