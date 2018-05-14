Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeENTXa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 May 2018 15:23:30 -0400
Date: Mon, 14 May 2018 14:23:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [pci:pci/resource 4/10] drivers/pci/of.c:315:4: error: label
 'parse_failed' used but not defined
Message-ID: <20180514192328.GB211882@bhelgaas-glaptop.roam.corp.google.com>
References: <201805150308.ICM6rKP0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805150308.ICM6rKP0%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 15, 2018 at 03:00:10AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
> head:   4704207c075cd99a51e58ef75c185652b17fadd8
> commit: 3f3e689a67ba3d0ac2d10fd3b99c1bd0331415be [4/10] PCI: Use devm_kzalloc() in of_pci_get_host_bridge_resources() path
> config: x86_64-randconfig-x002-201819 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 3f3e689a67ba3d0ac2d10fd3b99c1bd0331415be
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: the pci/pci/resource HEAD 4704207c075cd99a51e58ef75c185652b17fadd8 builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/of.c: In function '__of_pci_get_host_bridge_resources':
> >> drivers/pci/of.c:315:4: error: label 'parse_failed' used but not defined
>        goto parse_failed;
>        ^~~~

I tried to fold your fixes patch
(https://lkml.kernel.org/r/294ff38c-f8df-f89b-3bac-604e79fe6cfe@siemens.com)
into the relevant patches, but I didn't do it quite right.

I think this whole thing could be avoided if you restructured the patches
slightly.  What if you:

  - renamed the of_pci_get_host_bridge_resources() "struct device_node
    *dev" parameter to "struct device_node *dev_node" without refactoring
    anything,

  - added the "struct device *dev" parameter to
    of_pci_get_host_bridge_resources() and all callers,

  - renamed of_pci_get_host_bridge_resources() to
    devm_of_pci_get_host_bridge_resources() and converted it to use
    devm_kzalloc() internally, and

  - converted pr_info() to dev_info().

It looks like there aren't any in-tree users that depend on the
compatibility wrappers, and I think the patches would end up being easier
to read without the refactoring and the wrappers.  
