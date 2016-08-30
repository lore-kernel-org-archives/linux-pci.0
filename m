Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [RFC 0/2] vmd list item shortening
Date: Tue, 30 Aug 2016 15:04:55 -0600
Message-Id: <1472591097-19712-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Couple of RFC patches here. I don't really notice a positive benefit but
it does reduce the struct size of vmd_irq_list and hopefully we gain some
cache benefits from that.

Both are based on:
https://patchwork.kernel.org/patch/9304179/
https://patchwork.kernel.org/patch/9304181/

Jon Derrick (2):
  vmd: eliminate vmd_vector member from list type
  vmd: eliminate index member from irq list

 arch/x86/pci/vmd.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
1.8.3.1
