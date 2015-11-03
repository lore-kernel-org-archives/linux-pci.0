Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5638D07B.2030001@linaro.org>
Date: Tue, 03 Nov 2015 23:19:23 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>
CC: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
References: <1445963922-22711-1-git-send-email-tn@semihalf.com> <1445963922-22711-12-git-send-email-tn@semihalf.com> <5631180D.2000902@codeaurora.org> <20151103141512.GC3574@red-moon>
In-Reply-To: <20151103141512.GC3574@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/03/2015 10:15 PM, Lorenzo Pieralisi wrote:
> On Wed, Oct 28, 2015 at 02:46:37PM -0400, Sinan Kaya wrote:
>
> [...]
>
>>> -int raw_pci_write(unsigned int domain, unsigned int bus,
>>> -		unsigned int devfn, int reg, int len, u32 val)
>>> +struct pci_ops pci_root_ops = {
>>> +	.map_bus = pci_mcfg_dev_base,
>>> +	.read = pci_generic_config_read,
>>> +	.write = pci_generic_config_write,
>>
>>
>> Can you change these with pci_generic_config_read32 and
>> pci_generic_config_write32? We have some targets that can only do 32
>> bits PCI config space access.
>
> No.
>
> http://www.spinics.net/lists/linux-pci/msg44869.html
>
> Can you be a bit more specific please ?
>
> Sigh. Looks like we have to start adding platform specific quirks even
> before we merged the generic ACPI PCIe host controller implementation.

Cc Gab, Zhou, and Dondong who upstream the hip05 (designware) PCIe host
support.

I think so, some platform may not support ECAM for root complex,
which needs special handling of access config space, we may need
to consider those cases.

Thanks
Hanjun
