Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:63415 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbaGPU4a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 16:56:30 -0400
Received: by mail-ie0-f175.google.com with SMTP id x19so1448611ier.6
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 13:56:30 -0700 (PDT)
Date: Wed, 16 Jul 2014 14:56:27 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Wuyun <wuyun.wu@huawei.com>
Subject: Re: [PATCH v3 0/6] Cleanup for MSI
Message-ID: <20140716205627.GB14366@google.com>
References: <1404785221-6428-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404785221-6428-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 08, 2014 at 10:07:01AM +0800, Yijing Wang wrote:
> This patchset is based Bjorn's pci/msi branch.
> 
> v2->v3: Fix the misuse of MSI and MSIX default mask functions.
> 		Integrate "Use irq_get_msi_desc() to simplify code" into patchset.
> v1->v2: Modify msi_setup_entry() return type suggested by Bjorn.
> 		Post a new s390 MSI patch to fix and simplify MSI code.
> 		Post another 3 cleanup patch for MSI.
> 
> Yijing Wang (6):
>   PCI/MSI: MSI cleanup, msi_setup_entry()
>   s390/MSI: Use standard mask and unmask funtions
>   PCI/MSI: Remove unused function msi_remove_pci_irq_vectors()
>   PCI/MSI: Retrieve first MSI irq from msi_desc rather than pci_dev
>   PCI/MSI: Clean up the useless code
>   PCI/MSI: Use irq_get_msi_desc() to simplify code
> 
>  arch/s390/pci/pci.c |   49 ++++--------------------------
>  drivers/pci/msi.c   |   84 +++++++++++++++++++++++---------------------------
>  include/linux/pci.h |    2 -
>  3 files changed, 45 insertions(+), 90 deletions(-)

I applied these (except the s390 one, which Sebastian took) to pci/msi for
v3.17, thanks!

Bjorn
