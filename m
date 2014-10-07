Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59997 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbaJGE6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Oct 2014 00:58:09 -0400
Message-ID: <1412656721.30859.124.camel@pasglop>
Subject: [PATCH v3 6/7] powerpc/pseries: Honor the generic "no_64bit_msi"
 flag
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Tue, 07 Oct 2014 15:38:41 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of the arch specific quirk which we are deprecating
and that drivers don't understand.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---
 arch/powerpc/platforms/pseries/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 18ff462..6fd96d8 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -429,7 +429,7 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
 	 */
 again:
 	if (type == PCI_CAP_ID_MSI) {
-		if (pdn->force_32bit_msi) {
+		if (pdev->no_64bit_msi) {
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
 			if (rc < 0) {
 				/*


