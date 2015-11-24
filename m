Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151124164907.GA24819@localhost>
References: <1447648057-13644-1-git-send-email-jiang.liu@linux.intel.com>
	<20151124164907.GA24819@localhost>
Date: Tue, 24 Nov 2015 23:19:34 +0100
Message-ID: <CAJZ5v0irOUq6C9eSfCfmzyOiY1n1rUSxyUeUbvS9Nj0jNT2JrQ@mail.gmail.com>
Subject: Re: [Bugfix] x86/PCI: Fix regression caused by commit 4d6b4e69a245
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	x86@kernel.org, Keith Busch <keith.busch@intel.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 24, 2015 at 5:49 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Nov 16, 2015 at 12:27:37PM +0800, Jiang Liu wrote:
>> From: Liu Jiang <jiang.liu@linux.intel.com>
>>
>> Commit 4d6b4e69a245 ("x86/PCI/ACPI: Use common interface to support
>> PCI host bridge") converted x86 to use the common interface
>> acpi_pci_root_create, but the conversion missed on code piece in
>> arch/x86/pci/bus_numa.c, which causes regression on some legacy
>> AMD platforms as reported by Arthur Marsh <arthur.marsh@internode.on.net>.
>> The root causes is that acpi_pci_root_create() fails to insert
>> host bridge resources into iomem_resource/ioport_resource because
>> x86_pci_root_bus_resources() has already inserted those resources.
>> So change x86_pci_root_bus_resources() to not insert resources into
>> iomem_resource/ioport_resource.
>
> Fixes: 4d6b4e69a245 ("x86/PCI/ACPI: Use common interface to support PCI host bridge")
>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> Reported-and-tested-by: Arthur Marsh <arthur.marsh@internode.on.net>
>
> What's the status of this?  It looks like a regression we need to fix
> for v4.4.
>
> AFAICT, Arthur did *not* test this patch (rather, his response says he
> did test it and the test failed).
>
> 4d6b4e69a245 was merged by Rafael, and I assume he'll merge the fix
> unless I hear otherwise.

Quite frankly, I'm more likely to revert the offending commit at this
point as that's not the only regression reported against it and the
fix only helps in one case (out of three known to me).

Thanks,
Rafael
