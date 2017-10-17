Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0074.outbound.protection.outlook.com ([104.47.34.74]:53536
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761970AbdJQMsY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 08:48:24 -0400
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com
Cc: Wilson.Snyder@cavium.com, robert.richter@cavium.com,
        david.daney@cavium.com, mjaggi@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v7 1/2] PCI: quirks: Set Cavium ACS capability quirk flags to assert RR/CR/SV/UF.
Date: Tue, 17 Oct 2017 05:47:38 -0700
Message-Id: <1508244459-2615-2-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
In-Reply-To: <1508244459-2615-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
References: <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1508244459-2615-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The Cavium ThunderX (CN8XXX) family PCIe Root Ports has limited PCI
capabilities in terms of no ACS support advertisement. However,
the RTL internally implements similar protection as if ACS had
completion/request redirection, upstream forwarding and validation
features enabled.

This commit changes Cavium ACS capabilities quirk flags accordingly.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/pci/quirks.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a4d33619a7bb..5e0e83304fda 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4214,12 +4214,13 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	/*
-	 * Cavium devices matching this quirk do not perform peer-to-peer
-	 * with other functions, allowing masking out these bits as if they
-	 * were unimplemented in the ACS capability.
+	 * The Cavium downstream ports doesn't advertise their ACS capability
+	 * registers. However, the RTL internally implements similar protection
+	 * as if ACS had completion redirection, forwarding and validation
+	 * features enabled. So by this flags we're asserting that the hardware
+	 * implements and enables equivalent ACS functionality for these flags.
 	 */
-	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
-		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
+	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
 
 	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
 		return -ENOTTY;
-- 
2.13.6
