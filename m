Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36537 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbaA3Aqw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 19:46:52 -0500
Received: by mail-ob0-f169.google.com with SMTP id wo20so2802087obc.14
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 16:46:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW1yybW1Zr=gwHiZ9k_r9zddyBzR25cTB9YZgEiwghYcw@mail.gmail.com>
References: <1389741079-12976-1-git-send-email-tixxdz@opendz.org>
 <20140129231222.GI16825@google.com> <CAE9FiQW1yybW1Zr=gwHiZ9k_r9zddyBzR25cTB9YZgEiwghYcw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 29 Jan 2014 17:46:31 -0700
Message-ID: <CAErSpo7S=KVT_06YeQssefJ90QfLETECvKLW7Xk73_O5SbY+=g@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix a memory leak of pci_host_bridge on error path
To: Yinghai Lu <yinghai@kernel.org>
Cc: Djalal Harouni <tixxdz@opendz.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 29, 2014 at 5:23 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jan 29, 2014 at 3:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Wed, Jan 15, 2014 at 12:11:19AM +0100, Djalal Harouni wrote:
>>> On error paths make sure that the pci_host_bridge struct is freed.
>>>
>>> Signed-off-by: Djalal Harouni <tixxdz@opendz.org>
>>
>> Applied to pci/misc, thanks!
>>
>>> ---
>>> On top of linux-next.
>>>
>>>  drivers/pci/probe.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 23cdfac..483566c 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1771,15 +1771,13 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>>       bridge->dev.release = pci_release_host_bridge_dev;
>>>       dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
>>>       error = pcibios_root_bridge_prepare(bridge);
>>> -     if (error) {
>>> -             kfree(bridge);
>>> -             goto err_out;
>>> -     }
>>> +     if (error)
>>> +             goto host_bridge_err;
>>>
>>>       error = device_register(&bridge->dev);
>>>       if (error) {
>>>               put_device(&bridge->dev);
>>> -             goto err_out;
>>> +             goto host_bridge_err;
>>>       }
>>>       b->bridge = get_device(&bridge->dev);
>>>       device_enable_async_suspend(b->bridge);
>>> @@ -1836,6 +1834,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>>  class_dev_reg_err:
>>>       put_device(&bridge->dev);
>>>       device_unregister(&bridge->dev);
>>> +host_bridge_err:
>>> +     kfree(bridge);
>>>  err_out:
>>>       kfree(b);
>>>       return NULL;
>>> --
>
> Are you joking?
>
> NAK.
>
> even device_register fail,it will have one ref hold, and
> put_device(&bridge->dev)
> it will trigger bridge->dev.release aka pci_release_host_bridge_dev;
> that function will free the bridge.
> You will have double free.

OK, dropped, thanks.  I wasn't joking, I just made a mistake.

> commit 343df771e671d821478dd3ef525a0610b808dbf8
> Author: Jiang Liu <liuj97@gmail.com>
> Date:   Fri Jun 7 01:10:08 2013 +0800
>
>     PCI: Fix refcount issue in pci_create_root_bus() error recovery path
>
>     After calling device_register(&bridge->dev), the bridge is reference-
>     counted, and it is illegal to call kfree() on it except in the release
>     function.
>
>     [bhelgaas: changelog, use put_device() after device_register() failure]
>     Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: stable@vger.kernel.org
