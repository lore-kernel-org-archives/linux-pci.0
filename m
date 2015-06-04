Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <556FF820.5070405@linaro.org>
Date: Thu, 04 Jun 2015 15:02:56 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>, Al Stone <ahs3@redhat.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Salter <msalter@redhat.com>
Subject: Re: [Patch v4 0/8] Consolidate ACPI PCI root common code into ACPI
 core
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com> <556F6332.2040501@redhat.com> <556FAFEF.6040802@linux.intel.com> <556FF0AD.6000901@linaro.org> <556FF32B.9010900@linux.intel.com>
In-Reply-To: <556FF32B.9010900@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年06月04日 14:41, Jiang Liu wrote:
> On 2015/6/4 14:31, Hanjun Guo wrote:
>> Hi Jiang,
>>
>> On 2015年06月04日 09:54, Jiang Liu wrote:
>>> On 2015/6/4 4:27, Al Stone wrote:
>>>> On 06/02/2015 12:12 AM, Jiang Liu wrote:
>>>>> This patch set consolidates common code to support ACPI PCI root on x86
>>>>> and IA64 platforms into ACPI core, to reproduce duplicated code and
>>>>> simplify maintenance. And a patch set based on this to support ACPI
>>>>> based
>>>>> PCIe host bridge on ARM64 has been posted at:
>>>>
>>>> Link is missing (or it's a typo of some flavor).
>>> HI Al,
>>>      Sorry, I missed the link. It has been posted at:
>>> https://lkml.org/lkml/2015/5/26/207
>>
>> I failed to get io resources for PCI hostbridge  when I was testing PCI
>> on ARM64 QEMU, I debugged this for quite a while, and finally found out
>> that ACPI resource parsing for IO is not suitable for ARM64, because io
>> space for x86 is 64K, but 16M for ARM64.
>>
>> This issue is only found when the firmware representing the io resource
>> using the type ACPI_RESOURCE_TYPE_ADDRESS32, so the io address will
>> greater than 64k.
>>
>> In drivers/acpi/resource.c:
>>
>> static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
>>                                        u8 io_decode, u8 translation_type)
>> {
>>          res->flags = IORESOURCE_IO;
>>
>> [...]
>>
>>          if (res->end >= 0x10003)
>>                  res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
>>
>> [...]
>> }
>>
>> so the code will filter out res->end >= 0x10003, and in my case, it will
>> more than 64K, so we can't get the IO resources.
>>
>> I got a question, why we use if (res->end >= 0x10003) here?
>> I mean 64k will be 0x10000, and in that case, we should use
>> if (res->end >= 0x10000) here, not 0x10003, any history behind that?
>
> Hi Hanjun,
> This is a special tricky for x86. You may read a dword(four bytes) from
> IO port 0xffff, so the effective io port space is 0x10003 bytes.

Thanks for the explanation, how about add a patch to comment on it?
if it's ok to you and will improve the code readability, I can prepare
one.

>
>>
>> This is not the problem of this patch set, but need updating
>> the core ACPI resource parsing code, I'm working on that. I'm
>> just wondering there is no special IO space on IA64, how this works
>> on IA64?
> There is special handling for IO port on IA64. IA64 io ports are
> actually memory-mapped, and there may be multiple 64K IO port spaces.
> For example, each PCI domain may have its own 64k memory-mapped
> IO space.

That's the case for ARM64 too, I will review the IA64 code for
reference, great thanks for the help and explanation :)

Thanks
Hanjun
