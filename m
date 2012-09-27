Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54466 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab2I0URl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Sep 2012 16:17:41 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo7Vf1Pz3bFfMAfWXoh0gF844X2JT7RQ9-ecr3uWj=z9_w@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com>
	<CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
	<CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
	<CAE9FiQUUjPza9Hq8jJR0nLN__26zQooQAr=paB6dRjQtTM=ngw@mail.gmail.com>
	<CAErSpo7Vf1Pz3bFfMAfWXoh0gF844X2JT7RQ9-ecr3uWj=z9_w@mail.gmail.com>
Date: Thu, 27 Sep 2012 13:17:39 -0700
Message-ID: <CAE9FiQUrovv143dTo_k2m0DYXqwGc4BtbjmzGxo2Fk21Fp2EJw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 11:44 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> I'm not sure if that is needed.
>
> That's a useless response.  Do you want to elaborate on *why* you
> think this is a bad idea?

I did not say that is bad idea.

it is just not needed to waste your time.

>
> I explained the reasons why I think it's a good idea above, but just
> to expand on it, we currently have to create the struct pci_bus before
> we can add _PRT information.   But adding the _PRT info doesn't
> actually depend on the struct pci_bus; it only requires the segment
> number and the bus number.  We have that information before we scan
> the bus .
>
> I think it's useful to disentangle _PRT interface from the specifics
> of PCI (in this case, the struct pci_bus).  We're currently using the
> struct pci_bus here just as a convenient way to pass around the
> segment/bus number, but I don't think it's the appropriate abstraction
> for that.
>
> Do you see a technical problem with it?  Even if it's not *necessary*
> in order to make host bridge hotplug work, I think it's worth doing to
> make the code more understandable.
>
> Do you see a problem with adding the _PRT info before scanning the bus
> or with removing it after deleting the bus?

If the bus is not there, do not need that prt.

So if you find the prt and add it to the list before, later if
scanning fail etc failing path
you will need to clean that prt in the list.


> I'd like the bus scan
> code to be able to scan/add/bind drivers all at once in the PCI core.
> Today I think we have scan/add _PRT/device_add, where we have to do
> this _PRT stuff in the middle, so we have to use two PCI interfaces
> rather than one.

looks like we handle _PRT in pci_host_bridge add/remove notification,
just like Jiang's put that for pci device bus notifier.

>
> It's great if you see a way to remove acpi_pci_root_start() -- that
> will be tremendous.

that will need to more test.

> I think the current PCI stop/remove split is a
> similar issue, and I hope you can dream up a way to consolidate those,
> too.

that is SRIOV handling resign.

I would suggest following way:
use pf as parent for one new domain. and put all VFs on that domain.
and the domain could have 256 buses for those VFs.
and we have 16 bits domain number that could be used.

current got too many patches in my quilt... hate to keep rebasing again.

after pci root bus hotplug and for_each_res topic, will work on that SRIOV one.

-Yinghai
