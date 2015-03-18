Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 18 Mar 2015 17:11:52 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Thomas Hellstrom <thellstrom@vmware.com>,
	"bp @ alien8 . de" <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	"yinghai @ kernel . org" <yinghai@kernel.org>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix] x86/PCI: Release PCI IRQ resource only if PCI device is
 disabled when unbinding
Message-ID: <20150318221152.GA2495@google.com>
References: <1426577832-23164-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426577832-23164-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 17, 2015 at 03:37:12PM +0800, Jiang Liu wrote:
> To support IOAPIC hot-removal, we need to release PCI interrupt resource
> when unbinding PCI device driver. But due to historical reason,
> /*
>  * We would love to complain here if pci_dev->is_enabled is set, that
>  * the driver should have called pci_disable_device(), but the
>  * unfortunate fact is there are too many odd BIOS and bridge setups
>  * that don't like drivers doing that all of the time.
>  * Oh well, we can dream of sane hardware when we sleep, no matter how
>  * horrible the crap we have to deal with is when we are awake...
>  */

Quoting the comment here (especially the last two lines) is overkill and
obscures the real point.  The important thing is that some drivers have
legitimate reasons for not calling pci_disable_device().

> some drivers don't call pci_disable_device() when unloading, which
> prevents us from reallocating PCI interrupt resource on reloading
> PCI driver and causes regressions.

This isn't very clear.  I can believe that "drivers not calling
pci_disable_device()" means we don't release IRQ resources, which might
prevent you from hot-removing an IOAPIC.

But "drivers not calling pci_disable_device()" doesn't cause regressions.

> So release PCI interrupt resource only if PCI device is disabled when
> unbinding. By this way, we could support IOAPIC hot-removal on latest
> platforms and avoid regressions on old platforms.

Does this mean you can only hot-remove IOAPICs if all drivers for devices
using the IOAPIC call pci_disable_device()?  If so, it seems sort of
dubious that we have to rely on drivers for that.

What happens if we try to hot-remove an IOAPIC where we haven't released
all the IRQ resources?  Is there a nice error message that will help us
debug problem reports?

This has nothing to do with "latest platforms" and "old platforms."  That
text pretends to convey information, but it doesn't.  To be useful, it
would have to say something specific about how "latest" and "old" platforms
are different.

I haven't even figured out what causes the regressions yet.  I guess maybe
it's the fact that after b4b55cda5874, we always call pcibios_disable_irq(),
while before we only called it if the driver used pci_disable_device()?
The changelog should be clear about this.

> Please aslo refer to:

"also"

> https://bugzilla.kernel.org/show_bug.cgi?id=94721
> 

This apparently fixes something and needs a Fixes: tag to help people who
might backport the broken commit.

> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
> Hi Rafael,
> 	I have assumed an Reviewed-by from you, is that OK?
> Thanks!
> Gerry
> ---
>  arch/x86/pci/common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 3d2612b68694..8d792142cb2a 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -527,7 +527,7 @@ static int pci_irq_notifier(struct notifier_block *nb, unsigned long action,

I know the notifier was added by b4b55cda5874, not this patch, but I don't
think it's the best mechanism.  I would rather do something like calling
pcibios_disable_irq() directly from pci_device_remove().  That way the call
is more explicit, it's in arch-independent code, and it's more parallel
with how we call pcibios_enable_irq() in the pci_enable_device() path.

This code is all x86-specific.  But other arches use IOAPIC, and there's
nothing obviously x86-specific here.  Won't they still have issues here?

>  	if (action != BUS_NOTIFY_UNBOUND_DRIVER)
>  		return NOTIFY_DONE;
>  
> -	if (pcibios_disable_irq)
> +	if (!pci_is_enabled(dev) && pcibios_disable_irq)
>  		pcibios_disable_irq(dev);
>  
>  	return NOTIFY_OK;
> -- 
> 1.7.10.4
> 
