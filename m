Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:55351
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753642Ab3HBPdW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 11:33:22 -0400
From: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<dougthompson@xmission.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<jbeulich@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Subject: [PATCH 0/1] EDAC, AMD64_EDAC: Add ECC error decoding for newer Fam15h models.
Date: Fri, 2 Aug 2013 10:33:11 -0500
Message-ID: <1375457592-2194-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Aravind Gopalakrishnan (1):
  EDAC, AMD64_EDAC: Add ECC decoding support for newer F15h models.

 arch/x86/kernel/amd_nb.c  |   14 ++-
 drivers/edac/amd64_edac.c |  277 +++++++++++++++++++++++++++++++++++++++++----
 drivers/edac/amd64_edac.h |  108 +++++++++++++++++-
 include/linux/pci_ids.h   |    2 +
 4 files changed, 375 insertions(+), 26 deletions(-)

-- 
1.7.10.4


