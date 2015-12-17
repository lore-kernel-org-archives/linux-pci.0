Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] acpi: pci: Setup MSI domain for ACPI based pci
 devices
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1449766530-16935-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449766530-16935-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151216221541.GA31633@localhost>
CC: <marc.zyngier@arm.com>, <tglx@linutronix.de>,
	<jason@lakedaemon.net>, <rjw@rjwysocki.net>, <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	<hanjun.guo@linaro.org>, <tomasz.nowicki@linaro.org>,
	<graeme.gregory@linaro.org>, <dhdang@apm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Message-ID: <567200E3.1070405@amd.com>
Date: Wed, 16 Dec 2015 18:25:07 -0600
MIME-Version: 1.0
In-Reply-To: <20151216221541.GA31633@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/16/2015 4:15 PM, Bjorn Helgaas wrote:
> On Thu, Dec 10, 2015 at 08:55:27AM -0800, Suravee Suthikulpanit wrote:
>> >This patch introduces pci_msi_register_fwnode_provider() for irqchip
>> >to register a callback, to provide a way to determine appropriate MSI
>> >domain for a pci device.
>> >
>> >It also introduces pci_host_bridge_acpi_msi_domain(), which returns
>> >the MSI domain of the specified PCI host bridge with DOMAIN_BUS_PCI_MSI
>> >bus token. Then, it is assigned to pci device.
>> >
>> >Reviewed-by: Marc Zyngier<marc.zyngier@arm.com>
>> >Cc: Bjorn Helgaas<bhelgaas@google.com>
>> >Cc: Rafael J. Wysocki<rjw@rjwysocki.net>
>> >Signed-off-by: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
> Acked-by: Bjorn Helgaas<bhelgaas@google.com>
>
> I assume the whole series will be queued via a non-PCI tree.
>

Thank you, Bjorn. I think Marc is planning to pull this in once all 
parties have acked the patch series.

Suravee
