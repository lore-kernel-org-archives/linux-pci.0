Return-Path: <SRS0=sUav=7Q=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB7AC433E0
	for <linux-pci@archiver.kernel.org>; Wed,  3 Jun 2020 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935E620674
	for <linux-pci@archiver.kernel.org>; Wed,  3 Jun 2020 11:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgFCLsy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:48:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:3399 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCLsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:48:54 -0400
IronPort-SDR: S6B2zTxvRxV32bq+Zu89T3v641Gd5Yr/knYCSFnRMIuNjYb/QYRccBfHfLIyI6DHC5ujn0Emiq
 4rdwHBgmrsyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:48:54 -0700
IronPort-SDR: 4ddw8OIBGud9DgrSrKlodfEOWc4XlfVomUWtecYaXdUmTCaFcQJklBUyp35vy2jCHjjbgwwVh5
 LfUy+ojYrw6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="312587263"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jun 2020 04:48:52 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/15] vmw_vmci: Use PCI_IRQ_ALL_TYPES where appropriate
Date:   Wed,  3 Jun 2020 13:48:49 +0200
Message-Id: <20200603114850.13542-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index cc8eeb361fcd..ea300573f652 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -584,8 +584,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	error = pci_alloc_irq_vectors(pdev, VMCI_MAX_INTRS, VMCI_MAX_INTRS,
 			PCI_IRQ_MSIX);
 	if (error < 0) {
-		error = pci_alloc_irq_vectors(pdev, 1, 1,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+		error = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 		if (error < 0)
 			goto err_remove_bitmap;
 	} else {
-- 
2.17.2

