Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:46216 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266Ab2FEFlj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 01:41:39 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 5 Jun 2012 11:11:37 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q555fYrK10158386
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 11:11:35 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q55BBL29019325
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 21:11:22 +1000
Date: Tue, 5 Jun 2012 13:41:32 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
Message-ID: <20120605054132.GB24358@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
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

On Mon, Jun 04, 2012 at 10:20:51PM -0700, Yinghai Lu wrote:
>On Mon, Jun 4, 2012 at 10:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Mon, Jun 4, 2012 at 9:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
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
>
>also
>
>b->bridge = get_device(&bridge->dev);
>
>so there is one reference held by pci bus.

Hmm... so can we just have b->bridge, and then convert bridge to self if
necessary?

-- 
Richard Yang
Help you, Help me

