Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:36529 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab2EGDAO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 6 May 2012 23:00:14 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 7 May 2012 08:30:11 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q47307406816182
	for <linux-pci@vger.kernel.org>; Mon, 7 May 2012 08:30:08 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q478UbpZ019649
	for <linux-pci@vger.kernel.org>; Mon, 7 May 2012 18:30:37 +1000
Date: Mon, 7 May 2012 11:00:05 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: Does my understanding correct?
Message-ID: <20120507030005.GA13838@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120427092704.GA22529@richard>
 <CAErSpo6xy6AEQwROSOU6yrfdWpBgRpd+-hOGOyg0mv9UzKwOUA@mail.gmail.com>
 <20120428050127.GA25916@richard>
 <CAErSpo7mjeo8f=_3Uhj0V-Q1-q5dYqi8T7pMqBY6zdahpCWTRA@mail.gmail.com>
 <20120502062443.GB24172@richard>
 <CAErSpo6uODF00jL6hHXbB8=f3XiG2UMr+5-5CxY2T+duQVfcTA@mail.gmail.com>
 <20120503062134.GC6255@richard>
 <CAErSpo40hwqdnUOmjbdm+3TNt_w0rYg6-qD7nYmauRvaQXhkiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAErSpo40hwqdnUOmjbdm+3TNt_w0rYg6-qD7nYmauRvaQXhkiQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2012 at 10:39:42AM -0600, Bjorn Helgaas wrote:
>>
>>
>>                          
>>                          
>>      +-------------------------------|------------------------------+
>>      |                               |                              |
>>      |                          +----+----+                         |
>>      |                          | virtual |                         |
>>      |                          | PCI-PCI |                         |
>>      |                          | bridge  |                         |
>>      |                          +----+----+       
>>      |                               |        |
>>      |                               |Bus#3      
>>      |                               |                              |
>>      |          +----------------------------------------+          |
>>      |          |                    |                   |          |
>>      |          |                    |                   |          |
>>      |          |03:00.0             |03:01.0            |03:02.0   |
>>      |     +----+----+          +----+----+         +----++---+     |
>>      |     | virtual |          | virtual |         | virtual |     |
>>      |     | PCI-PCI |          | PCI-PCI |         | PCI-PCI |     |
>>      |     | bridge  |          | bridge  |         | bridge  |     |
>>      |     +----+----+          +----+----+         +----+----+     |
>>      |          |                    |                   |          |
>>      |          |                    |                   |          |
>>      +----------|--------------------|-------------------|----------+
>>                 | Bus#4?             |                   |
>>                 v                    v                   v
>>
I read the code of pci_scan_child_bus(), in this function it will call
pci_scan_slot() like this.

	for (devfn = 0; devfn < 0x100; devfn += 8)
		pci_scan_slot(bus, devfn);
I think this scheme is based on the PCI LB specification.

If the bus->self is ari enabled, one call of pci_scan_slot(bus, 0) will
scan all the functions under this bus.

Then next 2^5-1 times of pci_scan_slot() will configure the function which
has already been configured, or even empty function.

My idea is 
if the bus is ari enabled, just one call of pci_scan_slot() will be
called. 

Do you think this works? Or may I miss some real case?

>> So the link itself is Bus#4?
>
>Exactly.
>
>> If there is no device under this link, will Bus#4 appear in kernel?
>
>Yes, I'm pretty sure we build the bus 04 pci_bus structure, then scan
>bus 04 for devices.  Even if we find none, the pci_bus struct for bus
>04 remains.
>
>> And then the PCIe switch is represented by 4 pci_dev structure and each
>> is bridge type?
>
>Yes.  And each has an associated pci_bus struct for its secondary bus.
>
>Bjorn

-- 
Richard Yang
Help you, Help me

