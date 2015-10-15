Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <561FD3BB.70501@arm.com>
Date: Thu, 15 Oct 2015 17:26:35 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"msalter@redhat.com" <msalter@redhat.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
References: <20150604102253.GA31773@red-moon> <5570447D.3020705@linaro.org> <557504A2.3060203@linaro.org> <20150608151443.GA16151@red-moon> <55E4340D.6050004@linaro.org> <55ED6010.3020406@linaro.org> <20150908150727.GF29293@red-moon> <55F0388B.1090607@linaro.org> <20150911112018.GA13033@red-moon> <55F6DFF6.4010807@linaro.org> <20151015132200.GA7621@red-moon> <561FB985.8070509@linaro.org>
In-Reply-To: <561FB985.8070509@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15/10/15 15:34, Tomasz Nowicki wrote:

> Of course your help in testing is welcomed. Also please have a look at 
> my GICv3/ITS patches, they are important for ACPI PCI.

Where is the dependency? ACPI/PCI should really be standalone.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
