Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:61201 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbaKKVX7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 16:23:59 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn18so1786624igb.7
        for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2014 13:23:58 -0800 (PST)
Date: Tue, 11 Nov 2014 14:23:53 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	linux-s390@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 0/3] xen MSI code clean up
Message-ID: <20141111212353.GJ28161@google.com>
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Sebastian, linux-s390, David, Konrad, xen-devel]

On Mon, Oct 27, 2014 at 10:44:35AM +0800, Yijing Wang wrote:
> 
> Yijing Wang (3):
>   x86/xen: Introduce a global flag to fix the MSI mask bug
>   x86/xen: Revert "PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()"
>   s390/MSI: Use __msi_mask_irq() instead of default_msi_mask_irq()

I applied these with David's reviewed-by and ack to pci/msi for v3.19.

I'd like to see an ack from Sebastian for the s390 part, but I guess that
one is pretty trivial.

>  arch/s390/pci/pci.c             |    4 ++--
>  arch/x86/include/asm/x86_init.h |    3 ---
>  arch/x86/kernel/x86_init.c      |   10 ----------
>  arch/x86/pci/xen.c              |   15 +++------------
>  drivers/pci/msi.c               |   29 ++++++++++++-----------------
>  include/linux/msi.h             |    5 +++--
>  6 files changed, 20 insertions(+), 46 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
