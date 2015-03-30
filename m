Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60172 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbbC3K7g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Mar 2015 06:59:36 -0400
Date: Mon, 30 Mar 2015 12:59:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: [PATCH v2 1/6] crypto/ccp: drop linux/pci dependencies
Message-ID: <1427712964-16155-2-git-send-email-mst@redhat.com>
References: <1427712964-16155-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427712964-16155-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci code is in ccp-pci.c, don't include pci
headers from ccp/ccp-ops.c.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/crypto/ccp/ccp-ops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index 8729364..3da1140 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -12,8 +12,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
-- 
MST

