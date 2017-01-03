Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36677 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934542AbdACGen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 01:34:43 -0500
Received: by mail-pg0-f49.google.com with SMTP id f188so211334146pgc.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2017 22:34:42 -0800 (PST)
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Wang Sheng-Hui <shhuiw@foxmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Subject: [PATCH 6/6] PCI/ASPM: Add comment about L1 substate latency
Date: Mon,  2 Jan 2017 22:34:15 -0800
Message-Id: <1483425255-101923-7-git-send-email-rajatja@google.com>
In-Reply-To: <1483425255-101923-1-git-send-email-rajatja@google.com>
References: <1483425255-101923-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since the exit latencies for L1 substates are not advertised by
a device, it is not clear in spec how to do a L1 substate exit
latency check. We assume that the L1 exit latencies advertised
by a device include L1 substate latencies (and hence do not do any
check). If that is not true, we should do some sort of check here.

(I'm not clear about what that check should like currenlty. I'd be
glad to take up any suggestions).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pcie/aspm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 6735f38..cb5602c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -403,6 +403,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		 * Check L1 latency.
 		 * Every switch on the path to root complex need 1
 		 * more microsecond for L1. Spec doesn't mention L0s.
+		 *
+		 * The exit latencies for L1 substates are not advertised
+		 * by a device. Since the spec also doesn't mention a way
+		 * to determine max latencies introduced by enabling L1
+		 * substates on the components,  it is not clear how to do
+		 * a L1 substate exit latency check. We assume that the
+		 * L1 exit latencies advertised by a device include L1
+		 * substate latencies (and hence do not do any check)
 		 */
 		latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
 		if ((link->aspm_capable & ASPM_STATE_L1) &&
-- 
2.8.0.rc3.226.g39d4020

