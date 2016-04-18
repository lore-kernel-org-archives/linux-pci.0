Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
To: Jayachandran C <jchandra@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <5110401.mGEq6IVFz2@wuerfel>
 <CAKc_7PWFacFJZA2JpfM4RcRFVj0jyUE73HhhvmX0cKm07JGupg@mail.gmail.com>
 <4240660.NqlPcXaV7N@wuerfel>
 <CAKc_7PWw5VaPxcOpWbonksx6k4W5fe9yO8wBfigXNRkFAYAYEg@mail.gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
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
Message-ID: <5714DB37.7000907@semihalf.com>
Date: Mon, 18 Apr 2016 15:03:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAKc_7PWw5VaPxcOpWbonksx6k4W5fe9yO8wBfigXNRkFAYAYEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16.04.2016 16:36, Jayachandran C wrote:
> On Sat, Apr 16, 2016 at 1:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Saturday 16 April 2016 12:50:13 Jayachandran C wrote:
>>>>
>>>> I still think it would be better to keep the loadable PCI host drivers
>>>> separate from the ACPI PCI infrastructure. There are a number of
>>>> simplifications that we want to do to the DT based drivers in the long
>>>> run, so it's better if that code is not shared at this level. Abstracting
>>>> out the ECAM code is fine, but at that point you should be able to just
>>>> call it from the ACPI layer.
>>>
>>> The issue is not with this patch (in my opinion). This patch is just
>>> re-arranging how thunder specific data is maintained. Earlier it was
>>> a container_of gen_pci, now it is ->priv of pci_config_window.
>>>
>>> I can see the issue in patches 12 and 13 of this patchset which adds
>>> ACPI fixups into the thunder OF driver.
>>
>> Right, I commented on this one, because it seems to rearrange the code
>> in order to do the later one.
>
> Patches 11- 13 are not from me, and I am not completely on board
> on the approach of adding the sections.We can look at reworking this.
>
>>> The simple approach when doing modular PCI drivers would be to make
>>> pci-thunder-*.c like pci-host-common.c, to be compiled in if configured.
>>> The fie will contain all the Thunder quirks and can export
>>> pci_thunder_ecam_ops.
>>
>> I would argue that we should not export anything from drivers/pci/host,
>> those should really be standalone drivers that do not interact with other
>> subsystems.
>
> pci-host-common.c goes against being standalone. The files calling
> pci_host_common_probe() are expected to have custom ECAM ops
> the way it is written now. We need to have a reasonable way to share
> those ECAM ops if needed by ACPI.
>
>> How much code would you need to duplicate from thunder-ecam to have
>> the same functionality available in ACPI? My expectation is that it's
>> not really that much more compared to the code you need for sharing
>> a single implementation, but you get a lower complexity here, which
>> makes it easier to understand and to rework.
>
> Like I wrote above, the sharing is really simple because both generic
> ACPI and pci-host-common.c have been written for "ECAM with quirks".
>
> The whole pci-thunder-*.c is to support thunder PCI quirks since the
> generic OF is handled by pci-host-common.c and generic ECAM is now
> separated -  duplicating the whole file for ACPI will be bad.

Yes, it would be too much code duplication. Also, we already know 
drivers which need quirks.

We really need to agree on best approach here. Here are requirements 
which came up (please correct me if misunderstood sth):

Arnd:
1. Initial DT driver should be standalone [Arnd]
2. No exported symbols [Arnd]
3. Duplicate necessary code to ACPI framework.

JC:
1. Adding linker section is wrong.
2. Quirks should be exported (pci_thunder_ecam_ops), then no need for 
adding linker section
3. To much duplication to copy code into the ACPI framework.

My opinion:
1. I like linker section because it is easy to maintain and no need to 
export symbols.
2. We need more sophisticated algorithm for matching quirks (DMI is not 
enough and not only for ThunderX drivers). Of course I am open to any 
new suggestions.
3. To much duplication to copy code into the ACPI framework.

Thanks in advance for any pointers.

Thanks,
Tomasz

