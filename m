Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:16366
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751282AbaEGS67 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 May 2014 14:58:59 -0400
From: <suravee.suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
	Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>,
	Borislav Petkov <bp@suse.de>,
	"Robert Richter" <rric@kernel.org>,
	Daniel J Blueman <daniel@numascale.com>,
	Andreas Herrmann <herrmann.der.user@googlemail.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V3 0/3] x86/pci Fix numa_node info for AMD hostbridge and misc clean up.
Date: Wed, 7 May 2014 13:58:44 -0500
Message-ID: <1399489127-6961-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This in the V3 of the patch set which trys to fixed up numa_node for AMD hostbridges.
This topic was discussed in the following threads:

V1: https://lkml.org/lkml/2014/3/5/898
V2: https://lkml.org/lkml/2014/4/18/623

Change from V2:
As requested by Bjorn, the patch set will only add supports for family15h, and 
also deprecating the mechanism, as future platforms should be relying on the ACPI info.
He has also requested to keep the changes to the minimum. Therefore, the V2 patch 2 and 3
has been removed.

Myron Stowe (2):
  ACPI/PCI: Warn if we have to "guess" host bridge node information
  PCI: Remove unnecessary 'quirk_amd_nb_node'

Suravee Suthikulpanit (1):
  x86/PCI: Fix PCI root numa_node info on AMD family15h

 arch/x86/kernel/quirks.c | 58 -------------------------------------
 arch/x86/pci/acpi.c      |  6 +++-
 arch/x86/pci/amd_bus.c   | 75 +++++++++++++++++++++++++++++-------------------
 3 files changed, 51 insertions(+), 88 deletions(-)

-- 
1.9.0

