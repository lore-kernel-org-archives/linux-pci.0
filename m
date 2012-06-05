Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:40871 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab2FEGlN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 02:41:13 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 5 Jun 2012 05:43:40 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q555sl0F62324952
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 15:54:48 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q55624wM001483
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 16:02:05 +1000
Date: Tue, 5 Jun 2012 14:02:02 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
Message-ID: <20120605060202.GC24358@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120605032627.GA23271@richard>
 <20120605041146.GD6637@ram-ThinkPad-T61>
 <CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com>
 <CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 04, 2012 at 10:18:46PM -0700, Yinghai Lu wrote:
>On Mon, Jun 4, 2012 at 9:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> That's true, but I don't think it answers the question.  If we have:
>>
>>    pci_bus->bridge == pci_bus->self->dev
>>
>> why would we need both "self" and "bridge"?  It would be interesting
>> to try to remove "bridge" and replace uses of it with "self->dev".
>
>then how about root bus?
>
>root bus ->self should be NULL.
>
>root bus ->bridge is to the hostbridge->dev.
>
>Yinghai

Agree, root_pci_bus->self is NULL, and root_pci_bus->bridge point to a
solo device structure, not in hostbridge. 

BTW, if the dev is the hostbrige->dev, why not pci_host_bridge contain a
field "dev"?

And, why root bus differs with other bus a lot?
Both root bus and other bus use self/bridge point to the "PCI BRIDGE"
device.
I think we can determine whether this is a root bus by bus->parent?

-- 
Richard Yang
Help you, Help me

