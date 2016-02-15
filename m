Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47446 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbcBOImZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Feb 2016 03:42:25 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, Babu Moger <babu.moger@oracle.com>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/4] PCI VPD access fixes
Date: Mon, 15 Feb 2016 09:41:58 +0100
Message-Id: <1455525722-122040-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

the current PCI VPD page access assumes that the entire possible VPD
data is readable. However, the spec only guarantees a VPD data up to
the 'end' marker, with everything beyond that being undefined.
This causes a system lockup on certain devices.

With this patch we always set the VPD sysfs attribute size to '0', and
calculate the available VPD size on the first access.
If no valid data can be read an I/O error is returned.

I've also included the patch from Babu to blacklists devices which
are known to lockup when accessing the VPD data.

Changes to v2:
- Spelling fixes as suggested by Bjorn Helgaas
- Update to correct vpd size in pci_vpc_pci22_write
- Pass in modified VPD size to pci_vpd_pci22_size() to make
  quirk_brcm_570x_limit_vpd work

Babu Moger (1):
  pci: Blacklist vpd access for buggy devices

Hannes Reinecke (3):
  pci: Update VPD definitions
  pci: allow access to VPD attributes with size '0'
  pci: Determine actual VPD size on first access

 drivers/pci/access.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/pci/pci-sysfs.c | 22 +++++++------
 drivers/pci/quirks.c    | 43 +++++++++++++++++++++++++
 include/linux/pci.h     | 27 ++++++++++++++--
 4 files changed, 162 insertions(+), 14 deletions(-)

-- 
1.8.5.6

