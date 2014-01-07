Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36701 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbaAGAzV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2014 19:55:21 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so19620695ief.38
        for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2014 16:55:21 -0800 (PST)
Subject: [PATCH v7 01/15] PCI: Change pci_bus_region addresses to dma_addr_t
To: linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Airlie <airlied@linux.ie>, Yinghai Lu <yinghai@kernel.org>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Date: Mon, 06 Jan 2014 17:55:19 -0700
Message-ID: <20140107005519.10786.93870.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Struct pci_bus_region contains bus addresses, which are type dma_addr_t,
not resource_size_t.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1084a15175e0..7d5555270491 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -551,8 +551,8 @@ int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
 		  int reg, int len, u32 val);
 
 struct pci_bus_region {
-	resource_size_t start;
-	resource_size_t end;
+	dma_addr_t start;
+	dma_addr_t end;
 };
 
 struct pci_dynids {

