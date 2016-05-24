Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.8]:31914 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751686AbcEXGie convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 May 2016 02:38:34 -0400
From: Ocean HY1 He <hehy1@lenovo.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"luto@kernel.org" <luto@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"prarit@redhat.com" <prarit@redhat.com>,
	"jcm@redhat.com" <jcm@redhat.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Ocean HY1 He <hehy1@lenovo.com>
Subject: [PATCH] PCI/ASPM: fix reverse ASPM L0s assignment of upstream and
 downstream
Date: Tue, 24 May 2016 06:29:44 +0000
Message-ID: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In pcie_config_aspm_link(), when convert ASPM state to
upstream/downstream ASPM register state, the upstream variable and
dwsream variable are reversed. This causes PCI/E link enter ASPM L0s
even it should be disabled and PCI/E endpoint may reset randomly.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/pci/pcie/aspm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2dfe7fd..3f8a44d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -439,9 +439,9 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		return;
 	/* Convert ASPM state to upstream/downstream ASPM register state */
 	if (state & ASPM_STATE_L0S_UP)
-		dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;
-	if (state & ASPM_STATE_L0S_DW)
 		upstream |= PCI_EXP_LNKCTL_ASPM_L0S;
+	if (state & ASPM_STATE_L0S_DW)
+		dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;
 	if (state & ASPM_STATE_L1) {
 		upstream |= PCI_EXP_LNKCTL_ASPM_L1;
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
-- 
1.8.3.1
