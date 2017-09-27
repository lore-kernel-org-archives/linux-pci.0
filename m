Return-Path: <SRS0=Xovj=A4=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=Xovj=A4=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Alan Cox <alan@linux.intel.com>,
	Dan J Williams <dan.j.williams@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 0/3] Introduce PCI device blacklisting
Date: Wed, 27 Sep 2017 16:40:19 -0400
Message-Id: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

This set introduces a method to keep devices from matching driver id
tables.

Please see 0001 for more details of the motivation and implementation.

This set currently applies to Bjorn's next (v4.14-rc1) branch.


Jon Derrick (3):
  PCI: pci-driver: Introduce pci device delete list
  module: Ignore delete_id parameter
  Documentation: Add pci device delete_id interface

 Documentation/admin-guide/kernel-parameters.txt |  13 ++
 drivers/pci/pci-driver.c                        | 253 +++++++++++++++++++++++-
 include/linux/pci.h                             |   1 +
 kernel/module.c                                 |   7 +
 4 files changed, 272 insertions(+), 2 deletions(-)

-- 
1.8.3.1
