Return-Path: <cov@codeaurora.org>
Return-Path: <cov@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 01 Nov 2016 07:06:31 -0600
From: cov@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
 will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
 Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org,
 jchandra@broadcom.com, dhdang@apm.com, ard.biesheuvel@linaro.org,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 jeremy.linton@arm.com, liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
 jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] PCI: QDF2432 32 bit config space accessors
In-Reply-To: <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2016-10-31 15:48, Bjorn Helgaas wrote:
> On Wed, Sep 21, 2016 at 06:38:05PM -0400, Christopher Covington wrote:
>> The Qualcomm Technologies QDF2432 SoC does not support accesses 
>> smaller
>> than 32 bits to the PCI configuration space. Register the appropriate
>> quirk.
>> 
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> 
> Hi Christopher,
> 
> Can you rebase this against v4.9-rc1?  It no longer applies to my tree.

I apologize for not being clearer. This patch depends on:

PCI/ACPI: Extend pci_mcfg_lookup() responsibilities
PCI/ACPI: Check platform-specific ECAM quirks

These patches from Tomasz Nowicki were previously in your pci/ecam-v6
branch, but that seems to have come and gone. How would you like to
proceed?

> Note that this hardware is not spec-compliant since it doesn't support
> sub-32 bit config writes.  I just proposed a patch to warn about that
> [1], so if/when we merge that patch and this one, you'll start seeing
> those warnings.
> 
> [1]
> http://lkml.kernel.org/r/20161031213902.6340.96123.stgit@bhelgaas-glaptop.roam.corp.google.com

That looks great, thank you. The earlier PCI HDL and SoC vendors can be
made aware of such problems, the better.

Thanks,
Cov
