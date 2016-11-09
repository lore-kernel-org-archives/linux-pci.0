Return-Path: <cov@codeaurora.org>
Return-Path: <cov@codeaurora.org>
Subject: Re: [PATCHv2] PCI: QDF2432 32 bit config space accessors
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
 <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
 <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
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
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <aa37ca67-9909-e8f2-1a3e-b724cdb46c7b@codeaurora.org>
Date: Wed, 9 Nov 2016 14:25:56 -0500
MIME-Version: 1.0
In-Reply-To: <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 11/02/2016 12:08 PM, Bjorn Helgaas wrote:
> On Tue, Nov 01, 2016 at 07:06:31AM -0600, cov@codeaurora.org wrote:
>> Hi Bjorn,
>>
>> On 2016-10-31 15:48, Bjorn Helgaas wrote:
>>> On Wed, Sep 21, 2016 at 06:38:05PM -0400, Christopher Covington wrote:
>>>> The Qualcomm Technologies QDF2432 SoC does not support accesses
>>>> smaller
>>>> than 32 bits to the PCI configuration space. Register the appropriate
>>>> quirk.
>>>>
>>>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>>>
>>> Hi Christopher,
>>>
>>> Can you rebase this against v4.9-rc1?  It no longer applies to my tree.
>>
>> I apologize for not being clearer. This patch depends on:
>>
>> PCI/ACPI: Extend pci_mcfg_lookup() responsibilities
>> PCI/ACPI: Check platform-specific ECAM quirks
>>
>> These patches from Tomasz Nowicki were previously in your pci/ecam-v6
>> branch, but that seems to have come and gone. How would you like to
>> proceed?
> 
> Oh yes, that's right, I forgot that connection.  I'm afraid I kind of
> dropped the ball on that thread, so I went back and read through it
> again.
> 
> I *think* the current state is:
> 
>   - I'm OK with the first two patches that add the quirk
>     infrastructure.
> 
>   - My issue with the last three patches that add ThunderX quirks is
>     that there's no generic description of the ECAM address space.
> 
> So if I understand correctly, your Qualcomm patch depends only on the
> first two patches.
> 
> Then the question is how the Qualcomm ECAM address space is described.
> Your quirk overrides the default pci_generic_ecam_ops with the
> &pci_32b_ops, but it doesn't touch the address space part, so I assume
> the bus ranges and corresponding address space in your MCFG is
> correct.  So far, so good.
> 
> Is there also an ACPI device that contains that space in _CRS?  I
> think we concluded that the standard solution is to describe this with
> a PNP0C02 device.
> 
> Would you mind opening a bugzilla at bugzilla.kernel.org and attaching
> the dmesg log, /proc/iomem, and maybe a DSDT dump?  I'd like to have
> something to point at to say "if you need an MCFG quirk, you need the
> MCFG bit and *also* these other related ACPI device bits, and here's
> how it should be done."

We're working to add the PNP0C02 resource to future firmware, but it's
not in the current firmware. Are dmesg and /proc/iomem from the
current firmware interesting or should we wait for the update to file?

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
