Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38852 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbbIWTMU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 15:12:20 -0400
Subject: [PATCH 1/2] PCI: Clear IORESOURCE_UNSET when clipping a bridge
 window
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <helgaas@kernel.org>
Cc: kordikmarek@gmail.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	airlied@linux.ie, zermond@gmail.com, gob_iron@hotmail.com,
	weiyang.kernel@gmail.com, alexander.deucher@amd.com,
	niaminbox@gmail.com, Yinghai Lu <yinghai@kernel.org>
Date: Wed, 23 Sep 2015 14:12:16 -0500
Message-ID: <20150923191216.21781.33925.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150923191159.21781.66169.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150923191159.21781.66169.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") sets IORESOURCE_UNSET
if we fail to claim a resource.  If we tried to claim a bridge window,
failed, clipped the window, and tried to claim the clipped window, we
failed again because of IORESOURCE_UNSET:

  pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
  pci 0000:00:01.0: can't claim BAR 15 [mem 0xbdf00000-0xddefffff 64bit pref]: no compatible bridge window
  pci 0000:00:01.0: [mem size 0x20000000 64bit pref] clipped to [mem size 0x1df00000 64bit pref]
  pci 0000:00:01.0:   bridge window [mem size 0x1df00000 64bit pref]
  pci 0000:00:01.0: can't claim BAR 15 [mem size 0x1df00000 64bit pref]: no address assigned

The 00:01.0 window started as [mem 0xbdf00000-0xddefffff 64bit pref].  That
starts before the host bridge window [mem 0xc0000000-0xffffffff window], so
we clipped the 00:01.0 window to [mem 0xc0000000-0xddefffff 64bit pref].
But we left it marked IORESOURCE_UNSET, so the second claim failed when it
should have succeeded.

This means downstream devices will also fail for lack of resources, e.g.,
in the bugzilla below,

  radeon 0000:01:00.0: Fatal error during GPU init

Clear IORESOURCE_UNSET when we clip a bridge window.  Also clear
IORESOURCE_UNSET in our copy of the unclipped window so we can see exactly
what the original window was and how it now fits inside the upstream
window.

Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491#c47
Based-on-patch-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Based-on-patch-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Yinghai Lu <yinghai@kernel.org>
CC: stable@vger.kernel.org	# 4.1+
---
 drivers/pci/bus.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6fbd3f2..d3346d2 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -256,6 +256,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 		res->start = start;
 		res->end = end;
+		res->flags &= ~IORESOURCE_UNSET;
+		orig_res.flags &= ~IORESOURCE_UNSET;
 		dev_printk(KERN_DEBUG, &dev->dev, "%pR clipped to %pR\n",
 				 &orig_res, res);
 

