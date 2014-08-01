Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo02.seg.att.com ([209.65.160.78]:22793 "EHLO
	nbfkord-smmo02.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753076AbaHALvv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Aug 2014 07:51:51 -0400
Message-ID: <53DB7F4E.2010407@solarflare.com>
Date: Fri, 1 Aug 2014 12:51:42 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Ethan Zhao <ethan.kernel@gmail.com>
CC: Alexander Duyck <alexander.h.duyck@intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <CABawtvMK=FrquFm-imovjjCV9YMj-fH1mWYd=5G=kpJccdETPQ@mail.gmail.com>
In-Reply-To: <CABawtvMK=FrquFm-imovjjCV9YMj-fH1mWYd=5G=kpJccdETPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/08/14 04:18, Ethan Zhao wrote:
> On Thu, Jul 31, 2014 at 11:56 PM, Edward Cree <ecree@solarflare.com> wrote:
>> Clearing dev->is_physfn in the driver probe routine isn't safe:
>> dev->sriov memory can get leaked, for example, as sriov_init will get
>> called at device add, but sriov_release won't be called at removal.
>>
>   I think this memory leak bug doesn't exist.
>
>   The dev->sriov memory was allocated when pci_device_add() called.
> whenever devices
>   were hot-pluged into system or built-in devices were scanned while booting.
>
>   The memory of dev->sriov is to be freed by kobject->kobject_release() when
> the device reference counter reaches zero when put_device() was called.
> for hot-plug, that is pciehp_unconfigure_device()....etc.  but not in
> driver->remove().
>
Yes, but the problem is in pci_iov_release(), not how it gets called;
its code is
    if (dev->is_physfn)
        sriov_release(dev);
So if the device driver clears dev->is_physfn, and later on the device
is hot-unplugged, pci_iov_release() won't call sriov_release().
Thus any device driver that changes dev->is_physfn will, if the device
is hot-unplugged, leak dev->sriov.
Fortunately a quick grep shows no drivers doing this, so there's no
actual bug in existing code.  It's just that we can't use this approach
to disable SR-IOV from the driver's probe routine.
-Edward
>      put_device()
>         kobject_put()
>            kobject_release()
>                kobject_cleanup()
>                    device_release()
>                        dev->release(dev)
>                              pci_release_dev()
>                                   pci_release_capabilities()
>                                      pci_iov_release()
>                                          sriov_release(dev);
>                                                kfree(dev->sriov);
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
