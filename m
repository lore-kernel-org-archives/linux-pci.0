Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:64896 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaLQFVY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Dec 2014 00:21:24 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so14220086ier.4
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2014 21:21:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5490D5CB.5010200@huawei.com>
References: <CAGZFCEG-J=Qore8nWvWLe6m-bm59Mx+M=HdcaOBVNODm9beokQ@mail.gmail.com>
	<5490D5CB.5010200@huawei.com>
Date: Wed, 17 Dec 2014 10:51:23 +0530
Message-ID: <CAGZFCEFOiY+VmTVKOnPwDaKUKogUX9gkXtHuMATL3btw4kz2JQ@mail.gmail.com>
Subject: Re: sysfs-pci remove
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I could see the pci resource in /proc/iomem.

But , lspci -s 06:0.0 -vv  shows that there is no kernel mode driver
for that interface.


On Wed, Dec 17, 2014 at 6:30 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2014/12/17 1:51, ratheesh kannoth wrote:
>> Hi list,
>>
>> https://www.kernel.org/doc/Documentation/filesystems/sysfs-pci.txt
>> talks about "remove" entry.
>> The 'remove' file is used to remove the PCI device, by writing a non-zero
>> integer to the file.  if i remove the device , will the bar resource
>> map still appear on /proc/iomem ?
>
> Of course not.
>
>>
>>
>> -Ratheesh
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
>
> --
> Thanks!
> Yijing
>
