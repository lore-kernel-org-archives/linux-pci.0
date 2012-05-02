Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299Ab2EBVFl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 May 2012 17:05:41 -0400
Message-ID: <4FA1A1A2.5090406@redhat.com>
Date: Wed, 02 May 2012 17:05:38 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: Does my understanding correct?
References: <20120427092704.GA22529@richard> <CAErSpo6xy6AEQwROSOU6yrfdWpBgRpd+-hOGOyg0mv9UzKwOUA@mail.gmail.com> <20120428050127.GA25916@richard> <CAErSpo7mjeo8f=_3Uhj0V-Q1-q5dYqi8T7pMqBY6zdahpCWTRA@mail.gmail.com> <20120502062443.GB24172@richard> <CAErSpo6uODF00jL6hHXbB8=f3XiG2UMr+5-5CxY2T+duQVfcTA@mail.gmail.com>
In-Reply-To: <CAErSpo6uODF00jL6hHXbB8=f3XiG2UMr+5-5CxY2T+duQVfcTA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/02/2012 10:59 AM, Bjorn Helgaas wrote:
> On Wed, May 2, 2012 at 12:24 AM, Richard Yang
> <weiyang@linux.vnet.ibm.com>  wrote:
>> On Mon, Apr 30, 2012 at 09:56:13AM -0600, Bjorn Helgaas wrote:
>>> On Fri, Apr 27, 2012 at 11:01 PM, Richard Yang
>>> <weiyang@linux.vnet.ibm.com>  wrote:
>>>
>> Thanks for your nice chart.
>>> I think assignments shown for the PCIe-to-PCI bridge are OK, although
>>> I would draw it like this because the bridge originates a single bus
>>> 02 that may have multiple devices attached to it (this side is PCI,
>>> not PCIe, so it really is a shared bus):
>>>
>>>                                  ^
>>>                                  |
>>>                         +--------+--------+
>>>                         |     00:02.0     |
>>>                         | PCIe-PCI bridge |
>>>                         |                 |
>>>                         +--------+--------+
>>>                                  |
>>>                                  |
>>>                       +---------------------+    Bus 02
>>>                       |                     |
>>>                       |                     |
>>>                       |                     |
>>>                  +----v----+           +----v----+
>>>                  | 02:00.0 |           | 02:01.0 |
>>>                  +---------+           +---------+
>>>
>> So for this case, there is not internal bus, while this is really a
>> physical shared bus, not a logical one.
>
> Yes.  The downstream side of the PCIe-PCI bridge is PCI.
>
>>> I think the PCIe switch part is incorrect.  Here's Figure 1-3 from sec
>>> 1.3.3 of the PCIe r3 spec:
>>
>>                                      ^
>>                                      |
>>      +-------------------------------|------------------------------+
>>      |                               |                              |
>>      |                          +----+----+                         |
>>      |                          | virtual |                         |
>>      |                          | PCI-PCI |                         |
>>      |                          | bridge  |                         |
>>      |                          +----+----+                         |
>>      |                               |                              |
>>      |                               |Bus#3                         |
>>      |                               |                              |
>>      |          +----------------------------------------+          |
>>      |          |                    |                   |          |
>>      |          |                    |                   |          |
>>      |          |03:00.0             |03:01.0            |03:02.0   |
>>      |     +----+----+          +----+----+         +----++---+     |
>>      |     | virtual |          | virtual |         | virtual |     |
>>      |     | PCI-PCI |          | PCI-PCI |         | PCI-PCI |     |
>>      |     | bridge  |          | bridge  |         | bridge  |     |
>>      |     +----+----+          +----+----+         +----+----+     |
>>      |          |Bus#4?              |                   |          |
>>      |     -----+-------             |                   |          |
>>      +----------|--------------------|-------------------|----------+
>>                 |                    |                   |
>>                 v                    v                   v
>>
>>
>>> A PCIe switch appears as two or more PCI-PCI bridges.  One is
>>> associated with the upstream port; the others with the downstream
>>> ports.
>>>
>>> A bridge always has a primary side and a secondary side.  In your
>>> diagram, the bridge associated with the upstream port would be 00:01.0
>>> (primary bus 00) and could have a secondary bus of 03 (since 02 is
>>> already consumed by the PCIe-PCI bridge).
>> Hmm... I am confused why is 03. 02 is used but 01 is not used.
>> Switch should be configured after PCIe2PCI bridge?
>
> It's likely that the PCIe switch would be configured first, since its
> device number is lower, but that is not a requirement.  The
> requirement is that the bus number ranges consumed by bridges be
> non-overlapping.  In this case (using your original topology plus my
> PCIe switch diagram), we'd have:
>
>    1. an endpoint at 00:00.0 -- consumes no additional buses
>    2. a PCIe switch at 00:01.0 -- consumes at least [bus 03-06]
>    3. a PCIe-PCI bridge at 00:02.0 -- consumes least [bus 02] (its secondary bus)
>
> Bus 03 is the internal PCIe switch bus that connects the upstream port
> to the downstream ports.  Buses 04, 05, and 06 are the links
> originating from the downstream ports.
>
>>> The bridges associated with the downstream ports are all logically on
>>> bus 03.  Their primary bus number would be 03; they might be 03:00.0,
>>> 03:01.0, 03:02.0, etc.  Each would have its own secondary bus number,
>>> for example 04, 05, 06.  That secondary bus number is for the
>>> downstream link from the corresponding downstream port.
>> Hmm, as you mentioned in previous letter, PCIe is an point-to-point
>> protocol, then the secondary bus should reside in the Switch?
>> Do you think my Bus#4 is correct?
>
> No.  Bus 04 is a PCIe link that connects the downstream port (03:00.0)
> to a single PCIe device.  That device (04:00) could be a PCIe
> endpoint, or it could be the upstream port of another PCIe switch.
> (If it is a switch, more bus numbers would be required.)
>
>>> The endpoints below the PCIe switch could then be 04:00.0 and 05:00.0
>>> (or these could be the upstream ports of more PCIe switches).
>> So below the PCIe downstream port, there is only on PCIe device.
>> The whole bus is occupied by this device?
>> That is why the device could have upto 256 functions?
>
> Yes, if it supports ARI.
>
minor tweak: if the device *and* the downstream PCIe bridge support ARI...
both must exist.  I know of one such module, e.g., non-ARI PCIe switch w/PCIe endpoints)
and the endpoints have SRIOV/VF support... not a very smart hw combo. .. nuf said.

> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

