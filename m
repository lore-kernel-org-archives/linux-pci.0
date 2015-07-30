Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32776 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbG3VUb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 17:20:31 -0400
Received: by igbpg9 with SMTP id pg9so19666929igb.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2015 14:20:30 -0700 (PDT)
Date: Thu, 30 Jul 2015 16:20:26 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, rajatja@google.com, linux@roeck-us.net,
	rjw@rjwysocki.net
Subject: Re: [PATCH v2 0/2] Fix a deadlock for aer and pciehp driver
Message-ID: <20150730212026.GK9640@google.com>
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

Applied to pci/hotplug for v4.3 with changelogs as follows, thanks!

commit b37795cdcc42286f78711311943af38a615ea17c
Author: Yijing Wang <wangyijing@huawei.com>
Date:   Fri Jul 17 17:16:31 2015 +0800

    PCI: Protect pci_bus->slots with pci_slot_mutex, not pci_bus_sem
    
    Rajat Jain reported a deadlock when PCIe hot-add and AER recovery happen at
    the same time:
    
    thread 1:
    
      pciehp_enable_slot
        pciehp_configure_device
          pci_bus_add_devices
            pci_bus_add_device
              device_attach
                device_lock(dev)                       # acquire device lock
                ...
                pciehp_probe
                  init_slot
                    pci_hp_register
                      pci_create_slot
                        down_write(pci_bus_sem)        # deadlock here
    
    thread 2:
    
      aer_isr_one_error
        aer_process_err_device
          do_recovery
            broadcast_error_message(..., report_error_detected)
              pci_walk_bus(..., cb=report_error_detected, ...)
                down_read(&pci_bus_sem)                # acquire pci_bus_sem
                report_error_detected(dev)             # cb()
                  device_lock(dev)                     # deadlock here
    
    Previously, the bus->devices and bus->slots list were protected by
    pci_bus_sem.  In pci_create_slot(), we held it for writing so we could
    add to the bus->slots list.
    
    Add a new local pci_slot_mutex to protect bus->slots.  Hold pci_bus_sem for
    reading while searching the bus->devices list.
    
    [bhelgaas: changelog]
    Link: http://lkml.kernel.org/r/CAA93t1qpPqbih+UB0McA_d_+2rVaNkXsinAUxYzK9+JXSS+L-g@mail.gmail.com
    Reported-by: Rajat Jain <rajatja@google.com>
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Yijing Wang <wangyijing@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

commit 4ea786b8f6734a706bc4c2f84c2a2bbc77845487
Author: Yijing Wang <wangyijing@huawei.com>
Date:   Fri Jul 17 17:16:32 2015 +0800

    PCI: Hold pci_slot_mutex while searching bus->slots list
    
    Previously, pci_setup_device() and similar functions searched the
    pci_bus->slots list without any locking.  It was possible for another
    thread to update the list while we searched it.
    
    Add pci_dev_assign_slot() to search the list while holding pci_slot_mutex.
    
    [bhelgaas: changelog]
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Yijing Wang <wangyijing@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
