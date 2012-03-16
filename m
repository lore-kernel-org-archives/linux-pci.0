Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f202.google.com ([209.85.160.202]:64414 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946276Ab2CPXsV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2012 19:48:21 -0400
Received: by ghbz15 with SMTP id z15so762422ghb.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2012 16:48:20 -0700 (PDT)
Subject: [PATCH v2 5/7] powerpc/PCI: allow reallocation on PA Semi
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 16 Mar 2012 17:48:19 -0600
Message-ID: <20120316234819.6649.55979.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We believe there's no reason to prevent reallocation on PA Semi, so
revert to the default of "allow reallocation if necessary."

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Tested-by: Olof Johansson <olof@lixom.net>
Acked-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/platforms/pasemi/pci.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index b27d886..aa86271 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -229,9 +229,6 @@ void __init pas_pci_init(void)
 
 	/* Setup the linkage between OF nodes and PHBs */
 	pci_devs_phb_init();
-
-	/* Use the common resource allocation mechanism */
-	pci_add_flags(PCI_PROBE_ONLY);
 }
 
 void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)

