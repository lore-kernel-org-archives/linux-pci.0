Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45318 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740Ab2DLX7J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 19:59:09 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 9E0E03EE081
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 08:59:07 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8614545DE4D
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 08:59:07 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6E92C45DD78
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 08:59:07 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 629FD1DB803A
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 08:59:07 +0900 (JST)
Received: from m001.s.css.fujitsu.com (m001.s.css.fujitsu.com [10.23.4.39])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1F5631DB8038
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 08:59:07 +0900 (JST)
Message-ID: <4F876C54.5040408@jp.fujitsu.com>
Date: Fri, 13 Apr 2012 08:59:16 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Subject: Re: [RFC] pciehp: Add archdata setting
References: <4F79584B.2010301@jp.fujitsu.com> <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com> <4F7AA3A2.1080900@jp.fujitsu.com> <4F7C003B.4040208@jp.fujitsu.com> <4F866184.4000403@jp.fujitsu.com> <CAErSpo6Xb6rbZ757VHuQnWWsXbnygTM9JQFzvOnOiM895D+R-g@mail.gmail.com>
In-Reply-To: <CAErSpo6Xb6rbZ757VHuQnWWsXbnygTM9JQFzvOnOiM895D+R-g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Bjorn


Thanks for your research and comment.

As you said, a way of registering code with bus_register_notifier(), 
which will be called in device_add(), is better one than 
pcibios_enable_device().
I will try to write code with bus_register_notifier().


Regards.

Hiroo MATSUMOTO

> On Wed, Apr 11, 2012 at 11:00 PM, Hiroo Matsumoto
> <matsumoto.hiroo@jp.fujitsu.com> wrote:
>> Hi, Kaneshige
>>
>>
>> You are right!
>> Setting dma_ops in pcibios_enable_device is a nice way.
>> In PCI driver, pci_enable_device_xxx that calls pcibios_enable_device is
>> called before checking archdata.dma_ops.
>>
>> I added code of checking and setting dma_ops to pcibios_enable_device in
>> arch/powerpc/kernel/pci-common.c.
>> It works good.
> 
> When I researched this, I thought the best route was to use the
> bus_register_notifier() path, as amd_iommu_init_notifier() does.
> 
> We're filling in a struct device field, not a PCI field, and
> bus_register_notifier() seems like a more generic path than relying on
> pcibios_enable_device().
> 
> Bjorn
> 
> 

