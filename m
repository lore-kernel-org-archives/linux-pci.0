Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:47342 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031620Ab3HIXox (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 19:44:53 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so5726252oag.13
        for <linux-pci@vger.kernel.org>; Fri, 09 Aug 2013 16:44:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130809170404.GA29690@google.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
	<20130807040112.GA14662@google.com>
	<CAE9FiQVXhg299RKsoa8eCqoN7b9c0HaeTGHCnxQY=9vkSYaJJg@mail.gmail.com>
	<CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
	<20130809170404.GA29690@google.com>
Date: Fri, 9 Aug 2013 16:44:52 -0700
Message-ID: <CAE9FiQXuNPfhndRAm7uX4phvVqqVsQuuEzEqEi8at9f2oWPYOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 9, 2013 at 10:04 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> Solution would be
>> 1. separating stop and remove in two iterations.
>> 2. or make pci_stop_and_remove_bus_device could be used on VF.
>>
>> This patch is second solution:
>> Separate PF ref releasing from virtfn_remove, all that during
>> pci_destroy_dev for VFs.
>
> I like the second approach better, but I think the call path and
> locking is way too messy:
>
>     virtfn_remove
>       mutex_lock(&iov->dev->sriov->lock)          <--
>       pci_stop_and_remove_bus_device
>         mutex_trylock(&iov->dev->sriov->lock)     <--

yes, original sriov remove code have that, so try to save the lock holding

so if VF is removed directly other than virtfn_remove, those lock still get
hold in the process.

>         pci_stop_bus_device
>         pci_remove_bus_device
>           pci_destroy_dev
>             virtfn_release
>               virtfn_remove_bus
>               pci_dev_put
>
> I think it could be fixed, but it would require significant SR-IOV
> rework, and I'm dubious that we can get it done in time for v3.11.
>
> What would happen if we just reverted dc087f2f6a2 for now?  Jiang?
