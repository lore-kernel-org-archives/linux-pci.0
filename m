Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <54F5F59C.5000603@ti.com>
References: <1425333548-8802-1-git-send-email-m-karicheri2@ti.com>
 <CAErSpo7MsxgVZyhpijRzVN7mVNcbN7M4A4W-UKaNs4AnmGrB6g@mail.gmail.com> <54F5F59C.5000603@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Mar 2015 14:53:56 -0600
Message-ID: <CAErSpo5gPVqRrzZ3LbWvLRchr6SjxN0eve62dTJamfz+=O882Q@mail.gmail.com>
Subject: Re: [PATCH - v7] of: Move of_dma_configure() to device.c to help re-use
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Tue, Mar 3, 2015 at 11:55 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> On 03/02/2015 10:43 PM, Bjorn Helgaas wrote:
>>
>> On Mon, Mar 2, 2015 at 3:59 PM, Murali Karicheri<m-karicheri2@ti.com>
>> wrote:
>>>
>>> Move of_dma_configure() to device.c so it can be re-used for PCI devices
>>> to
>>> obtain DMA configuration from DT.  Also add a second argument so that for
>>> PCI, the DT node of root bus host bridge can be used to obtain the DMA
>>> configuration for the slave PCI device.
>>>
>>> Tested-by: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>  (AMD
>>> Seattle)
>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>>> Signed-off-by: Bjorn Helgaas<bhelgaas@google.com>
>>> Reviewed-by: Catalin Marinas<catalin.marinas@arm.com>
>>> Acked-by: Will Deacon<will.deacon@arm.com>
>>> CC: Joerg Roedel<joro@8bytes.org>
>>> CC: Grant Likely<grant.likely@linaro.org>
>>> CC: Rob Herring<robh+dt@kernel.org>
>>> CC: Russell King<linux@arm.linux.org.uk>
>>> CC: Arnd Bergmann<arnd@arndb.de>
>>> ---
>>>   - Based on the existing patch applied to arm-pci/pci/iommu for pci next
>>> (Bjorn)
>>>   - Fixed the build issue reported on ARCH=x86_64
>>
>>
>> Hi Murali,
>>
>> Can you please repost the entire series with fixed patches?  It's
>> easier for me to reapply the whole thing at once than it is to keep
>> track of and fiddle with individual patches.
>>
>> Bjorn
>
> Bjorn,
>
> Ok. I have just posted v8 of the series including all patches.

Thanks, I put them on a pci/murali-v8 branch for now.  I'm assuming
you want them to go through my tree.  In the cover letter, you
mentioned the "arm-pci iommu branch", so if that means you want them
via an ARM tree instead of mine, just let me know.  I assume the build
will be clean and I'll rename it back to pci/iommu.

Bjorn
