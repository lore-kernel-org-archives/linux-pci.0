Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37500 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdJEKBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2017 06:01:50 -0400
From: Colin King <colin.king@canonical.com>
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] switchtec: make struct event_regs static
Date: Thu,  5 Oct 2017 11:01:45 +0100
Message-Id: <20171005100145.29309-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The structure event_regs is local to the source and does not need to
be in global scope, so make it static.

Cleans up sparse warning:
symbol 'event_regs' was not declared. Should it be static

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index af81b2dec42e..da45dbea20ce 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -943,7 +943,7 @@ static u32 __iomem *pff_ev_reg(struct switchtec_dev *stdev,
 #define EV_PAR(i, r)[i] = {offsetof(struct part_cfg_regs, r), part_ev_reg}
 #define EV_PFF(i, r)[i] = {offsetof(struct pff_csr_regs, r), pff_ev_reg}
 
-const struct event_reg {
+static const struct event_reg {
 	size_t offset;
 	u32 __iomem *(*map_reg)(struct switchtec_dev *stdev,
 				size_t offset, int index);
-- 
2.14.1
