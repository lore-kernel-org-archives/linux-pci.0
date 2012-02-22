Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v1 01/11] PCI: make pci_flags always available
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Wed, 22 Feb 2012 11:19:07 -0700
Message-ID: <20120222181907.27513.95239.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we move resource assignment functions into the core, we'll still
need a way for architectures to prevent reassignment, e.g., the
"pci_probe_only" functionality, and we'll need a generic, always
available way the core can test for that.  The "pci_flags"
arrangement used by several architectures seems like a convenient
way to do this.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 86b69f85..7b7d7e9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -25,8 +25,11 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/slab.h>
+#include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
+unsigned int __weak pci_flags;
+
 struct resource_list_x {
 	struct resource_list_x *next;
 	struct resource *res;

