Return-Path: <SRS0=aFX3=FW=suse.de=jthumshirn@kernel.org>
Return-Path: <SRS0=aFX3=FW=suse.de=jthumshirn@kernel.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-pci@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 0/2] MCB Update for v4.17 
Date: Wed, 28 Feb 2018 09:44:16 +0100
Message-Id: <20180228084418.7566-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi Greg or Bjorn,

here's a small mcb update for the 4.17 window. The first patch makes
the PCI Vendor ID of Altera generally available in pci_ids.h and
removes it from the two private implementations before I would have to
add a 3rd one.

The 2nd patch adds the Altera's PCI vendor ID to the mcb pci driver
which enables at least one carrier board. This was reported and tested
by Ben Turner.

Bjorn asked me to Cc linux-pci@ in his response, so I'm not sure if he want's
to merge these two patches. I'm fine either way.

Thanks,
	Johannes

Changes to v1:
* Removed redundant pci_ids.h include

Johannes Thumshirn (2):
  PCI: add vendor id for Altera
  mcb: add Altera PCI ID to mcb-pci

 drivers/char/xillybus/xillybus_pcie.c | 1 -
 drivers/fpga/altera-cvp.c             | 2 --
 drivers/mcb/mcb-pci.c                 | 1 +
 include/linux/pci_ids.h               | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.13.6
