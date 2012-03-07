Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:58185 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030715Ab2CGWc4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2012 17:32:56 -0500
Received: by mail-ey0-f202.google.com with SMTP id q10so249452eaa.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2012 14:32:56 -0800 (PST)
Subject: [PATCH v3 10/34] powerpc/PCI: allow reallocation on PA Semi
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Mar 2012 15:32:55 -0700
Message-ID: <20120307223255.25669.42520.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We believe there's no reason to prevent reallocation on PA Semi, so
revert to the default of "allow reallocation if necessary."

CC: Olof Johansson <olof@lixom.net>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/platforms/pasemi/pci.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index b6a0ec4..aa86271 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -229,9 +229,6 @@ void __init pas_pci_init(void)
 
 	/* Setup the linkage between OF nodes and PHBs */
 	pci_devs_phb_init();
-
-	/* Use the common resource allocation mechanism */
-	pci_probe_only = 1;
 }
 
 void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)

