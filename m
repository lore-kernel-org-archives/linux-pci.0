Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35724 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbcCNJrl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2016 05:47:41 -0400
MIME-Version: 1.0
In-Reply-To: <20160314094335.GE1796@lahna.fi.intel.com>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
	<2736217.utxPzJExd5@vostro.rjw.lan>
	<20160311105815.GS1796@lahna.fi.intel.com>
	<2759763.dR5D0KopkA@vostro.rjw.lan>
	<CAPM=9txo4aOOa-CS-mnyQe+vYDtAOCm1bzAgfMzwJJS8ZuYmwQ@mail.gmail.com>
	<20160314094335.GE1796@lahna.fi.intel.com>
Date: Mon, 14 Mar 2016 19:47:39 +1000
Message-ID: <CAPM=9txx1s3ZZSaTAGDFh=hKk-Ek2Y=Wyw74CpTWu-cTDAnJ7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10 machines.
From: Dave Airlie <airlied@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>
>> -     if (pcie_port_runtime_suspend_allowed(dev))
>> +     if (pcie_port_runtime_suspend_allowed(dev)) {
>> +             pm_runtime_allow(&dev->dev);
>
> PCI drivers typically have left this decision up to the userspace. I'm
> wondering whether it is good idea to deviate from that here? Of course
> this allows immediate power savings but could potentially cause problems
> as well.
>

No distro has ever shipped userspace to do this, I really think this
is a bad design.
We have wasted countless watts of power on this stupid idea that people will
run powertop, only a few people in the world run powertop, lots of
people use Linux.

The kernel should power stuff down not wait for the user to run powertop,
At least for the GPU it's in the area of 8W of power, and I've got the
GPU drivers doing this themselves,

I could have the GPU driver call runtime allow for it's host bridge I suppose,
if we insist on the userspace cares, but I'd prefer not doing so.

> I think we need to add corresponding call to pm_runtime_forbid() in
> pcie_portdrv_remove().

Yes most likely.

Dave.
>

>>               pm_runtime_put_noidle(&dev->dev);
>> +     }
>>
>>       return 0;
>>  }
>> @@ -436,6 +438,8 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>>   * LINUX Device Driver Model
>>   */
>>  static const struct pci_device_id port_pci_ids[] = {
>> +     /* Intel Skylake PCIE graphics port */
>> +     { PCI_VDEVICE(INTEL, 0x0c01), .driver_data = PCIE_PORT_SPT },
>>       /* Intel Broxton */
>>       { PCI_VDEVICE(INTEL, 0x1ad6), .driver_data = PCIE_PORT_SPT },
>>       { PCI_VDEVICE(INTEL, 0x1ad7), .driver_data = PCIE_PORT_SPT },
>> --
>> 2.5.0
>>
>
