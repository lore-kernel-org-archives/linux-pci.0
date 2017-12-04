Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56468 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754055AbdLDPJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 10:09:44 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 3/8] arch/sh: pci: don't use disabled resources
Date: Mon,  4 Dec 2017 16:09:02 +0100
Message-Id: <20171204150907.24345-4-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In pcibios_scanbus(), we provide to the PCI core the usable MEM and IO
regions using pci_add_resource_offset(). We travel through all
resources available in the "struct pci_channel".

Also, in register_pci_controller(), we travel through all resources to
request them, making sure they don't conflict with already requested
resources.

However, some resources may be disabled, in which case they should not
be requested nor provided to the PCI core.

In the current situation, none of the resources are disabled. However,
follow-up patches in this series will make some resources disabled,
making this preliminary change necessary.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 5976a2c8a3e3..e5b7437ab4af 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -49,6 +49,8 @@ static void pcibios_scanbus(struct pci_channel *hose)
 	for (i = 0; i < hose->nr_resources; i++) {
 		res = hose->resources + i;
 		offset = 0;
+		if (res->flags & IORESOURCE_DISABLED)
+			continue;
 		if (res->flags & IORESOURCE_IO)
 			offset = hose->io_offset;
 		else if (res->flags & IORESOURCE_MEM)
@@ -102,6 +104,9 @@ int register_pci_controller(struct pci_channel *hose)
 	for (i = 0; i < hose->nr_resources; i++) {
 		struct resource *res = hose->resources + i;
 
+		if (res->flags & IORESOURCE_DISABLED)
+			continue;
+
 		if (res->flags & IORESOURCE_IO) {
 			if (request_resource(&ioport_resource, res) < 0)
 				goto out;
-- 
2.13.6
