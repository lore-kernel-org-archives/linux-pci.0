Return-Path: <cov@codeaurora.org>
Return-Path: <cov@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 20 Sep 2016 21:15:14 -0400
From: cov@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, will.deacon@arm.com,
 catalin.marinas@arm.com, rafael@kernel.org, Lorenzo.Pieralisi@arm.com,
 arnd@arndb.de, hanjun.guo@linaro.org, okaya@codeaurora.org,
 jchandra@broadcom.com, dhdang@apm.com, ard.biesheuvel@linaro.org,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 jeremy.linton@arm.com, liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
 jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
In-Reply-To: <20160920192636.GB4941@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <20160920192636.GB4941@localhost>
Message-ID: <0429663d51ed8e93fb0c96261dd2ecc7@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Thomasz,

On 2016-09-20 15:26, Bjorn Helgaas wrote:
> On Fri, Sep 09, 2016 at 09:24:02PM +0200, Tomasz Nowicki wrote:
>> Quirk handling relies on an idea of simple static array which contains
>> quirk enties. Each entry consists of identification information (IDs 
>> from
>> standard header of MCFG table) along with custom pci_ecam_ops 
>> structure and
>> configuration space resource structure. This way it is possible find
>> corresponding quirk entries and override pci_ecam_ops and PCI 
>> configuration
>> space regions.
>> 
>> As an example, the last 3 patches present quirk handling mechanism 
>> usage for
>> ThunderX.
>> 
>> v5 -> v6
>> - rebase against v4.8-rc5
>> - drop patch 1 form previous series
>> - keep pci_acpi_setup_ecam_mapping() in ARM64 arch directory
>> - move quirk code to pci_mcfg.c
>> - restrict quirk to override pci_ecam_ops and CFG resource structure
>>   only, no init call any more
>> - split ThunderX quirks into the smaller chunks
>> - add ThunderX pass1.x silicon revision support
>> 
>> v4 -> v5
>> - rebase against v4.8-rc1
>> - rework to exact MCFG OEM ID, TABLE ID, rev match
>>   - use memcmp instead of strncmp
>>   - no substring match
>> - fix typos and dmesg message
>> 
>> Tomasz Nowicki (5):
>>   PCI/ACPI: Extend pci_mcfg_lookup() responsibilities
>>   PCI/ACPI: Check platform specific ECAM quirks
>>   PCI: thunder-pem: Allow to probe PEM-specific register range for 
>> ACPI
>>     case
>>   PCI: thunder: Enable ACPI PCI controller for ThunderX pass2.x 
>> silicon
>>     version
>>   PCI: thunder: Enable ACPI PCI controller for ThunderX pass1.x 
>> silicon
>>     version
>> 
>>  arch/arm64/kernel/pci.c             |  17 ++--
>>  drivers/acpi/pci_mcfg.c             | 168 
>> +++++++++++++++++++++++++++++++++++-
>>  drivers/pci/host/pci-thunder-ecam.c |   2 +-
>>  drivers/pci/host/pci-thunder-pem.c  |  63 +++++++++++---
>>  include/linux/pci-acpi.h            |   4 +-
>>  include/linux/pci-ecam.h            |   7 ++
>>  6 files changed, 230 insertions(+), 31 deletions(-)
> 
> I'm not quite ready to merge these because we haven't resolved the
> question of how to expose the resources used by the memory-mapped
> config space.  I'm fine with the first two patches (I did make a
> couple trivial changes, see below), but there's no point in merging
> them until we merge a user for them.
> 
> I pushed the series to pci/ecam-v6 for build testing and discussion.
> The diff (the changes I made locally) from v6 as posted by Tomasz is
> below.

Rebasing the following simple quirks framework user onto this branch,
I have some questions.

https://source.codeaurora.org/quic/server/kernel/commit/?h=cov/4.8-rc2-testing&id=83b766cafef11c107b10177d0626db311f382299

> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index eb14f74..bb3b8ad 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -42,86 +42,59 @@ struct mcfg_fixup {
>  	struct resource cfgres;
>  };
> 
> -#define MCFG_DOM_ANY			(-1)

Did you delete this because there were no current users, because you'd
prefer users just use "-1", or for some other reason?

>  #define MCFG_BUS_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
>  						((end) - (start) + 1),	\
>  						NULL, IORESOURCE_BUS)
> -#define MCFG_BUS_ANY		MCFG_BUS_RANGE(0x0, 0xff)
> -#define MCFG_RES_EMPTY		DEFINE_RES_NAMED(0, 0, NULL, 0)
> +#define MCFG_BUS_ANY			MCFG_BUS_RANGE(0x0, 0xff)
> 
>  static struct mcfg_fixup mcfg_quirks[] = {
> -/*	{ OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, cfgres, ops }, */
> +/*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, cfgres, ops }, */

This comment appears to have the order of cfgres and ops reversed.

Am I correct in reading that if a user of the framework does not wish to
override cfgres they must place a struct resource with .start = 0 at the
end of their mcfg_quirks entry? If so, I guess I have the same questions
about removing MCFG_RES_EMPTY as I do about removing MCFG_DOM_ANY.

Thanks,
Cov
