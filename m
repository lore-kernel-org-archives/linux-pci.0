Return-Path: <cov@codeaurora.org>
Return-Path: <cov@codeaurora.org>
Subject: Re: [PATCH V6 2/5] PCI/ACPI: Check platform specific ECAM quirks
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "liudongdong (C)" <liudongdong3@huawei.com>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-3-git-send-email-tn@semihalf.com>
 <57D76626.1050109@huawei.com>
 <bac9f822-ce0a-7070-94df-4d66fc30f774@semihalf.com>
 <57D7E53F.1000106@huawei.com> <20160915105849.GA10345@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8730EA@lhreml507-mbx>
Cc: Tomasz Nowicki <tn@semihalf.com>, "helgaas@kernel.org"
 <helgaas@kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "jchandra@broadcom.com" <jchandra@broadcom.com>,
 "dhdang@apm.com" <dhdang@apm.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
 "mw@semihalf.com" <mw@semihalf.com>,
 "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
 "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
 Wangyijing <wangyijing@huawei.com>, "msalter@redhat.com"
 <msalter@redhat.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
 "jcm@redhat.com" <jcm@redhat.com>,
 "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
 "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
 "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <42c3f965-b40c-f2bb-e12c-34da6af1a4b7@codeaurora.org>
Date: Fri, 16 Sep 2016 08:27:40 -0400
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F8730EA@lhreml507-mbx>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 09/16/2016 05:02 AM, Gabriele Paoloni wrote:
> Hi Lorenzo and Tomasz
> 
> Many Thanks for looking at this
> 
>> -----Original Message-----
>> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
>> Sent: 15 September 2016 11:59
>> To: liudongdong (C)
>> Cc: Tomasz Nowicki; helgaas@kernel.org; will.deacon@arm.com;
>> catalin.marinas@arm.com; rafael@kernel.org; arnd@arndb.de;
>> hanjun.guo@linaro.org; okaya@codeaurora.org; jchandra@broadcom.com;
>> cov@codeaurora.org; dhdang@apm.com; ard.biesheuvel@linaro.org;
>> robert.richter@caviumnetworks.com; mw@semihalf.com;
>> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; Wangyijing;
>> msalter@redhat.com; linux-pci@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linaro-acpi@lists.linaro.org;
>> jcm@redhat.com; andrea.gallo@linaro.org; jeremy.linton@arm.com;
>> Gabriele Paoloni; jhugo@codeaurora.org; linux-acpi@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH V6 2/5] PCI/ACPI: Check platform specific ECAM
>> quirks
>>
>> On Tue, Sep 13, 2016 at 07:38:39PM +0800, Dongdong Liu wrote:
>>
>> [...]
>>
>>> Our host bridge is non ECAM only for the RC bus config space;
>>> for any other bus underneath the root bus we support ECAM access.
>>>
>>> RC config resource with hardcode as DEFINE_RES_MEM(0xb0070000,
>> SZ_4K),
>>> EP config resource we get it from MCFG table.
>>> So we need to override ops, but config resource we only need to
>> hardcode with RC config resource.
>>>
>>> Our host controller ACPI support patch can be found:
>>> https://lkml.org/lkml/2016/8/31/340
>>
>> Sorry I misread your code. IIUC you create an array of resources that
>> represent non-ECAM config space (and incidentally contain debug
>> registers to check the link status - that you need to check for every
>> given config access (?)), but you still need to have an MCFG entry that
> 
> The link status check is inherited from the designware framework (see
> http://lxr.free-electrons.com/source/drivers/pci/host/pcie-designware.c#L678)
> 
> However I think that in this case we can just check the link status
> in our init function and return an error if the link is down
> 
>> covers the bus number subject to quirk to make sure this mechanism
>> works. Correct ?
> 
> Well we need the quirks for the root bus numbers but if read this v6
> quirk mechanism correctly even if we do not specify an mcfg entry for
> bus 0 oci_mcfg_match_quirks() is called anyway and we can set our
> special configuration space addresses for the root buses (i.e. I think
> we can have a clean MCFG table with entries only for those bus ranges
> that are really ECAM)  
> 
>>
>> This also means that, with the MCFG tables you have and current
>> mainline kernel you are able to probe a root bridge (because the MCFG
>> table covers the bus number that is not ECAM), with enumeration
>> going haywire because it is trying to carry out ECAM accesses on
>> non-ECAM space.
> 
> Yes correct, we cannot access the host controller configuration space
> with our current MCFG table and current Linux mainline
> 
>>
>> Is my reading correct ?
>>
>> Anyway, that's not stricly related to this discussion, it is time we
>> converge on this patchset, we can add a domain range if that
>> simplifies things.
> 
> IMO it would be better to have the domain range to avoid
> a very large and repetitive static quirk array

The v6 framework requires what, 21 additional lines of quirk data? What
if you were to define some preprocessor macros to slim it down? I think
something like the following would bring it down to roughly 7 additional
lines.

#define PCI_ACPI_QUIRK_QUAD_DOM(rev, dom, ops) \
    { "HISI ", rev, 0, dom+0, MCFG_BUS_ANY, ops,
      MCFG_RES_EMPTY}, \
    { "HISI ", rev, 0, dom+1, MCFG_BUS_ANY, ops,
      MCFG_RES_EMPTY}, \
    { "HISI ", rev, 0, dom+2, MCFG_BUS_ANY, ops,
      MCFG_RES_EMPTY}, \
    { "HISI ", rev, 0, dom+3, MCFG_BUS_ANY, ops,
      MCFG_RES_EMPTY},

PCI_ACPI_QUIRK_QUAD_DOM("HIP05 ", 0, &hisi_pcie_hip05_ops)
PCI_ACPI_QUIRK_QUAD_DOM("HIP06 ", 0, &hisi_pcie_hip05_ops)
PCI_ACPI_QUIRK_QUAD_DOM("HIP07 ", 0, &hisi_pcie_hip06_ops)
PCI_ACPI_QUIRK_QUAD_DOM("HIP07 ", 4, &hisi_pcie_hip07_ops)
PCI_ACPI_QUIRK_QUAD_DOM("HIP07 ", 8, &hisi_pcie_hip07_ops)
PCI_ACPI_QUIRK_QUAD_DOM("HIP07 ", 12, &hisi_pcie_hip07_ops)

Cov
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
