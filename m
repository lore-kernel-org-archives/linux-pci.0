Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcJGQVK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:21:10 -0400
Subject: [PATCH 2/5] PCI: aardvark: Reorder accessor functions
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Oct 2016 11:21:06 -0500
Message-ID: <20161007162106.22668.45585.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder the accessors so the reader is first, as most other drivers do.
Uninline them.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-aardvark.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index fd0e6af..3d629d4 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -209,14 +209,14 @@ struct advk_pcie {
 	int root_bus_nr;
 };
 
-static inline void advk_writel(struct advk_pcie *advk, u32 val, u64 reg)
+static u32 advk_readl(struct advk_pcie *advk, u64 reg)
 {
-	writel(val, advk->base + reg);
+	return readl(advk->base + reg);
 }
 
-static inline u32 advk_readl(struct advk_pcie *advk, u64 reg)
+static void advk_writel(struct advk_pcie *advk, u32 val, u64 reg)
 {
-	return readl(advk->base + reg);
+	writel(val, advk->base + reg);
 }
 
 static int advk_pcie_link_up(struct advk_pcie *advk)

