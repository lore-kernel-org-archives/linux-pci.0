Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
From: Jon Masters <jcm@redhat.com>
Message-ID: <571130BB.9030508@redhat.com>
Date: Fri, 15 Apr 2016 14:19:39 -0400
MIME-Version: 1.0
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/15/2016 01:06 PM, Tomasz Nowicki wrote:
> From the functionality point of view this series might be split into the
> following logic parts:
> 1. Necessary fixes as the preparation for using driver on ARM64.
> 2. New ECAM API and update for users of the pci-host-common API
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.6-rc2 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v6)
> 
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.
> 
> v5 -> v6
> - dropped idea of x86 MMCONFIG code refactoring
> - integrated JC's patches which introduce new ECAM API:
>   https://lkml.org/lkml/2016/4/11/907
>   git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
> - integrated Sinan's fix for releasing IO resources, see patch [06/13]
> - added ACPI support for ThunderX ECAM and PEM drivers
> - rebased to 4.6-rc2

JC: can you explicitly confirm that you're ok with letting Tomasz drive
this? We would like to see one driver. Either that is Tomasz, or
Lorenzo, or it is you. But we need to have one overall cooordinated
effort to get this enablement into upstream as quickly as possible.

Some of the Enterprise folks are going to otherwise end up in a very
nasty situation of supporting the previous non-upstream patches for many
years, which is absolutely something we want to avoid...

Jon.

