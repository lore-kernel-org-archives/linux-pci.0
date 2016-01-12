Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] PCI VPD access fixes
Date: Tue, 12 Jan 2016 15:42:27 +0100
Message-Id: <1452609750-90760-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

the current PCI VPD page access assumes that the entire possible VPD
data is readable. However, the spec only guarantees a VPD data up to
the 'end' marker, with everything beyond that being undefined.
This causes a system lockup on certain devices.

With this patch we calculate the actual VPD size, or set it to '0'
if no valid VPD data could be read.

Hannes Reinecke (3):
  pci: Update VPD definitions
  pci: Update VPD size with correct length
  pci: set VPD size to '0' if PCI_VPD_FLAGS_VPD_REF_F0 is set

 drivers/pci/access.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci-sysfs.c | 20 +++++++++------
 include/linux/pci.h     | 27 ++++++++++++++++++--
 3 files changed, 104 insertions(+), 11 deletions(-)

-- 
1.8.5.6
