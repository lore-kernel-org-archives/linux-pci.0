Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64593 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2D3P4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Apr 2012 11:56:37 -0400
Received: by lbbgm6 with SMTP id gm6so326369lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 30 Apr 2012 08:56:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120428050127.GA25916@richard>
References: <20120427092704.GA22529@richard> <CAErSpo6xy6AEQwROSOU6yrfdWpBgRpd+-hOGOyg0mv9UzKwOUA@mail.gmail.com>
 <20120428050127.GA25916@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 30 Apr 2012 09:56:13 -0600
Message-ID: <CAErSpo7mjeo8f=_3Uhj0V-Q1-q5dYqi8T7pMqBY6zdahpCWTRA@mail.gmail.com>
Subject: Re: Does my understanding correct?
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2012 at 11:01 PM, Richard Yang
<weiyang@linux.vnet.ibm.com> wrote:
> On Fri, Apr 27, 2012 at 08:17:48AM -0600, Bjorn Helgaas wrote:
>>On Fri, Apr 27, 2012 at 3:27 AM, Richard Yang
>><weiyang@linux.vnet.ibm.com> wrote:
>>
>>I assume your question relates to the Stratus ftServer topology.  If
>>so, the lspci details might clarify things.
>>
> Yes, my picture is a little bit related to your previous mail.
> While my intention is to find out how the physical world is represented
> in the kernel.
>
> Below is a typical topology in PCIe spec r3.0.
>
>                          +------------------+
>                          |                  |
>                          |      RC          |
>                          |       Bus#0      |
>                          | -------------    |
>                          |                  |
>                          +-+-----+--------+-+
>         00:0.0             |     |        |        00:02.0
>  +---------+---------+      |     |        |       +------------+-------------+
>  |                   +------+     |        +-------|  PCIe 2 PCI Bridge       |
>  |   PCIe Endpoint   |            |                |                          |
>  +-------------------+            |                |  Bus#2                   |
>                                  |                |  --------------          |
>                                  |                +-------+---------------+--+
>                                  |                        |            |
>                                  |  00:01.0               |02:00.0     |02:01.0
>                     +------------+-------------+  +-------+------+ +---+-------+
>                     |                          |  |PCI dev       | |PCI dev    |
>                     |       Switch             |  |              | |           |
>                     |       Bus#1              |  |              | |           |
>                     |     ---------------      |  +--------------+ +-----------+
>                     |                          |
>                     +------------------------+-+
>                        |                       |
>                        |                       |
>                        | 01:00.0               | 01:01.0
>              +---------+-------+      +--------+----------------+
>              |                 |      |                         |
>              | PCI Endpoint    |      |  PCIe Endpoint          |
>              |                 |      |                         |
>              |                 |      |                         |
>              +-----------------+      +-------------------------+
>
> Do you think the current assignment of bus number and pci_dev is
> correct?

I think assignments shown for the PCIe-to-PCI bridge are OK, although
I would draw it like this because the bridge originates a single bus
02 that may have multiple devices attached to it (this side is PCI,
not PCIe, so it really is a shared bus):

                                 ^
                                 |
                        +--------+--------+
                        |     00:02.0     |
                        | PCIe-PCI bridge |
                        |                 |
                        +--------+--------+
                                 |
                                 |
                      +---------------------+    Bus 02
                      |                     |
                      |                     |
                      |                     |
                 +----v----+           +----v----+
                 | 02:00.0 |           | 02:01.0 |
                 +---------+           +---------+

I think the PCIe switch part is incorrect.  Here's Figure 1-3 from sec
1.3.3 of the PCIe r3 spec:

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
     |                               |                              |
     |                               |                              |
     |          +----------------------------------------+          |
     |          |                    |                   |          |
     |          |                    |                   |          |
     |          |                    |                   |          |
     |     +----+----+          +----+----+         +----++---+     |
     |     | virtual |          | virtual |         | virtual |     |
     |     | PCI-PCI |          | PCI-PCI |         | PCI-PCI |     |
     |     | bridge  |          | bridge  |         | bridge  |     |
     |     +----+----+          +----+----+         +----+----+     |
     |          |                    |                   |          |
     |          |                    |                   |          |
     +----------|--------------------|-------------------|----------+
                |                    |                   |
                v                    v                   v


A PCIe switch appears as two or more PCI-PCI bridges.  One is
associated with the upstream port; the others with the downstream
ports.

A bridge always has a primary side and a secondary side.  In your
diagram, the bridge associated with the upstream port would be 00:01.0
(primary bus 00) and could have a secondary bus of 03 (since 02 is
already consumed by the PCIe-PCI bridge).

The bridges associated with the downstream ports are all logically on
bus 03.  Their primary bus number would be 03; they might be 03:00.0,
03:01.0, 03:02.0, etc.  Each would have its own secondary bus number,
for example 04, 05, 06.  That secondary bus number is for the
downstream link from the corresponding downstream port.

The endpoints below the PCIe switch could then be 04:00.0 and 05:00.0
(or these could be the upstream ports of more PCIe switches).

Bjorn
