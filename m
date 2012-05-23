Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:49531 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab2EWEfC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 00:35:02 -0400
Received: by yhgm50 with SMTP id m50so980854yhg.1
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2012 21:35:01 -0700 (PDT)
Subject: [PATCH v6 0/2] PCI: acpiphp: remove multifunction devices
To: Amos Kong <kongjianjun@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, liuj97@gmail.com, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, kaneshige.kenji@jp.fujitsu.com
Date: Tue, 22 May 2012 22:35:01 -0600
Message-ID: <20120523043347.13449.1063.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's my proposal for fixing this problem.

I split out the pci_dev_put() for function 0 because it looks to me
like that is actually a separate issue -- it looks like we leaked
that reference even for single-function devices.

I restructured the iteration over bus->devices to make it read a bit
more naturally, and also to remove it from inside the slot->funcs
loop.  It didn't make sense to me to have a nested loop there.

The cleanup_p2p_bridge() stuff is mostly just fiddling with notify
handlers and other ACPI-specific stuff.  I don't think there's
actually a dependency there on the PCI device removal, so I think
it's safe to do that separately.

Does this make sense to you?  If so, can you test it and make sure
it actually works?

Thanks,
  Bjorn

---

Amos Kong (2):
      PCI: acpiphp: fix function 0 leak when disabling a slot
      PCI: acpiphp: remove all functions in slot, even without ACPI _EJx


 drivers/pci/hotplug/acpiphp_glue.c |   40 +++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 10 deletions(-)
