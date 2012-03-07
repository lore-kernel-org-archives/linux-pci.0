Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 13/34] PCI: make pci_flags non-weak
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 07 Mar 2012 15:33:10 -0700
Message-ID: <20120307223310.25669.87977.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
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
index 6db307f..e241f2f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -28,7 +28,7 @@
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
-unsigned int __weak pci_flags;
+unsigned int pci_flags;
 
 struct pci_dev_resource {
 	struct list_head list;

