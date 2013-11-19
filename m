Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49735 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab3KSWyh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 17:54:37 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so2593655pbc.33
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 14:54:37 -0800 (PST)
Received: from [192.168.211.134] ([66.129.239.13])
        by mx.google.com with ESMTPSA id g8sm19718656pbe.37.2013.11.19.14.54.35
        for <linux-pci@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 19 Nov 2013 14:54:36 -0800 (PST)
Message-ID: <528BEC2B.4040208@gmail.com>
Date: Tue, 19 Nov 2013 14:54:35 -0800
From: Rajat Jain <rajatjain.linux@gmail.com>
MIME-Version: 1.0
To: Linux-PCI <linux-pci@vger.kernel.org>
Subject: test mail 9
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hello,

This patch set enables the use of PCI Express link up and link down events
for Hotplug or Unplug. The requirement of such a feature was originally
discussed here:

http://www.spinics.net/lists/linux-pci/msg05783.html
http://www.spinics.net/lists/hotplug/msg05801.html

Patch [1/4]: makes a function non-static for use by patch 2.
Patch [2/4]: Contains the bulk logic to allow link events to be used
             for hotplug and removal.
Patch [3/4]: Makes the pciehp_power_thread() lock free by making it
             look at a work info->req instead of slot->state.
Patch [4/4]: Introduce slot->hotplug_lock to serialize the hotplug
             operations.

I'd appreciate if you could please review and provide me with any comments.

Thanks,

Rajat

Rajat Jain (4):
  pciehp: Make check_link_active() non-static
  pciehp: Use link state change notifications for hot-plug and removal
  pciehp: Ensure all hotplug events are processed, even very fast ones.
  pciehp: Introduce hotplug_lock to serialize HP events on each slot

 drivers/pci/hotplug/pciehp.h      |    6 ++
 drivers/pci/hotplug/pciehp_core.c |   10 +-
 drivers/pci/hotplug/pciehp_ctrl.c |  181 ++++++++++++++++++++++++++++++++++---
 drivers/pci/hotplug/pciehp_hpc.c  |   63 +++++++++----
 4 files changed, 229 insertions(+), 31 deletions(-)

-- 
1.7.9.5

