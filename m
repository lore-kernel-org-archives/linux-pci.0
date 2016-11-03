Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCHv2] PCI: QDF2432 32 bit config space accessors
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
 <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
 <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
 <3fd26a0d-a5c2-c385-866e-b957dffb7dda@codeaurora.org>
 <20161103140058.GA31142@bhelgaas-glaptop.roam.corp.google.com>
 <aa8bc916-9363-2de7-2997-4ce470562b2c@codeaurora.org>
Cc: cov@codeaurora.org, Tomasz Nowicki <tn@semihalf.com>,
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <fdabd92b-1e5f-e66a-a8ec-0f763b74de99@codeaurora.org>
Date: Thu, 3 Nov 2016 13:06:28 -0400
MIME-Version: 1.0
In-Reply-To: <aa8bc916-9363-2de7-2997-4ce470562b2c@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 11/3/2016 12:58 PM, Sinan Kaya wrote:
>> > This is the crucial point I have failed to communicate clearly: the
>> > PNP0C02 resource is *always* required, even if the MCFG is correct.
>> > 
> Interesting...
> 
> It looks like there is a lot of lessons learnt here from history.
> 
> I think this requirement is only true if your system DDR space and PCIe
> space overlaps in the memory map. I understand that Intel systems allow
> sharing of these two memory ranges. An OS could potentially reclaim this
> address range.
> 
> If there is no overlap and PCI is not enabled, there can't be any SW entity
> to reclaim this space. 
> 
> Did I miss something?
> 

For protection, it makes sense to reserve this range. I'm trying to understand
who would claim this range.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
