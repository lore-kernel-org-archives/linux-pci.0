Return-Path: <SRS0=KQx5=6G=intel.com=yu.c.chen@kernel.org>
Return-Path: <SRS0=KQx5=6G=intel.com=yu.c.chen@kernel.org>
Date: Mon, 3 Jul 2017 12:26:21 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	thejoe@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Work around poweroff & suspend-to-RAM issue on
 Macbook Pro 11
Message-ID: <20170703042621.GA22429@yu-desktop-1.sh.intel.com>
References: <20170702205948.GB18324@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170702205948.GB18324@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi,
On Sun, Jul 02, 2017 at 03:59:48PM -0500, Bjorn Helgaas wrote:
> Neither soft poweroff (transition to ACPI power state S5) nor
> suspend-to-RAM (transition to state S3) works on the Macbook Pro 11,4 and
> 11,5.
> 
> The problem is related to the [mem 0x7fa00000-0x7fbfffff] space.  When we
> use that space, e.g., by assigning it to the 00:1c.0 Root Port, the ACPI
> Power Management 1 Control Register (PM1_CNT) at [io 0x1804] doesn't work
> anymore.
> 
> Linux does a soft poweroff (transition to S5) by writing to PM1_CNT.  The
> theory about why this doesn't work is:
> 
>   - The write to PM1_CNT causes an SMI
>   - The BIOS SMI handler depends on something in
>     [mem 0x7fa00000-0x7fbfffff]
>   - When Linux assigns [mem 0x7fa00000-0x7fbfffff] to the 00:1c.0 Port, it
>     covers up whatever the SMI handler uses, so the SMI handler no longer
>     works correctly
> 
> Reserve the [mem 0x7fa00000-0x7fbfffff] space so we don't assign it to
> anything.
> 
> This is voodoo programming, since we don't know what the real conflict is,
> but we've failed to find the root cause.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103211
> Tested-by: thejoe@gmail.com
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: stable@vger.kernel.org
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Chen Yu <yu.c.chen@intel.com>
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 6d52b94f4bb9..20fa7c84109d 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -571,3 +571,35 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
> +
> +/*
> + * Apple MacBook Pro: Avoid [mem 0x7fa00000-0x7fbfffff]
> + *
> + * Using the [mem 0x7fa00000-0x7fbfffff] region, e.g., by assigning it to
> + * the 00:1c.0 Root Port, causes a conflict with [io 0x1804], which is used
> + * for soft poweroff and suspend-to-RAM.
> + *
> + * As far as we know, this is related to the address space, not to the Root
> + * Port itself.  Attaching the quirk to the Root Port is a convenience, but
> + * it could probably also be a standalone DMI quirk.
> + *
> + * https://bugzilla.kernel.org/show_bug.cgi?id=103211
> + */
> +static void quirk_apple_mbp_poweroff(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +
> +	if ((!dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,4") &&
> +	     !dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,5")) ||
> +	    pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(0x1c, 0))
> +		return;
> +
Not sure why we need to also the bus number of devfn, as there
is only one PCI bridge that would match 0x8c10? according to
https://bugzilla.kernel.org/attachment.cgi?id=210611
am I missing something?
thanks,
Yu
> +	res = request_mem_region(0x7fa00000, 0x200000,
> +				 "MacBook Pro poweroff workaround");
> +	if (res)
> +		dev_info(dev, "claimed %s %pR\n", res->name, res);
> +	else
> +		dev_info(dev, "can't work around MacBook Pro poweroff issue\n");
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
