Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47679 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751017AbdIKHpt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Sep 2017 03:45:49 -0400
From: Nicolai Stange <nstange@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 0/3] make PCI's and platform's driver_override_store()/show() converge
Date: Mon, 11 Sep 2017 09:45:39 +0200
Message-Id: <20170911074542.16777-1-nstange@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

both, drivers/pci/pci-sysfs.c and drivers/base/platform.c implement
a driver_override_store/show() pair which used to coincide between these
two subsystems (up to ->driver_override's storage location).

Now, both have received a fix in the meanwhile which the other subsystem
lacks each:
  commit 6265539776a0 ("driver core: platform: fix race condition with
                        driver_override")
and
  commit 4efe874aace5 ("PCI: Don't read past the end of sysfs
                       "driver_override" buffer")

Port the missing fix to the other subsystem each.

There's also the style fixup [2/3] which isn't strictly needed but
will make both driver_override_show() variants look the same again.

Applies to next-20170908.

Note that checkpatch complains about commit references to the PCI commit
mentioned above, which is, as I believe, a false positive due to the
quotation marks in the title.

Thanks,

Nicolai

Nicolai Stange (3):
  PCI: fix race condition with driver_override
  PCI: don't use snprintf() in driver_override_show()
  driver core: platform: Don't read past the end of "driver_override"
    buffer

 drivers/base/platform.c |  3 ++-
 drivers/pci/pci-sysfs.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.13.5
