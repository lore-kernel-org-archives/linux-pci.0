Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42906 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbbC3K7x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Mar 2015 06:59:53 -0400
Date: Mon, 30 Mar 2015 12:59:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jens Frederich <jfrederich@gmail.com>,
	Daniel Drake <dsd@laptop.org>,
	Jon Nettleton <jon.nettleton@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org
Subject: [PATCH v2 6/6] staging/olpc: drop pci dependencies
Message-ID: <1427712964-16155-7-git-send-email-mst@redhat.com>
References: <1427712964-16155-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427712964-16155-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This file does not use any pci APIs, drop
pci header includes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index bc7e664..d115f5c 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -18,8 +18,6 @@
 #include <linux/console.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/module.h>
-- 
MST

