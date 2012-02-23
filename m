Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qw0-f74.google.com ([209.85.216.74]:48563 "EHLO
	mail-qw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab2BWToF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 14:44:05 -0500
Received: by mail-qw0-f74.google.com with SMTP id b12so213849qad.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 11:44:04 -0800 (PST)
Subject: [PATCH v2 12/12] PCI: make pci_flags non-weak
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Thu, 23 Feb 2012 12:44:03 -0700
Message-ID: <20120223194403.20708.53279.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No architecture defines its own pci_flags, so the core symbol does not
need to be weak.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7b7d7e9..c172ebb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -28,7 +28,7 @@
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
-unsigned int __weak pci_flags;
+unsigned int pci_flags;
 
 struct resource_list_x {
 	struct resource_list_x *next;

