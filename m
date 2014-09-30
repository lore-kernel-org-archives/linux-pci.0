Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40836 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaI3Qgg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Sep 2014 12:36:36 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Designware MSI fixes
Date: Tue, 30 Sep 2014 18:36:25 +0200
Message-Id: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Those two patches were part of my designware multi-msi series. I decided
to postpone that one a little bit until the treewide MSI chip patches from
Yijing Wang have landed, but those two patches are just too obvious
fixes/style corrections to let them wait any longer.

Both patches were tested by Jingoo Han as part of the earlier series, but
I had to modify them a bit for the rebase, so any review/testing much
appreciated. Patches are on top of the pci/host-designware branch.

Lucas Stach (2):
  PCI: designware: remove bogus multiple MSI setup
  PCI: designware: remove open-coded bitmap operations

 drivers/pci/host/pcie-designware.c | 98 ++++++--------------------------------
 1 file changed, 14 insertions(+), 84 deletions(-)

-- 
2.1.0

