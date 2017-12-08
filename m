Return-Path: <SRS0=owfT=DE=gmail.com=f.fainelli@kernel.org>
Return-Path: <SRS0=owfT=DE=gmail.com=f.fainelli@kernel.org>
Subject: Re: [PATCH v3 1/8] SOC: brcmstb: add memory API
To: Bjorn Helgaas <helgaas@kernel.org>, Jim Quinlan <jim2101024@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, linux-mips@linux-mips.org,
 linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
 Ralf Baechle <ralf@linux-mips.org>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>, linux-arm-kernel@lists.infradead.org
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-2-git-send-email-jim2101024@gmail.com>
 <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <12a4228d-ab5e-35e4-a65c-24b0e64b1300@gmail.com>
Date: Fri, 8 Dec 2017 15:28:53 -0800
MIME-Version: 1.0
In-Reply-To: <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>



On 12/05/2017 12:59 PM, Bjorn Helgaas wrote:
> On Tue, Nov 14, 2017 at 05:12:05PM -0500, Jim Quinlan wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> This commit adds a memory API suitable for ascertaining the sizes of
>> each of the N memory controllers in a Broadcom STB chip.  Its first
>> user will be the Broadcom STB PCIe root complex driver, which needs
>> to know these sizes to properly set up DMA mappings for inbound
>> regions.
>>
>> We cannot use memblock here or anything like what Linux provides
>> because it collapses adjacent regions within a larger block, and here
>> we actually need per-memory controller addresses and sizes, which is
>> why we resort to manual DT parsing.
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>  drivers/soc/bcm/brcmstb/Makefile |   2 +-
>>  drivers/soc/bcm/brcmstb/memory.c | 172 +++++++++++++++++++++++++++++++++++++++
>>  include/soc/brcmstb/memory_api.h |  25 ++++++
>>  3 files changed, 198 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/soc/bcm/brcmstb/memory.c
>>  create mode 100644 include/soc/brcmstb/memory_api.h
>>
>> diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
>> index 9120b27..4cea7b6 100644
>> --- a/drivers/soc/bcm/brcmstb/Makefile
>> +++ b/drivers/soc/bcm/brcmstb/Makefile
>> @@ -1 +1 @@
>> -obj-y				+= common.o biuctrl.o
>> +obj-y				+= common.o biuctrl.o memory.o
>> diff --git a/drivers/soc/bcm/brcmstb/memory.c b/drivers/soc/bcm/brcmstb/memory.c
>> new file mode 100644
>> index 0000000..eb647ad9
>> --- /dev/null
>> +++ b/drivers/soc/bcm/brcmstb/memory.c
> 
> I sort of assume based on [1] that every new file should have an SPDX
> identifier ("The Linux kernel requires the precise SPDX identifier in
> all source files") and that the actual text of the GPL can be omitted.
> 
> Only a few files in drivers/pci currently have an SPDX identifier.  I
> don't know if that's oversight or work-in-progress or what.
> 
> [1] https://lkml.kernel.org/r/20171204212120.484179273@linutronix.de

This was submitted before SPDX was consistently enforced tree wide, so
yes we should fix this.

Any other comment besides that?
-- 
Florian
