Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <1449155999-220955-2-git-send-email-gabriele.paoloni@huawei.com>
 <20151203175826.GB2935@red-moon> <5018756.5lEEeJVMod@wuerfel>
Cc: liguozhu@hisilicon.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	linaro-acpi@lists.linaro.org, catalin.marinas@arm.com,
	Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org,
	will.deacon@arm.com, linux-acpi@vger.kernel.org,
	wangzhou1@hisilicon.com, hanjun.guo@linaro.org,
	liudongdong3@huawei.com, linux-pci@vger.kernel.org,
	wangyijing@huawei.com, tn@semihalf.com, tglx@linutronix.de,
	xuwei5@hisilicon.com, bhelgaas@google.com,
	jiang.liu@linux.intel.com
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5661FB9B.20201@arm.com>
Date: Fri, 4 Dec 2015 14:46:19 -0600
MIME-Version: 1.0
In-Reply-To: <5018756.5lEEeJVMod@wuerfel>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/03/2015 02:58 PM, Arnd Bergmann wrote:
> On Thursday 03 December 2015 17:58:26 Lorenzo Pieralisi wrote:
>> I will put together a proposal to define the way we specify HID and
>> related DSD properties for PCI host controllers and send it to
>> the ACPI working group for review.
>
> That also requires a change to SBSA, right? Today, SBSA assumes that
> we have a standard PCI host that will work with any hardware independent
> PCI implementation in an OS. We either have to give up on SBSA saying
> much about how PCI hosts are implemented, or stop assuming that hardware
> is SBSA compliant.

Which would be standardizing nonstandard hardware. It would surprise me 
if that got much traction.



