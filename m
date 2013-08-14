Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:40601 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111Ab3HNU6i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 16:58:38 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so7606760obb.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2013 13:58:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130814203606.GA9044@google.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
	<20130807040112.GA14662@google.com>
	<CAE9FiQVXhg299RKsoa8eCqoN7b9c0HaeTGHCnxQY=9vkSYaJJg@mail.gmail.com>
	<CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
	<20130809170404.GA29690@google.com>
	<CAE9FiQXuNPfhndRAm7uX4phvVqqVsQuuEzEqEi8at9f2oWPYOg@mail.gmail.com>
	<CAErSpo5uYciz4dZtf6utfehXGnooRAT3BcVHyz+EoZ4m7tbitg@mail.gmail.com>
	<CAE9FiQULOCz3snO26EHy_dumRULyOT34_iEjM_rZeP=pH8KGvw@mail.gmail.com>
	<20130814203606.GA9044@google.com>
Date: Wed, 14 Aug 2013 13:58:38 -0700
Message-ID: <CAE9FiQVYy9G_F3WC2yQTMrVUW39QbDT8t_7ZXBxNUf2UfBWUYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> in your test: the PF is not get freed but it is removed for bus's device list.
>> so pciehp_configure_device will create new one even the old is not
>> really released.
>
> Yes.  As I said above, I do see the leak of the PF pci_dev, and
> we certainly do need to fix that, but it's not a regression and
> doesn't seem urgent.
>
>> Please check with attached patch, that only release that from link-list in
>> pci_release device. I posted it a while back.
>> After it get applied, you will not have chance to create new device in
>> pciehp_configure_device.
>
> [I inlined your patch for convenience]
>
> I agree that the patch below looks like a good thing to do.
> However, it is not in v3.11.  So if the problem only happens when
> the patch below is applied, we don't need to fix the problem in
> v3.11.

ok.

>
> I've spent a LOT of time trying to reproduce this problem and
> convince myself that we need to do something in v3.11.  If you're
> telling me that my time was wasted because the problem does not
> happen in v3.11-rc, but only happens with your out-of-tree patch,
> I'm going to be very upset.

sorry, I did not notice that. I should test without that patch.

Yinghai
