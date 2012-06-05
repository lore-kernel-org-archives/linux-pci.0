Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:36238 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab2FEEN0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 00:13:26 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 4 Jun 2012 22:13:25 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C30151FF001D
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 04:12:43 +0000 (WET)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q554C6kh066540
	for <linux-pci@vger.kernel.org>; Mon, 4 Jun 2012 22:12:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q554Bot7020736
	for <linux-pci@vger.kernel.org>; Mon, 4 Jun 2012 22:11:50 -0600
Date: Tue, 5 Jun 2012 12:11:46 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
Message-ID: <20120605041146.GD6637@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120605032627.GA23271@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120605032627.GA23271@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 05, 2012 at 11:26:27AM +0800, Richard Yang wrote:
> 
> All, 
> 
> I draw a chart on the relationship of bridge/bus/devics.
> 
> I am not sure it is exact, so please correct me if it is not correct.

A clearer representation can be found at http://tldp.org/LDP/tlk/dd/pci.html		
in section 6.6.1

> 
> BTW, the pci_bus->self, pci_bus->bridge seem to point the same thing.
> So this is really necessary to do this?

pci_bus->self points to the pci_dev structure, and pci_bus->bridge
points to the device structure. Both correspond to the same bridge. BTW: device
structure is the basic structure to represent any device in the system,
not necessarily pci device.


> 
>                             Bus 0(pci_bus)                      
>                             +--------------------+<----+
>                             |                    |     |
>                             +--------------------+     |
>                                                        |
>                                                        |
>                              Bridge(pci_dev)           |                     
>                             +--------------------+<----|---+--------------+
>                             |subordinate(pci_bus)|-+   |   |              |
>                             +--------------------+ |   |   |              |
>                                                    |   |   |              |
>                                                    |   |   |              |
>                                                    |   |   |              |
>                             Bus 1(pci_bus)         |   |   |              |
>                        +--->+-------------------+<-+   |   |              |
>                        |    |parent(pci_bus)    |------+   |              |
>                        |    +-------------------+          |              |
>                        |    |self(pci_dev)      |----------+              |
>                        |    |bridge(device)     |                         |
>                        |    +-------------------+                         |
>                        |    |devices(list_head) |                         |
>                        |    +--------+----------+                         |
>                        |             |                                    |
>                        |      ----+--+---+----                            |
>    pci_dev             |          |      |          pci_dev               |
>    +---------------+<--|----------+      +--------->+-----------------+   |
>    |bus(pci_bus)   |---+                            |bus(pci_bus)     |   |
>    +---------------+                                +-----------------+   |
>    |dev.parent     |                                |dev.parent       |---+
>    +---------------+                                +-----------------+

