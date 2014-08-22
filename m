Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:54334 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaHVHqs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 03:46:48 -0400
Message-ID: <53F6F558.8060308@huawei.com>
Date: Fri, 22 Aug 2014 15:46:32 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] trivial changes for MSI
References: <1406339316-20163-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1406339316-20163-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/26 9:48, wangyijing@huawei.com wrote:
> From: Yijing Wang <wangyijing@huawei.com>

Hi Bjorn, please drop this one, I have sent new version.

Thanks!
Yijing.

> 
> Yijing Wang (3):
>   PCI/MSI: Clean up the kobject in struct msi_desc
>   PCI/MSI: Remove msi_desc->msi_attrib.pos
>   PCI/MSI: Refactor msi_bus to support EP enable/disable MSI
> 
>  arch/mips/pci/msi-octeon.c         |    6 +++---
>  drivers/pci/host/pcie-designware.c |    2 +-
>  drivers/pci/msi.c                  |   13 -------------
>  drivers/pci/pci-sysfs.c            |   12 ++++++------
>  include/linux/msi.h                |    3 ---
>  5 files changed, 10 insertions(+), 26 deletions(-)
> 
> 
> .
> 


-- 
Thanks!
Yijing

