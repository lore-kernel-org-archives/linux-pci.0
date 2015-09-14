Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33946 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833AbbINDF7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 13 Sep 2015 23:05:59 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org
Subject: [Bugfix 0/3] Convert eata driver to a normal PCI device driver
Date: Mon, 14 Sep 2015 11:08:56 +0800
Message-Id: <1442200140-30808-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <CAErSpo4oignSpK-LCLO=deW_FZ-V58GUhBxJ5uvmXe4DYo4WdA@mail.gmail.com>
References: <CAErSpo4oignSpK-LCLO=deW_FZ-V58GUhBxJ5uvmXe4DYo4WdA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Authur,
	As suggested by Bjorn, patch 1-2 set implement a PCI device
driver to manage eata PCI devices. And patch 3 tries to support PCI
device hot-removal for eata, but I have no change to test due to 
limited knowledge about scsi subsystem and lacking of hardware for
tests.
	So you could please help to test patch 1-2? Patch 3 is just
for comments.
Thanks!
Gerry

Jiang Liu (3):
  eata: Use IDA to manage eata board IDs
  eata: Implement PCI driver to manage eata PCI devices
  eata: Enhance eata driver to support PCI device hot-removal

 drivers/scsi/eata.c |  232 +++++++++++++++++++++++++++------------------------
 1 file changed, 125 insertions(+), 107 deletions(-)

-- 
1.7.10.4

