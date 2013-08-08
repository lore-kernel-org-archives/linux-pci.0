Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42888 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757239Ab3HHByf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 21:54:35 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so4701836obb.18
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2013 18:54:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
	<20130807040112.GA14662@google.com>
	<CAE9FiQVXhg299RKsoa8eCqoN7b9c0HaeTGHCnxQY=9vkSYaJJg@mail.gmail.com>
	<CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
Date: Wed, 7 Aug 2013 18:54:34 -0700
Message-ID: <CAE9FiQUyEaakfHia4DAb_KriGtzNwLei7jX2Y+31hTb4XvieWA@mail.gmail.com>
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

On Wed, Aug 7, 2013 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Aug 6, 2013 at 11:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Tue, Aug 6, 2013 at 9:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>> Huh.  I wish we didn't have virtfn_remove() at all.  I wish the
>>> normal device removal path, i.e., pci_stop_and_remove_bus_device(),
>>> could deal with VFs directly.  I don't know all the history there,
>>> so maybe there's some reason that's not feasible.
>>
>> I had one draft version, but looks more confusing.
>
> please check attached that make pci_stop_and_remove_bus_device()
> could be used with VF.

If this solution could be used, we can revert

commit dfab88beda88d6c24111e5966b08ecf813c3a18a
Author: Jiang Liu <liuj97@gmail.com>
Date:   Fri May 31 12:21:31 2013 +0800

    PCI: Hide remove and rescan sysfs interfaces for SR-IOV virtual functions


>
> It could replace
> https://patchwork.kernel.org/patch/2834638/
> https://patchwork.kernel.org/patch/2834639/
>
> Please choose one of the solutions.
>
> but we still need
> https://patchwork.kernel.org/patch/2834640/
> as VFs that does not use ARI could be on other virtual bus.
> so they will not be removed directly.
