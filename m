Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f202.google.com ([209.85.161.202]:39423 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab2EWEfJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 00:35:09 -0400
Received: by ggeh3 with SMTP id h3so829248gge.1
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2012 21:35:09 -0700 (PDT)
Subject: [PATCH v6 1/2] PCI: acpiphp: fix function 0 leak when disabling a slot
To: Amos Kong <kongjianjun@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, liuj97@gmail.com, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, kaneshige.kenji@jp.fujitsu.com
Date: Tue, 22 May 2012 22:35:06 -0600
Message-ID: <20120523043506.13449.81850.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120523043347.13449.1063.stgit@bhelgaas.mtv.corp.google.com>
References: <20120523043347.13449.1063.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Amos Kong <kongjianjun@gmail.com>

Previously, we acquired two references to function 0, but only released
one.

[bhelgaas: split this out from "remove all functions" fix]
Signed-off-by: Amos Kong <kongjianjun@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 62d0ae4..c8f9991 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -893,6 +893,7 @@ static int disable_device(struct acpiphp_slot *slot)
 	pdev = pci_get_slot(bus, PCI_DEVFN(slot->device, 0));
 	if (!pdev)
 		goto err_exit;
+	pci_dev_put(pdev);
 
 	list_for_each_entry(func, &slot->funcs, sibling) {
 		if (func->bridge) {

