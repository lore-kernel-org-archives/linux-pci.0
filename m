Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36998 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbHJT3K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 15:29:10 -0400
Received: by igbpg9 with SMTP id pg9so76430261igb.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 12:29:09 -0700 (PDT)
Date: Mon, 10 Aug 2015 14:29:06 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, rajatja@google.com, linux@roeck-us.net,
	rjw@rjwysocki.net
Subject: Re: [PATCH v2 0/2] Fix a deadlock for aer and pciehp driver
Message-ID: <20150810192906.GE32452@google.com>
References: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 05:16:30PM +0800, Yijing Wang wrote:
> Yijing Wang (2):
>   PCI: Use a local mutex instead of pci_bus_sem to avoid deadlock
>   PCI: Lock pci_slot_mutex when traverse bus->slots
> 
>  arch/powerpc/kernel/pci_of_scan.c |    6 +-----
>  arch/sparc/kernel/pci.c           |    6 +-----
>  drivers/pci/probe.c               |    6 +-----
>  drivers/pci/slot.c                |   26 +++++++++++++++++++++-----
>  include/linux/pci.h               |    4 +++-
>  5 files changed, 27 insertions(+), 21 deletions(-)
> 

I squashed the following fix from Yijing into the second patch to fix a
build issue:

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 214bf3f..b3ba7fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -798,7 +798,11 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
 				 struct hotplug_slot *hotplug);
 void pci_destroy_slot(struct pci_slot *slot);
+#ifdef CONFIG_SYSFS
 void pci_dev_assign_slot(struct pci_dev *dev);
+#else
+static inline void pci_dev_assign_slot(struct pci_dev *dev) { }
+#endif
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
