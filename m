Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51057 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaHBAeN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Aug 2014 20:34:13 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so6652449pab.6
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2014 17:34:12 -0700 (PDT)
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
From: Ethan Zhao <ethan.kernel@gmail.com>
In-Reply-To: <53DB7F4E.2010407@solarflare.com>
Date: Sat, 2 Aug 2014 08:34:03 +0800
Cc: Alexander Duyck <alexander.h.duyck@intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Message-Id: <E84505B9-370F-4A53-89CC-47711CDA3909@gmail.com>
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <CABawtvMK=FrquFm-imovjjCV9YMj-fH1mWYd=5G=kpJccdETPQ@mail.gmail.com> <53DB7F4E.2010407@solarflare.com>
To: Edward Cree <ecree@solarflare.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> 在 2014年8月1日，下午7:51，Edward Cree <ecree@solarflare.com> 写道：
> 
>> On 01/08/14 04:18, Ethan Zhao wrote:
>>> On Thu, Jul 31, 2014 at 11:56 PM, Edward Cree <ecree@solarflare.com> wrote:
>>> Clearing dev->is_physfn in the driver probe routine isn't safe:
>>> dev->sriov memory can get leaked, for example, as sriov_init will get
>>> called at device add, but sriov_release won't be called at removal.
>>  I think this memory leak bug doesn't exist.
>> 
>>  The dev->sriov memory was allocated when pci_device_add() called.
>> whenever devices
>>  were hot-pluged into system or built-in devices were scanned while booting.
>> 
>>  The memory of dev->sriov is to be freed by kobject->kobject_release() when
>> the device reference counter reaches zero when put_device() was called.
>> for hot-plug, that is pciehp_unconfigure_device()....etc.  but not in
>> driver->remove().
> Yes, but the problem is in pci_iov_release(), not how it gets called;
> its code is
>    if (dev->is_physfn)
>        sriov_release(dev);
> So if the device driver clears dev->is_physfn, and later on the device
> is hot-unplugged, pci_iov_release() won't call sriov_release().
> Thus any device driver that changes dev->is_physfn will, if the device
> is hot-unplugged, leak dev->sriov.

Currently , we set dev->is_physfn when PF' SRIOV cap is detected, no reason to
Change it later in driver.

Thanks
Ethan

> Fortunately a quick grep shows no drivers doing this, so there's no
> actual bug in existing code.  It's just that we can't use this approach
> to disable SR-IOV from the driver's probe routine.
> -Edward
>>     put_device()
>>        kobject_put()
>>           kobject_release()
>>               kobject_cleanup()
>>                   device_release()
>>                       dev->release(dev)
>>                             pci_release_dev()
>>                                  pci_release_capabilities()
>>                                     pci_iov_release()
>>                                         sriov_release(dev);
>>                                               kfree(dev->sriov);
> The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
