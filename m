Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40933 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758320AbcCaWe1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Mar 2016 18:34:27 -0400
Subject: [PATCH 0/2] PCI: Skylake PCH ACS quirks
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org
Date: Thu, 31 Mar 2016 16:34:26 -0600
Message-ID: <20160331222828.20486.30979.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel Skylake systems attempted to implement ACS on the PCH root
ports, but it came out a wee bit off.  As noted in the second patch
and the datasheets from Intel, dwords were used for the ACS
capability and control words, so we see the capabilities correctly
but the control register is an extra 2 bytes offset.  With this
quirk we can fix the kernel, unfortunately lspci will still show
the wrong ACS control bits though.  Thanks,

Alex

---

Alex Williamson (2):
      PCI: Reverse standard ACS vs device specific ACS enabling
      PCI: Quirk PCH root port ACS for Sunrise Point


 drivers/pci/pci.c    |   10 ++----
 drivers/pci/quirks.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h  |    7 +++-
 3 files changed, 91 insertions(+), 10 deletions(-)
