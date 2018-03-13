Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 12 Mar 2018 19:18:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, charles.chenxin@huawei.com,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH] ARM64/PCI: Set dev->irq=0 before calling
 acpi_pci_irq_enable()
Message-ID: <20180313001830.GA60197@bhelgaas-glaptop.roam.corp.google.com>
References: <1520650692-62705-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520650692-62705-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-acpi]

On Sat, Mar 10, 2018 at 10:58:12AM +0800, Dongdong Liu wrote:
> The init value of dev->irq is from PCI_INTERRUPT_LINE register.The default
> value of dev->irq usually is 255 before calling acpi_pci_irq_enable().
> This will cause a problem When the platform does not support INTx well.
> For example, we do not config _PRT on our HIP07 platform, we met irq 255
> confilict.

s/confilict/conflict/

arm64 calls acpi_pci_irq_enable() in the probe() path instead of in
the pci_enable_device() path.  I can't remember the reason, and
unfortunately we didn't add a comment explaining why arm64 has to be
different.

PCI_INTERRUPT_LINE is used only by software and has no effect on the
hardware.  If it contains 255 when Linux boots, that means firmware
must have set it to that value.

We need some comment here about why we should always ignore what
firmware put there on arm64.  It needs to explain why this is
different on arm64 than it is on x86 and ia64.  The changelog above
basically says "we need this to make it work", but that's not very
informative or convincing.

It sounds like you're saying HIP07 doesn't provide _PRT?  Per the PCI
Firmware Spec, r3.0, sec 4.4, _PRT is required under all PCI host
bridges.  So I think you're saying HIP07 doesn't comply with the spec,
but the workaround here applies to *all* arm64 platforms.  That
doesn't seem right.

On x86, I think if the _PRT doesn't tell us where an interrupt pin is
routed, we fall back to looking at PCI_INTERRUPT_LINE.  But here
you seem to be saying "there's no _PRT" *and* "there's no useful
information in PCI_INTERRUPT_LINE".

Maybe I'm not understanding what you're saying.

> The error message is as below.
> snd_hda_intel 000d:33:00.1: PCI INT B: no GSI
> snd_hda_intel 000d:33:00.1: enabling device (0000 -> 0002)
> snd_hda_intel 000d:33:00.1: Force to snoop mode by module option
> snd_hda_intel 000d:33:00.1: Device has broken 64-bit MSI but arch tried to
> assign one above 4G
> genirq: Flags mismatch irq 255. 00000001 (enahisic2i0-tx1) vs. 00000081
> (snd_hda_intel:card0)
> hns-nic HISI00C2:00 enahisic2i0: request irq(255) fail
> 
> enahisic2i0-tx1: this device is a platform device.
> snd_hda_intel:card0: this device is a PCI device.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> ---
>  arch/arm64/kernel/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 0e2ea1c..6a77bef 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -28,8 +28,11 @@
>   */
>  int pcibios_alloc_irq(struct pci_dev *dev)
>  {
> -	if (!acpi_disabled)
> +	if (!acpi_disabled) {
> +		dev->irq = 0;
>  		acpi_pci_irq_enable(dev);
> +	}
> +
>  
>  	return 0;
>  }
> -- 
> 1.9.1
> 
