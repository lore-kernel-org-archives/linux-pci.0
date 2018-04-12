Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:59978 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752389AbeDLRG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2018 13:06:28 -0400
From: <Alex_Gagniuc@Dellteam.com>
To: <keith.busch@intel.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>
CC: <scott.bauer@intel.com>
Subject: RE: [PATCH 0/4] PCI/AER: Use-after-free fix
Date: Thu, 12 Apr 2018 17:06:05 +0000
Message-ID: <a97b5921e5cf4855b5e76110a7984fdf@ausx13mps321.AMER.DELL.COM>
References: <20180409220444.6632-1-keith.busch@intel.com>
In-Reply-To: <20180409220444.6632-1-keith.busch@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Keith Busch [mailto:keith.busch@intel.com]=20

> AER error handling walks the PCI topology below a root port, saving point=
ers of the pci_dev structs affected by the error along the way.

Hi Keith,

I've been trying to do an ABA test to confirm that your change eliminates t=
he use-after-free issue we've seen. The race seems to be quite elusive, so =
I can't reliably reproduce it. Your changes have not been forgotten; I have=
 them staged for further testing.

Alex
