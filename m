Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeFZVPD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jun 2018 17:15:03 -0400
Date: Tue, 26 Jun 2018 16:15:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: Re: [lkp-robot] [bisect done] ef1433f717 [    7.049860] BUG: unable
 to handle kernel NULL pointer dereference at 0000004c
Message-ID: <20180626211501.GC181504@bhelgaas-glaptop.roam.corp.google.com>
References: <20180626011007.GI11011@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180626011007.GI11011@yexl-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 26, 2018 at 09:10:07AM +0800, kernel test robot wrote:
> 
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit ef1433f717a2c63747a519d86965d73ff9bd08b3
> Author:     Kishon Vijay Abraham I <kishon@ti.com>
> AuthorDate: Mon Apr 2 18:59:35 2018 +0530
> Commit:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CommitDate: Fri May 18 16:40:50 2018 +0100
> 
>     PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
>     
>     In order to be able to provide correct driver_data for pci_epf device,
>     a separate configfs entry for each pci_epf_device_id table entry in
>     pci_epf_driver is required.
>     
>     Add support to create configfs entry for each pci_epf_device_id
>     table entry here.
>     
>     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>     Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

>From the .config below:

  # CONFIG_PCI_ENDPOINT_CONFIGFS is not set

>From include/linux/pci-ep-cfs.h:

  #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
  ...
  #else
  static inline struct config_group *pci_ep_cfs_add_epf_group(const char *name)
  {
        return 0;
  }

>From ef1433f717a2:

  +       id = driver->id_table;
  +       while (id->name[0]) {
  +               group = pci_ep_cfs_add_epf_group(id->name);
  +               mutex_lock(&pci_epf_mutex);
  +               list_add_tail(&group->group_entry, &driver->epf_group);

Obviously group == 0 and the list_add_tail() is a NULL pointer
dereference.

Looks like we need either some sort of #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
in __pci_epf_register_driver() and pci_epf_unregister_driver(), or
higher-level interfaces and corresponding stubs that add/remove all
the IDs.

Bjorn
