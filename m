Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:54048 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbaDCQ2n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 12:28:43 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so2102566ieb.28
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 09:28:43 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 10:28:23 -0600
Message-ID: <CAErSpo6z4D2e633umvWoSPX2BjKY5g5CAhOeqhFo27xGghncLA@mail.gmail.com>
Subject: Coverity CIDs 1195199, 1195200: mei/pci-txe.c doesn't check
 pci_enable_msi() return value
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Alexander Gordeev <agordeev@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity complains that mei_txe_probe() and mei_txe_pci_resume() call
pci_enable_msi() without checking the result.  They do check
indirectly, by testing pci_dev_msi_enabled(), but it would be nicer to
check the pci_enable_msi() result directly:

112        pci_enable_msi(pdev);
113
114        /* clear spurious interrupts */
115        mei_clear_interrupts(dev);
116
117        /* request and enable interrupt  */
118        if (pci_dev_msi_enabled(pdev))

These are CIDs 1195199 and 1195200.

Bjorn
