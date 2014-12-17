Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:47798 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbaLQHgz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Dec 2014 02:36:55 -0500
Message-ID: <54913290.6070204@huawei.com>
Date: Wed, 17 Dec 2014 15:36:48 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: ratheesh kannoth <ratheesh.ksz@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: sysfs-pci remove
References: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>	<5490D5CB.5010200@huawei.com>	<CAGZFCEFOiY+VmTVKOnPwDaKUKogUX9gkXtHuMATL3btw4kz2JQ@mail.gmail.com>	<549119A9.4010406@huawei.com>	<CAGZFCEGF2Do4Kus+T_yg6-A1wNSXKr-RBm3eSC6Wuw02OMWTOQ@mail.gmail.com>	<54911F32.1070909@huawei.com> <CAGZFCEEFrLBbewsKmYVQGpnumeEY0Q7ZexrU+jydfyobuM7HTQ@mail.gmail.com>
In-Reply-To: <CAGZFCEEFrLBbewsKmYVQGpnumeEY0Q7ZexrU+jydfyobuM7HTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/12/17 14:21, ratheesh kannoth wrote:
> On Wed, Dec 17, 2014 at 11:44 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Unbind won't release PCI device bar resource, resources in /proc/iomem is the
>> physical address resource(added by request_resource()), if you iounmap the bar resource,
>> it won't change anything in /proc/iomem.
> 
> who is calling request_resource() ...is it enic driver ?

PCI core interface, E.g pci_bus_assign_resources()

> 
> Thanks,
> Ratheesh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

