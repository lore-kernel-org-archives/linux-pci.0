Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
In-Reply-To: <036882b9-b781-cb56-2bcf-35afb21b2812@codeaurora.org>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx> <575EBD13.8080808@codeaurora.org>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782E15@lhreml507-mbx> <b7202ebbb30f2c715427fbb387129e9c@codeaurora.org>
 <036882b9-b781-cb56-2bcf-35afb21b2812@codeaurora.org>
From: Duc Dang <dhdang@apm.com>
Date: Mon, 13 Jun 2016 14:07:23 -0700
Message-ID: <CADaLND=aWkENZVK1Ce9NT4LygGa3LTtG1dCabokDADjEJEgeFQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors
 against platfrom specific ECAM quirks
To: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: okaya@codeaurora.org, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
	"Chenxin (Charles)" <charles.chenxin@huawei.com>, Wangyijing <wangyijing@huawei.com>,
	Andrea Gallo <andrea.gallo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, linaro-acpi@lists.linaro.org,
	David Daney <ddaney@caviumnetworks.com>, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Bjorn Helgaas <helgaas@kernel.org>,
	"liudongdong (C)" <liudongdong3@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Jon Masters <jcm@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <Liviu.Dudau@arm.com>,
	Mark Salter <msalter@redhat.com>, Christopher Covington <cov@codeaurora.org>, Marcin Wojtas <mw@semihalf.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Jayachandran C <jchandra@broadcom.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 13, 2016 at 8:59 AM, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> On 6/13/2016 9:12 AM, okaya@codeaurora.org wrote:
>>
>> On 2016-06-13 10:29, Gabriele Paoloni wrote:
>>>
>>> Hi Sinan
>>>
>>>> -----Original Message-----
>>>> From: Sinan Kaya [mailto:okaya@codeaurora.org]
>>>> Sent: 13 June 2016 15:03
>>>> To: Gabriele Paoloni; liudongdong (C); helgaas@kernel.org;
>>>> arnd@arndb.de; will.deacon@arm.com; catalin.marinas@arm.com;
>>>> rafael@kernel.org; hanjun.guo@linaro.org; Lorenzo.Pieralisi@arm.com;
>>>> jchandra@broadcom.com; tn@semihalf.com
>>>> Cc: robert.richter@caviumnetworks.com; mw@semihalf.com;
>>>> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; Wangyijing;
>>>> Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
>>>> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
>>>> acpi@lists.linaro.org; jcm@redhat.com; andrea.gallo@linaro.org;
>>>> dhdang@apm.com; jeremy.linton@arm.com; cov@codeaurora.org; Chenxin
>>>> (Charles); Linuxarm
>>>> Subject: Re: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space
>>>> accessors against platfrom specific ECAM quirks
>>>>
>>>> On 6/13/2016 9:54 AM, Gabriele Paoloni wrote:
>>>> > As you can see here Liudongdong has replaced oem_revision with
>>>> > oem_table_id.
>>>> >
>>>> > Now it seems that there are some platforms that have already shipped
>>>> > using a matching based on the oem_revision (right Jon?)
>>>> >
>>>> > However I guess that if in FW they have defined oem_table_id properly
>>>> > they should be able to use this mechanism without needing to a FW
>>>> update.
>>>> >
>>>> > Can these vendors confirm this?
>>>> >
>>>> > Tomasz do you think this can work for Cavium Thunder?
>>>> >
>>>> > Thanks
>>>> >
>>>> > Gab
>>>>
>>>> Why not have all three of them?
>>>>
>>>> The initial approach was OEM id and revision id.
>>>>
>>>> Jeff Hugo indicated that addition (not removing any other fields) of
>>>> table id
>>>> would make more sense.
>>>
>>>
>>> Mmm from last email of Jeff Hugo on "[RFC PATCH 1/3] pci, acpi: Match
>>> PCI config space accessors against platfrom specific ECAM quirks."
>>>
>>> I quote:
>>>
>>>  "Using the OEM revision
>>>  field does not seem to be appropriate since these are different
>>>  platforms and the revision field appears to be for the purpose of
>>>  tracking differences within a single platform.  Therefore, Cov is
>>>  proposing using the OEM table id as a mechanism to distinguish
>>>  platform A (needs quirk applied) vs platform B (no quirks) from the
>>>  same OEM."
>>>
>>> So it looks to me that he pointed out that using the OEM revision field
>>> is wrong...and this is why I have asked if replacing it with the table
>>> id can work for other vendors....
>>>
>>> Thanks
>>>
>>> Gab
>>>
>>
>> I had an internal discussion with jeff and cov before posting on the
>> maillist.
>>
>> I think there is missing info in the email.
>>
>> Usage of oem id + table id + revision is ok.
>>
>> Usage of oem id + revision is not ok as one oem can build multiple chips
>> with the same oem id and revision id but different table id. Otherwise,
>> we can run out of revisions very quickly.
>
>
> Agreed.
>
> I'm sorry for the confusion.  My intent was to point out that revision alone
> appeared insufficient to address all the identified problems, but I believe
> there is still a case for using revision. Table id is useful for
> differentiating between platforms/chips.  Revision is useful for
> differentiation between different versions of a single platform/chip
> assuming the silicon is respun or some other fix is applied.  Both solve
> different scenarios, and I'm not aware of a reason why they could not be
> used together to solve all currently identified cases.

Using OEM ID + Table ID + Revision will work for X-Gene platforms as well.

Regards,
Duc Dang.
>
>>
>>>
>>>>
>>>> --
>>>> Sinan Kaya
>>>> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center,
>>>> Inc.
>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
>>>> Linux Foundation Collaborative Project
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> --
> Jeffrey Hugo
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project
