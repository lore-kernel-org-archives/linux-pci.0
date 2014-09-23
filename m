Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57329 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbaIWSMj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 14:12:39 -0400
Received: by mail-ie0-f181.google.com with SMTP id tr6so9621132ieb.26
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2014 11:12:38 -0700 (PDT)
Date: Tue, 23 Sep 2014 12:12:36 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Some cleanup for MSI code
Message-ID: <20140923181236.GB6776@google.com>
References: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 23, 2014 at 01:27:21PM +0800, Yijing Wang wrote:
> v2->v3: Split into several patches for better readability.
>         Add document description for msi_bus attribute in 
> 		Documentation/ABI/testing/sysfs-bus-pci.
> v1->v2: Rebased it on 3.17-rc1, and dropped a incorrect patch.
> 
> Yijing Wang (9):
>   PCI/MSI: Clean up the kobject in struct msi_desc
>   PCI/MSI: Remove msi_attrib->pos in struct msi_desc
>   PCI/MSI: Change msi_bus attribute to support enable/disable MSI for
>     EP
>   MSI: Use __get_cached_msi_msg() instead of get_cached_msi_msg()
>   PCI/MSI: Remove unused function get_cached_msi_msg()
>   PCI/MSI: Rename __get_cached_msi_msg() to get_cached_msi_msg()
>   MSI/powerpc: Use __read_msi_msg() instead of read_msi_msg()
>   PCI/MSI: Remove unused function read_msi_msg()
>   PCI/MSI: Rename __read_msi_msg() to read_msi_msg()
> 
>  Documentation/ABI/testing/sysfs-bus-pci |    9 +++++++++
>  arch/ia64/kernel/msi_ia64.c             |    2 +-
>  arch/ia64/sn/kernel/msi_sn.c            |    4 ++--
>  arch/mips/pci/msi-octeon.c              |    6 +++---
>  arch/powerpc/platforms/pseries/msi.c    |    2 +-
>  arch/x86/kernel/apic/io_apic.c          |    2 +-
>  arch/x86/pci/xen.c                      |    2 +-
>  drivers/pci/host/pcie-designware.c      |    2 +-
>  drivers/pci/msi.c                       |   31 ++-----------------------------
>  drivers/pci/pci-sysfs.c                 |   12 ++++++------
>  include/linux/msi.h                     |    9 ++-------
>  11 files changed, 29 insertions(+), 52 deletions(-)

Nice cleanups.  I applied them all to pci/msi for v3.18, thanks!

Let me know if you see issues with any of the tweaks I made.

Bjorn
