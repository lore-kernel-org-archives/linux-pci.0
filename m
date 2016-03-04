Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V5 00/15] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <56D49611.2050202@codeaurora.org> <20160303112332.GC28359@red-moon>
 <56D84938.6020102@codeaurora.org> <20160304105517.GA30693@red-moon>
 <56D97901.7080001@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, yinghai@kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D9A121.9080508@codeaurora.org>
Date: Fri, 4 Mar 2016 09:52:17 -0500
MIME-Version: 1.0
In-Reply-To: <56D97901.7080001@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Posting on top of Tomasz's email...

On 3/4/2016 7:01 AM, Tomasz Nowicki wrote:
> On 04.03.2016 11:55, Lorenzo Pieralisi wrote:
>> On Thu, Mar 03, 2016 at 09:24:56AM -0500, Sinan Kaya wrote:
>>> >On 3/3/2016 6:23 AM, Lorenzo Pieralisi wrote:
>>>> > >x86 and IA64 claim PCI resources on boot and live with that (well, minus
>>>> > >the gazillions x86 pci= parameters that change the PCI resources assignment
>>>> > >one way or another), comments very welcome in particular on the pci=realloc
>>>> > >option and its usage.
>>> >
>>> >I have been working with Linux PCIe over 3 years. I never used
>>> >pci=realloc argument.
>>> >
>>> >The v5 series minus [PATCH V5 11/15] drivers: pci: add generic code to
>>> >claim bus resources is working just fine and is ready to go upstream
>>> >in my opinion. It passed my internal testing with different types of
>>> >endpoints.
>>> >
>>> >The inclusion of this patch is now requiring everybody to add
>>> >pci=realloc argument otherwise the resources assigned by the UEFI BIOS
>>> >are not working.
>>> >
>>> >I think there is still some work to be done in this patch and is too
>>> >early to be included into the series. It is blocking progress of the
>>> >series which is sitting on review over 1 year already.
>> First off, I think that's specious, patch 11 is not blocking anything,
>> if you and Tomasz want to drop it go ahead and take responsibility
>> of the consequences.
>>
>> I am not saying patch 11 is perfect, it is there to review, if you
>> spot bugs point them out.
>>
>> If you are interested and willing to make an effort to understand why I
>> asked Tomasz to integrate it, a bit of background here:
>>
>> http://permalink.gmane.org/gmane.linux.kernel.pci/44830
>>
>> If we want to drop patch 11, we are going to discard whatever FW
>> set-up at FW/OS hand-off and reassign everything. Want to do it ?
>> Go ahead.

Yes, we should ideally reuse the BAR addresses assigned by FW. And, it is not
working as I said. It happens to work on Intel architectures. I'm saying that 
this patch needs some more work not that it is right or wrong.

How long it takes to figure this out is the question? It could have been dealt
with separately. If you can come up with a solution in the near future, 
I'm ready to test.

There was some big push on v3 to get it tested by multiple vendors. I was under
the impression that we are trying to get some version accepted.

Since I'm the only one complaining right now, I guess nobody else is testing 
v4 and v5.

>>
>> I wrote it in my previous email, probably it was not clear, so, here we
>> go again.
>>
>> If we want to at least consider the FW PCI configuration at FW/OS
>> handoff, we should read the PCI bridge apertures and claim them, when
>> that fails reassign the corresponding PCI bus hierarchy (which means
>> releasing the bridge resources and downstream devices and reassign
>> them), that's what pci=realloc does.
>>
>> I think that it is a command line option since it has to be a choice,
>> ie overriding FW set-up should be an option, not a default.
>>
>> Patch 11 does what x86 does in arch code arch/x86/pci/i386.c,
>>
>> pcibios_resource_survey()
>>
>> and that works for them (of course, minus quirks that do exist).
>>
>> I could integrate the code implementing pci=realloc in patch 11 so
>> that we realloc by default all resources claimed that failed (which
>> means that bridges are resized accordingly and you won't be forced
>> to use pci=realloc on command line).
>>
> 
> I agree with Lorenzo. Just because v3 works it does not mean we want to go this way. Also, I think we should realloc all resources claimed that failed, w/o need to use pci=realloc on command line.
> 

Let's give this a try. I have seen the kernel messages with and without realloc option 
too. I don't want to see any kind of error messages if it is actually working.

I don't want to get a support request that PCIe is broken even though it is not just
because of some error message in boot log that eventually got corrected by the 
architecture.

> Tomasz
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
