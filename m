Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v1 11/11] PCI: make pci_flags non-weak
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Wed, 22 Feb 2012 11:19:58 -0700
Message-ID: <20120222181958.27513.2134.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
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

