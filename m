Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
To: Arnd Bergmann <arnd@arndb.de>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <CAKc_7PWw5VaPxcOpWbonksx6k4W5fe9yO8wBfigXNRkFAYAYEg@mail.gmail.com>
 <5714DB37.7000907@semihalf.com> <10639671.xGDtp1R8bk@wuerfel>
Cc: Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	Jon Masters <jcm@redhat.com>, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, Wangyijing <wangyijing@huawei.com>,
	Marcin Wojtas <mw@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5715362A.7070701@semihalf.com>
Date: Mon, 18 Apr 2016 21:31:54 +0200
MIME-Version: 1.0
In-Reply-To: <10639671.xGDtp1R8bk@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18.04.2016 16:44, Arnd Bergmann wrote:
> On Monday 18 April 2016 15:03:51 Tomasz Nowicki wrote:
>> On 16.04.2016 16:36, Jayachandran C wrote:
>>> On Sat, Apr 16, 2016 at 1:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Saturday 16 April 2016 12:50:13 Jayachandran C wrote:
>>> The whole pci-thunder-*.c is to support thunder PCI quirks since the
>>> generic OF is handled by pci-host-common.c and generic ECAM is now
>>> separated -  duplicating the whole file for ACPI will be bad.
>>
>> Yes, it would be too much code duplication. Also, we already know
>> drivers which need quirks.
>>
>> We really need to agree on best approach here. Here are requirements
>> which came up (please correct me if misunderstood sth):
>>
>> Arnd:
>> 1. Initial DT driver should be standalone [Arnd]
>> 2. No exported symbols [Arnd]
>> 3. Duplicate necessary code to ACPI framework.
>
> Correct.
>
>> JC:
>> 1. Adding linker section is wrong.
>> 2. Quirks should be exported (pci_thunder_ecam_ops), then no need for
>> adding linker section
>> 3. To much duplication to copy code into the ACPI framework.
>>
>> My opinion:
>> 1. I like linker section because it is easy to maintain and no need to
>> export symbols.
>> 2. We need more sophisticated algorithm for matching quirks (DMI is not
>> enough and not only for ThunderX drivers). Of course I am open to any
>> new suggestions.
>
> Agreed.
>
>> 3. To much duplication to copy code into the ACPI framework.
>>
>> Thanks in advance for any pointers.
>
> Can you be more specific about what code actually would need to
> be duplicated? Anything besides the config space operations?
>

Basically the whole content of pci-thunder-ecam.c and pci-thunder-pem.c.

pci-thunder-ecam.c contains config space accessors. Similar for 
pci-thunder-pem.c but it also has extra init call (it is now called 
thunder_pem_init) which finds and maps related registers.

Thanks,
Tomasz

