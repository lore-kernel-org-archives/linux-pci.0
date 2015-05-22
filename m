Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <555F11B4.8000503@linaro.org>
Date: Fri, 22 May 2015 19:23:32 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	"x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: Re: [Patch v3 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
References: <1431593803-5213-1-git-send-email-jiang.liu@linux.intel.com> <1431593803-5213-6-git-send-email-jiang.liu@linux.intel.com> <5559E44B.2010702@linaro.org> <555BFC72.3060703@linux.intel.com> <555C0091.6050301@linaro.org>
In-Reply-To: <555C0091.6050301@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年05月20日 11:33, Hanjun Guo wrote:
> +CC Suravee,
>
> On 2015年05月20日 11:16, Jiang Liu wrote:
>> On 2015/5/18 21:08, Hanjun Guo wrote:
>>> Hi Jiang,
>>>
>>> On 2015年05月14日 16:56, Jiang Liu wrote:
>>>> Introduce common interface acpi_pci_root_create() and related data
>>>> structures to create PCI root bus for ACPI PCI host bridges. It will
>>>> be used to kill duplicated arch specific code for IA64 and x86. It may
>>>> also help ARM64 in future.
>>>
>>> As I commented in previous version, this patch will introduce
>>> compile error on ACPI enabled ARM64 kernel because struct
>>> pci_controller is not defined for ARM64, so how about adding
>>> the following patch before this patch, or squash to this one,
>>> does it make sense?
>> Hi Hanjun,
>>     Thanks for fixing this building issue for ARM64. The patch
>> is really what I want:). Will merge it into next version. With this
>> patch applied, are there any other issues from ARM64 side?
>
> Suravee is testing ARM64 PCI on top of your patch set, he can confirm
> that if there are any other issues :) (Suravee has a real ARM64 hardware
> in hand)

After confirmed with Suravee, this patch set works OK on ARM64
hardware for PCI hostbridge init, and can enumerate PCI devices
(adding some ARM64 related PCI patches) and works fine with legacy
interrupt, so to me, this patch set is good to go :)

For this patchset:

Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

I will add my Reviewed-by for some of patches later.

Thanks
Hanjun
