Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:48447 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaLQFup (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Dec 2014 00:50:45 -0500
Message-ID: <549119A9.4010406@huawei.com>
Date: Wed, 17 Dec 2014 13:50:33 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: ratheesh kannoth <ratheesh.ksz@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: sysfs-pci remove
References: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>	<5490D5CB.5010200@huawei.com> <CAGZFCEFOiY+VmTVKOnPwDaKUKogUX9gkXtHuMATL3btw4kz2JQ@mail.gmail.com>
In-Reply-To: <CAGZFCEFOiY+VmTVKOnPwDaKUKogUX9gkXtHuMATL3btw4kz2JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/12/17 13:21, ratheesh kannoth wrote:
> I could see the pci resource in /proc/iomem.
> 
> But , lspci -s 06:0.0 -vv  shows that there is no kernel mode driver
> for that interface.

If the device 06:0.0 was removed by "echo 1 > /sys/.../0000:6:0.0/remove",
you could not see lspci info for this device anymore.
Do you really remove the device ?

> 
> 
> On Wed, Dec 17, 2014 at 6:30 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> On 2014/12/17 1:51, ratheesh kannoth wrote:
>>> Hi list,
>>>
>>> https://www.kernel.org/doc/Documentation/filesystems/sysfs-pci.txt
>>> talks about "remove" entry.
>>> The 'remove' file is used to remove the PCI device, by writing a non-zero
>>> integer to the file.  if i remove the device , will the bar resource
>>> map still appear on /proc/iomem ?
>>
>> Of course not.
>>
>>>
>>>
>>> -Ratheesh
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>>
>> --
>> Thanks!
>> Yijing
>>
> 
> 


-- 
Thanks!
Yijing

