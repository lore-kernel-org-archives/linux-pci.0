Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14260 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387957AbeGWLh1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jul 2018 07:37:27 -0400
Message-ID: <e024134239091caf9684073887466df073ab1363.camel@linux.intel.com>
Subject: Documentation update wrt pci_release_regions()?
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Date: Mon, 23 Jul 2018 13:36:43 +0300
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

At some point I have stumbled over [1] which has a rightful confusion.
I tried to go through documentation we have and have no idea is that
behaviour have been fixed or not and if yes, in which kernel version.

Can we submit a patch against documentation to clarify the status of it?
Followup would be fix of hfi1 driver to drop confusion.

[1]: https://stackoverflow.com/questions/51163832/linux-pci-driver-setup
-and-teardown

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
