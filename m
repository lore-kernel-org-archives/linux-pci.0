Return-Path: <SRS0=rB3A=LN=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=rB3A=LN=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Keith Busch <keith.busch@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sinan Kaya <okaya@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Stephen Bates <sbates@raithlin.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2] PCI hotplug Eq v2
Date: Thu, 30 Aug 2018 16:11:59 -0600
Message-Id: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Sorry for the delay on this one and pushing it after RC1.
Feel free to queue it up for 4.20 if it looks fine.

I've added comments to the git log and source explaining why calculate_iosize
was left unchanged. Basically I could not synthesize a condition where it would
have affected the topology.

v1->v2: Comments

Jon Derrick (1):
  PCI: Equalize hotplug memory for non/occupied slots

 drivers/pci/setup-bus.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
1.8.3.1
