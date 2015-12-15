Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <566FE2DD.6080308@arm.com>
Date: Tue, 15 Dec 2015 09:52:29 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	tglx@linutronix.de, jason@lakedaemon.net, bhelgaas@google.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	hanjun.guo@linaro.org, tomasz.nowicki@linaro.org,
	graeme.gregory@linaro.org, dhdang@apm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 1/4] acpi: pci: Setup MSI domain for ACPI based pci
 devices
References: <1449766530-16935-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1449766530-16935-2-git-send-email-Suravee.Suthikulpanit@amd.com> <566EDCAC.1080401@arm.com> <2013286.NCRgLU1HGi@vostro.rjw.lan>
In-Reply-To: <2013286.NCRgLU1HGi@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/12/15 21:29, Rafael J. Wysocki wrote:
> On Monday, December 14, 2015 03:13:48 PM Marc Zyngier wrote:
>> On 10/12/15 16:55, Suravee Suthikulpanit wrote:
>>> This patch introduces pci_msi_register_fwnode_provider() for irqchip
>>> to register a callback, to provide a way to determine appropriate MSI
>>> domain for a pci device.
>>>
>>> It also introduces pci_host_bridge_acpi_msi_domain(), which returns
>>> the MSI domain of the specified PCI host bridge with DOMAIN_BUS_PCI_MSI
>>> bus token. Then, it is assigned to pci device.
>>>
>>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> Bjorn, Rafael,
>>
>> Do you have any comment on this?
>>
>> I was hoping to queue this work (and the 3 patches that depend on it)
>> for 4.5, but if you don't have the bandwidth to review it, I'll postpone
>> it to the following merge window.
> 
> How much time do we have to look at it before it is postponed?

Realistically, I'm going to stop queuing stuff Wednesday next week (I'll
be travelling, and without access to enough HW to follow up on potential
regressions), and I'd expect Thomas to stop pulling stuff even earlier
than that.

So we basically have a week to decide whether or not we want this for
the next merge window. I appreciate this is a busy time for everyone and
that this series took a long time to reach that stage, so any way is
fine by me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
