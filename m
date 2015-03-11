Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40664 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbCKP7i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 11:59:38 -0400
MIME-Version: 1.0
In-Reply-To: <55005F0F.5080302@ti.com>
References: <1426001139-18419-1-git-send-email-m-karicheri2@ti.com>
 <CAL_JsqJPvW5q4XwwenFTHrDG4cU5uTd7n-vLKj0mdV9FbVC4Ag@mail.gmail.com>
 <20150311124911.GA8656@n2100.arm.linux.org.uk> <55005F0F.5080302@ti.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 11 Mar 2015 10:59:16 -0500
Message-ID: <CAL_JsqLi+bo=zEobrduWW9D1KtTGtfO17XYw6jGjh_u_foy_VA@mail.gmail.com>
Subject: Re: [PATCH] pci: of : fix BUG: unable to handle kernel
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	Will Deacon <will.deacon@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 11, 2015 at 10:28 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> On 03/11/2015 08:49 AM, Russell King - ARM Linux wrote:
>>
>> On Wed, Mar 11, 2015 at 07:35:45AM -0500, Rob Herring wrote:
>>>
>>> On Tue, Mar 10, 2015 at 10:25 AM, Murali Karicheri<m-karicheri2@ti.com>
>>> wrote:
>>>>
>>>> On some platforms such as that based on x86, ia64 etc, root bus is
>>>> created with parent node passed in as NULL to pci_create_root_bus().
>>>> On these platforms, the patch series "PCI: get DMA configuration from
>>>> parent device" when applied causes kernel crash. So add a check for this
>>>> in of_pci_dma_configure()
>>>
>>>
>>> Wouldn't these arches have OF disabled and call an empty function?
>>> Regardless, we still need this.
>>>
>>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>>>
>>>
>>> I'm assuming Bjorn will apply this.
>>>
>>> Acked-by: Rob Herring<robh@kernel.org>
>>
>>
>> It might be an idea to read the subject line...
>>
>> "fix BUG: unable to handle kernel"
>
> Russell,
>
> I will fix the subject as "fix BUG: unable to handle kernel NULL pointer"
> and re-send.

Russell's point is the subject applies to every fix for a BUG.
Something like "of/pci: fix of_pci_dma_configure parent ptr NULL
dereference".

Rob
