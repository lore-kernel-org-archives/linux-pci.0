Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:33724 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2D1FBe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Apr 2012 01:01:34 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Sat, 28 Apr 2012 04:54:21 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q3S4sfqB2343166
	for <linux-pci@vger.kernel.org>; Sat, 28 Apr 2012 14:54:41 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q3S51SLv020131
	for <linux-pci@vger.kernel.org>; Sat, 28 Apr 2012 15:01:29 +1000
Date: Sat, 28 Apr 2012 13:01:27 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: Does my understanding correct?
Message-ID: <20120428050127.GA25916@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120427092704.GA22529@richard>
 <CAErSpo6xy6AEQwROSOU6yrfdWpBgRpd+-hOGOyg0mv9UzKwOUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6xy6AEQwROSOU6yrfdWpBgRpd+-hOGOyg0mv9UzKwOUA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2012 at 08:17:48AM -0600, Bjorn Helgaas wrote:
>On Fri, Apr 27, 2012 at 3:27 AM, Richard Yang
><weiyang@linux.vnet.ibm.com> wrote:
>
>I assume your question relates to the Stratus ftServer topology.  If
>so, the lspci details might clarify things.
>
Yes, my picture is a little bit related to your previous mail.
While my intention is to find out how the physical world is represented
in the kernel.

Below is a typical topology in PCIe spec r3.0.

                          +------------------+
                          |                  |
                          |      RC          |
                          |       Bus#0      |                                     
                          | -------------    |                                     
                          |                  |                                     
                          +-+-----+--------+-+                                     
         00:0.0             |     |        |        00:02.0                 
 +---------+---------+      |     |        |       +------------+-------------+
 |                   +------+     |        +-------|  PCIe 2 PCI Bridge       |
 |   PCIe Endpoint   |            |                |                          |
 +-------------------+            |                |  Bus#2                   |
                                  |                |  --------------          |
                                  |                +-------+---------------+--+
                                  |                        |            |       
                                  |  00:01.0               |02:00.0     |02:01.0
                     +------------+-------------+  +-------+------+ +---+-------+
                     |                          |  |PCI dev       | |PCI dev    |
                     |       Switch             |  |              | |           |
                     |       Bus#1              |  |              | |           |
                     |     ---------------      |  +--------------+ +-----------+
                     |                          |                               
                     +------------------------+-+                               
                        |                       |                                      
                        |                       |                                      
                        | 01:00.0               | 01:01.0                                    
              +---------+-------+      +--------+----------------+                    
              |                 |      |                         |                     
              | PCI Endpoint    |      |  PCIe Endpoint          |                     
              |                 |      |                         |                     
              |                 |      |                         |                     
              +-----------------+      +-------------------------+                     

Do you think the current assignment of bus number and pci_dev is
correct?


>In that system, my understanding is that 03:01.0 is a downstream port,
>not an upstream port.
>
>I think your picture is slightly misleading because PCIe links are not
>buses; they're point-to-point links between two devices.  You've drawn
>#3 and #5 as buses that can have several devices on them, which is not
>really the case.  The link from a downstream port should lead to
>exactly one device.
>
>That's one thing that's strange in the ftServer topology: apparently
>there are *two* devices on bus 03: the 03:00.0 upstream port and the
>03:01.0 downstream port.  I think 03:00.0 is the upstream port of a
>PCIe switch, which is perfectly normal.  My understanding is that
>03:01.0 is another *downstream* port that leads to several more
>devices (USB, NIC, etc).
>
>Bjorn

-- 
Richard Yang
Help you, Help me

