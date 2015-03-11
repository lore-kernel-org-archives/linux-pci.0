Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51497 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788AbbCKP2c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Mar 2015 11:28:32 -0400
Message-ID: <55005F0F.5080302@ti.com>
Date: Wed, 11 Mar 2015 11:28:15 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Rob Herring <robherring2@gmail.com>,
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
Subject: Re: [PATCH] pci: of : fix BUG: unable to handle kernel
References: <1426001139-18419-1-git-send-email-m-karicheri2@ti.com> <CAL_JsqJPvW5q4XwwenFTHrDG4cU5uTd7n-vLKj0mdV9FbVC4Ag@mail.gmail.com> <20150311124911.GA8656@n2100.arm.linux.org.uk>
In-Reply-To: <20150311124911.GA8656@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/11/2015 08:49 AM, Russell King - ARM Linux wrote:
> On Wed, Mar 11, 2015 at 07:35:45AM -0500, Rob Herring wrote:
>> On Tue, Mar 10, 2015 at 10:25 AM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
>>> On some platforms such as that based on x86, ia64 etc, root bus is
>>> created with parent node passed in as NULL to pci_create_root_bus().
>>> On these platforms, the patch series "PCI: get DMA configuration from
>>> parent device" when applied causes kernel crash. So add a check for this
>>> in of_pci_dma_configure()
>>
>> Wouldn't these arches have OF disabled and call an empty function?
>> Regardless, we still need this.
>>
>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>>
>> I'm assuming Bjorn will apply this.
>>
>> Acked-by: Rob Herring<robh@kernel.org>
>
> It might be an idea to read the subject line...
>
> "fix BUG: unable to handle kernel"
Russell,

I will fix the subject as "fix BUG: unable to handle kernel NULL 
pointer" and re-send.

Thanks

Murali
>
> which is meaningless.  It needs a much better subject line before it can
> be committed.
>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
