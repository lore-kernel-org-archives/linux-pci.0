Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 30 Mar 2015 12:59:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-parisc@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v2 2/6] input/serio: drop pci_ids dependency
Message-ID: <1427712964-16155-3-git-send-email-mst@redhat.com>
References: <1427712964-16155-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427712964-16155-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This driver does not use any PCI IDs, don't include
the pci_ids.h header.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/input/serio/gscps2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 94ab494..ecba666 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -31,7 +31,6 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
-#include <linux/pci_ids.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
-- 
MST

