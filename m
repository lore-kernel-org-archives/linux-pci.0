Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31178C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7232087F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfAaRHv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:07:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:50770 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfAaRHv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 12:07:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 09:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="296207379"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2019 09:07:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 09E64108; Thu, 31 Jan 2019 19:07:46 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: Fix runtime PME generation from D3hot
Date:   Thu, 31 Jan 2019 20:07:44 +0300
Message-Id: <20190131170746.7604-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Heiner reported [1] that runtime PME generation of his network card does
not work after commit 0e157e528604 ("PCI/PME: Implement runtime PM
callbacks") that landed in v4.20. Reverting the commit helps but it has
another drawback, which I originally tried to solve with the commit, that
the PCIe hierarchy wakes up immediately after being put into D3cold.

This series of two patches tries to fix both issues so that PME wakes up
from D3hot and that the hierarchy does not wake up immediately from D3cold.

The previous version of the series can be found here:

  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1892241.html

Changes from the previous version:

  * Add tags from Heiner and Rafael
  * Update changelog to mention relevent PCIe spec sections
  * Add comment to pcie_disable_interrupt() explaining why and what is
    masked

[1] https://www.spinics.net/lists/linux-pci/msg79051.html

Mika Westerberg (2):
  Revert "PCI/PME: Implement runtime PM callbacks"
  PCI: pciehp: Disable Data Link Layer State Changed event on suspend

 drivers/pci/hotplug/pciehp_hpc.c | 17 +++++++++++++++--
 drivers/pci/pcie/pme.c           | 27 ---------------------------
 2 files changed, 15 insertions(+), 29 deletions(-)

-- 
2.20.1

