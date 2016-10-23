Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:53035 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbcJWLzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Oct 2016 07:55:39 -0400
Message-Id: <cover.1477221514.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 23 Oct 2016 13:55:34 +0200
Subject: [PATCH v3 0/1] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ingo,

please consider merging the following patch to x86/urgent for v4.9-rc3,
it fixes a regression (boot failure) of Intel Mobile Internet Devices
due to a change in the PCI subsystem that appeared in v4.9-rc1.

The patch is marked v3 but in fact it's identical to v2 except now it's
rebased on today's tip.git master branch, has acks by Bjorn and Andy
plus a Fixes tag.  I also polished the commit message a bit.

Thanks!

Lukas


Lukas Wunner (1):
  x86/platform/intel-mid: Retrofit pci_platform_pm_ops ->get_state hook

 arch/x86/include/asm/intel-mid.h  |  1 +
 arch/x86/platform/intel-mid/pwr.c | 19 +++++++++++++++++++
 drivers/pci/pci-mid.c             |  6 ++++++
 3 files changed, 26 insertions(+)

-- 
2.9.3

