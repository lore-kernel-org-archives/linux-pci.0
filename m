Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbdHPQwp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 12:52:45 -0400
Date: Wed, 16 Aug 2017 11:52:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Paul Burton <paul.burton@imgtec.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:pci/host-xilinx 1/7] include/linux/pci-epf.h:53:25: error:
 field 'interrupt_pin' has incomplete type
Message-ID: <20170816165243.GB28977@bhelgaas-glaptop.roam.corp.google.com>
References: <201708160641.ZKA3UsJg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201708160641.ZKA3UsJg%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 16, 2017 at 06:11:45AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-xilinx
> head:   95b008920fd38e828a37c8a7131b449d33ba03b9
> commit: 13ff772beae556a664c029d5d75eaf7f3c104258 [1/7] PCI: Move enum pci_interrupt_pin to linux/pci.h
> config: blackfin-allyesconfig (attached as .config)
> compiler: bfin-uclinux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 13ff772beae556a664c029d5d75eaf7f3c104258
>         # save the attached .config to linux build tree
>         make.cross ARCH=blackfin 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/pci-epc.h:15:0,
>                     from drivers/pci/endpoint/pci-ep-cfs.c:23:
> >> include/linux/pci-epf.h:53:25: error: field 'interrupt_pin' has incomplete type
>      enum pci_interrupt_pin interrupt_pin;

I think the problem with this (and the similar m68k report) is that
enum pci_interrupt_pin was originally defined unconditionally in
include/linux/pci-epf.h, but after "PCI: Move enum pci_interrupt_pin
to linux/pci.h", it was defined in include/linux/pci.h under #ifdef
CONFIG_PCI.  Neither this blackfin config nor the m68k config defines
CONFIG_PCI.

CONFIG_PCI enables the host side of the PCI core, e.g., host bridge
infrastructure, device enumeration, etc.  It is possible to build
endpoint support without that, and pci_interrupt_pin is still useful
there.

I reworked the patch to define enum pci_interrupt_pin outside the
#ifdef CONFIG_PCI.

Bjorn
