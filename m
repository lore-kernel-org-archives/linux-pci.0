Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gh0-f202.google.com ([209.85.160.202]:46142 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab2GISUO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2012 14:20:14 -0400
Received: by ghbz15 with SMTP id z15so1221355ghb.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jul 2012 11:20:13 -0700 (PDT)
Subject: [PATCH 0/2] PCI: decode disable fixes
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matthew Wilcox <matthew.r.wilcox@intel.com>,
	Robert Hancock <hancockrwd@gmail.com>
Date: Mon, 09 Jul 2012 12:20:12 -0600
Message-ID: <20120709181745.18165.93914.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since 2.6.36 (253d2e5498), we've disabled MEM & IO decoding while we size
BARs (except for host bridge devices).  These patches tweak this in two
ways:

1) We only kept decoding disabled while sizing the low-order dword
of 64-bit BARs.  I think we should keep it disabled while we do the
high-order dword also.

2) I think we should also disable decoding while updating 64-bit BARs,
e.g., when we move a device into an aperture of an upstream bridge.  I'm
only proposing to disable decoding for 64-bit BAR updates because 32-bit
ones can be done atomically, while 64-bit updates require two writes and
the half-written state is a potential problem.

I'm considering these changes for the 3.6 merge window, which is
approaching fast, so let me know if you see issues with either of these.

---

Bjorn Helgaas (2):
      PCI: leave MEM and IO decoding disabled during 64-bit BAR sizing, too
      PCI: disable MEM decoding while updating 64-bit MEM BARs


 drivers/pci/probe.c     |    6 +++---
 drivers/pci/setup-res.c |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
Bjorn
