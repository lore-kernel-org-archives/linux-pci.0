Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0141.outbound.protection.outlook.com ([157.56.110.141]:40197
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753340AbaIRTyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Sep 2014 15:54:36 -0400
From: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<tglx@linutronix.de>, <hpa@zytor.com>, <x86@kernel.org>,
	<bp@suse.de>, <dan.carpenter@oracle.com>,
	<dougthompson@xmission.com>, <bp@alien8.de>,
	<m.chehab@samsung.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Subject: [PATCH 0/4] Add Fam15h Model60h support
Date: Thu, 18 Sep 2014 14:56:25 -0500
Message-ID: <1411070185-10137-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series is based on top of V5 patch regarding
Modify usage of amd64_read_dct_pci_cfg().
Link: http://marc.info/?l=linux-kernel&m=141079846507232&w=2

I had started work on above one earlier and could not test this patch
series before, so ended up sending it separately. I can meld it together
if that is desired.

Summary of new features in the processor:
 - DDR4 memory support
 - DDR3 LRDIMM support
 - Support for above are in Patches 3,4 of series.

Summary of patches in this series:
 - Patch 1: Add PCI device ID definitions
 - Patch 2: Add PCI IDs to NB tables as we need to cache Northbridges
            for later use in amd64_edac
 - Patch 3: F15hM60h adds support for DDR4 and DDR3 LRDIMMS. Adding them here.
 - Patch 4: Adds bulk of the code necessary to support F15hM60h.
            Also introduces a change to dbam_to_cs mapper functions.

Aravind Gopalakrishnan (4):
  pci_ids: Add PCI device IDs for F15h M60h
  x86, amd_nb: Add device IDs to NB tables for F15h M60h
  edac: Add DDR3 LRDIMM support, entries in edac_mem_types[]
  edac, amd64_edac: Add F15h M60h support

 arch/x86/kernel/amd_nb.c  |   2 +
 drivers/edac/amd64_edac.c | 226 ++++++++++++++++++++++++++++++++--------------
 drivers/edac/amd64_edac.h |  12 ++-
 drivers/edac/edac_mc.c    |   3 +
 include/linux/edac.h      |   2 +
 include/linux/pci_ids.h   |   2 +
 6 files changed, 178 insertions(+), 69 deletions(-)

-- 
2.0.2

