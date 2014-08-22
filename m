Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:53575 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbaHVHpi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 03:45:38 -0400
Message-ID: <53F6F500.1060700@huawei.com>
Date: Fri, 22 Aug 2014 15:45:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] Some MSI cleanup
References: <1408072451-9853-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1408072451-9853-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/8/15 11:14, Yijing Wang wrote:
> 

Hi Bjorn, please drop this series, I have sent a new version.

> Yijing Wang (3):
>   MSI: Use __get_cached_msi_msg() instead of get_cached_msi_msg()
>   MSI: Use __read_msi_msg() instead of read_msi_msg()
>   xen/MSI: Retrieve MSI msg from cached msi_desc->msg
> 
>  arch/ia64/kernel/msi_ia64.c          |    2 +-
>  arch/ia64/sn/kernel/msi_sn.c         |    4 ++--
>  arch/powerpc/platforms/pseries/msi.c |    2 +-
>  arch/x86/kernel/apic/io_apic.c       |    2 +-
>  arch/x86/pci/xen.c                   |    2 +-
>  drivers/pci/msi.c                    |   18 ++----------------
>  include/linux/msi.h                  |    6 ++----
>  7 files changed, 10 insertions(+), 26 deletions(-)
> 
> 
> .
> 


-- 
Thanks!
Yijing

