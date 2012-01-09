Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:57695 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880Ab2AIWnu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2012 17:43:50 -0500
Received: by yenm5 with SMTP id m5so492170yen.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2012 14:43:49 -0800 (PST)
Subject: [PATCH v2 1/3] x86/PCI: build amd_bus.o only when CONFIG_AMD_NB=y
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Date: Mon, 09 Jan 2012 15:43:49 -0700
Message-ID: <20120109224349.24913.23010.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We only need amd_bus.o for AMD systems with PCI.  arch/x86/pci/Makefile
already depends on CONFIG_PCI=y, so this patch just adds the dependency
on CONFIG_AMD_NB.

CC: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index 6b8759f..d24d3da 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -18,8 +18,9 @@ obj-$(CONFIG_X86_NUMAQ)		+= numaq_32.o
 obj-$(CONFIG_X86_MRST)		+= mrst.o
 
 obj-y				+= common.o early.o
-obj-y				+= amd_bus.o bus_numa.o
+obj-y				+= bus_numa.o
 
+obj-$(CONFIG_AMD_NB)		+= amd_bus.o
 obj-$(CONFIG_PCI_CNB20LE_QUIRK)	+= broadcom_bus.o
 
 ifeq ($(CONFIG_PCI_DEBUG),y)

