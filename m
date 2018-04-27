Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753079AbeD0Shr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 14:37:47 -0400
Date: Fri, 27 Apr 2018 13:37:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Frederick Lawler <fred@fredlawl.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: Re: [pci:pci/misc 2/2] drivers/infiniband//hw/hfi1/pcie.c:263:7:
 error: 'PCI_EXP_LNKSTA_CLS_8_0GT' undeclared; did you mean
 'PCI_EXP_LNKSTA_CLS_8_0GB'?
Message-ID: <20180427183743.GF8199@bhelgaas-glaptop.roam.corp.google.com>
References: <201804280224.jakvUcRr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201804280224.jakvUcRr%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 28, 2018 at 02:14:26AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
> head:   68e3ce09cb93f1a470b19816fa254b69480f246a
> commit: 68e3ce09cb93f1a470b19816fa254b69480f246a [2/2] IB/hfi1: Replace custom hfi1 macros with PCIe macros
> config: x86_64-randconfig-x001-201816 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 68e3ce09cb93f1a470b19816fa254b69480f246a
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/infiniband//hw/hfi1/pcie.c: In function 'extract_speed':
> >> drivers/infiniband//hw/hfi1/pcie.c:263:7: error: 'PCI_EXP_LNKSTA_CLS_8_0GT' undeclared (first use in this function); did you mean 'PCI_EXP_LNKSTA_CLS_8_0GB'?
>      case PCI_EXP_LNKSTA_CLS_8_0GT:
>           ^~~~~~~~~~~~~~~~~~~~~~~~
>           PCI_EXP_LNKSTA_CLS_8_0GB
>    drivers/infiniband//hw/hfi1/pcie.c:263:7: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/infiniband//hw/hfi1/pcie.c: In function 'pcie_speeds':
> >> drivers/infiniband//hw/hfi1/pcie.c:318:40: error: 'PCI_EXP_LNKCAP_SLS_8_0GT' undeclared (first use in this function); did you mean 'PCI_EXP_LNKCAP_SLS_8_0GB'?
>      if ((linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_8_0GT) {
>                                            ^~~~~~~~~~~~~~~~~~~~~~~~
>                                            PCI_EXP_LNKCAP_SLS_8_0GB

Sorry, my fault.  I fixed and even compiled it this time.
