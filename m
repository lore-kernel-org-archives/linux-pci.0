Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932131AbeARW4B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jan 2018 17:56:01 -0500
Date: Thu, 18 Jan 2018 16:55:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Frederick Lawler <fred@fredlawl.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:pci/misc 10/10] drivers/pci/pcie/aer/aerdrv_core.c:229:3:
 error: implicit declaration of function 'pci_printk'; did you mean
 'pci_intx'?
Message-ID: <20180118225501.GA160618@bhelgaas-glaptop.roam.corp.google.com>
References: <201801190308.UxduwqBp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201801190308.UxduwqBp%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 03:18:10AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
> head:   ba8d362b6d084433dd311c13de5fd2dba1c90b93
> commit: ba8d362b6d084433dd311c13de5fd2dba1c90b93 [10/10] PCI: Add wrappers for dev_printk()
> config: i386-randconfig-x015-201802 (attached as .config)
> compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
> reproduce:
>         git checkout ba8d362b6d084433dd311c13de5fd2dba1c90b93
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/pcie/aer/aerdrv_core.c: In function 'find_source_device':
> >> drivers/pci/pcie/aer/aerdrv_core.c:229:3: error: implicit declaration of function 'pci_printk'; did you mean 'pci_intx'? [-Werror=implicit-function-declaration]
>       pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
>       ^~~~~~~~~~

Sorry, my fault again.  I screwed up the grep and concluded that
pci_printk wasn't actually used, so I removed it.  Obviously it *is*
used.  I added it back and repushed the branch.
