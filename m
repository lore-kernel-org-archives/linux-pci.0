Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34031 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbbFDVtj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 17:49:39 -0400
Received: by obew15 with SMTP id w15so42353675obe.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 14:49:38 -0700 (PDT)
Subject: [PATCH 2/7] microblaze/PCI: Remove unnecessary
 pci_bus_find_capability() declaration
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <monstr@monstr.eu>
Date: Thu, 04 Jun 2015 16:49:36 -0500
Message-ID: <20150604214936.2399.94190.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_bus_find_capability() is declared in include/linux/pci.h.

Remove the pci_bus_find_capability() declaration from
arch/microblaze/include/asm/pci.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/pci.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index b6b5b3c..541400d 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -102,9 +102,6 @@ extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
 
 extern void pcibios_resource_survey(void);
 
-extern int pci_bus_find_capability(struct pci_bus *bus,
-						unsigned int devfn, int cap);
-
 struct file;
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long pfn,

