Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHFA6B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 5 Aug 2018 20:58:01 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v7 0/1] PCI: Handle conflict between hotplug and error handling
Date: Sun,  5 Aug 2018 15:51:35 -0700
Message-Id: <20180805225136.5800-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lukas:
'Your patch "[PATCH v6 1/1] PCI: pciehp: Ignore link events when there
is a fatal error pending" only checks once for a pending fatal error,
it should poll until either the fatal error is gone or a timeout is
hit.  If the fatal error is gone and the link is up, you can just return
from pciehp_handle_presence_or_link_change().  Else (in the timeout case)
fall back to the normal handling of a Link Down, i.e. let it bring down
the slot.'


Sinan Kaya (1):
  PCI: pciehp: Ignore link events when there is a fatal error pending

 drivers/pci/hotplug/pciehp_ctrl.c | 19 ++++++++++
 drivers/pci/pci.h                 |  2 ++
 drivers/pci/pcie/err.c            | 60 +++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

-- 
2.17.1
