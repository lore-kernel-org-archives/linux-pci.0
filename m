Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to
 drivers/acpi
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <20160303225152.GA10472@localhost>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <56D954F5.3010403@semihalf.com>
Date: Fri, 4 Mar 2016 10:27:17 +0100
MIME-Version: 1.0
In-Reply-To: <20160303225152.GA10472@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 03.03.2016 23:51, Bjorn Helgaas wrote:
> Hi Tomasz, Jayachandran, et al,
>
> On Tue, Feb 16, 2016 at 02:53:31PM +0100, Tomasz Nowicki wrote:
>> From: Jayachandran C <jchandra@broadcom.com>
>>
>> Move pci_mmcfg_list handling to a drivers/acpi/pci_mcfg.c. This is
>> to share the API and code with ARM64 later. The corresponding
>> declarations are moved from asm/pci_x86.h to linux/pci-acpi.h
>>
>> As a part of this we introduce three functions that can be
>> implemented by the arch code: pci_mmconfig_map_resource() to map a
>> mcfg entry, pci_mmconfig_unmap_resource to do the corresponding
>> unmap and pci_mmconfig_enabled to see if the arch setup of
>> mcfg entries was successful. We also provide weak implementations
>> of these, which will be used from ARM64. On x86, we retain the
>> old logic by providing platform specific implementation.
>>
>> This patch is purely rearranging code, it should not have any
>> impact on the logic of MCFG parsing or list handling.
>
> I definitely want to figure out how to make this work well on ARM64.
> I need to ponder this some more, so these are just some initial
> thoughts.
>
> My first impression is that (a) the x86 MCFG code is an unmitigated
> disaster, and (b) we're trying a little too hard to make that mess
> generic.  I think we might be better served if we came up with some
> cleaner, more generic code that we can use for ARM64 today, and
> migrate x86 toward that over time.
>
> My concern is that if we elevate the current x86 code to be
> "arch-independent", we will be perpetuating some interfaces and
> designs that shouldn't be allowed to escape arch/x86.
>
> Some of the code that moved to drivers/acpi/pci_mcfg.c is not really
> ACPI-specific, and could potentially be used for non-ACPI bridges that
> support ECAM.  I'd like to see that sort of code moved to a new file
> like drivers/pci/ecam.c.

Actually I split it as you suggested in the previous patch set. Please 
have a look at:
https://lkml.org/lkml/2016/2/4/646

Especially patches [0-6] which handle MMCONFIG refactoring.

Thanks,
Tomasz
