Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40873 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab2FZMQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jun 2012 08:16:30 -0400
Received: by bkcji2 with SMTP id ji2so4078733bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 05:16:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120626015740.GA8128@richard>
References: <20120620084515.GA22809@richard> <20120626015740.GA8128@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 26 Jun 2012 06:16:08 -0600
Message-ID: <CAErSpo4_qy59KS1K+t5rU8P95NNR8fB9x-ufe8VB8deGriOZ9A@mail.gmail.com>
Subject: Re: One question about the useage of pci_dev->resource[]
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2012 at 7:57 PM, Richard Yang
<weiyang@linux.vnet.ibm.com> wrote:
> On Wed, Jun 20, 2012 at 04:45:15PM +0800, Richard Yang wrote:
>>All,
>>
>>I want to confirm something for the pci_dev->resource[].
>>
>>As in the definition in the pci.h, this resource array is divided into
>>several parts.
>>    0-5  for standard PCI resources
>>    6    for ROM resource
>>    7-10 for bridge resource( if no iov )
>>
>>
>>1. For P2P bridge, 0-5 is left empty?
>>2. If so, in code pci_setup_device(), I think it set the wrong resource.
>>   It call pci_read_bases(dev, 2, PCI_ROM_ADDRESS1), for a p2p bridge.
>>   And in pci_read_bases(), BAR information is retrieved and set to
>>   pci_dev->resource[0|1].
>>3. If pci_setup_device() just set first two resource, the child bus will
>>   point to empty resource.
>>   In pci_alloc_child_bus(), child->resource[0-3] will be point to
>>   bridge->resource[7-10], which is not set in pci_setup_device().
>>4. Another question is, is there any convention for pci_bus->resource[].
>>   [0] for io, [1] for mem, [2] for prefetch?
> All,
>
> I go through the code again and find pci_dev->resource[7-10] is used for
> io/mem base/limit, which is used by the bridge to determine whether it
> will forward one pci transaction.
>
> So pci_dev->[0-1] is used by the bridge's driver?

Per the PCI-to-PCI Bridge spec v1.2, config space for type 1 devices
(bridges) has two BARs in addition to the I/O, mem, and prefetchable
mem windows.  These two BARs are optional and can be used for
device-specific configuration of the bridge itself.  This is unrelated
to forwarding transactions.  See sec 3.2.5.1.

The bridge consumes the address space described by the windows and
forwards it to its secondary interface.  It also consumes the address
space described by those BARs, without forwarding it.  Therefore, we
have to read the BARs to make sure we don't allocate that space to
anything else.

There *could* be device-specific bridge drivers that actually do
something with those BARs, but I'm not aware of any in Linux.

Bjorn
