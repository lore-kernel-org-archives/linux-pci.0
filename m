Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0182.outbound.protection.outlook.com ([207.46.163.182]:32379
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755128AbaEHQon (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 May 2014 12:44:43 -0400
From: <suravee.suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
	Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>,
	Borislav Petkov <bp@suse.de>,
	"Robert Richter" <rric@kernel.org>,
	Daniel J Blueman <daniel@numascale.com>,
	Andreas Herrmann <herrmann.der.user@googlemail.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V4 0/4] x86/pci Fix numa_node info for AMD hostbridge and misc clean up.
Date: Thu, 8 May 2014 11:44:17 -0500
Message-ID: <1399567461-15928-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This in the V4 of the patch set which trys to fixed up numa_node for AMD hostbridges.
This topic was discussed in the following threads:

V1: https://lkml.org/lkml/2014/3/5/898
V2: https://lkml.org/lkml/2014/4/18/623
V3: https://lkml.org/lkml/2014/5/7/588

Change from V3:
Split up the changes in patch1 into two per Robert's suggestions. The second patch has 
no functional change. 

Change from V2:
As requested by Bjorn, the patch set will only add supports for family15h, and 
also deprecating the mechanism, as future platforms should be relying on the ACPI info.
He has also requested to keep the changes to the minimum. Therefore, the V2 patch 2 and 3
has been removed.

Suravee Suthikulpanit (2):
  Patch1: x86/PCI: Fix PCI root numa_node info on AMD family15h
  Patch2: x86/PCI: Clean up and mark early_root_info_init as deprecated

Myron Stowe (2):
  Patch3: ACPI/PCI: Warn if we have to "guess" host bridge node information
  Patch4: X86/PCI: Remove unnecessary 'quirk_amd_nb_node'

 arch/x86/kernel/quirks.c | 58 -------------------------------------
 arch/x86/pci/acpi.c      |  6 +++-
 arch/x86/pci/amd_bus.c   | 75 +++++++++++++++++++++++++++++-------------------
 3 files changed, 51 insertions(+), 88 deletions(-)

-- 
1.9.0

