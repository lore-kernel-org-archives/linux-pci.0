Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58208 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbaGDAEn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 20:04:43 -0400
Received: by mail-ie0-f173.google.com with SMTP id at20so1017100iec.18
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2014 17:04:43 -0700 (PDT)
Date: Thu, 3 Jul 2014 18:04:40 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH 0/5] Cleanup for MSI
Message-ID: <20140704000440.GD25980@google.com>
References: <1403166574-7032-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403166574-7032-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 19, 2014 at 04:29:34PM +0800, Yijing Wang wrote:
> 
> Yijing Wang (5):
>   PCI/MSI: Introduce msix_clear_and_set_ctrl() function
>   PCI/MSI: Remove the unused function msi_enabled_mask()
>   PCI/MSI: Cache Multiple Message Capable info in msi_desc

The above three look good, and I applied them to pci/msi for v3.17.  If you
repost the others, please rebase them to that branch because I fixed some
whitespace issues:

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/msi

>   PCI/MSI: MSI cleanup, msi_setup_entry()
>   s390/MSI: Fix msi mask issue
> 
>  arch/s390/pci/pci.c |    2 +-
>  drivers/pci/msi.c   |  129 +++++++++++++++++++++++++--------------------------
>  include/linux/msi.h |    1 +
>  3 files changed, 65 insertions(+), 67 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
