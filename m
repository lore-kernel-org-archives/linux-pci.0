Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C092CC433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7703B2147D
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7703B2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeITWKm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:21034 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeITWKm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918154"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 09:26:24 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 00/12] pci error handling fixes
Date:   Thu, 20 Sep 2018 10:27:05 -0600
Message-Id: <20180920162717.31066-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v3 are:

  Initialize port services directly from port driver (suggested by
  Bjorn)

  Updated changelogs to match local style

  Added documentation update for ERR_FATAL behavior

  Included DPC save/restore state fix that was missing from previous

  Included AER upstream port fix that was mistakenly added to a
  different patch set

Keith Busch (12):
  PCI: portdrv: Initialize service drivers directly
  PCI: portdrv: Restore pci state on slot reset
  PCI: DPC: Save and restore control state
  PCI: AER: Take reference on error devices
  PCI: AER: Don't read upstream ports below fatal errors
  PCI: ERR: Use slot reset if available
  PCI: ERR: Handle fatal error recovery
  PCI: ERR: Always use the first downstream port
  PCI: ERR: Simplify broadcast callouts
  PCI: ERR: Report current recovery status for udev
  PCI: Unify device inaccessible
  PCI: Make link active reporting detection generic

 Documentation/PCI/pci-error-recovery.txt |  35 ++--
 drivers/pci/hotplug/pciehp.h             |   6 -
 drivers/pci/hotplug/pciehp_core.c        |   3 +-
 drivers/pci/hotplug/pciehp_hpc.c         |  22 +--
 drivers/pci/pci.c                        |  68 +++++++-
 drivers/pci/pci.h                        |  74 ++++++++-
 drivers/pci/pcie/aer.c                   |  25 +--
 drivers/pci/pcie/dpc.c                   |  72 ++++++--
 drivers/pci/pcie/err.c                   | 276 ++++++++-----------------------
 drivers/pci/pcie/pme.c                   |   3 +-
 drivers/pci/pcie/portdrv.h               |  24 +++
 drivers/pci/pcie/portdrv_pci.c           |  17 ++
 drivers/pci/probe.c                      |   1 +
 drivers/pci/slot.c                       |   2 +-
 include/linux/pci.h                      |   1 +
 15 files changed, 331 insertions(+), 298 deletions(-)

-- 
2.14.4

