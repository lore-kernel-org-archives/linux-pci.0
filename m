Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:42834 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab2FEVwW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 17:52:22 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Tue, 5 Jun 2012 15:52:21 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 15BE53E4004E
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 21:52:18 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q55LqGJ1187962
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 15:52:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q55LqF9v009623
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 15:52:16 -0600
Date: Wed, 6 Jun 2012 06:52:11 +0900
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: One chart on pci bridge and its bus and their children
Message-ID: <20120605215211.GA5564@shangw>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
References: <20120605032627.GA23271@richard>
 <20120605041146.GD6637@ram-ThinkPad-T61>
 <CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com>
 <CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com>
 <CAE9FiQUCV1+ePfyX7bqOyZ+Wcsj1neCO91MvuM5vNh3+UPERDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQUCV1+ePfyX7bqOyZ+Wcsj1neCO91MvuM5vNh3+UPERDQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi YingHai,

>>> That's true, but I don't think it answers the question.  If we have:
>>>
>>>    pci_bus->bridge == pci_bus->self->dev
>>>
>>> why would we need both "self" and "bridge"?  It would be interesting
>>> to try to remove "bridge" and replace uses of it with "self->dev".
>>
>> then how about root bus?
>>
>> root bus ->self should be NULL.
>>
>> root bus ->bridge is to the hostbridge->dev.

As I understood, the current implementation is to trace the PCI host bridge
through the PCI root bus. The problem would be avoided if you change it for
a little bit to trace the PCI host bridge through (PCI domain number), which
will simplify the current implementation in 3.5.RC1 as well even though not
much. For example: When looking for the PCI host bridge for the child bus,
we only need get the PCI domain number, then get the corresponding PCI host
bridge. We needn't go through the whole PCI bus tree from the bottom to the
top until the PCI root bus.

I'm not sure that will introduce performance improvement or not.

>
>also
>
>b->bridge = get_device(&bridge->dev);
>
>so there is one reference held by pci bus.
>

If we ignore the return value of get_device() here, that would be possible
to merge "bridge"/"self" for child PCI bus. However, we still need differentiate
the PCI root bus and child bus because the "bridge"/"self" of PCI root bus
would be "NULL", but "bridge"/"self" (might be merged to "bridge") would point
pci_dev of the P2P bridge.

Thanks,
Gavin

