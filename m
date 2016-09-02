Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [RFCv2 0/3] vmd irq list shortening, map allocation
Date: Fri,  2 Sep 2016 11:53:03 -0600
Message-Id: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

V2:
Added a map for vmd irqs to attempt to allocate all vmd irqs within an
irq list into a single page. Once we start getting many devices
sharing the irq in an irq list, this may help the list traversal latency.

V1:
Couple of RFC patches here. I don't really notice a positive benefit but
it does reduce the struct size of vmd_irq_list and hopefully we gain some
cache benefits from that.

Both are based on:
https://patchwork.kernel.org/patch/9304179/
https://patchwork.kernel.org/patch/9304181/

Jon Derrick (3):
  vmd: eliminate vmd_vector member from list type
  vmd: eliminate index member from irq list
  pci/vmd: Create irq map for irq nodes

 arch/x86/pci/vmd.c | 94 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 21 deletions(-)

-- 
1.8.3.1
