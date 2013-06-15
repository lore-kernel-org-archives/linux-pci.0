Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:45332 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab3FOAW2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2013 20:22:28 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so2590174ief.26
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2013 17:22:27 -0700 (PDT)
Date: Fri, 14 Jun 2013 18:22:24 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>,
	Tony Luck <tony.luck@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com
Subject: Re: [PATCH -v5 0/8] Add hostbridge resource release to support root
 bus hotplug in IA64
Message-ID: <20130615002224.GA21643@google.com>
References: <1370504093-14908-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370504093-14908-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 06, 2013 at 03:34:45PM +0800, Yijing Wang wrote:
> ...
> Jiang Liu (1):
>   PCI/IA64: fix memleak for create pci root bus fail
> 
> Yijing Wang (7):
>   PCI/IA64: SN: remove sn_pci_window_fixup()
>   PCI/IA64: SN: use normal resource instead of pci_window
>   PCI/IA64: embed pci hostbridge resources into pci_root_info
>   PCI/IA64: Allocate pci_root_info instead of using stack
>   PCI/IA64: add host bridge resource release for _CRS path
>   PCI/IA64: introduce probe_pci_root_info() to manage  _CRS resource
>   PCI: Replace printks with appropriate pr_*()
> 
>  arch/ia64/include/asm/pci.h   |   10 +-
>  arch/ia64/pci/pci.c           |  236 ++++++++++++++++++++++++++++-------------
>  arch/ia64/sn/kernel/io_init.c |  109 +++++--------------
>  3 files changed, 192 insertions(+), 163 deletions(-)

Tony, what do you think about this?  It only touches ia64, and I
have no way to build or test it.  So maybe you should handle this?

I haven't reviewed it, but I think it's the right general direction,
at least.

Bjorn
