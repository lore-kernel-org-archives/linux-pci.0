Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:38811 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab2FFGSN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jun 2012 02:18:13 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 6 Jun 2012 06:17:56 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q565LJRE36044864
	for <linux-pci@vger.kernel.org>; Wed, 6 Jun 2012 15:21:19 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q565Sb1H022352
	for <linux-pci@vger.kernel.org>; Wed, 6 Jun 2012 15:28:39 +1000
Date: Wed, 6 Jun 2012 13:28:35 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
Message-ID: <20120606052835.GB17042@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120605032627.GA23271@richard>
 <20120605041146.GD6637@ram-ThinkPad-T61>
 <CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com>
 <CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com>
 <CAE9FiQUCV1+ePfyX7bqOyZ+Wcsj1neCO91MvuM5vNh3+UPERDQ@mail.gmail.com>
 <20120605063538.GE6637@ram-ThinkPad-T61>
 <CAE9FiQV66_eUiQKJc79CMvRA9th8MOinjaVnYKLgpPz_4_pxww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQV66_eUiQKJc79CMvRA9th8MOinjaVnYKLgpPz_4_pxww@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 05, 2012 at 12:38:52PM -0700, Yinghai Lu wrote:
>>
>> Yinghai,
>>
>> is there a reason why this can't be fixed in
>> pci_create_root_bus() by having
>>   bus->self = bridge; /* 'bridge' is the pci_device of the corresponding host bridge */
>>   get_device(&bridge->dev);
>
>self is pointer to pci_dev bridge.
>
>and for root bus, it is NULL. that mean no pci bridge device related.
>
>bridge is device, and have that assigned from host bridge dev, or pci
>bridge dev.
>
>also for virtfn of iov, new bus from there will not have self assigned too.
>for it even bridge is not assigned.
>
>so bridge is just generic way to save bridge (pci, host) device ...

I did a summarize, we have three types of pci_bus.


Can we identify the type by following method?

+--------------------+--------------------------------------------------+
| bus type           |   identification                                 |
+--------------------+--------------------------------------------------+
| root_bus           |parent is NULL, bridge point to host_bridge dev   |
+--------------------+--------------------------------------------------+
| general_bus        |parent to parent bus, bridge point to the bridge  |
+--------------------+--------------------------------------------------+
| iov_bus            |parent to parent bus, bridge point to NULL        |
+--------------------+--------------------------------------------------+

-- 
Richard Yang
Help you, Help me

