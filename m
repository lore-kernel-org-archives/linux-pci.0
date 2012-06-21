Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:37223 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758631Ab2FUAQq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 20:16:46 -0400
Received: by fat25 with SMTP id 25so2361fat.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:44 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 7A37020004E
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:44 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id E5B13180181
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:43 -0700 (PDT)
Subject: [PATCH 2/6] PCI: fix upstream P2P bridge checks when enabling OBFF
	and LTR
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 Jun 2012 18:16:43 -0600
Message-ID: <20120621001643.4834.1430.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
References: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_enable_obff() and pci_enable_ltr() incorrectly check "dev->bus" instead
of "dev->bus->self" to determine whether the upstream device is a P2P
bridge or a host bridge.  For devices on the root bus, the upstream device
is a host bridge, "dev->bus != NULL" and "dev->bus->self == NULL", and we
panic with a null pointer dereference.

These functions should previously have panicked when called on devices
supporting OBFF or LTR, so they should be regarded as untested.

Found by Coverity (CID 143038 and CID 143039).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f4a5ea..b9e93cf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2108,7 +2108,7 @@ int pci_enable_obff(struct pci_dev *dev, enum pci_obff_signal_type type)
 		return -ENOTSUPP; /* no OBFF support at all */
 
 	/* Make sure the topology supports OBFF as well */
-	if (dev->bus) {
+	if (dev->bus->self) {
 		ret = pci_enable_obff(dev->bus->self, type);
 		if (ret)
 			return ret;
@@ -2215,7 +2215,7 @@ int pci_enable_ltr(struct pci_dev *dev)
 		return -EINVAL;
 
 	/* Enable upstream ports first */
-	if (dev->bus) {
+	if (dev->bus->self) {
 		ret = pci_enable_ltr(dev->bus->self);
 		if (ret)
 			return ret;

