Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:31927 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbaGDCmh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 22:42:37 -0400
Message-ID: <53B61494.5050904@huawei.com>
Date: Fri, 4 Jul 2014 10:42:28 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH 0/5] Cleanup for MSI
References: <1403166574-7032-1-git-send-email-wangyijing@huawei.com> <20140704000440.GD25980@google.com>
In-Reply-To: <20140704000440.GD25980@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/4 8:04, Bjorn Helgaas wrote:
> On Thu, Jun 19, 2014 at 04:29:34PM +0800, Yijing Wang wrote:
>>
>> Yijing Wang (5):
>>   PCI/MSI: Introduce msix_clear_and_set_ctrl() function
>>   PCI/MSI: Remove the unused function msi_enabled_mask()
>>   PCI/MSI: Cache Multiple Message Capable info in msi_desc
> 
> The above three look good, and I applied them to pci/msi for v3.17.  If you
> repost the others, please rebase them to that branch because I fixed some
> whitespace issues:
> 
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/msi

Bjorn, Thanks a lot!

> 
>>   PCI/MSI: MSI cleanup, msi_setup_entry()
>>   s390/MSI: Fix msi mask issue
>>
>>  arch/s390/pci/pci.c |    2 +-
>>  drivers/pci/msi.c   |  129 +++++++++++++++++++++++++--------------------------
>>  include/linux/msi.h |    1 +
>>  3 files changed, 65 insertions(+), 67 deletions(-)
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

