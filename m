Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:59592
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751931Ab3HBWnO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 18:43:14 -0400
From: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<dougthompson@xmission.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<jbeulich@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Subject: [PATCH 0/3 V2] EDAC, AMD64_EDAC: Add ECC error decoding for newer Fam15h models.
Date: Fri, 2 Aug 2013 17:43:01 -0500
Message-ID: <1375483384-2302-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes from V1:
	- Splitting up the patch
	- Remove unnecessary helper functions
	- Add family/model to amd64_pvt
	- Cleanup indent issues

Aravind Gopalakrishnan (3):
  EDAC, AMD64_EDAC: Add PCI Device ID Functions 3 and 4 for newer F15h
    models.
  EDAC, AMD64_EDAC: Add relevant condition checks as F15h M30h does not
    support GART or L3.
  EDAC, AMD64_EDAC: Add ECC decoding support for newer F15h models.

 arch/x86/kernel/amd_nb.c  |   14 ++-
 drivers/edac/amd64_edac.c |  276 +++++++++++++++++++++++++++++++++++++++++----
 drivers/edac/amd64_edac.h |   65 ++++++++++-
 include/linux/pci_ids.h   |    2 +
 4 files changed, 330 insertions(+), 27 deletions(-)

-- 
1.7.10.4


