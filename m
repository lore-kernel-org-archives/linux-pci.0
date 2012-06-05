Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:42889 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab2FED0g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2012 23:26:36 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 5 Jun 2012 08:56:33 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q553QUqI983394
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 08:56:30 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q558ti4W000841
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 18:55:45 +1000
Date: Tue, 5 Jun 2012 11:26:27 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: One chart on pci bridge and its bus and their children
Message-ID: <20120605032627.GA23271@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


All, 

I draw a chart on the relationship of bridge/bus/devics.

I am not sure it is exact, so please correct me if it is not correct.

BTW, the pci_bus->self, pci_bus->bridge seem to point the same thing.
So this is really necessary to do this?

                            Bus 0(pci_bus)                      
                            +--------------------+<----+
                            |                    |     |
                            +--------------------+     |
                                                       |
                                                       |
                             Bridge(pci_dev)           |                     
                            +--------------------+<----|---+--------------+
                            |subordinate(pci_bus)|-+   |   |              |
                            +--------------------+ |   |   |              |
                                                   |   |   |              |
                                                   |   |   |              |
                                                   |   |   |              |
                            Bus 1(pci_bus)         |   |   |              |
                       +--->+-------------------+<-+   |   |              |
                       |    |parent(pci_bus)    |------+   |              |
                       |    +-------------------+          |              |
                       |    |self(pci_dev)      |----------+              |
                       |    |bridge(device)     |                         |
                       |    +-------------------+                         |
                       |    |devices(list_head) |                         |
                       |    +--------+----------+                         |
                       |             |                                    |
                       |      ----+--+---+----                            |
   pci_dev             |          |      |          pci_dev               |
   +---------------+<--|----------+      +--------->+-----------------+   |
   |bus(pci_bus)   |---+                            |bus(pci_bus)     |   |
   +---------------+                                +-----------------+   |
   |dev.parent     |                                |dev.parent       |---+
   +---------------+                                +-----------------+
-- 
Richard Yang
Help you, Help me

