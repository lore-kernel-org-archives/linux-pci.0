Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbeERVDf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 May 2018 17:03:35 -0400
Date: Fri, 18 May 2018 16:03:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [pci:next 15/20] drivers/pci/host/pcie-altera.c:496:53: sparse:
 incompatible types for operation (&)
Message-ID: <20180518210332.GC41790@bhelgaas-glaptop.roam.corp.google.com>
References: <201805190321.nss6j8Jn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805190321.nss6j8Jn%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 19, 2018 at 03:42:27AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> head:   f8d3ac43d8cd4cfba337a50794c26c7ca89d86ac
> commit: 927da40afdbd6a5fdd31eab6e9aa655dee1f99a4 [15/20] Merge branch 'lorenzo/pci/host/misc'
> reproduce:
>         # apt-get install sparse
>         git checkout 927da40afdbd6a5fdd31eab6e9aa655dee1f99a4
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/pci/host/pcie-altera.c:496:53: sparse: incompatible types for operation (&)

I think I fixed this; it was missing a comma at the end of the first line:

        err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff
                                                    &pcie->resources, NULL);

This error was in the original patch, so I'm not sure if I forgot to push
the pci/resource branch or if kbuild didn't test it for some reason.

>    /kbuild/src/sparse/drivers/pci/host/pcie-rockchip-host.c:996:15: sparse: undefined identifier 'devm_of_pci_get_host_bridge_resources'

I'm confused about this one because pcie-rockchip-host.c doesn't even exist
in 927da40afdbd, so the steps to reproduce must not be quite right.

But I'm sure I screwed up a conflict resolution somewhere, so I'll find that,
too.

Bjorn
