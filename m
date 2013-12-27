Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45814 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3L0Aa2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Dec 2013 19:30:28 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MYF004BRW2QJ170@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 27 Dec 2013 09:30:26 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: designware: Fix indent code style
Date: Fri, 27 Dec 2013 09:30:25 +0900
Message-id: <000401cf029a$d63943d0$82abcb70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix indent code style and replace 'MSI interrupt controller'
of comment with 'MSI controller', in order to fix the following
checkpatch issues.

  ERROR: code indent should use tabs where possible
  WARNING: please, no spaces at the start of a line
  WARNING: line over 80 characters

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-designware.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 4a08d30..17ce88f 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -213,14 +213,14 @@ static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
 }
 
 static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
-                            unsigned int nvec, unsigned int pos)
+			    unsigned int nvec, unsigned int pos)
 {
 	unsigned int i, res, bit, val;
 
 	for (i = 0; i < nvec; i++) {
 		irq_set_msi_desc_off(irq_base, i, NULL);
 		clear_bit(pos + i, pp->msi_irq_in_use);
-		/* Disable corresponding interrupt on MSI interrupt controller */
+		/* Disable corresponding interrupt on MSI controller */
 		res = ((pos + i) / 32) * 12;
 		bit = (pos + i) % 32;
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
-- 
1.7.10.4


