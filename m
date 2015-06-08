Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <556540C7.6080301@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
	<1951882.p8DdrcurkC@vostro.rjw.lan>
	<556540C7.6080301@linaro.org>
Date: Mon, 8 Jun 2015 17:35:34 +0530
Message-ID: <CAD6G_RQnm-y9eQdYGV89zzY-x90ESo6-APPVpY7eiJ=AJbg2rg@mail.gmail.com>
Subject: Re: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
From: Jagan Teki <jteki@openedev.com>
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27 May 2015 at 09:27, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2015年05月27日 08:30, Rafael J. Wysocki wrote:
>>
>> On Tuesday, May 26, 2015 08:49:13 PM Hanjun Guo wrote:
>>>
>>> This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
>>> which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
>>> code into ACPI core":
>>>
>>> https://lkml.org/lkml/2015/5/14/98
>>
>>
>> I'll be regarding this patchset as an RFC until the one from Jiang Liu
>> goes in.
>
>
> Yes, please, Jiang Liu's patch set should go in first.

Apart from picking all, I have skipped x86, ia64 changes from above
and Jiang Liu's
series with disabling MSI, but I'm observing my arm64 board isn't
booted from uefi.

I'm suspecting pci-acpi changes were generic to specific pcie root
bridge controller,
but do I need to do any changes wrt pcie bridge? let me know if I miss
anything here.

thanks!
-- 
Jagan.
