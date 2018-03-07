Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932759AbeCGReG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 12:34:06 -0500
Date: Wed, 7 Mar 2018 11:34:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:next 34/50] drivers/pci/probe.c:1465:19: error: 'struct
 pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
Message-ID: <20180307173405.GA210610@bhelgaas-glaptop.roam.corp.google.com>
References: <201803080015.CzPERYDN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201803080015.CzPERYDN%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 08, 2018 at 12:57:16AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> head:   36e218fd55522ccfd4463fbf57909353e58280bd
> commit: 25210702e2122f42f6b2f44e0446e819d44bf113 [34/50] PCI/IOV: Use VF0 cached config registers for other VFs
> config: x86_64-randconfig-x017-201809 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 25210702e2122f42f6b2f44e0446e819d44bf113
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/probe.c: In function 'pci_setup_device':
> >> drivers/pci/probe.c:1465:19: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
>       hdr_type = dev->physfn->sriov->hdr_type;
>                       ^~~~~~
>                       is_physfn

Oops, my fault, I forgot to wait for the robot to build this patch.

"dev->physfn" only exists if CONFIG_PCI_ATS is defined (probably
should be CONFIG_PCI_IOV, but that's a separate question).  The
attached config doesn't define either.

KarimAllah, can you update this so it builds without CONFIG_PCI_ATS?
It'll be sort of annoying to have to clutter that code with #ifdefs;
maybe you can figure out a nicer solution.

I dropped this patch from "next" for now.

Bjorn
