Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V1 00/11] MMCONFIG refactoring and ARM64 PCI hostbridge
 init based on ACPI
To: Jon Masters <jcm@redhat.com>, bhelgaas@google.com, arnd@arndb.de,
	will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net,
	hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <5632ED1C.7050500@redhat.com>
Cc: jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <563329CD.6060506@semihalf.com>
Date: Fri, 30 Oct 2015 09:26:53 +0100
MIME-Version: 1.0
In-Reply-To: <5632ED1C.7050500@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 10/30/2015 05:07 AM, Jon Masters wrote:
> Hi Tomasz,
>
> Thanks for posting this series.
>
> On 10/27/2015 12:38 PM, Tomasz Nowicki wrote:
>
>>  From the functionality point of view this series might be split into two logic parts:
>> 1. Making MMCONFIG code arch-agnostic which allows all architectures to collect
>>     PCI config regions and used when necessary.
>> 2. Using generic MMCONFIG code and introducing ACPI based PCI hostbridge
>>     initialization for ARM64
> Can I confirm that the intention here is that this replaces Hanjun's
> previous patch series? Here's the previous one we were tracking:
>
> https://lkml.kernel.org/g/1432644564-24746-1-git-send-email-hanjun.guo@linaro.org
Indeed, we can call it next version.
>
> Assuming that is the case, then we will ping a number of folks to
> conduct testing and provide acks (this has already been discussed in a
> number of conversations with semiconductors over the past few days).
Yes, please, thanks!

Tomasz
