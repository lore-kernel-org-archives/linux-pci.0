Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48154 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756969AbcAMLZh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jan 2016 06:25:37 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/4] PCI VPD access fixes
Date: Wed, 13 Jan 2016 12:25:31 +0100
Message-Id: <1452684335-46107-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

the current PCI VPD page access assumes that the entire possible VPD
data is readable. However, the spec only guarantees a VPD data up to
the 'end' marker, with everything beyond that being undefined.
This causes a system lockup on certain devices.

With this patch we always set the VPD sysfs attribute size to '0', and
calculate the available VPD size on the first access.
If no valid data can be read an I/O error is returned.

I've also included the patch from Babu to blacklists devices which
are known to lockup when accessing the VPD data.

Babu Moger (1):
  pci: Blacklist vpd access for buggy devices

Hannes Reinecke (3):
  pci: Update VPD definitions
  pci: allow access to VPD attributes with size '0'
  pci: Determine actual VPD size on first access

 drivers/pci/access.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci-sysfs.c | 22 ++++++++------
 drivers/pci/quirks.c    | 41 +++++++++++++++++++++++++
 include/linux/pci.h     | 27 +++++++++++++++--
 4 files changed, 157 insertions(+), 12 deletions(-)

-- 
1.8.5.6

