Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
To: Arnd Bergmann <arnd@arndb.de>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <CAKc_7PVC6O4oh+bTmpLQRrhHrqGbaKB2hynecKOLmc5fBc-VVQ@mail.gmail.com>
 <5714E224.1030307@semihalf.com> <4253385.YPSgBqNLfg@wuerfel>
Cc: Jayachandran C <jchandra@broadcom.com>,
	Jon Masters <jcm@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	Wangyijing <wangyijing@huawei.com>,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5714FC89.8060005@semihalf.com>
Date: Mon, 18 Apr 2016 17:26:01 +0200
MIME-Version: 1.0
In-Reply-To: <4253385.YPSgBqNLfg@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18.04.2016 16:38, Arnd Bergmann wrote:
> On Monday 18 April 2016 15:33:24 Tomasz Nowicki wrote:
>>
>> Of course we can split discussion into the two topics:
>> 1. ECAM based ACPI host controller - patches [1-10]
>> 2. Quirks handling and examples.
>>
>> IMO, it is very helpful for reviewers to go with one unified patch set
>> and see the whole picture. Also, as you can see, quirks handling allows
>> people to test it easily with their servers (not only QEMU but real HW).
>
> I think splitting the two would help tremendously. The regular
> PCI support should just get merged (it should have been completed
> years ago when ACPI for ARM64 was first implemented), while the quirks
> handling contains all ugly nonstandard hacks we have to be careful
> about.
>

OK, so for those who want to review just "ECAM based ACPI host 
controller" lets consider only patches [1-10]. Patches 11-13 are well 
isolated and do not affect previous one. Is that ok for this series?

Thanks,
Tomasz
