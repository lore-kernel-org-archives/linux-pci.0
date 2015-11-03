Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bhelgaas@google.com, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI hostbridge init
Date: Tue, 03 Nov 2015 16:59:28 +0100
Message-ID: <5802577.H74A3Lg5B3@wuerfel>
In-Reply-To: <5638CE5D.4030703@codeaurora.org>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com> <5638C728.2020503@semihalf.com> <5638CE5D.4030703@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 03 November 2015 10:10:21 Sinan Kaya wrote:
> 
> I don't see anywhere in the SBSA spec addendum that the PCI 
> configuration space section that unaligned accesses *MUST* be supported.
> 
> If this is required, please have this info added to the spec. I can work 
> with the designers for the next chip.
> 
> Unaligned access on the current hardware returns incomplete values or 
> can cause bus faults. The behavior is undefined.

Unaligned accesses are not allowed, but any PCI compliant device must
support aligned 1, 2 or 4 byte accesses on its configuration space,
though the byte-enable mechanism. In an ECAM host bridge, those are
mapped to load/store accesses from the CPU with the respective width
and natural alignment.

	Arnd
