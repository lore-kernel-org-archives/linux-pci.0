Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:59507 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaLQGOR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Dec 2014 01:14:17 -0500
Message-ID: <54911F32.1070909@huawei.com>
Date: Wed, 17 Dec 2014 14:14:10 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: ratheesh kannoth <ratheesh.ksz@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: sysfs-pci remove
References: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>	<5490D5CB.5010200@huawei.com>	<CAGZFCEFOiY+VmTVKOnPwDaKUKogUX9gkXtHuMATL3btw4kz2JQ@mail.gmail.com>	<549119A9.4010406@huawei.com> <CAGZFCEGF2Do4Kus+T_yg6-A1wNSXKr-RBm3eSC6Wuw02OMWTOQ@mail.gmail.com>
In-Reply-To: <CAGZFCEGF2Do4Kus+T_yg6-A1wNSXKr-RBm3eSC6Wuw02OMWTOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/12/17 14:08, ratheesh kannoth wrote:
> On Wed, Dec 17, 2014 at 11:20 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> If the device 06:0.0 was removed by "echo 1 > /sys/.../0000:6:0.0/remove",
>> you could not see lspci info for this device anymore.
>> Do you really remove the device ?
> 
> Oh , my bad. I did not remove the device. I did an unbind
> 
>  echo -n "0000:06:00.0" > /sys/bus/pci/drivers/enic/unbind0
> 
> Unbind wont remove it from /proc/iomem ? I thought enic pci driver is
> the one is calling ioremap on those memory ?

Unbind won't release PCI device bar resource, resources in /proc/iomem is the
physical address resource(added by request_resource()), if you iounmap the bar resource,
it won't change anything in /proc/iomem.

> 
> Thanks,
> Ratheesh
> 
> 


-- 
Thanks!
Yijing

