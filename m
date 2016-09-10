Return-Path: <bp@alien8.de>
Return-Path: <bp@alien8.de>
Date: Sat, 10 Sep 2016 17:23:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rui Wang <rui.y.wang@intel.com>
Cc: bhelgaas@google.com, torvalds@linux-foundation.org,
	peterz@infradead.org, tglx@linutronix.de, helgaas@kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	rjw@rjwysocki.net, tony.luck@intel.com, mingo@kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 584c5c422f6c ("x86/ioapic: Support hot-removal of IOAPICs
 present during boot")
Message-ID: <20160910152301.exha54snrq5cydkb@pd.tnic>
References: <20160910143031.5s4psayo4wqrmpt2@pd.tnic>
 <1473519809-31107-1-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1473519809-31107-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 10, 2016 at 11:03:29PM +0800, Rui Wang wrote:
> From b37d806c78e5eea70dbb890c1e3dbb8b7e5038e6 Mon Sep 17 00:00:00 2001
> From: Rui Wang <rui.y.wang@intel.com>
> Date: Sat, 10 Sep 2016 10:56:34 -0400
> Subject: [PATCH] x86/ioapic: Ignore root bridges without a companion ACPI device
> 
> Some PCI root bridges don't have a corresponding ACPI device.

Please say here that this is can be the case on some old platforms. Mine
is a couple of years old dell workstation box.

> Don't call acpi_ioapic_add() on these bridges because they can't
> support ioapic hotplug.

Right, exactly.

> Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> ---
>  drivers/pci/setup-bus.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ec538d3..2b05ac6 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1852,10 +1852,15 @@ dump:
>  void __init pci_assign_unassigned_resources(void)
>  {
>  	struct pci_bus *root_bus;
> +	acpi_handle root_handle;
>  
>  	list_for_each_entry(root_bus, &pci_root_buses, node) {
>  		pci_assign_unassigned_root_bus_resources(root_bus);
> -		acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
> +		root_handle = ACPI_HANDLE(root_bus->bridge);
> +
> +		/* make sure the root bridge has a companion ACPI device */
> +		if (root_handle)
> +			acpi_ioapic_add(root_handle);

Just do:

		if (ACPI_HANDLE(root_bus->bridge))
			acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));

no need for the local variable - gcc is smart enough to fetch it only
once :)

Anyway, I'll run it later to verify.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
