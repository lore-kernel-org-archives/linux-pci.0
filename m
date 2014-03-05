Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:43351
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755769AbaCEVHT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 16:07:19 -0500
From: <suravee.suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <aravind.gopalakrishnan@amd.com>,
	<kim.naru@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/3] amd/pci: Add AMD hostbridge supports for newer AMD systems
Date: Wed, 5 Mar 2014 15:06:40 -0600
Message-ID: <1394053603-3724-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The current code only supports upto AMD hostbridge for family11h.
This causes PCI numa_node information to be reported incorrectly
for newer family with multi sockets.

This patch set introduces the logic to discover AMD hostbridges.

Note: 
    * Patch 1 and 2 are functional changes.
    * Patch 3 is code clean up/restructuring

Suravee Suthikulpanit (3):
  amd/pci: Add supports for generic AMD hostbridges
  amd/pci: Support additional MMIO ranges capabilities
  amd/pci: Miscellaneous code clean up for early_fillup_mp_bus_info

 arch/x86/pci/amd_bus.c |  376 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 251 insertions(+), 125 deletions(-)

-- 
1.7.10.4


