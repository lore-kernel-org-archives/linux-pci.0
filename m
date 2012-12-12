Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <50C89D2B.4060206@gmail.com>
Date: Wed, 12 Dec 2012 23:05:15 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing0307@gmail.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	linux-pci@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH 5/6] ACPI: Replace struct acpi_bus_ops with enum type
References: <8498184.VilrUmatxI@vostro.rjw.lan> <CAE9FiQXYPPcRZZBFGrqcV--0-UixMH1f+q4WdovErthsLhxn7A@mail.gmail.com> <50C74C92.1040405@gmail.com> <2093499.q2b9fD3smR@vostro.rjw.lan> <50C89608.7050908@gmail.com>
In-Reply-To: <50C89608.7050908@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/12/2012 10:34 PM, Yijing Wang wrote:
> 于 2012-12-12 2:30, Rafael J. Wysocki 写道:
>> Hi Gerry,
>>
>> On Tuesday, December 11, 2012 11:09:06 PM Jiang Liu wrote:
>>> Hi Rafael,
>>> 	I have worked out a patch set to clean up ACPI/PCI related notifications,
>>> please refer to
>>> http://www.spinics.net/lists/linux-pci/msg17822.html
>>> 	The patchset doesn't apply cleanly to Bjorn's latest pci-next tree. I will
>>> help to rebase it if needed.
>>
>> I have reviewed the patches and I think they make sense overall.  However,
>> the statement that acpi_pci_bind()/acpi_pci_unbind() are used to maintain
>> PCI-ACPI binding relationships is quite inaccurate, because all what these
>> functions do is to (1) add/remove ACPI PM notifiers to/from PCI devices and
>> (2) retrieve the _PRT information for bridges from ACPI tables.  In fact,
>> the *binding* itself is managed by the code in drivers/acpi/glue.c.
>>
>> Also, please have a look at my suggestion in the last reply to Yinghai:
>>
>> http://marc.info/?l=linux-pci&m=135522965707752&w=2
>>
>> In fact, I think we can go even further than that.  Namely, if we populate the
>> ACPI handle of the device in pci_scan_device(), then we can just move the PM
>> notifier and wakeup setup to platform_pci_wakeup_init(), where it should be
>> (we'll also need to add a corresponding _exit() function, then, but that'll be
>> much cleaner anyway).
>>
>> Then, the remaining thing would be to ensure that _PRT entries are parsed
>> as appropriate somewhere around pci_init_capabilities().
>>
>> Also, I wonder if you can help test the $subject patchset on a system with
>> hardware PCI hotplug (preferably on top of the linux-pm.git/master branch)?
>>
> Hi Rafael,
>    We are doing test for this series patches, I will send out the test result as soon.
Hi Rafael,
	We have tried to merge your patchset with IOH hotplug patchsets from Yinghai,
and obviously it's not a ease task and we have run into panics. We will try to find
some ways to test your patchset only next step.
	Thanks!

> 
> Thanks!
> Yijing
> 
> 
> 

