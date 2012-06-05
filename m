Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:59869 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab2FEGAR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 02:00:17 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 5 Jun 2012 05:23:12 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q555PxuS32178294
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 15:26:00 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q555XHSp022048
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 15:33:17 +1000
Date: Tue, 5 Jun 2012 13:33:15 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
Message-ID: <20120605053315.GA24358@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120605032627.GA23271@richard>
 <20120605041146.GD6637@ram-ThinkPad-T61>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120605041146.GD6637@ram-ThinkPad-T61>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 05, 2012 at 12:11:46PM +0800, Ram Pai wrote:
>On Tue, Jun 05, 2012 at 11:26:27AM +0800, Richard Yang wrote:
>> 
>> All, 
>> 
>> I draw a chart on the relationship of bridge/bus/devics.
>> 
>> I am not sure it is exact, so please correct me if it is not correct.
>
>A clearer representation can be found at http://tldp.org/LDP/tlk/dd/pci.html		
>in section 6.6.1
Thanks, Ram.

I found I missed one important field in pci_bus.

>
>> 
>> BTW, the pci_bus->self, pci_bus->bridge seem to point the same thing.
>> So this is really necessary to do this?
>
>pci_bus->self points to the pci_dev structure, and pci_bus->bridge
>points to the device structure. Both correspond to the same bridge. BTW: device
>structure is the basic structure to represent any device in the system,
>not necessarily pci device.
>
>
>> 
>>                             Bus 0(pci_bus)                      
>>                             +--------------------+<----+
>>                             |                    |     |
>>                             +--------------------+     |
>>                                                        |
>>                                                        |
>>                              Bridge(pci_dev)           |                     
>>                             +--------------------+<----|---+--------------+
>>                             |subordinate(pci_bus)|-+   |   |              |
>>                             +--------------------+ |   |   |              |
>>                                                    |   |   |              |
>>                                                    |   |   |              |
>>                                                    |   |   |              |
>>                             Bus 1(pci_bus)         |   |   |              |
>>                        +--->+-------------------+<-+   |   |              |
>>                        |    |parent(pci_bus)    |------+   |              |
>>                        |    +-------------------+          |              |
>>                        |    |self(pci_dev)      |----------+              |
>>                        |    |bridge(device)     |                         |
>>                        |    +-------------------+                         |
>>                        |    |devices(list_head) |                         |
>>                        |    +--------+----------+                         |
>>                        |             |                                    |
>>                        |      ----+--+---+----                            |
>>    pci_dev             |          |      |          pci_dev               |
>>    +---------------+<--|----------+      +--------->+-----------------+   |
>>    |bus(pci_bus)   |---+                            |bus(pci_bus)     |   |
>>    +---------------+                                +-----------------+   |
>>    |dev.parent     |                                |dev.parent       |---+
>>    +---------------+                                +-----------------+

-- 
Richard Yang
Help you, Help me

