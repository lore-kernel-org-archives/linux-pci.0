Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38881 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdHBTpn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2017 15:45:43 -0400
Received: by mail-wm0-f51.google.com with SMTP id m85so1140132wma.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Aug 2017 12:45:43 -0700 (PDT)
From: Piotr Gregor <piotrgregor@rsyncme.org>
Date: Wed, 2 Aug 2017 20:42:18 +0100
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: pci: Add in description of pci_set_power_state
Message-ID: <20170802194216.GA12995@westernst>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add two reasons of returning 0 value to the description
of the pci_set_power_state to include the cases when:

- the transition is to D1 or D2 but D1 and D2 are not supported
- the transition is to D3 but D3 is not supported.

Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..9528781 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -892,7 +892,9 @@ EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
  * -EINVAL if the requested state is invalid.
  * -EIO if device does not support PCI PM or its PM capabilities register has a
  * wrong version, or device doesn't support the requested state.
+ * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
  * 0 if device already is in the requested state.
+ * 0 if the transition is to D3 but D3 is not supported.
  * 0 if device's power state has been successfully changed.
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
-- 
2.1.4
