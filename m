Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [Linaro-acpi] ACPI namespace details for ARM64
To: Al Stone <al.stone@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org
References: <20161109220506.GN14322@bhelgaas-glaptop.roam.corp.google.com>
 <a0829be4-6324-758b-2fe6-a274f715a3a9@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Al Stone <ahs@redhat.com>,
 Robert Richter <rrichter@cavium.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, Arnd Bergmann
 <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jon Masters <jcm@redhat.com>, linaro-acpi@lists.linaro.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Don Dutile <ddutile@redhat.com>, Christopher Covington <cov@codeaurora.org>,
 Tomasz Nowicki <tn@semihalf.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <98c9564d-17f9-f549-6dd4-5c6abc1ba1a3@codeaurora.org>
Date: Fri, 11 Nov 2016 09:24:28 -0500
MIME-Version: 1.0
In-Reply-To: <a0829be4-6324-758b-2fe6-a274f715a3a9@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/10/2016 6:18 PM, Al Stone wrote:
> On 11/09/2016 03:05 PM, Bjorn Helgaas wrote:
>> Hi all,
>>
>> We've been working through the details of getting ACPI to work on
>> arm64, and there have been lots of questions about what this means for
>> PCI.  I've outlined this for several people individually, but I'm
>> going to send this separately, apart from a specific patch series, to
>> make sure we're all on the same page.  Please correct my errors and
>> misunderstandings.
>>
>> Bjorn
>>
>> [snip....]
> 
> A big +1 to all of this.  This also looks like something that should
> be added to either PCI, ACPI or arm64 documentation (or even all three).
> What do you think?


I agree. In order to have compliant systems, we have to make PNP0C02 required
in the PCIe appendix of the SBSA specification.

> 
> Thank you for putting this together, Bjorn.
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
