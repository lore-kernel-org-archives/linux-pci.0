Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:49065 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHMd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Feb 2018 07:33:56 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Niklas Cassel <niklass@axis.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        John Keeping <john@metanate.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: endpoint: Handle 64-bit BARs properly
Date: Thu,  8 Feb 2018 13:33:44 +0100
Message-Id: <20180208123346.20784-2-niklas.cassel@axis.com>
In-Reply-To: <20180208123346.20784-1-niklas.cassel@axis.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A 64-bit BAR uses the succeeding BAR for the upper bits, therefore
we cannot call pci_epc_set_bar() on a BAR that follows a 64-bit BAR.

If pci_epc_set_bar() is called with flag PCI_BASE_ADDRESS_MEM_TYPE_64,
it has to be up to the controller driver to write both BAR[x] and BAR[x+1]
(and BAR_mask[x] and BAR_mask[x+1]).

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 800da09d9005..eef85820f59e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -382,6 +382,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 			if (bar == test_reg_bar)
 				return ret;
 		}
+		if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
+			bar++;
 	}
 
 	return 0;
-- 
2.14.2
