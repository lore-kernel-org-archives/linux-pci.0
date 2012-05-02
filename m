Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:39020 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab2EBGZE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 May 2012 02:25:04 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 2 May 2012 07:13:37 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q426Hqdj942132
	for <linux-pci@vger.kernel.org>; Wed, 2 May 2012 16:17:52 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q426Ojtg018719
	for <linux-pci@vger.kernel.org>; Wed, 2 May 2012 16:24:45 +1000
Date: Wed, 2 May 2012 14:24:43 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: Does my understanding correct?
Message-ID: <20120502062443.GB24172@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120427092704.GA22529@richard>
 <CAErSpo6xy6AEQwROSOU6yrfdWpBgRpd+-hOGOyg0mv9UzKwOUA@mail.gmail.com>
 <20120428050127.GA25916@richard>
 <CAErSpo7mjeo8f=_3Uhj0V-Q1-q5dYqi8T7pMqBY6zdahpCWTRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7mjeo8f=_3Uhj0V-Q1-q5dYqi8T7pMqBY6zdahpCWTRA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2012 at 09:56:13AM -0600, Bjorn Helgaas wrote:
>On Fri, Apr 27, 2012 at 11:01 PM, Richard Yang
><weiyang@linux.vnet.ibm.com> wrote:
>
Thanks for your nice chart.
>I think assignments shown for the PCIe-to-PCI bridge are OK, although
>I would draw it like this because the bridge originates a single bus
>02 that may have multiple devices attached to it (this side is PCI,
>not PCIe, so it really is a shared bus):
>
>                                 ^
>                                 |
>                        +--------+--------+
>                        |     00:02.0     |
>                        | PCIe-PCI bridge |
>                        |                 |
>                        +--------+--------+
>                                 |
>                                 |
>                      +---------------------+    Bus 02
>                      |                     |
>                      |                     |
>                      |                     |
>                 +----v----+           +----v----+
>                 | 02:00.0 |           | 02:01.0 |
>                 +---------+           +---------+
>
So for this case, there is not internal bus, while this is really a
physical shared bus, not a logical one.
>I think the PCIe switch part is incorrect.  Here's Figure 1-3 from sec
>1.3.3 of the PCIe r3 spec:

                                     ^
                                     |
     +-------------------------------|------------------------------+
     |                               |                              |
     |                          +----+----+                         |
     |                          | virtual |                         |
     |                          | PCI-PCI |                         |
     |                          | bridge  |                         |
     |                          +----+----+                         |
     |                               |                              |
     |                               |Bus#3                         |
     |                               |                              |
     |          +----------------------------------------+          |
     |          |                    |                   |          |
     |          |                    |                   |          |
     |          |03:00.0             |03:01.0            |03:02.0   |
     |     +----+----+          +----+----+         +----++---+     |
     |     | virtual |          | virtual |         | virtual |     |
     |     | PCI-PCI |          | PCI-PCI |         | PCI-PCI |     |
     |     | bridge  |          | bridge  |         | bridge  |     |
     |     +----+----+          +----+----+         +----+----+     |
     |          |Bus#4?              |                   |          |
     |     -----+-------             |                   |          |
     +----------|--------------------|-------------------|----------+
                |                    |                   |
                v                    v                   v


>A PCIe switch appears as two or more PCI-PCI bridges.  One is
>associated with the upstream port; the others with the downstream
>ports.
>
>A bridge always has a primary side and a secondary side.  In your
>diagram, the bridge associated with the upstream port would be 00:01.0
>(primary bus 00) and could have a secondary bus of 03 (since 02 is
>already consumed by the PCIe-PCI bridge).
Hmm... I am confused why is 03. 02 is used but 01 is not used.
Switch should be configured after PCIe2PCI bridge?
>
>The bridges associated with the downstream ports are all logically on
>bus 03.  Their primary bus number would be 03; they might be 03:00.0,
>03:01.0, 03:02.0, etc.  Each would have its own secondary bus number,
>for example 04, 05, 06.  That secondary bus number is for the
>downstream link from the corresponding downstream port.
Hmm, as you mentioned in previous letter, PCIe is an point-to-point
protocol, then the secondary bus should reside in the Switch?
Do you think my Bus#4 is correct?
>
>The endpoints below the PCIe switch could then be 04:00.0 and 05:00.0
>(or these could be the upstream ports of more PCIe switches).
So below the PCIe downstream port, there is only on PCIe device. 
The whole bus is occupied by this device?
That is why the device could have upto 256 functions?
>
>Bjorn

-- 
Richard Yang
Help you, Help me

