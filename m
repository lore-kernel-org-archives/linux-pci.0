Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <571130BB.9030508@redhat.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <571130BB.9030508@redhat.com>
From: Martinez Kristofer <kristofer.s.martinez@gmail.com>
Date: Sun, 17 Apr 2016 17:23:31 +0800
Message-ID: <CABtop_ExTJ=esXga5f+zT2AV0Vj49zsDVgxegLfW7R4sc+Nmzw@mail.gmail.com>
Subject: Re: [PATCH V6 00/13] Support for generic ACPI based PCI host controller
To: Jon Masters <jcm@redhat.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, robert.richter@caviumnetworks.com,
	mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 16, 2016 at 2:19 AM, Jon Masters <jcm@redhat.com> wrote:
> On 04/15/2016 01:06 PM, Tomasz Nowicki wrote:
>> From the functionality point of view this series might be split into the
>> following logic parts:
>> 1. Necessary fixes as the preparation for using driver on ARM64.
>> 2. New ECAM API and update for users of the pci-host-common API
>> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
>> 4. Enable above driver on ARM64
>>
>> Patches has been built on top of 4.6-rc2 and can be found here:
>> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v6)
>>
>> This has been tested on Cavium ThunderX server. Any help in reviewing and
>> testing is very appreciated.
>>
>> v5 -> v6
>> - dropped idea of x86 MMCONFIG code refactoring
>> - integrated JC's patches which introduce new ECAM API:
>>   https://lkml.org/lkml/2016/4/11/907
>>   git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
>> - integrated Sinan's fix for releasing IO resources, see patch [06/13]
>> - added ACPI support for ThunderX ECAM and PEM drivers
>> - rebased to 4.6-rc2
>
> JC: can you explicitly confirm that you're ok with letting Tomasz drive
> this? We would like to see one driver. Either that is Tomasz, or
> Lorenzo, or it is you. But we need to have one overall cooordinated
> effort to get this enablement into upstream as quickly as possible.
>
> Some of the Enterprise folks are going to otherwise end up in a very
> nasty situation of supporting the previous non-upstream patches for many
> years, which is absolutely something we want to avoid...
>
Indeed, we need only one driver for this. But given there're already
others except this
one exist, and I believe no one want to give up their efforts. Also I
think it's not exactly the
same feauture provided by those drivers, so can we make some trade-off
to combine
those drivers into one and add the Signed-off-by for all the anthors?
One agreement for all of us is to upstream the ACPI PCI for ARM64 asap!

M.K.

>
> Jon.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
