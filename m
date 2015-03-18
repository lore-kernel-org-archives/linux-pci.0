Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35044 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754848AbbCRSwF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Mar 2015 14:52:05 -0400
Message-ID: <5509C951.30402@arm.com>
Date: Wed, 18 Mar 2015 18:52:01 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Duc Dang <dhdang@apm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, Feng Kan <fkan@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Loc Ho <lho@apm.com>
Subject: Re: [PATCH v2 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
References: <cover.1425497218.git.dhdang@apm.com> <ca98e05f8a8dabdc6cc5b6e8c3ce50cf4e900fac.1425497218.git.dhdang@apm.com> <5509BE7C.1000901@arm.com> <CADaLNDn0V8F27Yu1-j8H0Dw2t-Ac04TZcbtsg++ALdB4orXrUQ@mail.gmail.com>
In-Reply-To: <CADaLNDn0V8F27Yu1-j8H0Dw2t-Ac04TZcbtsg++ALdB4orXrUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18/03/15 18:29, Duc Dang wrote:
> On Wed, Mar 18, 2015 at 11:05 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 04/03/15 19:39, Duc Dang wrote:
>>> X-Gene v1 SOC supports total 2688 MSI/MSIX vectors coalesced into
>>> 16 HW IRQ lines.
>>>
>>> Signed-off-by: Duc Dang <dhdang@apm.com>
>>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>>
>> I just had a quick look at this, and this seems to be going in the exact
>> opposite direction compared to what we now have on arm64, where we move
>> away from using struct msi_controller for most thing, and implement PCI
>> MSI/MSIX in a generic way, using MSI domains.
>>
>> I suggest you have a look at how GICv2m and GICv3 ITS implement the MSI
>> support. You can also have a look at what I did for the Tegra MSI
>> controller in this patch:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/kill-msi-controller&id=83b3602fcee7972b9d549ed729b56ec28de16081
>>
>> Eventually, the plan is to kill msi_controller entirely, so introducing
>> new drivers that rely on it is not something I'm eager to see.
> 
> Thanks, Marc.
> 
>  X-Gene 1 MSI is handled by separate MSI controller block, so its
> driver implementation is different from GICv2m and GICv3. I will refer

It will certainly be different in the sense that you won't use a stacked
domain on top of the GIC. But what I want to see is the use of a generic
pci_msi_domain on top of an irq_domain, just like we have on v2m and v3.
Thomas has also been vocal enough about that in the past, and x86 is
going down that road as well.

> to what you did for Tegra MSI, but I don't see your latest changes in
> 4.0-rc4. Is the change you made for Tegra MSI going to mainline soon?

Not yet. As you can see in this branch, this relies on some other
cleanups. But you can already convert most of your driver and put it in
the shape that matches what we have for v2m and v3. Once the required
cleanups are in, I'll remove the last traces of msi_controller myself if
necessary.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
