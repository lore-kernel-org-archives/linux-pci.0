Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:41889 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbaBLTLE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 14:11:04 -0500
Received: by mail-ob0-f175.google.com with SMTP id wn1so10943793obc.34
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 11:11:03 -0800 (PST)
Received: from localhost ([172.16.48.185])
        by mx.google.com with ESMTPSA id ii8sm55040311obb.11.2014.02.12.11.11.02
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Feb 2014 11:11:02 -0800 (PST)
Subject: [PATCH 2/4] x86/PCI: Remove unnecessary local variable
 initialization
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Feb 2014 12:11:00 -0700
Message-ID: <20140212191059.5459.95679.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140212190949.5459.46330.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140212190949.5459.46330.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 4f25ec077552..ef7e92068eb1 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -473,11 +473,11 @@ probe_pci_root_info(struct pci_root_info *info, struct acpi_device *device,
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
 	struct acpi_device *device = root->device;
-	struct pci_root_info *info = NULL;
+	struct pci_root_info *info;
 	int domain = root->segment;
 	int busnum = root->secondary.start;
 	LIST_HEAD(resources);
-	struct pci_bus *bus = NULL;
+	struct pci_bus *bus;
 	struct pci_sysdata *sd;
 	int node;
 #ifdef CONFIG_ACPI_NUMA

