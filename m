Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0120.outbound.protection.outlook.com ([65.55.169.120]:39008
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751469AbaILKB0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Sep 2014 06:01:26 -0400
Message-ID: <5412C451.609@amd.com>
Date: Fri, 12 Sep 2014 05:00:49 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"Rob Herring" <robh+dt@kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	"Will Deacon" <Will.Deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Device Tree ML" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 00/10] Support for creating generic PCI host bridges
 from DT
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <5412ADE9.2050708@amd.com>
 <20140912093018.GX27864@e106497-lin.cambridge.arm.com>
In-Reply-To: <20140912093018.GX27864@e106497-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/12/2014 4:30 AM, Liviu Dudau wrote:
> On Fri, Sep 12, 2014 at 09:25:13AM +0100, Suravee Suthikulpanit wrote:
>> On 9/8/2014 8:54 AM, Liviu Dudau wrote:
>>> This is my version 10 of the attempt at adding support for generic PCI host
>>> bridge controllers that make use of device tree information to
>>> configure themselves. This version reverses v9's attempt to create one function
>>> to drive the whole process of extracting the host bridge ranges, setup the
>>> host bridge driver and then scan the root bus behind the host bridge. While it
>>> would've been quite user friendly, I agree that it would've caused a lot of pain
>>> in the future.
>>>
>>> I would like to get ACKs for the remaining patches as I would like to integrate
>>> this into -next in the following week.
>>>
>>> This version marks an implementation break with the previous versions as
>>> of_create_pci_host_bridge() is now gone. It gets replaced by
>>> of_pci_get_host_bridge_resources() that only parses the DT and extracts the
>>> relevant ranges and converts them to resources. The updated host bridge drivers
>>> will have to follow the guidelines in this example code:
>>>
>>> static int foohb_probe(struct platform_device *pdev)
>>> {
>>> 	struct device_node *dn = pdev->dev.of_node;
>>> 	struct foohb_drv *drv;
>>> 	resource_size_t io_base = 0;  /* phys address for start of IO */
>>> 	struct pci_bus *bus;
>>> 	int err = 0;
>>> 	LIST_HEAD(res);
>>>
>>> 	.....
>>> 	err = of_pci_get_host_bridge_resources(dn, 0, 255, &res, &io_base);
>>> 	if (err)
>>> 		goto err_handling;
>>> 	err = foohb_setup(drv, ...., &res, &io_base);
>>> 	if (err)
>>> 		goto err_handling;
>
> Hi Suravee,
>
>>
>> My understanding is that the "foohb_setup" above is supposed to be equivalent
>> to the "int (*setup)(struct pci_host_bridge *, resource_size_t)" in V9 that was
>> passed in as an argument of "of_create_pci_hot_bridge()".
>
> Correct. Parameters are probably different, but it is internal to your driver so
> you can do whatever you want there.
>
>>
>> The problem I have is I need an intermediate step between "pci_create_root_bus()"
>> and "pci_scan_child_bus()" in order to update the information such as the "pci_bus->msi"
>> before this is propagate down to the child bus during the "pci_scan_child_bus"
>> which is also called in the pci_scan_root_bus() function.
>
> How did that work with my v9 patchset? How does it work for other MSI-aware platforms?
> Are they not using pci_scan_child_bus()?

In the of_create_pci_host_bridge of V9, you call the setup function between "pci_create_root_bus()"
and "pci_scan_child_bus()". At that point, I can update the "root_bus->msi" to point to my
"struct msi_chip" which was created during GICv2m initialization
(Please see http://marc.info/?l=linux-kernel&m=141034053331632&w=2).
Then, when a child bus is created, it propagate this msi_chip pointer from the parent bus.

Suravee


